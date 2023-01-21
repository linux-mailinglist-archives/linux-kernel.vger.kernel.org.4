Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9A676542
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjAUIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjAUIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:48:23 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A255B2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:48:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8456E424EB;
        Sat, 21 Jan 2023 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1674290898;
        bh=Trk1r4f9UJjlxj5XEJA/iW4CHhEy4cvK9cYiIMgdahg=;
        h=From:To:Cc:Subject:Date;
        b=HUXUMSzeLZtn0lgaK1qRbz5tp11xnaXhqx8AAofJvhp7zDuC4isAqv2b7/MXMo8vn
         PTJ16VrCwnOOmAhsi7Z0Tbijm0cQtZtuqhdCJY1RBpG4mszfk49hVuNeg3//jRaGZp
         2kZjL9AEOIJFyeCpl0B9ERyrSTwMKZiA4pT//p5Df2XtD9eZjGDhlppVal9T720VgY
         z0rVeXlBToj5solh1nnzVjb4H+VL8QTrcFEnadXKz3yMPcvlE19e6D2l5gBwawn6cl
         35C2GQux48EoZE6MVAvepCb/XBT0+qWoyApBoTj6R7U0utFqJ4pVlt2NgTmYwkhi8o
         9rPo6KGFUNhZg==
From:   Asahi Lina <lina@asahilina.net>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
Subject: [PATCH] iommu/io-pgtable: Add Apple UAT variant format
Date:   Sat, 21 Jan 2023 17:47:58 +0900
Message-Id: <20230121084758.31875-1-lina@asahilina.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple Silicon SoCs (M1, M2, etc.) have a GPU with an ARM64 firmware
coprocessor. The firmware and the GPU share page tables in the standard
ARM64 format (the firmware literally sets the base as its TTBR0/1
registers). TTBR0 covers the low half of the address space and is
intended to be per-GPU-VM (GPU user mappings and kernel-managed
buffers), while TTBR1 covers the upper half and is global (firmware
code, data, management structures shared with the AP, and a few
GPU-accessible data structures).

In typical Apple fashion, the permissions are interpreted differently
from traditional ARM PTEs. By default, firmware mappings use Apple SPRR
permission remapping. The firmware only uses that for its own
code/data/MMIO mappings, and those pages are not accessible by the GPU
hardware. We never need to touch/manage these mappings, so this patch
does not support them.

When a specific bit is set in the PTEs, permissions switch to a
different scheme which supports various combinations of firmware/GPU
access. This is the mode intended to be used by AP GPU drivers, and what
we implement here.

The prot bits are interpreted as follows:

- IOMMU_READ and IOMMU_WRITE have the usual meaning.

- IOMMU_PRIV creates firmware-only mappings (no GPU access)
- IOMMU_NOEXEC creates GPU-only structures (no FW access)
- Otherwise structures are accessible by both GPU and FW

- IOMMU_MMIO creates Device mappings for firmware
- IOMMU_CACHE creates Normal-NC mappings for firmware (cache-coherent
  from the point of view of the AP, but slower)
- Otherwise creates Normal mappings for firmware (this requires manual
  cache management on the firmware side, as it is not coherent with the
  SoC fabric)

GPU-only mappings (textures/etc) are expected to use IOMMU_CACHE and are
seemingly coherent with the CPU (or otherwise the firmware/GPU already
issue the required cache management operations when correctly
configured).

There is a GPU-RO/FW-RW mode, but it is not currently implemented (it
doesn't seem to be very useful for the driver). There seems to be no
real noexec control (i.e. for shaders) on the GPU side. All of these
mappings are implicitly noexec for the firmware.

Drivers are expected to fully manage per-user (TTBR0) page tables, but
ownership of shared kernel (TTBR1) page tables is shared between the
firmware and the AP OS. We handle this by simply using a smaller IAS to
drop down one level of page tables, so the driver can install a PTE in
the top-level (firmware-initialized) page table directly and just add an
offset to the VAs passed into the io_pgtable code. This avoids having to
have any special handling for this here. The firmware-relevant data
structures are small, so we do not expect to ever require more VA space
than one top-level PTE covers (IAS=36 for the next level, 64 GiB).

Only 16K page mode is supported. The coprocessor MMU supports huge pages
as usual for ARM64, but the GPU MMU does not, so we do not enable them.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/iommu/io-pgtable-arm.c | 101 +++++++++++++++++++++++++++++++--
 drivers/iommu/io-pgtable.c     |   1 +
 include/linux/io-pgtable.h     |   6 ++
 3 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 72dcdd468cf3..85f35035ae95 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -130,6 +130,15 @@
 #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
 
+#define APPLE_UAT_MEMATTR_PRIV		(((arm_lpae_iopte)0x0) << 2)
+#define APPLE_UAT_MEMATTR_DEV		(((arm_lpae_iopte)0x1) << 2)
+#define APPLE_UAT_MEMATTR_SHARED	(((arm_lpae_iopte)0x2) << 2)
+#define APPLE_UAT_GPU_ACCESS			(((arm_lpae_iopte)1) << 55)
+#define APPLE_UAT_UXN				(((arm_lpae_iopte)1) << 54)
+#define APPLE_UAT_PXN				(((arm_lpae_iopte)1) << 53)
+#define APPLE_UAT_AP1				(((arm_lpae_iopte)1) << 7)
+#define APPLE_UAT_AP0				(((arm_lpae_iopte)1) << 6)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -402,7 +411,42 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;
 
-	if (data->iop.fmt == ARM_64_LPAE_S1 ||
+	if (data->iop.fmt == APPLE_UAT) {
+		/*
+		 * This bit enables GPU access and the particular permission
+		 * rules that follow. Without it, access is firmware-only and
+		 * permissions follow the firmware's Apple SPRR configuration.
+		 */
+		pte = APPLE_UAT_GPU_ACCESS;
+		if (prot & IOMMU_PRIV) {
+			/* Firmware structures */
+			pte |= APPLE_UAT_AP0;
+			if (prot & IOMMU_WRITE) {
+				/* Firmware RW */
+				pte |= APPLE_UAT_UXN;
+			} else if (!(prot & IOMMU_READ)) {
+				/* No access */
+				pte |= APPLE_UAT_PXN;
+			}
+		} else if (prot & IOMMU_NOEXEC) {
+			/* GPU structures (no FW access) */
+			pte |= APPLE_UAT_AP1 | ARM_LPAE_PTE_nG;
+			if (!(prot & IOMMU_READ)) {
+				pte |= APPLE_UAT_PXN;
+				if (!(prot & IOMMU_WRITE))
+					pte |= APPLE_UAT_UXN;
+			} else if (prot & IOMMU_WRITE) {
+				pte |= APPLE_UAT_UXN;
+			}
+		} else {
+			pte |= ARM_LPAE_PTE_nG;
+			/* GPU structures (also FW accessible) */
+			if (prot & IOMMU_WRITE)
+				pte |= APPLE_UAT_UXN;
+			if (prot & IOMMU_READ)
+				pte |= APPLE_UAT_PXN;
+		}
+	} else if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
 		pte = ARM_LPAE_PTE_nG;
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
@@ -421,7 +465,14 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	 * Note that this logic is structured to accommodate Mali LPAE
 	 * having stage-1-like attributes but stage-2-like permissions.
 	 */
-	if (data->iop.fmt == ARM_64_LPAE_S2 ||
+	if (data->iop.fmt == APPLE_UAT) {
+		if (prot & IOMMU_MMIO)
+			pte |= APPLE_UAT_MEMATTR_DEV;
+		else if (prot & IOMMU_CACHE)
+			pte |= APPLE_UAT_MEMATTR_SHARED;
+		else
+			pte |= APPLE_UAT_MEMATTR_PRIV;
+	} else if (data->iop.fmt == ARM_64_LPAE_S2 ||
 	    data->iop.fmt == ARM_32_LPAE_S2) {
 		if (prot & IOMMU_MMIO)
 			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
@@ -444,12 +495,14 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	 * "outside the GPU" (i.e. either the Inner or System domain in CPU
 	 * terms, depending on coherency).
 	 */
-	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
+	if (data->iop.fmt == APPLE_UAT)
+		pte |= ARM_LPAE_PTE_SH_NS;
+	else if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
 		pte |= ARM_LPAE_PTE_SH_IS;
 	else
 		pte |= ARM_LPAE_PTE_SH_OS;
 
-	if (prot & IOMMU_NOEXEC)
+	if (prot & IOMMU_NOEXEC && data->iop.fmt != APPLE_UAT)
 		pte |= ARM_LPAE_PTE_XN;
 
 	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
@@ -1079,6 +1132,41 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
+static struct io_pgtable *
+apple_uat_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct arm_lpae_io_pgtable *data;
+
+	/* No quirks for UAT (hopefully) */
+	if (cfg->quirks)
+		return NULL;
+
+	if (cfg->ias > 48 || cfg->oas > 42)
+		return NULL;
+
+	cfg->pgsize_bitmap &= SZ_16K;
+
+	data = arm_lpae_alloc_pgtable(cfg);
+	if (!data)
+		return NULL;
+
+	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
+					   cfg);
+	if (!data->pgd)
+		goto out_free_data;
+
+	/* Ensure the empty pgd is visible before the TTBAT can be written */
+	wmb();
+
+	cfg->apple_uat_cfg.ttbr = virt_to_phys(data->pgd);
+
+	return &data->iop;
+
+out_free_data:
+	kfree(data);
+	return NULL;
+}
+
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
@@ -1104,6 +1192,11 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.free	= arm_lpae_free_pgtable,
 };
 
+struct io_pgtable_init_fns io_pgtable_apple_uat_init_fns = {
+	.alloc	= apple_uat_alloc_pgtable,
+	.free	= arm_lpae_free_pgtable,
+};
+
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
 static struct io_pgtable_cfg *cfg_cookie __initdata;
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index b843fcd365d2..faec53e22388 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -20,6 +20,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
 	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
+	[APPLE_UAT] = &io_pgtable_apple_uat_init_fns,
 #endif
 #ifdef CONFIG_IOMMU_IO_PGTABLE_DART
 	[APPLE_DART] = &io_pgtable_apple_dart_init_fns,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index e4697ff48d3a..50d4dce53ded 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -19,6 +19,7 @@ enum io_pgtable_fmt {
 	AMD_IOMMU_V2,
 	APPLE_DART,
 	APPLE_DART2,
+	APPLE_UAT,
 	IO_PGTABLE_NUM_FMTS,
 };
 
@@ -148,6 +149,10 @@ struct io_pgtable_cfg {
 			u64 ttbr[4];
 			u32 n_ttbrs;
 		} apple_dart_cfg;
+
+		struct {
+			u64	ttbr;
+		} apple_uat_cfg;
 	};
 };
 
@@ -262,5 +267,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_apple_uat_init_fns;
 
 #endif /* __IO_PGTABLE_H */
-- 
2.35.1

