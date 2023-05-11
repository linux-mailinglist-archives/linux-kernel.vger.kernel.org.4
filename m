Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5699F6FEEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbjEKJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjEKJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:35:35 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 02:35:31 PDT
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D71A8A47;
        Thu, 11 May 2023 02:35:30 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 1D35E720163;
        Thu, 11 May 2023 11:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1683797104;
        bh=Vap+41/PY6pXzbjKvr9Q+3GpaSZ82N/7BpF/0fTMCj8=;
        h=From:To:CC:Subject:Date:From;
        b=b5Zw/J+gzTB7D2sT7mNE7AoYe2Uk9/Km4o+WPa4OQ3QQT2XYC5mIsJRaAvH5uEuaZ
         FFHkEiViLqdOs/g0FaEHRgYcGcnTAvcJJUa+QG1AN9qFLCF548kFKEez634W9d5Kc3
         7vTG2I3d70yPFy+F/m8n0AtmOCaPox/te72scJ1KbWL60+CYxJQEzMs9d81Co+qpDq
         qYOlaizCvU6WIBGxasuJK11YzANyzQcFW6/Wq8GUVP9U35T37FoZPKePtkDez37iQv
         GQKB37YvMZvVHsV+ZMTII6+NasY8+YKC92zc6X6KpN1iY3Dj4EYVabUlS4mHPEByux
         zKyximx+Zdt+w==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 May 2023 11:25:02 +0200
Received: from localhost.localdomain (172.16.51.5) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Thu, 11 May 2023 11:25:01 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: imx6q: Disable only available frequencies
Date:   Thu, 11 May 2023 11:23:34 +0200
Message-ID: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the example in Documentation/power/opp.rst, an availability check
is present before disabling a specific frequency. If a frequency isn't
available, the warning of a failed disabling of a non-existent
frequency is misleading. Therefore, check the availability of the
frequency in a separate inline function before disabling it.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Cc: linux-kernel@vger.kernel.org (open list)
To: linux-arm-kernel@lists.infradead.org
---
 drivers/cpufreq/imx6q-cpufreq.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 48e1772e98fd..4e2d2bc47aba 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -209,6 +209,21 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
+static inline int disable_freq_if_available(struct device *dev,
+					    unsigned long freq)
+{
+	struct dev_pm_opp *opp;
+	int ret = 0;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
+	if (!IS_ERR(opp)) {
+		dev_pm_opp_put(opp);
+		ret = dev_pm_opp_disable(dev, freq);
+	}
+
+	return ret;
+}
+
 #define OCOTP_CFG3			0x440
 #define OCOTP_CFG3_SPEED_SHIFT		16
 #define OCOTP_CFG3_SPEED_1P2GHZ		0x3
@@ -254,16 +269,16 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
 	val &= 0x3;
 
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
-		if (dev_pm_opp_disable(dev, 996000000))
+		if (disable_freq_if_available(dev, 996000000))
 			dev_warn(dev, "failed to disable 996MHz OPP\n");
 
 	if (of_machine_is_compatible("fsl,imx6q") ||
 	    of_machine_is_compatible("fsl,imx6qp")) {
 		if (val != OCOTP_CFG3_SPEED_852MHZ)
-			if (dev_pm_opp_disable(dev, 852000000))
+			if (disable_freq_if_available(dev, 852000000))
 				dev_warn(dev, "failed to disable 852MHz OPP\n");
 		if (val != OCOTP_CFG3_SPEED_1P2GHZ)
-			if (dev_pm_opp_disable(dev, 1200000000))
+			if (disable_freq_if_available(dev, 1200000000))
 				dev_warn(dev, "failed to disable 1.2GHz OPP\n");
 	}
 
@@ -318,17 +333,17 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 
 	if (of_machine_is_compatible("fsl,imx6ul")) {
 		if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
-			if (dev_pm_opp_disable(dev, 696000000))
+			if (disable_freq_if_available(dev, 696000000))
 				dev_warn(dev, "failed to disable 696MHz OPP\n");
 	}
 
 	if (of_machine_is_compatible("fsl,imx6ull")) {
 		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
-			if (dev_pm_opp_disable(dev, 792000000))
+			if (disable_freq_if_available(dev, 792000000))
 				dev_warn(dev, "failed to disable 792MHz OPP\n");
 
 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
-			if (dev_pm_opp_disable(dev, 900000000))
+			if (disable_freq_if_available(dev, 900000000))
 				dev_warn(dev, "failed to disable 900MHz OPP\n");
 	}
 
-- 
2.11.0

