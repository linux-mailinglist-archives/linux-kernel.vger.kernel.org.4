Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E8704A69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjEPKWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjEPKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:22:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F044217
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:22:39 -0700 (PDT)
Date:   Tue, 16 May 2023 10:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684232558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqPgwAW90cOeVazXe+kEfEHoMbM4x7CLjfL19TxDKts=;
        b=e6YZtoBLwwLoMDtBJ+I57c+6jmytCiQb7O3U9SW9VEnt9GqnRq121/aLznIuXcVQ8+s8jj
        mTD4WFFWc8eIWrarGRELzvRhUAxfWLnlzAcPq+wdQynUvx1QTMjPsZ3CqBaLa0zd9S4O+g
        ymw9Mns2jK6jKNi+JRqsz2lJ0BefVtbzaPuo0ADB/BKQSoMxXgesdCpKDiW5VHVWOHI3F5
        9ee+tB59BheZ2qWeclXOHs2L5JQBUJG0AVNy9EWAOQrw3YjJnXdgZ8hbzML/rEejQCGzt7
        0spOs2YTI+nOgp1YXr0lC4SfvHvv9LXaW30IFg90kjmpetdhg7yaKoi2QKR51g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684232558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqPgwAW90cOeVazXe+kEfEHoMbM4x7CLjfL19TxDKts=;
        b=UYL2P00Ws3gLiAFnLWwgZ8eh7h4SNuFM9JXXT2U9mwJSAmbT4nuQNjtmHZBnOMSLBaO4pb
        Ayz85hGDpltTpVAg==
From:   "irqchip-bot for Douglas Anderson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3: Disable pseudo NMIs on
 Mediatek devices w/ firmware issues
Cc:     Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
References: <20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
MIME-Version: 1.0
Message-ID: <168423255773.404.14848290278499554700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     44bd78dd2b8897f59b7e3963f088caadb7e4f047
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/44bd78dd2b8897f59b7e3963f088caadb7e4f047
Author:        Douglas Anderson <dianders@chromium.org>
AuthorDate:    Mon, 15 May 2023 13:13:51 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 16 May 2023 10:43:24 +01:00

irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues

Some Chromebooks with Mediatek SoCs have a problem where the firmware
doesn't properly save/restore certain GICR registers. Newer
Chromebooks should fix this issue and we may be able to do firmware
updates for old Chromebooks. At the moment, the only known issue with
these Chromebooks is that we can't enable "pseudo NMIs" since the
priority register can be lost. Enabling "pseudo NMIs" on Chromebooks
with the problematic firmware causes crashes and freezes.

Let's detect devices with this problem and then disable "pseudo NMIs"
on them. We'll detect the problem by looking for the presence of the
"mediatek,broken-save-restore-fw" property in the GIC device tree
node. Any devices with fixed firmware will not have this property.

Our detection plan works because we never bake a Chromebook's device
tree into firmware. Instead, device trees are always bundled with the
kernel. We'll update the device trees of all affected Chromebooks and
then we'll never enable "pseudo NMI" on a kernel that is bundled with
old device trees. When a firmware update is shipped that fixes this
issue it will know to patch the device tree to remove the property.

In order to make this work, the quick detection mechanism of the GICv3
code is extended to be able to look for properties in addition to
looking at "compatible".

Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid
---
 drivers/irqchip/irq-gic-common.c |  8 ++++++--
 drivers/irqchip/irq-gic-common.h |  1 +
 drivers/irqchip/irq-gic-v3.c     | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index a610821..de47b51 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -16,7 +16,11 @@ void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (!of_device_is_compatible(np, quirks->compatible))
+		if (quirks->compatible &&
+		    !of_device_is_compatible(np, quirks->compatible))
+			continue;
+		if (quirks->property &&
+		    !of_property_read_bool(np, quirks->property))
 			continue;
 		if (quirks->init(data))
 			pr_info("GIC: enabling workaround for %s\n",
@@ -28,7 +32,7 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (quirks->compatible)
+		if (quirks->compatible || quirks->property)
 			continue;
 		if (quirks->iidr != (quirks->mask & iidr))
 			continue;
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 27e3d4e..3db4592 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -13,6 +13,7 @@
 struct gic_quirk {
 	const char *desc;
 	const char *compatible;
+	const char *property;
 	bool (*init)(void *data);
 	u32 iidr;
 	u32 mask;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fcee22..a605aa7 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -39,6 +39,7 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -1720,6 +1721,15 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_mtk_gicr(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_MTK_GICR_SAVE;
+
+	return true;
+}
+
 static bool gic_enable_quirk_cavium_38539(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1793,6 +1803,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.init	= gic_enable_quirk_msm8996,
 	},
 	{
+		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
+		.property = "mediatek,broken-save-restore-fw",
+		.init	= gic_enable_quirk_mtk_gicr,
+	},
+	{
 		.desc	= "GICv3: HIP06 erratum 161010803",
 		.iidr	= 0x0204043b,
 		.mask	= 0xffffffff,
@@ -1834,6 +1849,11 @@ static void gic_enable_nmi_support(void)
 	if (!gic_prio_masking_enabled())
 		return;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
+		pr_warn("Skipping NMI enable due to firmware issues\n");
+		return;
+	}
+
 	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
 	if (!ppi_nmi_refs)
 		return;
