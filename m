Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF89613C92
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiJaRvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiJaRvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:51:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1C63BA;
        Mon, 31 Oct 2022 10:51:09 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-157-181.ewe-ip-backbone.de [95.33.157.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8817B6602948;
        Mon, 31 Oct 2022 17:51:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667238663;
        bh=kGeCW1YTwGhNttEL0JAP5rbTFVI1UH3AbwhQ1VzHwhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwSB0Vi3Lb7nP++iI7kmLX9IXeF6EV96YGvhOgFlyjostnFF9O5UvudkathyoVGND
         SPrk/qjwdnYvvBIThFino+OiEGBADYgwxoQVajMf8omGdWS6wWfKuuDdCIq9+fCkvE
         PsGjpcwVSNRWHjIlyTkPIXGgfnB9Fjg8oIFa4+2/Z0xe5M62ayZYHIa3AKI/btVlri
         IBuhp5kMLvNfbhde3lLuunzXrxKmpgh0ezM2UyKP7BYGSSAJEHTWXvFba1Id5u7P6Q
         RAUOQ/YT0ctizL/yP4b7NCbK17hpIh1tpkl5AGazB8/RZc3gh06NvIn1xllZckkoBG
         IfX8WAPKDOqng==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 5529F4801D1; Mon, 31 Oct 2022 18:50:59 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 5/7] thermal: rockchip: Support dynamic sized sensor array
Date:   Mon, 31 Oct 2022 18:50:56 +0100
Message-Id: <20221031175058.175698-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221031175058.175698-1-sebastian.reichel@collabora.com>
References: <20221031175058.175698-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamically allocate the sensors array based on the amount
of platform sensors in preparation for rk3588 support, which
needs 7 sensors.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index a547e44e2b64..c9d04b58a1e5 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -51,12 +51,6 @@ enum adc_sort_mode {
 
 #include "thermal_hwmon.h"
 
-/**
- * The max sensors is two in rockchip SoCs.
- * Two sensors: CPU and GPU sensor.
- */
-#define SOC_MAX_SENSORS	2
-
 /**
  * struct chip_tsadc_table - hold information about chip-specific differences
  * @id: conversion table
@@ -147,7 +141,7 @@ struct rockchip_thermal_data {
 	struct platform_device *pdev;
 	struct reset_control *reset;
 
-	struct rockchip_thermal_sensor sensors[SOC_MAX_SENSORS];
+	struct rockchip_thermal_sensor *sensors;
 
 	struct clk *clk;
 	struct clk *pclk;
@@ -1367,6 +1361,11 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (!thermal->chip)
 		return -EINVAL;
 
+	thermal->sensors = devm_kcalloc(&pdev->dev, thermal->chip->chn_num,
+					sizeof(*thermal->sensors), GFP_KERNEL);
+	if (!thermal->sensors)
+		return -ENOMEM;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	thermal->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(thermal->regs))
-- 
2.35.1

