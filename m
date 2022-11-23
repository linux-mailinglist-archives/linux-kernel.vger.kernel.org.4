Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2562635B85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiKWLXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiKWLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:23:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646276316E;
        Wed, 23 Nov 2022 03:22:59 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A4F16602A1D;
        Wed, 23 Nov 2022 11:22:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669202577;
        bh=+f+soK5ibkBzyHND0/INlV0VOdmTdJmaAL6gQPdWIUo=;
        h=From:To:Cc:Subject:Date:From;
        b=Fohq9DEzlCEE/5lh4LJ4BYVjRxw396rO4ldL+nsahl6kzXBXJ9+kl0KtXEnlsGbKr
         jl6y8O+6z12Uknf2vz/30XUJ6lbG3dTnFzS8cPLqy+97zZDdzE55g9H+LPWziSbJCE
         KagE+/XGNVV9NHqP9+UwJBVEM4A27a1mZvNsZRmwGAEc5hEL6Rr1ArTTO1zocKz4TD
         KMc5lAh8iY4kH00DV6YCL5miDKmO6S5eqTMpKSEBImvuCLZX/y8rymXGNWb+6D5cIS
         A8UHIiXKPSHhTf6+JCOAIX3uDFq6FPuBxiuvpO6XXYDunjiIrZOTtdD6A2VODny57Q
         FMGEh5XbPLc5Q==
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
Subject: [PATCH v2 0/4] MediaTek CIRQ: new register layout and schema
Date:   Wed, 23 Nov 2022 12:22:45 +0100
Message-Id: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
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
 .../mediatek,mtk-cirq.yaml                    | 68 ++++++++++++++
 drivers/irqchip/irq-mtk-cirq.c                | 91 +++++++++++++++----
 3 files changed, 142 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml

-- 
2.38.1

