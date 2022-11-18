Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2CF62F2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbiKRKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKRKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:42:55 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757DF97083
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:42:54 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668768172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zhq3ZPbOW/IjySbkqalqQrSgHm9uIPo6a/xa8S5bNyE=;
        b=Ht2++LndUjVOqrAQD0+1tnKkVc0lpX3HoTEFa58uWLO+SaR/r7amjxj5fYlev1agdSx5LN
        RwfAjrXH7aOkiRE3FHSxFwxWW/tnzL/GYYZbFyI4aqhhEY4B5R2vy+0fjc4p4kxMEwHTi1
        zJUmdMN7WjkNR5fza5+eRJ+gB44Kny0=
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] iommu: amd: Added value check
Date:   Fri, 18 Nov 2022 13:42:52 +0300
Message-Id: <20221118104252.122809-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Аdded a return value check for the function
mmu_notifier_register.

Return value of a function 'mmu_notifier_register'
called at iommu_v2.c:642 is not checked,
 but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/iommu/amd/iommu_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 5ecc0bc608ec..88134f34589f 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -639,7 +639,9 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (pasid_state->mm == NULL)
 		goto out_free;
 
-	mmu_notifier_register(&pasid_state->mn, mm);
+	ret = mmu_notifier_register(&pasid_state->mn, mm);
+	if (ret)
+		goto out_free;
 
 	ret = set_pasid_state(dev_state, pasid_state, pasid);
 	if (ret)
-- 
2.25.1

