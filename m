Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB757735B63
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjFSPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjFSPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:44:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABC7139;
        Mon, 19 Jun 2023 08:44:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f849605df4so4660599e87.3;
        Mon, 19 Jun 2023 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687189477; x=1689781477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2xW1pdD4hh2VGs4Mpg9cKE/j/pXz/wg2o6KnZsreRQ=;
        b=SXi9EuYemDFlDxp0BqouWi1+qLw4f2dj8Wiuwrapoqielba8KLGExvIZVg831z4yh3
         n9YHgewmBi/vaHWDfDGSKEpC72HxQIzH8PcrDpN3EpQZvZMqRoHVJ7V8WC0h071yrRd/
         yjJ1KFmUABIwfoo0Cwrw7pSyffKMlHGB0qgS1k8qkXTXKQ+OBnZ0SQ8rnR2diuoSUD5B
         fWhRAyGZkSnFTAsdlUAwXFnx2UYjxddxGfSfNnLGrO2nqRd1bq9WNetJYb+RsWW85ED2
         zjFc46hV/eGrfqKuG/LfBj6tpbAUcdzezYY8RJOCeJSfHi2CKqHwiHBukPmYhJlnsQkq
         VzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687189477; x=1689781477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2xW1pdD4hh2VGs4Mpg9cKE/j/pXz/wg2o6KnZsreRQ=;
        b=MtUoM+Wx+hSzrmuAmsFL+oOWlx+VH7XN/amXwRWmPVAGIsiyxw6LXAkI2bzlgJGgCM
         jJJp5VIbifkadjU+u14gUs3KcGX2l09lmEu4RaXYOdnJF7XX5Bif3VxdmyA/rf3eYXx7
         s5izV7VC35fTcoIwQy5/t18ppm8AY9KL7KbNwrkuZNXLi7OpqLHBc/q7iksmyo+xM+dS
         jz0HTj8kueOuIhQ26NY+RRv123yIS1ILl77QT8tb+JEI3nfe7VoYhaecvTTs/THwjoSu
         ei1ylaw88vW5iw4/eaRubSftp7AO4Y+3HM7acoXj5FgXokya0bMfc0aqQTDP/Ipw3bOI
         RlWg==
X-Gm-Message-State: AC+VfDy6L886+rUJ/K71cai3qLQTwJEe+K5lus5Aqo5Nbti5A9xsnFVU
        fi76KZjv6qRD4AAfGr2GMkdONQvAZXuDgf7s
X-Google-Smtp-Source: ACHHUZ6fyzgyF6IaPo1cFaZ/Jbu3BHrWZiNQ4Ii9axwoUxhdnuwBR6cJW7DJpqJrgj7c7vZ8IZ/jdQ==
X-Received: by 2002:a19:505b:0:b0:4f8:5af4:73ef with SMTP id z27-20020a19505b000000b004f85af473efmr4062285lfj.28.1687189477519;
        Mon, 19 Jun 2023 08:44:37 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id f11-20020a19ae0b000000b004f85e53250bsm1207144lfc.191.2023.06.19.08.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:44:37 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v8 4/4] riscv: dts: allwinner: d1: Add GPADC node
Date:   Mon, 19 Jun 2023 18:42:27 +0300
Message-Id: <20230619154252.3951913-5-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619154252.3951913-1-bigunclemax@gmail.com>
References: <20230619154252.3951913-1-bigunclemax@gmail.com>
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

This patch adds declaration of the general purpose ADC for D1
and T113s SoCs.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 922e8e0e2c09..cb353d5805cb 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -138,6 +138,16 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		gpadc: adc@2009000 {
+			compatible = "allwinner,sun20i-d1-gpadc";
+			reg = <0x2009000 0x400>;
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

