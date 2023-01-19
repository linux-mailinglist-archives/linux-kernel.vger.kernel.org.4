Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73156673132
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjASFaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjASFai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:30:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888632692;
        Wed, 18 Jan 2023 21:30:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k16so650443wms.2;
        Wed, 18 Jan 2023 21:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2/XB5nocOcz71QrQT5RaGDQw4mHrCDFlBceveHpJws=;
        b=fgDrE8OE636Axhvs8Lml+cCcuTQCUQ3tIQGZGfszJQbL15Y6MB1s5qgXmfdl/gtjcH
         4f8H5rVpgBL88MNsCqOyrWE/SJpME1Rvm3qmPfYuyDf//rjSI1AlxZOsmFFv+RPG5Ip0
         UwdT5DS96/BoAmZ4+dwGog+uvQvQKlZxX11OwT7AR5yYyxZNPcGQcFpdNtjn9dfVsU9T
         hzze1H8WwkdArdbeRUrL2cZyrXOLacd9q9mFtFGP62I9bHfpQm3/81p2XS5tRFVrAVNy
         IeeNfkB38/GWcaL9igVXh6v/UAMdfvU6qbEm9MuYOQ9RTkbxTlL9doZMIFKvhtiwCffE
         qqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2/XB5nocOcz71QrQT5RaGDQw4mHrCDFlBceveHpJws=;
        b=XTrb2xqpcQ3sfn3dTdyWM9tb1llTnlO5heP0FSTDj9Wc7ssw9+xmzceXvRH8Is7NKi
         2M6LaOMsIkI+Xol1CT0o+6T92twrzAivzlHFF5SlkbNPXW8gEQV/ghhn3QGpmLCthgeS
         GZEIXU8FLl/5HKnzNKjUeRbkcTkeJVi5K7qOyl13TZeSv7Dk5hu+pepVS9VvuxPLtQTt
         SEKccOuUYES0dmKTqYFlOzA2wdCp/oUX4q4IF05CGxiLjcX0MYgFRXGq53XCB4tS1RLQ
         0e2Ew8MCYXBRPhiyX59AvPCuZc1AwueJNP5xaXYG0+WIs9YHE3oSP2z+bf+HcQ39AWdc
         jSLw==
X-Gm-Message-State: AFqh2koSgndyB6ePaLgkXoJopAZhdv0VIqEkQXzU7/tSroGwSbS/7N2L
        f1BPjM4ItmU6sGm3VAWo+N8=
X-Google-Smtp-Source: AMrXdXvZG+5JyX7tCrSg0+qdoNIZWu8cTzu9QPwzTNMQg4F6j1BoIm8ZtyycdVguMOiAWMPmO0H4dQ==
X-Received: by 2002:a05:600c:1c8b:b0:3db:fe:f84e with SMTP id k11-20020a05600c1c8b00b003db00fef84emr8654045wms.1.1674106236017;
        Wed, 18 Jan 2023 21:30:36 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c3baa00b003d9f14e9085sm4235381wms.17.2023.01.18.21.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:30:35 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: remove CPU opps below 1GHz for G12A boards
Date:   Thu, 19 Jan 2023 05:30:31 +0000
Message-Id: <20230119053031.21400-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A devices experience CPU stalls and random board wedges when
the system idles and CPU cores clock down to lower opp points. Recent
vendor kernels include a change to remove 100-250MHz and other distro
sources also remove the 500/667MHz points. Unless all 100-667Mhz opps
are removed or the CPU governor forced to performance stalls are still
observed, so let's remove them to improve stability and uptime.

Fixes: b190056fa9ee ("arm64: dts: meson-g12a: add cpus OPP table")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
It seems we (me) forgot about G12A when pushing changes to remove opp
points from G12B and SM1 boards in [0] and [1].

[0] https://github.com/torvalds/linux/commit/6c4d636bc00dc17c63ffb2a73a0da850240e26e3
[1] https://github.com/torvalds/linux/commit/fd86d85401c2049f652293877c0f7e6e5afc3bbc

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index fb0ab27d1f64..6eaceb717d61 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -57,26 +57,6 @@ cpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <666666666>;
-			opp-microvolt = <731000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <731000>;
-- 
2.34.1

