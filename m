Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E79461418A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJaXWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJaXWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B2C15810;
        Mon, 31 Oct 2022 16:22:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y16so18011105wrt.12;
        Mon, 31 Oct 2022 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9VHYXuPl7lW+Y4lOtJuafMlo94cKBcVsHf9qYkj+B8=;
        b=qf0tMMl7snTqw2mpt9fryEeYpgvyZJbJ0NM8T0rxZudbdjYlSSzz2Y/dp35RwtmISC
         up1dW4cn2X+ky4dtt75aP5ApvwXapf8dnzExcC6lwQ/PhSIMXfy5YVBjt0tcbZCp5f5J
         CbsWgcSeYSkWwZihcpbq/7ycY1sT63Ppdt5oaHWPbBWuzfGScxt/9S1Yj7We+BAbZEaT
         gOtp3Y3mLD+pfcFrNMpijr5V6FbCf7J6J2xwDMFraC/B/eTWTwKjGp/3cuSo9dTHL9HD
         XCq8jqtREWmnYLszNnJsTQMNx748mzLtK0DtQM10PWho2gJE0+Y5yfC74H7Bw3Jsb4eu
         Lo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9VHYXuPl7lW+Y4lOtJuafMlo94cKBcVsHf9qYkj+B8=;
        b=jV/oKax3QRoOVFAtvBAAwXnBIvr3jhbeSi58iVqmYwpipKlb0Ub6DnBO7u5QoCvO6Y
         zEqOqPcp/f8Y+CzaV4PQd573f/l97iGTkOAPayboz/1/N+w6TVoet/0BjmJRuXq440fc
         b8ynSidvl8W5U88LX6aOFE32dT/yLu7+l5d4T/30gq6Oo/bBFYQrARg+YSCz7j6v35lZ
         gxWW64PmauD+VEWbCEFJTYzdCr2l4h5pixY0gZT8WoQvZXw32clv6FEMlyj8I6qlcM27
         3aJ5Xmg8e2M4wYLORbiEbp8/v/PJUBpx0VSQOpFrIpCRw3l9NeUavVzQQZd40Sfpii25
         ncEg==
X-Gm-Message-State: ACrzQf22JeF7KPl3wYs7dlKM6t6w57MvckltUNj8aKVME0CBx/iPgi/m
        4JzOEhtDjC9Akg362M/UP0Y=
X-Google-Smtp-Source: AMsMyM5232K+NHOFlqCTn5WLGMbE8QDMZMvrRDvJqDG488x9XN1/k8JSsvrExIamD5sOLVNyAJzIwQ==
X-Received: by 2002:adf:cd86:0:b0:236:6056:14d3 with SMTP id q6-20020adfcd86000000b00236605614d3mr10035142wrj.30.1667258531659;
        Mon, 31 Oct 2022 16:22:11 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:11 -0700 (PDT)
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
Subject: [PATCH v4 4/9] arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Drop clock-names property
Date:   Mon, 31 Oct 2022 23:21:57 +0000
Message-Id: <20221031232202.131945-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3->V4
* Included Ack/RB from Geert

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

