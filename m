Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12F67E0DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjA0J4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjA0J4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:56:20 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7EA1A48F;
        Fri, 27 Jan 2023 01:56:19 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id b18-20020a056830311200b0068aed2e014fso1089676ots.13;
        Fri, 27 Jan 2023 01:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l2Z180oEHBv0ophrRyrSwGxvlM3VzZAmGs8B6dfBoE=;
        b=EFJVjM1tzgT+IwjAlmwyaVLUgAC1QrboMm9WndKfAG47m9Yv90ZJfyO1j2wdQvDCKk
         FsXq8jvjdjR9dFm3/ZfYnle/WHinL1cI+I2GhWsYp0K1/O1WFJ+0T6IJAQDkcK5wrcS0
         ugrNVNnqaJvKin0ygvxVcf6CTTwG0J0pvTKG906uBNzoPgI+/eSjvJqXizRqQRTM8mEV
         yD8/9U/JD3gZtDIyya6BnYOaZG+F4/psvtvJCJicmRmquYQmrZ/MfYzLmuk1Mbc6Kvw+
         aIV+ir6US0QvBJdKeHy9xS+nWjqaGTkVRxt/gI6S3T6H06Jqia/tZznfw8GpszFfPgcH
         D5xg==
X-Gm-Message-State: AFqh2kptM96IAsGd3UNyk2Z3t/CDb71lLWCMis01NAM7ODQuJeXQd8YX
        i/XUhyxxupU0+MDUZaghCU70bh5OiuW4Bw==
X-Google-Smtp-Source: AMrXdXs3hW/pFHKwBqsnwhe8tFX9M7xVr0nOBzkm69iU1b8T1/DgRbBAa866hqzyjLRDSC1kYcjRIg==
X-Received: by 2002:a9d:6b0c:0:b0:684:c12a:c2f0 with SMTP id g12-20020a9d6b0c000000b00684c12ac2f0mr23743344otp.28.1674813378843;
        Fri, 27 Jan 2023 01:56:18 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id g20-20020a9d6b14000000b0068848d6b231sm1558104otp.30.2023.01.27.01.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 01:56:18 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id u13-20020a056830118d00b00686def09868so1936148otq.7;
        Fri, 27 Jan 2023 01:56:18 -0800 (PST)
X-Received: by 2002:a81:1216:0:b0:506:6b5d:523c with SMTP id
 22-20020a811216000000b005066b5d523cmr743466yws.283.1674813367375; Fri, 27 Jan
 2023 01:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-6-saravanak@google.com>
 <Y9OZh0ZqtnqmKcvT@smile.fi.intel.com>
In-Reply-To: <Y9OZh0ZqtnqmKcvT@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Jan 2023 10:55:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2eUkpRDD_4u71pfXQd_GixStJh56NJ0Kh+dR6h9phiA@mail.gmail.com>
Message-ID: <CAMuHMdU2eUkpRDD_4u71pfXQd_GixStJh56NJ0Kh+dR6h9phiA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] driver core: fw_devlink: Add DL_FLAG_CYCLE
 support to device links
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

On Fri, Jan 27, 2023 at 10:30 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Jan 26, 2023 at 04:11:32PM -0800, Saravana Kannan wrote:

> >                              DL_FLAG_AUTOREMOVE_SUPPLIER | \
> >                              DL_FLAG_AUTOPROBE_CONSUMER  | \
> >                              DL_FLAG_SYNC_STATE_ONLY | \
> > -                            DL_FLAG_INFERRED)
> > +                            DL_FLAG_INFERRED | \
> > +                            DL_FLAG_CYCLE)
>
> You can make less churn by squeezing the new one above the last one.

And avoiding some future churn by introducing alphabetical order.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
