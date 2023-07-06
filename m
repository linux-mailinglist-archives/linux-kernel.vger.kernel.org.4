Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6B74A5BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGFVMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGFVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:11:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696751BF8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:11:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so1655112a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688677909; x=1691269909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGO8LXPFOC05OH1b6bVd+tBSMQRMmrpbZNvLLPxoXdU=;
        b=S1xJ95eVwYQ6Y4rDN/Ilt/q81mxarIljoLh1JFx09oZ+ZMpd/PRh4iE5YWcHbA4PAS
         IaoYSsnPSenvSw/9nGdM1aEEkJWlFgmuVnsrvxqS/89Y+uGz8kQwW+Dh2hE0jtZRoEgG
         /D6W8j/9nU5FGC7uR8gkS799jKCyCh/uxeuxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688677909; x=1691269909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGO8LXPFOC05OH1b6bVd+tBSMQRMmrpbZNvLLPxoXdU=;
        b=AleC9GxvkL5wnV8zWu/Ai8QFZxOkFXNZe5wBHJTDONpQSPWskBoRkFnnwdugMP9CT2
         oFqu/hgbLSGqVfykV454uOFfmZ7G3yyb0tBHG/MIyB4gpCBTzJE624o8kXBZPI6107JF
         i+L4jP1ATftt0YC3h2XosvN57vhp3ACMFSy7nH427+I7+IPWc5UMOS4UOe9BIC43rSMz
         v2xIhMcr6HDjY9GH3DerB3Fu7iHyj+9kqIuC7MZ2Pk/IsgRxsWaoriV5slv69SDEmSnn
         QeT9/zZlWTigy9p9fveeoltKjVraMCg9apN5hrP2e4UjcFO1NCiZkGbc0iGAbMrZPPzm
         zDvA==
X-Gm-Message-State: ABy/qLYbxjz9GPmfpjrMJj2/dxSKVooZAOaXt+mdZXYC5V+8tkxGU4IW
        zw9jwog4PlSwDPmA7A8ybG/2H42fr4jpHjheS1uHXwFj
X-Google-Smtp-Source: APBJJlFuvYOBOtjGsE9ezIr9R6019hoYb3TwOSnWAwsEXXXrbF38SomANBLhdcc6SDon9okO482lDQ==
X-Received: by 2002:aa7:db48:0:b0:514:a4cd:85d7 with SMTP id n8-20020aa7db48000000b00514a4cd85d7mr2386895edt.26.1688677908842;
        Thu, 06 Jul 2023 14:11:48 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7d058000000b0051df583ca96sm1179481edo.43.2023.07.06.14.11.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 14:11:48 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so3133a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:11:48 -0700 (PDT)
X-Received: by 2002:a50:f608:0:b0:514:95d4:c2bb with SMTP id
 c8-20020a50f608000000b0051495d4c2bbmr24630edn.2.1688677907801; Thu, 06 Jul
 2023 14:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org> <20230703-fix-boe-tv101wum-nl6-v3-1-bd6e9432c755@linaro.org>
In-Reply-To: <20230703-fix-boe-tv101wum-nl6-v3-1-bd6e9432c755@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jul 2023 14:11:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wju3WS45=EpXMUg7FjYDh3-=mvm_jS7TF1tsaAzbb4Uw@mail.gmail.com>
Message-ID: <CAD=FV=Wju3WS45=EpXMUg7FjYDh3-=mvm_jS7TF1tsaAzbb4Uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/panel: boe-tv101wum-nl6: Drop macros and open
 code sequences
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 3, 2023 at 6:22=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> The boe-tv101wum-nl6 is reinventing the mechanism to send command
> sequences that we usually nix during review, but I missed this one
> so fixing it up myself.

Sorry for this. :( I know I've reviewed/applied several of the patches
that made this worse, but I believe that the whole array/sequence
scheme predated my involvement in the driver. I've never been a huge
fan of these black box sequences and try to make it a point to grumble
about them each time through the review, though again their use
predated my involvement...


> Also use the explicit function calls to mipi_dsi_dcs_exit_sleep_mode()
> and mipi_dsi_dcs_set_display_on() instead of reimplementing them
> with homegrown sequences.

Yeah, this is nice, thanks!


> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Convert the two newly added Starry displays as well.
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 3351 ++++++++++++------=
------
>  1 file changed, 1654 insertions(+), 1697 deletions(-)

I'm at least moderately curious if you did size comparisons in the
resulting binary before and after. Given that mipi_dsi_dcs_write_seq()
is currently implemented as a macro this seems like it has the
potential of massively exploding the size of the compiled object size.
Even if it wasn't a macro, I'd wonder if the compiler is really smart
enough to generate code that's as good for these long sequences. The
call sequences for several hundred function calls could be enough
overhead to justify adding a function to the core that handles an
array of sequences. Would that be a good compromise? Add to the core
handling of a sequence of sequences but don't add the extra special
case for delays (each time you need a delay you need to start a new
sequence of sequences).

Aside from the potential binary size bloat, I guess this also has the
downside of not considering it a true error if one of these init steps
fails for some reason. The new code will just spit out a ratelimited
error and continue trying to init whereas the old code would have
stopped immediately. The new way is probably OK, but the difference in
behavior should be noted in the commit message in case this is causing
problems for anyone.


> +static int inx_hj110iz_init(struct mipi_dsi_device *dsi)
> +{
> +       int ret;
>
> -static const struct panel_init_cmd auo_kd101n80_45na_init_cmd[] =3D {
> -       _INIT_DELAY_CMD(24),
> -       _INIT_DCS_CMD(0x11),
> -       _INIT_DELAY_CMD(120),
> -       _INIT_DCS_CMD(0x29),
> -       _INIT_DELAY_CMD(120),
> -       {},
> -};
> +       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x20);
> +       mipi_dsi_dcs_write_seq(dsi, 0xFB, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0x05, 0xD1);

The sequence of init commands for inx_hj110iz_init() is quite
different before and after your patch. The first such difference is
right here. The old code used to have "0x06, 0xC0" right after the
"0x05, 0xD1"

Is this on purpose? If so, can you please move that change to a
separate patch and have this patch be _just_ a no-op.


> +static int boe_init(struct mipi_dsi_device *dsi)
> +{
> +       msleep(24);

Where did the msleep(24) come from? It wasn't there before your patch,
right? Please make this patch a no-op and add the 24ms sleep in a
separate patch if it's needed.


> +static int starry_qfh032011_53g_init(struct mipi_dsi_device *dsi)
>  {
> -       struct mipi_dsi_device *dsi =3D boe->dsi;
> -       struct drm_panel *panel =3D &boe->base;
> -       int i, err =3D 0;
> -
> -       if (boe->desc->init_cmds) {
> -               const struct panel_init_cmd *init_cmds =3D boe->desc->ini=
t_cmds;
> -
> -               for (i =3D 0; init_cmds[i].len !=3D 0; i++) {
> -                       const struct panel_init_cmd *cmd =3D &init_cmds[i=
];
> -
> -                       switch (cmd->type) {
> -                       case DELAY_CMD:
> -                               msleep(cmd->data[0]);
> -                               err =3D 0;
> -                               break;
> -
> -                       case INIT_DCS_CMD:
> -                               err =3D mipi_dsi_dcs_write(dsi, cmd->data=
[0],
> -                                                        cmd->len <=3D 1 =
? NULL :
> -                                                        &cmd->data[1],
> -                                                        cmd->len - 1);
> -                               break;
> -
> -                       default:
> -                               err =3D -EINVAL;
> -                       }
> -
> -                       if (err < 0) {
> -                               dev_err(panel->dev,
> -                                       "failed to write command %u\n", i=
);
> -                               return err;
> -                       }
> -               }
> -       }
> +       int ret;
> +
> +       mipi_dsi_dcs_write_seq(dsi, 0xB0, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC3, 0x4F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC4, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC5, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC6, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC7, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC8, 0x4D);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC9, 0x52);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCA, 0x51);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCD, 0x5D);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCE, 0x5B);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCF, 0x4B);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD0, 0x49);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD1, 0x47);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD2, 0x45);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD3, 0x41);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD7, 0x50);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD8, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD9, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDA, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDB, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDC, 0x4E);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDD, 0x52);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDE, 0x51);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE1, 0x5E);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE2, 0x5C);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE3, 0x4C);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE4, 0x4A);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE5, 0x48);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE6, 0x46);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE7, 0x42);
> +       mipi_dsi_dcs_write_seq(dsi, 0xB0, 0x03);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBE, 0x03);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCC, 0x44);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC8, 0x07);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC9, 0x05);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCA, 0x42);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCD, 0x3E);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCF, 0x60);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD2, 0x04);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD3, 0x04);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD4, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD5, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD6, 0x03);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD7, 0x04);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD9, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDB, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE4, 0xF0);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE5, 0x0A);
> +       mipi_dsi_dcs_write_seq(dsi, 0xB0, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCC, 0x08);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC2, 0x08);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC4, 0x10);
> +       mipi_dsi_dcs_write_seq(dsi, 0xB0, 0x02);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC0, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC1, 0x0A);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC2, 0x20);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC3, 0x24);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC4, 0x23);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC5, 0x29);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC6, 0x23);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC7, 0x1C);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC8, 0x19);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC9, 0x17);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCA, 0x17);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCB, 0x18);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCC, 0x1A);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCD, 0x1E);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCE, 0x20);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCF, 0x23);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD0, 0x07);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD1, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD2, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD3, 0x0A);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD4, 0x13);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD5, 0x1C);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD6, 0x1A);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD7, 0x13);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD8, 0x17);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD9, 0x1C);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDA, 0x19);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDB, 0x17);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDC, 0x17);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDD, 0x18);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDE, 0x1A);
> +       mipi_dsi_dcs_write_seq(dsi, 0xDF, 0x1E);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE0, 0x20);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE1, 0x23);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE2, 0x07);
> +
> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret)
> +               return ret;
> +       msleep(120);
> +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret)
> +               return ret;
> +       msleep(80);
> +
>         return 0;
>  }
>
> +
> +static int starry_himax83102_j02_init(struct mipi_dsi_device *dsi)

nit: don't need two blank lines between functions. ...and if you do,
for some reason, you should be consistent and have two blank lines
between _all_ of them, not just some.


> +{
> +       int ret;
> +
> +       mipi_dsi_dcs_write_seq(dsi, 0xB9, 0x83, 0x10, 0x21, 0x55, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xB1, 0x2C, 0xB5, 0xB5, 0x31, 0xF1, 0=
x31, 0xD7, 0x2F, 0x36, 0x36,
> +                              0x36, 0x36, 0x1A, 0x8B, 0x11, 0x65, 0x00, =
0x88, 0xFA, 0xFF, 0xFF, 0x8F,
> +                              0xFF, 0x08, 0x74, 0x33);
> +       mipi_dsi_dcs_write_seq(dsi, 0xB2, 0x00, 0x47, 0xB0, 0x80, 0x00, 0=
x12, 0x72, 0x3C, 0xA3, 0x03,
> +                              0x03, 0x00, 0x00, 0x88, 0xF5);
> +       mipi_dsi_dcs_write_seq(dsi, 0xB4, 0x76, 0x76, 0x76, 0x76, 0x76, 0=
x76, 0x63, 0x5C, 0x63, 0x5C,
> +                              0x01, 0x9E);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xCD);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBA, 0x84);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBC, 0x1B, 0x04);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBE, 0x20);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBF, 0xFC, 0xC4);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC0, 0x36, 0x36, 0x22, 0x11, 0x22, 0=
xA0, 0x61, 0x08, 0xF5, 0x03);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xCC);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC7, 0x80);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xC6);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC8, 0x97);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xC9, 0x00, 0x1E, 0x13, 0x88, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCB, 0x08, 0x13, 0x07, 0x00, 0x0F, 0=
x33);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCC, 0x02);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xC4);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD0, 0x03);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD1, 0x37, 0x06, 0x00, 0x02, 0x04, 0=
x0C, 0xFF);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD2, 0x1F, 0x11, 0x1F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD3, 0x06, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x08,
> +                              0x37, 0x47, 0x34, 0x3B, 0x12, 0x12, 0x03, =
0x03, 0x32, 0x10, 0x10,
> +                              0x00, 0x10, 0x32, 0x10, 0x08, 0x00, 0x08, =
0x32, 0x17, 0x94, 0x07,
> +                              0x94, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD5, 0x18, 0x18, 0x18, 0x18, 0x18, 0=
x18, 0x18, 0x18, 0x18,
> +                              0x18, 0x19, 0x19, 0x40, 0x40, 0x1A, 0x1A, =
0x1B, 0x1B, 0x00, 0x01,
> +                              0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x20, =
0x21, 0x28, 0x29, 0x18,
> +                              0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, =
0x18, 0x18, 0x18, 0x18,
> +                              0x18, 0x18);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD6, 0x18, 0x18, 0x18, 0x18, 0x18, 0=
x18, 0x18, 0x18, 0x18,
> +                              0x18, 0x40, 0x40, 0x19, 0x19, 0x1A, 0x1A, =
0x1B, 0x1B, 0x07, 0x06,
> +                              0x05, 0x04, 0x03, 0x02, 0x01, 0x00, 0x29, =
0x28, 0x21, 0x20, 0x18,
> +                              0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, =
0x18, 0x18, 0x18, 0x18,
> +                              0x18, 0x18);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD8, 0xAA, 0xBA, 0xEA, 0xAA, 0xAA, 0=
xA0, 0xAA, 0xBA, 0xEA,
> +                              0xAA, 0xAA, 0xA0, 0xAA, 0xBA, 0xEA, 0xAA, =
0xAA, 0xA0, 0xAA, 0xBA,
> +                              0xEA, 0xAA, 0xAA, 0xA0, 0xAA, 0xBA, 0xEA, =
0xAA, 0xAA, 0xA0, 0xAA,
> +                              0xBA, 0xEA, 0xAA, 0xAA, 0xA0);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE0, 0x00, 0x09, 0x14, 0x1E, 0x26, 0=
x48, 0x61, 0x67, 0x6C,
> +                              0x67, 0x7D, 0x7F, 0x80, 0x8B, 0x87, 0x8F, =
0x98, 0xAB, 0xAB, 0x55,
> +                              0x5C, 0x68, 0x73, 0x00, 0x09, 0x14, 0x1E, =
0x26, 0x48, 0x61, 0x67,
> +                              0x6C, 0x67, 0x7D, 0x7F, 0x80, 0x8B, 0x87, =
0x8F, 0x98, 0xAB, 0xAB,
> +                              0x55, 0x5C, 0x68, 0x73);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE7, 0x0E, 0x10, 0x10, 0x21, 0x2B, 0=
x9A, 0x02, 0x54, 0x9A,
> +                              0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x12, =
0x05, 0x02, 0x02, 0x10);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBD, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0xB1, 0x01, 0xBF, 0x11);
> +       mipi_dsi_dcs_write_seq(dsi, 0xCB, 0x86);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD2, 0x3C, 0xFA);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xC5);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD3, 0x00, 0x00, 0x00, 0x00, 0x80, 0=
x0C, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE7, 0x02, 0x00, 0x28, 0x01, 0x7E, 0=
x0F, 0x7E, 0x10, 0xA0,
> +                              0x00, 0x00, 0x20, 0x40, 0x50, 0x40);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBD, 0x02);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD8, 0xFF, 0xFF, 0xBF, 0xFE, 0xAA, 0=
xA0, 0xFF, 0xFF, 0xBF,
> +                              0xFE, 0xAA, 0xA0);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE7, 0xFE, 0x04, 0xFE, 0x04, 0xFE, 0=
x04, 0x03, 0x03, 0x03,
> +                              0x26, 0x00, 0x26, 0x81, 0x02, 0x40, 0x00, =
0x20, 0x9E, 0x04, 0x03,
> +                              0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, =
0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBD, 0x03);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xC6);
> +       mipi_dsi_dcs_write_seq(dsi, 0xB4, 0x03, 0xFF, 0xF8);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xD8, 0x00, 0x2A, 0xAA, 0xA8, 0x00, 0=
x00, 0x00, 0x2A, 0xAA,
> +                              0xA8, 0x00, 0x00, 0x00, 0x3F, 0xFF, 0xFC, =
0x00, 0x00, 0x00, 0x3F,
> +                              0xFF, 0xFC, 0x00, 0x00, 0x00, 0x2A, 0xAA, =
0xA8, 0x00, 0x00, 0x00,
> +                              0x2A, 0xAA, 0xA8, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBD, 0x00);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xC4);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBA, 0x96);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBD, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xC5);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBA, 0x4F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
> +       mipi_dsi_dcs_write_seq(dsi, 0xBD, 0x00);
> +
> +
> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);

nit: why two blank lines above?


> +       if (ret)
> +               return ret;
> +       msleep(120);
> +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret)
> +               return ret;
> +       msleep(80);

Where did the "msleep(80)" come from? I don't see this in the code
you're replacing. If the "msleep(80)" is needed, please introduce it
in a separate patch.


> +
> +       return 0;
> +};
> +
> +
> +static int starry_ili9882t_init(struct mipi_dsi_device *dsi)

nit: don't need two blank lines between functions


> +{
> +       int ret;
> +
> +       msleep(5);

I know it was doing a msleep(5) before, but I guess it's now more
obvious that (according to the docs) this should be a usleep_range()
or a delay, since delays < 20 ms are documented as not being super
appropriate for msleep(). I guess it doesn't _really_ matter,
though...


-Doug
