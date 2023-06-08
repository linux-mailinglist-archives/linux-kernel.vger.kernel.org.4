Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD79727C68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjFHKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjFHKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:12:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E06211C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:12:14 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01C966606F10;
        Thu,  8 Jun 2023 11:12:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686219133;
        bh=htK85a15rgB70pAiwirg1NuBxZSlaNpIlLEQliB0CKQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KXRtkM4CXJf+IOobM2UO7YbpAL05O78sIPHxI2S5I6kSf1wCmo94OLUl7IAgrUiOt
         nKWRrOftMrcsEBZGfpLdcHvnbsm8QiBUZXhF2+SOXAU3LtPJ/GZUVKziaX/kdmZFfe
         rtb0TEPQK3exBin/8T6WjwAj+Y2BlE9JODWUBLk0AQN4AbQE0uqptb+/tORNIMcRem
         kOReUlz1/AwZ5zidDHcbWWd+mSgMTVfRe07k+bdVrS1W5xRwSC25rkuo2WyLxLWurj
         PeIj9NwRH8r909MctKH5r+1s7A/Wr1sHMewI40u6pcss2gyAnlS8kq1eogOS+gTbPp
         LQBpdN8pBqjFQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/3] drm/mediatek: General cleanups
Date:   Thu,  8 Jun 2023 12:12:06 +0200
Message-Id: <20230608101209.126499-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series performs some cleanups in drm/mediatek; specifically, changes
it to use devm_platform_get_and_ioremap_resource(), dev_err_probe() and
devm_pm_runtime_enable, hence harmonizing log formats and removing some
unneeded lines of code.

AngeloGioacchino Del Regno (3):
  drm/mediatek: Use devm_platform_get_and_ioremap_resource()
  drm/mediatek: Use dev_err_probe() in probe functions
  drm/mediatek: Use devm variant for pm_runtime_enable() when possible

 drivers/gpu/drm/mediatek/mtk_cec.c            | 29 ++++---------
 drivers/gpu/drm/mediatek/mtk_disp_aal.c       | 21 ++++-----
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     | 19 +++-----
 drivers/gpu/drm/mediatek/mtk_disp_color.c     | 22 ++++------
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c     | 19 +++-----
 drivers/gpu/drm/mediatek/mtk_disp_merge.c     | 28 +++++-------
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 26 +++++------
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 13 +++---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      | 43 +++++++------------
 drivers/gpu/drm/mediatek/mtk_dsi.c            | 21 ++++-----
 drivers/gpu/drm/mediatek/mtk_ethdr.c          | 18 ++++----
 drivers/gpu/drm/mediatek/mtk_hdmi.c           | 17 +++-----
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c       | 15 +++----
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       | 29 ++++++-------
 14 files changed, 121 insertions(+), 199 deletions(-)

-- 
2.40.1

