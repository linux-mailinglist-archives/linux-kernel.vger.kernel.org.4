Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3341E7313F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbjFOJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjFOJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:32:38 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E732683;
        Thu, 15 Jun 2023 02:32:36 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8YpBa021622;
        Thu, 15 Jun 2023 11:32:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=3uBLJmxq5VVWC2o5xkCW/MuK8POUJa1lY65SLOrbAlI=;
 b=cVtd5PJjhGLfmF4RwGm+bP1LzN007yc/3l6k9Ad4UD0tlSxgBDnOniSQTPbM9gKQ0mH4
 05m34vL7As4a8I0I4ivY5z3Irgru2n7k9pwnxzztngJD6UgLRHAhPdPDsgYWuCQEc8y4
 ZlCnhZcv5PB5UO3roTqkSyh1TLgbJpsJuSsw0oomyBwU6chgQBGYcpWbLrACPnzgOrr+
 ncMjNT9SXEkhdi7Gt5g3wP0HaRcq7+/ZPNZewLvSgeqTmXPluL1KPNGzI47g/7FRACgF
 QrkKiuwPulr5/0D7x1hVLOk+xhqK56f+Y3xPx/lkpsOOGoXlXHlIpLZDmIjJANToBoLh cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7y8sge46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:32:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E441810002A;
        Thu, 15 Jun 2023 11:32:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCD6421A91B;
        Thu, 15 Jun 2023 11:32:22 +0200 (CEST)
Received: from localhost (10.252.8.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 11:32:22 +0200
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
Subject: [PATCH 2/7] rtc: stm32: don't stop time counter if not needed
Date:   Thu, 15 Jun 2023 11:27:48 +0200
Message-ID: <20230615092753.323844-3-valentin.caron@foss.st.com>
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

From: Antonio Borneo <antonio.borneo@foss.st.com>

RTC counters are stopped when INIT bit in ISR register is set and
start counting from the (eventual) new value when INIT is reset.

In stm32_rtc_init(), called during probe, the INIT bit is set to
program the prescaler and the 24h mode. This halts the RTC counter
at each probe tentative causing the RTC time to loose from 0.3s to
0.8s at each kernel boot.
If the RTC is battery powered, both prescaler value and 24h mode
are kept during power cycle and there is no need to program them
again.

Check if the desired prescaler value and the 24h mode are already
programmed, then skip reprogramming them to avoid halting the time
counter.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/rtc/rtc-stm32.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index abb77ad774a1..bd7a59a07537 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -628,7 +628,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 	const struct stm32_rtc_registers *regs = &rtc->data->regs;
 	unsigned int prer, pred_a, pred_s, pred_a_max, pred_s_max, cr;
 	unsigned int rate;
-	int ret = 0;
+	int ret;
 
 	rate = clk_get_rate(rtc->rtc_ck);
 
@@ -656,6 +656,20 @@ static int stm32_rtc_init(struct platform_device *pdev,
 			 "fast" : "slow");
 	}
 
+	cr = readl_relaxed(rtc->base + regs->cr);
+
+	prer = readl_relaxed(rtc->base + regs->prer);
+	prer &= STM32_RTC_PRER_PRED_S | STM32_RTC_PRER_PRED_A;
+
+	pred_s = (pred_s << STM32_RTC_PRER_PRED_S_SHIFT) &
+		 STM32_RTC_PRER_PRED_S;
+	pred_a = (pred_a << STM32_RTC_PRER_PRED_A_SHIFT) &
+		 STM32_RTC_PRER_PRED_A;
+
+	/* quit if there is nothing to initialize */
+	if ((cr & STM32_RTC_CR_FMT) == 0 && prer == (pred_s | pred_a))
+		return 0;
+
 	stm32_rtc_wpr_unlock(rtc);
 
 	ret = stm32_rtc_enter_init_mode(rtc);
@@ -665,13 +679,10 @@ static int stm32_rtc_init(struct platform_device *pdev,
 		goto end;
 	}
 
-	prer = (pred_s << STM32_RTC_PRER_PRED_S_SHIFT) & STM32_RTC_PRER_PRED_S;
-	writel_relaxed(prer, rtc->base + regs->prer);
-	prer |= (pred_a << STM32_RTC_PRER_PRED_A_SHIFT) & STM32_RTC_PRER_PRED_A;
-	writel_relaxed(prer, rtc->base + regs->prer);
+	writel_relaxed(pred_s, rtc->base + regs->prer);
+	writel_relaxed(pred_a | pred_s, rtc->base + regs->prer);
 
 	/* Force 24h time format */
-	cr = readl_relaxed(rtc->base + regs->cr);
 	cr &= ~STM32_RTC_CR_FMT;
 	writel_relaxed(cr, rtc->base + regs->cr);
 
-- 
2.25.1

