Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9328C60E185
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiJZNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiJZNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:07:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423FAAE21C;
        Wed, 26 Oct 2022 06:07:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so1439333wme.5;
        Wed, 26 Oct 2022 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE9e2apMACasyKGOaqFNr+Yuli9PwHdn/ViP61o5ChA=;
        b=DzuBSWVlLD7Oq2PImHUCrXgRbDGGp9aYU77BavLFQ3bCrrGI08yyDVWeHV2bS2gDS5
         hOwzt8ovcCCRrwSqXCUvkeUJapL5tfr7FjzKiTZfYYXHj2MrGVM7593qH0kodTEUDT25
         +J4OIQVXYJBc63ts7t/LtzOPKmx4zRHSRiIyOjnB5VIoNledCy4or+AOj444a/6LyEXt
         hPY3vXkLIK/DUZvA+aY78X5kHZy4Dca81o7U8lI63zBPteba+6PBo59xjkO+IZvF/40s
         NZGO9Bd3b8NcKtSi8+OVeX/c63kVVERbll9Mg/a93JP6Zl0FVS397/Q9+UtO4plX+cdl
         pm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE9e2apMACasyKGOaqFNr+Yuli9PwHdn/ViP61o5ChA=;
        b=vuejZa3jEQ4/6/yeX4KQuJ1rHNAUU7ojU8ztxZJbx6KUU/6a1Ub+8qRTcCKXh+p3qS
         YtRgrZgyo972F68e5puou+Yh5kVaIwhNlLZKf7zVZ/IaVU+WRrATi1FkAQyp9Zc6RTSV
         vXeI8u+BCij42IfB4Z6VAYYmtl5BlFn4ZibEm2OPccDpWXsMSWktZrS2zY4XAYrwpsya
         yGexymHlKT93Ym0VMbSlAG+WG0sEZKmHkeoAiHNPdVBgo9drU5gOTFfnTy8UVz/jePVq
         IBk9hkIukJsW6WFQqlHfEd+zrNfoQqwmQHkyj5gU5NP/fkH+J3qMJNLE5qqtbzFMANYy
         DWIw==
X-Gm-Message-State: ACrzQf3pr+fJ+TBYH2I9q5PeklfAzjGaGCgAn60vSL/dUlPIPaTEN9S1
        qNtLIziDKRtqG+f7+Du+Eqc=
X-Google-Smtp-Source: AMsMyM4Wy+0BYeCpFF6l/kAV/9w1zSxx1LDnrH0dVe7Zmx/8AAQcEx+931gBjxR0/Tk1Xj4ND8ACxg==
X-Received: by 2002:a05:600c:46ca:b0:3c6:f3e3:df99 with SMTP id q10-20020a05600c46ca00b003c6f3e3df99mr2409066wmo.77.1666789640706;
        Wed, 26 Oct 2022 06:07:20 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc:c67c:46e:319e])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5245433wrb.114.2022.10.26.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:07:20 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 4/9] arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Drop clock-names property
Date:   Wed, 26 Oct 2022 14:06:53 +0100
Message-Id: <20221026130658.45601-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Now that the driver has been updated to drop fetching the clk reference by
name we no longer need the clock-names property in the ov5645 sensor node.

This is in preparation for removal for clock-names property from the DT
binding.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3
* New patch
---
 arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi b/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
index 7ce986f0a06f..7cb5c958aece 100644
--- a/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
+++ b/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
@@ -65,7 +65,6 @@ &MIPI_OV5645_PARENT_I2C {
 	ov5645: ov5645@3c {
 		compatible = "ovti,ov5645";
 		reg = <0x3c>;
-		clock-names = "xclk";
 		clocks = <&osc25250_clk>;
 		clock-frequency = <24000000>;
 		vdddo-supply = <&ov5645_vdddo_1v8>;
-- 
2.25.1

