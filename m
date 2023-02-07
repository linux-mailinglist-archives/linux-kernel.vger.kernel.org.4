Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4768E30C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBGVgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:36:16 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031B01F491;
        Tue,  7 Feb 2023 13:36:16 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id w3so18471112qts.7;
        Tue, 07 Feb 2023 13:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lg0sHUTSECVWWUA2U2vv5V8YfzjLBhdgpAqAGOEck8k=;
        b=7gP0S2lWjPsosW7Pm1F+GO7wjAEfSO9Iuw7l/1E2w2QgRHkxS8iE+5Q2waGuWZlIrb
         TFGEQrX47A2fiiMfuxXxQYt+cvVKGvcQ9au5p0YzKQvopSy6ijXdeGTf9SZgxhfP7nSE
         4NPoyIaHEll4gjuI/eSJwkFiof4/C5UzBWZEJUWxH8UCTi2MuQB1XWir/dkhYy7DB7Rc
         /9igmQOTcccl+Ruji9aVnyGpl0Q6RNGZEmVxc+lSdsQOzRczAC9KcFTeC+T1QcYFRgaY
         AuJO223HP3pMOrKiU1tvl74a9t1ObuQxcknK3l9tiJUz9pP1W2jIKlP3a1WhO1nfXWpf
         r0aA==
X-Gm-Message-State: AO0yUKUm53sifKTuQUw+w+RVLyn4wz1UkjArP95bxbq2t7ZOD2uAD9O6
        uAyqANrg/TmEqfrFSVwt4a2uOQZ1Kbs8nw==
X-Google-Smtp-Source: AK7set92yDaImQUOrCYHUkIhlxRKMlsiHaSpuxj4VfNct4eZ8MsEt7XG9o8bCEN/qiliHEvHFlxfmw==
X-Received: by 2002:ac8:5781:0:b0:3b8:68ef:d538 with SMTP id v1-20020ac85781000000b003b868efd538mr7683827qta.52.1675805774999;
        Tue, 07 Feb 2023 13:36:14 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id d8-20020a05622a100800b003b643951117sm10465121qte.38.2023.02.07.13.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 13:36:14 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-51ba4b1b9feso211767857b3.11;
        Tue, 07 Feb 2023 13:36:14 -0800 (PST)
X-Received: by 2002:a5b:508:0:b0:8a3:59a4:340e with SMTP id
 o8-20020a5b0508000000b008a359a4340emr532033ybp.604.1675805764091; Tue, 07 Feb
 2023 13:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Feb 2023 22:35:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWWc6pbrxCETL+VcXiwesfpUE7r2xc9U9ti5aTietqzDQ@mail.gmail.com>
Message-ID: <CAMuHMdWWc6pbrxCETL+VcXiwesfpUE7r2xc9U9ti5aTietqzDQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

Hi Saravana,

On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> Naresh, Tony, Abel, Geert, Dmitry, Maxim(s), Miquel, Luca, Doug, Martin,
> Jean-Philippe,
>
> Can I get your Tested-by's for this v3 series please?

I have tested this on a variety of Renesas arm32/arm64 platforms,
and on several RISC-V platforms.
Apart from the regression related to dynamic overlays caused by
"[PATCH v3 09/12] of: property: Simplify of_link_to_phandle()"
(which you may decide to ignore for now ;-)
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
