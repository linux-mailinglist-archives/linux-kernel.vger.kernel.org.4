Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9E2710B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbjEYLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjEYLxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:53:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4997
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:53:05 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1BDFB6605840;
        Thu, 25 May 2023 12:53:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685015583;
        bh=vq6ZQxb4poCfUCjWGmL6dXu84EQJb4PKabd/UNw0s4g=;
        h=From:To:Cc:Subject:Date:From;
        b=IzIYSl921YO0AOJdl8z6BMZLsgvTWMJrKKVbJfiHaPSiTEYM2zb04jVfCsrUWDx/K
         3xs2TyOgF1WKRQtktDGxjmKwSUqkuzEHLYX8d0I0WQmnxjOznHhd2e0S/qHPMcTZIJ
         b15yh5DW9/LHhH0hJQb3UP+x1Qeh7bO5rvtmHqBN7PXR3MbhOAnGy3pjbIqtBMbtRN
         iIFu0RnzneEshocDt1mcnIT3aL1QG65+nD7xBcfiRHuXU5nVzA5Q8/ItPAg6ZW78AN
         mOlkRuTjO8R3eQb8LbwP2asde/LTHy7bhcHi60xOFb41mDsRqvQMbXB5iFTGM79ku0
         7FSzcgC1/I0vg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 0/3] MediaTek MIPI-DSI PHY: Cleanups
Date:   Thu, 25 May 2023 13:52:55 +0200
Message-Id: <20230525115258.90091-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

This series performs some cleanups to the MediaTek mipi-dsi PHY, used in
various MediaTek SoCs; in particular, it's migrating this driver to
register its clock as clk_hw provider instead and makes use of the devm
function for the same, allowing to remove a pointer to struct clk and
the whole .remove_new() callback, as it's not needed anymore.
This also cleans up the of_device_id table.

Tested on MT8173, MT8192 Chromebooks, MT6795 Xperia M5 smartphone.

AngeloGioacchino Del Regno (3):
  phy: mediatek: mipi-dsi: Convert to register clk_hw
  phy: mediatek: mipi-dsi: Use devm variant for of_clk_add_hw_provider()
  phy: mediatek: mipi-dsi: Compress of_device_id match entries

 drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 30 +++++++++----------------
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h |  1 -
 2 files changed, 10 insertions(+), 21 deletions(-)

-- 
2.40.1

