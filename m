Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF28B73B421
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjFWJuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjFWJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:49:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736D210A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:49:53 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7ADBE6607136;
        Fri, 23 Jun 2023 10:49:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687513792;
        bh=plscFZKHtNrQWXzBbZcsxZgutWbHc8HsuS8WC/3cV34=;
        h=From:To:Cc:Subject:Date:From;
        b=dppyZk6IgFXmtfxoPXPzwbLNGKkivdJzNItHFQMjpdGwtJ1Xi9nociONjFOGuhwJD
         hdnUIXW6dEmqxzz0VL7Z9HEUo/32RIPvmqcDb7ylFtyFaLHDFMSnZS17hMrB9+OiEU
         0AG9LFaJUXjZ94jV3ppwup8UPWGLy6b9d8K2ctpq0yf50i5MnRId6ywNEG74RaTCAl
         kDi20SBJf2DDTi0ZkP245wngMjLIOOH9P25wY/Mm7Wb9//EiAOAVyotv5FFJl/8SWn
         w1O2nykH0p2mN5JHTS2NOAdj4vsP2a7Y5LjBxS77NekE3aI2pkWudB71HbejOFygIp
         eqLgpuJn027MQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        wenst@chromium.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/3] MediaTek DRM: Clean up CMDQ support and ifdefs
Date:   Fri, 23 Jun 2023 11:49:28 +0200
Message-Id: <20230623094931.117918-1-angelogioacchino.delregno@collabora.com>
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

This series changes MediaTek CMDQ support to use the mtk-cmdq-helper
functions, removing duplicated cmdq setup code in mtk-drm and also
removing all instances of `#if IS_REACHABLE(CONFIG_MTK_CMDQ)` while
keeping compatibility with both CONFIG_MTK_CMDQ=n and =m/=y.

This applies on top of [1] and [2].

[1]: https://lore.kernel.org/lkml/20230524093412.92211-1-angelogioacchino.delregno@collabora.com
[2]: https://lore.kernel.org/lkml/20230608084727.74403-1-angelogioacchino.delregno@collabora.com

AngeloGioacchino Del Regno (3):
  drm/mediatek: Dynamically allocate CMDQ and use helper functions
  drm/mediatek: Remove all preprocessor ifs for CONFIG_MTK_CMDQ
  drm/mediatek: Move CMDQ setup to mtk_drm_cmdq_init() function

 drivers/gpu/drm/mediatek/mtk_disp_aal.c     |   2 -
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c   |   2 -
 drivers/gpu/drm/mediatek/mtk_disp_color.c   |   2 -
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c   |   2 -
 drivers/gpu/drm/mediatek/mtk_disp_merge.c   |   2 -
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |   2 -
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   2 -
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 178 +++++++-------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  12 --
 drivers/gpu/drm/mediatek/mtk_ethdr.c        |   6 +-
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c     |   3 +-
 include/linux/soc/mediatek/mtk-cmdq.h       |   1 +
 12 files changed, 69 insertions(+), 145 deletions(-)

-- 
2.40.1

