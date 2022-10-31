Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EAF614188
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJaXWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJaXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0429915808;
        Mon, 31 Oct 2022 16:22:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a14so18049534wru.5;
        Mon, 31 Oct 2022 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyD58U8XfTPLhP8L6dYQRdSftQvUir8wfXrJ1EL57to=;
        b=TNYP7upQ+XliKy6Oy7PDt04rpganc5iZE4z0navqKYlnSR/R7ix1GtEMsNLSqDj2QI
         AmXDEXzES5/rm9GUZmpRVlG+ZQhuTCFtsOQZUnqU2EJ6vEN7ShTffbPl91t58QJSb/8J
         kZQk8XH8CzIxBQf9OxHSxdyz0FAMuyyZqLTvCcd2oDa656OiEFZp/lwgyl2aI3Gtpmti
         rgiPkhc8Ok6ayKY8i0evCl7Mhp/flXoBlBlrdR3HDVFjPEB99hEX0ZnYOvm9EPx/iKur
         XuCMtg+RKWWU3UpoAcQoD43iZ9IBy3I7jMAe9ViZ/TLqB0cyDwt5ZLaGN+YxHSYjXdY4
         Mn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyD58U8XfTPLhP8L6dYQRdSftQvUir8wfXrJ1EL57to=;
        b=LcHPQY0YQ83/LNb2f68u9LANbOVoe0W4YLij8JCqzhB+3RZRyTRweTw55y63xyrmNO
         vbGnSVKBm16XJMts6BcurY0Zeyjt2M5TsOJwOr7SJNXqmUcLn3cZlvWjApeOANdAqaAc
         j8D1HwBjc0eHV+ZUibu20w80lOQ5+uJNKlkEoEauBEQ4PKOkYQ+2RwOWZqHVfBeztXJU
         2UAmyDigNSTbQthL5skKKWjUI+Fe/fC7/+0ov/sAqNQ/E0yUHcWeZlI6LNYHl0goyzoq
         JKUlfHiA35IVo5GJP/XzixTM6dosnW9AQjLBD5UWzcEETeKGduLZhBpswk2p8hc7EXzK
         97YA==
X-Gm-Message-State: ACrzQf2dAhK4cj4uD+fYB6OgCcdhzp8T/TVvuNKHKSliiaIzOHUlU2+d
        jiqhmTQkZdE/BjiMx9JJ498=
X-Google-Smtp-Source: AMsMyM4+nWVJ22rNl4L7Cw61VJfAK+GGQ3uEGtoGTMf8OXpswZoCAsaKIvLrAZEGv01WVC3JFOsbVw==
X-Received: by 2002:a5d:44d2:0:b0:236:d8c5:122e with SMTP id z18-20020a5d44d2000000b00236d8c5122emr3142672wrr.611.1667258530433;
        Mon, 31 Oct 2022 16:22:10 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:09 -0700 (PDT)
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
Subject: [PATCH v4 3/9] ARM: dts: imx6qdl-wandboard: Drop clock-names property
Date:   Mon, 31 Oct 2022 23:21:56 +0000
Message-Id: <20221031232202.131945-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This is in preparation for removal for clock-names property from the DT
binding.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
---
v3->V4
* Included Ack from Shawn

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

