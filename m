Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6877260E193
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiJZNHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiJZNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:07:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA71FB701;
        Wed, 26 Oct 2022 06:07:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so1451159wmr.2;
        Wed, 26 Oct 2022 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf2UiB+zU3vDS2ZGfH6hKqDtwI6lpc4PY4He6vWYvz4=;
        b=aIxFQBtFoxypKmy5lP8Nk86z3bdDwR6XHd2uN35GLGvO4nMZmd2FErn67JwqbYpBWt
         +w/SOEytlOjUuruWyuUDKeVuPM/jN8PTP/9ZEg2L4iQGNe5RFifhUuM/B0PVNdYTa3aB
         RCuaRApl4YUM/Wh3oKFZ1ISx8D3j28ak+R9j1oXvWD/t3r7q4bg1r33D4LRyAXhS2f7O
         +Uu7eiwFTfBGK4z9rWApu8K8EQRNonxcVptAougeAOE+8JnGOnQVING/umzElmbhFOe3
         xd2LrVB6wGxKCQ+OsP2QZ0gWCmePRIiaVFD181HMrWF9GloQ/YnJh/rzXHGkuJJ9FOJp
         PCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf2UiB+zU3vDS2ZGfH6hKqDtwI6lpc4PY4He6vWYvz4=;
        b=CoFFmPevnDSATjV0oR3Vv4JjZe5POZfaLZBKI4gOLtG8xKpkSkb1B1FSiChBFpAfop
         jh4Bgg0/gNr9uUTu6fdEuKmbYXNG6AUcQBqG6YCZqaJ5aImxCwU3jWBu6AYgV2msxEbZ
         gI+YtT6UIAl6gERFNpKZ6EkSD4fDJRwJx9esRxctzVKxayedu9mJidRBUfC/1EpvD/W6
         8jMIrH4S/ytXnEZMoj+x3K9/lujOs7f6Qf26wAwnCe0+VaITfqH+gSDvSQxJkqxHuFiB
         MR+ia8G22K9stsEmzohB9fc7Atq05yotPAksgc69uJWxNrZbX1+WWXjhZgEIvpvmAhtg
         I+KA==
X-Gm-Message-State: ACrzQf3Gjw+OqIv7qilpeZl6nM7STxJo2TcsFARaLUV+rAeh9VGN6jbK
        I053RTO9UgO2qvXObNxOaO0=
X-Google-Smtp-Source: AMsMyM6nJq7LNPFc/VDVJBW42THSzVzYdGTV/smjB+OZhSvemg+8pvORx1sIduEukfTnMxeR5SiCpw==
X-Received: by 2002:a05:600c:3548:b0:3c6:f7cb:1567 with SMTP id i8-20020a05600c354800b003c6f7cb1567mr2370839wmq.161.1666789638051;
        Wed, 26 Oct 2022 06:07:18 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc:c67c:46e:319e])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5245433wrb.114.2022.10.26.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:07:17 -0700 (PDT)
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
Subject: [PATCH v3 2/9] ARM: dts: imx6qdl-pico: Drop clock-names property
Date:   Wed, 26 Oct 2022 14:06:51 +0100
Message-Id: <20221026130658.45601-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This is in preparation for removal for clock-names property from the
DT binding.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3
* New patch
---
 arch/arm/boot/dts/imx6qdl-pico.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-pico.dtsi b/arch/arm/boot/dts/imx6qdl-pico.dtsi
index f7a56d6b160c..c39a9ebdaba1 100644
--- a/arch/arm/boot/dts/imx6qdl-pico.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-pico.dtsi
@@ -233,7 +233,6 @@ camera@3c {
 		pinctrl-0 = <&pinctrl_ov5645>;
 		reg = <0x3c>;
 		clocks = <&clks IMX6QDL_CLK_CKO2>;
-		clock-names = "xclk";
 		clock-frequency = <24000000>;
 		vdddo-supply = <&reg_1p8v>;
 		vdda-supply = <&reg_2p8v>;
-- 
2.25.1

