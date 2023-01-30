Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD1681375
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbjA3Ogb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjA3Og3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:36:29 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1DC13F;
        Mon, 30 Jan 2023 06:36:28 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-16332831ed0so15182887fac.10;
        Mon, 30 Jan 2023 06:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9D5+mOa+V6zLZUsgo8fYk9qa1TaSMliGQ0eIaxr9+OE=;
        b=ujvaDeOyxdEPQBM6LHJVbeVJzeIjTEh9A/RQkWgete8QeKRXzDf6lksCF5XFXvlRIF
         sqk7bEMlKpmHhE4I0N+xxQpp5B8PTyz6+mEACJb6aLo9yon60800epD5UdpJItIxVRxj
         CJJNxjQCyUqKEO0VDMYVfjby/d+CxF9C2hApUXWhrqwVhR4GJm+UC8aU0phkTUqfWBFR
         i4sjMVimjD6U5pV4DQE3HFykUJnzSY269VGf/jfex8SbC12Qv1o2pNBcqCuJUStF0Xq1
         /OdEWJhrPvNLKP8UEy/y2wRXhApi+0enrQ3gwRfRmrTT8IzRvNF/Q3phcnlvox3FtWvs
         6Obw==
X-Gm-Message-State: AO0yUKWPgNA4nWSqacZuUcTbGrw1m+e0tSsD52xYCrX5lba17YfXEzk6
        b0LDnLBRsED4pSwutqe2K7GVOnbokkU2UQ==
X-Google-Smtp-Source: AK7set+8OYk4njLoOMTUhSZWHB6oaLJyCVrpGEBDZSVs11tu5z653ZnqxL02nNp6sEBftIRrarFWSA==
X-Received: by 2002:a05:6870:204c:b0:163:cd39:5f1f with SMTP id l12-20020a056870204c00b00163cd395f1fmr847394oad.40.1675089387661;
        Mon, 30 Jan 2023 06:36:27 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id f64-20020a9d2c46000000b0068bcd2b0bfasm1873405otb.65.2023.01.30.06.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 06:36:27 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so116756otq.13;
        Mon, 30 Jan 2023 06:36:27 -0800 (PST)
X-Received: by 2002:a25:ab30:0:b0:80b:8247:e8b1 with SMTP id
 u45-20020a25ab30000000b0080b8247e8b1mr1966130ybi.604.1675089376546; Mon, 30
 Jan 2023 06:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-9-saravanak@google.com>
 <Y9OcqGTocu8ZlFqy@smile.fi.intel.com> <CAGETcx-PiV12pKnVuKyvNcjYbHA=YFJG1QUa-o-G1cL3iMHgcA@mail.gmail.com>
 <Y9e09qUa9CDxHFcb@smile.fi.intel.com>
In-Reply-To: <Y9e09qUa9CDxHFcb@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jan 2023 15:36:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSgS-hu1xV_vmJZi_kr6ypiS=a-e0p7Hb75HKDfz9k-g@mail.gmail.com>
Message-ID: <CAMuHMdXSgS-hu1xV_vmJZi_kr6ypiS=a-e0p7Hb75HKDfz9k-g@mail.gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jan 30, 2023 at 1:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Jan 27, 2023 at 11:34:28PM -0800, Saravana Kannan wrote:
> > On Fri, Jan 27, 2023 at 1:43 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Jan 26, 2023 at 04:11:35PM -0800, Saravana Kannan wrote:
> > > > +static bool __fw_devlink_relax_cycles(struct device *con,
> > > > +                              struct fwnode_handle *sup_handle)
> > > > +{
> > > > +     struct fwnode_link *link;
> > > > +     struct device_link *dev_link;
> > >
> > > > +     struct device *sup_dev = NULL, *par_dev = NULL;
> > >
> > > You can put it the first line since it's long enough.
> >
> > Wait, is that a style guideline to have the longer lines first?
>
> No, but it's easier to read.

Yes it is, "reverse xmas tree" local variable ordering:
https://elixir.bootlin.com/linux/v6.2-rc6/source/Documentation/process/maintainer-netdev.rst#L272

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
