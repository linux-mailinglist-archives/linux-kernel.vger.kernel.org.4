Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D46D1605
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCaDcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCaDcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:32:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC37CA19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:31:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o2so20046945plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680233517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+9ZPtRrjL6zYn8USHZp7DIBp0J7SJ4SjTl0hBaFZwU=;
        b=DCa6KQxGG6AzMQVouFVFhw+hOgFCcmaF1zjXTSBVZFn3cRWwVJMldaTcDG/bcHarIn
         wKN527uYemylzJGjuDKerFk0a1H1DxfYo0pWhoAM2XeqMrO/zWP7A4j2eKcsklyP5nYO
         6iLv41misbE4Ld549/Mpg0xZ0xvDmWDPHdldwhJ0tKWt8eZteEbQaixaP83kHwVdThhX
         FNYYiN/01zrYghz6igEjQwEA47ScJQf/uEjLsppkLDXuoWrkLBkMYRStm7guSPHSL0Ve
         WKhcgrWCVPP4yZOltI4ItQJGBVwY39oGinS+lAAVzuVw6H1dj8B8hbE1qmAghoPRhWgZ
         aFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680233517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+9ZPtRrjL6zYn8USHZp7DIBp0J7SJ4SjTl0hBaFZwU=;
        b=zn1kbVSVgFN78jhwNNRxNX66gcmEUayTlUcCKuUPLtMyJqTaFXvgv9uhzE4Iim95vJ
         fs8/FonSi3GYoryqtF4n7Z+4hp2OmnoCwYzXoj225Tq6mHQCAMZzdm2vjojHGw1oDUea
         331qB03VS3dFfxe+XttyA5yq4RyKMDXeeZoatCGJlFHSA80LGXOpwm8b6oVk+UoT/63K
         ghvgkYT8zmfdMEgnZuLrI1DH0/ZLJAc/CNHSHR5O1zwq9uKKJme3a7ooQv86xeU+fCC1
         pjbH42T0GD7S2/FpLyoUZnxKVbKKYrCiwiIX5e0VzfKkHoXzjUrCb7ODhBW2JNrSatOv
         cSAg==
X-Gm-Message-State: AAQBX9fS94BML7gKlXO5N6zENCyheNlKkkw+KRNmJjrwh4VwbXGw/vAP
        FCxXtb3VJT5o/tT8uNdajfE=
X-Google-Smtp-Source: AKy350YKL1xfmb6bn3n7spfcte0bMvhxDHTazP/SFUMAnfe0dfrEdD/Hy8m6gTAtym+NDyPM1lg3XQ==
X-Received: by 2002:a17:90b:33cc:b0:237:40a5:7cb9 with SMTP id lk12-20020a17090b33cc00b0023740a57cb9mr28369711pjb.5.1680233517522;
        Thu, 30 Mar 2023 20:31:57 -0700 (PDT)
Received: from ubt.spreadtrum.com ([138.113.14.245])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001a239325f1csm449128pld.100.2023.03.30.20.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:31:57 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V3 2/2] iommu: sprd: Add support for reattaching an existing domain
Date:   Fri, 31 Mar 2023 11:31:24 +0800
Message-Id: <20230331033124.864691-3-zhang.lyra@gmail.com>
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

This IOMMU driver should allow a domain to be attached more than once.

If IOMMU is reattaching to the same domain which is attached, there's
nothing to be done.

If reattching to a previously-used domain, do not alloc DMA buffer
again which stores address mapping table to avoid memory leak.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/sprd-iommu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 7df1f730c778..3513b2b108bf 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -62,6 +62,7 @@ enum sprd_iommu_version {
  * @eb: gate clock which controls IOMMU access
  */
 struct sprd_iommu_device {
+	struct sprd_iommu_domain	*dom;
 	enum sprd_iommu_version	ver;
 	u32			*prot_page_va;
 	dma_addr_t		prot_page_pa;
@@ -252,15 +253,27 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	size_t pgt_size = sprd_iommu_pgt_size(domain);
 
-	if (dom->sdev)
-		return -EINVAL;
+	/* The device is attached to this domain */
+	if (sdev->dom == dom)
+		return 0;
 
-	dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
-	if (!dom->pgt_va)
-		return -ENOMEM;
+	/* The first time that domain is attaching to a device */
+	if (!dom->pgt_va) {
+		dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
+		if (!dom->pgt_va)
+			return -ENOMEM;
+
+		dom->sdev = sdev;
+	}
 
-	dom->sdev = sdev;
+	sdev->dom = dom;
 
+	/*
+	 * One sprd IOMMU serves one client device only, disabled it before
+	 * configure mapping table to avoid access conflict in case other
+	 * mapping table is stored in.
+	 */
+	sprd_iommu_hw_en(sdev, false);
 	sprd_iommu_first_ppn(dom);
 	sprd_iommu_first_vpn(dom);
 	sprd_iommu_vpn_range(dom);
-- 
2.25.1

