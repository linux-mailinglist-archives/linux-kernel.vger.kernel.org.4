Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDEF6B4758
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjCJOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjCJOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:48:39 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3DE1223A3;
        Fri, 10 Mar 2023 06:47:40 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso3053402ota.1;
        Fri, 10 Mar 2023 06:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0H5Wu4JK6lQArjMSAowLoAG+26f+c1LrnbxEzmAS4U=;
        b=svkfSYyk/0FO4ObyJ5l2snPPQbxiDwyqbb4kN0P/EN97mWcvqAZl3y+Wxind441S46
         P8dv+o2kcvWPUK9RU/6fe1svX6JICaqzHJ4Ats4k8Ft1cj2URC7jDfqxxaDZdfL6ToZw
         wCNrO+xK8FVBVJ+1s2G/1x6qlIJ0PBMuYup0m6dUcSAnFjrA/C8CzA9lGapJkLxwPMqo
         43cC5lDWe0SYIDRHibwdIOGNC8CE/1ayzOjPvRs9qKynzAgd+1clWPfodIK21c9zhjNI
         R5I6NtEEBX3SCcb0rmSgiyckOcM3d2Ah+rZ7WzbhkMyORsQqKEIb5wcviGAU0KpF+S1k
         BMvg==
X-Gm-Message-State: AO0yUKWdE5yTevJVY/YjkBtwf9KxDD3aLDS/+oUbA7taMzGF5eraR4bF
        drAJFE+XlP8JMBf0hZZsVw==
X-Google-Smtp-Source: AK7set+1v0Oy317O/GgYXBQ/6eEBO/u3ew/d9R+Nk1dh3yQXWhHfEHApW3jqyFaoPyN4Vuj/ZB6org==
X-Received: by 2002:a05:6830:807:b0:694:39e5:fdc8 with SMTP id r7-20020a056830080700b0069439e5fdc8mr12074773ots.32.1678459659397;
        Fri, 10 Mar 2023 06:47:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a26-20020a9d725a000000b00684c5211c58sm107392otk.60.2023.03.10.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:38 -0800 (PST)
Received: (nullmailer pid 1542936 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:09 -0600
Message-Id: <20230310144709.1542910-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 drivers/iommu/ipmmu-vmsa.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ff7a72cf377..d0843caf8760 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -139,7 +139,7 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	int err;
 
 	np = dev_get_dev_node(dev);
-	if (!np || !of_find_property(np, "#stream-id-cells", NULL)) {
+	if (!np || !of_property_present(np, "#stream-id-cells")) {
 		of_node_put(np);
 		return -ENODEV;
 	}
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..f4470303d906 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1014,7 +1014,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	 * the lack of has_cache_leaf_nodes flag or renesas,ipmmu-main property.
 	 */
 	if (!mmu->features->has_cache_leaf_nodes ||
-	    !of_find_property(pdev->dev.of_node, "renesas,ipmmu-main", NULL))
+	    !of_property_present(pdev->dev.of_node, "renesas,ipmmu-main"))
 		mmu->root = mmu;
 	else
 		mmu->root = ipmmu_find_root();
-- 
2.39.2

