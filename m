Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862A762F46D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiKRMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiKRMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:17:50 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485DC97371;
        Fri, 18 Nov 2022 04:17:43 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668773861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ac6hqu8MRPhDQ5SpxuNlbB+ZBkfygCfSzR81j36kZp0=;
        b=hfsh3qVWGl23RR5TGxSoDvRbF+Yh+gHCOdhWAsTYzwXm4CF6cYOrqEKpnXhXptIA7/7IsY
        4yxctKsaBRccVHrdiC5VlzFlncqcBJnXi3675V5gjlwIQ0XGMlvxni4o2hbvQ5FcEAeYad
        1ldpL0YAOyHm5KG9S+WDkZdjlV2QlJQ=
To:     Karen Xie <kxie@chelsio.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH v2] cxgbi: cxgb4i: Added pointer check
Date:   Fri, 18 Nov 2022 15:17:40 +0300
Message-Id: <20221118121740.128877-1-arefev@swemel.ru>
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

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 2c3491528d42..b93bd36dcb2d 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -620,6 +620,8 @@ static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
 #endif
 	flowclen16 = tx_flowc_wr_credits(&nparams, &flowclen);
 	skb = alloc_wr(flowclen, 0, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
 	flowc = (struct fw_flowc_wr *)skb->head;
 	flowc->op_to_nparams =
 		htonl(FW_WR_OP_V(FW_FLOWC_WR) | FW_FLOWC_WR_NPARAMS_V(nparams));
-- 
2.25.1

