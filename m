Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBA766CE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjAPSND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjAPSMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:12:31 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6949C2310B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:58:48 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15ebfdf69adso12158410fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vgfXRILltDL8S4th3YYjCyiGREYlV3Wzl8EokshqMNY=;
        b=FHCujPFf3hVg/9eX5RypYIWhrfc+BxPlhn0Ye/kcvv6zEBXYT9qt8hLZnv18d2mz8o
         EjEs6I1t45nZRfcAdAW/5wHuo9CCG4XtYfjm6EVDOnv7ySS7xNBlGvj4nDRefeCrVWxC
         5gCI9/1E/+REHC+SBXVMzrj2PYK1nnoOAT4S526A3rIFsdWqw/zsBuG4Ba7UOVoi9IP9
         +QRB9ATxf5RVJPastXYGgVZZrfpnMt0sI16NFx6sxDlvYydCHpWyrxY4d6VFGu9a54TU
         PjmO5PhzDw3sJujpM9Vvom4PCkqp2mncX7o7LOpyH/twytvYH7HoHoZOhrDkU9XkdYRM
         F0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgfXRILltDL8S4th3YYjCyiGREYlV3Wzl8EokshqMNY=;
        b=IC0okrkTu1DpGvMazspOem0cejytFFNA6sac/OberWGzXzNqhtdAkoWGeeWbjKkQym
         QnuMWffpiEqY/LoQWKqBAUNx4IiTutem/1BIcK9jiOBgmG4mWAR3YouQ+5LsoNM+B2sS
         fLWIDy2hAOB6VMBBXuiwCT/DCQq5JVPP8T9hNrnX5Az/6K7bHdL+db0euJDIEjqzZ/Kv
         o4NxsVGdRC+8kJaI740XXy5q1qr4cz5Jy2o3i7usTEoULZ4VlLEQzgTtbDrlInF8m3UY
         nrrWM96Wl7U9Kh/ozv/rR3gQtTnXvOSTt08JfPQiFiz+8Ifb/B6VFfGlTJfinCZiOpsS
         LbDQ==
X-Gm-Message-State: AFqh2kok4bcQjeLaI9FPM1pyr4QZ14H8Y12X8Dd4p+y6XQdXNziz3VX1
        FMnPrUKNTAV6YDpn6oVCyEKoNDx8vRHgi65CnYYq475j
X-Google-Smtp-Source: AMrXdXvxUWNEueQOsZDzqdCgqeJ4gzqa9d6KCdyrfPanU1F9Nty4mte0rlSM9c7THwdnA/vkAXlHCW5oZYmAohu9szg=
X-Received: by 2002:a05:6870:7a18:b0:15f:5509:9a0d with SMTP id
 hf24-20020a0568707a1800b0015f55099a0dmr53155oab.46.1673891927813; Mon, 16 Jan
 2023 09:58:47 -0800 (PST)
MIME-Version: 1.0
References: <Y8PIId1k1TmIAo18@ubun2204.myguest.virtualbox.org>
In-Reply-To: <Y8PIId1k1TmIAo18@ubun2204.myguest.virtualbox.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Jan 2023 12:58:36 -0500
Message-ID: <CADnq5_OpLW77PqMi=-OYg=wam5FgFvB3CbFZHbPpotPo9G6Uiw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: avoid variable reinitialization
To:     Deepak R Varma <drv@mailo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
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

This is already fixed.

Thanks,

Alex

On Sun, Jan 15, 2023 at 4:32 AM Deepak R Varma <drv@mailo.com> wrote:
>
> The member variable set_odm_combine is already initialized and hence the
> reinitialization instruction can be removed. Issue identified using the
> dubleinit.cocci Coccinelle semantic patch script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> index 41edbd64ea21..777d8efee977 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> @@ -254,7 +254,6 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
>                 .get_hw_timing = optc1_get_hw_timing,
>                 .init_odm = optc3_init_odm,
>                 .set_odm_bypass = optc314_set_odm_bypass,
> -               .set_odm_combine = optc314_set_odm_combine,
>                 .set_h_timing_div_manual_mode = optc314_set_h_timing_div_manual_mode,
>  };
>
> --
> 2.34.1
>
>
>
