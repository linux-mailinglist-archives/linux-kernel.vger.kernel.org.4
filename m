Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D56294E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKOJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiKOJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:54:43 -0500
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 01:54:41 PST
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802A38B4;
        Tue, 15 Nov 2022 01:54:41 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668505589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NmmBGedzdtOQXgj14ZUnuEyKYV0y5hMfZTUePWXPEbw=;
        b=sCnrEURWR+mhGX/LBvib/yhHGHOmE4zVV2U/doO+IVBvQrtJncWxwXNCNNUrjtYNonMigQ
        25UDg0jFSQy9FsokzFGug5hM05TlaLVgsvDQYVRVG03WeY4Ndn0Fpge0LBBHdNmuJR+UG6
        IFkTwM3LAyK+D16v+pATt5G3w6PlBak=
To:     Karen Xie <kxie@chelsio.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] cxgb4i : Added pointer check
Date:   Tue, 15 Nov 2022 12:46:29 +0300
Message-Id: <20221115094629.73591-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value of a function 'alloc_wr' is dereferenced at cxgb4i.c:624
without checking for null, but it is usually checked for this function

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 2c3491528d42..40ed8e27945c 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -611,7 +611,7 @@ static inline int tx_flowc_wr_credits(int *nparamsp, int *flowclenp)
 
 static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
 {
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	struct fw_flowc_wr *flowc;
 	int nparams, flowclen16, flowclen;
 
@@ -620,6 +620,8 @@ static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
 #endif
 	flowclen16 = tx_flowc_wr_credits(&nparams, &flowclen);
 	skb = alloc_wr(flowclen, 0, GFP_ATOMIC);
+	if (!skb)
+	 return -ENOMEM;
 	flowc = (struct fw_flowc_wr *)skb->head;
 	flowc->op_to_nparams =
 		htonl(FW_WR_OP_V(FW_FLOWC_WR) | FW_FLOWC_WR_NPARAMS_V(nparams));
-- 
2.25.1

