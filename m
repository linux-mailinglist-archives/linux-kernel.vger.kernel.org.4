Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6853767F5B3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjA1Hft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjA1Hfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:35:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28AE8D0B2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:35:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so6773223pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b+RFpRJs0xuB4gmuObROuwz4dxLhUH7cqrzlkSnFIcc=;
        b=E5f3tYSRcGCHD0f05IVlrEg2aBkkQF0+d8+GwNVMRweXITwGxTNJvl5GTzT/ZHynfs
         tS33LB+QIqb6arl4mkDu5QIIcWq5vLgpXy8dfHP3V/owwfOnmTzyMOVP0yNrKwmgGMTM
         tG1bKn3TkpfZydcJaT59XgRaIixC6tces40+ymhlwJ1PXxTT4wvEjPW7qoMy1Ye0oXYz
         oCJ7l5IbZD3va8n08BzIwLdTZQpf60Obi65+jSPECZ4UGLN3XalZN27XFaLXBv51sDrI
         X/kC6qLfllMA7pk8Jbm/NdDdvLdnCZch7bX6oAHOjIuA2BwN+rjWZ4QxCawWq1g9Ce0Z
         cBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+RFpRJs0xuB4gmuObROuwz4dxLhUH7cqrzlkSnFIcc=;
        b=2vcC3gPhzHGbB6f5r4pWzHhsz2OHMQFyTHwFSsnH5PH54adkYUlnJ5h84wCZohYUJX
         yRbwBsXawgcH2Uap0UMgxTPWoLrArRjCOLfekxtgsUbgnI2TTZ51y4qmRvxejQ5SjYFn
         dU24QFuf3QhqO+zq5wug662S7cYDGYcUmjfWL4bVQO40RLGT+Xw4ApB0joJxDFfbcNH2
         H1jkOjGbjDtNJ4o9LgUxyXR1lBrWw8OHgxeTPHnGeQ+eqHfELH1kd1L5xRb5Pfj1ZQeP
         LL663IV+w/5rLtybPl7/9w1/xTF2sqm+D8brZ+1Nh5UKzyUAdftQJwQuIup+oaBzxrtg
         U64Q==
X-Gm-Message-State: AFqh2koT2L8qjyl34tKeZQxgxKiEx6H646xesFbhx0nMZbfNtwTzbU7S
        iWQcyWIOIuYmNNQOp5MWcCuZwoc9JnQMM4hIaIwUAg==
X-Google-Smtp-Source: AMrXdXtcy6GzDmIsWx+JJhiM4nf5ZJkxCfBvmjzprfDg2/sXA1zxWHzVMufXd/eGbAB3EbQBo759okdBtzEgtTTy6y4=
X-Received: by 2002:a17:90a:7e8d:b0:225:d307:95ce with SMTP id
 j13-20020a17090a7e8d00b00225d30795cemr5435623pjl.136.1674891317143; Fri, 27
 Jan 2023 23:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-11-saravanak@google.com>
 <Y9OemQgO9qoSdT1r@smile.fi.intel.com>
In-Reply-To: <Y9OemQgO9qoSdT1r@smile.fi.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Jan 2023 23:34:40 -0800
Message-ID: <CAGETcx9rSNgBhthkyj5zPbTPzp_SW+UUUJqPCSPFix0KG9NiOw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 1:51 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 26, 2023 at 04:11:37PM -0800, Saravana Kannan wrote:
> > Since this device is only partially initialized by the irqchip driver,
> > we need to mark the fwnode device as not initialized. This is to let
> > fw_devlink know that the device will be completely initialized at a
> > later point. That way, fw_devlink will continue to defer the probe of
> > the power domain consumers till the power domain driver successfully
> > binds to the struct device and completes the initialization of the
> > device.
>
> ...
>
> >               pd_pdev->dev.of_node = np;
> > +             pd_pdev->dev.fwnode = of_fwnode_handle(np);
>
> Instead,
>
>                 device_set_node(&pd_dev->dev, of_fwnode_handle(np));

Ack


-Saravana
