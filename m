Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9C672A97
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjARVe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjARVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:34:27 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE564D96
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:34:25 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id j185so127736vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVS/NpDaaL5u1HrOH58OmL5iaK3Ar8XB2wiyBVMcnhM=;
        b=lOBqJ+xmUB4+8ymAKDe/h/gitreW9zu3XVQVPwxBGccDmm35qm0ekH8pIVbQ/SSCY2
         599IakA7d7M/OrTGZk63miTsWCEMTVWvjpzkQkss8MvBjGQF0yKDz12O7uLkr2gOQn2m
         jAkZaqXlsGpbuQW6IMFzx90912tCY0IQvncT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVS/NpDaaL5u1HrOH58OmL5iaK3Ar8XB2wiyBVMcnhM=;
        b=mOAWvYVbQscPaQslN+XEAGnHspzRjrbOdgBlR6ihnUXMQpz2ncA2xFGkL+T7CnMbHT
         7EhScHbricoXk6YVc6lS13almOFv0/xt/3YDycFNOQF2Jah3AZidWziPH8H9a0mj4AGJ
         a6H9ZlQF02lwD8DMJtbCbqvHAte2XW9oYHtA+OBqaUU3PR2sxpNGKQ3Zhm529n7jTIuN
         KmLWR1M9u5W8F1vuRmngKu+Y74W3HxfvzfZtUYIOoLMM8yRXBVxt9EE6i9kV/ryTeU+M
         IudFrOwz6DkdqfWpjSHU+1KRquH2fuUg8pqr0nNtTe9xb0JpqrqBgiFrExtho9QP5LuM
         j9xA==
X-Gm-Message-State: AFqh2krzZDe2YcIctIj57SGXuKeMfFo7yVdkZ923xvKOCe5r38FL2D5z
        ooBNB0tSorc1lHVHGJnNRg0bWOCDFNBoeEuF
X-Google-Smtp-Source: AMrXdXvAsiCqTi9NlPong/IL1UXXR3p3RTQWEVvBqB5HPqT6WQ2FFI16uO4YjrUtrtkizm3bmqIWUw==
X-Received: by 2002:a05:6102:a32:b0:3c7:e44d:594f with SMTP id 18-20020a0561020a3200b003c7e44d594fmr17300752vsb.9.1674077664035;
        Wed, 18 Jan 2023 13:34:24 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id x22-20020ab035d6000000b006102b9ac9adsm725972uat.30.2023.01.18.13.34.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:34:20 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id k4so176199vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:34:19 -0800 (PST)
X-Received: by 2002:a67:e109:0:b0:3d0:dcbb:2004 with SMTP id
 d9-20020a67e109000000b003d0dcbb2004mr1126577vsl.43.1674077659353; Wed, 18 Jan
 2023 13:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20230106030108.2542081-1-swboyd@chromium.org>
In-Reply-To: <20230106030108.2542081-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 18 Jan 2023 13:34:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0Bwx4HzCSL8EE-+ngGLZ-NqpbC+J9jby84FKBOB_ddQ@mail.gmail.com>
Message-ID: <CAD=FV=U0Bwx4HzCSL8EE-+ngGLZ-NqpbC+J9jby84FKBOB_ddQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed
 during disable
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 5, 2023 at 7:01 PM Stephen Boyd <swboyd@chromium.org> wrote:
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
>
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

As mentioned by Stephen, my initial reaction was that this felt
asymmetric. We were moving some stuff from unprepare() to disable()
and it felt like that would mean we would also need to move something
from prepare() to enable. Initially I thought maybe that "something"
was all of boe_panel_init_dcs_cmd() but I guess that didn't work.

I don't truly have a reason that this _has_ to be symmetric. I was
initially worried that there might be some place where we call
pre_enable(), then never call enable() / disable(), and then call
post_disable(). That could have us in a bad state because we'd never
enter sleep mode / turn the display off. However (as I think I've
discovered before and just forgot), I don't think this is possible
because we always call pre-enable() and enable() together. Also, as
mentioned by Sam, we're about to fully shut the panel's power off so
(unless it's on a shared rail) it probably doesn't really matter.

Thus, I'd be OK with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'm also happy to land this (adding Cc: stable) to drm-misc-fixes if
nobody has any objections (also happy if someone else wants to land
it). I guess the one worry I have is that somehow this could break
something for one of the other 8 panels that this driver supports (or
it could have bad interactions with the display controller used on a
board with one of these panels?). Maybe we should have "Cc: stable"
off just to give it extra bake time? ...and maybe even push to
drm-misc-next instead of -fixes again to give extra bake time?


In any case, I still wanted to look closer. I'll repeat my constant
refrain that I'm no expert here, so call me out if I say anything too
stupid.

As far as I can tell, boe_panel_enter_sleep_mode() does a bunch of
things that have no true opposite in the driver. Let me paste it here
for reference since Stephen's patch didn't touch it:

> static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
> {
>     struct mipi_dsi_device *dsi = boe->dsi;
>     int ret;
>
>     dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;

The above line is particularly concerning. Since there's no opposite
anywhere, I'm going to assume that the panels in this file that use
"LPM" end up not using LPM after the first suspend/resume cycle.
Almost all other panel drivers that clear this flag only do so
temporarily. Seems like maybe this was an oversight in the initial
commit a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga
dsi video mode panel")? Nothing new, but maybe we should fix it?


>     ret = mipi_dsi_dcs_set_display_off(dsi);
>     if (ret < 0)
>         return ret;
>
>     ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
>     if (ret < 0)
>         return ret;

The first of these two (set_display_off) seems quite safe and matches
well with the concept of "disable". We're basically blacking the
screen, I imagine. I then wondered: where do we turn the display on?
It seems like there should be a call to mipi_dsi_dcs_set_display_on(),
right?

Digging a little, there actually is, at least for 3 of the 9 panels
that this driver supports. It's hidden in the giant blob of "DCS"
commands. Specifically, this magic sequence:

_INIT_DELAY_CMD(...),
_INIT_DCS_CMD(0x11),
_INIT_DELAY_CMD(...),
_INIT_DCS_CMD(0x29),
_INIT_DELAY_CMD(...),

The 0x11 there is mipi_dsi_dcs_exit_sleep_mode() and the 0x29 there is
mipi_dsi_dcs_set_display_on()

Now, I'd have to ask why the other 6 of 9 panels _don't_ have those
commands and how the display gets turned on / pulled out of sleep
mode. Maybe they just come up that way? It does feel likely that we
could probably:

a) Parameterize the delays

b) Remove the hardcoded 0x11 and 0x29 from the dcs command blob and
add calls to mipi_dsi_dcs_exit_sleep_mode() /
mipi_dsi_dcs_set_display_on()

c) At least add the mipi_dsi_dcs_set_display_on() to the "enable" call
and then see if mipi_dsi_dcs_exit_sleep_mode() worked in enable() or
if that was important to keep in prepare().

Even if we eventually are able to revert Stephen's patch once we have
the power sequence ordering series, it still might be nice to make the
enable/exit of sleep mode explicit instead of hidden in the DCS
command blob.

-Doug
