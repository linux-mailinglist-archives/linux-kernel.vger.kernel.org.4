Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF416E6D49
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDRUJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjDRUJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:09:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF54C3A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:09:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2472a3bfd23so1414934a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681848591; x=1684440591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJjRijV5blbjzZLZll3N1JO9eikZc6Mlip365pggL9w=;
        b=RxI8ccMnJU34C26Ht6af/Th3w247gQIO0uQnzRfH2qt11y5bG/KVu1JIv98zlpx4D1
         6+T+7fm9LFj2LYaDIo2LT8T1Xo9ePq7ThXSPvAlSvNHct8dmTKu+ixGW2MxKCmKPEic5
         0NMP5HW32YUXzNX6ZAvMzUZ+r7/o+fZqhWAmOZNWEtuGQr2uKAwqdsnDPOcnCQXkusAL
         lEJpFgOxxgNb/wSBQGjXS2rZ5x92nLQ4+hV53yJlZyN8pSO9LtwYDE3KxhzcV0myrIXX
         ZNsRtuRyCHtRAnfOYgVIMLVSDSYy3KfNTnfDpnhlSRuUbePgyG4vh2nQsd84Uc0WGgIG
         AqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681848591; x=1684440591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJjRijV5blbjzZLZll3N1JO9eikZc6Mlip365pggL9w=;
        b=epw4CfXlthAtdHMYYkuerq0Xsi7q4PAQKeZcXFFezW2CgPwzM2dY5pllTLmfXGJt7Z
         0vYsVWtKb184ggvJO/FFDScromMiIp45SCXV/dhbw9c1ERdouDgSjWKdmwK8OKLWu1aC
         PmAkh4eWOAZUpfO6b79UpcoARMgkzBoHdQzCtuX7z+S/INhrLPtALMHvCCDc3tyykOBN
         sg8TfMQ1RprB7jLLkIsICiiW0i59tOZwOS2tvRB+KyTKkDPU5bDgivCSW/dgslhvCrVf
         uyS1OYONiy9LBburLeZ9MsMd/lDmgOilZrKR3onm/EtkiivVk5CtuRT27rGs0raLW5Qy
         nqRw==
X-Gm-Message-State: AAQBX9dubxlJWR7iB7MqPDsz00NsviW2PFzjbIwDVJmxC4ImvU/c2y+T
        JO4M18gh5ztxiMOq1P+AqNuFaxcaqlMt3lIRcgYejA==
X-Google-Smtp-Source: AKy350baeGq9wa+UpgsWuLoH1elNcvdt1oOkfqqmaCQpAHbi6Eath+2E2j22ABbywJdPOlHgLe3u3xkeQP5kmoW7nv0=
X-Received: by 2002:a17:90a:fe8c:b0:246:f73c:3aba with SMTP id
 co12-20020a17090afe8c00b00246f73c3abamr618143pjb.39.1681848590753; Tue, 18
 Apr 2023 13:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230408165023.2706235-1-trix@redhat.com>
In-Reply-To: <20230408165023.2706235-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 13:09:39 -0700
Message-ID: <CAKwvOdmFtc0shP45t7S9aoh1+UGXyaX_aodvJd97d-nH5J0HQg@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: remove variable count
To:     Tom Rix <trix@redhat.com>
Cc:     airlied@redhat.com, kraxel@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 9:50=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable
>   'count' set but not used [-Werror,-Wunused-but-set-variable]
>         int count =3D 0;
>             ^
> This variable is not used so remove it.

Thanks for the patch!

Fixes: 64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_cmd.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.=
c
> index 281edab518cd..d6ea01f3797b 100644
> --- a/drivers/gpu/drm/qxl/qxl_cmd.c
> +++ b/drivers/gpu/drm/qxl/qxl_cmd.c
> @@ -421,7 +421,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
>  {
>         uint32_t handle;
>         int idr_ret;
> -       int count =3D 0;
>  again:
>         idr_preload(GFP_ATOMIC);
>         spin_lock(&qdev->surf_id_idr_lock);
> @@ -433,7 +432,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
>         handle =3D idr_ret;
>
>         if (handle >=3D qdev->rom->n_surfaces) {
> -               count++;
>                 spin_lock(&qdev->surf_id_idr_lock);
>                 idr_remove(&qdev->surf_id_idr, handle);
>                 spin_unlock(&qdev->surf_id_idr_lock);
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
