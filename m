Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103A6B8B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCNGWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCNGWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:22:45 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8A789F11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:22:44 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id o3so9701vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678774963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP5emk5ij6jshM8bNF/8R6cp8PTSDJxKM5rJKgfECeY=;
        b=McaU0YGzdkZ9HoyYFK5fQkHwDWreYN+JBXl/CPv41Sfxu7S2nsMcK+4dQ4JwApi27Q
         quv8FCqcuuW5EJ7n4AboO3p60WcSsKrldnvBQe2763QPm/3zxrI8lCLeIxfohX711kzu
         JsJcqdv7S8DC/MFOwSswEOYJ0Mc2lFWgdB1m9cOslz+G5nlwK6LJrzxbmlfWpKN7PuPf
         JD2a52e4mCXfeBOLjqDY1Ek/ssH6nu2i2B3iktI6HUqWCSDh1+YkcYRQnTjIu8/LtKms
         6bUwAAeMHuhQK0vKoJnLq9lxBKkDq1b1tJjfb0G/sv66rgOX9OR3ezpDMs6KZjUz35lF
         YQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678774963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mP5emk5ij6jshM8bNF/8R6cp8PTSDJxKM5rJKgfECeY=;
        b=WMKGQBuK1tHpnLy9p+hc0aVSGLL1Gz2M7TBSumbXCE9nhIGhNNcBntrQRW1/LfPzLt
         CSbfDwYcXjsvuH14hgYuTdI4yuTai8q4gyXWwUWo1icHSWiWO58RIjW33aL5d5zQtx04
         pbamiOyWrTAlR4Dxud9ExaERm95/Q9inYbIoqxjZZXubDQvjhqTwgZZcdEYT5c4IJlOe
         mXu56l4OSID6SagJ6WzQ+j52Rj2Z06CXNEJZpCNEXJklc0bjkh93inRgVJCK1uJGqKth
         5XVqpt6MSA0tqEh4WwBQnEtl4nbDCjQ7Eq3lGjMtyL5fek2QWW1epB6lsXyAp4xuymSC
         gI0A==
X-Gm-Message-State: AO0yUKXcUkjbQEoJ6eH4m+diudTaMjNnd0aB0g1GE9TV4g3B7WGIRmNE
        XlFHzceygjYlazvmk0WLv1uVJCpSuAlND95ud38=
X-Google-Smtp-Source: AK7set93QwubXRmJafDMw85VbcUHvhyg1cH2ItiXORXrlCQaBi7a+tHtXvJxTnt1oMBZ2mvp6I7vZ4JaIKk7pi1FjwY=
X-Received: by 2002:a67:d999:0:b0:423:e277:8c33 with SMTP id
 u25-20020a67d999000000b00423e2778c33mr5697413vsj.1.1678774963298; Mon, 13 Mar
 2023 23:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230314052711.4061652-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230314052711.4061652-1-harshit.m.mogalapalli@oracle.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Tue, 14 Mar 2023 14:22:32 +0800
Message-ID: <CAKGbVbsh4AXo+E4=T0eHeHS_ZuY4QYgRBF+Nbt+BFFMoJOMo0g@mail.gmail.com>
Subject: Re: [PATCH] drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Andreas Baierl <ichgeh@imkreisrum.de>,
        Simon Shields <simon@lineageos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Qiang Yu <yuq825@gmail.com>

On Tue, Mar 14, 2023 at 1:27=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Smatch reports:
> drivers/gpu/drm/lima/lima_drv.c:396 lima_pdev_probe() warn:
>         missing unwind goto?
>
> Store return value in err and goto 'err_out0' which has
> lima_sched_slab_fini() before returning.
>
> Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Only compile tested.
> ---
>  drivers/gpu/drm/lima/lima_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_=
drv.c
> index 7b8d7178d09a..39cab4a55f57 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -392,8 +392,10 @@ static int lima_pdev_probe(struct platform_device *p=
dev)
>
>         /* Allocate and initialize the DRM device. */
>         ddev =3D drm_dev_alloc(&lima_drm_driver, &pdev->dev);
> -       if (IS_ERR(ddev))
> -               return PTR_ERR(ddev);
> +       if (IS_ERR(ddev)) {
> +               err =3D PTR_ERR(ddev);
> +               goto err_out0;
> +       }
>
>         ddev->dev_private =3D ldev;
>         ldev->ddev =3D ddev;
> --
> 2.38.1
>
