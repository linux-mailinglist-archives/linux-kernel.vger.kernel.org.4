Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304AD6F3EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEBIQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:16:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533E107
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:16:57 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 495506605634;
        Tue,  2 May 2023 09:16:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683015416;
        bh=SSwmXETI5ywApoRMU7RMUhj/O68+be0mDEk19Wze6fw=;
        h=From:To:Cc:Subject:Date:From;
        b=ovl6U0mDiCQ4dRXGcVpcvlX2tyT6AUyz+GCn+OLx5sgj1uCD/TzUfLZMhizga94YL
         pL3GCUVaZfSIHAHBhn8nMGJpSURD3ywxZQzCnJHXM2zgMVa3WmY8b7uem4ZQdAEfPk
         sbF9/BrAu/UzCULs0pmeMVn6z+ouVcx9WVJAYW5s0H0bpM3ajlnDDHNcVrNWw7fxDa
         9qOoavR0VtdNluymUTGDKHKt9uPIgNfcjetEd26eSRQeSt8mrbItdUx+rHa+VpmaMd
         anXs3jbUJ6LJZw6Z5sHTuSQLQccy3q1Dlb6vQZtLoI5o0jTRTX9nIEpD+fmquXztfV
         mCyyOuCwGJlNA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH 00/11] MediaTek DDP GAMMA - 12-bit LUT support
Date:   Tue,  2 May 2023 10:16:39 +0200
Message-Id: <20230502081650.25947-1-angelogioacchino.delregno@collabora.com>
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

This series adds support for GAMMA IP requiring and/or supporting
a 12-bits LUT using a slightly different register layout and programming
sequence for multiple LUT banks: this IP version is currently found
on a number of SoCs, not only including the Chromebook/IoT oriented
Kompanio 1200/1380 MT8195/MT8195T, but also Smartphone chips such as
the Dimensity 9200 (MT6985) and others.

This series was tested on MT8195, MT8192, MT8173, MT6795:
 * MT6795, MT8192, MT8173: No regression, works fine.
 * MT8195: Color correction is finally working!

AngeloGioacchino Del Regno (10):
  drm/mediatek: gamma: Reduce indentation in mtk_gamma_set_common()
  drm/mediatek: gamma: Support SoC specific LUT size
  drm/mediatek: gamma: Improve and simplify HW LUT calculation
  drm/mediatek: gamma: Enable the Gamma LUT table only after programming
  drm/mediatek: gamma: Use bitfield macros
  drm/mediatek: gamma: Support specifying number of bits per LUT
    component
  drm/mediatek: gamma: Support multi-bank gamma LUT
  drm/mediatek: gamma: Add support for 12-bit LUT and MT8195
  drm/mediatek: gamma: Make sure relay mode is disabled
  drm/mediatek: gamma: Program gamma LUT type for descending or rising

Jason-JH.Lin (1):
  drm/mediatek: gamma: Adjust mtk_drm_gamma_set_common parameters

 drivers/gpu/drm/mediatek/mtk_disp_aal.c     |   2 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   3 +-
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c   | 194 ++++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   9 +
 6 files changed, 177 insertions(+), 36 deletions(-)

-- 
2.40.1

