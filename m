Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2778A7292C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbjFIIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbjFIISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7293AB9;
        Fri,  9 Jun 2023 01:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D5C61F2B;
        Fri,  9 Jun 2023 08:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DDEC433D2;
        Fri,  9 Jun 2023 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298664;
        bh=Q3lpJIl4Z5sdoUzSuGxmM+HFKMFmLc0nDXYEbM0IvBY=;
        h=From:To:Cc:Subject:Date:From;
        b=DMyvvowuFDe9JYaxvty4pMatDHzghPPuqy6k1T12vhsZOqKn9hmQ9b7+2sOPPyUju
         nuTm9fCFhpeV7x2GJCAQp8It3FYVdxYmVBLZpDEUi+fiViW3nPYnVxV6i7LuF09KpG
         NKdbUYUJhEXeGmsWZXsctSZQQYxkm0rDszqHQH4RcGLM2IPLn6GLouWX9BJFNLvbTR
         KDUcvCQpqCdIaBVOWswsmHDjdYs3I8FCftKXf/YSlmp3n0HzQVYiAKWhrZ6ou4NWuq
         HjEWDO3udnppvGxrwN2UxVN+C+96WGNa66qX+kli0Gs1upOKKsUHYHf2ffNsziaU/e
         rmvLWbHegeyFw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jerome Glisse <glisse@freedesktop.org>,
        Karol Herbst <kherbst@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Leo Li <sunpeng.li@amd.com>, linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        nouveau@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Stanley Yang <Stanley.Yang@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [RESEND 00/15] Rid W=1 warnings from GPU
Date:   Fri,  9 Jun 2023 09:17:03 +0100
Message-ID: <20230609081732.3842341-1-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (15):
  drm/xlnx/zynqmp_disp: Use correct kerneldoc formatting in zynqmp_disp
  drm/xlnx/zynqmp_dp: Fix function name zynqmp_dp_link_train() ->
    zynqmp_dp_train()
  drm/vkms/vkms_composer: Fix a few different kerneldoc formatting
  drm/mediatek/mtk_disp_aal: Remove half completed incorrect struct
    header
  drm/mediatek/mtk_disp_ccorr: Remove half completed incorrect struct
    header
  drm/nouveau/nvkm/subdev/acr/lsfw: Remove unused variable 'loc'
  drm/nouveau/nvkm/subdev/bios/init: Demote a bunch of kernel-doc abuses
  drm/nouveau/nvkm/subdev/volt/gk20a: Demote kerneldoc abuses
  drm/nouveau/nvkm/engine/gr/gf100: Demote kerneldoc abuse
  drm/nouveau/nvkm/engine/gr/tu102: Staticify local function
    gf100_fifo_nonstall_block()
  drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Move SYNAPTICS_DEVICE_ID
    into CONFIG_DRM_AMD_DC_DCN ifdef
  drm/nouveau/dispnv04/crtc: Demote kerneldoc abuses
  drm/nouveau/nvkm/engine/gr/tu102: Completely remove unused function
    ‘tu102_gr_load’
  drm/radeon/radeon_ttm: Remove unused variable 'rbo' from
    radeon_bo_move()
  drm/amd/amdgpu/sdma_v6_0: Demote a bunch of half-completed function
    headers

 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +-
 drivers/gpu/drm/mediatek/mtk_disp_aal.c       |   5 -
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     |   5 -
 drivers/gpu/drm/nouveau/dispnv04/crtc.c       |   4 +-
 .../gpu/drm/nouveau/nvkm/engine/gr/gf100.c    |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/gr/tu102.c    |  13 --
 .../gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c    |   3 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/init.c   | 136 +++++++++---------
 .../gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c  |   4 +-
 drivers/gpu/drm/radeon/radeon_ttm.c           |   2 -
 drivers/gpu/drm/vkms/vkms_composer.c          |   6 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c            |   6 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c              |   2 +-
 14 files changed, 89 insertions(+), 113 deletions(-)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Gourav Samaiya <gsamaiya@nvidia.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Jerome Glisse <glisse@freedesktop.org>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-media@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: nouveau@lists.freedesktop.org
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>

-- 
2.41.0.162.gfafddb0af9-goog

