Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB4F611BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJ1Uzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJ1Uzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:55:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48B51D2F7D;
        Fri, 28 Oct 2022 13:55:48 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16028660293F;
        Fri, 28 Oct 2022 21:55:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990546;
        bh=iSgsGlmn8UzFPy/Bi6ux9UCWV6sTSj4Y28v6dJJ/BVc=;
        h=From:To:Cc:Subject:Date:From;
        b=C7RFbtoqRooAQPAssjew96nxn7HNdspClPWlfGz2SoJULrIu+2lIB88QzX1GXDBDB
         r3d2Xc6a+cgIi/tjSsOWCktvM+Gn9YtBDgfw2s3rcZ/1CVY36Qy8Fi4wtEOUT47F+k
         rv2k0L3tNocOPg1YGL4Zb78aPqZ0bgwEeHDqOtzGIwsGsdt48H1S4SNHhy+9Kw7wU5
         +0lUBCGkmZB1p1RfAMcFyX0ivCe9f1zrhq35POGZt1hsihLcWPfaRoX0fRlmAT301i
         HTbHjNqoZy7ClBn3KbsHkJC9YZno0YKHdw0t2W6oHdgHINF69vlj/G7OgtvcRRIdJM
         2jmXm+sO9ge1A==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH 0/8] Adjust usage of rt5682(s) power supply properties
Date:   Fri, 28 Oct 2022 16:55:32 -0400
Message-Id: <20221028205540.3197304-1-nfraprado@collabora.com>
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


Nícolas F. R. A. Prado (8):
  ASoC: dt-bindings: realtek,rt5682s: Add AVDD and MICVDD supplies
  ASoC: dt-bindings: realtek,rt5682s: Add dbvdd and ldo1-in supplies
  ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT supplies
  ASoC: dt-bindings: rt5682: Add dbvdd and ldo1-in supplies
  ASoC: rt5682s: Support dbvdd and ldo1-in supplies
  ASoC: rt5682: Support dbvdd and ldo1-in supplies
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

