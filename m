Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707DA6E14E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDMTLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:11:11 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB297AB3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:11:10 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54ee0b73e08so303943507b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681413068; x=1684005068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n5rfNu1HowE7oAZejmf2ckXvzQnhKf+e7UaYPPXJgI=;
        b=Ewn2hF1Ptsh4vbimiMWYAv2F0hDUpOXiTczRDUKAd8AjKUmYzu+u7aH/ND1d+M0auW
         ZLPwlEirOObbffnHmnjT320ALvj96WAqEplTUZx6C+kFJFh7xkOMFSrRNw65HcxZmdfl
         VsGTatz/DxjQ6JaGT7ltrfcNJLAupFJvyzOrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681413068; x=1684005068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/n5rfNu1HowE7oAZejmf2ckXvzQnhKf+e7UaYPPXJgI=;
        b=en88l6pE6lerGsEmJllutDQZO00JewBPumIabEhWz/QWRbqXH/adlU/hhY2AOCFwf2
         Ff1CKVV8vwWzAK6xyxlALfhR2dBp2LAFNoq5uoZR0hx7Wr1QwzQPtE2UMR5NReSN8gQ3
         7sRpG1LqiXRj+X+9CNqSa6HIlTeEWGy6PdtYCtqa0H8S67d3HlteFH0Kp0xF6xsn1p6L
         9lzvFLHsG0RZpv4E9XM3j2VAyRNyLSR3QTvxCqe0M1OjLKYLF8AO5ysaUcC8dhx/K2b8
         XqIBKsgcfrXGXgWQ/1h2547+h46RUAtwThcLLhxVsLrBpZuEu4xIYj/dyu+ftPYaVwrJ
         yWQA==
X-Gm-Message-State: AAQBX9e9ivPsfpBsOmQv5CKTXUYYCoWlHycgE4+G2DqpJw0liRiMUGr1
        X7B9sVDIdiPXNugxb3fn3euZyO5zrN/xGAkonIE=
X-Google-Smtp-Source: AKy350aN0CE6Sv6nHjKPTCMG0AOUvGW7bVuQKH91JgbT8A9qZtvpm675xrNU1xjDhKzMXKrK3/Xx3Q==
X-Received: by 2002:a0d:ea4f:0:b0:54f:bc13:202d with SMTP id t76-20020a0dea4f000000b0054fbc13202dmr3218123ywe.28.1681413068352;
        Thu, 13 Apr 2023 12:11:08 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 72-20020a81054b000000b00545a08184edsm655574ywf.125.2023.04.13.12.11.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 12:11:07 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id n203so4779337ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:11:06 -0700 (PDT)
X-Received: by 2002:a25:cc05:0:b0:b8b:eea7:525a with SMTP id
 l5-20020a25cc05000000b00b8beea7525amr1725774ybf.7.1681413066412; Thu, 13 Apr
 2023 12:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230408082014.235425-1-nikita@trvn.ru> <CAD=FV=XEQS9MB4e52B4yLjiP8ksYmeos_emiH4=-adCOwzfGUA@mail.gmail.com>
 <905403377ec62914a2fbe21a6b4a6c8e@trvn.ru>
In-Reply-To: <905403377ec62914a2fbe21a6b4a6c8e@trvn.ru>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Apr 2023 12:10:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_NUNXgY-9p6CUvNwYte+aPjjZPLV4oZRXR5zdEn0Kjg@mail.gmail.com>
Message-ID: <CAD=FV=X_NUNXgY-9p6CUvNwYte+aPjjZPLV4oZRXR5zdEn0Kjg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Implement wait_hpd_asserted
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 12, 2023 at 9:19=E2=80=AFPM Nikita Travkin <nikita@trvn.ru> wro=
te:
>
> Doug Anderson =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 13.04.2023 01:22:
> > Hi,
> >
> > On Sat, Apr 8, 2023 at 1:20=E2=80=AFAM Nikita Travkin <nikita@trvn.ru> =
wrote:
> >>
> >> This bridge doesn't actually implement HPD due to it being way too slo=
w
> >> but instead expects the panel driver to wait enough to assume HPD is
> >> asserted. However some panels (such as the generic 'edp-panel') expect
> >> the bridge to deal with the delay and pass maximum delay to the aux
> >> instead.
> >>
> >> In order to support such panels, add a dummy implementation of wait
> >> that would just sleep the maximum delay and assume no failure has
> >> happened.
> >>
> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> >> ---
> >> This was suggested in [1] to make sure DT users can be semantically
> >> correct (not adding no-hpd when the line is actually there) while
> >> still using a hard delay to be faster than waiting the long debounce
> >> time.
> >>
> >> [1] - https://lore.kernel.org/all/CAD=3DFV=3DVR7sKsquE25eF7joc7gPApu-v=
qwduZzjE=3DwFCoXjMYnQ@mail.gmail.com/
> >> ---
> >>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/b=
ridge/ti-sn65dsi86.c
> >> index 7a748785c545..260cad1fd1da 100644
> >> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> >> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> >> @@ -618,6 +618,24 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_a=
ux *aux,
> >>         return len;
> >>  }
> >>
> >> +static int ti_sn_aux_wait_hpd_asserted(struct drm_dp_aux *aux, unsign=
ed long wait_us)
> >> +{
> >> +       /*
> >> +        * The HPD in this chip is a bit useless (See comment in
> >> +        * ti_sn65dsi86_enable_comms) so if our driver is expected to =
wait
> >> +        * for HPD, we just assume it's asserted after the wait_us del=
ay.
> >> +        *
> >> +        * In case we are asked to wait forever (wait_us=3D0) take con=
servative
> >> +        * 500ms delay.
> >> +        */
> >> +       if (wait_us =3D=3D 0)
> >> +               wait_us =3D 500000;
> >> +
> >> +       usleep_range(wait_us, wait_us + 1000);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static int ti_sn_aux_probe(struct auxiliary_device *adev,
> >>                            const struct auxiliary_device_id *id)
> >>  {
> >> @@ -627,6 +645,7 @@ static int ti_sn_aux_probe(struct auxiliary_device=
 *adev,
> >>         pdata->aux.name =3D "ti-sn65dsi86-aux";
> >>         pdata->aux.dev =3D &adev->dev;
> >>         pdata->aux.transfer =3D ti_sn_aux_transfer;
> >> +       pdata->aux.wait_hpd_asserted =3D ti_sn_aux_wait_hpd_asserted;
> >
> > This looks reasonable to me, but I think you only want this
> > implementation if the "no-hpd" property _isn't_ present. In other
> > words:
> >
> > if (!of_property_read_bool(np, "no-hpd"))
> >   pdata->aux.wait_hpd_asserted =3D ti_sn_aux_wait_hpd_asserted;
> >
> > Essentially:
> >
> > * If "no-hpd" is present in ti-sn65dsi86 then we'll assume that HPD is
> > handled by the panel driver via a GPIO or a "no-hpd" there (which will
> > cause the panel driver to wait the maximum duration).
> >
> > * If "no-hpd" isn't present in ti-sn65dsi86 then HPD is actually
> > hooked up and thus the panel driver _won't_ handle it.
> >
> > Does that seem right? Presumably this should be explained by comments.
> >
>
> This does sound reasonable indeed, I didn't think to add it
> conditionally because, looking at the current users of
> wait_hpd_asserted, they will first try the "no-hpd" paths
> and will only call the bridge when they think it's on the
> bridge to wait.
>
> Thus, if DT is modeled properly - Panel has no-hpd or a gpio,
> wait_hpd_asserted will never be called anyway. Other bridges
> seem to also unconditionally enable the method.
>
> For this to be a trouble, a panel driver has to be "broken"
> with some form of calling wait_hpd_asserted despite knowing
> the HPD line is not hooked up...
>
> So I feel like guarding the wait_hpd_asserted for no-hpd
> users should not actually change much, but if you think
> I should add the check anyway, please let me know.

Ah, true, it shouldn't actually matter. I guess I still like it
slightly better with the extra check but not enough that I'll insist
on it. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I can commit this to drm-misc-next, but I'll plan to wait ~1 week to
see if anyone else has any comments about it.

-Doug
