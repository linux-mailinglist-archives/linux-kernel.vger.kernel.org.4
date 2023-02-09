Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A631690BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBIObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBIObj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:31:39 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332635C49C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:31:38 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1442977d77dso2734442fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bAHq2aXoHE9Fe/KZsmeyboiiKh6zP+A9gzRXjKBxKu8=;
        b=ZcoBm1Ri0Z9Sk5SjI7nRheQwxs5BaGMxW+if4vsk8pC6GqwRLdSLhV+aNhibhJOOZ2
         8ojHsKob/AgvRN11PPVSh17NuQ1V/L/vJcUEBRFDt6e95suHbthebKmUyv3DowKX1H5u
         jZAL1hTKf+UUfYIqFhMyu92POgbnS9hi3RnUBRO/zL1a5em5CHRfJeMFQRg+2dVZhfWS
         vUuHQ+MfUD4iYHxLQfLtPxlPHTyii+nHqUD24gUV/UGT35S8CazCeiYBeVUpUUBUdBNE
         XUGrvSfZHJbFrGKOC/Pu8XhjcYJoDtbfwMfS93GI9ne9diwciFOxP3PhhOhmEAQdUvs4
         C1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAHq2aXoHE9Fe/KZsmeyboiiKh6zP+A9gzRXjKBxKu8=;
        b=f4eR7P1kJJo5a42R4AGkjH/sP8t/awRgrTysNlXPSsu5qB19EtWDlontQ10F8msiU2
         1pOikvtPgQHkl2ul1zRmUJhTeAj9mUGWU6AR4Xt5DPH6N/infqgFFZnlyO1dybvhX0Mq
         keaF6RbjFPdoKBbRr9v8DXteJikou/Ifr36TMgJHWMlUVt+mlG0W9QtuW51C7py11iW1
         dAN49jWNh811CrNxGnqxMjDdxrwoEkWh9mxR/vqPSKQscQxRTWbmU7NcxPSmmMvYFYoy
         3ddtaNssivgQR78LHuZHbKVEoNgPqK1Z+oT6DhyZBzBJzgGQM65MVAg3dxEQK+K9CwX2
         tnug==
X-Gm-Message-State: AO0yUKXO+SUMV0XvLXHRozYibtRWfxSwp1cFRMlSwsSN2CTkAoJSkjq1
        SDxapSNO14DLaB2JZosambpGPXz8iFnFTpuwLPk=
X-Google-Smtp-Source: AK7set82uDRv5nADn17D2bnmo1l46P/8c3InNahDM5vhaCkpxSWLBEyOT4US+eVY9f1hThDEzvpdaL7BWFbrQfaRTzU=
X-Received: by 2002:a05:6871:29c:b0:163:8cc6:86a with SMTP id
 i28-20020a056871029c00b001638cc6086amr1083579oae.46.1675953097478; Thu, 09
 Feb 2023 06:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20230209124513.1341645-1-arnd@kernel.org>
In-Reply-To: <20230209124513.1341645-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Feb 2023 09:31:25 -0500
Message-ID: <CADnq5_PMNWFZR-ZJ2d4RUtNJDLsP1AGEqLs27X4A7R22L5H3bQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix link_validation build failure
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, George Shen <George.Shen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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

On Thu, Feb 9, 2023 at 7:45 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_DRM_AMD_DC_DCN is disabled, the is_frl member
> is not defined:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c: In function 'dp_active_dongle_validate_timing':
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:126:66: error: 'const struct dc_dsc_config' has no member named 'is_frl'
>   126 |                         if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
>       |                                                                  ^
>
> Use the same #ifdef as the other references to this.
>
> Fixes: 54618888d1ea ("drm/amd/display: break down dc_link.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_validation.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
> index cd821d077d73..8ddebf3bdd46 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
> @@ -123,9 +123,11 @@ static bool dp_active_dongle_validate_timing(
>                 if (dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps > 0) { // DP to HDMI FRL converter
>                         struct dc_crtc_timing outputTiming = *timing;
>
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>                         if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
>                                 /* DP input has DSC, HDMI FRL output doesn't have DSC, remove DSC from output timing */
>                                 outputTiming.flags.DSC = 0;
> +#endif
>                         if (dc_bandwidth_in_kbps_from_timing(&outputTiming) > dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps)
>                                 return false;
>                 } else { // DP to HDMI TMDS converter
> --
> 2.39.1
>
