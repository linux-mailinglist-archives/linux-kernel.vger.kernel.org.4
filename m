Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7259748136
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGEJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGEJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:42:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD21710
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:42:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F2C3D660087A;
        Wed,  5 Jul 2023 10:42:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688550159;
        bh=zINDDL4xiGK/8luSkmKXT+SCyjHKCbbr1Sc9XWyTjCM=;
        h=From:To:Cc:Subject:Date:From;
        b=GuCdJlW0aAu+LpdTEmm5X87DRUudiBJENtp6Ld0vjQY7EaPja74qJ2fQ7MK4Wewo1
         ksoE7FJQ5+LMx2McHb8JCxk8hPnYTHI5JrRp6GwWwNSV4HReFc3RLG3noT3uV4rn58
         8Asj6s/x/gIUZudjq1oEBO2BCh9xClWkYOtDdB+t7PAAvnZDPy+/HCNeDaqO7XAfn5
         M0+1z3NaUV63Tu3J/aV+5JXOwLNI6QKQAe2zDCWiYxKx8kV+TF43iMt6TgtScMgZeL
         1mlDAL0SYMMGKK7VbUcZ/8T1Mnzgb3sKs3o+TnEG1kSXO8BdA8V40LnJdQQm8PmQLG
         KxZoYMbGr4wZA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 0/3] drm/mediatek: General cleanups
Date:   Wed,  5 Jul 2023 11:42:29 +0200
Message-Id: <20230705094232.75904-1-angelogioacchino.delregno@collabora.com>
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

This series performs some cleanups in drm/mediatek; specifically, changes
it to use devm_platform_ioremap_resource(), dev_err_probe() and
devm_pm_runtime_enable, hence harmonizing log formats and removing some
unneeded lines of code.

Changes in v2:
 - Switched from devm_platform_get_and_ioremap_resource() to dropping
   struct resource pointer with using devm_platform_ioremap_resource()

AngeloGioacchino Del Regno (3):
  drm/mediatek: Use devm_platform_ioremap_resource()
  drm/mediatek: Use dev_err_probe() in probe functions
  drm/mediatek: Use devm variant for pm_runtime_enable() when possible

 drivers/gpu/drm/mediatek/mtk_cec.c            | 29 ++++--------
 drivers/gpu/drm/mediatek/mtk_disp_aal.c       | 22 ++++------
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     | 20 +++------
 drivers/gpu/drm/mediatek/mtk_disp_color.c     | 23 ++++------
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c     | 20 +++------
 drivers/gpu/drm/mediatek/mtk_disp_merge.c     | 29 +++++-------
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 27 +++++-------
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 13 +++---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      | 44 +++++++------------
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  3 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            | 22 ++++------
 drivers/gpu/drm/mediatek/mtk_ethdr.c          | 18 ++++----
 drivers/gpu/drm/mediatek/mtk_hdmi.c           | 18 +++-----
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c       | 18 +++-----
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       | 30 +++++--------
 15 files changed, 122 insertions(+), 214 deletions(-)

-- 
2.40.1

