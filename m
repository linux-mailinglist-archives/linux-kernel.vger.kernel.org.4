Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678BB5B8D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiINQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiINQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:52:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3B80E92;
        Wed, 14 Sep 2022 09:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E06BB81907;
        Wed, 14 Sep 2022 16:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D4DC43141;
        Wed, 14 Sep 2022 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663174349;
        bh=ZwdKR+wq+42vJbHhUhqKm4ox6fQoPPx3uxHytzx1GNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2KUqy2T6e+N4SnfSjqONgo1x+Qntl5J2LHL2TJPHYhLimBjPjHyWZZVfWHkS3Mhl
         Ny6JDA3c1+ezdRKKxtCeikassDOX1TBVqBMSE4wcgUFLB+bhUykSi67zRhH91JynyT
         aJCjtaX4/uJ3hQjvLBDVSsv+ZtywYe3W3wnPGbC4z5s5UezVbOy1FPhuTC2dtsgbUB
         dUFckceO/r2wZ3kO7MczAnAnA5WeuiFN/yMolUlhmTT9mct+BcIHcmdEy9GGLNXYDG
         lOqrf6UulQZ+QVAyZR4QW7Sjpt1rQzpS0v8oBaaCyVg20bKHYu6O2bKNePuQHRnMxs
         fjCNPD0NriFqw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 2/2] spmi: pmic-arb: Add support for PMIC v7
Date:   Wed, 14 Sep 2022 22:22:12 +0530
Message-Id: <20220914165212.3705892-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914165212.3705892-1-vkoul@kernel.org>
References: <20220914165212.3705892-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

PMIC v7 has different offset values and seqeunces, so add support for
this new version of PMIC

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450 HDK
---
 drivers/spmi/spmi-pmic-arb.c | 242 ++++++++++++++++++++++++++++++++---
 1 file changed, 221 insertions(+), 21 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 2cf3203b2397..8b6a42ab816f 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -22,8 +22,14 @@
 #define PMIC_ARB_VERSION_V2_MIN		0x20010000
 #define PMIC_ARB_VERSION_V3_MIN		0x30000000
 #define PMIC_ARB_VERSION_V5_MIN		0x50000000
+#define PMIC_ARB_VERSION_V7_MIN		0x70000000
 #define PMIC_ARB_INT_EN			0x0004
 
+#define PMIC_ARB_FEATURES		0x0004
+#define PMIC_ARB_FEATURES_PERIPH_MASK	GENMASK(10, 0)
+
+#define PMIC_ARB_FEATURES1		0x0008
+
 /* PMIC Arbiter channel registers offsets */
 #define PMIC_ARB_CMD			0x00
 #define PMIC_ARB_CONFIG			0x04
@@ -48,7 +54,6 @@
 #define INVALID_EE				0xFF
 
 /* Ownership Table */
-#define SPMI_OWNERSHIP_TABLE_REG(N)	(0x0700 + (4 * (N)))
 #define SPMI_OWNERSHIP_PERIPH2OWNER(X)	((X) & 0x7)
 
 /* Channel Status fields */
@@ -91,6 +96,7 @@ enum pmic_arb_channel {
 
 /* Maximum number of support PMIC peripherals */
 #define PMIC_ARB_MAX_PERIPHS		512
+#define PMIC_ARB_MAX_PERIPHS_V7		1024
 #define PMIC_ARB_TIMEOUT_US		1000
 #define PMIC_ARB_MAX_TRANS_BYTES	(8)
 
@@ -104,12 +110,12 @@ enum pmic_arb_channel {
 	((((slave_id) & 0xF)   << 28) | \
 	(((periph_id) & 0xFF)  << 20) | \
 	(((irq_id)    & 0x7)   << 16) | \
-	(((apid)      & 0x1FF) << 0))
+	(((apid)      & 0x3FF) << 0))
 
 #define hwirq_to_sid(hwirq)  (((hwirq) >> 28) & 0xF)
 #define hwirq_to_per(hwirq)  (((hwirq) >> 20) & 0xFF)
 #define hwirq_to_irq(hwirq)  (((hwirq) >> 16) & 0x7)
-#define hwirq_to_apid(hwirq) (((hwirq) >> 0)  & 0x1FF)
+#define hwirq_to_apid(hwirq) (((hwirq) >> 0)  & 0x3FF)
 
 struct pmic_arb_ver_ops;
 
@@ -130,13 +136,21 @@ struct apid_data {
  * @channel:		execution environment channel to use for accesses.
  * @irq:		PMIC ARB interrupt.
  * @ee:			the current Execution Environment
+ * @bus_instance:	on v7: 0 = primary SPMI bus, 1 = secondary SPMI bus
  * @min_apid:		minimum APID (used for bounding IRQ search)
  * @max_apid:		maximum APID
+ * @base_apid:		on v7: minimum APID associated with the particular SPMI
+ *			bus instance
+ * @apid_count:		on v5 and v7: number of APIDs associated with the
+ *			particular SPMI bus instance
  * @mapping_table:	in-memory copy of PPID -> APID mapping table.
  * @domain:		irq domain object for PMIC IRQ domain
  * @spmic:		SPMI controller object
  * @ver_ops:		version dependent operations.
- * @ppid_to_apid	in-memory copy of PPID -> APID mapping table.
+ * @ppid_to_apid:	in-memory copy of PPID -> APID mapping table.
+ * @last_apid:		Highest value APID in use
+ * @apid_data:		Table of data for all APIDs
+ * @max_periphs:	Number of elements in apid_data[]
  */
 struct spmi_pmic_arb {
 	void __iomem		*rd_base;
@@ -149,8 +163,11 @@ struct spmi_pmic_arb {
 	u8			channel;
 	int			irq;
 	u8			ee;
+	u32			bus_instance;
 	u16			min_apid;
 	u16			max_apid;
+	u16			base_apid;
+	int			apid_count;
 	u32			*mapping_table;
 	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
 	struct irq_domain	*domain;
@@ -158,7 +175,8 @@ struct spmi_pmic_arb {
 	const struct pmic_arb_ver_ops *ver_ops;
 	u16			*ppid_to_apid;
 	u16			last_apid;
-	struct apid_data	apid_data[PMIC_ARB_MAX_PERIPHS];
+	struct apid_data	*apid_data;
+	int			max_periphs;
 };
 
 /**
@@ -180,6 +198,7 @@ struct spmi_pmic_arb {
  * @irq_clear:		on v1 address of PMIC_ARB_SPMI_PIC_IRQ_CLEARn
  *			on v2 address of SPMI_PIC_IRQ_CLEARn.
  * @apid_map_offset:	offset of PMIC_ARB_REG_CHNLn
+ * @apid_owner:		on v2 and later address of SPMI_PERIPHn_2OWNER_TABLE_REG
  */
 struct pmic_arb_ver_ops {
 	const char *ver_str;
@@ -196,6 +215,7 @@ struct pmic_arb_ver_ops {
 	void __iomem *(*irq_status)(struct spmi_pmic_arb *pmic_arb, u16 n);
 	void __iomem *(*irq_clear)(struct spmi_pmic_arb *pmic_arb, u16 n);
 	u32 (*apid_map_offset)(u16 n);
+	void __iomem *(*apid_owner)(struct spmi_pmic_arb *pmic_arb, u16 n);
 };
 
 static inline void pmic_arb_base_write(struct spmi_pmic_arb *pmic_arb,
@@ -627,6 +647,11 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int first = pmic_arb->min_apid;
 	int last = pmic_arb->max_apid;
+	/*
+	 * acc_offset will be non-zero for the secondary SPMI bus instance on
+	 * v7 controllers.
+	 */
+	int acc_offset = pmic_arb->base_apid >> 5;
 	u8 ee = pmic_arb->ee;
 	u32 status, enable, handled = 0;
 	int i, id, apid;
@@ -637,8 +662,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	for (i = first >> 5; i <= last >> 5; ++i) {
-		status = readl_relaxed(
-				ver_ops->owner_acc_status(pmic_arb, ee, i));
+		status = readl_relaxed(ver_ops->owner_acc_status(pmic_arb, ee, i - acc_offset));
 		if (status)
 			acc_valid = true;
 
@@ -983,8 +1007,8 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 		if (offset >= pmic_arb->core_size)
 			break;
 
-		regval = readl_relaxed(pmic_arb->cnfg +
-				      SPMI_OWNERSHIP_TABLE_REG(apid));
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
+								     apid));
 		apidd->irq_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
 		apidd->write_ee = apidd->irq_ee;
 
@@ -1020,21 +1044,30 @@ static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 
 static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 {
-	struct apid_data *apidd = pmic_arb->apid_data;
+	struct apid_data *apidd;
 	struct apid_data *prev_apidd;
-	u16 i, apid, ppid;
+	u16 i, apid, ppid, apid_max;
 	bool valid, is_irq_ee;
 	u32 regval, offset;
 
 	/*
 	 * In order to allow multiple EEs to write to a single PPID in arbiter
-	 * version 5, there is more than one APID mapped to each PPID.
+	 * version 5 and 7, there is more than one APID mapped to each PPID.
 	 * The owner field for each of these mappings specifies the EE which is
 	 * allowed to write to the APID.  The owner of the last (highest) APID
 	 * which has the IRQ owner bit set for a given PPID will receive
 	 * interrupts from the PPID.
+	 *
+	 * In arbiter version 7, the APID numbering space is divided between
+	 * the primary bus (0) and secondary bus (1) such that:
+	 * APID = 0 to N-1 are assigned to the primary bus
+	 * APID = N to N+M-1 are assigned to the secondary bus
+	 * where N = number of APIDs supported by the primary bus and
+	 *       M = number of APIDs supported by the secondary bus
 	 */
-	for (i = 0; ; i++, apidd++) {
+	apidd = &pmic_arb->apid_data[pmic_arb->base_apid];
+	apid_max = pmic_arb->base_apid + pmic_arb->apid_count;
+	for (i = pmic_arb->base_apid; i < apid_max; i++, apidd++) {
 		offset = pmic_arb->ver_ops->apid_map_offset(i);
 		if (offset >= pmic_arb->core_size)
 			break;
@@ -1045,8 +1078,8 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 		ppid = (regval >> 8) & PMIC_ARB_PPID_MASK;
 		is_irq_ee = PMIC_ARB_CHAN_IS_IRQ_OWNER(regval);
 
-		regval = readl_relaxed(pmic_arb->cnfg +
-				      SPMI_OWNERSHIP_TABLE_REG(i));
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
+								     i));
 		apidd->write_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
 
 		apidd->irq_ee = is_irq_ee ? apidd->write_ee : INVALID_EE;
@@ -1145,6 +1178,40 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return offset;
 }
 
+/*
+ * v7 offset per ee and per apid for observer channels and per apid for
+ * read/write channels.
+ */
+static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
+			   enum pmic_arb_channel ch_type)
+{
+	u16 apid;
+	int rc;
+	u32 offset = 0;
+	u16 ppid = (sid << 8) | (addr >> 8);
+
+	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
+	if (rc < 0)
+		return rc;
+
+	apid = rc;
+	switch (ch_type) {
+	case PMIC_ARB_CHANNEL_OBS:
+		offset = 0x8000 * pmic_arb->ee + 0x20 * apid;
+		break;
+	case PMIC_ARB_CHANNEL_RW:
+		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
+			dev_err(&pmic_arb->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
+				sid, addr);
+			return -EPERM;
+		}
+		offset = 0x1000 * apid;
+		break;
+	}
+
+	return offset;
+}
+
 static u32 pmic_arb_fmt_cmd_v1(u8 opc, u8 sid, u16 addr, u8 bc)
 {
 	return (opc << 27) | ((sid & 0xf) << 20) | (addr << 4) | (bc & 0x7);
@@ -1179,6 +1246,12 @@ pmic_arb_owner_acc_status_v5(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
 	return pmic_arb->intr + 0x10000 * m + 0x4 * n;
 }
 
+static void __iomem *
+pmic_arb_owner_acc_status_v7(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+{
+	return pmic_arb->intr + 0x1000 * m + 0x4 * n;
+}
+
 static void __iomem *
 pmic_arb_acc_enable_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
 {
@@ -1197,6 +1270,12 @@ pmic_arb_acc_enable_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
 	return pmic_arb->wr_base + 0x100 + 0x10000 * n;
 }
 
+static void __iomem *
+pmic_arb_acc_enable_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->wr_base + 0x100 + 0x1000 * n;
+}
+
 static void __iomem *
 pmic_arb_irq_status_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
 {
@@ -1215,6 +1294,12 @@ pmic_arb_irq_status_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
 	return pmic_arb->wr_base + 0x104 + 0x10000 * n;
 }
 
+static void __iomem *
+pmic_arb_irq_status_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->wr_base + 0x104 + 0x1000 * n;
+}
+
 static void __iomem *
 pmic_arb_irq_clear_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
 {
@@ -1233,6 +1318,12 @@ pmic_arb_irq_clear_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
 	return pmic_arb->wr_base + 0x108 + 0x10000 * n;
 }
 
+static void __iomem *
+pmic_arb_irq_clear_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->wr_base + 0x108 + 0x1000 * n;
+}
+
 static u32 pmic_arb_apid_map_offset_v2(u16 n)
 {
 	return 0x800 + 0x4 * n;
@@ -1243,6 +1334,28 @@ static u32 pmic_arb_apid_map_offset_v5(u16 n)
 	return 0x900 + 0x4 * n;
 }
 
+static u32 pmic_arb_apid_map_offset_v7(u16 n)
+{
+	return 0x2000 + 0x4 * n;
+}
+
+static void __iomem *
+pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->cnfg + 0x700 + 0x4 * n;
+}
+
+/*
+ * For arbiter version 7, APID ownership table registers have independent
+ * numbering space for each SPMI bus instance, so each is indexed starting from
+ * 0.
+ */
+static void __iomem *
+pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->cnfg + 0x4 * (n - pmic_arb->base_apid);
+}
+
 static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.ver_str		= "v1",
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v1,
@@ -1254,6 +1367,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.irq_status		= pmic_arb_irq_status_v1,
 	.irq_clear		= pmic_arb_irq_clear_v1,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.apid_owner		= pmic_arb_apid_owner_v2,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v2 = {
@@ -1267,6 +1381,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 	.irq_status		= pmic_arb_irq_status_v2,
 	.irq_clear		= pmic_arb_irq_clear_v2,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.apid_owner		= pmic_arb_apid_owner_v2,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v3 = {
@@ -1280,6 +1395,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 	.irq_status		= pmic_arb_irq_status_v2,
 	.irq_clear		= pmic_arb_irq_clear_v2,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.apid_owner		= pmic_arb_apid_owner_v2,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v5 = {
@@ -1293,6 +1409,21 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 	.irq_status		= pmic_arb_irq_status_v5,
 	.irq_clear		= pmic_arb_irq_clear_v5,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v5,
+	.apid_owner		= pmic_arb_apid_owner_v2,
+};
+
+static const struct pmic_arb_ver_ops pmic_arb_v7 = {
+	.ver_str		= "v7",
+	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
+	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
+	.offset			= pmic_arb_offset_v7,
+	.fmt_cmd		= pmic_arb_fmt_cmd_v2,
+	.owner_acc_status	= pmic_arb_owner_acc_status_v7,
+	.acc_enable		= pmic_arb_acc_enable_v7,
+	.irq_status		= pmic_arb_irq_status_v7,
+	.irq_clear		= pmic_arb_irq_clear_v7,
+	.apid_map_offset	= pmic_arb_apid_map_offset_v7,
+	.apid_owner		= pmic_arb_apid_owner_v7,
 };
 
 static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
@@ -1319,8 +1450,18 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	pmic_arb = spmi_controller_get_drvdata(ctrl);
 	pmic_arb->spmic = ctrl;
 
+	/*
+	 * Please don't replace this with devm_platform_ioremap_resource() or
+	 * devm_ioremap_resource().  These both result in a call to
+	 * devm_request_mem_region() which prevents multiple mappings of this
+	 * register address range.  SoCs with PMIC arbiter v7 may define two
+	 * arbiter devices, for the two physical SPMI interfaces, which  share
+	 * some register address ranges (i.e. "core", "obsrvr", and "chnls").
+	 * Ensure that both devices probe successfully by calling devm_ioremap()
+	 * which does not result in a devm_request_mem_region() call.
+	 */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
-	core = devm_ioremap_resource(&ctrl->dev, res);
+	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
 	if (IS_ERR(core)) {
 		err = PTR_ERR(core);
 		goto err_put_ctrl;
@@ -1349,12 +1490,15 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 			pmic_arb->ver_ops = &pmic_arb_v2;
 		else if (hw_ver < PMIC_ARB_VERSION_V5_MIN)
 			pmic_arb->ver_ops = &pmic_arb_v3;
-		else
+		else if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
 			pmic_arb->ver_ops = &pmic_arb_v5;
+		else
+			pmic_arb->ver_ops = &pmic_arb_v7;
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "obsrvr");
-		pmic_arb->rd_base = devm_ioremap_resource(&ctrl->dev, res);
+		pmic_arb->rd_base = devm_ioremap(&ctrl->dev, res->start,
+						 resource_size(res));
 		if (IS_ERR(pmic_arb->rd_base)) {
 			err = PTR_ERR(pmic_arb->rd_base);
 			goto err_put_ctrl;
@@ -1362,13 +1506,69 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "chnls");
-		pmic_arb->wr_base = devm_ioremap_resource(&ctrl->dev, res);
+		pmic_arb->wr_base = devm_ioremap(&ctrl->dev, res->start,
+						 resource_size(res));
 		if (IS_ERR(pmic_arb->wr_base)) {
 			err = PTR_ERR(pmic_arb->wr_base);
 			goto err_put_ctrl;
 		}
 	}
 
+	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
+
+	if (hw_ver >= PMIC_ARB_VERSION_V7_MIN) {
+		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
+		/* Optional property for v7: */
+		of_property_read_u32(pdev->dev.of_node, "qcom,bus-id",
+					&pmic_arb->bus_instance);
+		if (pmic_arb->bus_instance > 1) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "invalid bus instance (%u) specified\n",
+				pmic_arb->bus_instance);
+			goto err_put_ctrl;
+		}
+
+		if (pmic_arb->bus_instance == 0) {
+			pmic_arb->base_apid = 0;
+			pmic_arb->apid_count =
+				readl_relaxed(core + PMIC_ARB_FEATURES) &
+				PMIC_ARB_FEATURES_PERIPH_MASK;
+		} else {
+			pmic_arb->base_apid =
+				readl_relaxed(core + PMIC_ARB_FEATURES) &
+				PMIC_ARB_FEATURES_PERIPH_MASK;
+			pmic_arb->apid_count =
+				readl_relaxed(core + PMIC_ARB_FEATURES1) &
+				PMIC_ARB_FEATURES_PERIPH_MASK;
+		}
+
+		if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
+				pmic_arb->base_apid + pmic_arb->apid_count);
+			goto err_put_ctrl;
+		}
+	} else if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
+		pmic_arb->base_apid = 0;
+		pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES) &
+					PMIC_ARB_FEATURES_PERIPH_MASK;
+
+		if (pmic_arb->apid_count > pmic_arb->max_periphs) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
+				pmic_arb->apid_count);
+			goto err_put_ctrl;
+		}
+	}
+
+	pmic_arb->apid_data = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
+					   sizeof(*pmic_arb->apid_data),
+					   GFP_KERNEL);
+	if (!pmic_arb->apid_data) {
+		err = -ENOMEM;
+		goto err_put_ctrl;
+	}
+
 	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
 		 pmic_arb->ver_ops->ver_str, hw_ver);
 
@@ -1420,7 +1620,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	}
 
 	pmic_arb->ee = ee;
-	mapping_table = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PERIPHS,
+	mapping_table = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
 					sizeof(*mapping_table), GFP_KERNEL);
 	if (!mapping_table) {
 		err = -ENOMEM;
@@ -1431,7 +1631,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	/* Initialize max_apid/min_apid to the opposite bounds, during
 	 * the irq domain translation, we are sure to update these */
 	pmic_arb->max_apid = 0;
-	pmic_arb->min_apid = PMIC_ARB_MAX_PERIPHS - 1;
+	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
 
 	platform_set_drvdata(pdev, ctrl);
 	raw_spin_lock_init(&pmic_arb->lock);
-- 
2.37.3

