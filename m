Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8E6DF69E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDLNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDLNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:12:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F4F7AB1;
        Wed, 12 Apr 2023 06:12:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FC606603102;
        Wed, 12 Apr 2023 14:12:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681305141;
        bh=+riuISXy3VPiJ6mOioE8PhdIQu+xEKxpkJXqCAILO9c=;
        h=From:To:Cc:Subject:Date:From;
        b=or42XwpmzhGHuSBWzVRtaENPX1BZSaOk/mksrYYXK1Wk1cmkimGKT/p6KShTcSqbj
         16h4pVLezeTQviuGIXackRKbpaHt0HaUiWp6sAxPaX5Nrj3IHiqlzjW5G/JZStl3gQ
         vqqvYF3b6HWmNRIFQCdtd9Ybncd4k9b2/cW4ZhGzUjw9JtAHoQTUR6nLp9KSP4zlCW
         1ss/FGv7Coz/qbCbRSGu5wPGvhVhvhMJmKslKo5hOXPll/s9P/Ez43HqQtja/RnOjV
         9Wd0ZqmdkNbsA6z+Wtek8GuG8F7Qj+fxNgZOT86K7505zv9scOaW77XWP/vFQ5VnVU
         dRsYHPbbHmN8A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        amergnat@baylibre.com, flora.fu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/6] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper
Date:   Wed, 12 Apr 2023 15:12:10 +0200
Message-Id: <20230412131216.198313-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
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

Changes in v3:
 - Rebased on next-20230412
 - Changed if branch to switch in pwrap_init() as suggested
   by Matthias and Alexandre.

Changes in v2:
 - Rebased on next-20230323
 - Changed pwrap.txt addition to new yaml file addition

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces support in the PMIC Wrapper for a different PMIC
topology, which is commonly found on smartphone boards, using one main
PMIC and one Companion/Sub PMIC, both accessible *only* through the pwrap;
be aware that this kind of topology is not *specific to* the Helio X10
SoC, but common across many kinds of MediaTek smartphone oriented SoCs
and board designs.

That said, support for the PMIC combo MT6331+MT6332 is provided in this
series in a form that will be able to initialize the PMICs with crypto
and DualIO but nothing else: these PMICs are very featureful, so I have
decided to add this support in more than just one step, as there will
be multiple patches for multiple different subsystems (..it's a mfd!..).

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

AngeloGioacchino Del Regno (6):
  dt-bindings: soc: mediatek: pwrap: Add compatible for MT6795 Helio X10
  soc: mediatek: pwrap: Move PMIC read test sequence in function
  soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
  soc: mediatek: mtk-pmic-wrap: Add support for companion PMICs
  soc: mediatek: mtk-pmic-wrap: Add support for MT6331 w/ MT6332
    companion
  soc: mediatek: pwrap: Add support for MT6795 Helio X10

 .../bindings/soc/mediatek/mediatek,pwrap.yaml |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 292 ++++++++++++++++--
 2 files changed, 267 insertions(+), 26 deletions(-)

-- 
2.40.0

