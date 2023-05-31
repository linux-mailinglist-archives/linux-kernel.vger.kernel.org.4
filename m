Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058627182A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbjEaNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjEaNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499B1B3;
        Wed, 31 May 2023 06:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DA7761346;
        Wed, 31 May 2023 13:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F52C433D2;
        Wed, 31 May 2023 13:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540541;
        bh=hmCtJpQjdp9jItNQhrqO208ugFMQmvJywnybkkkOh5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODf9bkL2Qt9DWIijSkaRUYaNM7rNlAGZ/bzU7H+b2DYhKp15YXrkmvN/aewmiiyTj
         q3I9+RZTYIAhq6qsCAweD+/m3yWTfvpk4NVKGrG6eMQk502rH6FvX6HUB6BLl+Zvk/
         /itC0SMkrT0JAoTfj8U2XADw0dmZY346ZVo8NylAFlQRLhwT2p6psGSLhtp9Ct5pLa
         8oKjhLW6LZ4IfjZSgGQAurFScUso7bGfKxXQ0gzQAUMJtQuftNktVbYAGmuppdPJRD
         g2nbJZSNeRuKIA1wr9UDl3GhyjsLlyT2TZwvwMgz82aEAOjSdeVgNS4N6qatga9e0C
         XwkOUiUwEalig==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tglx@linutronix.de, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/33] irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues
Date:   Wed, 31 May 2023 09:41:37 -0400
Message-Id: <20230531134159.3383703-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 44bd78dd2b8897f59b7e3963f088caadb7e4f047 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-common.c |  8 ++++++--
 drivers/irqchip/irq-gic-common.h |  1 +
 drivers/irqchip/irq-gic-v3.c     | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index a610821c8ff2a..de47b51cdadbe 100644
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
index 27e3d4ed4f328..3db4592cda1c0 100644
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
index 2182f87d2d12e..11f7c53e4b634 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -38,6 +38,7 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -1730,6 +1731,15 @@ static bool gic_enable_quirk_msm8996(void *data)
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
@@ -1802,6 +1812,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.compatible = "qcom,msm8996-gic-v3",
 		.init	= gic_enable_quirk_msm8996,
 	},
+	{
+		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
+		.property = "mediatek,broken-save-restore-fw",
+		.init	= gic_enable_quirk_mtk_gicr,
+	},
 	{
 		.desc	= "GICv3: HIP06 erratum 161010803",
 		.iidr	= 0x0204043b,
@@ -1844,6 +1859,11 @@ static void gic_enable_nmi_support(void)
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
-- 
2.39.2

