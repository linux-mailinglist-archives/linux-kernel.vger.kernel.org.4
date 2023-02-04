Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5168ACE2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjBDWbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 17:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjBDWbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 17:31:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F6C23874
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 14:30:56 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 5so1995406pgd.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 14:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2c3ryMxpOrIrZDVaOC8ynRmFu3tYBCZQcCXL31Q6F3k=;
        b=E4A5hYEQRp90Hq5gcHozZx89CANxAwz5pa5hV0u6D7/CSE7D9FjEvqXYB61jPCQN6R
         uanAQTYAH37I86uAD9fDVd49n5AU/IEwpa65uBkowop5pcrCfFX/HEqL6I3zA9pf0F/P
         032WaKdRiA1F3CA+VV0gqYE/t8IDtiSmSqfwZvkJnIKPsa3Rxgert/AdhpNpC3cDkPXN
         ZbnNVdwFWbp0s9NZKPQf67Rm7IXXFcig56fq7QTqXVPsjWTVSNoZ/+s1RlvgWSk4eex2
         1Ql/Hhl5ACwU2n9vWNsCmfribawOpaIaR63+0/CkkzNuCejBofd+kArEuZQQTqc6wP/+
         PQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2c3ryMxpOrIrZDVaOC8ynRmFu3tYBCZQcCXL31Q6F3k=;
        b=sQHJN99bavqnIu2/2/MqBqNiuAUanU8NNewU/ZNH5VOi+VKiztHVLUgfOrBZ4Go9Vw
         50RQqr5ADrEQLDCPd6R7Dnff4cdtp6r0hbYmwO0gwz5SoEjA2slhw5uqGXM4LpAbBtuH
         8kscKBMD0c7McBwNO99zEjBhk57ql79LFI53QFrUHAjKI50LKtyZF0q+uLFPJhBzbn6k
         NfYdr66+pouB2SbHf9uusm+d6KmIQBE/wYQYR3/JZ+sZA+fmoBSmidNXo+LPnkG/Xj4M
         MVKNmXDBnIS2cMqt24RrdOpr3CTYGICqH29AZDSK6AnIHCQx6tQTuaDeMlCb9rLGlqk1
         kuug==
X-Gm-Message-State: AO0yUKXndf5wkhaGOqbg5DVXVUhSkW7kTj2O7DjskuyaQNBhs4Ex4967
        rLgkcq+jqFqI5zNzd5jEyb88onGQMdvKup2+LbqQZg==
X-Google-Smtp-Source: AK7set+ZC7Ks2eIaN+4nhpE4jlE1jqO/ZiAjj58j/wvorPO2PW5t0ia/NMESz7xFZXQD1dSaARAuey5tmskPGv2QHv4=
X-Received: by 2002:a62:1a57:0:b0:593:bac2:b49 with SMTP id
 a84-20020a621a57000000b00593bac20b49mr3621986pfa.44.1675549855647; Sat, 04
 Feb 2023 14:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-4-saravanak@google.com>
 <CAMuHMdV4B49OM7S-UAxJtfAR8OvG_-S526fGnTA+t+-orytrTw@mail.gmail.com>
 <CAGETcx9EXkbAfEX6pBL84DBr3SEwiJe7N4xh91TspLn8CwZ+LQ@mail.gmail.com>
 <CAMuHMdUFeSim2gvmiBuPbAajbK6ybh67gBmbLLqRhG1T5+v0JA@mail.gmail.com>
 <CAGETcx-TSrjFnmxV02TMaGN6Au4f9SuLgzjMPOqAOTqx_bqLhA@mail.gmail.com> <CAMuHMdX=F5zPfVQLihWRBt0EN-nNW=x4v_XFpp4aY9WrhkwmJw@mail.gmail.com>
In-Reply-To: <CAMuHMdX=F5zPfVQLihWRBt0EN-nNW=x4v_XFpp4aY9WrhkwmJw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 4 Feb 2023 14:30:19 -0800
Message-ID: <CAGETcx_7wRwYaERw5oJT-Lh+rU_9QAM6HRthEe6ShyhyCQTciw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:14 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Mon, Jan 30, 2023 at 9:00 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Mon, Jan 30, 2023 at 12:43 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Sat, Jan 28, 2023 at 8:19 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Fri, Jan 27, 2023 at 12:11 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Fri, Jan 27, 2023 at 1:11 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > The OF_POPULATED flag was set to let fw_devlink know that the device
> > > > > > tree node will not have a struct device created for it. This information
> > > > > > is used by fw_devlink to avoid deferring the probe of consumers of this
> > > > > > device tree node.
> > > > > >
> > > > > > Let's use fwnode_dev_initialized() instead because it achieves the same
> > > > > > effect without using OF specific flags. This allows more generic code to
> > > > > > be written in driver core.
> > > > > >
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > --- a/drivers/soc/renesas/rcar-sysc.c
> > > > > > +++ b/drivers/soc/renesas/rcar-sysc.c
> > > > > > @@ -437,7 +437,7 @@ static int __init rcar_sysc_pd_init(void)
> > > > > >
> > > > > >         error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
> > > > > >         if (!error)
> > > > > > -               of_node_set_flag(np, OF_POPULATED);
> > > > > > +               fwnode_dev_initialized(&np->fwnode, true);
> > > > >
> > > > > As drivers/soc/renesas/rmobile-sysc.c is already using this method,
> > > > > it should work fine.
> > > > >
> > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > i.e. will queue in renesas-devel for v6.4.
> >
> > I hope you meant queue it up for 6.3 and not 6.4?
>
> V6.4.
> The deadline for submitting pull requests for the soc tree is rc6.
> Sorry, your series was posted too late to make that.
>
> > > > Thanks! Does that mean I should drop this from this series? If two
> > > > maintainers pick the same patch up, will it cause problems? I'm
> > > > eventually expecting this series to be picked up by Greg into
> > > > driver-core-next.
> > >
> > > Indeed. Patches for drivers/soc/renesas/ are supposed to go upstream
> > > through the renesas-devel and soc trees. This patch has no dependencies
> > > on anything else in the series (or vice versa), so there is no reason
> > > to deviate from that, and possibly cause conflicts later.
> >
> > This series is supposed to fix a bunch of issues and I vaguely think
> > the series depends on this patch to work correctly on some Renesas
> > systems. You are my main renesas person, so it's probably some issue
> > you hit. Is you pick it up outside of this series I need to keep
> > asking folks to pick up two different patch threads. I don't have a
> > strong opinion, just a FYI. If you can take this patch soon, I don't
> > have any concerns.
>
> Oh right, you do remove OF_POPULATED handling in
> "[PATCH v2 09/11] of: property: Simplify of_link_to_phandle()".
> It might be wise to postpone that removal, as after your series,
> there are stillseveral users left, some of them might be impacted.
>
> I do plan to test your full series on all my boards, but probably that
> won't happen this week.
>
> > > BTW, I will convert to of_node_to_fwnode() while applying.
> >
> > Sounds good.
>
> If you still want this to land in v6,3 (with the of_node_to_fwnode()
> conversion):
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Yeah, let me try to land this in 6.3 with the series.

-Saravana
