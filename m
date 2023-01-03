Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153ED65BAA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjACGaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjACGa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:30:28 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA49ACE37
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:30:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c9so15000176pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 22:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IH4BnFmj51xja43rQ2VjV2A7Vl5bq18SZUAgL2EcwnI=;
        b=TG8uvyWlWw/f/acMw9cbu5au61WMfhj8SQ7FwLvxR65sqsYZBrZeJ84HJaB1uTlkJL
         NjKW3hoU0GcIiCuaxhYad+YSh6y8IxPDZsTYtz7rjBw5PGyuCpsS6al8/MpbgN0ZcJLJ
         f88f2MFNLsumloslDC9abPso5qnjumuUgJm8gVlEsK/WS9uv28IZhOLXdwC54bcSLGsx
         PqxZZ1FK2Lacldkq5OtLbraJqwV9ht6pZiE6vLz7JKYvU0RMFEvhq/nSEVE+5hmPHNvl
         874ZBFtjftFatmgPEAof5bKW7H8DotegkmfFt/Hnwa6ydCivHzy46tLoyJTNJaFjfLWZ
         zGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH4BnFmj51xja43rQ2VjV2A7Vl5bq18SZUAgL2EcwnI=;
        b=pfq7ejh6rLiBjC8zByKiV43lbphcbMwUYfkX4q4UO/f8hrpL24NFCXMvZekV7yFLta
         J8QtXm2yX5Zx6NbifZU2aoSxkUXEtAG5JhVeQlnUuJOS6uQy4TdfLtonc1ZuVr5Gtw7w
         SQKsphsUu6BO9Eci0la0OweYZhtmH472AsOGQe2XWsBxIRORhzN+cB7ZMxupXhHBErtt
         J+RpVAeedzAa/qsIxoCL8XsZZyjprlMXHc03GjlylJ4EwWkCpoiIsVKEI2OPkmq0G3R3
         Ttb04Lt5FWolJoeWg3E7h6IzMDUcwy09TktQonZ7oTTed5/l1FIN8/xcuMbDrFDcXk6r
         j0cQ==
X-Gm-Message-State: AFqh2kqYtVECpsgjM+s2l512BBqA/sZK9DkLYVfwQ8iano4HjKxsoxG7
        78NiNGKI7mj0dD8y98IYHwQ=
X-Google-Smtp-Source: AMrXdXuB8TRSOt5N1YqvE+OSqTWyWFvhKTUMq1KEyXVklZBiK31z6i7whkRLrLYws9KRNGMhpo6u6Q==
X-Received: by 2002:a05:6a00:88a:b0:581:19ed:78b9 with SMTP id q10-20020a056a00088a00b0058119ed78b9mr38707011pfj.2.1672727427390;
        Mon, 02 Jan 2023 22:30:27 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i127-20020a626d85000000b00581a156b920sm10418848pfc.132.2023.01.02.22.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 22:30:26 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] iommu: Fix refcount leak in iommu_device_claim_dma_owner
Date:   Tue,  3 Jan 2023 10:30:17 +0400
Message-Id: <20230103063017.4022393-1-linmq006@gmail.com>
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
Also an empty @owner is a more serious problem than refcount leak.
Move iommu_group_get() after owner check to fix the refcount leak.

Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- Remove set NULL to group as suggested by Baolu Lu.
- Update commit message according to Lu's explanation.
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..5f6a85aea501 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3185,14 +3185,16 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
  */
 int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	struct iommu_group *group;
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

