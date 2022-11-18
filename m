Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6856C62F222
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiKRKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKRKGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:06:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562C8FB0C;
        Fri, 18 Nov 2022 02:06:49 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D3C556602A94;
        Fri, 18 Nov 2022 10:06:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668766008;
        bh=gNMF9FUnsHl1tClZCnynz5bAOkfDS1T9IfVFHk+eg0A=;
        h=From:To:Cc:Subject:Date:From;
        b=KfO8rte2j+APGO/WGZA16lqXuuA0MD8OW+xMTmUBmaL53n1QaAdsRbFqVLeTL5V3O
         gFrCylI/34JWH5AbcTFEfNMYOnad+pNVBXssX8KhfsBPIKPplesXF+4apIDn2LZVjv
         tGGE8fsPwcYj5IGG5DzUtD3tKDWw8uBhrwrTDt0J/zaXvfu8aYInqcdlXAPhYPwGqp
         N4fmsHCawQf+PKkbBsCbFCMANdGhPRaPPqsF4JtWk+nPjjcfxulYznG6WGVkSQl/+j
         2C74Zmm5/Ix/34qH2hPL561OWzGPAe7y1ze9kadkFVDrgWd7I3L5nRlHqzoR1MqZAE
         gDYZyF+K+pbAw==
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
Subject: [PATCH v1 0/4] MediaTek CIRQ: new register layout and schema
Date:   Fri, 18 Nov 2022 11:06:35 +0100
Message-Id: <20221118100639.33704-1-angelogioacchino.delregno@collabora.com>
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

This was tested on MT8173 Elm, MT8192 Asurada, MT8195 Tomato (where
the latter require devicetree work to actually make use of the CIRQ,
not included in this series).

AngeloGioacchino Del Regno (4):
  dt-bindings: interrupt-controller: mediatek,cirq: Migrate to dt schema
  dt-bindings: interrupt-controller: mediatek,cirq: Document MT8192
  irqchip: irq-mtk-cirq: Move register offsets to const array
  irqchip: irq-mtk-cirq: Add support for System CIRQ on MT8192

 .../interrupt-controller/mediatek,cirq.txt    | 33 --------
 .../mediatek,mtk-cirq.yaml                    | 71 ++++++++++++++++
 drivers/irqchip/irq-mtk-cirq.c                | 81 ++++++++++++++-----
 3 files changed, 134 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml

-- 
2.38.1

