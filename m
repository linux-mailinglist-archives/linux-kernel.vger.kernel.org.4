Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9B5665D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjAKOHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjAKOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:07:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBCD270;
        Wed, 11 Jan 2023 06:07:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E9006602D9C;
        Wed, 11 Jan 2023 14:07:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673446057;
        bh=n5WHHdQNBAmOfq5p8QxYo1xuR8hghbRyMcc6c0ej73E=;
        h=From:To:Cc:Subject:Date:From;
        b=ft+RLNTMPustVX31ZWVZ+VbC8cBRx/3a766ayXp+Je96O72qZb91w6D7v68FJ1NDL
         KsXKIoRZVL4b6CmVrTmJ09ngH1dGN1MowQDAM81UCm8Vfsy36O7OTsl3egi55IDvV6
         envsu1WpEfF5FCOQoI/tSwRMQCp1PH5R0mSDjCTs5EjD+tRatASSerY4C8QF/qGJFX
         Lu2ho8UJ8BUTiWXUeloV2QzRIXUnb0CFLkcWxvcPCsq8NeLMZCdXgr4ikJ4pUrh8++
         N4o15u4RBqLyukqKK7Zx8Tzb8XmYy54VBXvIDZH/3ov5gCxijHm4/Qw2YAAt5rUDzX
         LSAWgXk4WxxnQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] arm64: dts: mediatek: mt8173-elm: Move display to ps8640 auxiliary bus
Date:   Wed, 11 Jan 2023 15:07:24 +0100
Message-Id: <20230111140724.294533-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
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

Move the display to an aux-bus subnode of the PS8640 eDP bridge.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 18e214464a2d..f9b10c7027cf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -90,18 +90,6 @@ switch-volume-up {
 		};
 	};
 
-	panel: panel {
-		compatible = "lg,lp120up1";
-		power-supply = <&panel_fixed_3v3>;
-		backlight = <&backlight>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&ps8640_out>;
-			};
-		};
-	};
-
 	panel_fixed_3v3: regulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "PANEL_3V3";
@@ -282,6 +270,20 @@ ps8640_out: endpoint {
 				};
 			};
 		};
+
+		aux-bus {
+			panel: panel {
+				compatible = "lg,lp120up1";
+				power-supply = <&panel_fixed_3v3>;
+				backlight = <&backlight>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&ps8640_out>;
+					};
+				};
+			};
+		};
 	};
 };
 
-- 
2.39.0

