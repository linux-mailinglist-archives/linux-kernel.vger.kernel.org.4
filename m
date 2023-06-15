Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09D731401
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245592AbjFOJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbjFOJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:33:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1773E2700;
        Thu, 15 Jun 2023 02:33:35 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F7x49D022782;
        Thu, 15 Jun 2023 11:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=KGfRr9Mz7eZ6U4XP0pLjyw89b0Du0XVaJReLW6qPtx4=;
 b=mk1/mPY1HSWhbRxWPlj0lTUPngKYGkwjV+MHtygtAP72leBZV5yWBpCgtF42uyOA99NO
 Pg80w7pNf07wrmHKvJYwyN7aShRqOul+nnxW4oVQMegg1tM+xo7Eu5sNt5LYIA17/3I4
 6/19sf61NegZvoesTiMRFCNETwlris7UuM2dhi5m15gPqjJPxjyBykLiujn/4aku4JI7
 bu5P/dywewnsrG0lyzNsndqrs/TX+A6WyYvv07p65ZQD+gUBliNFmUmFgsb4hqdn/qc8
 +LVJIMB9V1+dH5nVUuLdOg0wMVm0OyDNhsylkPsdh4SYzKaTkK46Qb2ExchfsD3MoJ6l PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7vkfst7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:33:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 610F110002A;
        Thu, 15 Jun 2023 11:33:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 59AC221A91B;
        Thu, 15 Jun 2023 11:33:28 +0200 (CEST)
Received: from localhost (10.252.8.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 11:33:27 +0200
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
Subject: [PATCH 7/7] rtc: stm32: fix issues of stm32_rtc_valid_alrm function
Date:   Thu, 15 Jun 2023 11:27:53 +0200
Message-ID: <20230615092753.323844-8-valentin.caron@foss.st.com>
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

stm32_rtc_valid_alrm function has some issues :
- arithmetical operations are impossible on BCD values
- "cur_mon + 1" can overflow
- the use case with the next month, the same day/hour/minutes went wrong

To solve that, we prefer to use timestamp comparison.
e.g. : On 5 Dec. 2021, the alarm limit is 5 Jan. 2022 (+31 days)
       On 31 Jan 2021, the alarm limit is 28 Feb. 2022 (+28 days)

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/rtc/rtc-stm32.c | 61 ++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 30c5004d6902..85689192fa7a 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -90,6 +90,9 @@
 /* Max STM32 RTC register offset is 0x3FC */
 #define UNDEF_REG			0xFFFF
 
+/* STM32 RTC driver time helpers */
+#define SEC_PER_DAY		(24 * 60 * 60)
+
 struct stm32_rtc;
 
 struct stm32_rtc_registers {
@@ -426,40 +429,42 @@ static int stm32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return 0;
 }
 
-static int stm32_rtc_valid_alrm(struct stm32_rtc *rtc, struct rtc_time *tm)
+static int stm32_rtc_valid_alrm(struct device *dev, struct rtc_time *tm)
 {
-	const struct stm32_rtc_registers *regs = &rtc->data->regs;
-	int cur_day, cur_mon, cur_year, cur_hour, cur_min, cur_sec;
-	unsigned int tr = readl_relaxed(rtc->base + regs->tr);
-	unsigned int dr = readl_relaxed(rtc->base + regs->dr);
-
-	cur_day = (dr & STM32_RTC_DR_DATE) >> STM32_RTC_DR_DATE_SHIFT;
-	cur_mon = (dr & STM32_RTC_DR_MONTH) >> STM32_RTC_DR_MONTH_SHIFT;
-	cur_year = (dr & STM32_RTC_DR_YEAR) >> STM32_RTC_DR_YEAR_SHIFT;
-	cur_sec = (tr & STM32_RTC_TR_SEC) >> STM32_RTC_TR_SEC_SHIFT;
-	cur_min = (tr & STM32_RTC_TR_MIN) >> STM32_RTC_TR_MIN_SHIFT;
-	cur_hour = (tr & STM32_RTC_TR_HOUR) >> STM32_RTC_TR_HOUR_SHIFT;
+	static struct rtc_time now;
+	time64_t max_alarm_time64;
+	int max_day_forward;
+	int next_month;
+	int next_year;
 
 	/*
 	 * Assuming current date is M-D-Y H:M:S.
 	 * RTC alarm can't be set on a specific month and year.
 	 * So the valid alarm range is:
 	 *	M-D-Y H:M:S < alarm <= (M+1)-D-Y H:M:S
-	 * with a specific case for December...
 	 */
-	if (((tm->tm_year > cur_year &&
-	      tm->tm_mon == 0x1 && cur_mon == 0x12) ||
-	     (tm->tm_year == cur_year &&
-	      tm->tm_mon <= cur_mon + 1)) &&
-	    (tm->tm_mday > cur_day ||
-	     (tm->tm_mday == cur_day &&
-	     (tm->tm_hour > cur_hour ||
-	      (tm->tm_hour == cur_hour && tm->tm_min > cur_min) ||
-	      (tm->tm_hour == cur_hour && tm->tm_min == cur_min &&
-	       tm->tm_sec >= cur_sec)))))
-		return 0;
+	stm32_rtc_read_time(dev, &now);
+
+	/*
+	 * Find the next month and the year of the next month.
+	 * Note: tm_mon and next_month are from 0 to 11
+	 */
+	next_month = now.tm_mon + 1;
+	if (next_month == 12) {
+		next_month = 0;
+		next_year = now.tm_year + 1;
+	} else {
+		next_year = now.tm_year;
+	}
 
-	return -EINVAL;
+	/* Find the maximum limit of alarm in days. */
+	max_day_forward = rtc_month_days(now.tm_mon, now.tm_year)
+			 - now.tm_mday
+			 + min(rtc_month_days(next_month, next_year), now.tm_mday);
+
+	/* Convert to timestamp and compare the alarm time and its upper limit */
+	max_alarm_time64 = rtc_tm_to_time64(&now) + max_day_forward * SEC_PER_DAY;
+	return rtc_tm_to_time64(tm) <= max_alarm_time64 ? 0 : -EINVAL;
 }
 
 static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -470,17 +475,17 @@ static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	unsigned int cr, isr, alrmar;
 	int ret = 0;
 
-	tm2bcd(tm);
-
 	/*
 	 * RTC alarm can't be set on a specific date, unless this date is
 	 * up to the same day of month next month.
 	 */
-	if (stm32_rtc_valid_alrm(rtc, tm) < 0) {
+	if (stm32_rtc_valid_alrm(dev, tm) < 0) {
 		dev_err(dev, "Alarm can be set only on upcoming month.\n");
 		return -EINVAL;
 	}
 
+	tm2bcd(tm);
+
 	alrmar = 0;
 	/* tm_year and tm_mon are not used because not supported by RTC */
 	alrmar |= (tm->tm_mday << STM32_RTC_ALRMXR_DATE_SHIFT) &
-- 
2.25.1

