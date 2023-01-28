Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021C367F570
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjA1HT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjA1HT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:19:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FD7E6CC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:19:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jl3so7046785plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=laXAH5vCj60E4SKPB0EaS+rzszoEwgFmO/AUUT4c6EE=;
        b=tmPZMbcJdI07kMJbg//bhDUNZ5KDVVZ2XAzmy8ooz8DAs/87eQ8xaIW9TMmlo7p11e
         hdSVHBR5OJilXJnd6grGS0h68h34HGg+wmw02fuRE3b8brDJ4Rpk3tb6YfnqMUaMNhjM
         fgye91Hf232OS8bCCEAmgY2kHzH7TvDc87sBHl+WPLXCSalMe5BWf/ze5NEMJrUa7o2O
         Jcy1lTTkJcImUcG+o7lTL+/xh3ChzFeROE8zm199gWvoBKR4rdbbAdKNH/EVHjkrThIl
         Bz8K7V429/gShD3wOSxSSFR7OYsgY82uRYwvBvSbV+BGLHO84mkzYjIcLyNuodj9mkX3
         YaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laXAH5vCj60E4SKPB0EaS+rzszoEwgFmO/AUUT4c6EE=;
        b=rf3C0QOE9fopcvYOp4409JwwDK99vS7pn9lWp1uco5tVQ27p1UKBx427E85DQ2n67E
         dzWIaDkmmZ3AmKOSqsZXvNnrrtFK1D/Kj9cAg5TROLTignklmpq9gwf8ak8AKy/pszN6
         RvcdUG61isCyj+kP4C6+f3I/kRyounaQs7wOMkomb0kIpqCf6qnmxkFqFDPjiRmjaJJ0
         wIoCmdnHz8mnORADW0tdeibcSXP1O+jQQ6gpkSPbnsp7PHwFQDt52h8AGpoYM28/PS7h
         dt3PGPZaP7nFp0C6JjllDF5kpCKvt2fw8JBBJRGuUDskO5pVxwHZwvWtJrhDb58G4sm4
         1+gA==
X-Gm-Message-State: AO0yUKX20QaaQ1EpwLjdlz8Z0yln5ZxfiYPWruMQKaOuRVldPlekxlIP
        YFazLEwx8Hux945Q3SASBdv6IAfJxP0So+zzst50bw==
X-Google-Smtp-Source: AK7set9Mr0byHbMSV0I8NA2aqwV2H7BFCi7M8aNlkggIrU6lOiPUWBoUK5Tegh3Ooimmvu26mnAavaDANvOV+V848Ys=
X-Received: by 2002:a17:90a:64c5:b0:22b:ef05:ea5b with SMTP id
 i5-20020a17090a64c500b0022bef05ea5bmr2691642pjm.50.1674890363672; Fri, 27 Jan
 2023 23:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-4-saravanak@google.com>
 <CAMuHMdV4B49OM7S-UAxJtfAR8OvG_-S526fGnTA+t+-orytrTw@mail.gmail.com>
In-Reply-To: <CAMuHMdV4B49OM7S-UAxJtfAR8OvG_-S526fGnTA+t+-orytrTw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Jan 2023 23:18:46 -0800
Message-ID: <CAGETcx9EXkbAfEX6pBL84DBr3SEwiJe7N4xh91TspLn8CwZ+LQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] soc: renesas: Move away from using OF_POPULATED
 for fw_devlink
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:11 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, Jan 27, 2023 at 1:11 AM Saravana Kannan <saravanak@google.com> wrote:
> > The OF_POPULATED flag was set to let fw_devlink know that the device
> > tree node will not have a struct device created for it. This information
> > is used by fw_devlink to avoid deferring the probe of consumers of this
> > device tree node.
> >
> > Let's use fwnode_dev_initialized() instead because it achieves the same
> > effect without using OF specific flags. This allows more generic code to
> > be written in driver core.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!
>
> > --- a/drivers/soc/renesas/rcar-sysc.c
> > +++ b/drivers/soc/renesas/rcar-sysc.c
> > @@ -437,7 +437,7 @@ static int __init rcar_sysc_pd_init(void)
> >
> >         error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
> >         if (!error)
> > -               of_node_set_flag(np, OF_POPULATED);
> > +               fwnode_dev_initialized(&np->fwnode, true);
>
> As drivers/soc/renesas/rmobile-sysc.c is already using this method,
> it should work fine.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.4.

Thanks! Does that mean I should drop this from this series? If two
maintainers pick the same patch up, will it cause problems? I'm
eventually expecting this series to be picked up by Greg into
driver-core-next.

-Saravana

>
> >
> >  out_put:
> >         of_node_put(np);
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
