Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DAB74A830
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGGAiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGGAiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:38:06 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942F19BD;
        Thu,  6 Jul 2023 17:37:19 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 7 Jul 2023
 08:37:09 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH V2 3/4] soc: c3: Add support for power domains controller
Date:   Fri, 7 Jul 2023 08:37:09 +0800
Message-ID: <20230707003710.2667989-4-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
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

Add support for C3 Power controller. C3 power control
registers are in secure domain, and should be accessed by SMC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
V1 -> V2: Fixed some formatting.
---
 drivers/soc/amlogic/meson-secure-pwrc.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index c11d65a3e3d9..a1ffebf70de3 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <dt-bindings/power/meson-a1-power.h>
+#include <dt-bindings/power/amlogic,c3-pwrc.h>
 #include <dt-bindings/power/meson-s4-power.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/meson/meson_sm.h>
@@ -120,6 +121,22 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(RSA,	0),
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
 static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
 	SEC_PD(S4_DOS_HEVC,	0),
 	SEC_PD(S4_DOS_VDEC,	0),
@@ -202,6 +219,11 @@ static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
 	.count = ARRAY_SIZE(a1_pwrc_domains),
 };
 
+static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
+	.domains = c3_pwrc_domains,
+	.count = ARRAY_SIZE(c3_pwrc_domains),
+};
+
 static struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
 	.domains = s4_pwrc_domains,
 	.count = ARRAY_SIZE(s4_pwrc_domains),
@@ -212,6 +234,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
 		.compatible = "amlogic,meson-a1-pwrc",
 		.data = &meson_secure_a1_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,c3-pwrc",
+		.data = &amlogic_secure_c3_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,meson-s4-pwrc",
 		.data = &meson_secure_s4_pwrc_data,
-- 
2.37.1

