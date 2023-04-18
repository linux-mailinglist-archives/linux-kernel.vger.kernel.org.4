Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FCF6E577E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDRCaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDRC36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:29:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57711172C;
        Mon, 17 Apr 2023 19:29:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a524c999d9so15928385ad.3;
        Mon, 17 Apr 2023 19:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681784997; x=1684376997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67tDMZwaozkC/4h2hdsCG2SkbsBh10T01ijQGIySkUo=;
        b=VJarTu7ueI5jKfXJfk+sjPdWWMUCCCD6nLfSLTw6040i2UYSycKSAllI/xAR7zCoYu
         OItvn0Oeemlm5n9LFQCXKTfuy8D8a0KV/HJTU9e5FTaY1m789aYYem58VdwQbzozMGuO
         o6DOc+DXHNLkHxf0SrVu/H9w/aiTxiARFSfOOmT1zNos5os7TTkg2fmWd4aIe8siOduN
         5cIo1HFO6CvnO5qWrKf7sYcZekO9EVXSC3gy7qjeeE0gr8lDbA8mAXZ8fd03elp3hfrL
         aHdZWThvlq6kFwPX927MP9zOSAuNMOusekXfci4qH8FVvoVgT2Bh2CF9FbRVPD+QpIoi
         y8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681784997; x=1684376997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67tDMZwaozkC/4h2hdsCG2SkbsBh10T01ijQGIySkUo=;
        b=CnUPEwNK3ckFB8Yo1Rl7S0xsV8VzlZ7ix1V6ouwCy/yMBajc6vSLJ98QN9j2SD1HM7
         2lAc1i2I18vHpWw5AhKJMIQYpHs6DCQq20m0Lq/o/ZLT8UmQkOqUf89KdXUErOPLwvjk
         bZamHdGC6WWwRor6emclLQQkuWI+GmVxi1OKfpMAjCsy5NXQZbsIncSp/zm7iLcci4s1
         RxxDbcugCQ4HEffjPuPUT7+F/AaCDy0m36aK4MmbMWt8jqesfqRROMUAM7fu+z3+/MC2
         q2YJ8LSXyZhU+k2qjuEykhsCYpHSCeFRMTtJJAwKau2s9+PTQgDXp2YG7KIpIFQP0+Uz
         O8gA==
X-Gm-Message-State: AAQBX9eZddxubmXbq7h77gJ6ipGIZ4lq6gHJWbSY+rFv/7GyA2s6ze01
        8scXwAloJNzD+k+JvSa/D403khEV9llThXRgY0c=
X-Google-Smtp-Source: AKy350a8gUiMivOsGNvLuu+CPxSUKtbHvfaXMbOwAEVLwgvkJrDx2eY3Li4L6RzuwTjiYRjvOxHRH6bVfvLtalZZ9bI=
X-Received: by 2002:a17:902:e88e:b0:1a5:25db:5bc0 with SMTP id
 w14-20020a170902e88e00b001a525db5bc0mr217740plg.3.1681784996433; Mon, 17 Apr
 2023 19:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <20230415104104.5537-3-aford173@gmail.com>
 <7eed74e8-9f67-a410-3cec-f61a6db85238@denx.de>
In-Reply-To: <7eed74e8-9f67-a410-3cec-f61a6db85238@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 17 Apr 2023 21:29:44 -0500
Message-ID: <CAHCN7xKw26TQ=t75TEDbEkA0mb9rnEwNW=7ei1=WFBZjiJMf=g@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
To:     Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 5:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/15/23 12:41, Adam Ford wrote:
> > Fetch the clock rate of "sclk_mipi" (or "pll_clk") instead of
> > having an entry in the device tree for samsung,pll-clock-frequency.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >   drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index 9fec32b44e05..73f0c3fbbdf5 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -1744,11 +1744,6 @@ static int samsung_dsim_parse_dt(struct samsung_=
dsim *dsi)
> >       struct device_node *node =3D dev->of_node;
> >       int ret;
> >
> > -     ret =3D samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequen=
cy",
> > -                                    &dsi->pll_clk_rate);
> > -     if (ret < 0)
> > -             return ret;
> > -
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequ=
ency",
> >                                      &dsi->burst_clk_rate);
> >       if (ret < 0)
>
> Does this break compatibility with old samsung DTs ?

My goal here was to declutter the device tree stuff and fetch data
automatically if possible. What if I changed this to make them
optional?  If they exist, we can use them, if they don't exist, we
could read the clock rate.  Would that be acceptable?

adam
