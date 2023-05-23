Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750E970E75C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjEWVaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbjEWVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:30:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B718F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:30:11 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f38a7c5d45so25425371cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684877410; x=1687469410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12a8TVZQvjkkyWtI7fz8x1oDJA/k8YRY6ApQKDzedDE=;
        b=i5moAtbaux+oKTRJvt8kgT2kh9lY+QtUnf5dOM8p9NVz4BW7Jbvr/60GqaqzzqW91O
         ciN7S77mH1rmkRF+C0oA2vYi02ye9vfNbVpAmFoKiPBeORYUuzHCIKrCwltxv5szNa+B
         2OQBuSzBN/s/EG4L6EegcVwP1XVnCnWc1EAQNkV5cI+Sz7UdfWpertNCSdk1DfxA02R4
         Ky5c0TpQcbqG4a8Q1xOvmGokmJMDow7bLEH67Ow78PcsGt+TgIEK+/XGezREYGbPWYac
         m1qKMHu+hz4+FsbCHOWFJiYEEn37+QHR3z+Uoi88pXSBgnIzSpenOztV60VvMWUjIBJY
         j6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877410; x=1687469410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12a8TVZQvjkkyWtI7fz8x1oDJA/k8YRY6ApQKDzedDE=;
        b=aK+zM9bD8A0/kjREwUPdqgEa3mMtZnWgNPKDHkR/Ha3idUA/0evrVjC+eYMdKxfq5M
         f7Vfmb/xhuM5Mhjqbh3PzU8oNbpH1uBjPHrAJ8rr/ACJT8D8ErP38rw1tJ5hiQ6/1NTb
         XwrmpyXaGQCQr/xK1LsugMyoAkCE4gTwtqfyMlOYnFkl9nHVvqPAIuP3r5+FXhjldFAb
         kaMEE/mnQxHWJoH0cFVx3GyU/3oJ1SEs+Xn1+OrB+4ONUde33aPFL6DA3C4LsttxfGUH
         0euIaW/MaQODfINpCXCnuaPI6qkx73DGA9ZvzoVdykH6ez8wazdniM639EXTUQsiCNXN
         qtfQ==
X-Gm-Message-State: AC+VfDxzO64perIk8nO9DjKMZz9o5qIyR0P5HSg6WL2O+pE8Y/6fSJ87
        xyPqsapb0l0KalnHNbtxZWbeKcNkFkCMdopxcJQqIQ==
X-Google-Smtp-Source: ACHHUZ4Wan+pBGA30UDc0Hp2h00PD3iAXL1/dmWzS2pNFookLK0VclHG8VPaSvULEt2cdpPwFDE0Oudo35XhtSYs7m4=
X-Received: by 2002:a05:6214:20ef:b0:623:7108:362d with SMTP id
 15-20020a05621420ef00b006237108362dmr28098589qvk.9.1684877409885; Tue, 23 May
 2023 14:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230523212050.9970-1-aweber.kernel@gmail.com>
In-Reply-To: <20230523212050.9970-1-aweber.kernel@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 May 2023 14:29:59 -0700
Message-ID: <CAKwvOd=00s_MMQcnbyQkEsUE8HwhSCw+=KyzckKpdTrivQ3N-w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: samsung-s6d7aa0: use pointer for drm_mode in
 panel desc struct
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, thierry.reding@gmail.com,
        David Airlie <airlied@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>,
        Daniel Vetter <daniel@ffwll.ch>, Tom Rix <trix@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Tue, May 23, 2023 at 2:20=E2=80=AFPM Artur Weber <aweber.kernel@gmail.co=
m> wrote:
>
> Fixes compilation errors on older GCC versions (before 8.x) and Clang
> after changes introduced in commit 6810bb390282 ("drm/panel: Add
> Samsung S6D7AA0 panel controller driver"). Tested with GCC 13.1.1,
> GCC 6.4.0 and Clang 16.0.3.

Hi Artur,
Thanks for the patch! Mind sending a v2 with the diagnostic added to
the commit message? This gives reviewers much more context as to what
issue you are fixing.

>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/=
drm/panel/panel-samsung-s6d7aa0.c
> index f532aa018428..102e1fc7ee38 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -37,7 +37,7 @@ struct s6d7aa0_panel_desc {
>         unsigned int panel_type;
>         int (*init_func)(struct s6d7aa0 *ctx);
>         int (*off_func)(struct s6d7aa0 *ctx);
> -       const struct drm_display_mode drm_mode;
> +       const struct drm_display_mode *drm_mode;
>         unsigned long mode_flags;
>         u32 bus_flags;
>         bool has_backlight;
> @@ -309,7 +309,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080=
al02_desc =3D {
>         .panel_type =3D S6D7AA0_PANEL_LSL080AL02,
>         .init_func =3D s6d7aa0_lsl080al02_init,
>         .off_func =3D s6d7aa0_lsl080al02_off,
> -       .drm_mode =3D s6d7aa0_lsl080al02_mode,
> +       .drm_mode =3D &s6d7aa0_lsl080al02_mode,
>         .mode_flags =3D MIPI_DSI_MODE_VSYNC_FLUSH | MIPI_DSI_MODE_VIDEO_N=
O_HFP,
>         .bus_flags =3D DRM_BUS_FLAG_DE_HIGH,
>
> @@ -412,7 +412,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080=
al03_desc =3D {
>         .panel_type =3D S6D7AA0_PANEL_LSL080AL03,
>         .init_func =3D s6d7aa0_lsl080al03_init,
>         .off_func =3D s6d7aa0_lsl080al03_off,
> -       .drm_mode =3D s6d7aa0_lsl080al03_mode,
> +       .drm_mode =3D &s6d7aa0_lsl080al03_mode,
>         .mode_flags =3D MIPI_DSI_MODE_NO_EOT_PACKET,
>         .bus_flags =3D 0,
>
> @@ -440,7 +440,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_ltl101=
at01_desc =3D {
>         .panel_type =3D S6D7AA0_PANEL_LTL101AT01,
>         .init_func =3D s6d7aa0_lsl080al03_init, /* Similar init to LSL080=
AL03 */
>         .off_func =3D s6d7aa0_lsl080al03_off,
> -       .drm_mode =3D s6d7aa0_ltl101at01_mode,
> +       .drm_mode =3D &s6d7aa0_ltl101at01_mode,
>         .mode_flags =3D MIPI_DSI_MODE_NO_EOT_PACKET,
>         .bus_flags =3D 0,
>
> @@ -458,7 +458,7 @@ static int s6d7aa0_get_modes(struct drm_panel *panel,
>         if (!ctx)
>                 return -EINVAL;
>
> -       mode =3D drm_mode_duplicate(connector->dev, &ctx->desc->drm_mode)=
;
> +       mode =3D drm_mode_duplicate(connector->dev, ctx->desc->drm_mode);
>         if (!mode)
>                 return -ENOMEM;
>
>
> base-commit: 37cee4876a45a5c3da79a83d34ed4f3c68548aef
> --
> 2.40.1
>


--=20
Thanks,
~Nick Desaulniers
