Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F7722C5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjFEQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjFEQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:21:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A04394;
        Mon,  5 Jun 2023 09:21:24 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E07336602242;
        Mon,  5 Jun 2023 17:21:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685982082;
        bh=2xM4D3RXODTjflo/pDhE5ajGirQ2J1DJCOKW4dD1ots=;
        h=From:To:Cc:Subject:Date:From;
        b=F++k+VTwB0Fu79tr3WdJ3h/zt13mnAkCtnn5Fppc1BzEzL/Eys+buzrlbawcEK1uj
         sbxLt27KtZDuoJ2aLDZwS+cd4BOb9vf0Jbw1NeoU4w4xJHhl68fiB/qbwrn7jec3ub
         Y3DN8Br4UJjhA2hgbivcTYT5WqXWxJlFQz4Yq5gPwsvBZ6cbVSgecTCJa1jXg8dPED
         Wo6fsNwR8eqZM0D0oU9OtZuEbs3ZbbPVN7nBRz5j9qgkMUuRkMgu6y/A2+YYdX3GFq
         OoyYAg8+xLTkrqwwgV6iCeL3oW071cmoWCeuic6rX4tzqaV6xwoA87je9nmz0uJmP1
         YsAZFmnZ0riFQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/6] Enable decoder for mt8183
Date:   Mon,  5 Jun 2023 12:20:24 -0400
Message-Id: <20230605162030.274395-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series enables the hardware decoder present on mt8183. At first
glance, the only missing piece is the devicetree node for it, however,
simply adding it as is would cause an address collision between the
first register iospace and the clock-controller node, so a rework of the
dt-binding and driver, as well as addition of a clock, were needed
first.

Tested that H264 decoding works with the hardware decoder on
mt8183-kukui-jacuzzi-juniper-sku16, giving a fluster score of 98/135 on
the JVT-AVC_V1 test suite. And ensured other SoCs (MT8192 and MT8195)
still work as usual.


Nícolas F. R. A. Prado (5):
  media: dt-bindings: mediatek,vcodec: Allow single clock for mt8183
  media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
  media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS for mt8183
  media: mediatek: vcodec: Read HW active status from clock
  clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec

Yunfei Dong (1):
  arm64: dts: mediatek: mt8183: Add decoder

 .../media/mediatek,vcodec-decoder.yaml        | 56 ++++++++++++++----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 39 ++++++++++++
 drivers/clk/mediatek/clk-mt8183-vdec.c        |  5 ++
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 59 +++++++++++++++----
 .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 20 +++++--
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 12 +++-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
 include/dt-bindings/clock/mt8183-clk.h        |  3 +-
 8 files changed, 165 insertions(+), 30 deletions(-)

-- 
2.40.1

