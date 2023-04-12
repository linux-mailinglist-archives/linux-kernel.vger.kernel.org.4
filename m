Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844146DFA84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDLPnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDLPnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:43:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22159C5;
        Wed, 12 Apr 2023 08:43:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F8DB547;
        Wed, 12 Apr 2023 17:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681314194;
        bh=4NyFXWkTeYTdYPjiIvCQ6ScjCOvbiEwdgtblQo9Csj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqgA4KO9MDMYA9XTbZKAavKnRsuzwKfm3DAKTP90+SlQvhDQF1n+yAiSU1FY4rPSs
         V9tgvxM4KKOiPT25AeRG4BOsvDn5v+7KTttsYasxy7NoricAIyZ4ZqUMx488tyWgj1
         Ast1ORK+0zYd4CEjHtvLGoqifErWXW6kh07YXJAk=
Date:   Wed, 12 Apr 2023 18:43:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v7 00/17] Add RCar DU lib support
Message-ID: <20230412154326.GZ11253@pendragon.ideasonboard.com>
References: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

(CC'ing Kieran who has missed the series so far)

Thank you for the patch.

On Tue, Apr 11, 2023 at 12:42:18PM +0100, Biju Das wrote:
> The DU controller on RZ/G2L LCDC is similar to R-Car as it is
> connected to VSPD. RCar DU lib is created for sharing kms, vsp and encoder
> driver code between both RCar and RZ/G2L alike SoCs.

I'm afraid that my opinion hasn't changed much compared to the previous
versions :-(

The RZ/G2L LCD Controller (LCDC) is indeed made of FCP, VSP and DU
hardware blocks, like in R-Car. While the VSP is similar to its R-Car
counterpart, and the FCP may be as well (I haven't checked), the only
common point between the RZ/G2L and R-Car DU is the name.

This patch series is turning the R-Car DU driver into a generic library
to support the unrelated RZ/G2L DU. This makes the code more complex,
and significantly more difficult to maintain. Not only would changes for
R-Car then need to be tested on RZ/G2L as well (which is a platform I
don't have access to), but refactoring of the code to address R-Car use
cases may become more difficult due to RZ/G2L support.

The only hardware-specific similarity I see between the RZ/G2L and R-Car
DU is usage of the VSP as an external composer. That part is mostly
handled by the VSP driver which is already an external component to the
DU driver. There is a thin glue layer in the DU driver to translate the
KMS plane API to the VSP internal API, and some code may be reused on
the RZ/G2L, but I expect that to be fairly limited, especially given
that the interface with the VSP isn't exactly the same on the two
platforms. Still, *if* that code could be nicely split to a library
shared by the two platforms, *without* causing more pain (significant
maintenance burden) than gain (code sharing), I would be fine with that.

What I don't like is how intrusive the patch series is. You're turning
the whole DU driver into a library, for parts where the two platforms
have no common hardware implementation. If there are significant
portions of the DU driver that would be duplicated for RZ/G2L, it may be
a sign that that code could be factored out to a library, but it should
in that case not be a DU library, but a DRM core helper.

The DRM core helpers and the VSP helpers are two independent components,
so I would be fine if you decide to only implement one of the two.

> Tested this patch series on RZ/{G2M, G2L, G2LC} and RZ/V2L platforms.
> 
> v6->v7:
>  * Split DU lib and  RZ/G2L du driver as separate patch series as
>    DU support added to more platforms based on RZ/G2L alike SoCs.
>  * Rebased to latest drm-tip.
> v5->v6:
>  * Merged DU lib and RZ/G2L du driver in same patch series
>  * Rebased to latest drm-misc.
>  * Merged patch#1 to RZ/G2L Driver patch.
>  * Updated KConfig dependency from ARCH_RENESAS->ARCH_RZG2L.
>  * Optimized rzg2l_du_output_name() by removing unsupported outputs.
> 
> v4->v5:
>  * Added Rb tag from Rob for binding patch.
>  * Started using RCar DU libs(kms, vsp and encoder)
>  * Started using rcar_du_device, rcar_du_write, rcar_du_crtc,
>    rcar_du_format_info and rcar_du_encoder.
> v3->v4:
>  * Changed compatible name from renesas,du-r9a07g044->renesas,r9a07g044-du
>  * started using same compatible for RZ/G2{L,LC}
>  * Removed rzg2l_du_group.h and struct rzg2l_du_group
>  * Renamed __rzg2l_du_group_start_stop->rzg2l_du_start_stop
>  * Removed rzg2l_du_group_restart
>  * Updated rzg2l_du_crtc_set_display_timing
>  * Removed mode_valid callback.
>  * Updated rzg2l_du_crtc_create() parameters
>  * Updated compatible
>  * Removed RZG2L_DU_MAX_GROUPS
> V2->v3:
>  * Added new bindings for RZ/G2L DU
>  * Removed indirection and created new DRM driver based on R-Car DU
> v1->v2:
>  * Based on [1], all references to 'rzg2l_lcdc' replaced with 'rzg2l_du'
>  * Updated commit description for bindings
>  * Removed LCDC references from bindings
>  * Changed clock name from du.0->aclk from bindings
>  * Changed reset name from du.0->du from bindings
>  * Replaced crtc_helper_funcs->rcar_crtc_helper_funcs
>  * Updated macro DRM_RZG2L_LCDC->DRM_RZG2L_DU
>  * Replaced rzg2l-lcdc-drm->rzg2l-du-drm
>  * Added forward declaration for struct reset_control
> 
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220312084205.31462-2-biju.das.jz@bp.renesas.com/
> 
> RFC->v1:
>  * Changed  minItems->maxItems for renesas,vsps.
>  * Added RZ/G2L LCDC driver with special handling for CRTC reusing
>    most of RCar DU code
>  * Fixed the comments for num_rpf from rpf's->RPFs/ and vsp->VSP.
> RFC:
>  https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220112174612.10773-18-biju.das.jz@bp.renesas.com/
>  https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220112174612.10773-12-biju.das.jz@bp.renesas.com/
>  https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220112174612.10773-13-biju.das.jz@bp.renesas.com/
>  https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220112174612.10773-19-biju.das.jz@bp.renesas.com/
> 
> Biju Das (17):
>   drm: rcar-du: Add encoder lib support
>   drm: rcar-du: Add kms lib support
>   drm: rcar-du: Add vsp lib support
>   drm: rcar-du: Move rcar_du_vsp_atomic_begin()
>   drm: rcar-du: Move rcar_du_vsp_atomic_flush()
>   drm: rcar-du: Move rcar_du_vsp_{map,unmap}_fb()
>   drm: rcar-du: Move rcar_du_dumb_create()
>   drm: rcar-du: Move rcar_du_gem_prime_import_sg_table()
>   drm: rcar-du: Add rcar_du_lib_vsp_init()
>   drm: rcar-du: Move rcar_du_vsp_plane_prepare_fb()
>   drm: rcar-du: Move rcar_du_vsp_plane_cleanup_fb()
>   drm: rcar-du: Move rcar_du_vsp_plane_atomic_update()
>   drm: rcar-du: Add rcar_du_lib_fb_create()
>   drm: rcar-du: Add rcar_du_lib_mode_cfg_helper_get()
>   drm: rcar-du: Move rcar_du_encoders_init()
>   drm: rcar-du: Move rcar_du_properties_init()
>   drm: rcar-du: Add rcar_du_lib_vsps_init()
> 
>  drivers/gpu/drm/rcar-du/Kconfig               |  10 +
>  drivers/gpu/drm/rcar-du/Makefile              |   4 +
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c     | 117 +--
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.h     |  14 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder_lib.c | 138 ++++
>  drivers/gpu/drm/rcar-du/rcar_du_encoder_lib.h |  30 +
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c         | 694 +---------------
>  drivers/gpu/drm/rcar-du/rcar_du_kms.h         |  29 +-
>  drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c     | 744 ++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h     |  61 ++
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c         | 407 +---------
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.h         |  26 +-
>  drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c     | 436 ++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h     |  76 ++
>  14 files changed, 1515 insertions(+), 1271 deletions(-)
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_encoder_lib.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_encoder_lib.h
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h

-- 
Regards,

Laurent Pinchart
