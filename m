Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E226A0AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjBWNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjBWNn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:43:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB154DE21;
        Thu, 23 Feb 2023 05:43:57 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D3D96602206;
        Thu, 23 Feb 2023 13:43:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159835;
        bh=kcWtsl7kt6vskygEy/KjJuQ2tTbCD0wsvaj9dsJ3sHY=;
        h=From:To:Cc:Subject:Date:From;
        b=fsD0NKgVghv0d1bNIskDjH0rGdpRGIHsVJrgkm9GCaIZ4ipNQm4+0yRR0lZeU0cMt
         NP/Hf9RXoOI+PdcgIJu0qba8DSLcY9goY4kYwGgUoUrDIUnyj8VTMwxoyOVGgxNrju
         aHmgTwdLMJfiu5Y61fqy9ns9og63pAtqPvX80+NvNeRGRcf8qbdemQ5r0bnvhc4bJl
         yN8zN3ZDUE/cd4xbowQ8xugXP73mRZMh6g/TuHThCyAKv/0uxZ3nuD7F72QSdjfER6
         m90eUOzpnAqMPbCy1/abhIX/bVvheKDffJTxdNTpiv774XpcbcVnOuxJxJg7eFUYqq
         z/6qI0ZhzdDgA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 00/16] Enable GPU with DVFS support on MediaTek SoCs
Date:   Thu, 23 Feb 2023 14:43:29 +0100
Message-Id: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
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

[1]: https://lore.kernel.org/lkml/20230223133440.80941-1-angelogioacchino.delregno@collabora.com/

Alyssa Rosenzweig (2):
  arm64: dts: mediatek: mt8192: Add GPU nodes
  arm64: dts: mediatek: mt8192-asurada: Enable GPU

AngeloGioacchino Del Regno (13):
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

Nícolas F. R. A. Prado (1):
  arm64: dts: mediatek: mt8192-asurada: Add MFG0 domain supply

 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  11 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  17 ++-
 .../boot/dts/mediatek/mt8183-pumpkin.dts      |  11 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  34 ++---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  17 +++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     |  22 ++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 118 +++++++++++++++++-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   5 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  95 +++++++++++++-
 9 files changed, 304 insertions(+), 26 deletions(-)

-- 
2.39.2

