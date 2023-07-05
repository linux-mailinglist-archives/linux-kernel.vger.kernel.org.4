Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002C9748ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjGERoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjGERoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:44:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7FA19B;
        Wed,  5 Jul 2023 10:44:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365ELIu5007738;
        Wed, 5 Jul 2023 19:44:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Xy/hUYzK/4Hs4UPMJUFskvFcKLM1GyUKIZn77IV+Fes=;
 b=vCwbkT5nm6PutN3dXl9Xg3lNmyhsfEQzI1V6KG6psfJ3174Bd5q4ZqZJRtQKck2kQcLk
 SQVJBYMtrbtVbWrigeEVjf63CTsxVbfvpQwqF6/YLGBQft7yBzLLwKeoxRlRZnn9/wRh
 OTHJCJ/j+xyjJTiJcTiXB12mLmZavpSaObJkIah2AY0+D5S2qgTz/E7/hlMFEuz1Bf7L
 g099DFKggv6L1il6DpPjDVGaCHFVqXWtrQAmgEW/t++9q9Mkx55QzozRDOLZ9c9QBozF
 i59B6taLIWgfaTLp1nN5VC1r/j0rHJyaCY0DWZ0JwyTK8muth8IUNYyh6BoBM2Ppju0L DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rna75h6g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:44:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AB51100057;
        Wed,  5 Jul 2023 19:44:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 82F56252250;
        Wed,  5 Jul 2023 19:44:04 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 5 Jul
 2023 19:44:04 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 3/7] rtc: stm32: improve rtc precision
Date:   Wed, 5 Jul 2023 19:43:53 +0200
Message-ID: <20230705174357.353616-4-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230705174357.353616-1-valentin.caron@foss.st.com>
References: <20230705174357.353616-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

