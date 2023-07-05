Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA07748AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjGERoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjGERoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:44:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B0E57;
        Wed,  5 Jul 2023 10:44:10 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Fabec003081;
        Wed, 5 Jul 2023 19:44:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=tu9jBOtEovYr093HJ36dUdSrKpaYVFSBiOffzxwZiQY=;
 b=3GOJyEli9IvgD3M88EkpF0MMjrEkw4HGaWwL4OUHbyi+OH2NqSuORREOgNbrdadE/4g+
 XZeVV5Z9psiKK3QVP3LsaNNll/aukga2b8KRLPnEgB9VneRS3eoIXvsznYPvW/R3zvI/
 J0tf0piMa3rjTk6dx6L9Kcg774vzTEkFw2znLbi7u8zd3nw1gBk2QYYp3Mq12/8ZtREQ
 JWI+dtHXAd8cgfcUX9RH+0oEtXwtz+FHDRppJbng6tVgQg2UVBQnrm8ecEGlB2S5ODRZ
 0WFXYVP7k0pyamIIjF3WBNrayz4QuoIzq3uY9SPrrSR3BEbkXxSiuSEF1M2NQ5BQdlyh Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rn8c9t4wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:44:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68E55100057;
        Wed,  5 Jul 2023 19:44:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F856252250;
        Wed,  5 Jul 2023 19:44:03 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 5 Jul
 2023 19:44:03 +0200
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
Subject: [PATCH v2 1/7] rtc: stm32: use the proper register sequence to read date/time
Date:   Wed, 5 Jul 2023 19:43:51 +0200
Message-ID: <20230705174357.353616-2-valentin.caron@foss.st.com>
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

From: Antonio Borneo <antonio.borneo@foss.st.com>

Date and time are read from two separate RTC registers.
To ensure consistency between the two registers, reading the time
register locks the values in the shadow date register until the
date register is read.
Thus, the whole date/time read requires reading the time register
first, followed by reading the date register.
If the reads are done in reversed order, the shadow date register
will remain locked until a future read operation. The future read
will read the former date value that could be already invalid.

Fix the read order of date/time registers in stm32_rtc_valid_alrm()

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/rtc/rtc-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 3d36e11cff80..abb77ad774a1 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -429,8 +429,8 @@ static int stm32_rtc_valid_alrm(struct stm32_rtc *rtc, struct rtc_time *tm)
 {
 	const struct stm32_rtc_registers *regs = &rtc->data->regs;
 	int cur_day, cur_mon, cur_year, cur_hour, cur_min, cur_sec;
-	unsigned int dr = readl_relaxed(rtc->base + regs->dr);
 	unsigned int tr = readl_relaxed(rtc->base + regs->tr);
+	unsigned int dr = readl_relaxed(rtc->base + regs->dr);
 
 	cur_day = (dr & STM32_RTC_DR_DATE) >> STM32_RTC_DR_DATE_SHIFT;
 	cur_mon = (dr & STM32_RTC_DR_MONTH) >> STM32_RTC_DR_MONTH_SHIFT;
-- 
2.25.1

