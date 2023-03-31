Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9C6D1604
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCaDcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCaDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:31:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF618F80
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:31:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso24118973pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680233515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3buwZbi8UwI0JR//L3crQYz+6oBSYG/M98AK9MATFQ=;
        b=fuXLi9xSbUbEqkJl8uhdtJ/06Tw8zfHYGi67/DwMDHhe9fm0v2lm456H2gONn3NQUf
         noUEGMu+esSuCuuBBZ2RPOSk8SaM3R23iA8p9ufRQatKbY1MNQPD0c9hVGonNQZepGSE
         Ghmh9pxzTdl/m+bVPbVyCidDReb56ZQaxuZAYkNkYG2gT5QYGCsp3LbMVjgnoXEGh3+A
         321W0QSzv/7KMFCJr7AFZdmJ0Teu3cSXPD9WGjAY44zJGh/ANQr3KI6hryKaB0e8z1kJ
         j0oyDP1TlfXnvSMjFr69dOF1pQ8ncx377nWzpC1BW940nw2SNwGWsu0gl+Bj3mNlGDCK
         aRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680233515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3buwZbi8UwI0JR//L3crQYz+6oBSYG/M98AK9MATFQ=;
        b=RI04nYJJl5TjR+feMlI5EKK9X2nTV3A2MgnGP2qgZezVJtH5kDxd2CcZJxdASBFKgh
         APVrcnwMXKWW2wyfrQIgCrK58vtu+t7YX0qtJ0jsPRe+OpI3Ty0xGXqB2JmygRKgqnfz
         4rp2N7lWkrOwa9hxabcmv4JjKyuLKCiVsOQuuC3TCdpvsU8ocC4Stos6nTHwDgCDPWup
         z4TfX2Ga7polvAkciJrZGIQPNVu6kFFqIJwYKZ7U7AG1+g9Snxvkaawwenebm3d96dNZ
         nK2duAd5L0wSGUDBWZLyVWLVvh432uQiDO/qaWWsP+0VozTtnnN7o4axxZJzIvR9q452
         5KJg==
X-Gm-Message-State: AAQBX9foBfa97yqiV2lkK6VKBleWRPXFFhyztl/t15sx5oYNEDkLhAf1
        P2gX4TUeATC3bhgrcVbrQHM=
X-Google-Smtp-Source: AKy350YtID6gCA0syz1/NyDJ5v5uxsRZsPlZpvjDe6NNnTvhOlKsawpswgbD23v1bJCkAC6ufr4oXw==
X-Received: by 2002:a17:90a:db97:b0:236:6a28:f784 with SMTP id h23-20020a17090adb9700b002366a28f784mr28430263pjv.3.1680233514896;
        Thu, 30 Mar 2023 20:31:54 -0700 (PDT)
Received: from ubt.spreadtrum.com ([138.113.14.245])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001a239325f1csm449128pld.100.2023.03.30.20.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:31:54 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V3 1/2] iommu: sprd: release dma buffer to avoid memory leak
Date:   Fri, 31 Mar 2023 11:31:23 +0800
Message-Id: <20230331033124.864691-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331033124.864691-1-zhang.lyra@gmail.com>
References: <20230331033124.864691-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

When attaching to a domain, the driver would alloc a DMA buffer which
is used to store address mapping table, and it need to be released
when the IOMMU domain is freed.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/sprd-iommu.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ae94d74b73f4..7df1f730c778 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -151,13 +151,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 	return &dom->domain;
 }
 
-static void sprd_iommu_domain_free(struct iommu_domain *domain)
-{
-	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
-
-	kfree(dom);
-}
-
 static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
 {
 	struct sprd_iommu_device *sdev = dom->sdev;
@@ -230,6 +223,28 @@ static void sprd_iommu_hw_en(struct sprd_iommu_device *sdev, bool en)
 	sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
 }
 
+static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
+{
+	size_t pgt_size;
+
+	/* Nothing need to do if the domain hasn't been attached */
+	if (!dom->sdev)
+		return;
+
+	pgt_size = sprd_iommu_pgt_size(&dom->domain);
+	dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
+	dom->sdev = NULL;
+	sprd_iommu_hw_en(dom->sdev, false);
+}
+
+static void sprd_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+
+	sprd_iommu_cleanup(dom);
+	kfree(dom);
+}
+
 static int sprd_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-- 
2.25.1

