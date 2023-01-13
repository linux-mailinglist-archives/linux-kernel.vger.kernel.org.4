Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46546669E31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAMQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAMQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:33:06 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22714D4BA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:27:46 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id w72so10414213vkw.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8K/16wcw70g3853WB4bevqY45r4f6kMjEA+IYsdkDYY=;
        b=iGJOEt8ndx9S9t9mnzB3G2gCDTZNO1tXjhSiYvNzozMtXH/KeS6K3xEXo5Y6n0LSQX
         2DgR8VBGHq7ZsloVs/sKaMKxiV47xE+PoyL/ffZ7zoLPkxjS1jtUnmXpP0y77WI70/BE
         U0s4dok1NhO5F1VBQRZihTY4nyT8PWMql/zNhM2pn4KpbDp/bhbLnvK9Wjz7vDHpOrXZ
         VABz8C5bMhkhhqnjRJzkB4jM3Bnyrk7yQvmMk/ONbBKBeTD7PIK/5k20wP4QvD85qcwo
         TgpuxLsEmJz0xnSwPWEu9i9KLHVC+1fR1yiLWyURT6iwhMqj4wwwsYuySwyG6Z+rwUVc
         A/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K/16wcw70g3853WB4bevqY45r4f6kMjEA+IYsdkDYY=;
        b=kfIwSihRICowOMIkvpSYTMTLla9aCI4Muu2YFnUsxh37yosGEjWjw6UIuQ+MjmrBNy
         X7M86w3FFI82sZ8k6DVB801rxIblXbqmEpKN/PvpwMu1s5LAmJn9OUmt4Ex4JmxtZW6c
         NY7kndJAjfiJi/qRDuHpJGeovGrr6MXSRphiU7+Bf8NKtMv47MZ6XnLGj3SNsKKLL+C+
         TCa2SY8g5+0tnIMueEaSXivY4QCIUPHU1NDs5+NbEMycpZr6kevCdNgvD4aiavVE/tQU
         r8VXemVin89Z2Hq6cMplEHHJbpITybmayjZI6HoMYzi0i2HNAfZPiPN+fYJ0Q2XXC9q5
         jxiA==
X-Gm-Message-State: AFqh2kpHHjrxo/XvDr1izyFP5kmN88rZ/S0dQ3Wj1uUYBp+leI8PNFG8
        BA/vfJxXpEFlcaO1u8cycKDRTP4FLnsBPDpQj8cE/Q==
X-Google-Smtp-Source: AMrXdXted3g6f9FMBDZMKLKDidfaUBO0lwDfRqcINCLqTHIg2JU6SKu+UJRIODTJ9PYp+yhkkqL1z4wgduGpqrneqV0=
X-Received: by 2002:a1f:1243:0:b0:3da:e97f:4dd7 with SMTP id
 64-20020a1f1243000000b003dae97f4dd7mr1741706vks.36.1673627265794; Fri, 13 Jan
 2023 08:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20230106030108.2542081-1-swboyd@chromium.org>
In-Reply-To: <20230106030108.2542081-1-swboyd@chromium.org>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 13 Jan 2023 16:27:29 +0000
Message-ID: <CAPY8ntA=Dq6GFQ3gEOm9PzPyOa9bHTr8JrpXLibnai7xKqRbpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed
 during disable
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@lists.linux.dev, linux-mediatek@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

On Fri, 6 Jan 2023 at 03:01, Stephen Boyd <swboyd@chromium.org> wrote:
>
> The unprepare sequence has started to fail after moving to panel bridge
> code in the msm drm driver (commit 007ac0262b0d ("drm/msm/dsi: switch to
> DRM_PANEL_BRIDGE")). You'll see messages like this in the kernel logs:
>
>    panel-boe-tv101wum-nl6 ae94000.dsi.0: failed to set panel off: -22
>
> This is because boe_panel_enter_sleep_mode() needs an operating DSI link
> to set the panel into sleep mode. Performing those writes in the
> unprepare phase of bridge ops is too late, because the link has already
> been torn down by the DSI controller in post_disable, i.e. the PHY has
> been disabled, etc. See dsi_mgr_bridge_post_disable() for more details
> on the DSI .
>
> Split the unprepare function into a disable part and an unprepare part.
> For now, just the DSI writes to enter sleep mode are put in the disable
> function. This fixes the panel off routine and keeps the panel happy.

It is documented that the mipi_dsi_host_ops transfer function should
be called with the host in any state [1], so the host driver is
failing there.

This sounds like the same issue I was addressing in adding the
prepare_prev_first flag to drm_panel, and pre_enable_prev_first to
drm_bridge via [2].
Defining prepare_prev_first for your panel would result in the host
pre_enable being called before the panel prepare, and therefore the
transfer calls from boe_panel_init_dcs_cmd boe_panel_prepare won't be
relying on the DSI host powering up early. It will also call the panel
unprepare before the DSI host bridge post_disable is called, and
therefore the DSI host will still be powered up and the transfer won't
fail.

Actually I've just noted the comment at [3]. [2] is that framework fix
that means that the magic workaround isn't required, but it will
require this panel to opt in to the ordering change.

Cheers.
  Dave

[1] https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#c.mipi_dsi_host_ops
[2] https://patchwork.freedesktop.org/series/100252/
[3] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/msm/dsi/dsi_manager.c#L47

> My Wormdingler has an integrated touchscreen that stops responding to
> touch if the panel is only half disabled too. This patch fixes it. And
> finally, this saves power when the screen is off because without this
> fix the regulators for the panel are left enabled when nothing is being
> displayed on the screen.
>
> Fixes: 007ac0262b0d ("drm/msm/dsi: switch to DRM_PANEL_BRIDGE")
> Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
> Cc: yangcong <yangcong5@huaqin.corp-partner.google.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 857a2f0420d7..c924f1124ebc 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1193,14 +1193,11 @@ static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
>         return 0;
>  }
>
> -static int boe_panel_unprepare(struct drm_panel *panel)
> +static int boe_panel_disable(struct drm_panel *panel)
>  {
>         struct boe_panel *boe = to_boe_panel(panel);
>         int ret;
>
> -       if (!boe->prepared)
> -               return 0;
> -
>         ret = boe_panel_enter_sleep_mode(boe);
>         if (ret < 0) {
>                 dev_err(panel->dev, "failed to set panel off: %d\n", ret);
> @@ -1209,6 +1206,16 @@ static int boe_panel_unprepare(struct drm_panel *panel)
>
>         msleep(150);
>
> +       return 0;
> +}
> +
> +static int boe_panel_unprepare(struct drm_panel *panel)
> +{
> +       struct boe_panel *boe = to_boe_panel(panel);
> +
> +       if (!boe->prepared)
> +               return 0;
> +
>         if (boe->desc->discharge_on_disable) {
>                 regulator_disable(boe->avee);
>                 regulator_disable(boe->avdd);
> @@ -1528,6 +1535,7 @@ static enum drm_panel_orientation boe_panel_get_orientation(struct drm_panel *pa
>  }
>
>  static const struct drm_panel_funcs boe_panel_funcs = {
> +       .disable = boe_panel_disable,
>         .unprepare = boe_panel_unprepare,
>         .prepare = boe_panel_prepare,
>         .enable = boe_panel_enable,
>
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> --
> https://chromeos.dev
>
