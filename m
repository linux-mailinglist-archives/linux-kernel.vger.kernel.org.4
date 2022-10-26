Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFAA60E192
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiJZNHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiJZNHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:07:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1300CFB709;
        Wed, 26 Oct 2022 06:07:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l32so10157156wms.2;
        Wed, 26 Oct 2022 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIVy3GeRA5OkZZu6xDvDHdm1GOthqotFd5U/fgk56CY=;
        b=PC0PsXNpaGDc04Hd6MeOzRXUfr7dc58xEoLjm25RZbla2XenW7dqPyzgi4Ybnnr6PB
         Y7sQA9NPE9i+gORdw2J7k3jx1VIG8uBbhJzMFxLM0sJP5b2yu9C4T8iux39YOJgLAAzg
         7S2TA1vaSGvXt2nyD4qDUO0qiyRKvyVMOoQyucHEQIaKMmd94+ocFfAIwrY4P88CAkis
         qpawzaU+7sYnMSCHJj4xNV0DftzA8w7jSZtCw+V+RuWKylc2ERdre6pYkyhhUoszd3ju
         1lNDoq13+5THiZSh2N/hAlSBPqxEnH+rdseCpYVQt/j4P/Muld2eHZ29QMl519j2y5cx
         GgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIVy3GeRA5OkZZu6xDvDHdm1GOthqotFd5U/fgk56CY=;
        b=wsf1IaPNHeayyikFaj1oRzv+EHdCrsOifespcW4qsn8kYWBfJy/YrmY9Q7flRl92Nh
         WZ1csSIio76bHupnst/hMQQ9CXJwNl7CZBhE+YAm9XIEOKWdJwuXnBbiiPxA831MeC2U
         d+BRJqiMdAtgIgTt9yx9ydA+jxc0idnI3FbsjGGeKh3LvqSaM7xuAGXEz4TmfFd0PUU5
         d2EfU2sM2sS+XWkL+ZxkwX4FKDUvjcijHkEXMSiaC2wwiLS75QD8ALWUXi1RQ+6hp3cI
         VvzQQosePayUhJc8makXMBDHWa9gDgnghKS+7dqG4JJ069Q0iymSQl4TIWK+mjxzjw7O
         2VAA==
X-Gm-Message-State: ACrzQf0aMq/ptDVArPtJ4Die0SQ+yDCO1SCdM+6FPa/wtGQ0rGQXIJv9
        huM14KnaBwGLY0jl9av+LPs=
X-Google-Smtp-Source: AMsMyM6BXVgmVVcTF7eixvSAbS1wL0OVZiVY3Q/JhtfJEZVGiXULG1OOLs18zbfllXGuFtCIDsZHKg==
X-Received: by 2002:a05:600c:154a:b0:3c9:f0df:1cc with SMTP id f10-20020a05600c154a00b003c9f0df01ccmr2417925wmg.200.1666789639448;
        Wed, 26 Oct 2022 06:07:19 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc:c67c:46e:319e])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5245433wrb.114.2022.10.26.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:07:18 -0700 (PDT)
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
Subject: [PATCH v3 3/9] ARM: dts: imx6qdl-wandboard: Drop clock-names property
Date:   Wed, 26 Oct 2022 14:06:52 +0100
Message-Id: <20221026130658.45601-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index ec6fba5ee8fd..e4f63423d8ee 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -131,7 +131,6 @@ camera@3c {
 		pinctrl-0 = <&pinctrl_ov5645>;
 		reg = <0x3c>;
 		clocks = <&clks IMX6QDL_CLK_CKO2>;
-		clock-names = "xclk";
 		clock-frequency = <24000000>;
 		vdddo-supply = <&reg_1p8v>;
 		vdda-supply = <&reg_2p8v>;
-- 
2.25.1

