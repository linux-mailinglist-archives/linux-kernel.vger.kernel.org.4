Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD167E0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjA0Jwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA0Jw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:52:27 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3691C2713;
        Fri, 27 Jan 2023 01:52:26 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id o5so3536748qtr.11;
        Fri, 27 Jan 2023 01:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcPSHtw8IRmQiplO2eV40srjU+RjNYjtCSWfS2dk4XE=;
        b=R1GbwsKi2K+QrxKcvFvoI833NE3S8Dry7taEg3FMbkdMM7KD/9V1PMrLd4og23g6e0
         3WgjPissVb+yrtHwN+Izq4ecmy+eh5wlENDUmaf1Z9yPOR7sHilz6QVXTNCz7DOwex69
         dAHnkdYcnBdMwomyZTOmJxZumtuuhoVhz0V7XTDDVE9mFHFXXME8pKdVvPhzCfuUr0iC
         cnfjxGtW+mmoI9ffJ5O59XmxLsV+bKIsu2Hguoq5slT4bdMm6H1yuTkVuJRVVlUSXxlQ
         lzTeGHbaSyAwkrwIW23F5TDLwKhXIUhMXrhAzoTVNx03tFfPz+t0rLJOnE2LfvW5K8tq
         boJw==
X-Gm-Message-State: AFqh2komLGbl2mX85GalmcrXbMSs/LV5uATKYd8QAlyPrvXIAFkop9fh
        YLXajhiM/79vCZP+gosr/QUHC76TZScBaA==
X-Google-Smtp-Source: AMrXdXvlWxGCchkRGWxaENR5ex8IEBgdDcFt/5ILK6KbQUGjfXFd02fgVpDg8k7JEYtQ2HaAcZJMag==
X-Received: by 2002:a05:622a:4015:b0:3b0:7755:ab80 with SMTP id cf21-20020a05622a401500b003b07755ab80mr62763671qtb.67.1674813145118;
        Fri, 27 Jan 2023 01:52:25 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id d12-20020ac85acc000000b003b68d445654sm981543qtd.91.2023.01.27.01.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 01:52:24 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-4ff07dae50dso60282707b3.2;
        Fri, 27 Jan 2023 01:52:24 -0800 (PST)
X-Received: by 2002:a25:d505:0:b0:7bf:d201:60cb with SMTP id
 r5-20020a25d505000000b007bfd20160cbmr3209718ybe.365.1674813133808; Fri, 27
 Jan 2023 01:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-9-saravanak@google.com>
 <Y9OcqGTocu8ZlFqy@smile.fi.intel.com>
In-Reply-To: <Y9OcqGTocu8ZlFqy@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Jan 2023 10:52:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRbiNW9nd_N_=+OTo-uCmy2ePfOmREEHcqLyEn1H=Rhg@mail.gmail.com>
Message-ID: <CAMuHMdXRbiNW9nd_N_=+OTo-uCmy2ePfOmREEHcqLyEn1H=Rhg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] driver core: fw_devlink: Make cycle detection
 more robust
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

On Fri, Jan 27, 2023 at 10:43 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Jan 26, 2023 at 04:11:35PM -0800, Saravana Kannan wrote:
> > + * Check if @sup_handle or any of its ancestors or suppliers direct/indirectly
> > + * depend on @con.  This function can detect multiple cyles between @sup_handle
>
> A single space is enough.

It's very common to write two spaces after a full stop.
When joining two sentences on separate lines in vim using SHIFT-J,
vim will make sure there are two spaces.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
