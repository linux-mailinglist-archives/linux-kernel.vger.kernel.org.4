Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FC467E037
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjA0JbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjA0JbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:31:13 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F13525B;
        Fri, 27 Jan 2023 01:30:59 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d3so3527600qte.8;
        Fri, 27 Jan 2023 01:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5Bg3XM00OVfj9CBB6CoZK0gXWkuIJjg1b6VOboGlP0=;
        b=XwJsvxvMsfDZGSghlm0dYwvsrCL75svGWecLZhJ0aoVePvbuzJ428EN0kFrT8cr6ru
         0NVzH4WLglrA6Pbkh0Z56IiC7d2ltc6pie85lxoroxTyrULsyd9erQ7CxBNmLveYHRx1
         620Ge5UwZv9s0n2KlMMcXBlh6HMzMivPumZ8MIU9mf+JyMVATgLfqYMIiCMizXxG4tVv
         UjJK2WjDKCHJAAiZtsZxqKsX31AmqfEfCZct1VwxIQ3rK7yCD8FJ9n9w3Sb12OP0nWFc
         ojDKOWyLw1GWYq1I01X8LDPldRX5CjSDavZd0trup0PnwgpnKiDhp2nSfF3VZkd5yBHS
         dBpQ==
X-Gm-Message-State: AO0yUKX/3qj204gabMa0AU5YB5yJlwblQAcf9p1M9E3bQIB06vMmueVD
        UAw5rr0hsKDVvR+r58QD+AXmVAY8s0k04A==
X-Google-Smtp-Source: AK7set/Px2mTQDnrXaZgF6X6CiXK0u7yJDkBADmtJXaT3kxEYBk/8+kZaO3X0I854oj+fX8IJVyqlw==
X-Received: by 2002:ac8:7f50:0:b0:3b7:fc64:2149 with SMTP id g16-20020ac87f50000000b003b7fc642149mr19026297qtk.44.1674811858627;
        Fri, 27 Jan 2023 01:30:58 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id n7-20020ac86747000000b003ab43dabfb1sm2344965qtp.55.2023.01.27.01.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 01:30:58 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id m199so5264617ybm.4;
        Fri, 27 Jan 2023 01:30:58 -0800 (PST)
X-Received: by 2002:a25:dd8:0:b0:80a:6a1c:7c3b with SMTP id
 207-20020a250dd8000000b0080a6a1c7c3bmr2129588ybn.89.1674811847373; Fri, 27
 Jan 2023 01:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-4-saravanak@google.com>
 <Y9OYdX38NfRE9Tvb@smile.fi.intel.com>
In-Reply-To: <Y9OYdX38NfRE9Tvb@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Jan 2023 10:30:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUdi9ShckBiEAfg3dgp9EUm354tpf3zEz8Dduo2Qyo2vA@mail.gmail.com>
Message-ID: <CAMuHMdUdi9ShckBiEAfg3dgp9EUm354tpf3zEz8Dduo2Qyo2vA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] soc: renesas: Move away from using OF_POPULATED
 for fw_devlink
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Jan 27, 2023 at 10:25 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Jan 26, 2023 at 04:11:30PM -0800, Saravana Kannan wrote:
> > The OF_POPULATED flag was set to let fw_devlink know that the device
> > tree node will not have a struct device created for it. This information
> > is used by fw_devlink to avoid deferring the probe of consumers of this
> > device tree node.
> >
> > Let's use fwnode_dev_initialized() instead because it achieves the same
> > effect without using OF specific flags. This allows more generic code to
> > be written in driver core.
>
> ...
>
> > -             of_node_set_flag(np, OF_POPULATED);
> > +             fwnode_dev_initialized(&np->fwnode, true);
>
> of_fwnode_handle(np) ?

Or of_node_to_fwnode(). Looks like we have (at least) two of them...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
