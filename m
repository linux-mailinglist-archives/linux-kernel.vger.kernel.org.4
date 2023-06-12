Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F336172B555
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjFLCSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLCSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:18:20 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB81C3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 19:18:17 -0700 (PDT)
X-UUID: 625a568d3da64d2aa78ff3d2e669f391-20230612
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8dbb7674-442a-4ae3-b328-85febe458103,IP:5,U
        RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-35
X-CID-INFO: VERSION:1.1.22,REQID:8dbb7674-442a-4ae3-b328-85febe458103,IP:5,URL
        :0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
        ON:release,TS:-35
X-CID-META: VersionHash:120426c,CLOUDID:6d5a183e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230612101800XIEZGSAS,BulkQuantity:0,Recheck:0,SF:17|19|44|38|24|102,
        TC:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 625a568d3da64d2aa78ff3d2e669f391-20230612
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1936308362; Mon, 12 Jun 2023 10:17:55 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com
Cc:     kevin.tian@intel.com, jgg@ziepe.ca, vasant.hegde@amd.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        gehao618@163.com, Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] iommu/amd: Fix memory leak when domain type checks fail
Date:   Mon, 12 Jun 2023 10:17:18 +0800
Message-Id: <20230612021718.82293-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When domain type checks fail,we also should free protection_domain struct
to avoid memory leak in protection_domain_alloc

Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc1ec6849775..f08e65629c74 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2094,7 +2094,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
 		pgtable = amd_iommu_pgtable;
 	} else {
-		return NULL;
+		goto out_err;
 	}
 
 	switch (pgtable) {
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
