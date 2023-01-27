Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43B67E1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjA0KaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjA0K3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:29:50 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5C13503;
        Fri, 27 Jan 2023 02:29:47 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id i9so3856357oif.4;
        Fri, 27 Jan 2023 02:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKruyQW1tJheLO2piiCDKl7s1j50V272W4MEFdOhqCA=;
        b=00+WBZEp5E7eC76VI9EsDKRtz4ugATiY6ovgMMg5+8PzQAlrpPfvIdodehUMGd0n86
         qtdHuIn6Hf9dWrjaQ6ZXLe3g2cBht7i0u4e6MnjVp+XmHtqNlbiaeFhg9m/DZURgXkeJ
         5zRTt4mI7f3XZGXeXo9/u97SvmTw6OhV3sYHc4ds7vtxk9S7DZYkdiloDTZNHRRNN0dr
         opf8/Kd/An02cPK3pPj5ctk9gz47BfZ8sNfNRf7FaqcuvTBI/IG7ZRGFcQtVilWyf4yG
         hOhmcLcAvIneUWFdTCV02nxnhIKcTXyjnuCRQOKkUcxaJgDoI2mgfvTAXoqIUy9GQxVx
         bulw==
X-Gm-Message-State: AO0yUKWwdXt3Yvo6SNRiUw3mgR9xlU24cMNk8GWoIVDNxPyOsmCtQ8IG
        rZKRGhSSFZqcpwLknwe8DMGj5Nw3r69cLA==
X-Google-Smtp-Source: AK7set+qty1T48p73vD/2rNItlz11TA6XIf8lynjnYUo1pcyPxbsdPj1v3HWUIOWXFa6e7SRbVsIfA==
X-Received: by 2002:a05:6808:d1:b0:35e:7595:30df with SMTP id t17-20020a05680800d100b0035e759530dfmr2415966oic.9.1674815387051;
        Fri, 27 Jan 2023 02:29:47 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id f66-20020aca3845000000b0036acbbf9fbasm1399943oia.46.2023.01.27.02.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:29:46 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso98981otl.11;
        Fri, 27 Jan 2023 02:29:46 -0800 (PST)
X-Received: by 2002:a0d:f281:0:b0:508:2f2c:8e5f with SMTP id
 b123-20020a0df281000000b005082f2c8e5fmr772773ywf.384.1674815376246; Fri, 27
 Jan 2023 02:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-9-saravanak@google.com>
 <Y9OcqGTocu8ZlFqy@smile.fi.intel.com> <CAMuHMdXRbiNW9nd_N_=+OTo-uCmy2ePfOmREEHcqLyEn1H=Rhg@mail.gmail.com>
 <Y9OjE+bJquDcCpJ8@smile.fi.intel.com>
In-Reply-To: <Y9OjE+bJquDcCpJ8@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Jan 2023 11:29:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVpDJmjFebdc5yi421Tyvnh4w5AqZTuA035o4FU_wZRKw@mail.gmail.com>
Message-ID: <CAMuHMdVpDJmjFebdc5yi421Tyvnh4w5AqZTuA035o4FU_wZRKw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Jan 27, 2023 at 11:10 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Jan 27, 2023 at 10:52:02AM +0100, Geert Uytterhoeven wrote:
> > On Fri, Jan 27, 2023 at 10:43 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Jan 26, 2023 at 04:11:35PM -0800, Saravana Kannan wrote:
> > > > + * Check if @sup_handle or any of its ancestors or suppliers direct/indirectly
> > > > + * depend on @con.  This function can detect multiple cyles between @sup_handle
> > >
> > > A single space is enough.
> >
> > It's very common to write two spaces after a full stop.

See e.g.:

    git grep "\.  [^ ]

> > When joining two sentences on separate lines in vim using SHIFT-J,
> > vim will make sure there are two spaces.
>
> But is this consistent with all kernel doc comments in the core.c?

Probably there are inconsistencies...
(Aren't there everywhere?)

> I'm fine with either as long as it's consistent.

At least the kerneldoc source will look similar to the PDF output
(LaTeX inserts more space after a full stop automatically ;-).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
