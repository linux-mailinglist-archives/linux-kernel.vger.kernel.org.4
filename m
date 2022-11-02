Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5372A616BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKBSUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiKBSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB9B2F388;
        Wed,  2 Nov 2022 11:20:09 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC23566028BD;
        Wed,  2 Nov 2022 18:20:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413207;
        bh=73yq3hSmCgnnBnC9+ZUyzTnv19Mj0CWcIsrmUiNrmxI=;
        h=From:To:Cc:Subject:Date:From;
        b=omK34qDxLzEuDlGtMXDGhcAOcY4mxHxqYYS4VJQp20qGEOIofJX3PmEhQrJXS6RHt
         39fe/AbQJxKAqXZ5KKlg0k2gP/D8pbZGTl18E4kHjW8sgEB7KyxV5F/NifoYyI38q7
         gooAraSdx3SvF0rz3tpLFwGOLuMPcERWAJwZTI8C3m7cDuFfa0uBSwupvNbd6+etB8
         /fuf9ZEXDZJDRknvb7egxXCZ+R56vncD21qZh1ad1nHwQEGPICo018iLqy/CUMuvSF
         6j1KQfr2dKLFmOarx6lC4Hs+V5HFf0VDMCPQxmM0+/G9KxGg7Wo27Hy1iumSxnEUlk
         0WSHSrkT3SLig==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Andy Gross <agross@kernel.org>,
        Derek Fang <derek.fang@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Adjust usage of rt5682(s) power supply properties
Date:   Wed,  2 Nov 2022 14:19:54 -0400
Message-Id: <20221102182002.255282-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series sets straight the usage of power supply properties for the
rt5682 and rt5682s audio codecs.

These properties were already being used by sc7180-trogdor.dtsi (and
derived DTs like sc7180-trogdor-kingoftown.dtsi).

We start by documenting the power supplies that are already in use and
then add few others that were missing to the bindings.

Then we update the drivers to also support the new supplies.

Finally we update the trogdor DTs so they have the newly added but
required supplies and remove a superfluous one that was causing
warnings.

v1: https://lore.kernel.org/all/20221028205540.3197304-1-nfraprado@collabora.com

Changes in v2:
- Made new supply names uppercase to be consistent with the existing
  ones

Nícolas F. R. A. Prado (8):
  ASoC: dt-bindings: realtek,rt5682s: Add AVDD and MICVDD supplies
  ASoC: dt-bindings: realtek,rt5682s: Add DBVDD and LDO1-IN supplies
  ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT supplies
  ASoC: dt-bindings: rt5682: Add DBVDD and LDO1-IN supplies
  ASoC: rt5682s: Support DBVDD and LDO1-IN supplies
  ASoC: rt5682: Support DBVDD and LDO1-IN supplies
  arm64: dts: qcom: sc7180-trogdor: Add missing supplies for rt5682
  arm64: dts: qcom: sc7180-trogdor: Remove VBAT supply from rt5682s

 .../bindings/sound/realtek,rt5682s.yaml       | 23 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5682.txt      | 20 ++++++++++++++++
 .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   |  1 +
 ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts |  1 +
 ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  2 ++
 sound/soc/codecs/rt5682.c                     |  2 ++
 sound/soc/codecs/rt5682.h                     |  2 +-
 sound/soc/codecs/rt5682s.c                    | 22 ++++++++++++++++++
 sound/soc/codecs/rt5682s.h                    |  2 ++
 10 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.38.1

