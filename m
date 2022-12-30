Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FB659656
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiL3Ibg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiL3Ibd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:31:33 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF52F4B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:31:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 18so1894997pfx.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPSc5CLczFof6Az09YQrNvJzlEU7+w21O5dXtl4mqyk=;
        b=lMGhHsMvJXqUL1WfSWtNrtoqQ6vbQ8zSMbNi4ZfLr6yGd+iI9hh2xm4OY8u6H0Go1a
         CRiG/cfzwsPXQBIKH0SNonLyEto/TmbUZtxEFKTtqIYL66ODBGy0t4WXObCEICe3kDGR
         8YRC4yRX/fhYyCflh9NNuUvujL/14pnsIISl0GQerrQRob8bRGlyVcutFiYh9C8KUjdL
         VbiLNF1sse3ZJoGI/Wvw+ZNu4HUap0FfEfHaBX1uNsAkyuEZSVgQ80sj1Q3YLo7rgnLo
         xZ2pxM4v2cGvbNPgTPF/11XWj/vW70W8z/kP3EnBjVJB+hw4e4VGS+OM3TbIkUvvuOIF
         EvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPSc5CLczFof6Az09YQrNvJzlEU7+w21O5dXtl4mqyk=;
        b=deP1tfBWXKjTe5XEeHZjQYbtEyC+Fa4Z35egUHtBcLydi7hvR24vnRfF91XdPgI5E/
         k7cOc88J/KQw68ZRQNlfQeGvW5QWfb5aHj0x+c99ICaaNGAZAMJYuFhOgypqmGpstZ9D
         b7OaYEm8637Qknwe05Wfp9clU9uMzSeIo4PkkHyQe38XDzJZhNnkEHf325sFHvabpWeJ
         eEWuCoWiypwMg7GmJFVRz6YYsG1kgzufGhk9PtblRYYjyhgwUVZKLym2afWsDDVnbSt8
         cMZ9ZkpsHIqjjGq33nC3zoH4ECHbC4XuC3TVeMTt06VxkJqdVQcOC5cpDSImbh1DI4+j
         EocA==
X-Gm-Message-State: AFqh2kplSRi1lhcArbFSAunysYbS73qkiBxz46+DdCLDJ8I+K4g8HCqG
        ZPiVTKcsJEFQ77OH3rowFc0=
X-Google-Smtp-Source: AMrXdXtJsKuFq/yA8finz6BSFXjWdGZhmxoS70wa6aAQdiMsdDW7v9DTz++wMC4LjcQsJ/9B8bgXLg==
X-Received: by 2002:a62:404:0:b0:581:91d1:3cc4 with SMTP id 4-20020a620404000000b0058191d13cc4mr8260380pfe.7.1672389091733;
        Fri, 30 Dec 2022 00:31:31 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm10182227pfz.157.2022.12.30.00.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 00:31:31 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] iommu: Fix refcount leak in iommu_device_claim_dma_owner
Date:   Fri, 30 Dec 2022 12:31:00 +0400
Message-Id: <20221230083100.1489569-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_group_get() returns the group with the reference incremented.
Move iommu_group_get() after owner check to fix the refcount leak.

Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..3a7dd8b61fab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3185,14 +3185,16 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
  */
 int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	struct iommu_group *group = NULL;
 	int ret = 0;
 
-	if (!group)
-		return -ENODEV;
 	if (WARN_ON(!owner))
 		return -EINVAL;
 
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
 		if (group->owner != owner) {
-- 
2.25.1

