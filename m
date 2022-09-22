Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3579A5E5EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiIVJtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:49:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E91D4A83;
        Thu, 22 Sep 2022 02:49:15 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 88F5C660221C;
        Thu, 22 Sep 2022 10:49:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663840154;
        bh=/sD//Fx1hRIgFZ1vKpgrsJe4DfP3ojqL+kjqLiG5HQM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ac8iISjW5bF7fiHTQjUlLMkOyosReAbqjI1vruuU2AJnF3BMWGzcSHExlLDelG/Rm
         OEzolRwICeQAoCpaMGZWVGIltjiPG7FMhekes9gNT1ghf+uE0YXRyBKYHmDuyO6551
         mwAIuGBdzE6ojsV0joG3jyPR7FKSvAo8ztMKfmwW+38h7EjYQnwKXf9CaLJdma9lk0
         SY6QJHuhzhdLw5UgCcxvL0rPD0BOzpNVylvuHYf6Hrph4ykC8Uo8LOFmdGxXICvgBO
         YxF2LkN99kmLsikXGrPYxWYkMzH6d1qfvSdPwGcPvjuj993PLU8pS+H74oHaOZ1nZJ
         ZkXe+rymvKnYQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/4] MT8195 Acer Tomato - Audio support
Date:   Thu, 22 Sep 2022 11:49:04 +0200
Message-Id: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

This series enables full support for audio, with DSP, on the Cherry
Chromebooks.
Related ALSA UCM2 configuration was already merged in its upstream
repository [1]: this is fully tested and working as-is since all of
the required fixes for MT8195 SOF drivers were picked and are present
since `next-20220908`.

[1]: https://github.com/alsa-project/alsa-ucm-conf/commit/a59c3b1a57de8eb424c4f754bb031265e856260e

______________________________________
_________ Platform overview: _________

What's still missing?

* Format:    feature  (location)
*
* MediaTek vcodec enc/dec (mt8195.dtsi only)
* PCI-Express WiFi card (mt8195 and mt8195-cherry)
* VDOSYS1 (mt8195.dtsi and mediatek-drm/mmsys drivers)
* DP/eDP outputs for external/internal display (mt8195 and mt8195-cherry)
* LVTS Thermal Sensors (mt8195.dtsi, driver is missing)
* GPU support (clocks and mtk-regulator-coupler are awaiting for review/pick)

AngeloGioacchino Del Regno (4):
  arm64: dts: mediatek: cherry: Add Audio Front End (AFE) support
  arm64: dts: mediatek: cherry: Enable the Audio DSP for SOF
  arm64: dts: mediatek: cherry: Add external codecs and speaker
    amplifier
  arm64: dts: mediatek: cherry: Add sound card configuration

 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  10 ++
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  10 ++
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  10 ++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 109 ++++++++++++++++++
 4 files changed, 139 insertions(+)

-- 
2.37.2

