Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD76FB185
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjEHN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjEHN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:29:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189342BCF0;
        Mon,  8 May 2023 06:29:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aad6f2be8eso42390825ad.3;
        Mon, 08 May 2023 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683552551; x=1686144551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3PaC+u4I8/xCvBzjXljSbT+ExOFEPX4hvoclskNFFw=;
        b=MWzI31C4XaHMcFzzVuAi/60gb6uwvtco6/TBowcdMuXPSg6ouaWHsUC+w3hk0vsXS6
         oPTulJVX1PGaYLCMzcH3+8oB8oL6BeHvikIF2RUuD8i87DyMG4PNHYh6Z2Ue8r+V/LO4
         4+SpbLukuQnI/I/HwQtnPFwDtuQ15FAhlMf2Uwry1bPCxSzZ23nAsjh8ONAQObnmWMZ9
         PYMtxSD454r+qxmt021fSN5+vt7owtGLGVc/NwhGChX6bn9RWyQe6MCrEzPSANGHkeeX
         em9zjjCOXakgtbHs6pbRHIsAlOQ8q974MBE6f7as19Vz+C21I3sbbgtVOo4hoAnCHtHQ
         f9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683552551; x=1686144551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3PaC+u4I8/xCvBzjXljSbT+ExOFEPX4hvoclskNFFw=;
        b=NXQn1n3QVjc9ilpFkgZhS1iMk5wmIsfS2s0nwo1g7iO8ZHXmTquLkiCKL1s+ZqaNHx
         +zFJag+fGjf2HyT7P0FrYV9G8aTvSLQ8RyJBBuL3rKKzw8wgTkFzv57zSBcYMsGlBiI8
         LvzwK3hW6UaQNRv5TJh1lvCgz242b8x9WDzy90P/Jn4H+MBWhsazBxOj6G5GsQ+lGtUf
         OrvRb4pa/KU8UQrj0/liXvJaNp1ntUaSPW3DnMUqtANvfYwYunNF8ZyH58xDkJSVEGZY
         6/oTEtf4tBRQh+3rT2/prEcbZhKuen7+e/q56A+TSUBWu43tAlQp5IBsPGorUzHHx0Nu
         fj6g==
X-Gm-Message-State: AC+VfDzEWlyAZzTJZ/llpri3blYzd4DOMFFkgjWAEUiXzWclnuFPuRvv
        yTy7R/0fw/C8fu8LfCjSzeo=
X-Google-Smtp-Source: ACHHUZ7KAFR45h+/U8HBtUfGhPJcOvkhRnZ3gz7CGtsMf4W1x4+mYkZaOv9TKK1YDMVLKRQ2r39hPw==
X-Received: by 2002:a17:902:8a95:b0:1aa:cddd:57d8 with SMTP id p21-20020a1709028a9500b001aacddd57d8mr9863298plo.30.1683552551322;
        Mon, 08 May 2023 06:29:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v13-20020a170903238d00b001aafdf8063dsm7253193plh.157.2023.05.08.06.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:29:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 May 2023 06:29:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
Message-ID: <7d3b2991-f755-42e5-87ca-727fd8fb9164@roeck-us.net>
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
 <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
 <20221115132811.GA4189373@roeck-us.net>
 <TYWPR01MB87753203F46FA9C744FEF7E6C2069@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <20230507153625.GA3135@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507153625.GA3135@www.linux-watchdog.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 05:36:25PM +0200, Wim Van Sebroeck wrote:
> Hi Fabrizio,
> 
> Based on below e-mail I excluded this patch from the merge window.
> I saw that Guenter still has it in his branch.

Thanks for the note. I'll drop it.

Guenter

> So can we have an update on this please?
> 
> Thanks in advance,
> Wim.
> 
> > Hi Geert and Guenter,
> > 
> > Thank you for your reviews!
> > 
> > As it turns out, the rzg2l_wdt driver has some reset related issues
> > (currently not addressed by the driver) for the RZ/V2M and RZ/Five
> > SoCs. More specifically to this patch, there is a better way to fix
> > the restart callback by addressing the way the reset is handled
> > for the watchdog IP.
> > 
> > I am dropping this patch, and I'll send out a series to address
> > the above concerns (which will tackle the issues with the restart
> > callback in a better way).
> > 
> > 
> > Thanks,
> > Fab
> > 
> > 
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > > Sent: 15 November 2022 13:28
> > > Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
> > > 
> > > On Thu, Nov 03, 2022 at 10:39:54PM +0000, Fabrizio Castro wrote:
> > > > The setting for the RZ/V2M watchdog cannot be changed once
> > > > the watchdog has been enabled, unless the IP gets reset.
> > > > The current implementation of the restart callback assumes
> > > > that the watchdog is not enabled, but that's not always the
> > > > case, and it leads to longer than necessary reboot times if
> > > > the watchdog is already running.
> > > >
> > > > Always reset the RZ/V2M watchdog first, so that we can always
> > > > restart quickly.
> > > >
> > > > Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > 
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > > ---
> > > >  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> > > > index 974a4194a8fd..00438ceed17a 100644
> > > > --- a/drivers/watchdog/rzg2l_wdt.c
> > > > +++ b/drivers/watchdog/rzg2l_wdt.c
> > > > @@ -145,10 +145,10 @@ static int rzg2l_wdt_restart(struct
> > > watchdog_device *wdev,
> > > >  {
> > > >  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
> > > >
> > > > -	clk_prepare_enable(priv->pclk);
> > > > -	clk_prepare_enable(priv->osc_clk);
> > > > -
> > > >  	if (priv->devtype == WDT_RZG2L) {
> > > > +		clk_prepare_enable(priv->pclk);
> > > > +		clk_prepare_enable(priv->osc_clk);
> > > > +
> > > >  		/* Generate Reset (WDTRSTB) Signal on parity error */
> > > >  		rzg2l_wdt_write(priv, 0, PECR);
> > > >
> > > > @@ -157,6 +157,11 @@ static int rzg2l_wdt_restart(struct watchdog_device
> > > *wdev,
> > > >  	} else {
> > > >  		/* RZ/V2M doesn't have parity error registers */
> > > >
> > > > +		reset_control_reset(priv->rstc);
> > > > +
> > > > +		clk_prepare_enable(priv->pclk);
> > > > +		clk_prepare_enable(priv->osc_clk);
> > > > +
> > > >  		wdev->timeout = 0;
> > > >
> > > >  		/* Initialize time out */
> > > > --
> > > > 2.34.1
> > > >
