Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E5170F0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbjEXI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjEXI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:29:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ECF132;
        Wed, 24 May 2023 01:28:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3b9755961so582113e87.0;
        Wed, 24 May 2023 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684916928; x=1687508928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odFoqtaACFFyMrXmxlrRHYMZnaIGXqlcjA/Yeo/eMSM=;
        b=Mvd/veDyjuxX8uDcTR8PI4Xqf4ovhcjx5jyKNU3IYsLv4K4TWPiwQuH7PXLRUsd1lc
         FyfsPiUqwOq7sGQfZ10bL3H78meCp0oJsj12w7ytR5d0mG3wDlkzIA9amxl0LHWmdIa0
         nXTGfbb9SYE29Q/mKKsF9fX2N4Xee3qGLqoiTf3mpGpaRyyJf2VzepfVXB0Fj6tjE84u
         Wre8p0Iu75GJoNJ32N0Rhj8avsw8FRrCTbcV0NFk4oNtz1jQj3MslC3Ps8lUxtC0cQd/
         6c9GVZxKAzA3NmOekitk+/TRT6AuwtmWI3YkDMpKlpGigNvSnPkbhU9lCm7b0LEp42gX
         ThBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916928; x=1687508928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odFoqtaACFFyMrXmxlrRHYMZnaIGXqlcjA/Yeo/eMSM=;
        b=EC5jYU7NWyXxMSRi3jOSknkrmtqpEzRJGFF8nYPx6OOXKZ609kEhSeCWzGDgmJHAlJ
         LYD4XkPZL5BJGc3H705KVioQwymuP312VAEM08ogOZ2gKifxWzHqiPsPFU6Vli6iSecd
         fe2/Ux+6BTBjk6U8vUR5hQSt4xehG2mYwdxNzrxSPS7OkbhmF4iWGiN69VH6tzPglg8r
         5r2ZOGC5L+qlwKL/8SRdStp0qTaOAVmAIxRdHhvoy1lxOX8n1qVXGp15TmbAPxy+lOfy
         KJa41/OGFDiN4Dj+Gwgu0DiHYUgMru1hihjFPavW7AH78AIehA1tPkF9X5hc+PyaFNQ+
         8rRQ==
X-Gm-Message-State: AC+VfDzas8pptdGBS0JOkFHIXkudCHxX4hU47giKwPu6Ghhb7+aTiqB2
        0bHcueyd7jMqkLKbdFap5vfVlJEAOkSvpMUw
X-Google-Smtp-Source: ACHHUZ7nTj6ZzaR2KWD9boDc/9z2PyjWBCXVB7avQ4mYjB8ldUrHEw92byKyfbq/IsC5bWV5bsz3dQ==
X-Received: by 2002:ac2:596a:0:b0:4f1:3ae6:20bf with SMTP id h10-20020ac2596a000000b004f13ae620bfmr5776396lfp.1.1684916928480;
        Wed, 24 May 2023 01:28:48 -0700 (PDT)
Received: from pc.. (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.googlemail.com with ESMTPSA id c18-20020a197612000000b004f378fbb358sm1614049lff.112.2023.05.24.01.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:28:48 -0700 (PDT)
From:   Maxim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC PATCH v1 4/4] riscv: dts: allwinner: d1: Add GPADC node
Date:   Wed, 24 May 2023 11:27:33 +0300
Message-Id: <20230524082744.3215427-5-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524082744.3215427-1-bigunclemax@gmail.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
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

This patch adds declaration of the general purpose ADC with two channel
for D1 SoC.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
index 97e7cbb32597..b21825429cca 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
@@ -6,6 +6,16 @@
 
 / {
 	soc {
+		gpadc: adc@2009000 {
+			compatible = "allwinner,sun20i-d1-gpadc";
+			reg = <0x2009000 0x1000>;
+			clocks = <&ccu CLK_BUS_GPADC>;
+			resets = <&ccu RST_BUS_GPADC>;
+			interrupts = <SOC_PERIPHERAL_IRQ(57) IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#io-channel-cells = <0>;
+		};
+
 		lradc: keys@2009800 {
 			compatible = "allwinner,sun20i-d1-lradc",
 				     "allwinner,sun50i-r329-lradc";
-- 
2.39.2

