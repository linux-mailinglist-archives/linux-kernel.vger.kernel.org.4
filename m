Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F407E6F0335
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjD0JRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbjD0JRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:17:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05D4ED0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:17:02 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id A761F1BF20F;
        Thu, 27 Apr 2023 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1682587021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5d+itg7Hh9nGexE8xtDQBtvYxB28npggmEJJymVnOx0=;
        b=GiRAFr/UTTGAFRwKFq02UQ3SwuendpSDUVIwVn5Lk3RL8sQiji6+GNYB+ncXZGgcINis2i
        +hEu6FMUYS79zqH8yhix+kKfWPGUBo+rpAHBsdYsk57vUkb3k71Y9YsADICRi1UtCcSPFu
        SPRGwpbzcb+YwciZdpbeMznGr9bq22Rwd6b41s5jf1IaHaaRuDQd5QCwbly74kn8+BpsLU
        oAMDEFV2mXmo/l4ceJ9uWfxrqvEzrOHjpBaN2fEydUYrKIFJp5dEDtj1BaLXLnHvkAZdcX
        IP6yphZGlER3ked+FWv/4ND24J7f3rpMmHmKQ0FWg4ZnoZMg388aa3Osbml03A==
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
Subject: [PATCH v3 4/7] arm64: dts: allwinner: a64: reset pll-video0 rate
Date:   Thu, 27 Apr 2023 11:16:08 +0200
Message-Id: <20230427091611.99044-5-me@crly.cz>
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

With pll-mipi as its source clock, the exact rate to which TCON0's data
clock can be set to is constrained by the current rate of pll-video0.
Unless changed on a request of another consumer, the rate of pll-video0
is left as inherited from the bootloader.

The default rate on reset is 297 MHz, a value preferable to what it is
later set to in u-boot (294 MHz). This happens unintentionally though,
as u-boot, for the sake of simplicity, rounds the rate requested by DE2
driver (297 MHz) to 6 MHz steps.

Reset the PLL to its default rate of 297 MHz.

Signed-off-by: Roman Beranek <me@crly.cz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e6a194db420d..cfc60dce80b0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -667,6 +667,9 @@ ccu: clock@1c20000 {
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+
+			assigned-clocks = <&ccu CLK_PLL_VIDEO0>;
+			assigned-clock-rates = <297000000>;
 		};
 
 		pio: pinctrl@1c20800 {
-- 
2.34.1

