Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37667F5D5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjA1H7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjA1H7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:59:08 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1824616D;
        Fri, 27 Jan 2023 23:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674892733; bh=qMf+Xfzo+BufqPQ/JYYC7vZ8jwBEi6vlqKAvmk8x3H4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=J6mT4L4ZQxGRbqR2dJy2cRxz+ACZgwokL5It6x0711QYr9Z39yyaEyLLK9dCssfmC
         zFoB7QcWXieSioe6yKEH4+AktJidBhk7sZxxQaKpJVODvhNMF5sy69KDcsp61LlrBE
         WAtzF2nT9HE1Jf6c8wmK3vLpOoS8B0aUty0i6Zgg=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 28 Jan 2023 08:58:53 +0100 (CET)
X-EA-Auth: AbVnrGizcFtzXuYqAw3Q9ExojJUsxcVdLH/fMIOfZgK/DtWWIjme5wpWUyT/MEz5Bt3cMParN9MS8TEqjwiWKARGs9R3Nu+I
Date:   Sat, 28 Jan 2023 13:28:48 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: st: Use min/max helpers for comparison and assignment
Message-ID: <Y9TVuM1az7ajhTlS@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by using min_t helper macro for logical evaluation
and value assignment. Use the _t variant of min macro since the
variable types are not same.
This issue is identified by coccicheck using the minmax.cocci file.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: Proposed change is only compile/build tested.

 drivers/scsi/st.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index b90a440e135d..38aa59cba110 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -1574,8 +1574,7 @@ static int setup_buffering(struct scsi_tape *STp, const char __user *buf,
 
 	if (!STbp->do_dio) {
 		if (STp->block_size)
-			bufsize = STp->block_size > st_fixed_buffer_size ?
-				STp->block_size : st_fixed_buffer_size;
+			bufsize = max(STp->block_size, st_fixed_buffer_size);
 		else {
 			bufsize = count;
 			/* Make sure that data from previous user is not leaked even if
@@ -2186,8 +2185,7 @@ st_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 					  STps->eof, STbp->buffer_bytes,
 					  (int)(count - total));
 			) /* end DEB */
-			transfer = STbp->buffer_bytes < count - total ?
-			    STbp->buffer_bytes : count - total;
+			transfer = min_t(size_t, STbp->buffer_bytes, (count - total));
 			if (!do_dio) {
 				i = from_buffer(STbp, buf, transfer);
 				if (i) {
@@ -3996,7 +3994,7 @@ static int append_to_buffer(const char __user *ubp, struct st_buffer * st_bp, in
 	}
 	for (; i < st_bp->frp_segs && do_count > 0; i++) {
 		struct page *page = st_bp->reserved_pages[i];
-		cnt = length - offset < do_count ? length - offset : do_count;
+		cnt = min((length - offset), do_count);
 		res = copy_from_user(page_address(page) + offset, ubp, cnt);
 		if (res)
 			return (-EFAULT);
@@ -4028,7 +4026,7 @@ static int from_buffer(struct st_buffer * st_bp, char __user *ubp, int do_count)
 	}
 	for (; i < st_bp->frp_segs && do_count > 0; i++) {
 		struct page *page = st_bp->reserved_pages[i];
-		cnt = length - offset < do_count ? length - offset : do_count;
+		cnt = min((length - offset), do_count);
 		res = copy_to_user(ubp, page_address(page) + offset, cnt);
 		if (res)
 			return (-EFAULT);
-- 
2.34.1



