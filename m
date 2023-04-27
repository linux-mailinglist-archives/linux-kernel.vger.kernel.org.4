Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABD6F0C25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244515AbjD0SvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0SvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:51:10 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2673A82
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:51:09 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-38bed577755so3296534b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682621469; x=1685213469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj/UQ4EcbnPYX5rdQ2FvYxfbgSOOZ5uRyKBmHlffxD0=;
        b=feWpeKjy4Sm9WZ7b/pmiLnFFZIGc9T7VUaULKfCt+h8y00oglLNWZnO1AUj/v3GvTg
         RJx94X1q0Y2oaGd496aUHH52PdWa7vtZDDj/j+ywnG8msPz0EzD64GmJqd0/zajrF/TQ
         ZAQr/tw0N0lAR+CdrS6TXNzM4L5mZyjiOVTmc7nemSJlZ2NYh2WJfeCKj+fn1fA64Otq
         bflm1HlReI7Zk3+9tfrzvJLs8iZ2H5MuA8N3/uyTvaXRNf9lHJ9LkrGFQpwBXwfwHmJl
         41QLwgUBiPS8CA/obC//N88K3/zQA5V1elhBb3/0noB0bohqB7iV/osY6KEq6+30smYJ
         VL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682621469; x=1685213469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj/UQ4EcbnPYX5rdQ2FvYxfbgSOOZ5uRyKBmHlffxD0=;
        b=UaC9sv91IEUvMuzOWM3PaAnyPWysckpibzgbm2h5hj2AXMC9iDlwZACKp5RrA0uFP7
         TIS17xTIPArgr17r90xciKvORfe4G2eEsQzijlFEhBaZb8s/2TGYr2Q+6DwP9B0hAJrf
         xUCo+2uv/imv6JKsBppjuzB5zTveY9ZipyG+89j1oUnV7U66EvEBwj09tO25U+KfHEut
         tVELPf+M6sbZ5BroBCiR1J97+Gu4EGXuw4hlRFN96ErqC+LguXP/ZrHDuP5b/YGqwtyg
         LU+0wLdkhy1DfKF941voFE4/42Xa1iOmE8mVsmfP1aWlhyHx4/ELmxgTmtvH+nR3nVc/
         Xg6Q==
X-Gm-Message-State: AC+VfDw3EdUECsHjRn0PuEY3Eg3hwhioH1AK+toHDZlBqfF1gNA6esH1
        YQ5pIeAKtHdvYUCNLFRC+4jXe3F1Q/fFGZH1nXo=
X-Google-Smtp-Source: ACHHUZ4eZ4DAEDIK0HbrjPaPpejSm+oDIFgpiHFoT+ZzsqnI11a4sHlFLxDUZdwYEQ9bI1gMnrKuuC4PpWSFm0URrco=
X-Received: by 2002:a05:6808:1cf:b0:38c:25e3:d9d2 with SMTP id
 x15-20020a05680801cf00b0038c25e3d9d2mr1130277oic.57.1682621469037; Thu, 27
 Apr 2023 11:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230426225458.877481-1-olvaffe@gmail.com>
In-Reply-To: <20230426225458.877481-1-olvaffe@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Apr 2023 14:50:57 -0400
Message-ID: <CADnq5_MEc_YAfts-wWEZVsm=bJLv5CT65qNX8c-qj_VZsxnS5A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: add a missing lock for AMDGPU_SCHED
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Apr 26, 2023 at 6:55=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote=
:
>
> mgr->ctx_handles should be protected by mgr->lock.
>
> v2: improve commit message
> v3: add a Fixes tag
>
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: 52c6a62c64fac ("drm/amdgpu: add interface for editing a foreign pr=
ocess's priority v3")
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_sched.c
> index e9b45089a28a6..863b2a34b2d64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -38,6 +38,7 @@ static int amdgpu_sched_process_priority_override(struc=
t amdgpu_device *adev,
>  {
>         struct fd f =3D fdget(fd);
>         struct amdgpu_fpriv *fpriv;
> +       struct amdgpu_ctx_mgr *mgr;
>         struct amdgpu_ctx *ctx;
>         uint32_t id;
>         int r;
> @@ -51,8 +52,11 @@ static int amdgpu_sched_process_priority_override(stru=
ct amdgpu_device *adev,
>                 return r;
>         }
>
> -       idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
> +       mgr =3D &fpriv->ctx_mgr;
> +       mutex_lock(&mgr->lock);
> +       idr_for_each_entry(&mgr->ctx_handles, ctx, id)
>                 amdgpu_ctx_priority_override(ctx, priority);
> +       mutex_unlock(&mgr->lock);
>
>         fdput(f);
>         return 0;
> --
> 2.40.1.495.gc816e09b53d-goog
>
