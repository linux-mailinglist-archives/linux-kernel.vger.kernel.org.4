Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A56745876
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjGCJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGCJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:32:55 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B69518D;
        Mon,  3 Jul 2023 02:32:06 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 3 Jul 2023
 17:32:01 +0800
From:   =Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH 2/3] soc: c3: Add support for power domains controller
Date:   Mon, 3 Jul 2023 17:31:41 +0800
Message-ID: <20230703093142.2028500-3-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add support for C3 Power controller. C3 power control
registers are in secure domain, and should be accessed by SMC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/soc/amlogic/meson-secure-pwrc.c | 28 ++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index 25b4b71df9b8..39ccc8f2e630 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -12,6 +12,7 @@
 #include <linux/pm_domain.h>
 #include <dt-bindings/power/meson-a1-power.h>
 #include <dt-bindings/power/meson-s4-power.h>
+#include <dt-bindings/power/amlogic-c3-power.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/meson/meson_sm.h>
 #include <linux/module.h>
@@ -132,6 +133,22 @@ static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
 	SEC_PD(S4_AUDIO,	0),
 };
 
+static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
+	SEC_PD(C3_NNA,	0),
+	SEC_PD(C3_AUDIO,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_SDIOA,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_EMMC,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_USB_COMB, GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_SDCARD,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_ETH,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_GE2D,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_CVE,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_GDC_WRAP,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_ISP_TOP,		GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_MIPI_ISP_WRAP, GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(C3_VCODEC,	0),
+};
+
 static int meson_secure_pwrc_probe(struct platform_device *pdev)
 {
 	int i;
@@ -179,7 +196,7 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
 	for (i = 0 ; i < match->count ; ++i) {
 		struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
 
-		if (!match->domains[i].index)
+		if (!match->domains[i].name)
 			continue;
 
 		dom->pwrc = pwrc;
@@ -207,6 +224,11 @@ static struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
 	.count = ARRAY_SIZE(s4_pwrc_domains),
 };
 
+static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
+	.domains = c3_pwrc_domains,
+	.count = ARRAY_SIZE(c3_pwrc_domains),
+};
+
 static const struct of_device_id meson_secure_pwrc_match_table[] = {
 	{
 		.compatible = "amlogic,meson-a1-pwrc",
@@ -216,6 +238,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
 		.compatible = "amlogic,meson-s4-pwrc",
 		.data = &meson_secure_s4_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,c3-pwrc",
+		.data = &amlogic_secure_c3_pwrc_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_secure_pwrc_match_table);
-- 
2.37.1

