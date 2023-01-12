Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98E667222
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjALM0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjALM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:26:17 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B55496F4;
        Thu, 12 Jan 2023 04:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673526362; bh=OsbxLgpenh3EmaJqVO2D5pKj+O3xzETqZGytw+PMepM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=gCQq8YfKeCDxCd8mHHPKSlFxYxq2Vx/KJ6RyfcCAS6ZOliJS9/LIZwxEsZr9I69F1
         E9oG9SDnP62gqwcL6yb+c7ubjDXxV/0RvQCtRwhCb9jbx8av9Q2GLX0R9ROk2+2tEu
         Zj0ZpBspBPc3zDmQO4CQY8ygZkscRaY414GNIkBQ=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 12 Jan 2023 13:26:02 +0100 (CET)
X-EA-Auth: zKf4La/UoBbkbkJBV4yz8GHr94GydOUPwZmccHa9aCZx+8idzk8fE2Xao4lY0aXrBYf5G3IZ40c4vyYqRf1miESw+BK/stO1
Date:   Thu, 12 Jan 2023 17:55:57 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] scsi: csiostor: use *ptr instead of ptr with sizeof
Message-ID: <Y7/8VUXJSFXTpYlz@ubun2204.myguest.virtualbox.org>
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

The function csio_enqueue_evt() should be passed the actual length of
the event/message so that it can be fully copied over to the event
queue. Use the sizeof(*ptr) to get the real message length instead of
sizeof(ptr).
Issue identified using the noderef,cocci coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The change is compile tested only.

 drivers/scsi/csiostor/csio_mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_mb.c b/drivers/scsi/csiostor/csio_mb.c
index 94810b19e747..4df8a4df4408 100644
--- a/drivers/scsi/csiostor/csio_mb.c
+++ b/drivers/scsi/csiostor/csio_mb.c
@@ -1551,7 +1551,7 @@ csio_mb_isr_handler(struct csio_hw *hw)
 		 * Enqueue event to EventQ. Events processing happens
 		 * in Event worker thread context
 		 */
-		if (csio_enqueue_evt(hw, CSIO_EVT_MBX, mbp, sizeof(mbp)))
+		if (csio_enqueue_evt(hw, CSIO_EVT_MBX, mbp, sizeof(*mbp)))
 			CSIO_INC_STATS(hw, n_evt_drop);
 
 		return 0;
-- 
2.34.1



