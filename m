Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341806807AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjA3InF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3InB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:43:01 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F75126DB;
        Mon, 30 Jan 2023 00:43:00 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1631b928691so14070869fac.11;
        Mon, 30 Jan 2023 00:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6jHULr0UQaDIQzU8hyuuqTklxOoQZdGiuLMsSkhuWs=;
        b=S1Tm8H/OnWW4DfYurqncTbXVsh18VHwSVW3b9L68G3OSBalCsUkfOyvK2IDufkhqWV
         PlCJOXL4H2vycBSbKjXvEWfyJPALfVmo0njLpRuH9L05rvcXkFMFYlo90Q1WRUeFZA3T
         N8er15m3zIhotAzqYoEZz/yB6oVfT3bW03yZuIwTnue/qk4XCRig39972XUsZDHyWw8G
         ffOJIXju419cVI4FP1j4udAozox2ACumg4dTSZLDxzxvFkl4u/SfYFn8o9HCDljyM5HA
         XUgSLsiVdMNzPLjXinrwrFw4DZrPLJKHNCojH5cdMaeZ9cGQ3pc/u+FPO88tNJEi/ry3
         nixA==
X-Gm-Message-State: AO0yUKW3ub8jDm39uOhfj7w+TA6HUFBhijt2uLGJV+AOW/V1EJ4zABxM
        fWMswW51hlfcvYbEdvBijUDZ5u2h7g2ZJg==
X-Google-Smtp-Source: AK7set/SYIL3y3Z8ZbL72BHPZj9eiDJ+EepfDjYiGnDYjfWs274lBCXLC9w8SNyJjrHN7JtOaIXoUg==
X-Received: by 2002:a05:6870:9106:b0:163:ade9:27b4 with SMTP id o6-20020a056870910600b00163ade927b4mr2012832oae.26.1675068179567;
        Mon, 30 Jan 2023 00:42:59 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id bf34-20020a0568700a2200b001631914e41asm4890153oac.33.2023.01.30.00.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 00:42:59 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id k91-20020a9d19e4000000b0068bca1294aaso1194275otk.8;
        Mon, 30 Jan 2023 00:42:59 -0800 (PST)
X-Received: by 2002:a25:37d4:0:b0:80b:8602:f3fe with SMTP id
 e203-20020a2537d4000000b0080b8602f3femr2897020yba.36.1675068168732; Mon, 30
 Jan 2023 00:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-4-saravanak@google.com>
 <CAMuHMdV4B49OM7S-UAxJtfAR8OvG_-S526fGnTA+t+-orytrTw@mail.gmail.com> <CAGETcx9EXkbAfEX6pBL84DBr3SEwiJe7N4xh91TspLn8CwZ+LQ@mail.gmail.com>
In-Reply-To: <CAGETcx9EXkbAfEX6pBL84DBr3SEwiJe7N4xh91TspLn8CwZ+LQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jan 2023 09:42:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFeSim2gvmiBuPbAajbK6ybh67gBmbLLqRhG1T5+v0JA@mail.gmail.com>
Message-ID: <CAMuHMdUFeSim2gvmiBuPbAajbK6ybh67gBmbLLqRhG1T5+v0JA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] soc: renesas: Move away from using OF_POPULATED
 for fw_devlink
To:     Saravana Kannan <saravanak@google.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Sat, Jan 28, 2023 at 8:19 AM Saravana Kannan <saravanak@google.com> wrote:
> On Fri, Jan 27, 2023 at 12:11 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Jan 27, 2023 at 1:11 AM Saravana Kannan <saravanak@google.com> wrote:
> > > The OF_POPULATED flag was set to let fw_devlink know that the device
> > > tree node will not have a struct device created for it. This information
> > > is used by fw_devlink to avoid deferring the probe of consumers of this
> > > device tree node.
> > >
> > > Let's use fwnode_dev_initialized() instead because it achieves the same
> > > effect without using OF specific flags. This allows more generic code to
> > > be written in driver core.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/soc/renesas/rcar-sysc.c
> > > +++ b/drivers/soc/renesas/rcar-sysc.c
> > > @@ -437,7 +437,7 @@ static int __init rcar_sysc_pd_init(void)
> > >
> > >         error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
> > >         if (!error)
> > > -               of_node_set_flag(np, OF_POPULATED);
> > > +               fwnode_dev_initialized(&np->fwnode, true);
> >
> > As drivers/soc/renesas/rmobile-sysc.c is already using this method,
> > it should work fine.
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.4.
>
> Thanks! Does that mean I should drop this from this series? If two
> maintainers pick the same patch up, will it cause problems? I'm
> eventually expecting this series to be picked up by Greg into
> driver-core-next.

Indeed. Patches for drivers/soc/renesas/ are supposed to go upstream
through the renesas-devel and soc trees. This patch has no dependencies
on anything else in the series (or vice versa), so there is no reason
to deviate from that, and possibly cause conflicts later.

BTW, I will convert to of_node_to_fwnode() while applying.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
