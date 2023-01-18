Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10DB672340
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjARQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjARQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:30:04 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68AD568AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:27:43 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id d6-20020a056830138600b0068585c52f86so5323553otq.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLdC3qx5X23ZTWTn4lkdwFcqpO5MTmWNpyLG41+WA1s=;
        b=nLf9epBFlxR6krgARsD3lbkWmGeZHvQA1oRluTyMi/qL2RWgXgcljSPE7Um4nStOdu
         9SI5Cz6hszekFbr1yxIl4bVZbVtn3y3jp605uNt12b8Yue1hdvqQzaXvDLANaOetbLew
         +hycseY5Y1eFI5b3JV+GAXEogzZsxBHm6g2iZmYvUCRazrBJfQ8dUH/l1OOB91/SQxMg
         p4O6FNSjUiv7p7V9d7jm1LkClKWZ3XUSIyu3d85I8Qbh/7eKN3EXAxIptZRpdbMRDK8S
         78bakS5oUq1sAleAjQPlmLtyqKiFDNRJ9X5YF0dBh9l8ozwVy+5FeDdnY6NyTutrOd2u
         t6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLdC3qx5X23ZTWTn4lkdwFcqpO5MTmWNpyLG41+WA1s=;
        b=CeNGOyMMjJqCbGmTfLynqnDKOb22hqSWFDfIBQgveezr7N65Pvc/oo7N4rH+H7oZ5n
         xaq98Y806XHnxSNxgAfcl63afP8Hmu9lhgN5h6MXeJuro/bYFQlqOjABMdIWjfK8i37J
         0SfCjOBvV4An2AKHmmLsTt8RMXY6Ukc6EWx6+tMMXAIwmxJ482vl2rOzdSTWTgfJLWYJ
         uhGNFnvWtAAXnmWTwyTBoXrRm/Hs7nSNHPvQsPGt8Dt9gD58uS+9nXa22FIIj+ZXDuAL
         K2t2ZqJB+D/hlW8f1sDlqf1cMuopyAmmmFJATIZzUht6EBHrhp0boep3hOWsi16Eu632
         leZg==
X-Gm-Message-State: AFqh2kotp2tiVqobjPp4MTt9gw6snjoaBnnbBXXV3RVwoBXIbmhm+2mw
        EthT8nKDo00m0dpHrPAwUnEJP1DRAnvvkdHYB4I=
X-Google-Smtp-Source: AMrXdXsegNk4k/rAkAxVNuPoRKAagjpW/F5xdsb24pH+zMi0Qk+mVGdtzKwl2en7fSBvf1GQSm5XETg6FeTPZl2AstU=
X-Received: by 2002:a05:6830:449:b0:684:bedc:4f54 with SMTP id
 d9-20020a056830044900b00684bedc4f54mr406381otc.233.1674059263009; Wed, 18 Jan
 2023 08:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20230118093011.3796248-1-arnd@kernel.org>
In-Reply-To: <20230118093011.3796248-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Jan 2023 11:27:31 -0500
Message-ID: <CADnq5_PF7j+X6_o7tVrnhnKhSY9=gASSgxzpTwPJ7WEq=YsR+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix dp_retrieve_lttpr_cap() return value
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Lewis Huang <Lewis.Huang@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
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

On Wed, Jan 18, 2023 at 4:30 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-13 notices a mismatch between the return type of dp_retrieve_lttpr_cap()
> and the returned value:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c: In function 'dp_retrieve_lttpr_cap':
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1465:24: error: implicit conversion from 'enum <anonymous>' to 'enum dc_status' [-Werror=enum-conversion]
>  1465 |                 return false;
>       |                        ^~~~~
>
> Change the value to an actual dc_status code and remove the bogus
> initialization that was apparently meant to get returned here.
>
> Fixes: b473bd5fc333 ("drm/amd/display: refine wake up aux in retrieve link caps")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c
> index 088f4291bfbf..e72ad1b8330f 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c
> @@ -1455,14 +1455,14 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
>  enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
>  {
>         uint8_t lttpr_dpcd_data[8];
> -       enum dc_status status = DC_ERROR_UNEXPECTED;
> -       bool is_lttpr_present = false;
> +       enum dc_status status;
> +       bool is_lttpr_present;
>
>         /* Logic to determine LTTPR support*/
>         bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
>
>         if (!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support)
> -               return false;
> +               return DC_ERROR_UNEXPECTED;
>
>         /* By reading LTTPR capability, RX assumes that we will enable
>          * LTTPR extended aux timeout if LTTPR is present.
> --
> 2.39.0
>
