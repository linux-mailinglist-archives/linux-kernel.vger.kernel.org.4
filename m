Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8196675B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjATRdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjATRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:33:29 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFDCB507
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:32:57 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s124so5034705oif.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=87t+oUf+a0Dntkm1neH5VXJkrRsI/op4lJUax3qjibo=;
        b=C11141WGDsrnqbvFx18+o4BqFM9T5uzgu0a9bCtay8eJiafXb5ICVY922ub5/qLDah
         ksS3XsCN7F9xF6+eDXHHtozZjAq2Q2yg1Br5q4PspU+33c5btcapDYnRoBfGozvMs8xB
         ej/M2h86SQGaj6x+pUobn/yPXfV2EANiLb2MsHJlXMvUoDg8zxRRgClQgAaOVM0nWMiQ
         pMgarJMIeI6mpiNKd35zAGAm9GydqW7tGeAfQDwBJDyNBer2x6N7+5cwXxk6w+4JZxse
         AYPPaewMvXfaeqjXr/zkeCNwTejY8ljAqKBhSYEviFnMpnOVlga5XZBHp8ISiu3e8t5Q
         AeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87t+oUf+a0Dntkm1neH5VXJkrRsI/op4lJUax3qjibo=;
        b=IP9a9qoRyFrV91stQMv0arKIhNW+P5h/S6u19ljdFW5eM/fR1C9/ZIgT1GdctkXqUr
         5UmtOLOcyK6ZaN2OKUKY0xCSQsvgjmcyP0RPjX5wfLKK43rGyImAbXQG87TX0CYvXht2
         i+dVtxciZiDtHLsuX43e5arvK6uny9eUkir0JG2Vaz2OWhPLIp9PKF2h1CYSM91yL2QA
         Ie6M3iUCzsRMOBv1of3QU5gZXtZhy4n2VHQmZdXbNMa3gPPAqydpwz+S8mzLLjQt9rBx
         ToKWdgP5JnNUVKtkixz+zWNr+nQYsTWFTcNHijdb2cHz6TVhLv6rkWGOaslnUOL2h8JN
         C74A==
X-Gm-Message-State: AFqh2krdfOpz4hhN+AyIjCfLwjpOfPiUsoAXl7rXntCAZWshzQRDrxNH
        y1Timy0NvHnMMV3r2AZ+0op2nkw/HbMH2R973HLvqVHC
X-Google-Smtp-Source: AMrXdXsOtiPsMwKEFnxgJcl1dP7zHFtGdt88xKMd5HouHyfTb+B956vMHCeiRA78YVCNR81SkmOrLXSdERXCJuRPYQk=
X-Received: by 2002:a05:6808:4387:b0:35b:d93f:cbc4 with SMTP id
 dz7-20020a056808438700b0035bd93fcbc4mr886518oib.96.1674235972772; Fri, 20 Jan
 2023 09:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20230120173226.98569-1-hamza.mahfooz@amd.com>
In-Reply-To: <20230120173226.98569-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 20 Jan 2023 12:32:40 -0500
Message-ID: <CADnq5_MVRBeduHKqUAcPSRF9ruAU5WVOG0w407edocCKME8nXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use a more appropriate return value in dp_retrieve_lttpr_cap()
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jan 20, 2023 at 12:31 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> Not all ASICs support LTTPR, however if they don't it doesn't mean that
> we have encountered unexpected behaviour. So, use DC_NOT_SUPPORTED
> instead of DC_ERROR_UNEXPECTED.
>
> Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c
> index e72ad1b8330f..21fd9275ae4c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c
> @@ -1462,7 +1462,7 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
>         bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
>
>         if (!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support)
> -               return DC_ERROR_UNEXPECTED;
> +               return DC_NOT_SUPPORTED;
>
>         /* By reading LTTPR capability, RX assumes that we will enable
>          * LTTPR extended aux timeout if LTTPR is present.
> --
> 2.39.0
>
