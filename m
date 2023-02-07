Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EADF68D117
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBGH4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBGH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:56:37 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE533ABF;
        Mon,  6 Feb 2023 23:56:36 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id z5so15778770qtn.8;
        Mon, 06 Feb 2023 23:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2wYlj6gN2naNv6gpoblV6OOQNS/n19UAH0L94v4JNA=;
        b=wUPhG2bN1r5NsnmQHW5uV+uFZJu0ulIEuhmFktxC08fwn1do48LRBLUTfw/Mn16tAh
         op8NJT1ECr2pxKEEIL8fBSth5R1K5OJUdRyRBAL9q/yL1TYa5L1ohz5m5+qUw266MpxC
         19k11pIIoiELRG44AnGRmCbEU4ADTFSu5c5qJoRPBF0uup6wqbyO7eopTCtLYCelvPTF
         aa+Wc+q7O5foi1L2KdzbT4HRk531X/mHRAc+AzdbpS3xi7bYKGZZi+T3BLO3SxZC0HnS
         Q0H3nQymUbi4qR2/fQoErzUNYOobkPiGNDoc8rex+msCMl3kjY4GzWYnfqXA2IjxHymB
         /C+w==
X-Gm-Message-State: AO0yUKXHpCKZnfDcwkdtg3334D2hdnKxaoXI/6fYMXhLwmHr3EQuIzmv
        BYmaIVvAZT3tNfPvUQTn0hw/t1SkRImtQQ==
X-Google-Smtp-Source: AK7set/GsXzUtdquy75y0skRTgxKoi8REMlB3sUQ/kxGRwkiKEXp2fARGeiFzvznbAB8sWCyRdNxPQ==
X-Received: by 2002:ac8:5949:0:b0:3b8:41f4:94e7 with SMTP id 9-20020ac85949000000b003b841f494e7mr3710067qtz.17.1675756595464;
        Mon, 06 Feb 2023 23:56:35 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id e18-20020ac86712000000b003b9a505627bsm8872489qtp.79.2023.02.06.23.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 23:56:35 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5254e8994e8so140830827b3.6;
        Mon, 06 Feb 2023 23:56:34 -0800 (PST)
X-Received: by 2002:a5b:508:0:b0:8a3:59a4:340e with SMTP id
 o8-20020a5b0508000000b008a359a4340emr269046ybp.604.1675756583781; Mon, 06 Feb
 2023 23:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com> <20230207014207.1678715-4-saravanak@google.com>
In-Reply-To: <20230207014207.1678715-4-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Feb 2023 08:56:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRq-+zMuMPMuqLt45t5X78P4nRWZ-cJe8fk=1TsugTYA@mail.gmail.com>
Message-ID: <CAMuHMdVRq-+zMuMPMuqLt45t5X78P4nRWZ-cJe8fk=1TsugTYA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] soc: renesas: Move away from using OF_POPULATED
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

On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> The OF_POPULATED flag was set to let fw_devlink know that the device
> tree node will not have a struct device created for it. This information
> is used by fw_devlink to avoid deferring the probe of consumers of this
> device tree node.
>
> Let's use fwnode_dev_initialized() instead because it achieves the same
> effect without using OF specific flags. This allows more generic code to
> be written in driver core.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

You've missed my earlier:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
