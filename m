Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA064E142
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiLOSsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiLOSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:47:57 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7DA49B5C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:47:14 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id l127so6062875oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CsTgnx/vUhdK+gz2CNEy5Z7hFYOJSlBzwtF5agxWOL8=;
        b=oJ/RLh3LE65rNsavJKHaY98DljooO1VSJWFUTr1wmqLEJMXIOe0CN8Q6agEtH9pvrl
         G0829Arhxti8Lxq/OboQdCGpM+BSSMy0u5YyANB0ogTqs7q29XR3OscSrV7QugBmLFVT
         5965GQ0r+20cquOxy7daSlbU9JSNv206QtP6u11wF0wmcfrZ2k5db2HoY18AnFjQ1QrN
         1Z8lML5DrGwyC4pgMHY3nFGGbRkvE3y7el4uYo4JlJQRjIR6yP0cTpl8w84fUt39z8Qb
         h7zgh8ztAeAa62eIxcm6VpzgPY7BiuaWyhLBvFCoLkcXVDABUvDH2EW3pASKTqCR/MTg
         7yjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsTgnx/vUhdK+gz2CNEy5Z7hFYOJSlBzwtF5agxWOL8=;
        b=Mm8sBYgZRP1pts3zDAUC2eueuUL0psXDox0Eng334Tf94Q1Sc7HisoL2VL38TL+VdM
         hyMT3mvqgZ42VxGv9LpuzHNs/zx2bsfcBqs3HeqBh62ZYFPBqEUAsV2CZsHVayvweQlU
         HrTfxiZYCkTR659jhFp0BTg4SemwE6FDvzqFvy8q5ybOZffg94jMNEwr1ZmRCho5cCr/
         B6bDoDtVWq3iLfdVQZbiV6mUKHoqj3l61Bqoj803zFwxAoarKoYAkWP1wk4PJ+aaK+lk
         x3GMbtqiaDS8zbmJk4M3knUg92ZC9NooG9OzTufK17T3BR8bMrMIjddolNxMTEqGCVa6
         kjzQ==
X-Gm-Message-State: ANoB5pkEHj4cJmvwep8qboz/1aGLBClXrgF82GD/apgBmwNT4GsJbAZ9
        6wnAXvaajF3nAm2SFpY9AG/wqHF0UC+G/0hNL9U=
X-Google-Smtp-Source: AA0mqf6sYeW3AlVu8sndUu1dAS9K8n4qGS3TdVKb977xhfSHkDUXzaWLTbMPA09k52WEWKWPUGEt6dskSiK1BWnMQhs=
X-Received: by 2002:a05:6808:1cd:b0:35b:f5f7:3ed0 with SMTP id
 x13-20020a05680801cd00b0035bf5f73ed0mr464102oic.46.1671130034322; Thu, 15 Dec
 2022 10:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20221215164537.1126692-1-arnd@kernel.org>
In-Reply-To: <20221215164537.1126692-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Dec 2022 13:47:02 -0500
Message-ID: <CADnq5_MxnmXaMW+D-F6fDLafwWPojHr2YuwX1mY8VM5a3S_Yjw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix duplicate assignments
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Alex Hung <alex.hung@amd.com>,
        linux-kernel@vger.kernel.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Roman Li <roman.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Duncan Ma <duncan.ma@amd.com>
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

On Thu, Dec 15, 2022 at 11:46 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The .set_odm_combine callback pointer was added twice, causing
> a harmless -Wextra warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_optc.c:258:36: error: initialized field overwritten [-Werror=override-init]
>   258 |                 .set_odm_combine = optc314_set_odm_combine,
>       |                                    ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_optc.c:258:36: note: (near initialization for 'dcn314_tg_funcs.set_odm_combine')
>
> Fixes: 5ade1b951dec ("drm/amd/display: Add OTG/ODM functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> index f246aab23050..0086cafb0f7a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> @@ -241,7 +241,6 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
>                 .set_dsc_config = optc3_set_dsc_config,
>                 .get_dsc_status = optc2_get_dsc_status,
>                 .set_dwb_source = NULL,
> -               .set_odm_combine = optc314_set_odm_combine,
>                 .get_optc_source = optc2_get_optc_source,
>                 .set_out_mux = optc3_set_out_mux,
>                 .set_drr_trigger_window = optc3_set_drr_trigger_window,
> --
> 2.35.1
>
