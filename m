Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4C690E10
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBIQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBIQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:12:05 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54992749F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:12:01 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:eeed:e695:5a2f:fc6d])
        by albert.telenet-ops.be with bizsmtp
        id K4Bw2900Q4vi5L7064BwSr; Thu, 09 Feb 2023 17:11:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pQ9WM-008RDm-Fm;
        Thu, 09 Feb 2023 17:11:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pQ9We-007aVD-Jh;
        Thu, 09 Feb 2023 17:11:56 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] thermal/drivers/rcar_gen3: Add support for R-Car V4H
Date:   Thu,  9 Feb 2023 17:11:54 +0100
Message-Id: <852048eb5f4cc001be7a97744f4c5caea912d071.1675958665.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1675958665.git.geert+renesas@glider.be>
References: <cover.1675958665.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Thermal Sensor/Chip Internal Voltage Monitor/Core
Voltage Monitor (THS/CIVM/CVM) on the Renesas R-Car V4H (R8A779G0) SoC.

According to the R-Car V4H Hardware User's Manual Rev. 0.70, the
(preliminary) conversion formula for the thermal sensor is the same as
for most other R-Car Gen3 and Gen4 SoCs, while the (preliminary)
conversion formula for the chip internal voltage monitor differs.
As the driver only uses the former, no further changes are needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 4ef927437842af74..04245393e78d02c5 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -403,6 +403,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 		.compatible = "renesas,r8a779f0-thermal",
 		.data = &rcar_gen3_ths_tj_1,
 	},
+	{
+		.compatible = "renesas,r8a779g0-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
-- 
2.34.1

