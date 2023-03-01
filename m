Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B916A74C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCAUFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCAUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:04:54 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6214ECE8;
        Wed,  1 Mar 2023 12:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677701077; bh=SkxO6ocDDrslWnzemAIXgnlRsRGtgWAqK1nWvppSEB8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=QHsEMb/KrTcnyTB6UNjavqfGLt1j2d1fL0ym1Suwoa53CBCVnZBY7kmt9j2zCznL2
         MdC56njcZuDWLnsStfHtIq+p+T7WUQ/oQZdeKXTtmPAwOuEvBlVzLLN6+TJ9I8/8rP
         uIgt49qQJagPTxKgdGptMigRKmTN+arINl4m4Oew=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  1 Mar 2023 21:04:37 +0100 (CET)
X-EA-Auth: DU2ysQMmY52E4ROFbJqtsDKo9YDpEmEu2WCkbqP9Vr5J2zznwaEaDw2Lq5mgK05twi4f9pSDcMAkBxxx3hn6q8WLeFXa0tjo
Date:   Thu, 2 Mar 2023 01:34:33 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH RESEND] scsi: fnic: Use a variable for repeated mem_size
 computation
Message-ID: <Y/+v0QNRgsr18rwg@ubun2204.myguest.virtualbox.org>
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

Use a variable to upfront compute memory size to be allocated,
instead of repeatedly computing it at different instructions.
The reduced instruction length also allows to tidy up the code.
Issue identified using the array_size_dup Coccinelle semantic
patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note:
   Proposed change compile tested only.
   Resending patch for review and feedback. No functional changes.


 drivers/scsi/fnic/fnic_trace.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index e03967463561..7b8ef74fc060 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -544,12 +544,10 @@ int fnic_fc_trace_init(void)
 	unsigned long fc_trace_buf_head;
 	int err = 0;
 	int i;
+	size_t mem_sz = array_size(PAGE_SIZE, fnic_fc_trace_max_pages);
 
-	fc_trace_max_entries = (fnic_fc_trace_max_pages * PAGE_SIZE)/
-				FC_TRC_SIZE_BYTES;
-	fnic_fc_ctlr_trace_buf_p =
-		(unsigned long)vmalloc(array_size(PAGE_SIZE,
-						  fnic_fc_trace_max_pages));
+	fc_trace_max_entries = mem_sz / FC_TRC_SIZE_BYTES;
+	fnic_fc_ctlr_trace_buf_p = (unsigned long)vmalloc(mem_sz);
 	if (!fnic_fc_ctlr_trace_buf_p) {
 		pr_err("fnic: Failed to allocate memory for "
 		       "FC Control Trace Buf\n");
@@ -557,13 +555,11 @@ int fnic_fc_trace_init(void)
 		goto err_fnic_fc_ctlr_trace_buf_init;
 	}
 
-	memset((void *)fnic_fc_ctlr_trace_buf_p, 0,
-			fnic_fc_trace_max_pages * PAGE_SIZE);
+	memset((void *)fnic_fc_ctlr_trace_buf_p, 0, mem_sz);
 
 	/* Allocate memory for page offset */
-	fc_trace_entries.page_offset =
-		vmalloc(array_size(fc_trace_max_entries,
-				   sizeof(unsigned long)));
+	mem_sz = array_size(fc_trace_max_entries, sizeof(unsigned long));
+	fc_trace_entries.page_offset = vmalloc(mem_sz);
 	if (!fc_trace_entries.page_offset) {
 		pr_err("fnic:Failed to allocate memory for page_offset\n");
 		if (fnic_fc_ctlr_trace_buf_p) {
@@ -574,8 +570,7 @@ int fnic_fc_trace_init(void)
 		err = -ENOMEM;
 		goto err_fnic_fc_ctlr_trace_buf_init;
 	}
-	memset((void *)fc_trace_entries.page_offset, 0,
-	       (fc_trace_max_entries * sizeof(unsigned long)));
+	memset((void *)fc_trace_entries.page_offset, 0, mem_sz);
 
 	fc_trace_entries.rd_idx = fc_trace_entries.wr_idx = 0;
 	fc_trace_buf_head = fnic_fc_ctlr_trace_buf_p;
-- 
2.34.1



