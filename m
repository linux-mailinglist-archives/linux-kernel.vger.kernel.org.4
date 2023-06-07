Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E17726F59
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjFGU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjFGU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:57:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB51BEA;
        Wed,  7 Jun 2023 13:57:31 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C01166032D2;
        Wed,  7 Jun 2023 21:57:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686171449;
        bh=3Ss4Xbs+eUeVm0wwUGrfx/rLq0kUmO44VcFrpD6blPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Hjy4ZAVDbkJPCL4X1AXfEB2Qx119GEsaxIbUuBS0OMEF7Rq9rtwOugPt2aFyEie0i
         fKbdk32a3zQF8wT4eUuV1aZVpksNTJFwhr1BVsRUkaY2VDNb64IagZxnCyfEsm7JSr
         YlHGXXbaw7WuKIiJcc2wQRA2jBRFc7JifUkg+wBW/1UahWkwhXJKRg21WkAJGR8o1Q
         hbXEVn06a0H/rFhsnkHyqGx8hSBdVRfnm9TguMpGP5QYPUYqh4VdfIR+/EFNI1YVO7
         8YON8g1BUz0/1/D/NrO/+3mbbWR8o9CumX2U8FczxHYottf3ww5OiUX7wzyH+udumm
         lxmDVGfI+tEOQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH v2 0/5] Enable decoder for mt8183
Date:   Wed,  7 Jun 2023 16:53:37 -0400
Message-ID: <20230607205714.510012-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes in v2:
- Merged commit 1 (media: dt-bindings: mediatek,vcodec: Allow single
  clock for mt8183) into commit 3 (media: dt-bindings: mediatek,vcodec:
  Remove VDEC_SYS for mt8183)
- Further constrained properties in dt-binding
- Added CLK_IGNORE_UNUSED flag to active clock
- Reformatted reg-names in DT node

Nícolas F. R. A. Prado (4):
  media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
  media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS for mt8183
  media: mediatek: vcodec: Read HW active status from clock
  clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec

Yunfei Dong (1):
  arm64: dts: mediatek: mt8183: Add decoder

 .../media/mediatek,vcodec-decoder.yaml        | 65 +++++++++++++++----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 30 +++++++++
 drivers/clk/mediatek/clk-mt8183-vdec.c        |  5 ++
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 59 +++++++++++++----
 .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 20 ++++--
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 12 +++-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
 include/dt-bindings/clock/mt8183-clk.h        |  3 +-
 8 files changed, 165 insertions(+), 30 deletions(-)

-- 
2.41.0

