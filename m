Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B74717FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjEaM1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjEaM1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:27:51 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0510F;
        Wed, 31 May 2023 05:27:49 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VCJ43R010603;
        Wed, 31 May 2023 14:27:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=h7L5j+RUM3hQ2mgGUZnVH7FJKV90A51gfQKR4MF9lFk=;
 b=sPP6nP4UaqPo/lkWbNS+0p/cmLiyBKEooMxSguV/7ivMg2GXexyS3K6WOu92iJQeDSYN
 6ZkFLb+lt5y8VdcNnQVcB19PtXhBH7W+jmFOViY4LOzRMEOJPQDYVso6sXwYOwG4UF3i
 EJL22blZDCLwAXBYxArP1Waf4dxdaNy/2oIwz4eQbuQAOs+H0A6gyhFynk4yMIVnHo5A
 9O8EKlk4e7nM5/Nsz2iaZ46NXMmnD8mMbBxfkvCiT/N1WhDx5ibB1/as4yZedB0fRsTi
 7Z0lWx/nF/djt1/AnMGyGuZwcWq6mAf6qyHnMQEzaHJHcSq4rM84SCc9yMQFxAXILnkT Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qx314sh8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:27:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ABB8C10002A;
        Wed, 31 May 2023 14:27:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A21E6233C97;
        Wed, 31 May 2023 14:27:32 +0200 (CEST)
Received: from localhost (10.252.9.126) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 31 May
 2023 14:27:32 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: stm32: remove dedicated wakeup management
Date:   Wed, 31 May 2023 14:27:31 +0200
Message-ID: <20230531122732.1515594-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.9.126]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Torgue <alexandre.torgue@foss.st.com>

There is no more needs to use a dedicated wake up interrupt for RTC as
EXTI block manages by itself now all interrupt lines.

Dedicated wakeup interrupt has been introduced with STM32 MP1 support
commit b72252b6580c ("rtc: stm32: add stm32mp1 rtc support") because GIC &
EXTI interrupts were not yet linked in EXTI driver.

Removing this interrupt won't break compatibility with device trees which
do use two interrupts entries: it could only prevent wakeup from low power
modes on STM32MP1x, but platform power management is not yet available.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/rtc/rtc-stm32.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 229cb2847cc4..3d36e11cff80 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -114,7 +114,6 @@ struct stm32_rtc_data {
 	void (*clear_events)(struct stm32_rtc *rtc, unsigned int flags);
 	bool has_pclk;
 	bool need_dbp;
-	bool has_wakeirq;
 };
 
 struct stm32_rtc {
@@ -127,7 +126,6 @@ struct stm32_rtc {
 	struct clk *rtc_ck;
 	const struct stm32_rtc_data *data;
 	int irq_alarm;
-	int wakeirq_alarm;
 };
 
 static void stm32_rtc_wpr_unlock(struct stm32_rtc *rtc)
@@ -547,7 +545,6 @@ static void stm32_rtc_clear_events(struct stm32_rtc *rtc,
 static const struct stm32_rtc_data stm32_rtc_data = {
 	.has_pclk = false,
 	.need_dbp = true,
-	.has_wakeirq = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -569,7 +566,6 @@ static const struct stm32_rtc_data stm32_rtc_data = {
 static const struct stm32_rtc_data stm32h7_rtc_data = {
 	.has_pclk = true,
 	.need_dbp = true,
-	.has_wakeirq = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -600,7 +596,6 @@ static void stm32mp1_rtc_clear_events(struct stm32_rtc *rtc,
 static const struct stm32_rtc_data stm32mp1_data = {
 	.has_pclk = true,
 	.need_dbp = false,
-	.has_wakeirq = true,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -779,19 +774,12 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = device_init_wakeup(&pdev->dev, true);
-	if (rtc->data->has_wakeirq) {
-		rtc->wakeirq_alarm = platform_get_irq(pdev, 1);
-		if (rtc->wakeirq_alarm > 0) {
-			ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
-							    rtc->wakeirq_alarm);
-		} else {
-			ret = rtc->wakeirq_alarm;
-			if (rtc->wakeirq_alarm == -EPROBE_DEFER)
-				goto err;
-		}
-	}
 	if (ret)
-		dev_warn(&pdev->dev, "alarm can't wake up the system: %d", ret);
+		goto err;
+
+	ret = dev_pm_set_wake_irq(&pdev->dev, rtc->irq_alarm);
+	if (ret)
+		goto err;
 
 	platform_set_drvdata(pdev, rtc);
 
@@ -879,9 +867,6 @@ static int stm32_rtc_suspend(struct device *dev)
 	if (rtc->data->has_pclk)
 		clk_disable_unprepare(rtc->pclk);
 
-	if (device_may_wakeup(dev))
-		return enable_irq_wake(rtc->irq_alarm);
-
 	return 0;
 }
 
@@ -903,9 +888,6 @@ static int stm32_rtc_resume(struct device *dev)
 		return ret;
 	}
 
-	if (device_may_wakeup(dev))
-		return disable_irq_wake(rtc->irq_alarm);
-
 	return ret;
 }
 #endif
-- 
2.25.1

