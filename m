Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66466CE77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjAPSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjAPSLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:11:35 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AEF1CF54
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:57:27 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s124so7163274oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5OkHX/Az8Mry0UKCOlHqO4EM33fiMoag3d66F0Eejk=;
        b=Rg4+a73abcdpBd7XsB2vRpplYYdmV6iqGARh7CQiaUgMxWvIa6FGDtkhjgLjghUsHa
         P7ECrLgFof/sqwJuhBdQFUbSCMdNKTi2uPkRRUkSBBeznLpZwlXN3G3iRa5HTG8J7H5R
         l8isod3hoEH2DzBeYtuPcuOd0RcBJ2B0J+rejWzokA0rWnL6IWULCkfNJP4qQVMuYgYA
         y8K4WUmu/e6tS1rDRGKmT3dTk+0KG7TAap/vIAIrOb441oSeU8Hm4P+RTIXm/jOL7pjJ
         sW+00I/LkJVhzwWsrVIfhXuGR9BrH9pJH9Wd/R7u/51hcYq460jzDmUP6QAx2pQu/bg0
         nDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5OkHX/Az8Mry0UKCOlHqO4EM33fiMoag3d66F0Eejk=;
        b=B+1XxqENuacROmU4Yz0FHRceQWpzwNUJMFzqsQvbZGW/vXwlaeG4jx4G3dp6Boev4a
         kKAFFRmvVaPDf7SdWCxhU9CnZJQuFthCV1AabDxSakDAXefc7aSxGUcj3NU/ISkD/VPZ
         xopb74klLdwyLN597hTPDQqS31cRM8XQPUoq3a1ASN8dB5YWLsmNFHWnZ23Qvb+sIidS
         jI4W9kRGMaCo0ySovZMCc+2jDj5L7JBm2HEI1WPXyVUVwhPjqnuFSwgPlxHxgN09LW5T
         Q+TFkGVvWmcDFsi6aUM6XZ9z7qUmSgGePRYxdXSvJDOx8lnlHzVSte5ekXrPQqyilIxM
         /Ndg==
X-Gm-Message-State: AFqh2kq5JPRRew97cfutVaoRZOSNZQsx4+4Btgo4mPUKN23COp7OUP0b
        zd9FU2rH/Ov83WPEFCrr67CWpgwJbVfw5kw+t1g=
X-Google-Smtp-Source: AMrXdXvOkWc2rL8rHfWhUdEhHY8Dl8h0BCl4hvpl0NJmh4GENZy24NQOJn6EpWg7UL7gEpJOCkrHr4MDKELVJafTjtM=
X-Received: by 2002:aca:2807:0:b0:35b:f5f7:3ed0 with SMTP id
 7-20020aca2807000000b0035bf5f73ed0mr8864oix.46.1673891846851; Mon, 16 Jan
 2023 09:57:26 -0800 (PST)
MIME-Version: 1.0
References: <Y8PGts5Nku8OSlRN@ubun2204.myguest.virtualbox.org>
In-Reply-To: <Y8PGts5Nku8OSlRN@ubun2204.myguest.virtualbox.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Jan 2023 12:57:15 -0500
Message-ID: <CADnq5_NyK_O=CypSz+WrAbM2MpsP_7D2RjB6JAu_qmyEnAVc6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use swap() helper macro in bios_parser
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

Applied.  Thanks!

On Sun, Jan 15, 2023 at 4:26 AM Deepak R Varma <drv@mailo.com> wrote:
>
> Use swap() helper macro instead of open coded swap instructions. The
> change also facilitates code cleanup and realignment for improved
> readability.  Issue identified using swap.cocci Coccinelle semantic
> patch script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 074e70a5c458..7b5894adbf51 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -2929,7 +2929,6 @@ static enum bp_result construct_integrated_info(
>         struct atom_common_table_header *header;
>         struct atom_data_revision revision;
>
> -       struct clock_voltage_caps temp = {0, 0};
>         uint32_t i;
>         uint32_t j;
>
> @@ -3032,14 +3031,8 @@ static enum bp_result construct_integrated_info(
>         for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
>                 for (j = i; j > 0; --j) {
>                         if (info->disp_clk_voltage[j].max_supported_clk <
> -                               info->disp_clk_voltage[j-1].max_supported_clk
> -                               ) {
> -                               /* swap j and j - 1*/
> -                               temp = info->disp_clk_voltage[j-1];
> -                               info->disp_clk_voltage[j-1] =
> -                                       info->disp_clk_voltage[j];
> -                               info->disp_clk_voltage[j] = temp;
> -                       }
> +                           info->disp_clk_voltage[j-1].max_supported_clk)
> +                               swap(info->disp_clk_voltage[j-1], info->disp_clk_voltage[j]);
>                 }
>         }
>
> --
> 2.34.1
>
>
>
