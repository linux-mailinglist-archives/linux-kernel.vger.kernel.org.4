Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8C6614187
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJaXWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJaXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A828115731;
        Mon, 31 Oct 2022 16:22:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v7so2220127wmn.0;
        Mon, 31 Oct 2022 16:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MdUt/iNt9/kTh817Rsfi87nfiZ1a+43i2ZO2yuH5Cg=;
        b=jTVLX6Bj322sv3oFouLXybUnw9DkS2lMpgMu6sR2Z4/4QVL7Z+30E/OUf74oytw9rw
         9SpEv+OgwDZbj3wvJ1ZWj/6alqMFz7EGU53qPlHUE9llmzddo8WPTgS+h/zKaMjqZGXS
         VHLDyKimZ/2AZ8uviDEeQ/Ocpi4rdPJAzGDSJNgoqdOBQPk/HwiqOiYDADcfwodcTb7d
         lr2O8nKDsNyNxP8v0GmablOlrX1pL/+EnMUOVPz1Tx4LUtUFdFY0jclVeZzu8YVn25Ey
         ci2mRQqRUyzxxugA1Nhy5hlIAG4gdbgZSe3M96P/Fw6nUgw0PcbmKO9IyMrChaKQLKtH
         8/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MdUt/iNt9/kTh817Rsfi87nfiZ1a+43i2ZO2yuH5Cg=;
        b=FI6438eEP7qbYH2dIjZshX5TyYvyklFXfbx+PDr/SFFOwM6GmqmOX2g8y5c/euiu1X
         gnnwAvqKCkC2vLCTemSXumg3J4lv2CZywNHLYe5mYb1dhiP6XTclFNMTnvVVcavKA1rB
         pLx95SFWsNw7LOnzOQMEGWw7I+bsRB8jVy/TQgQtLJIDHtyFqinIITBos9sqR1EvGOCM
         g43lv+Fgz4TAFhS9gnMNtvCxxGbhghMI97Sla5rJnkAvdg+AXU50oH0vF6BGsHebLOBQ
         H0ax5nbKSKm6Mgs8c/U/YhCZ8im4UDKEXLA2vtvek3zFL8gIc/y20J9/cjtyWz0E6deN
         bqlg==
X-Gm-Message-State: ACrzQf3xrRF7Qz/ifbWuxAXOI9P4BU5ud5XvCeak/dX0MCeIp+6+QrBO
        oq17SOsE7qC0KTKwBEKL3Js=
X-Google-Smtp-Source: AMsMyM4Mg3gghsP5pWgmFsT2XFdnBmf6Abctn4YIlTztqIGN2AwFewk/aTLlAZMdHs85kMJMq/QNQA==
X-Received: by 2002:a05:600c:6023:b0:3cf:7dc1:e08e with SMTP id az35-20020a05600c602300b003cf7dc1e08emr456974wmb.154.1667258529235;
        Mon, 31 Oct 2022 16:22:09 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:08 -0700 (PDT)
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
Subject: [PATCH v4 2/9] ARM: dts: imx6qdl-pico: Drop clock-names property
Date:   Mon, 31 Oct 2022 23:21:55 +0000
Message-Id: <20221031232202.131945-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Acked-by: Shawn Guo <shawnguo@kernel.org>
---
v3->V4
* Included Ack from Shawn

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

