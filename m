Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28AC6932F9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBKSJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 13:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBKSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 13:09:01 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC849199D1;
        Sat, 11 Feb 2023 10:08:55 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pQuId-002kLh-MN; Sat, 11 Feb 2023 19:08:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=zqbmGy0Jv3vJGh6aAHHKeDDZRhY9sXO436cNNDadWT8=; b=Go1hEZsENvYi1EX69q3k7cU/r+
        iInM6Er3NdykzgXG6J41flKQ88txUv5FVrah+mhS7+cKDDJSk01oINQQi2xMffl+wPVF2P7xWBMuC
        7/Dad1S16kwSl9N9Tpas5D+wGSInWA6aa1WHgNJOf2kdfas3pYmtuVwngToUI6Fhi+AEMfr9cTnRv
        aVdxc3d6Fj6nRHlvdmzW1pxWM+ZqbCzNAEbKXEbfNJA7BtIznxKOH7Zd9uDvJtVAncoh7QfiFEl6i
        wRVwPQDiINnOwTaFLHN9ueqOR67Dl9kW5+BRHIHQWveWbYhCS8RIIL4zKhfnaJAaIBMT2y00KOqDO
        6XCS38Ig==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=zqbmGy0Jv3vJGh6aAHHKeDDZRhY9sXO436cNNDadWT8=; b=aD8g22JUJdi6Gpfk9VpgXfG1i6
        S+hfGkMqHFky338JQRi30NKu7BzAghc3z4O0STe83eVfRk7Hm29Ryc/TWYvU062noS+8khzp1qQzT
        jv/f2Mi2ROfXdat0BoRlgw8+nhh7hFzEjPjb0GO/0pB3HIdnLLPZ6FTa1fpVfxSKOQHM3m8pfEuXd
        N2rTh8HlWYqmHeOCNyc7u+SrIdG1fFtB5x0p5MlUMyDKznV9PvRcBzlEgIQIRZzxfp1pIYz+Z7ZFz
        bZUA8YWYjb5ro+y7CVnzORWh39AOb6pJWkgLQ3EgIwYXFLYynOyqYgCq55NA1EzjPJFpmKpoDSjoT
        5iQOpBYA==;
Received: from [2a02:908:1b0:8800:d984:3cf8:3cb3:b087]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pQuIa-000f1N-PK; Sat, 11 Feb 2023 19:08:35 +0100
Message-ID: <200d4457-9801-c862-0e86-850e3188f765@flying-snail.de>
Date:   Sat, 11 Feb 2023 19:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH] pinctrl: sunxi: set minimal debounce on input-debounce 0
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
 <20230207011608.2ce24d17@slackpad.lan>
 <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
 <20230209202952.673d5a60@slackpad.lan>
 <20230210082936.qefzz4fsp3jpalvp@houat>
 <20230210094425.474cfba5@donnerap.cambridge.arm.com>
 <20230210100620.z6j7rvkiwyu7paij@houat>
 <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
 <ba463d40-3d39-a621-b198-191fdbe239a1@feldner-bv.de>
 <20230211151358.3467b4f9@slackpad.lan>
From:   Andreas Feldner <pelzi@flying-snail.de>
In-Reply-To: <20230211151358.3467b4f9@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sunxi-h3-h5 based boards have no support for switching
off IRQ debouncing filter. This would be the expected
behaviour of value 0 for the general pinctl parameter
input-debounce.
The current driver implementation ignores value 0
for input-debounce, leaving the chip's default. This
default, however, is not minimal, but equivalent to
value 31 (microseconds).

This patch does not ignore value 0 but instead makes
sure the corresponding IRQ debounce filter is set
to the shortest time selectable, i. e. the fast
oscillator with a divider of 1 == (2 ^ 0).

The current default behaviour is explicitly ensured
by including input-debounce=<31 31> in the relevant
part of the devicetree.

Fixes: 7c926492d38a ("pinctrl: sunxi: Add support for interrupt debouncing")

Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
---
  arch/arm/boot/dts/sunxi-h3-h5.dtsi    |  1 +
  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 40 +++++++++++++++------------
  2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi 
b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 686193bd6bd9..e9ed4948134d 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -410,6 +410,7 @@ pio: pinctrl@1c20800 {
              #gpio-cells = <3>;
              interrupt-controller;
              #interrupt-cells = <3>;
+            input-debounce = <31 31>;

              csi_pins: csi-pins {
                  pins = "PE0", "PE2", "PE3", "PE4", "PE5",
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c 
b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f35179eceb4e..6798c8f4067e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1444,29 +1444,35 @@ static int sunxi_pinctrl_setup_debounce(struct 
sunxi_pinctrl *pctl,
          if (ret)
              return ret;

-        if (!debounce)
-            continue;
-
-        debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC, debounce);
-        losc_div = sunxi_pinctrl_get_debounce_div(losc,
-                              debounce_freq,
-                              &losc_diff);
-
-        hosc_div = sunxi_pinctrl_get_debounce_div(hosc,
-                              debounce_freq,
-                              &hosc_diff);
-
-        if (hosc_diff < losc_diff) {
-            div = hosc_div;
-            src = 1;
+        if (debounce) {
+            debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC, debounce);
+            losc_div = sunxi_pinctrl_get_debounce_div(losc,
+                                  debounce_freq,
+                                  &losc_diff);
+
+            hosc_div = sunxi_pinctrl_get_debounce_div(hosc,
+                                  debounce_freq,
+                                  &hosc_diff);
+
+            if (hosc_diff < losc_diff) {
+                div = hosc_div;
+                src = 1;
+            } else {
+                div = losc_div;
+                src = 0;
+            }
          } else {
-            div = losc_div;
-            src = 0;
+            /* lowest time as best approximation to "off" */
+            div = 0;
+            src = 1;
          }

          writel(src | div << 4,
                 pctl->membase +
                 sunxi_irq_debounce_reg_from_bank(pctl->desc, i));
+
+        pr_info("Debounce filter for IRQ bank %d configured to %d us 
(reg %x)\n",
+            i, debounce, src | div << 4);
      }

      return 0;
-- 
2.30.2


