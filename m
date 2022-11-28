Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E78263A4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiK1JW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiK1JWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:22:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BB91571D;
        Mon, 28 Nov 2022 01:22:24 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57EC8660294D;
        Mon, 28 Nov 2022 09:22:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669627342;
        bh=4svnuKGRmLuN+k+64E0njW9wpfP9VKSIlPLHnGC+4mQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JQSTZK4KaQPRhalVDrCtMMQI9v8APfBJLDiYftywMIL8rSoY4xX6Eio89qbFbeuM3
         KXpR15r3LnlnVj8uqY4WI5pJxDAl3FBAPXRuzBbrk9gHz+3LXBhpOuoQeV5OUVWisb
         ZZf+gPuJkZU2B1Q2k7wDJ5T6I0zoivdDuhRrI3Vik+g8XIe2cY/TDn+O8EB+7tfoIp
         zLVsqN3kcAYri3lFIhIzSRftK51YB+PWtMZKtpNhyBp7lJYoGbk2eHjE4qDw8kWu/P
         Qj4sli6AzNf0nMcgRg+M2JXNDS6dhRx7/YKSvgLXgJmOqcZT6ZbEIW1N2Ekh2nnj0q
         2JkPbr3xueAyQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/4] MediaTek CIRQ: new register layout and schema
Date:   Mon, 28 Nov 2022 10:22:13 +0100
Message-Id: <20221128092217.36552-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
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

On newer SoCs (like MT8192/95 and also other non-chromebook chips), the
MediaTek CIRQ controller has a new register layout: this series adds
some more flexibility to the irq-mtk-cirq driver, allowing to select
the register layout based on a SoC-specific compatible.

While at it, I've also performed a schema conversion .. because why not.

This was tested on MT8173 Elm, MT8192 Asurada, MT8195 Tomato (both
MT8192 and MT8195 require devicetree work to actually make use of
the CIRQ, not included in this series - while MT8173 has it already).

Changes in v3:
 - Renamed mtk_cirq_regs_xxx to mtk_cirq_regoffs_xxx

Changes in v2:
 - Used the right base patches, as something went wrong in v1 (sorry!)
 - [1/4] Fixed items for mediatek,ext-irq-range
 - [3/4] Renamed `regs` to `offsets`, as it's effectively a register
         offsets (and not registers) array
 - [3/4] Added mtk_cirq_reg() accessor
 - [3/4] Added all supported compatible strings to of_device_id
 - [3/4] Fixed mtk_cirq_reg_index enumeration to not assign 0 to the
         first index (as it's 0 by default), removed meaningless
         CIRQ_MAX index
 - [4/4] Now this patch only adds the `v2` offsets and a compatible
         string "mediatek,mt8192-cirq".

AngeloGioacchino Del Regno (4):
  dt-bindings: interrupt-controller: mediatek,cirq: Migrate to dt schema
  dt-bindings: interrupt-controller: mediatek,cirq: Document MT8192
  irqchip: irq-mtk-cirq: Move register offsets to const array
  irqchip: irq-mtk-cirq: Add support for System CIRQ on MT8192

 .../interrupt-controller/mediatek,cirq.txt    | 33 -------
 .../mediatek,mtk-cirq.yaml                    | 68 +++++++++++++
 drivers/irqchip/irq-mtk-cirq.c                | 95 +++++++++++++++----
 3 files changed, 146 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml

-- 
2.38.1

