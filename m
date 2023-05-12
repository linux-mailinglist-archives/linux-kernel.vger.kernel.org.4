Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2D700B09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbjELPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbjELPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:09:13 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2D5F5BA5;
        Fri, 12 May 2023 08:09:08 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id D3F8E5E85C;
        Fri, 12 May 2023 17:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1683904108;
        bh=mVNuMFQVfDKbGZ53v1bHBsJOGKRreCNyAVxU+AsY7a0=;
        h=From:To:CC:Subject:Date:From;
        b=LT5l4SC/dNI9XJjlIn9+Lb8w0goX2Fg9z4rIBVsVUGcD3h2xTrAf7kO3Ibo8R8Jvx
         rDrYc55F9xuCUhAQg7aM85SjWQ5b4DsCAoqUU14dD8E95viwM25XssHTuaB6PWWkcs
         jgz8LS0F0Z87Ip/S8AhOZzDBYgbtXfJXd+aaGoV0knlbvY+NtF7Ghes+jFPvh4BJ6l
         CFhRr5jcVqc1NosImLvzq0DLVdLYOtGZYx+9hudiGIpJVdPuDgZmqcZ9ubkvao7PTq
         bsrE7PLnt4ED7OvGNpZvneY2aCUdTo0ixMhW8M4xPMlmvppJj5io6rQuCZ+kcTB+KI
         JxAds+/O99l/g==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 17:08:25 +0200
Received: from localhost.localdomain (172.16.51.5) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 17:08:24 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] cpufreq: imx6q: No warning output when disabling a non-existing frequency of the OPP
Date:   Fri, 12 May 2023 17:07:11 +0200
Message-ID: <20230512150711.106854-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is confusing if a warning is given for disabling a non-existent
frequency of the operating performance points (OPP). In this case
the function dev_pm_opp_disable() returns -ENODEV. Check the return
value and avoid the output of a warning in this case. Avoid code
duplication by using a separate function.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/cpufreq/imx6q-cpufreq.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 48e1772e98fd..9fb1501033bb 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -209,6 +209,14 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
+static void imx6x_disable_freq_in_opp(struct device *dev, unsigned long freq)
+{
+	int ret = dev_pm_opp_disable(dev, freq);
+
+	if (ret < 0 && ret != -ENODEV)
+		dev_warn(dev, "failed to disable %ldMHz OPP\n", freq / 1000000);
+}
+
 #define OCOTP_CFG3			0x440
 #define OCOTP_CFG3_SPEED_SHIFT		16
 #define OCOTP_CFG3_SPEED_1P2GHZ		0x3
@@ -254,17 +262,15 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
 	val &= 0x3;
 
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
-		if (dev_pm_opp_disable(dev, 996000000))
-			dev_warn(dev, "failed to disable 996MHz OPP\n");
+		imx6x_disable_freq_in_opp(dev, 996000000);
 
 	if (of_machine_is_compatible("fsl,imx6q") ||
 	    of_machine_is_compatible("fsl,imx6qp")) {
 		if (val != OCOTP_CFG3_SPEED_852MHZ)
-			if (dev_pm_opp_disable(dev, 852000000))
-				dev_warn(dev, "failed to disable 852MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 852000000);
+
 		if (val != OCOTP_CFG3_SPEED_1P2GHZ)
-			if (dev_pm_opp_disable(dev, 1200000000))
-				dev_warn(dev, "failed to disable 1.2GHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 1200000000);
 	}
 
 	return 0;
@@ -316,20 +322,16 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
-	if (of_machine_is_compatible("fsl,imx6ul")) {
+	if (of_machine_is_compatible("fsl,imx6ul"))
 		if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
-			if (dev_pm_opp_disable(dev, 696000000))
-				dev_warn(dev, "failed to disable 696MHz OPP\n");
-	}
+			imx6x_disable_freq_in_opp(dev, 696000000);
 
 	if (of_machine_is_compatible("fsl,imx6ull")) {
 		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
-			if (dev_pm_opp_disable(dev, 792000000))
-				dev_warn(dev, "failed to disable 792MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 792000000);
 
 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
-			if (dev_pm_opp_disable(dev, 900000000))
-				dev_warn(dev, "failed to disable 900MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 900000000);
 	}
 
 	return ret;
-- 
2.11.0

