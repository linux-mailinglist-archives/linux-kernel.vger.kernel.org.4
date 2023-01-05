Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F265F2DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjAERfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjAERfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:35:38 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776CFF3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:35:37 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id h185so10020740oif.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4BSkEEasM9xBRpEtduVdzqwndj5RyW9YuRlhkwCIB4=;
        b=DPGGg3n5KzcxEjttL1f+CMF2rq5xLBp39bAl5sIGkSEQzp6RwnQmEIOjYSrbZNcZcp
         gfYGcoO2TzFJOyzWbp5BeSnAGhkqcR4qIJQP/8OpvO02MZgSvJbvHp1sCseIQlFett7C
         lpQoOeIqnqNgaExRtgrVWGSM98HCGP9kNZy7VDvXsGUhZC/VdqbciQlXtLTHwBNnBfQw
         OHcxDQ8QQpdwOQPB4XaJXHklTP3xLAL6eRkDmtYQr7TdMS5/C06gVFGFFYY82FnRMA48
         rGT6MCaqlo4rWqzGVTsP4IfME+kXFRDAQT0xpssNGdLQWnvGumDoVu2meRPk/YotI9xJ
         cBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4BSkEEasM9xBRpEtduVdzqwndj5RyW9YuRlhkwCIB4=;
        b=HAedfaO4OXDy7DNCGyMMKqCYLmUV4hEnG+Di3u8HtMHs7ZMhHkksrcbH02qWxG5mWV
         NXke0gcgVVcst2jvZnWTu5gkt7iTw9nl0YxcfKu+3QFb9OVCcT9YlcO54zlOb9onlwnp
         /VBkeOc29QLljIN5PzgERys46Z/PiJwZYrq3y/6bntb7oex7icb4JKNU1dmF5M6URlBY
         hTlDJWWGyk/3l+248O7CjksYpwTl1FjLSifZ1mBUAhgQQ09Pqr5aRLoaLCSauaucvWUi
         phdb6MYo51Dig/Q+y8WwLF1gt4tk/S+uAse1NCO+o00nMEXJnl2C1gqHW4cF2VIzLJmj
         CfKQ==
X-Gm-Message-State: AFqh2krNeJUjnW0NhLBxatDua4BYDzw3NeSHajCqHM9naUdrimaDZkZL
        I+gKoIpi/SYgDZupkRphmNiLmx19uk9SCEJiWXY=
X-Google-Smtp-Source: AMrXdXuW7STqhYbguQ8byzSSIPnwB736bo/Nh54FFN0naD72Hw+ph+bw+Mc/CR5WVJol15a903OC4CGrvOjNi14Rc7M=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr3458236oib.46.1672940136395; Thu, 05
 Jan 2023 09:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20230105170138.717-1-mario.limonciello@amd.com>
In-Reply-To: <20230105170138.717-1-mario.limonciello@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 5 Jan 2023 12:35:25 -0500
Message-ID: <CADnq5_NChw4dwXukT7KJ5O7c=qFLg1umi1C-ykHd3eZG0biRnA@mail.gmail.com>
Subject: Re: [PATCH v7 00/45] Recover from failure to probe GPU
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lazar Lijo <Lijo.Lazar@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        David Airlie <airlied@gmail.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 12:02 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> One of the first thing that KMS drivers do during initialization is
> destroy the system firmware framebuffer by means of
> `drm_aperture_remove_conflicting_pci_framebuffers`
>
> This means that if for any reason the GPU failed to probe the user
> will be stuck with at best a screen frozen at the last thing that
> was shown before the KMS driver continued it's probe.
>
> The problem is most pronounced when new GPU support is introduced
> because users will need to have a recent linux-firmware snapshot
> on their system when they boot a kernel with matching support.
>
> However the problem is further exaggerated in the case of amdgpu because
> it has migrated to "IP discovery" where amdgpu will attempt to load
> on "ALL" AMD GPUs even if the driver is missing support for IP blocks
> contained in that GPU.
>
> IP discovery requires some probing and isn't run until after the
> framebuffer has been destroyed.
>
> This means a situation can occur where a user purchases a new GPU not
> yet supported by a distribution and when booting the installer it will
> "freeze" even if the distribution doesn't have the matching kernel support
> for those IP blocks.
>
> The perfect example of this is Ubuntu 22.10 and the new dGPUs just
> launched by AMD.  The installation media ships with kernel 5.19 (which
> has IP discovery) but the amdgpu support for those IP blocks landed in
> kernel 6.0. The matching linux-firmware was released after 22.10's launch.
> The screen will freeze without nomodeset. Even if a user manages to install
> and then upgrades to kernel 6.0 after install they'll still have the
> problem of missing firmware, and the same experience.
>
> This is quite jarring for users, particularly if they don't know
> that they have to use "nomodeset" to install.
>
> To help the situation make changes to GPU discovery:
> 1) Delay releasing the firmware framebuffer until after early_init
> completed.  This will help the situation of an older kernel that doesn't
> yet support the IP blocks probing a new GPU. IP discovery will have failed.
> 2) Request loading all PSP, VCN, SDMA, SMU, DMCUB, MES and GC microcode
> into memory during early_init. This will help the situation of new enough
> kernel for the IP discovery phase to otherwise pass but missing microcode
> from linux-firmware.git.

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> v6->v7:
>  * Pick up tags
>  * Fix PSP TAv1 handling to match previous behavior (securedisplay_context
>    only is set on PSPv10 and PSPv12/Renoir)
> v5->v6:
>  * Fix arguments for amdgpu_ucode_release to allow clearing pointer
>  * Fix whitespace mistake in VCN
>  * Pick up tags
> v4->v5:
>  * Rename amdgpu_ucode_load to amdgpu_ucode_request
>  * Add and utilize amdgpu_ucode_release throughout existing patches
>  * Update all amdgpu code to stop using request_firmware and
>    release_firmware for microcode
>  * Drop export of amdgpu_ucode_validate outside of amdgpu_ucode.c
>  * Pick up relevant tags for some patches
> v3->v4:
>  * Rework to delay framebuffer release until early_init is done
>  * Make IP load microcode during early init phase
>  * Add SMU and DMCUB checks for early_init loading
>  * Add some new helper code for wrapping request_firmware calls (needed for
>    early_init to return something besides -ENOENT)
> v2->v3:
>  * Pick up tags for patches 1-10
>  * Rework patch 11 to not validate during discovery
>  * Fix bugs with GFX9 due to gfx.num_gfx_rings not being set during
>    discovery
>  * Fix naming scheme for SDMA on dGPUs
> v1->v2:
>  * Take the suggestion from v1 thread to delay the framebuffer release
>    until ip discovery is done. This patch is CC to stable to that older
>    stable kernels with IP discovery won't try to probe unknown IP.
>  * Drop changes to drm aperature.
>  * Fetch SDMA, VCN, MES, GC and PSP microcode during IP discovery.
>
> Mario Limonciello (27):
>   drm/amd: Delay removal of the firmware framebuffer
>   drm/amd: Add a legacy mapping to "amdgpu_ucode_ip_version_decode"
>   drm/amd: Convert SMUv11 microcode to use
>     `amdgpu_ucode_ip_version_decode`
>   drm/amd: Convert SMUv13 microcode to use
>     `amdgpu_ucode_ip_version_decode`
>   drm/amd: Add a new helper for loading/validating microcode
>   drm/amd: Use `amdgpu_ucode_request` helper for SDMA
>   drm/amd: Convert SDMA to use `amdgpu_ucode_ip_version_decode`
>   drm/amd: Make SDMA firmware load failures less noisy.
>   drm/amd: Use `amdgpu_ucode_*` helpers for VCN
>   drm/amd: Load VCN microcode during early_init
>   drm/amd: Load MES microcode during early_init
>   drm/amd: Use `amdgpu_ucode_*` helpers for MES
>   drm/amd: Remove superfluous assignment for `adev->mes.adev`
>   drm/amd: Use `amdgpu_ucode_*` helpers for GFX9
>   drm/amd: Load GFX9 microcode during early_init
>   drm/amd: Use `amdgpu_ucode_*` helpers for GFX10
>   drm/amd: Load GFX10 microcode during early_init
>   drm/amd: Use `amdgpu_ucode_*` helpers for GFX11
>   drm/amd: Load GFX11 microcode during early_init
>   drm/amd: Parse both v1 and v2 TA microcode headers using same function
>   drm/amd: Avoid BUG() for case of SRIOV missing IP version
>   drm/amd: Load PSP microcode during early_init
>   drm/amd: Use `amdgpu_ucode_*` helpers for PSP
>   drm/amd/display: Load DMUB microcode during early_init
>   drm/amd: Use `amdgpu_ucode_release` helper for DMUB
>   drm/amd: Use `amdgpu_ucode_*` helpers for SMU
>   drm/amd: Load SMU microcode during early_init
>   drm/amd: Optimize SRIOV switch/case for PSP microcode load
>   drm/amd: Use `amdgpu_ucode_*` helpers for GFX6
>   drm/amd: Use `amdgpu_ucode_*` helpers for GFX7
>   drm/amd: Use `amdgpu_ucode_*` helpers for GFX8
>   drm/amd: Use `amdgpu_ucode_*` helpers for GMC6
>   drm/amd: Use `amdgpu_ucode_*` helpers for GMC7
>   drm/amd: Use `amdgpu_ucode_*` helpers for GMC8
>   drm/amd: Use `amdgpu_ucode_*` helpers for SDMA2.4
>   drm/amd: Use `amdgpu_ucode_*` helpers for SDMA3.0
>   drm/amd: Use `amdgpu_ucode_*` helpers for SDMA on CIK
>   drm/amd: Use `amdgpu_ucode_*` helpers for UVD
>   drm/amd: Use `amdgpu_ucode_*` helpers for VCE
>   drm/amd: Use `amdgpu_ucode_*` helpers for CGS
>   drm/amd: Use `amdgpu_ucode_*` helpers for GPU info bin
>   drm/amd: Use `amdgpu_ucode_*` helpers for DMCU
>   drm/amd: Use `amdgpu_ucode_release` helper for powerplay
>   drm/amd: Use `amdgpu_ucode_release` helper for si
>   drm/amd: make amdgpu_ucode_validate static
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |  11 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  22 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  59 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 299 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  25 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 259 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  14 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  14 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  65 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   1 +
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  16 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 155 +++------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 124 +++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  30 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  68 +---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  94 ++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 140 ++------
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  14 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  13 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  13 +-
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |   7 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        | 108 ++-----
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  99 ++----
>  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  80 +----
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        | 131 +-------
>  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c        |  79 +----
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  27 +-
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c      |  14 +-
>  drivers/gpu/drm/amd/amdgpu/psp_v3_1.c         |  16 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  18 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  18 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  47 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  30 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  55 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  25 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   5 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 110 ++++---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  11 +-
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  12 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  51 +--
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  28 +-
>  50 files changed, 900 insertions(+), 1545 deletions(-)
>
> --
> 2.34.1
>
