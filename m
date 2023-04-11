Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E73C6DD9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDKLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDKLmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:42:45 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C5AB3C16;
        Tue, 11 Apr 2023 04:42:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,336,1673881200"; 
   d="scan'208";a="159045151"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2023 20:42:42 +0900
Received: from localhost.localdomain (unknown [10.226.93.123])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 37F69400195D;
        Tue, 11 Apr 2023 20:42:37 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 00/17] Add RCar DU lib support
Date:   Tue, 11 Apr 2023 12:42:18 +0100
Message-Id: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.0 required=5.0 tests=AC_FROM_MANY_DOTS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DU controller on RZ/G2L LCDC is similar to R-Car as it is
connected to VSPD. RCar DU lib is created for sharing kms, vsp and encoder
driver code between both RCar and RZ/G2L alike SoCs.

Tested this patch series on RZ/{G2M, G2L, G2LC} and RZ/V2L platforms.

v6->v7:
 * Split DU lib and  RZ/G2L du driver as separate patch series as
   DU support added to more platforms based on RZ/G2L alike SoCs.
 * Rebased to latest drm-tip.
v5->v6:
 * Merged DU lib and RZ/G2L du driver in same patch series
 * Rebased to latest drm-misc.
 * Merged patch#1 to RZ/G2L Driver patch.
 * Updated KConfig dependency from ARCH_RENESAS->ARCH_RZG2L.
 * Optimized rzg2l_du_output_name() by removing unsupported outputs.

v4->v5:
 * Added Rb tag from Rob for binding patch.
 * Started using RCar DU libs(kms, vsp and encoder)
 * Started using rcar_du_device, rcar_du_write, rcar_du_crtc,
   rcar_du_format_info and rcar_du_encoder.
v3->v4:
 * Changed compatible name from renesas,du-r9a07g044->renesas,r9a07g044-du
 * started using same compatible for RZ/G2{L,LC}
 * Removed rzg2l_du_group.h and struct rzg2l_du_group
 * Renamed __rzg2l_du_group_start_stop->rzg2l_du_start_stop
 * Removed rzg2l_du_group_restart
 * Updated rzg2l_du_crtc_set_display_timing
 * Removed mode_valid callback.
 * Updated rzg2l_du_crtc_create() parameters
 * Updated compatible
 * Removed RZG2L_DU_MAX_GROUPS
V2->v3:
 * Added new bindings for RZ/G2L DU
 * Removed indirection and created new DRM driver based on R-Car DU
v1->v2:
 * Based on [1], all references to 'rzg2l_lcdc' replaced with 'rzg2l_du'
 * Updated commit description for bindings
 * Removed LCDC references from bindings
 * Changed clock name from du.0->aclk from bindings
 * Changed reset name from du.0->du from bindings
 * Replaced crtc_helper_funcs->rcar_crtc_helper_funcs
 * Updated macro DRM_RZG2L_LCDC->DRM_RZG2L_DU
 * Replaced rzg2l-lcdc-drm->rzg2l-du-drm
 * Added forward declaration for struct reset_control

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220312084205.31462-2-biju.das.jz@bp.renesas.com/

RFC->v1:
 * Changed  minItems->maxItems for renesas,vsps.
 * Added RZ/G2L LCDC driver with special handling for CRTC reusing
   most of RCar DU code
 * Fixed the comments for num_rpf from rpf's->RPFs/ and vsp->VSP.
RFC:
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220112174612.10773-18-biju.das.jz@bp.renesas.com/
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220112174612.10773-12-biju.das.jz@bp.renesas.com/
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220112174612.10773-13-biju.das.jz@bp.renesas.com/
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220112174612.10773-19-biju.das.jz@bp.renesas.com/

Biju Das (17):
  drm: rcar-du: Add encoder lib support
  drm: rcar-du: Add kms lib support
  drm: rcar-du: Add vsp lib support
  drm: rcar-du: Move rcar_du_vsp_atomic_begin()
  drm: rcar-du: Move rcar_du_vsp_atomic_flush()
  drm: rcar-du: Move rcar_du_vsp_{map,unmap}_fb()
  drm: rcar-du: Move rcar_du_dumb_create()
  drm: rcar-du: Move rcar_du_gem_prime_import_sg_table()
  drm: rcar-du: Add rcar_du_lib_vsp_init()
  drm: rcar-du: Move rcar_du_vsp_plane_prepare_fb()
  drm: rcar-du: Move rcar_du_vsp_plane_cleanup_fb()
  drm: rcar-du: Move rcar_du_vsp_plane_atomic_update()
  drm: rcar-du: Add rcar_du_lib_fb_create()
  drm: rcar-du: Add rcar_du_lib_mode_cfg_helper_get()
  drm: rcar-du: Move rcar_du_encoders_init()
  drm: rcar-du: Move rcar_du_properties_init()
  drm: rcar-du: Add rcar_du_lib_vsps_init()

 drivers/gpu/drm/rcar-du/Kconfig               |  10 +
 drivers/gpu/drm/rcar-du/Makefile              |   4 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c     | 117 +--
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h     |  14 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder_lib.c | 138 ++++
 drivers/gpu/drm/rcar-du/rcar_du_encoder_lib.h |  30 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c         | 694 +---------------
 drivers/gpu/drm/rcar-du/rcar_du_kms.h         |  29 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c     | 744 ++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h     |  61 ++
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c         | 407 +---------
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h         |  26 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c     | 436 ++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h     |  76 ++
 14 files changed, 1515 insertions(+), 1271 deletions(-)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_encoder_lib.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_encoder_lib.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h

-- 
2.25.1

