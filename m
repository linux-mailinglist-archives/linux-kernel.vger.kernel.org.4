Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4760D209
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiJYQzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiJYQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:55:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165D5209E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so13494880wrh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj7FhB58uMn4h8H3wgZfmSRd9vXTbsp8lRGrOrs+X1o=;
        b=KoO/IFDIdAddmPIJ1BG+QvpjyIUIS+dN795VoEhPKi5wfaQcbf+E+GBzzCH6fbXB/f
         d9ezM6PZerO2XMyIMxsSkwcP20hElLy6CA53mi4Ad70JlUoEJZ4K5wCBfivlaTzslW/j
         YMhNodNgw0XA0BPiiU+0Hcacb+yulPiCGfNKmvPAuKajNPunn14TvN1/MPH986ZC67w0
         zkf6rSBJMR4omsaTAkmgZQtJcYGtOFewv3K43i1E5CtMwARAPVfK5Tq/KrxUNFrk7sYb
         2mv3NfngdOVyfsvD7dk7CUw6njAMR0Vg70i5toRbU7IqeLnCDaRSm4G0ppSF5+EIz4O0
         73lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj7FhB58uMn4h8H3wgZfmSRd9vXTbsp8lRGrOrs+X1o=;
        b=vkKaqXvJmq8dp197dfc9TzDHURecL/SD31iwekFxCJOr/hB/OKlsELAsmyNo1m1vsm
         +c9e7IUPC5QILmjGqiwukCm/fqM8EI1LBWXTPg0W0tpKaO05VWwEPzdrNPXPrnuWeuvL
         IKNyUaA/sWAtycoc++qpsHdgBusM/pPINMeBZSrvaupFPUCqiOZxkCWbwdxgsiRZU1Ep
         /lT56vWZ1Fz1k7x4obEzDMPKOq13ZL+hFhJVUlTAbq7e55K8TsS0XOBNpMrmcRgeFQeQ
         7Yug/UeH+rA/JgOvuqeUuXFif+/1WfHleEGpq9o7wPkI0hB5I3U3dYdGC1YKnyz7+Z7w
         JGrQ==
X-Gm-Message-State: ACrzQf3kaWJWnheS4+zRSEFbum9fB0GOlrjRO9jM43lQhokxtZSjANSU
        XmNg5CdzQdmjwEcpKOsHo/4ypI8VbgvqSA==
X-Google-Smtp-Source: AMsMyM4QbdbhgbDyi34T6qfyQKp7IPL827BhF9NwQyMqQzPbUOVWRISJYasElMB6P/tEeZYiLkd+dQ==
X-Received: by 2002:a5d:64c2:0:b0:22e:41b1:faf7 with SMTP id f2-20020a5d64c2000000b0022e41b1faf7mr24834767wri.428.1666716879104;
        Tue, 25 Oct 2022 09:54:39 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:38 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 5/5] iommu/sun50i: Implement .iotlb_sync_map
Date:   Tue, 25 Oct 2022 18:54:15 +0200
Message-Id: <20221025165415.307591-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025165415.307591-1-jernej.skrabec@gmail.com>
References: <20221025165415.307591-1-jernej.skrabec@gmail.com>
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

Allocated iova ranges need to be invalidated immediately or otherwise
they might or might not work when used by master or CPU. This was
discovered when running video decoder conformity test with Cedrus. Some
videos were now and then decoded incorrectly and generated page faults.

According to vendor driver, it's enough to invalidate just start and end
TLB and PTW cache lines. Documentation says that neighbouring lines must
be invalidated too. Finally, when page fault occurs, that iova must be
invalidated the same way, according to documentation.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
 - new patch

 drivers/iommu/sun50i-iommu.c | 73 ++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index e62e245060ac..5cb2d44dfb92 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -93,6 +93,8 @@
 #define NUM_PT_ENTRIES			256
 #define PT_SIZE				(NUM_PT_ENTRIES * PT_ENTRY_SIZE)

+#define SPAGE_SIZE			4096
+
 struct sun50i_iommu {
 	struct iommu_device iommu;

@@ -295,6 +297,62 @@ static void sun50i_table_flush(struct sun50i_iommu_domain *sun50i_domain,
 	dma_sync_single_for_device(iommu->dev, dma, size, DMA_TO_DEVICE);
 }

+static void sun50i_iommu_zap_iova(struct sun50i_iommu *iommu,
+				  unsigned long iova)
+{
+	u32 reg;
+	int ret;
+
+	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_REG, iova);
+	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_MASK_REG, GENMASK(31, 12));
+	iommu_write(iommu, IOMMU_TLB_IVLD_ENABLE_REG,
+		    IOMMU_TLB_IVLD_ENABLE_ENABLE);
+
+	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_TLB_IVLD_ENABLE_REG,
+					reg, !reg, 1, 2000);
+	if (ret)
+		dev_warn(iommu->dev, "TLB invalidation timed out!\n");
+}
+
+static void sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu,
+				       unsigned long iova)
+{
+	u32 reg;
+	int ret;
+
+	iommu_write(iommu, IOMMU_PC_IVLD_ADDR_REG, iova);
+	iommu_write(iommu, IOMMU_PC_IVLD_ENABLE_REG,
+		    IOMMU_PC_IVLD_ENABLE_ENABLE);
+
+	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_PC_IVLD_ENABLE_REG,
+					reg, !reg, 1, 2000);
+	if (ret)
+		dev_warn(iommu->dev, "PTW cache invalidation timed out!\n");
+}
+
+static void sun50i_iommu_zap_range(struct sun50i_iommu *iommu,
+				   unsigned long iova, size_t size)
+{
+	assert_spin_locked(&iommu->iommu_lock);
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
+
+	sun50i_iommu_zap_iova(iommu, iova);
+	sun50i_iommu_zap_iova(iommu, iova + SPAGE_SIZE);
+	if (size > SPAGE_SIZE) {
+		sun50i_iommu_zap_iova(iommu, iova + size);
+		sun50i_iommu_zap_iova(iommu, iova + size + SPAGE_SIZE);
+	}
+	sun50i_iommu_zap_ptw_cache(iommu, iova);
+	sun50i_iommu_zap_ptw_cache(iommu, iova + SZ_1M);
+	if (size > SZ_1M) {
+		sun50i_iommu_zap_ptw_cache(iommu, iova + size);
+		sun50i_iommu_zap_ptw_cache(iommu, iova + size + SZ_1M);
+	}
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
+}
+
 static int sun50i_iommu_flush_all_tlb(struct sun50i_iommu *iommu)
 {
 	u32 reg;
@@ -344,6 +402,18 @@ static void sun50i_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
 }

+static void sun50i_iommu_iotlb_sync_map(struct iommu_domain *domain,
+					unsigned long iova, size_t size)
+{
+	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
+	struct sun50i_iommu *iommu = sun50i_domain->iommu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->iommu_lock, flags);
+	sun50i_iommu_zap_range(iommu, iova, size);
+	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
+}
+
 static void sun50i_iommu_iotlb_sync(struct iommu_domain *domain,
 				    struct iommu_iotlb_gather *gather)
 {
@@ -767,6 +837,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 		.attach_dev	= sun50i_iommu_attach_device,
 		.detach_dev	= sun50i_iommu_detach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
+		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
 		.iova_to_phys	= sun50i_iommu_iova_to_phys,
 		.map		= sun50i_iommu_map,
@@ -786,6 +857,8 @@ static void sun50i_iommu_report_fault(struct sun50i_iommu *iommu,
 		report_iommu_fault(iommu->domain, iommu->dev, iova, prot);
 	else
 		dev_err(iommu->dev, "Page fault while iommu not attached to any domain?\n");
+
+	sun50i_iommu_zap_range(iommu, iova, SPAGE_SIZE);
 }

 static phys_addr_t sun50i_iommu_handle_pt_irq(struct sun50i_iommu *iommu,
--
2.38.1

