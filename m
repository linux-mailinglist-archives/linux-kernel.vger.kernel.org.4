Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920026EABB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjDUNaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjDUN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:29:53 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F736F2;
        Fri, 21 Apr 2023 06:29:52 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 1C172403F3;
        Fri, 21 Apr 2023 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1682083259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0r0DPCZt1EU488fl2GZEqSoMWdqqn9V2ojnp3z0FnE=;
        b=UR4nsX1r2aXnxpPuEaO65hov5YFHqI6djkFgTMhrnWyj63ZWLuhJlewOo5544FPp1+UgP4
        N6WAsS3x0rWze0vX0EseVtLBI5ZPUGU4jJBZpqERpBYsQISLw1Uh0JJv0RXYjQ8XEemfRa
        +ruFmmCim29eRZGRt1EDMjERyp7xULQ=
Received: from frank-G5.. (fttx-pool-217.61.159.143.bambit.de [217.61.159.143])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 119EE10072A;
        Fri, 21 Apr 2023 13:20:58 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v1 6/7] arm64: dts: mt7986: add thermal-zones
Date:   Fri, 21 Apr 2023 15:20:46 +0200
Message-Id: <20230421132047.42166-7-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421132047.42166-1-linux@fw-web.de>
References: <20230421132047.42166-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 5d68a617-c55d-461a-a20f-0eeaabed9417
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

Add thermal-zones to mt7986 devicetree.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index a409d5e845c2..845b29a9664a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -603,4 +603,44 @@ wifi: wifi@18000000 {
 			memory-region = <&wmcpu_emi>;
 		};
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&thermal 0>;
+
+			trips {
+				cpu_trip_crit: crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+
+				cpu_trip_hot: hot {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_trip_active_high: active-high {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_active_low: active-low {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_passive: passive {
+					temperature = <40000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+		};
+	};
 };
-- 
2.34.1

