Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2121E670D97
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjAQXeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAQXcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:32:54 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E383CE33
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:03:14 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id v17so5699441oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zfEqVK+RYVz2dN9ZOupR4yHgB7WZQv3MJYztxeL+5Xc=;
        b=LDfx9vc+Y38Mn1Rs0kcG0pXmB1UTfEU/iOvU7gmofIoKOya9iHq6VfoY1qU/kBB0k6
         vlxeI9awjroyWOiws1Kj+ylDPMGff9OYplninlS7bWj20s3Iqrz+VFqv9YDDOnkIUhAG
         pLyGgUT+2y+xCj6EAGD+Wosk/sh+sMqq1t0xOaZmikJsKMfxobPgIwPiPseY2nw5qXe+
         8Bn23e45g8OElQ6sBCbErDUAaoJSZKKiYg1XY+DmtfPO5NOHPk7bi1viLmweWPp8UX7T
         PLHsVxe45pZPQ1xtEhBX/6yscP8QfaXu5y206tNE7jxIGeqiWvtmA4/QTuYWZylZIU7f
         0leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfEqVK+RYVz2dN9ZOupR4yHgB7WZQv3MJYztxeL+5Xc=;
        b=r49TTO+J1HT3l3IACfyqiqZ9TyCMonSI16218Bh9ViuoXsPcYF7yqSVci3z+cHxsCP
         N2UNCN7Nvo4ngijXRogTrWg4kMpy1yGZuLd2dDMZakaLEt6gxjw2xrdoN1Zmatv0yXGh
         i3i9gSRs44yTHWHp2hbQJpmzdkWw9Z7CDZseXezE2myTl9XaFFmlbGTZ36UqmNKRT3g4
         ADa/V46weMEtxfwx1yyw3A/4428/9z05kSIeDegrgT4TyKx44QuLJNn56+XauPNbv6lL
         SdWfdnBQcTUL7OPOrvF0pW4D7NNUJILPxzgxQeUNxN905Y46ULetIzlwDJK9IXXodeTs
         HGdA==
X-Gm-Message-State: AFqh2koY+dduPKGaj4viHx1hmi06fwQTKh3JMNYElwK6FsXlTb+lBjcb
        Zjjjeth4VKrCTGFLLrSrtL9P8Gnoi8TeQB4OUkA80YTS
X-Google-Smtp-Source: AMrXdXvDFWC8RH8P2THHJkEJ8U8eikLyA3GduhlkdGUC68h6pM+zXj1AXAk7a9ylP3xIx2YJx2ehvp/stRmWfBk9Uxs=
X-Received: by 2002:aca:2807:0:b0:35b:f5f7:3ed0 with SMTP id
 7-20020aca2807000000b0035bf5f73ed0mr299595oix.46.1673989393929; Tue, 17 Jan
 2023 13:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20230117205452.195298-1-hamza.mahfooz@amd.com>
In-Reply-To: <20230117205452.195298-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 Jan 2023 16:03:01 -0500
Message-ID: <CADnq5_Njw0uFYnB7--A=0Zv78ETLeXpNvH6Zc4znpTPLLQgwkA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix issues with driver unload
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>, dri-devel@lists.freedesktop.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        hersen wu <hersenxs.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org
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

On Tue, Jan 17, 2023 at 3:55 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> Currently, we run into a number of WARN()s when attempting to unload the
> amdgpu driver (e.g. using "modprobe -r amdgpu"). These all stem from
> calling drm_encoder_cleanup() too early. So, to fix this we can stop
> calling drm_encoder_cleanup() in amdgpu_dm_fini() and instead have it be
> called from amdgpu_dm_encoder_destroy(). Also, we don't need to free in
> amdgpu_dm_encoder_destroy() since mst_encoders[] isn't explicitly
> allocated by the slab allocater.
>
> Fixes: f74367e492ba ("drm/amdgpu/display: create fake mst encoders ahead of time (v4)")
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 4 ----
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 -
>  2 files changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9547037857b6..5cc14ed2e93e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1733,10 +1733,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>                 adev->dm.vblank_control_workqueue = NULL;
>         }
>
> -       for (i = 0; i < adev->dm.display_indexes_num; i++) {
> -               drm_encoder_cleanup(&adev->dm.mst_encoders[i].base);
> -       }
> -
>         amdgpu_dm_destroy_drm_device(&adev->dm);
>
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index bbeeee7c5d7c..5fa9bab95038 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -492,7 +492,6 @@ static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs
>  static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
>  {
>         drm_encoder_cleanup(encoder);
> -       kfree(encoder);
>  }
>
>  static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
> --
> 2.39.0
>
