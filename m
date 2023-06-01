Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2E471F5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjFAWco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjFAWcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:32:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716C1A8;
        Thu,  1 Jun 2023 15:32:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so1390259f8f.2;
        Thu, 01 Jun 2023 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685658752; x=1688250752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/TmEA+PoC7xu6/KU/ll32pvJQ2ck1CrGNuRyF6FIV0=;
        b=PONnEob4cS799koyjCLxAEsadb0C5Fdkmzoc9mRcit0XlOSYJQv+wlsMZI1/KUhrq0
         EmiI5N6UUlzX07g4bppV5fM/ERH0Kc1q6C1Ecwo+XK/lBO+kqZhSWdHRQTJn/r+xHJ3Q
         /RBLLfLxgIVRLbYYoZgGQ+EM/XZH2dpFGccTFJrYUZ3AkWEYYPMaVSTUYmlnEKCu306P
         mM31tPQ8fqWiFZRgKAMLFy8HVh/vqXa11YJMlUmyGKmSiVSSfBBkOZuln7xeu0urBO3P
         kdwBI+K529QyXPDED8jvlTPhU96rtmoSs6MoFIw1vWgaQmEoeT+EXp2xw9pGcPw+t1ZH
         J4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685658752; x=1688250752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/TmEA+PoC7xu6/KU/ll32pvJQ2ck1CrGNuRyF6FIV0=;
        b=g0LNO0f2Uzn11IScvna4IFRB3R89Xpt6LCLn/IsLcQxQKnwupTvq25fXoih4W6iEvS
         A/wkGyWc5qKcljBxdRTeAmFO6GUvAVA3vU+jGmjo2DPUNpxOf3REqHb8kmNuFl8ZmBtG
         jXQJ4qgGHABTTHMN4xMAB58HhG6det4qcBi7r7Mi0gYI27SRrM95qO8grmUhdlYjOnd1
         iXJP+xKWOacPh9z9WvzVN4Kg3+Dr8a2yMQdhjVnMynm94g0ngqba01w8tgAkr+HZemHh
         QhqDBIezJAobcwBW4/pau2LsapFzR0EbJci6U/sFR8bB6vJdmjKApalKxElXbAwcGMPg
         WRzg==
X-Gm-Message-State: AC+VfDxPE2rK4GNhP1ZrcEZhuEyxU00aVhWIAwrth70QsJ5Znbnlr+/o
        puivxxvhd6RStuGFztRJK4YdM2aV9emR3cI2
X-Google-Smtp-Source: ACHHUZ7+6YZkcaeG6CeOS2iTlIxdCLfJll9IA+N/ujkTvPbYMeBBBBx/fSq02syrGNxPfUZeojqXWg==
X-Received: by 2002:a5d:6709:0:b0:30a:eac8:e5c1 with SMTP id o9-20020a5d6709000000b0030aeac8e5c1mr3088955wru.6.1685658751871;
        Thu, 01 Jun 2023 15:32:31 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4d87000000b0030af8da022dsm8619149wru.44.2023.06.01.15.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:32:31 -0700 (PDT)
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
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] riscv: dts: allwinner: d1: Add GPADC node
Date:   Fri,  2 Jun 2023 01:30:41 +0300
Message-Id: <20230601223104.1243871-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601223104.1243871-1-bigunclemax@gmail.com>
References: <20230601223104.1243871-1-bigunclemax@gmail.com>
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

