Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D318968E58C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBHBqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:46:44 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAC3CE1C;
        Tue,  7 Feb 2023 17:46:43 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z5so19287912qtn.8;
        Tue, 07 Feb 2023 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHiDONKTcVrmAlG+ok9qtoCDOdT6Y3uf/zpz8K5JdxA=;
        b=pFq71igqHJMSWLWD1b//qoS4jLrNx+34uB/RKEaZqql0gVrvRfP+cR+CPV107dlgf+
         XM4k4b7KJbYQE55/tP81uf9x2gmyradXMPz+iRUS0+frJJeN2WIKEM4PJUmxtgadQjLJ
         0AFlrITAMwAsoQ8wNXXI3WK9b387ZreyPvO7qNZmMs2XGcx21eQC1SxFmwRiPvEOHvWZ
         q5YgX3nZNjflPFvsvkfk+O5tYVizrpexD6/dMQQKoFKV0aH7r0lbmZf5EzGj85aBaXh+
         AEefjH1LBBl/xQ8JMzbE4iDWocJcVEbtexjOAmyaTIEUwWRLIWeyh92QF8pq4UmYzws7
         C9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHiDONKTcVrmAlG+ok9qtoCDOdT6Y3uf/zpz8K5JdxA=;
        b=b64L/QEgZ5GER+MoNUwwTnQ8Z5hYC1RyNg1l0aOo8kzJ6HcTA0RcsNA1c4bXEv/WtV
         qMSpGaR06ZP8jTrHwhPsclVqjpcVsaP91XCJLiSqcq5NDkIj1f72zD3VegayJy4kJIZa
         q2ML5Mtw4O0RWNcDDZ6kUfWDLZ/Gui/PXsqkfqZVXpA0f9fs8TgrSQ73CRfDmcKq08zZ
         Xzc9P4iF3NN97kpiRYFEGzhSQfay6NjpJKd6NbihW+pOErw102DKbEu/gTTYENn2GYhU
         gZBdj/wpMJbmi677b8oB6KKXnNLDtqJhT7DYtlWGh+1XPLELXVXtRIei8znceQ7WnmT8
         5vxw==
X-Gm-Message-State: AO0yUKUUch5wR6Yg3wML3LMipX5wAXUWee890GGxlKiykb1Cf2kqaiPI
        lwGlpvwNGz6mLM64ZrKhouowLB3GvOg=
X-Google-Smtp-Source: AK7set+En1tsQUU4iVuJtFlFVb8sucz5AKOaLpSDafWm8rsNlEbgewSVmtF+O0jbVeewNq8LJayMMw==
X-Received: by 2002:ac8:5bcb:0:b0:3b9:bf43:fccd with SMTP id b11-20020ac85bcb000000b003b9bf43fccdmr9298181qtb.10.1675820802581;
        Tue, 07 Feb 2023 17:46:42 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id t129-20020a37aa87000000b006fc2f74ad12sm10503816qke.92.2023.02.07.17.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:46:42 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] riscv: dts: nezha-d1: add gpio-line-names
Date:   Tue,  7 Feb 2023 20:45:03 -0500
Message-Id: <20230208014504.18899-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.17.g4027e30c53
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

Add descriptive names so users can associate specific lines with their
respective pins on the 40-pin header according to the schematics found at:

	http://dl.linux-sunxi.org/D1/D1_Nezha_development_board_schematic_diagram_20210224.pdf

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
index a0769185be97..33489c7619cb 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
@@ -90,6 +90,15 @@ pcf8574a: gpio@38 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		#interrupt-cells = <2>;
+		gpio-line-names =
+			"pin13 [PP0,gpio8] ",
+			"pin16 [PP1,gpio10]",
+			"pin18 [PP2,gpio11]",
+			"pin26 [PP3,gpio17]",
+			"pin22 [PP4,gpio14]",
+			"pin28 [PP5,gpio19]",
+			"pin37 [PP6,gpio23]",
+			"pin11 [PP7,gpio6] ";
 	};
 };
 
@@ -164,3 +173,47 @@ &usbphy {
 	usb1_vbus-supply = <&reg_vcc>;
 	status = "okay";
 };
+
+&pio {
+	gpio-line-names =
+		/* Port A */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* Port B */
+		"pin5  [PB0, gpio2/twi2-sck]",
+		"pin3  [PB1, gpio1/twi2-sda]",
+		"",
+		"pin38 [PB3, gpio24/i2s2-din]",
+		"pin40 [PB4, gpio25/i2s2-dout]",
+		"pin12 [PB5, gpio7/i2s-clk]",
+		"pin35 [PB6, gpio22/i2s2-lrck]",
+		"",
+		"pin8  [PB8, gpio4/uart0-txd]",
+		"pin10 [PB9, gpio5/uart0-rxd]",
+		"",
+		"",
+		"pin15 [PB12,gpio9]",
+		"", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* Port C */
+		"",
+		"pin31 [PC1, gpio21]",
+		"", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* Port D */
+		"", "", "", "", "", "", "", "",
+		"", "",
+		"pin24 [PD10,gpio16/spi1-ce0]",
+		"pin23 [PD11,gpio15/spi1-clk]",
+		"pin19 [PD12,gpio12/spi1-mosi]",
+		"pin21 [PD13,gpio13/spi1-miso]",
+		"pin27 [PD14,gpio18/spi1-hold]",
+		"pin29 [PD15,gpio20/spi1-wp]",
+		"", "", "", "", "", "",
+		"pin7  [PD22,gpio3/pwm]";
+};
-- 
2.36.0.rc2.17.g4027e30c53

