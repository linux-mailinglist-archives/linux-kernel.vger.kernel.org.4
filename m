Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD69B67236F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjARQee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjARQeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:34:16 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A9E24121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:32:27 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12c8312131fso36064550fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzGHdZnG38PUUso3BdMIxZ7feb7Goq8YWG54jrX7zvU=;
        b=GzemvJG3q98iiC1WOZ/vHs+0ci5tOEzqaW+djlTNc/h3csNqfHs8q3ah49wH69giFg
         Xd+vx1PvINMXJr9GDJ2t3YQ389aUfD5tKEO8m9EX7XorrooVPyqaC8MV0rd0DEESzKOp
         xBfHIxUjb7j5kk6DaGyyUmFbLg8Ly53BNGcVIVgll32oMGVW9NptEFEkTDjDShyTKlT2
         0e/zPlwN1iCRWFNfpQEA2zAc4wlEnoyROiEP49m+ty63pY27BV4dTFwz2HKjfJUs6BfH
         RNbS8BB868nWBfPIa5dortHoUp2ymPSyXmoV84X/nO9njNScIdO2LeykUaAK0QARvbaM
         Vu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzGHdZnG38PUUso3BdMIxZ7feb7Goq8YWG54jrX7zvU=;
        b=LlxRL/ekPv55J3sthRh5rDOtZzyJmpmfIyLvHoqEX46wGVoxQCjIj0yacet7RWSi1S
         UoHt+eJlSDHDV0vhhyIAqx4Wnb20k5av9ThcE2jUBvAiNk3yHXhhin4nrqGgznbmbQH4
         n7dXHijXPE3VE8Rlw52Sxsyb+BFSsvl7LvK4gnQivfpRDIVKgfFvi5+5wILSx3WFCMJW
         vBJJTeWs81peEEyV+EnRq0405O9RzV/a/R7sAU/sCRbn7yc1YA51PGVDq0PEpbQqUjsX
         Tlh5PHJmrwkye4VlJnSdorstkw1sDnZGDTePLawTSGDp5Aj2alFtrjOvDOPCcNYXPbAs
         9R1g==
X-Gm-Message-State: AFqh2kqNZPJmDPJ+5TSUMEw6rE5WZfzFihlZV8EnfKcQFpJnoDL1c/GR
        9dnwpVI1tq4SW6ECFG18KodVBVLxpA5suzOB5LN8zqdr
X-Google-Smtp-Source: AMrXdXs3xaVHPfIEvEvlPCi6maxmp3xBY1Iji7ce+Clj8jRQDwb5a3yegddizqXtH7OPOAPAkq/8C0VDJbyVyAapx/k=
X-Received: by 2002:a05:6870:7a18:b0:15f:5509:9a0d with SMTP id
 hf24-20020a0568707a1800b0015f55099a0dmr726423oab.46.1674059546916; Wed, 18
 Jan 2023 08:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20230118160722.289840-1-arnd@kernel.org>
In-Reply-To: <20230118160722.289840-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Jan 2023 11:32:15 -0500
Message-ID: <CADnq5_NPmDjmU+KpHU6z_pNDoASim7Hokq9XnHu8ONP6HqZZdw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hdmi_encoded_link_bw definition
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Ian Chen <ian.chen@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Solomon Chiu <solomon.chiu@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        "Shen, George" <George.Shen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Po Ting Chen <robin.chen@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied.  Thanks!

Alex

On Wed, Jan 18, 2023 at 11:07 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some of the data structures are hidden when CONFIG_DRM_AMD_DC_DCN is
> disabled, which leads to a link failure:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:234:21: error: 'union hdmi_encoded_link_bw' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>   234 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
>       |                     ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:234:42: error: parameter 2 ('hdmi_encoded_link_bw') has incomplete type
>   234 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:232:17: error: function declaration isn't a prototype [-Werror=strict-prototypes]
>   232 | static uint32_t intersect_frl_link_bw_support(
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c: In function 'get_active_converter_info':
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1126:76: error: storage size of 'hdmi_encoded_link_bw' isn't known
>  1126 |                                                 union hdmi_encoded_link_bw hdmi_encoded_link_bw;
>       |                                                                            ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1130:101: error: 'struct <anonymous>' has no member named 'MAX_ENCODED_LINK_BW_SUPPORT'
>  1130 |                                                                                 hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
>
> There is probably no need to hide the data structure, and removing
> the #ifdef makes it build cleanly.
>
> Fixes: d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> index b7e53b7dc4ed..84da54358922 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> @@ -361,14 +361,10 @@ enum dpcd_downstream_port_detailed_type {
>  union dwnstream_port_caps_byte2 {
>         struct {
>                 uint8_t MAX_BITS_PER_COLOR_COMPONENT:2;
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>                 uint8_t MAX_ENCODED_LINK_BW_SUPPORT:3;
>                 uint8_t SOURCE_CONTROL_MODE_SUPPORT:1;
>                 uint8_t CONCURRENT_LINK_BRING_UP_SEQ_SUPPORT:1;
>                 uint8_t RESERVED:1;
> -#else
> -               uint8_t RESERVED:6;
> -#endif
>         } bits;
>         uint8_t raw;
>  };
> @@ -406,7 +402,6 @@ union dwnstream_port_caps_byte3_hdmi {
>         uint8_t raw;
>  };
>
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>  union hdmi_sink_encoded_link_bw_support {
>         struct {
>                 uint8_t HDMI_SINK_ENCODED_LINK_BW_SUPPORT:3;
> @@ -428,7 +423,6 @@ union hdmi_encoded_link_bw {
>         } bits;
>         uint8_t raw;
>  };
> -#endif
>
>  /*4-byte structure for detailed capabilities of a down-stream port
>  (DP-to-TMDS converter).*/
> --
> 2.39.0
>
