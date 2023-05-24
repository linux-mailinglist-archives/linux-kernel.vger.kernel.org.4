Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9492170F100
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbjEXIdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEXIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:32:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA38E198
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:32:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juY-0002lD-UF; Wed, 24 May 2023 10:31:58 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juY-002RZc-0T; Wed, 24 May 2023 10:31:58 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juW-009j9f-JA; Wed, 24 May 2023 10:31:56 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 10/25] PM / devfreq: rockchip-dfi: Add RK3568 support
Date:   Wed, 24 May 2023 10:31:38 +0200
Message-Id: <20230524083153.2046084-11-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524083153.2046084-1-s.hauer@pengutronix.de>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds RK3568 support to the DFI driver.  Only iniitialization
differs from the currently supported RK3399.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 21 +++++++++++++++++++++
 include/soc/rockchip/rk3568_grf.h    | 12 ++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 include/soc/rockchip/rk3568_grf.h

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 6b3ef97b3be09..261d112580c9e 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -23,6 +23,7 @@
 
 #include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
+#include <soc/rockchip/rk3568_grf.h>
 
 #define DMC_MAX_CHANNELS	2
 
@@ -209,10 +210,30 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	return 0;
 };
 
+static int rk3568_dfi_init(struct rockchip_dfi *dfi)
+{
+	struct regmap *regmap_pmu = dfi->regmap_pmu;
+	u32 reg2, reg3;
+
+	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG2, &reg2);
+	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG3, &reg3);
+
+	dfi->ddr_type = FIELD_GET(RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO, reg2);
+
+	if (FIELD_GET(RK3568_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >= 0x3)
+		dfi->ddr_type |= FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, reg3) << 3;
+
+	dfi->channel_mask = 1;
+
+	return 0;
+};
+
 static const struct of_device_id rockchip_dfi_id_match[] = {
 	{ .compatible = "rockchip,rk3399-dfi", .data = rk3399_dfi_init },
+	{ .compatible = "rockchip,rk3568-dfi", .data = rk3568_dfi_init },
 	{ },
 };
+
 MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
 
 static int rockchip_dfi_probe(struct platform_device *pdev)
diff --git a/include/soc/rockchip/rk3568_grf.h b/include/soc/rockchip/rk3568_grf.h
new file mode 100644
index 0000000000000..575584e9d8834
--- /dev/null
+++ b/include/soc/rockchip/rk3568_grf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __SOC_RK3568_GRF_H
+#define __SOC_RK3568_GRF_H
+
+#define RK3568_PMUGRF_OS_REG2		0x208
+#define RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
+
+#define RK3568_PMUGRF_OS_REG3		0x20c
+#define RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
+#define RK3568_PMUGRF_OS_REG3_SYSREG_VERSION		GENMASK(31, 28)
+
+#endif /* __SOC_RK3568_GRF_H */
-- 
2.39.2

