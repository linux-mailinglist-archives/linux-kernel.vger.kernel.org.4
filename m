Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A510765D545
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbjADONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbjADOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:12:51 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B5B1E;
        Wed,  4 Jan 2023 06:12:49 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a9so7177743ilk.6;
        Wed, 04 Jan 2023 06:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/UGqMaPLn0RLZcUOfGRM9RvG3oDMMZB7aFPu1G+vN0=;
        b=dPvuEHDFGE+DgSimMZg76EeydzCN0DS7QJzALtiaoOtgqaP9ZCwW2NrjwDn6Dw85JS
         adhFdGP4hbufKFHp9QwzxGBiDDdRwOLastqdXNvzQpYvM992GVFM4eb8HVbruHELlImI
         TVHpCs86NGZcZSutHdtsj+UenvnjVQj1pSEVtvVWQvp8E+A639t6MU01+jfUCcy6IdCd
         d9C8n+SHAEbRt3rPajHupQ1vg2cMLSG1h2+0zqC5hyy33fH+tsCQ5psssa7m3X8VB0Mv
         0qguy7pb3fgU/AUQfvUgQ8tygNyfWO11YZVbXB5XNzldz2Uvn4SWtALufmPw2cI36G1V
         pu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/UGqMaPLn0RLZcUOfGRM9RvG3oDMMZB7aFPu1G+vN0=;
        b=XKo6/lEyrdPW2DNgznd6JduXMlA+QOF2EHCb0TAFR4Vgy0fKW76jtkySq67IC+VB/B
         JAOEDNWLiQN982/mAjdSdpiVcID8Wc6e2Wp//zy4E2wUvLBbD3sr2Nf3Molb+i/FS6Of
         ASGD8mI8tRlQV7DNriSxbvG/MrzQsue7RFlvQM8Nrp2vfBEkI5hPHJ5fKZCcNcq3d7Pv
         U2x0CPmY0CtTR2kMm7xQm5c03lNYGug17O1nYa5zglLwljaZIbpslfjlL11m3rgGBHrz
         ay2GlTziDu+X6rGutTAaTsKoGtZzx5fOqCflqgrsBz4FVAZPVS5qI70PxdxhY7Xs+hvq
         ZJTg==
X-Gm-Message-State: AFqh2kpTSKfGTeICLGnq1aIZLkeiFk3anrgYr6CxQP0drwl/6T/6Em8x
        418BgNygNf19YJ2c/rdNp8QZuak1YJs=
X-Google-Smtp-Source: AMrXdXsrFS8OCAf4RSp1vImyUy3fr2Zbv2/gEXdpSY2BFjeWRwoXXXl4ROVpsv6xSVTwMZbPG+lG+Q==
X-Received: by 2002:a92:d586:0:b0:30c:5316:d94 with SMTP id a6-20020a92d586000000b0030c53160d94mr5580126iln.31.1672841568701;
        Wed, 04 Jan 2023 06:12:48 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:58ca:a321:54c8:c288])
        by smtp.gmail.com with ESMTPSA id ay28-20020a056638411c00b0038a5af5e831sm11353451jab.100.2023.01.04.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:12:47 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: beacon-renesom: Fix gpio expander reference
Date:   Wed,  4 Jan 2023 08:12:42 -0600
Message-Id: <20230104141245.8407-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board used to originally introduce the Beacon Embedded
RZ/G2[M/N/H] boards had a GPIO expander with address 20, but
this was change when the final board went to production.

The production boards changed both the part itself and
the address.  With the incorrect address, the LCD cannot
come up.  If the LCD fails, the rcar-du driver fails to come up,
and that also breaks HDMI.

Pre-release board were not shipped to the general public, so it
should be safe to push this as a fix.  Anyone with a production
board would have video fail due to this GPIO expander change.

Fixes: a1d8a344f1ca ("arm64: dts: renesas: Introduce r8a774a1-beacon-rzg2m-kit")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
index 8166e3c1ff4e..8b6fe235a8f0 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
@@ -437,20 +437,6 @@ wm8962_endpoint: endpoint {
 		};
 	};
 
-	/* 0 - lcd_reset */
-	/* 1 - lcd_pwr */
-	/* 2 - lcd_select */
-	/* 3 - backlight-enable */
-	/* 4 - Touch_shdwn */
-	/* 5 - LCD_H_pol */
-	/* 6 - lcd_V_pol */
-	gpio_exp1: gpio@20 {
-		compatible = "onnn,pca9654";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	touchscreen@26 {
 		compatible = "ilitek,ili2117";
 		reg = <0x26>;
@@ -482,6 +468,21 @@ hd3ss3220_out_ep: endpoint {
 			};
 		};
 	};
+
+	gpio_exp1: gpio@70 {
+		compatible = "onnn,pca9654";
+		reg = <0x70>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"lcd_reset",
+			"lcd_pwr",
+			"lcd_select",
+			"backlight-enable",
+			"Touch_shdwn",
+			"LCD_H_pol",
+			"lcd_V_pol";
+	};
 };
 
 &lvds0 {
-- 
2.34.1

