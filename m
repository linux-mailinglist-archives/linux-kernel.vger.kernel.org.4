Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A372AB7C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjFJMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjFJMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:31:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E33C2A;
        Sat, 10 Jun 2023 05:31:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so27563665e9.3;
        Sat, 10 Jun 2023 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686400261; x=1688992261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/TmEA+PoC7xu6/KU/ll32pvJQ2ck1CrGNuRyF6FIV0=;
        b=LXnm8gPbPQkQWKDuC02ieMibyFgLdcZnn88V0/4WRrpJ+/82BLx419ELyBKEzKDuJ1
         EytK1+TtoApSioJlkL9L1JGf9koy7mTG6XAERLAil475SHg6QSPUHAcwX0NkqsemMa1Q
         8fmyO6WeLVmb5MYgiaL13FR6Z8OZpf0fIcfitSS59euxOUES68UA9aReJ1o70FjbI0RL
         hYrclT9vuW1CCHdjtveVm19YpZ31bwdJtbAujx4+X0w2ndKHY+JII8r2kmsYmZrU1o9R
         eqKQPmpOD2dMZhKqNXDG9K+TPQKHWcVFQud6DPUVWiTwbuSasvYHBLee2lZ+9aG4oR9v
         4Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686400261; x=1688992261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/TmEA+PoC7xu6/KU/ll32pvJQ2ck1CrGNuRyF6FIV0=;
        b=hwZhpvne9J8p353gQWolcSXJFflhu4cddtFvVoVMPcig8EP3NoEIHOo+DPAAeA5urQ
         w40BtnEOhrvMRZffVJ1mlB1EiUQG7J1PatM2pmcP6nffEiddmnbAeM4YefGbNqsd2489
         qVLS6p8KwTs3+QG3zofmFzxbybElW2w7VONgpP73zK2mt5m1aCLaR+3PDRxfH8cnSTvd
         J8gfJMxfL0wm6qGNoyWOHMcE8L0bb5sJf2EsDvZW26V1sJkzZdYSthcEdiZ4d5DFlJWn
         npy6kDhrNGvVYrJme9kCZBY3iCHh1YDpd6cPIHHx9yQPlDuwMG9p7m046H9dypMik7c6
         LZDA==
X-Gm-Message-State: AC+VfDxDBkzofkRTut01l1T6QGVo+lCuPw5M0PT/Y9QqboFHdj8WvT42
        JcAcAszCtOJC+GzIDF5U19x1ROd++OE6LfUn
X-Google-Smtp-Source: ACHHUZ6oQnfcW+hVFxDL3r5DfdtcISrzUdyYfVhCOqBjpbqMOY2nywjUESWhtMB1LNwj370onHD7sA==
X-Received: by 2002:a05:600c:2186:b0:3f6:e79:3a8e with SMTP id e6-20020a05600c218600b003f60e793a8emr3710347wme.12.1686400260702;
        Sat, 10 Jun 2023 05:31:00 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b003f80e81705asm2310487wmh.45.2023.06.10.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 05:31:00 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 3/3] riscv: dts: allwinner: d1: Add GPADC node
Date:   Sat, 10 Jun 2023 15:29:09 +0300
Message-Id: <20230610122934.953106-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610122934.953106-1-bigunclemax@gmail.com>
References: <20230610122934.953106-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

This patch adds declaration of the general purpose ADC for D1
and T113s SoCs.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 922e8e0e2c09..90c79041cfba 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -138,6 +138,16 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		gpadc: adc@2009000 {
+			compatible = "allwinner,sun20i-d1-gpadc";
+			reg = <0x2009000 0x1000>;
+			clocks = <&ccu CLK_BUS_GPADC>;
+			resets = <&ccu RST_BUS_GPADC>;
+			interrupts = <SOC_PERIPHERAL_IRQ(57) IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#io-channel-cells = <1>;
+		};
+
 		dmic: dmic@2031000 {
 			compatible = "allwinner,sun20i-d1-dmic",
 				     "allwinner,sun50i-h6-dmic";
-- 
2.39.2

