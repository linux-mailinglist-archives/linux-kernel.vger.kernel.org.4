Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048C36B755A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCMLIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCMLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:08:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857A3644C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:08:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id p6so6679122pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678705698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMfIcPw24eAIaxANk5dvKrsQWn+L+1o2hPI8u1Bd4r8=;
        b=g/GAPic/XSvU4iEU3zMBU9tlU+p851NwZqiXr0aa35i3EXQ5/btu8wqfRCPqwbY7Wt
         /p5FSgAWZ+ZyETwbSNXR+ZgBZLI+/ay7auCL1GkmD6CkTlCQ4sbS7bzea9N+0OEG35BE
         YLfjSO7RIrRiWFm4wIfFcmdH/b1mrVNxfAJoo79UbSfbV3ZAWMron8M/7JrmnVOEUFCf
         oZ5IHv1CSW6TZ2Zw97nFfLp0p8b6ptVxPBnl/0/XddXKoEXte7B2vXqMxERN7Ih4cuC5
         WnFFha8hepJTnT9HK4X6bZwuxPzO6E8lOGrzcE3Fy5cb8PPDbC5FylQWnSvxpuDVesME
         RE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMfIcPw24eAIaxANk5dvKrsQWn+L+1o2hPI8u1Bd4r8=;
        b=KLr99/wusCkO616YwuyofkRathpkjtKtgdAX5PLnE8z6Eb3JIx8EK64DKxz8TQ5nRm
         G24dUo5AMJPZvXvOxKZHsAtKQadZ2ZlWFD4EJa0vgERO+7DzoxKOxzvzEZMy2ToU65k+
         ezy2JQ/qZXtRcxhXLiqxC4thQnQq3JUF+GRxi8qgKd7WeOZ9qItFB7BzghgetdmBdVId
         OpR5PDR2g1tOxHJypGAoYliw27PJGayF3U72/dEHQvWG3nqRH2Q6pJxH3J4BNSzhNPEw
         yTy6GWJ+rkSr0xEiRizIYrWZPHVVfsyqyWf9sZPjV8SfY8csbgi9KrM0vQlLQ9NAwmjH
         ffZw==
X-Gm-Message-State: AO0yUKXrU8M4Rvc02eXLAOQtXkMd7OjsBStY2Lk/7HxlFgICFexKhDex
        7/bocSlvJ3fMacC65N1J76Gbv+Lqa9X3adzSKdw=
X-Google-Smtp-Source: AK7set+C5h1Ucyyg+GQdjN8ADb5vMD5w5MLyG6dEw/6w1G4peIVgYoOZrBrp2x73DcS+x3tIyRUnfx6w9p+4IWr/h70=
X-Received: by 2002:a62:79c4:0:b0:622:65eb:f6bd with SMTP id
 u187-20020a6279c4000000b0062265ebf6bdmr2191781pfc.2.1678705697790; Mon, 13
 Mar 2023 04:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJXMmwYqD=Eb2=_vJw390KAd6NgkWCpq6yCbAyaJ3xK5A@mail.gmail.com>
 <20230313085105.GB7446@pengutronix.de>
In-Reply-To: <20230313085105.GB7446@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 13 Mar 2023 06:08:05 -0500
Message-ID: <CAHCN7xJxBrN5aQgvkV8LrqoTATinr0kFYKht2_YKqTF71UCoKw@mail.gmail.com>
Subject: Re: MXSFB and Video PLL clock on i.MX8M Mini/Nano Question
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
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

On Mon, Mar 13, 2023 at 3:51=E2=80=AFAM Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
>
> On Sun, Mar 12, 2023 at 02:28:45PM -0500, Adam Ford wrote:
> > I am trying to work through a series that was submitted for enabling
> > the DSI on the i.MX8M Mini and Nano.  I have extended this series to
> > route the DSI to an HDMI bridge, and I am able to get several
> > resolutions to properly sync on my monitor.  However, there are also a
> >  bunch that appear on the list when I run modetest that do not sync on
> > my monitor.
> >
> > When running some debug code, it appears that it's related to the
> > clocking of the MXSFB driver.
> >
> > From what I can tell, the MSXFB driver attempts to set the clock based
> > on the desired resolution and refresh rate.  When the default
> > VIDEO_PLL clock is set to 594MHz, many of the resolutions that cleanly
> > divide from the 594MHz clock appear to sync with my monitor.  However,
> > in order to get other resolutions to appear, I have to manually change
> > the device tree to set VIDEO_PLL to a different clock rate so MSXFB
> > can use it.  Unfortunately, that breaks the resolutions that used to
> > work.
> >
> > I threw together a hack into the MXSFB driver which adds a new
> > optional clock to the MSXFB driver.  When I pass VIDEO_PLL to this
> > driver, it can automatically set the clock rate to match that of
> > whatever the desired clock is, and I can get many more resolutions to
> > appear.
> > Another advantage of this is that the Video_PLL can be the minimum
> > speed needed for a given rate instead of setting a higher rate, then
> > dividing it down.
>
> Isn't it possible to add the CLK_SET_RATE_PARENT flag to the pixel
> clock? That's what i.MX6sx and i.MX7 do.

I thought about that, but on the Nano, the video_pll is several layers up.

video_pll -> video_pll_bypass -> disp_pixel -> disp_pixel_clk

Do I just set that flag for each of these?

adam
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
