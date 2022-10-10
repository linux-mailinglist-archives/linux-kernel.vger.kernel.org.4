Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F85FA5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiJJUTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJJUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:18:53 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8547B2A5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:16:19 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-132af5e5543so13647825fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zQo9CpEQOxd8V/Gnq9d1IqgBFMZ32QQpuKIj7r7NKWU=;
        b=dSUXLhcRKIZVH3q5lAX9w1Sjipi2FBkD3S3AJw8zTLfOJybtcjQoPR1iTC7PLnVVuf
         TpaUyfjZ7mwW/0WOfIdM/KQYj8DsRzcXOQWCRdFRAsaNjYx4LhHo9LGEr2BXQo9SVB4c
         Vew7ExS55SDBCIQcUathisVLmkU5xfdBBZyByYFc59O2NtR/SFG3pELPoMILT7pHFkP2
         E5c7mWZIDNSQj6OojMGL1tRz9EcOy82oNgC8XMaGSYGz3UFFBzowfv9SRchUaD5xIi+J
         a5C4WmW5YAgqfam8iTjrfr7Zo6nPUor/YeKLZNRQvYWrPKTGKKqDY7E8tqE0SXPrLUJI
         FZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQo9CpEQOxd8V/Gnq9d1IqgBFMZ32QQpuKIj7r7NKWU=;
        b=Dn4gOqu/zUrFX5hXASI9QklNeVzljXyzVWuzav0ORWXRsS9SCR0g2ZbEkVHP+T4pFU
         0dwP3czMJXp1BKU7Eu9Oq7vZAi7UBMJevB4+m1Evtb7Br1OyuGJnHDMDDU9uOs7gZCga
         ZRhbE6qKXjFO8HHQmbNpqpHW7PvLY1byfrRuv4Z40JU9AIOfHwDo/5ZOiPuSgAisa258
         ZAGobqU2ZQTw/0fKstZc0TeFTaojwOf/271Ondlpg8fWaPk69AoJaL0Di+4s8295PFCL
         LyZ77utciUwPY4vWrRZTsAj/VHFsYdWtJzh2vv91Vgnr1OW5Hd2evyb7mutkPQpdJzWp
         xFzw==
X-Gm-Message-State: ACrzQf1jIrrBjSRKeFX6tPiIhM0sSmsqCQ4bKeX8i7JgQHRhKRhnd3iV
        LfpJ9ykb+9ReG9aCdt06N6yK9hUBbT6vs+jV7dg=
X-Google-Smtp-Source: AMsMyM4qJfDM7UUUcDtmV8h9gbgCQq1xrzkSI7eacitRYeX1RGvN1jyZLWCyX1jvdEm9guTjynYyZLTk48YwcyGMRtQ=
X-Received: by 2002:a05:6870:40c8:b0:136:4389:1375 with SMTP id
 l8-20020a05687040c800b0013643891375mr7561495oal.46.1665432977966; Mon, 10 Oct
 2022 13:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221010060512.3064524-1-linux@roeck-us.net>
In-Reply-To: <20221010060512.3064524-1-linux@roeck-us.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Oct 2022 16:16:06 -0400
Message-ID: <CADnq5_N5wLSnACnpuqVCMm7LGc20cdGdRhtnwRjUBq7vbrZn8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix array-bounds error in
 dc_stream_remove_writeback() [take 2]
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
        Leo Li <sunpeng.li@amd.com>, Xinhui.Pan@amd.com,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
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

Applied.  Thanks.

Alex

On Mon, Oct 10, 2022 at 2:05 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Commit 5d8c3e836fc2 ("drm/amd/display: fix array-bounds error in
> dc_stream_remove_writeback()") tried to fix an array bounds error seen
> with gcc 12.0. Unfortunately, that results in another array bounds error,
> seen with older versions of gcc.
>
> Building csky:allmodconfig ... failed
> --------------
> Error log:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:
>         In function 'dc_stream_remove_writeback':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83:
>         error: array subscript 1 is above array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
>   527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
>       |                                                             ~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:1269,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:27:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_stream.h:241:34: note: while referencing 'writeback_info'
>   241 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
>
> We could check both i and j for overflow to fix the problem. That would,
> however, be not make much sense since it is known and provable that j <= i.
> Also, the check introduced with commit 5d8c3e836fc2 does not really add
> value since it checks if j < MAX_DWB_PIPES. Since it is known that j <= i,
> it would make more sense to check if i < MAX_DWB_PIPES. Unfortunately, that
> does not help to solve the problem observed here: gcc still complains.
>
> To solve the problem, replace the subsequent check for 'i != j' with
> 'j < i'. This is identical to the original check since we know that j <= i,
> and it makes all versions of gcc happy. Drop the check introduced with
> commit 5d8c3e836fc2 since it is not really useful and does not solve the
> problem.
>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Fixes: 5d8c3e836fc2 ("drm/amd/display: fix array-bounds error in dc_stream_remove_writeback()")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index ae13887756bf..9f568d618cd0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -520,9 +520,9 @@ bool dc_stream_remove_writeback(struct dc *dc,
>         }
>
>         /* remove writeback info for disabled writeback pipes from stream */
> -       for (i = 0, j = 0; i < stream->num_wb_info && j < MAX_DWB_PIPES; i++) {
> +       for (i = 0, j = 0; i < stream->num_wb_info; i++) {
>                 if (stream->writeback_info[i].wb_enabled) {
> -                       if (i != j)
> +                       if (j < i)
>                                 /* trim the array */
>                                 stream->writeback_info[j] = stream->writeback_info[i];
>                         j++;
> --
> 2.36.2
>
