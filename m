Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D207313F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbjFOJcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbjFOJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:32:38 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5326B0;
        Thu, 15 Jun 2023 02:32:37 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8I2F3009956;
        Thu, 15 Jun 2023 11:32:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Xy/hUYzK/4Hs4UPMJUFskvFcKLM1GyUKIZn77IV+Fes=;
 b=ykj2xVGd4l8SPjOC+WaEsyn1vfQMeJB19nja7j0WMoq7jGqLyuTksVeSG1ypwhQ7oWbj
 qdqRfPA/+c69YhcQSIiZss7N5gdsd2LRwaPwCf3S0NsBabQCZB1DW652Ne/wrKke5vPc
 0ypd32toBFM/zNCbKNuW+BCS3Rg9WG2DirmEDhKoXq/4hQ2r7/fH//5/YJaDJBDB0nbs
 Qm7CNUebjRIch7m1yqK6MQVEV6CvmHJrAZtnPzQZLE6sVqkKnd+n11y8fsuJGXR9lZ5G
 Dqd0JRs+nBQD3fWx4ydRRCxFE1yPK0Uex8nlR/bSzh2cVQGkIeOv+bIKFvVhwZgJVmV8 eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7s1maxs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:32:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 004F810002A;
        Thu, 15 Jun 2023 11:32:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EBF8721A91B;
        Thu, 15 Jun 2023 11:32:23 +0200 (CEST)
Received: from localhost (10.252.8.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 11:32:23 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 3/7] rtc: stm32: improve rtc precision
Date:   Thu, 15 Jun 2023 11:27:49 +0200
Message-ID: <20230615092753.323844-4-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615092753.323844-1-valentin.caron@foss.st.com>
References: <20230615092753.323844-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.8.64]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Guibout <christophe.guibout@foss.st.com>

The rtc is used to update the stgen counter on wake up from
low power modes, so it needs to be as much accurate as possible.

The maximization of asynchronous divider leads to a 4ms rtc
precision clock.
By decreasing pred_a to 0, it will have pred_s=32767 (when
need_accuracy is true), so stgen clock becomes more accurate
with 30us precision.
Nevertheless this will leads to an increase of power consumption.

Signed-off-by: Christophe Guibout <christophe.guibout@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/rtc/rtc-stm32.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index bd7a59a07537..cad88668bcfb 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -114,6 +114,7 @@ struct stm32_rtc_data {
 	void (*clear_events)(struct stm32_rtc *rtc, unsigned int flags);
 	bool has_pclk;
 	bool need_dbp;
+	bool need_accuracy;
 };
 
 struct stm32_rtc {
@@ -545,6 +546,7 @@ static void stm32_rtc_clear_events(struct stm32_rtc *rtc,
 static const struct stm32_rtc_data stm32_rtc_data = {
 	.has_pclk = false,
 	.need_dbp = true,
+	.need_accuracy = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -566,6 +568,7 @@ static const struct stm32_rtc_data stm32_rtc_data = {
 static const struct stm32_rtc_data stm32h7_rtc_data = {
 	.has_pclk = true,
 	.need_dbp = true,
+	.need_accuracy = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -596,6 +599,7 @@ static void stm32mp1_rtc_clear_events(struct stm32_rtc *rtc,
 static const struct stm32_rtc_data stm32mp1_data = {
 	.has_pclk = true,
 	.need_dbp = false,
+	.need_accuracy = true,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -636,11 +640,25 @@ static int stm32_rtc_init(struct platform_device *pdev,
 	pred_a_max = STM32_RTC_PRER_PRED_A >> STM32_RTC_PRER_PRED_A_SHIFT;
 	pred_s_max = STM32_RTC_PRER_PRED_S >> STM32_RTC_PRER_PRED_S_SHIFT;
 
-	for (pred_a = pred_a_max; pred_a + 1 > 0; pred_a--) {
-		pred_s = (rate / (pred_a + 1)) - 1;
+	if (rate > (pred_a_max + 1) * (pred_s_max + 1)) {
+		dev_err(&pdev->dev, "rtc_ck rate is too high: %dHz\n", rate);
+		return -EINVAL;
+	}
+
+	if (rtc->data->need_accuracy) {
+		for (pred_a = 0; pred_a <= pred_a_max; pred_a++) {
+			pred_s = (rate / (pred_a + 1)) - 1;
 
-		if (((pred_s + 1) * (pred_a + 1)) == rate)
-			break;
+			if (pred_s <= pred_s_max && ((pred_s + 1) * (pred_a + 1)) == rate)
+				break;
+		}
+	} else {
+		for (pred_a = pred_a_max; pred_a + 1 > 0; pred_a--) {
+			pred_s = (rate / (pred_a + 1)) - 1;
+
+			if (((pred_s + 1) * (pred_a + 1)) == rate)
+				break;
+		}
 	}
 
 	/*
-- 
2.25.1

