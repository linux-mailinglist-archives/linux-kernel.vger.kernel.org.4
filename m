Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361CE64D966
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLOKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:20:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A41273;
        Thu, 15 Dec 2022 02:20:08 -0800 (PST)
Received: from xps.home (82-65-172-229.subs.proxad.net [82.65.172.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17D716602C5F;
        Thu, 15 Dec 2022 10:20:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671099606;
        bh=WLY57/vsBcQcsEyV40fycSi6IdmeLYRjKEbqIxSuVAE=;
        h=From:To:Cc:Subject:Date:From;
        b=L4Z7LHOP1m/pl9kidybLzd95BeF3YuK9yATRCRR4ZcXNjaSFVYLRe181UFXJXFwFN
         lPWMylYVLsX3qzBscLwrhwGTB+wtWerzfx6cIiYsX4cE4HT+eIjBrQRPs6tqsUBZac
         T3PAIPwE1fuJEL1AZ+QWSJar6g4ed5Ynx+KOmYeHgyjVdwnp9KAso2VYTBTdg9m9JC
         qJfcCjPNj+UXyo2Fh0cRbYBZWsmarMFrYoNzsZuu/TPu19NXve+4WOGGb8DWGbm18G
         +yAuQMRM1LcwE1cWE0SQjzimBAMpwtE/h+OQ9ag5DyZ/ceWA6DrjVhSzqlemMcgzDx
         ImC/Ev/aZV72w==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Caleb Connolly <kc@postmarketos.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH] arm64: dts: rockchip: fix input enable pinconf on rk3399
Date:   Thu, 15 Dec 2022 11:19:47 +0100
Message-Id: <20221215101947.254896-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the input enable pinconf was introduced, a default drive-strength
value of 2 was set for the pull up/down configs. However, this parameter
is unneeded when configuring the pin as input, and having a single
hardcoded value here is actually harmful: GPIOs on the RK3399 have
various same drive-strength capabilities depending on the bank and port
they belong to.

As an example, trying to configure the GPIO4_PD3 pin as an input with
pull-up enabled fails with the following output:

  [   10.706542] rockchip-pinctrl pinctrl: unsupported driver strength 2
  [   10.713661] rockchip-pinctrl pinctrl: pin_config_set op failed for pin 155

(acceptable drive-strength values for this pin being 3, 6, 9 and 12)

Let's drop the drive-strength property from all input pinconfs in order
to solve this issue.

Fixes: ec48c3e82ca3 ("arm64: dts: rockchip: add an input enable pinconf to rk3399")
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 92c2207e686c..59858f2dc8b9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2221,13 +2221,11 @@ pcfg_input_enable: pcfg-input-enable {
 		pcfg_input_pull_up: pcfg-input-pull-up {
 			input-enable;
 			bias-pull-up;
-			drive-strength = <2>;
 		};
 
 		pcfg_input_pull_down: pcfg-input-pull-down {
 			input-enable;
 			bias-pull-down;
-			drive-strength = <2>;
 		};
 
 		clock {
-- 
2.35.1

