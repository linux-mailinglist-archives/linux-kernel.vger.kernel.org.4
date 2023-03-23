Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246DD6C6F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjCWRcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjCWRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:31:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBCB36451
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so2793126pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679592695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6LXKCEb3/BINodw1aD0uX0Oh1YqBoNeM7/LB28/UeE=;
        b=NK9khFXdbhd8AKbccKVwlYyqpaZSoBXNzGIi3sVGUjFITXPQheAzihAZfIYb9p+oxb
         XUEpywwYq0mqN5UgRT4jN3CL+nDWq1ly1yWETTmghx9I7R6rh1PuH7RfMF66fg37AzoU
         FDVkOPpzOxlYJBbqQ9zCj6qxz0ADFmmhi3w5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6LXKCEb3/BINodw1aD0uX0Oh1YqBoNeM7/LB28/UeE=;
        b=KR1tDelMC7I2pOVFo12OJ40RG/outl2Ry2j/zP50sPGY7zuPrrifReHtEVVNYQiFuL
         21Tb7WI2vpZaNcafI3uxrc01H4VCsKLLaSrqJnZArO4XGyLXzJ1ab67j7AcMQI/uGQgJ
         fAcI4PQ+GdiDavJtjggOf0TY4KEo2Og/emVPaswKi8rsLmLttBfHCI4WSjl8R8bLnEq6
         1LvA7Xh5aobD37iUo1vfU3/fBDt8DY0UMNMLCShfCXDnwlwtlud09kxApYqIlrUuEeAE
         wke5LVkUQRXzIh7PhD2kPyg5+xNWfEvtve46bwHvJ/BG+GX573XBECfo6xcy0LIpnPYz
         rDiQ==
X-Gm-Message-State: AO0yUKWcRVJ4pUyA4a2vqYDdUZSQI0E0cz7KEymtdCpBDRMqy7U/AEWx
        XsDzfpoMV80mtSMGlfmi5meIng==
X-Google-Smtp-Source: AK7set8eHb9MWIbayLU4pYFk+mcrLE3Fp8YxxyVR5lvyiNfDfEC1S4tIYQcJryxp4TjSbPKIz4IrPA==
X-Received: by 2002:a05:6a20:8b83:b0:da:5ab7:8ce9 with SMTP id m3-20020a056a208b8300b000da5ab78ce9mr271523pzh.22.1679592695237;
        Thu, 23 Mar 2023 10:31:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16d3:ef20:206a:6521])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0061a6f4c1b2bsm12613546pfm.171.2023.03.23.10.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:31:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] arm64: dts: qcom: sc7180: Fix trogdor qspi pin config
Date:   Thu, 23 Mar 2023 10:30:16 -0700
Message-Id: <20230323102605.12.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230323173019.3706069-1-dianders@chromium.org>
References: <20230323173019.3706069-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial
trogdor and lazor dt") we specified the pull settings on the boot SPI
(the qspi) data lines as pullups to "park" the lines. This seemed like
the right thing to do, but I never really probed the lines to confirm.

Since that time, I've done A LOT of research, experiements and poking
of the lines with a voltmeter.

A first batch of discoveries:
- There is an external pullup on CS (clearly shown on schematics)
- There are weak external pulldowns on CLK/MOSI (believed to be Cr50's
  internal pulldowns)
- There is no pull on MISO.
- When qspi isn't actively transferring it still drives CS, CLK, and
  MOSI. CS and MOSI are driven high and CLK is driven low. It does not
  drive MISO and (if no internal pulls are enabled) the line floats.

The above means that it's good to have some sort of pull on MISO, at
the very least. The pullup that we had before was actually fine (and
my voltmeter confirms that it actually affected the state of the pin)
but a pulldown would work equally well (and would match MOSI and CLK
better).

The above also means that we could save a tiny bit of power (not
measurable by my setup) by setting up a sleep state for these pins. If
nothing else this prevents us from driving high against Cr50's
internal pulldown on MOSI. However, Qualcomm has also asserted in the
past that it burns a little extra power to drive a pin, especially
since these are configured with a slightly higher drive strength

Let's fix all this. Since the external pulls are different for the two
data lines, we'll split them into separate configs. Then we'll change
the MISO pin to a pulldown and add a sleep state.

On a slightly tangental (but not totally unrelated note), I also
discovered some interesting things with these pins in suspend. First,
I found that if we don't switch the pins to GPIO that the qspi
peripheral continues to drive them in suspend. That'll be solved by
what we're already doing above. Second, I found that something in the
system suspend path (after Linux stops running) reconfigures these
pins so that they don't have their normal pulls enabled but instead
change to "keepers" (bias-bus-hold in DT speak). If a pin was floating
before we entered suspend then it would stop floating. I found that I
could manually pull a pin to a different level and then probe it and
it would stay there. This is exactly keeper behavior. With the
solution we have the switch to "keeper" doesn't matter too much but
it's good to document.

While talking about "keepers", it can also be noted that I found that
the "keepers" on these pins were at least enough to win a fight
against Cr50's internal pulls. That means it's best to make sure that
the state of the pins are already correct before the mysterious
transition to a keeper. Otherwise we'll burn (a small amount of) power
in S3 via this fight. Luckily with the current solution we don't hit
this case.

NOTE: I've left "sc7180-idp" behavior totally alone in this patch. I
didn't add a sleep state and I didn't change any pulls--I just adapted
it to the fact that the data lines have separate configs. Qualcomm
doesn't provide me with schematics for IDP and thus I don't actually
know how the pulls are configured. Since this is just a development
platform and worked well enough, it seems safer to leave it alone.

Dependencies:
- This patch has a hard dependency on ("pinctrl: qcom: Support
  OUTPUT_ENABLE; deprecate INPUT_ENABLE"). Something in the boot code
  seemed to have been confused and thought it needed to set the
  "OUTPUT ENABLE" bit for these pins even though it was using them as
  SPI. Thus if we don't honor the "output-disable" property we could
  end up driving the SPI pins while in sleep mode.
- In general, it's probably best not to backport this to a kernel that
  doesn't have commit d21f4b7ffc22 ("pinctrl: qcom: Avoid glitching
  lines when we first mux to output"). That landed a while ago, but
  it's still good to be explicit in case someone was backporting. If
  we don't have that then there might be a glitch when we first switch
  over to GPIO before we disable the output.
- This patch _doesn't_ really have any dependency on the qspi driver
  patch that supports setting the pinctrl sleep state--they can go in
  either order. If we define the sleep state and the driver never
  selects it that's fine. If the driver tries to select a sleep state
  that we don't define that's fine.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
v1 of this patch was ("arm64: dts: qcom: sc7180: Fix trogdor qspi pull
direction") [1]. Since then, I've spent time running experiments where
I tried lots of different combinations and then probed the GPIOs with
a multimeter to figure out what's happening. As a result, it's now at
the end of a somewhat larger series.

I should note that I've removed the "Fixes" tag of this patch. While
it still technically does "fix" the old behavior, the old behavior
really wasn't terrible (a miniscule amount of extra power draw). It's
probably not worth the risk that adding "Fixes" will cause it to get
backported without the pinctrl support (see "Dependencies" in the
patch description).

[1] https://lore.kernel.org/r/20230213165743.1.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid

 arch/arm64/boot/dts/qcom/sc7180-idp.dts      |  9 ++++--
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 34 ++++++++++++++++----
 arch/arm64/boot/dts/qcom/sc7180.dtsi         |  9 ++++--
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index c3bdd3295c02..44c27b4eac45 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -354,7 +354,7 @@ &qfprom {
 &qspi {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_clk &qspi_cs0 &qspi_data01>;
+	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data0>, <&qspi_data1>;
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
@@ -512,8 +512,11 @@ &qspi_cs0 {
 	bias-disable;
 };
 
-&qspi_data01 {
-	/* High-Z when no transfers; nice to park the lines */
+&qspi_data0 {
+	bias-pull-up;
+};
+
+&qspi_data1 {
 	bias-pull-up;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 39100b0c1140..ca6920de7ea8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -424,8 +424,9 @@ &qfprom {
 
 &qspi {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data01>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data0>, <&qspi_data1>;
+	pinctrl-1 = <&qspi_sleep>;
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
@@ -1046,17 +1047,20 @@ &pri_mi2s_mclk_active {
 };
 
 &qspi_cs0 {
-	bias-disable;
+	bias-disable;		/* External pullup */
 };
 
 &qspi_clk {
 	drive-strength = <8>;
-	bias-disable;
+	bias-disable;		/* Rely on Cr50 internal pulldown */
 };
 
-&qspi_data01 {
-	/* High-Z when no transfers; nice to park the lines */
-	bias-pull-up;
+&qspi_data0 {
+	bias-disable;		/* Rely on Cr50 internal pulldown */
+};
+
+&qspi_data1 {
+	bias-pull-down;
 };
 
 &qup_i2c2_default {
@@ -1336,6 +1340,22 @@ p_sensor_int_l: p-sensor-int-l-state {
 		bias-disable;
 	};
 
+	qspi_sleep: qspi-sleep-state {
+		pins = "gpio63", "gpio64", "gpio65", "gpio68";
+
+		/*
+		 * When we're not actively transferring we want pins as GPIOs
+		 * with output disabled so that the quad SPI IP block stops
+		 * driving them. We rely on the normal pulls configured in
+		 * the active state and don't redefine them here. Also note
+		 * that we don't need the reverse (output-enable) in the
+		 * normal mode since the "output-enable" only matters for
+		 * GPIO function.
+		 */
+		function = "gpio";
+		output-disable;
+	};
+
 	qup_uart3_sleep: qup-uart3-sleep-state {
 		cts-pins {
 			/*
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index fe62ce516c4e..b2fcf0b58722 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1535,8 +1535,13 @@ qspi_cs1: qspi-cs1-state {
 				function = "qspi_cs";
 			};
 
-			qspi_data01: qspi-data01-state {
-				pins = "gpio64", "gpio65";
+			qspi_data0: qspi-data0-state {
+				pins = "gpio64";
+				function = "qspi_data";
+			};
+
+			qspi_data1: qspi-data1-state {
+				pins = "gpio65";
 				function = "qspi_data";
 			};
 
-- 
2.40.0.348.gf938b09366-goog

