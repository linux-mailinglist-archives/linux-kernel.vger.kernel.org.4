Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96134732134
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjFOU5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjFOU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:57:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0926AA;
        Thu, 15 Jun 2023 13:57:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so22689505e9.3;
        Thu, 15 Jun 2023 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686862653; x=1689454653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPsNG/FZ1k4UaDSBhJRqncRzudNFaZG2hOicOFjuDg0=;
        b=Lq6c3nOqJ/m4ocMF35gRFAvHKZHsdT0ZTfnmTKDlRj81mkl4S2DzbrY01Dd3MHb2vD
         LKJ97u3S6t32HPcaIzJTkSnBRFtCIckL8AlSf8FvbbsFpSZmJsjxR8HjSQ5Ne87RfOeg
         ZPKNUTpsUwA4zB0uxL2nCVlzZNtepLrIrCT8WU/S/4fcFEKFsG9CGji4LGTeLM8aiv6A
         r65sVgWOecbSgMOoDwgg4nJgtOopirkHV9raIkZOrpcLVGCHAHskpEkwBp0oChLBhBCI
         ubn5vE6xVLuNZqiEBJBRzmyDsGs5llJ/gj52BduyjC6lr5TwlGH/x/NSYa6gR3IJSosG
         PbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686862653; x=1689454653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPsNG/FZ1k4UaDSBhJRqncRzudNFaZG2hOicOFjuDg0=;
        b=GhxW6cHAst8VNW/EMOowaGaSTKrayMLcrgTYqu2otBS9Z4duu2FWGjhJzTv1vGKyXJ
         VHbCu4zJTpMednaxhdrWbQbbzyUgtbp0IyIabqsBwkVEGFKuENBA4CwK7ENg9mO4CKcy
         Q8vCnUJIwmO8lQcLQvGqRrTJEgI2U133yZPbOoIM0imJTm6FVtinQ9QW1Gwyd8k3zpXE
         cUSTaa2Om+iqsmtTaKq88FUIY0TKVbEP5Fof+8Epp3XQHLqG5/GD2zErzmqxzVEYJFWM
         zBXVR0jLaRgP+OAx4N/r5AA5xYnkIlRWt/sgcRSkDOWc8c6mfTsRYip5CNflvkdXj9jY
         t2rg==
X-Gm-Message-State: AC+VfDzpqPpvNCdC3iwADQ9rooD18+Qa8JsdNOG56n0ehmqzu1veUJ2T
        +20M3DvTEko+lIbqXnTVkzXwspZtYC5KX8qf
X-Google-Smtp-Source: ACHHUZ6G6BjLZPo9OOrHMIFog94EWcKf0LkdquMRmMdpIg/KVI+L1MZrvO92xcPAZ8zBJyiX2LWPlQ==
X-Received: by 2002:a1c:7907:0:b0:3f6:2a6:e2c with SMTP id l7-20020a1c7907000000b003f602a60e2cmr288223wme.9.1686862653373;
        Thu, 15 Jun 2023 13:57:33 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id k24-20020a7bc318000000b003f733c1129fsm176372wmj.33.2023.06.15.13.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 13:57:33 -0700 (PDT)
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
        Haibo Chen <haibo.chen@nxp.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v7 3/3] riscv: dts: allwinner: d1: Add GPADC node
Date:   Thu, 15 Jun 2023 23:55:22 +0300
Message-Id: <20230615205540.1803975-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615205540.1803975-1-bigunclemax@gmail.com>
References: <20230615205540.1803975-1-bigunclemax@gmail.com>
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

