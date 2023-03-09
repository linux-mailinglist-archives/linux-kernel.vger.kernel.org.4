Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADED6B2159
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCIK0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCIK01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:26:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F095C618A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:26:23 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82BA76603010;
        Thu,  9 Mar 2023 10:26:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678357581;
        bh=N5rncwLqIzL40g4iR25V5+icV4dUKNFhKHV4oNcqK9s=;
        h=From:To:Cc:Subject:Date:From;
        b=onfl1tC7dpZo/F3UsCarDfTOKZpu4FXAJkCysyeJxTMzko2Gld+TQtsjEbxkANdT7
         iAlLIPlVU3JXJy8aN9ckUbewGCUS8lOlhDcdbhQBW20lp2kZ2JP19g+LHgd53ALcJl
         toGEDBF2lVeuvES0m0REBWDWKIfxyMKm2m5y+wxK+8Z82fpzH/49kpj7xdTFQKcN/U
         v96YDvYDftNdcJWtu2VIq+5OTFBeGJDvP/dMgJjS+UlNdy5uAagbTLBb75U7HIxSku
         wH5J2txcKAEV+CzdyZNSY8tN/EnuGWTKfs23nn9PLluWAOFx22NMAFOkqFCAriPV16
         UlbY5ciN9L49g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/3] MediaTek MMSYS: Split out MT8173 and add MT6795
Date:   Thu,  9 Mar 2023 11:26:15 +0100
Message-Id: <20230309102618.114157-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
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

This series migrates MT8173 to use its own mmsys DDP routing table
and introduces support for the MediaTek Helio X10 MT6795 using the
same routing table as MT8173.

Broader explanation goes to that MT6795 addition: 

Both MT6795 and MT8173 can support more usecases than the ones in
the current routing tables and the ones that are actually supported
in mediatek-drm!
This is mostly about MERGE, dual-DSI, WDMA (for command mode panels)
and others, but, again, right now, these are not supported.

I could have created a mt6795-mmsys.h, but that would've been a 1:1
clone of mt8173-mmsys.h, creating unnecessary code duplication hence
raising code (and kernel) size for no practical reason.

As a side note, if more MTK Smartphone SoCs land upstream, I expect
to see more re-using of MTK Chromebook SoCs mmsys routing tables.

P.S.: MT6795 dt-bindings are already upstream in v6.1 [1].

This series was tested on:
 - MT8173 Acer Chromebook R13 (Elm)
 - MT6795 Sony Xperia M5 (Holly)

Also, this series depends on [2]

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml?h=v6.1.15#n28
[2]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=724014

AngeloGioacchino Del Regno (3):
  soc: mediatek: mtk-mmsys: Split out MT8173 mmsys DDP routing table
  soc: mediatek: mtk-mmsys: Change MT8173 num_resets to 64
  soc: mediatek: mtk-mmsys: Add support for MT6795 Helio X10

 drivers/soc/mediatek/mt8173-mmsys.h | 95 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    | 16 ++++-
 drivers/soc/mediatek/mtk-mmsys.h    |  2 +-
 3 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/mediatek/mt8173-mmsys.h

-- 
2.39.2

