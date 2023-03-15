Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A754D6BAF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCOLsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCOLsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:48:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17B81C5AC;
        Wed, 15 Mar 2023 04:48:13 -0700 (PDT)
Received: from localhost (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9185666003AC;
        Wed, 15 Mar 2023 11:48:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678880891;
        bh=QMdRoHZDA4Dzb4ZItQ6gCETIH96B+vuVwaf66nkbnMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bj2xu6gGH92QEICLrGXFl386kUFglMAxEePZm/i3SmcJEKbpiM06LNDvC992CaPby
         NM5t+sCRjcezTbr2NabWD08SWWwBmtibVsTapQxEK5mmB3qBMqm6A3ZR3zGvTqK2X/
         kq1tpf4ei/myrqWjdSjmx33y1vbA3Buej4dDpK5R58c44aTHtliZQbl8QPa5lGIgMm
         1Wde+f/mne8pQmnJ8dV2Z1/44cIZWLAcw0wV8eDw5pqm2mchbH57paOvrdGTazIPO3
         Haypn6anq0fRgT56oE4lMtcT9wJBSs1PwqkREBZoFgiIm6TTJ8E18JZQyaJqgJ6+sB
         vwoxdhZxRe/tA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 00/11] Enable I2S support for RK3588/RK3588S SoCs
Date:   Wed, 15 Mar 2023 13:47:55 +0200
Message-Id: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are five I2S/PCM/TDM controllers and two I2S/PCM controllers embedded 
in the RK3588 and RK3588S SoCs. Furthermore, RK3588 provides four additional
I2S/PCM/TDM controllers.

This patch series adds the required device tree nodes to support all the above.

Additionally, it enables analog audio support for the Rock 5B SBC, which has
been used to test both audio playback and recording.

Note that some of the DT bindings fixes in this series are not particularly
related to I2S, but are required for a proper dtbs_check validation.

Cristian Ciocaltea (11):
  dt-bindings: firmware: arm,scmi: Document assigned-clocks and
    assigned-clock-rates
  dt-bindings: serial: snps-dw-apb-uart: Relax dma-names order
    constraint
  ASoC: dt-bindings: everest,es8316: Document audio graph port
  ASoC: dt-bindings: rockchip: Document audio graph port
  ASoC: dt-bindings: rockchip: i2s-tdm: Document audio graph port
  ASoC: dt-bindings: rockchip: i2s-tdm: Document power-domains
  ASoC: dt-bindings: rockchip: Add compatible for RK3588
  ASoC: rockchip: i2s: Add compatible for RK3588
  arm64: dts: rockchip: rk3588s: Add I2S nodes
  arm64: dts: rockchip: rk3588: Add I2S nodes
  arm64: dts: rockchip: rk3588-rock-5b: Add analog audio

 .../bindings/firmware/arm,scmi.yaml           |   3 +
 .../bindings/serial/snps-dw-apb-uart.yaml     |  10 +-
 .../bindings/sound/everest,es8316.yaml        |   4 +
 .../bindings/sound/rockchip,i2s-tdm.yaml      |   7 +
 .../bindings/sound/rockchip-i2s.yaml          |   5 +
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  62 ++++++++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  68 ++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 148 ++++++++++++++++++
 sound/soc/rockchip/rockchip_i2s.c             |   1 +
 9 files changed, 305 insertions(+), 3 deletions(-)

-- 
2.39.1

