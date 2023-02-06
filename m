Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4604A68B951
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBFKCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjBFKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:01:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A5C1EFFF;
        Mon,  6 Feb 2023 02:01:16 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84D7C6600368;
        Mon,  6 Feb 2023 10:01:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675677675;
        bh=duZOdncpie1C6AkV6VHZLZr+dP/cQtDdlisJYyTikZU=;
        h=From:To:Cc:Subject:Date:From;
        b=Wz+D0HXapes31AhNtVqod1g92sOPbKAITwPCL6NoJWFqZqYkkxp61GhP8Yw2S91zS
         90/Z0Yaq57mjg8YDv+WL6ngA3KGuB6z0aoAuTF0DpAvW/w0+8NBtkpODajR2zjFMSi
         Fq2mjRn3qwnbeQaeINfHsxySUq/Bgs0lhvW5SqLy5Dl1IsevArsIVwaJXori/bhmkf
         KqbVjow+UEK1EqtcGztQx1WirTVQXj7beaK8Ul481fmSSPEWeSNx8Cm0g8Z9ynEppj
         /DS9/hDnNb7qibx38pfO8SG+Jx8TK9n+sQ7U3p88eOz3lyltQ6NglWJnX0c/6EZUtW
         tFZU7dlB5ZgRw==
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
Subject: [PATCH v3 0/7] MediaTek Frequency Hopping: MT6795/8173/92/95
Date:   Mon,  6 Feb 2023 11:00:58 +0100
Message-Id: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
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

Changes in v3:
 - Added commit to export register/unregister/parse FHCTL functions
   to allow building clock drivers using FHCTL as modules

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
AngeloGioacchino Del Regno (7):
  clk: mediatek: fhctl: Add support for older fhctl register layout
  clk: mediatek: clk-pllfh: Export register/unregister/parse functions
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
 drivers/clk/mediatek/clk-pllfh.c              | 26 +++++--
 drivers/clk/mediatek/clk-pllfh.h              |  1 +
 10 files changed, 314 insertions(+), 21 deletions(-)

-- 
2.39.1

