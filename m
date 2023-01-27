Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1B67DEE1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjA0IME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjA0IMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:12:02 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D186761FB;
        Fri, 27 Jan 2023 00:11:58 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id ll10so2245757qvb.6;
        Fri, 27 Jan 2023 00:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBAPOHYTkWiPLnj81NzCswXH0Y6077YYaFE4ZOx/zRY=;
        b=cSJYl8O2nDpMg/CA3iceMsy1oxQllQ9Gjg9Nmq6jJ+kPrr71GxU5PxeL5DfGt3zDfa
         gPWuMZ3zzRic0MJOJj0flpXENXbJ/OobiqOD0JvpCHn8ift85z/WN5i/QgzRiPA5hLPM
         T2HEq8Kwkk2eZ3iP3pFF8GllTOLzR0s0cvAPUBAsVGuEdCWMWMeIkplPIRK8pHdQYe6l
         PiKsuN/lDJ203Wb1mNcQ4y/1RubjH2mQ8pAf0YL2H7BfEHz8otvTonhIBEEVjQBLIQlQ
         hb/D8yWbwg5rx0mxa1jhaJaCT7iugdUs2vsOlbMTNeFjQkNFXE82Ncf7I2C8yF8XxQIh
         bveA==
X-Gm-Message-State: AO0yUKVFCiFEgINkl1Y5vLuqV6A25a2jfGBmvxfvgrjaROJJ7JKy1bO3
        PKze7f9gQjFmi6bkda7L0W1+DoAsUoqj6AZW
X-Google-Smtp-Source: AK7set9Bz62Q67ABrWdM7KPzU8QFgHRgxZTAr85sdaX8Gw1YpZ3MjQxtUT3lWXRtAgamQxPpSzFeGA==
X-Received: by 2002:ad4:48d1:0:b0:537:727f:ac2b with SMTP id v17-20020ad448d1000000b00537727fac2bmr13020372qvx.41.1674807117361;
        Fri, 27 Jan 2023 00:11:57 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id p25-20020a05620a22b900b00706c1f7a608sm190589qkh.89.2023.01.27.00.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:11:57 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-4fda31c3351so56901947b3.11;
        Fri, 27 Jan 2023 00:11:57 -0800 (PST)
X-Received: by 2002:a25:37d4:0:b0:80b:8602:f3fe with SMTP id
 e203-20020a2537d4000000b0080b8602f3femr1568499yba.36.1674807106088; Fri, 27
 Jan 2023 00:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-4-saravanak@google.com>
In-Reply-To: <20230127001141.407071-4-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Jan 2023 09:11:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV4B49OM7S-UAxJtfAR8OvG_-S526fGnTA+t+-orytrTw@mail.gmail.com>
Message-ID: <CAMuHMdV4B49OM7S-UAxJtfAR8OvG_-S526fGnTA+t+-orytrTw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] soc: renesas: Move away from using OF_POPULATED
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Fri, Jan 27, 2023 at 1:11 AM Saravana Kannan <saravanak@google.com> wrote:
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

Thanks for your patch!

> --- a/drivers/soc/renesas/rcar-sysc.c
> +++ b/drivers/soc/renesas/rcar-sysc.c
> @@ -437,7 +437,7 @@ static int __init rcar_sysc_pd_init(void)
>
>         error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
>         if (!error)
> -               of_node_set_flag(np, OF_POPULATED);
> +               fwnode_dev_initialized(&np->fwnode, true);

As drivers/soc/renesas/rmobile-sysc.c is already using this method,
it should work fine.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

>
>  out_put:
>         of_node_put(np);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
