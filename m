Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8667313F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245506AbjFOJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244971AbjFOJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:32:39 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6226B6;
        Thu, 15 Jun 2023 02:32:38 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8I2F5009956;
        Thu, 15 Jun 2023 11:32:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=MXa5UGOKwnuvRKspTklCvl9TbHyucJqEV4w5bCIDszM=;
 b=waacJ3UCN+Myd982zuzVHXWxobMlJZWjDYRvNtKru0DTY2sPGXUmXeADKwohP8wLFljV
 37I6Gg6EGilpEjVD7Wb0oXbCEXM5KTyzmd0j54S7L84cs8V3n+Bp3acQ4sSVj+pEgUwO
 UVcvC8wZJH0H670tumVZ9FRQ8O9F2DQF1KYisADg/ix5CsIwoOZFiV3qyuN26ryPm1iy
 h014RaO/gc4DoWyW/4ZbJCbf6+yrjPw66Z4Iv60moeRMnvsCD5hGZkKGRJfylDNGMCMZ
 aYLug9v5joCeMUoTtZx66XixwYtBR3ScZuaGm1UAFl/407Zf/eU446M2hf0a0dA4HIce eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7s1maxsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:32:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2EABC100046;
        Thu, 15 Jun 2023 11:32:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C51821A91B;
        Thu, 15 Jun 2023 11:32:25 +0200 (CEST)
Received: from localhost (10.252.8.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 11:32:24 +0200
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
Subject: [PATCH 4/7] rtc: stm32: don't print an error on probe deferral
Date:   Thu, 15 Jun 2023 11:27:50 +0200
Message-ID: <20230615092753.323844-5-valentin.caron@foss.st.com>
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

Change stm32-rtc driver to not generate an error message when
device probe operation is deferred for a clock.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/rtc/rtc-stm32.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index cad88668bcfb..5ebf0b8e75f9 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -6,6 +6,7 @@
 
 #include <linux/bcd.h>
 #include <linux/clk.h>
+#include <linux/errno.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/mfd/syscon.h>
@@ -759,16 +760,13 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		rtc->rtc_ck = devm_clk_get(&pdev->dev, NULL);
 	} else {
 		rtc->pclk = devm_clk_get(&pdev->dev, "pclk");
-		if (IS_ERR(rtc->pclk)) {
-			dev_err(&pdev->dev, "no pclk clock");
-			return PTR_ERR(rtc->pclk);
-		}
+		if (IS_ERR(rtc->pclk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rtc->pclk), "no pclk clock");
+
 		rtc->rtc_ck = devm_clk_get(&pdev->dev, "rtc_ck");
 	}
-	if (IS_ERR(rtc->rtc_ck)) {
-		dev_err(&pdev->dev, "no rtc_ck clock");
-		return PTR_ERR(rtc->rtc_ck);
-	}
+	if (IS_ERR(rtc->rtc_ck))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_ck), "no rtc_ck clock");
 
 	if (rtc->data->has_pclk) {
 		ret = clk_prepare_enable(rtc->pclk);
-- 
2.25.1

