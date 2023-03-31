Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250546D245A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjCaPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjCaPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:47:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5830F0;
        Fri, 31 Mar 2023 08:47:29 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VDr4QB010311;
        Fri, 31 Mar 2023 17:47:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=eRrWNW+wqxD3/GwUf/qHnZc761vbTu9x3KnHNUXIaMQ=;
 b=cz8ZHWXiFdhsnvsBJYYP/G4lo7Z4lnX8n/kpxRSmUuQUJcKfIUTWOWYndEdBqxFI6ngR
 aAQFOBLD7hVJm6lOx7hznLY1KaMB8YlgaOHFQ94KnBA1z6eSwMsjSHD2B3HvMf05L/mr
 2DQ+Po1KLyJD9Mh4hN2O7ZL4jJvY1fEUlqoCBowSYkjUS21YJlH4oXpiFofLnaVaLxuQ
 mJGFQHStVcU7DytGR3R+zP6ZKSeUN4VsjnYxFZUknahpNqhB0qj+HhNp0FpNfMFnw+mI
 KZCA0hkSqv6EjsSyEkHMnn+wTR20us/uoQie6FzcYsADht6MHx4YWroOiZzK79Rk4hap rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pnw9c24ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 17:47:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8E1A100034;
        Fri, 31 Mar 2023 17:47:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B0CB2222CAD;
        Fri, 31 Mar 2023 17:47:16 +0200 (CEST)
Received: from localhost (10.201.21.178) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 31 Mar
 2023 17:47:16 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH 3/5] remoteproc: stm32: Clean-up the management of the hold boot by SMC call
Date:   Fri, 31 Mar 2023 17:46:49 +0200
Message-ID: <20230331154651.3107173-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two ways to manage the Cortex-M4 hold boot:
- by Linux thanks to a sys config controller
- by the secure context when the hold boot is protected.
Since the introduction of the SCMI server, the use of the SMC call
is deprecated. If the trust zone is activated, the management of the
hold boot must be done by the secure context thanks to a SCMI reset
controller.

This patch cleans-up the code related to the SMC call, replaced by
the SCMI server.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/stm32_rproc.c | 34 ++------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 7d782ed9e589..4be651e734ee 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -5,7 +5,6 @@
  *          Fabien Dessenne <fabien.dessenne@st.com> for STMicroelectronics.
  */
 
-#include <linux/arm-smccc.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -88,7 +87,6 @@ struct stm32_rproc {
 	struct stm32_rproc_mem *rmems;
 	struct stm32_mbox mb[MBOX_NB_MBX];
 	struct workqueue_struct *workqueue;
-	bool secured_soc;
 	void __iomem *rsc_va;
 };
 
@@ -398,20 +396,12 @@ static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
 {
 	struct stm32_rproc *ddata = rproc->priv;
 	struct stm32_syscon hold_boot = ddata->hold_boot;
-	struct arm_smccc_res smc_res;
 	int val, err;
 
 	val = hold ? HOLD_BOOT : RELEASE_BOOT;
 
-	if (IS_ENABLED(CONFIG_HAVE_ARM_SMCCC) && ddata->secured_soc) {
-		arm_smccc_smc(STM32_SMC_RCC, STM32_SMC_REG_WRITE,
-			      hold_boot.reg, val, 0, 0, 0, 0, &smc_res);
-		err = smc_res.a0;
-	} else {
-		err = regmap_update_bits(hold_boot.map, hold_boot.reg,
-					 hold_boot.mask, val);
-	}
-
+	err = regmap_update_bits(hold_boot.map, hold_boot.reg,
+				 hold_boot.mask, val);
 	if (err)
 		dev_err(&rproc->dev, "failed to set hold boot\n");
 
@@ -680,8 +670,6 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct stm32_syscon tz;
-	unsigned int tzen;
 	int err, irq;
 
 	irq = platform_get_irq(pdev, 0);
@@ -710,24 +698,6 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 		return dev_err_probe(dev, PTR_ERR(ddata->rst),
 				     "failed to get mcu_reset\n");
 
-	/*
-	 * if platform is secured the hold boot bit must be written by
-	 * smc call and read normally.
-	 * if not secure the hold boot bit could be read/write normally
-	 */
-	err = stm32_rproc_get_syscon(np, "st,syscfg-tz", &tz);
-	if (err) {
-		dev_err(dev, "failed to get tz syscfg\n");
-		return err;
-	}
-
-	err = regmap_read(tz.map, tz.reg, &tzen);
-	if (err) {
-		dev_err(dev, "failed to read tzen\n");
-		return err;
-	}
-	ddata->secured_soc = tzen & tz.mask;
-
 	err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
 				     &ddata->hold_boot);
 	if (err) {
-- 
2.25.1

