Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A568E954
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBHHuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:50:52 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4458CC1B;
        Tue,  7 Feb 2023 23:50:46 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id g8so19815216qtq.13;
        Tue, 07 Feb 2023 23:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mVnPAd0AxN2Xeetse6ostcKuisaMZaCTAVRb6pMiOQ=;
        b=0IMQcfxjEelv9/oYQAYNEmhYsa2xbScwkoHXd9MTtuyt93TxIKslh5WMjz9MqtjfRR
         15hO69GngPI72iI8xrjh6iUGrSdBc0P6OsGwIPg+aZ9pCV9xDGumcgLSG+k5qPJQHMBS
         DuaS7Iu4loaT6rMFeeM8z1st0z1INaFTg1LCmiKicJZ8gyFo6EmLWh/lNQieIyJqZgR8
         NsK+WNGRqcebX12dZ+l9A8g2PGePYSKLj1H78AgvnKgxIg7SVlNKS8Yl5bzuxw9TqHSB
         sEG65alZYdO0o27G02iVkvWrk4BYf36sMOcF3FMu5ZxfqTJa0l6W3OhcDjTFqqEKlW+1
         RAzg==
X-Gm-Message-State: AO0yUKVpW/yR8oa1kqLJr7N48VY11kU7XVDAGMI9siPFGTqh9mWC19R1
        CeaN6zZvZ3WTVQ8eVr1v3uBEc/SXHci9cg==
X-Google-Smtp-Source: AK7set/9wGYNzbPDX5cKq1ydLJP4Rz1yBbJIRYIj5QNzr6xS5H+0PS8utHDmzY5hLD0/5rHI3wgoWA==
X-Received: by 2002:a05:622a:309:b0:3ba:1641:5a49 with SMTP id q9-20020a05622a030900b003ba16415a49mr11396369qtw.8.1675842645808;
        Tue, 07 Feb 2023 23:50:45 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id h13-20020ac8714d000000b003b9dca4cdf4sm11016860qtp.83.2023.02.07.23.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 23:50:45 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-52bf225460cso1446357b3.4;
        Tue, 07 Feb 2023 23:50:45 -0800 (PST)
X-Received: by 2002:a5b:24c:0:b0:87a:68fd:181a with SMTP id
 g12-20020a5b024c000000b0087a68fd181amr839537ybp.36.1675842634268; Tue, 07 Feb
 2023 23:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
 <20230207014207.1678715-10-saravanak@google.com> <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
 <Y+NQUVR9P3hmqFcL@kroah.com>
In-Reply-To: <Y+NQUVR9P3hmqFcL@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Feb 2023 08:50:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXyeU=HP6XVYuXrkjQ8JF53kEW-6mvthCwfL+u3Efuk1A@mail.gmail.com>
Message-ID: <CAMuHMdXyeU=HP6XVYuXrkjQ8JF53kEW-6mvthCwfL+u3Efuk1A@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] of: property: Simplify of_link_to_phandle()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
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

Hi Greg,

On Wed, Feb 8, 2023 at 8:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Feb 07, 2023 at 09:57:14PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> > > The driver core now:
> > > - Has the parent device of a supplier pick up the consumers if the
> > >   supplier never has a device created for it.
> > > - Ignores a supplier if the supplier has no parent device and will never
> > >   be probed by a driver
> > >
> > > And already prevents creating a device link with the consumer as a
> > > supplier of a parent.
> > >
> > > So, we no longer need to find the "compatible" node of the supplier or
> > > do any other checks in of_link_to_phandle(). We simply need to make sure
> > > that the supplier is available in DT.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Thanks for your patch!
> >
> > This patch introduces a regression when dynamically loading DT overlays.
> > Unfortunately this happens when using the out-of-tree OF configfs,
> > which is not supported upstream.  Still, there may be (obscure)
> > in-tree users.
>
> As we can't do anything about out-of-tree code, why does this matter?

Because the actual DT overlay mechanism is upstream.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
