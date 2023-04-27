Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB316F0334
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbjD0JRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243022AbjD0JRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:17:00 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77ED4ED8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:16:59 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id F39831BF20E;
        Thu, 27 Apr 2023 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1682587018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S23886ftCV2z3JzYA86agYfVu4I9nMhyGAcsGtlcMm8=;
        b=SlOp8M679mlprn5QF4T4Z/1qQkN/zzBVlLyWxep4ucMjj9ZC552ld1lfvvIV+hK5ySEI2/
        AYCDGHSyvYsgtd3gAXrH802/kInXb+iu2NlWhCPGUpH+eRuxqecYctfBauG9LBCJkd6HCR
        a7ZPdLtGuzUxbRsBVIfEA2CV63+XFajwOaMjDrm9wbeIh07ABbxyXQ6P128nlcg1ouyJGL
        rEv1NFtWEnx7sgglpkPriB36UohdHWGK2Ki1gwjfr8xbNhp8E/EPmxt4POEZ5YM/yfRJvp
        91U+4P6duge1qherK8l3MAhKaWXPyMDL4vgx/vyxc6/majm44v8URFUmz3VweQ==
From:   Roman Beranek <me@crly.cz>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] arm64: dts: allwinner: a64: assign PLL_MIPI to CLK_TCON0
Date:   Thu, 27 Apr 2023 11:16:07 +0200
Message-Id: <20230427091611.99044-4-me@crly.cz>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20230427091611.99044-1-me@crly.cz>
References: <20230427091611.99044-1-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign pll-mipi parent to tcon0's source clock via 'assigned-clocks'.

Signed-off-by: Roman Beranek <me@crly.cz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 62f45f71ec65..e6a194db420d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -411,6 +411,8 @@ tcon0: lcd-controller@1c0c000 {
 			#clock-cells = <0>;
 			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
 			reset-names = "lcd", "lvds";
+			assigned-clocks = <&ccu CLK_TCON0>;
+			assigned-clock-parents = <&ccu CLK_PLL_MIPI>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.34.1

