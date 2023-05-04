Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7F6F68A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjEDJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjEDJr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:47:27 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3127049D5;
        Thu,  4 May 2023 02:47:25 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3447a1h4008978;
        Thu, 4 May 2023 11:46:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=I0DdDsFCaPtPMNVJWEIGh2sxNVuBtInCqcxh0YNZ2bQ=;
 b=dMIWrXyTLzpprM5nmhMMCbEfEMPqWHHMCh+dzRL4O2xMV3SAR1kBZgM96e5pvGBcx51m
 N++HqzlTcM7IV3g4Sn60P2s+he4lJd7c8ipREJjbdBRMa7v/Il+uWJEC9GGqrpSRNF9/
 q76JyS9VIptnwRuiLz634TLAjhPxMOjdq0eOcQxjJIquhBmx0RDq/4Fh3Zn0NmKOvZta
 qxrwJMvINjnMdfogN2GGAl44MZ7ZasHWuLGQJXlknV4z0KbkmhWER1M44335EcG6EBMt
 eqO+6nQXNzlSjSywx0mL6rIo/axHuOes/XWQu4lw9Xh8okD3zVaZzWjtxT/39yworhmX Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qbu1ud06g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 11:46:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0DC0100038;
        Thu,  4 May 2023 11:46:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B91D82138F9;
        Thu,  4 May 2023 11:46:53 +0200 (CEST)
Received: from localhost (10.201.21.213) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 4 May
 2023 11:46:53 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v2 2/4] remoteproc: stm32: Allow hold boot management by the SCMI reset controller
Date:   Thu, 4 May 2023 11:46:39 +0200
Message-ID: <20230504094641.870378-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504094641.870378-1-arnaud.pouliquen@foss.st.com>
References: <20230504094641.870378-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hold boot can be managed by the SCMI controller as a reset.
If the "hold_boot" reset is defined in the device tree, use it.
Else use the syscon controller directly to access to the register.
The support of the SMC call is deprecated but kept for legacy support.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Updates vs previous version
- keep support of the "st,syscfg-tz" property for legacy compatibility
- rename secured_soc in hold_boot_smc for readability
- add comments to explain hold boot management.
- update commit message
---
 drivers/remoteproc/stm32_rproc.c | 78 +++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 7d782ed9e589..e9cf24274345 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -79,6 +79,7 @@ struct stm32_mbox {
 
 struct stm32_rproc {
 	struct reset_control *rst;
+	struct reset_control *hold_boot_rst;
 	struct stm32_syscon hold_boot;
 	struct stm32_syscon pdds;
 	struct stm32_syscon m4_state;
@@ -88,7 +89,7 @@ struct stm32_rproc {
 	struct stm32_rproc_mem *rmems;
 	struct stm32_mbox mb[MBOX_NB_MBX];
 	struct workqueue_struct *workqueue;
-	bool secured_soc;
+	bool hold_boot_smc;
 	void __iomem *rsc_va;
 };
 
@@ -401,13 +402,28 @@ static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
 	struct arm_smccc_res smc_res;
 	int val, err;
 
+	/*
+	 * Three ways to manage the hold boot
+	 * - using SCMI: the hold boot is managed as a reset,
+	 * - using Linux(no SCMI): the hold boot is managed as a syscon register
+	 * - using SMC call (deprecated): use SMC reset interface
+	 */
+
 	val = hold ? HOLD_BOOT : RELEASE_BOOT;
 
-	if (IS_ENABLED(CONFIG_HAVE_ARM_SMCCC) && ddata->secured_soc) {
+	if (ddata->hold_boot_rst) {
+		/* Use the SCMI reset controller */
+		if (!hold)
+			err = reset_control_deassert(ddata->hold_boot_rst);
+		else
+			err =  reset_control_assert(ddata->hold_boot_rst);
+	} else if (IS_ENABLED(CONFIG_HAVE_ARM_SMCCC) && ddata->hold_boot_smc) {
+		/* Use the SMC call */
 		arm_smccc_smc(STM32_SMC_RCC, STM32_SMC_REG_WRITE,
 			      hold_boot.reg, val, 0, 0, 0, 0, &smc_res);
 		err = smc_res.a0;
 	} else {
+		/* Use syscon */
 		err = regmap_update_bits(hold_boot.map, hold_boot.reg,
 					 hold_boot.mask, val);
 	}
@@ -705,34 +721,54 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 		dev_info(dev, "wdg irq registered\n");
 	}
 
-	ddata->rst = devm_reset_control_get_by_index(dev, 0);
+	ddata->rst = devm_reset_control_get_optional(dev, "mcu_rst");
+	if (!ddata->rst) {
+		/* Try legacy fallback method: get it by index */
+		ddata->rst = devm_reset_control_get_by_index(dev, 0);
+	}
 	if (IS_ERR(ddata->rst))
 		return dev_err_probe(dev, PTR_ERR(ddata->rst),
 				     "failed to get mcu_reset\n");
 
 	/*
-	 * if platform is secured the hold boot bit must be written by
-	 * smc call and read normally.
-	 * if not secure the hold boot bit could be read/write normally
+	 * Three ways to manage the hold boot
+	 * - using SCMI: the hold boot is managed as a reset
+	 *    The DT "reset-mames" property should be defined with 2 items:
+	 *        reset-names = "mcu_rst", "hold_boot";
+	 * - using SMC call (deprecated): use SMC reset interface
+	 *    The DT "reset-mames" property is optional, "st,syscfg-tz" is required
+	 * - default(no SCMI, no SMC): the hold boot is managed as a syscon register
+	 *    The DT "reset-mames" property is optional, "st,syscfg-holdboot" is required
 	 */
-	err = stm32_rproc_get_syscon(np, "st,syscfg-tz", &tz);
-	if (err) {
-		dev_err(dev, "failed to get tz syscfg\n");
-		return err;
-	}
 
-	err = regmap_read(tz.map, tz.reg, &tzen);
-	if (err) {
-		dev_err(dev, "failed to read tzen\n");
-		return err;
+	ddata->hold_boot_rst = devm_reset_control_get_optional(dev, "hold_boot");
+	if (IS_ERR(ddata->hold_boot_rst)) {
+		if (PTR_ERR(ddata->hold_boot_rst) == -EPROBE_DEFER)
+			return PTR_ERR(ddata->hold_boot_rst);
+		ddata->hold_boot_rst = NULL;
+	}
+
+	if (!ddata->hold_boot_rst && IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)) {
+		/* Manage the MCU_BOOT using SMC call */
+		err = stm32_rproc_get_syscon(np, "st,syscfg-tz", &tz);
+		if (!err) {
+			err = regmap_read(tz.map, tz.reg, &tzen);
+			if (err) {
+				dev_err(dev, "failed to read tzen\n");
+				return err;
+			}
+			ddata->hold_boot_smc = tzen & tz.mask;
+		}
 	}
-	ddata->secured_soc = tzen & tz.mask;
 
-	err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
-				     &ddata->hold_boot);
-	if (err) {
-		dev_err(dev, "failed to get hold boot\n");
-		return err;
+	if (!ddata->hold_boot_rst && !ddata->hold_boot_smc) {
+		/* Default: hold boot manage it through the syscon controller */
+		err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
+					     &ddata->hold_boot);
+		if (err) {
+			dev_err(dev, "failed to get hold boot\n");
+			return err;
+		}
 	}
 
 	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
-- 
2.25.1

