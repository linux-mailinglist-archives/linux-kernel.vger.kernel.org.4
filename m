Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4716F6AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEDMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEDMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:00:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425CB6188
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:00:21 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643990c5319so19355b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683201621; x=1685793621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyXif4sCtHvoN5uI5jyPj3Z5NBr5S8ivL+oLwWNb3rg=;
        b=f5GVgLtQqOiovcWwoZPI+yiTb7UcRkGusHC/AMfo1LJYOXrnLlIrhjZ6oEjU9QxJmt
         DwsdrOdUGf6ddzyxiBZItfwQokSfb+CEmrJ+3J3rB+8TH4gB58ddqnPZqVqdfBdNuh/M
         hbrBB89EuGX4Ffv7Y4BBViMl44W298gSC7c4LCxEime69AVP16mtiDk/UbsQzDpKbM5g
         J4VBTwV00WxmQog5AvZdlq5OeoDrka2AhiJ2kt54yMycTG4RlHQOI+LWjuGo7ksISWbP
         gSltMvNmuGnUI91ZsxH5izfGiwR1xFhxtnYoAiT5GUkMKupcjLVXbSCyha1bsKqBCmwW
         hUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683201621; x=1685793621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyXif4sCtHvoN5uI5jyPj3Z5NBr5S8ivL+oLwWNb3rg=;
        b=KlyV/i5dORLqCXgSnLCcaKYAM/vZgVlolA2tIT6hEbTBLNUiptJYiNp34RYaT+7ZIj
         Id7wB4S3euDzPer5VtECqJ31KqLdTje8X3saOzLUP0h4YFeYEIbBoi6bno89cYHxUHMw
         Sc6ac7+MIylZ744ojxtVsbW87mSHpZsOtyXHBAuqas5C7yqPeDs/RGwxffM4HjJxbZbF
         0S+BB123NtAiDM44+QR5p/UaM6aABGU7MSRiXFKOcA4fP1i0AdOsInF0tGBTAz3ZG3fr
         SBXpG76opfPZvjtYJoQORKD7N00XDh8Z4ShTwM8H4C8R+rqwrV3+GkeiGzFAMXxC/VVt
         hJSA==
X-Gm-Message-State: AC+VfDxy4YguCLeamkDvXie4fga3/ftfC4fFN0+eykertexudguwtidZ
        dcTV/NyuLfvodw/CoiumvHdz/5WwKnN5VF7WHYIYrJlq
X-Google-Smtp-Source: ACHHUZ4zmxrnrJ7nTQLL/tZMBkjpJRFnRzCfUvzZOGNrKids1H1zwqdvrvPVhgjMU5zX8H8xhA9SXNBC+ghaJWP7gBE=
X-Received: by 2002:a17:902:70cb:b0:1a6:4016:8974 with SMTP id
 l11-20020a17090270cb00b001a640168974mr2971499plt.31.1683201620554; Thu, 04
 May 2023 05:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230502010759.17282-1-aford173@gmail.com> <20230502010759.17282-4-aford173@gmail.com>
 <7519081.EvYhyI6sBW@steina-w>
In-Reply-To: <7519081.EvYhyI6sBW@steina-w>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 4 May 2023 07:00:08 -0500
Message-ID: <CAHCN7x+7YWyvy+cDXcD2D5twJt_Ys6tP+TsLgjH4TgcORW0LPA@mail.gmail.com>
Subject: Re: [PATCH V3 3/7] drm: bridge: samsung-dsim: Fetch
 pll-clock-frequency automatically
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     dri-devel@lists.freedesktop.org, marex@denx.de,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 4:21=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Am Dienstag, 2. Mai 2023, 03:07:55 CEST schrieb Adam Ford:
> > Make the pll-clock-frequency optional.  If it's present, use it
> > to maintain backwards compatibility with existing hardware.  If it
> > is absent, read clock rate of "sclk_mipi" to determine the rate.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> > b/drivers/gpu/drm/bridge/samsung-dsim.c index bf4b33d2de76..2dc02a9e37c=
0
> > 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -1726,12 +1726,20 @@ static int samsung_dsim_parse_dt(struct samsung=
_dsim
> > *dsi) {
> >       struct device *dev =3D dsi->dev;
> >       struct device_node *node =3D dev->of_node;
> > +     struct clk *pll_clk;
> >       int ret;
> >
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequen=
cy",
> >                                      &dsi->pll_clk_rate);
> > -     if (ret < 0)
> > -             return ret;
> > +
> > +     /* If it doesn't exist, read it from the clock instead of failing=
 */
> > +     if (ret < 0) {
> > +             pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> > +             if (!IS_ERR(pll_clk))
> > +                     dsi->pll_clk_rate =3D clk_get_rate(pll_clk);
> > +             else
> > +                     return PTR_ERR(pll_clk);
> > +     }
> >
>
> Now that 'samsung,pll-clock-frequency' is optional the error in
> samsung_dsim_of_read_u32() should be changed. Otherwise you will get
> > /soc@0/bus@32c00000/dsi@32e10000: failed to get 'samsung,pll-clock-
> frequency' property

I'll change the message from err to info with a message that reads "no
samsung,pll-clock-frequency, using pixel clock"

Does that work?

adam
>
> Best regards,
> Alexander
>
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-
> frequency",
> >                                      &dsi->burst_clk_rate);
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>
