Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC809716C02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjE3SMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjE3SL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:11:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6275F3;
        Tue, 30 May 2023 11:11:54 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3512C6606E76;
        Tue, 30 May 2023 19:11:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685470313;
        bh=iHcb9BFc/X1bbxtUKpaxg5GTnEgeVVJ1yraooXSIn1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVgtbEN3hqRjjWYAhVn3DNUVrLbzogAUD3ZcQ6srLv0f6+cM8SjLXGVgwHRq751qy
         AgUnx+6VWIYyHU8oLQ5/WBDwbY/Z8sGpfUwOCuKp/2LH5EYVhEsRfBDh/X4tvdhXAK
         FCABiS0A1FDOV/C7rJMrx8UdWqQvf6fPQeJI94xn6D091IxAsBvJYBFq5LLbo97eY5
         f4csibbvqoXLChNyuFKbc/4iblvSsZhz+hY5RBjlTyE9Nil/Xz4qxaa47CLjFASdfv
         xwM3QLj7S02aaP9MQ2X2T057l51nlM6kDQeyq0HtRfZJg5ovfDqT05zaL07SIavHbt
         Oeov1kSSDiI/Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Assign ES8316 MCLK rate on rk3588-rock-5b
Date:   Tue, 30 May 2023 21:11:40 +0300
Message-Id: <20230530181140.483936-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530181140.483936-1-cristian.ciocaltea@collabora.com>
References: <20230530181140.483936-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2S0_8CH_MCLKOUT clock rate on Rock 5B board defaults to 12 MHz and
it is used to provide the master clock (MCLK) for the ES8316 audio
codec.

On sound card initialization, this limits the allowed sample rates
according to the MCLK/LRCK ratios supported by the codec, which results
in the following non-standard rates: 15625, 30000, 31250, 46875.

Hence, the very first access of the sound card fails:

  Broken configuration for playback: no configurations available: Invalid argument
  Setting of hwparams failed: Invalid argument

However, all subsequent attempts will succeed, as the audio graph card
will request a correct clock frequency, based on the stream sample rate
and the multiplication factor.

Assign MCLK to 12.288 MHz, which allows the codec to advertise most of
the standard sample rates.

Fixes: 55529fe3f32d ("arm64: dts: rockchip: Add rk3588-rock-5b analog audio")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 3e4aee8f70c1..30cdd366813f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -133,6 +133,8 @@ es8316: audio-codec@11 {
 		reg = <0x11>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
 		clock-names = "mclk";
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
 		#sound-dai-cells = <0>;
 
 		port {
-- 
2.40.1

