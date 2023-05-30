Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BDC715E67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjE3ME1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjE3MEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:04:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29554D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:04:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4s-0000DJ-M5; Tue, 30 May 2023 14:03:50 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4r-003rWx-T2; Tue, 30 May 2023 14:03:49 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4o-00C3vL-QF; Tue, 30 May 2023 14:03:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 07/15] ARM: dts: imx6dl: Add trip points to thermal zones on several devices
Date:   Tue, 30 May 2023 14:03:37 +0200
Message-Id: <20230530120345.2874900-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530120345.2874900-1-o.rempel@pengutronix.de>
References: <20230530120345.2874900-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
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

Kernel v6.3-rc1 prints errors due to missing trip points in thermal
zones. These errors indicate a lack of critical temperature threshold
settings, causing warnings at boot. To silence these errors, this patch
introduces trip points into the thermal zones of several imx6dl based
devices.

The following devices are updated:
- plym2m
- prtvt7
- victgo
- vicut1

These devices are automotive grade and expected to operate up to 105C.
An exception is the plym2m, an industrial grade device, which is
certified to work up to 85C.

The added trip points act as alert thresholds but do not trigger any
actions except warnings. This behavior is by design, as these devices
should maintain their performance until the end, without any thermal
throttling.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-plym2m.dts   | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-prtvt7.dts   | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-victgo.dts   | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi |  8 ++++++++
 4 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
index e3c10483f33b..dfa8110b1d97 100644
--- a/arch/arm/boot/dts/imx6dl-plym2m.dts
+++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
@@ -113,18 +113,42 @@ chassis-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&tsens0>;
+
+			trips {
+				alert {
+					temperature = <85000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 
 		touch-thermal0 {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp0>;
+
+			trips {
+				alert {
+					temperature = <85000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 
 		touch-thermal1 {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp1>;
+
+			trips {
+				alert {
+					temperature = <85000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index 45bc6e3245f6..568e98cb62aa 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -246,18 +246,42 @@ chassis-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&tsens0>;
+
+			trips {
+				alert {
+					temperature = <105000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 
 		touch-thermal0 {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp0>;
+
+			trips {
+				alert {
+					temperature = <105000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 
 		touch-thermal1 {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp1>;
+
+			trips {
+				alert {
+					temperature = <105000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index 23274be08e61..4875afadb630 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -74,18 +74,42 @@ chassis-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&tsens0>;
+
+			trips {
+				alert {
+					temperature = <105000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 
 		touch-thermal0 {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp0>;
+
+			trips {
+				alert {
+					temperature = <105000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 
 		touch-thermal1 {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp1>;
+
+			trips {
+				alert {
+					temperature = <105000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index 74017ae5a67a..ca9c20e90bcf 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -169,6 +169,14 @@ chassis-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&tsens0>;
+
+			trips {
+				alert {
+					temperature = <105000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
 		};
 	};
 };
-- 
2.39.2

