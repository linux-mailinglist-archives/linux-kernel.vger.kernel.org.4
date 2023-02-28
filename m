Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339E76A5703
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjB1Kry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB1Krw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:47:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD72127486;
        Tue, 28 Feb 2023 02:47:50 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 017656602FD5;
        Tue, 28 Feb 2023 10:47:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677581269;
        bh=UYlZn2m3FLwAJmop3xVRjsR84HG36BvM+Lh813y5jmo=;
        h=From:To:Cc:Subject:Date:From;
        b=VyttjHMzS5vmcW/yO/9GA6k8V620wwbGBFYaxJflUaXcG719+h6gTsKSTLuOKCsJf
         Axf/NSHmEys1Scpkd8PpC9U9eg05C6yTMEVJ+Q+A7sDzYIoDDCyiqNMDPm7Lsp8bLN
         ZJXx1FTYY6UhgDRQy2P+HZKxMhqg2gE29aJ7I5LKdwvDGzQgLKvbN2JA1o/TgZdWHM
         PHAHGDU8fPUiSlaw5VmFuRvaJEGgZnLIhUkHHfOl69elQyli2CDugjrYXAwwNhujTu
         vDbuwERGwmFyHfftPBnhuxLYdV+zQMnAiP+vq7z+5+nT7FimuCVpjiFKuAGMWsyIqd
         F2fIZa+ouErAQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v3 00/18] Enable GPU with DVFS support on MediaTek SoCs
Date:   Tue, 28 Feb 2023 11:47:23 +0100
Message-Id: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
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

Changes in v3:
 - Changed MT8186 compatibles for new bindings
 - Added min/max voltage overrides for vgpu/vsram_gpu on
   mt8183-pumpkin and evb as suggested by Chen-Yu
 - Cosmetic fixes for "arm64: dts: mediatek: mt8192: Add GPU nodes"

Changes in v2:
 - Changed MT8186 to use only two power domains for the GPU.

We finally have working GPU DVFS on MediaTek SoCs.
On Panfrost.
For real.
...and the best part is that it's going upstream.

In order to get GPU DVFS working, it was necessary to satisfy a
specific constraint (which is different, depending on the SoC)
between two regulators: GPU VCORE and GPU SRAM.
This was done through adding the mtk-regulator-coupler driver,
which transparently manages the voltage relation between these
two vregs, hence completely eliminating the need to manage these
regulators in the Panfrost driver; this solves the long standing
issue with devfreq+opp tables not supporting managing voltages
for two regulators per opp entry out of the box, due to which
we never got GPU DVFS on those SoCs, often locking them out to
a low GPU frequency.

This changes. Right now!

Tested on MT8192, MT8195 Chromebooks.

This series depends on [1].

[1]: https://lore.kernel.org/lkml/20230228102704.708150-1-angelogioacchino.delregno@collabora.com/

Alyssa Rosenzweig (2):
  arm64: dts: mediatek: mt8192: Add GPU nodes
  arm64: dts: mediatek: mt8192-asurada: Enable GPU

AngeloGioacchino Del Regno (15):
  arm64: dts: mediatek: mt8183-kukui: Couple VGPU and VSRAM_GPU
    regulators
  arm64: dts: mediatek: mt8183-kukui: Override vgpu/vsram_gpu
    constraints
  arm64: dts: mediatek: mt8183: Remove second opp-microvolt entries from
    gpu table
  arm64: dts: mt8183-pumpkin: Couple VGPU and VSRAM_GPU regulators
  arm64: dts: mediatek: mt8183-evb: Couple VGPU and VSRAM_GPU regulators
  arm64: dts: mediatek: mt8183: Use mediatek,mt8183b-mali as GPU
    compatible
  arm64: dts: mediatek: mt8192: Add mfg_ref_sel clock to MFG0 domain
  arm64: dts: mediatek: mt8192-asurada: Assign sram supply to MFG1 pd
  arm64: dts: mediatek: mt8192-asurada: Couple VGPU and VSRAM_OTHER
    regulators
  arm64: dts: mediatek: mt8195: Add mfg_core_tmp clock to MFG1 domain
  arm64: dts: mt8195: Add panfrost node for Mali-G57 Valhall Natt GPU
  arm64: dts: mediatek: mt8195-cherry: Enable Mali-G57 GPU
  arm64: dts: mediatek: mt8186: Add GPU node
  arm64: dts: mediatek: mt8183-pumpkin: Override vgpu/vsram_gpu
    constraints
  arm64: dts: mediatek: mt8183-evb: Override vgpu/vsram_gpu constraints

Nícolas F. R. A. Prado (1):
  arm64: dts: mediatek: mt8192-asurada: Add MFG0 domain supply

 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  17 ++-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  17 ++-
 .../boot/dts/mediatek/mt8183-pumpkin.dts      |  17 ++-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  34 ++---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  17 +++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     |  22 ++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 116 +++++++++++++++++-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   5 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  95 +++++++++++++-
 9 files changed, 314 insertions(+), 26 deletions(-)

-- 
2.39.2

