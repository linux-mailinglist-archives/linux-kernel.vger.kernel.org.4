Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64B667C64A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjAZIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjAZIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:53:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4DC6C100;
        Thu, 26 Jan 2023 00:53:27 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 409976602D35;
        Thu, 26 Jan 2023 08:53:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674723206;
        bh=HX+xRQ1MW+zhTnCO03qIVVo98R9P1arkoDNOQVwfKU0=;
        h=From:To:Cc:Subject:Date:From;
        b=BAtopgoj/QqMawnbD1SOcgdbch/1thvXqI/fRAGMel/anVgACYESLpX7hD0PONfe5
         M+86Z4d21XQM2t5o31Awz9QjjHzj/T7gYMOkoSoWds7fhmGkQe1EgpT3+91kJrUnxU
         dDyb9CRba9h37GHu3SNtvfOmm0Ds2qLtiTFOg6q5wz95H8s6Ha5KUq/HTra454shpk
         Y48r1+IMxr/avlYigxSx0wxyXldpU50MKtmSvz4YFBh7ZcwzaHbrbgHhrfBRUJ/B2a
         N/P6I9PfqNIYlFft6ZzjtXcsU/8EhVcA7yrSgx6JqPdXj35v63mGWrkCccGOhsP0lF
         W9JV0MOVyG2/Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 0/6] MediaTek Frequency Hopping: MT6795/8173/92/95
Date:   Thu, 26 Jan 2023 09:53:15 +0100
Message-Id: <20230126085321.87267-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
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

Changes in v2:
 - Rebased over v4 of my clock drivers cleanups series [1]

This series adds support for Frequency Hopping (FHCTL) on more MediaTek
SoCs, specifically, MT6795, MT8173, MT8192 and MT8195.

In order to support older platforms like MT6795 and MT8173 it was
necessary to add a new register layout that is ever-so-slightly
different from the one that was previously introduced for MT8186.

Since the new layout refers to older SoCs, the one valid for MT8186
and newer SoCs was renamed to be a "v2" layout, while the new one
for older chips gets the "v1" name.

Note: These commits won't change any behavior unless FHCTL gets
      explicitly enabled and configured in devicetrees.

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=714059

AngeloGioacchino Del Regno (6):
  clk: mediatek: fhctl: Add support for older fhctl register layout
  dt-bindings: clock: mediatek,mt8186-fhctl: Support MT6795,
    MT8173/92/95
  clk: mediatek: mt6795: Add support for frequency hopping through FHCTL
  clk: mediatek: mt8173: Add support for frequency hopping through FHCTL
  clk: mediatek: mt8192: Add support for frequency hopping through FHCTL
  clk: mediatek: mt8195: Add support for frequency hopping through FHCTL

 .../bindings/clock/mediatek,mt8186-fhctl.yaml |  7 +-
 drivers/clk/mediatek/clk-fhctl.c              | 26 ++++++-
 drivers/clk/mediatek/clk-fhctl.h              |  9 ++-
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c  | 63 ++++++++++++++++-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c  | 65 ++++++++++++++++-
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c  |  2 +
 drivers/clk/mediatek/clk-mt8192.c             | 67 +++++++++++++++++-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c  | 69 ++++++++++++++++++-
 drivers/clk/mediatek/clk-pllfh.c              | 23 +++++--
 drivers/clk/mediatek/clk-pllfh.h              |  1 +
 10 files changed, 311 insertions(+), 21 deletions(-)

-- 
2.39.0

