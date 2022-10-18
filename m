Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F96029AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJRKv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJRKvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:51:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D050688AC;
        Tue, 18 Oct 2022 03:51:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so31227252ejn.3;
        Tue, 18 Oct 2022 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8s/NenqR0ahFt82BntWKaJG1O8nHl/K2hei9L3ruCZ8=;
        b=KGAw/QW0PiTZ9+Ardgq7VdZhJxcUoB7pyfxIUirEukeTz4vqWLS6WoOuIxHLfsQw7F
         +JR9LpunPF8g6P8uiWo65OH3j695YMWeG6Ax9w83fVCVOSqK2dl8+hdyHL5uvn+n8384
         qU5sJ+PvjmOLN7pgPqG6gHyT15bDniMt8fyUz4NPtQdPkGC6I0C45zIINxrR7c6ghK+S
         kWW075BUXclIIlpsq1qgAfHI9Ty72JnOoOhgefYro0GI78I2+wHrAwSng/AUqRmWLp34
         EwfTfKxG1ZA4pYdECeH267F2FoiyTw7POhy0x027w8wWYbsVoaZ+lMLKBhmbqsWByVV6
         ZeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s/NenqR0ahFt82BntWKaJG1O8nHl/K2hei9L3ruCZ8=;
        b=4MaCjCq0yUnxTb0yQiVTj3UvHcSLGQ1U3k9E8TFoGCtnbho1g2HP6R60/L5OoehiCf
         tkzNYlVgHOEFhGQITI5YV+L1STkg5oF7BcCZFeVUesfvlz7bFDmHXU1coV93W5zvWgz2
         PgctVXQcYTQnhDdHKtJ7TaSCio71HV4tdGQYXT13SvE9ouNiLbyP3oEmtD0BAISlwR0+
         WxCP/HkgJicES+x342MvyQkHBMLlL4sUj6AQ6fia1ttolcmrb9s1LQ+q8M4TjhpI9QjK
         JEiIM6yh9pPOHYxevymSnW2QcNOrMF4CDmDFeizhOqZc11C09Ds6YTUBGyRJdQqQ1p98
         rm6g==
X-Gm-Message-State: ACrzQf2XGV3PItq4XX/+r/RG382bD7wjbdS/zfvyGA7+N9JnDgGsFdwS
        /t+xxJCl/qE/9xsB/vqT7qXHPfoMLlc=
X-Google-Smtp-Source: AMsMyM7NYsVfYI5dAQa0D48MTMmaoDeXayNele7ewEzKiTK8cWeiczz9UX17n1oLButztQG5ptcs5Q==
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id ww7-20020a170907084700b0077ff489cc25mr1873073ejb.80.1666090311689;
        Tue, 18 Oct 2022 03:51:51 -0700 (PDT)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906314e00b0073d84a321c8sm7459550eje.166.2022.10.18.03.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:51:50 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Always define struct iommu_fwspec
Date:   Tue, 18 Oct 2022 12:51:49 +0200
Message-Id: <20221018105149.820062-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

In order to fully make use of the !IOMMU_API stub functions, make the
struct iommu_fwspec always available so that users of the stubs can keep
using the structure's internals without causing compile failures.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi Joerg,

this is a rebased patch extracted from an ancient series that never
ended up getting applied:

	https://lore.kernel.org/all/20191209120005.2254786-3-thierry.reding@gmail.com/

You had already acked this particular patch, so maybe you can pick this
up. I've seen at least two discussions where this was brought up again,
so I figured it'd be worth sending this out again because it can help
remove a number of #ifdef blocks throughout the kernel.

 include/linux/iommu.h | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a325532aeab5..e3295c45d18f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -173,6 +173,25 @@ enum iommu_dev_features {
 
 #define IOMMU_PASID_INVALID	(-1U)
 
+/**
+ * struct iommu_fwspec - per-device IOMMU instance data
+ * @ops: ops for this device's IOMMU
+ * @iommu_fwnode: firmware handle for this device's IOMMU
+ * @flags: IOMMU_FWSPEC_* flags
+ * @num_ids: number of associated device IDs
+ * @ids: IDs which this device may present to the IOMMU
+ */
+struct iommu_fwspec {
+	const struct iommu_ops	*ops;
+	struct fwnode_handle	*iommu_fwnode;
+	u32			flags;
+	unsigned int		num_ids;
+	u32			ids[];
+};
+
+/* ATS is supported */
+#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -598,25 +617,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
 /* FSL-MC device grouping function */
 struct iommu_group *fsl_mc_device_group(struct device *dev);
 
-/**
- * struct iommu_fwspec - per-device IOMMU instance data
- * @ops: ops for this device's IOMMU
- * @iommu_fwnode: firmware handle for this device's IOMMU
- * @flags: IOMMU_FWSPEC_* flags
- * @num_ids: number of associated device IDs
- * @ids: IDs which this device may present to the IOMMU
- */
-struct iommu_fwspec {
-	const struct iommu_ops	*ops;
-	struct fwnode_handle	*iommu_fwnode;
-	u32			flags;
-	unsigned int		num_ids;
-	u32			ids[];
-};
-
-/* ATS is supported */
-#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
-
 /**
  * struct iommu_sva - handle to a device-mm bond
  */
@@ -680,7 +680,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
 struct iommu_ops {};
 struct iommu_group {};
-struct iommu_fwspec {};
 struct iommu_device {};
 struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
-- 
2.37.3

