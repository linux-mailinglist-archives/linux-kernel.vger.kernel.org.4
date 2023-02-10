Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFDD691E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjBJLgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjBJLgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:36:13 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5140E233CF;
        Fri, 10 Feb 2023 03:36:12 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-16aa71c1600so6243773fac.11;
        Fri, 10 Feb 2023 03:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TboQQzoO+DB2tudXmL0VoYEafVQP7KOEkR8OjKkKyi4=;
        b=DAxdjoIWihc6/4Ci+X1kQo+m90XHZSRxwoPQcz8baTZLQf2AUElFbermnTOWaf6NQG
         MyUFh1RAQ2CegihtUXZsIFyRz+VGaiHVl3CFpLQpm+T7qi96t7b8R3iTx1NdJxPQ/v3y
         /dRCg1uKM6ujl/QPBBA2+AjbysUdFWt/yRmoMUR4e/U/WuaJpFTKwl/YTVMenPjcE3Vy
         D+QPJQlacpsLQbxfHo3Yi+Vx52MQks4Y53HIXRFx3dND7xCSMe0ttpIk7RkiiDsPugxo
         DJ6FVzIIfhZ5VcRuCErijJg7YEGK7UKuX7YaH7vT9bdL9CtIYwxV6YxQX1MJ3ie3DVd+
         0yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TboQQzoO+DB2tudXmL0VoYEafVQP7KOEkR8OjKkKyi4=;
        b=TXrrDi4JXhVvqOdafv0O25rIRZ+Mp0PBZiQhLdIyKKSq37Fa3pD9CC17QLpLd5Q0Ev
         c1TPGbrUlJafntTkHQXwICXaxzjv4JA2btS0L9LQ4oybLNI7Fl4cmwEutE8t0r3T4Ieo
         xYsOvno5K79vH0Gk8AeNjzqkAN/wMK67W5i2XErfXnJrwpHYbWIj3xaaNOxRUcWqhTEG
         APkO0w+cn3CSdqgDdVEl5vBOVkMW9qbVVeXVpsDFWU+sBc/T63JJfjScMMBK3JPK5EgH
         +RleXbbwHDMLYerh85KZAK30+uqJ9K0E+tEga1ULDUJJJ3FsXqZe/hlf77WHP8xdcJ66
         m2Qw==
X-Gm-Message-State: AO0yUKXd+/dHLykdv8u5NDX/2kcqzb72gVv+bEbv+HdJ/hPFEepeX1+K
        YJV9seu7XerndLRdn42CaooZjZlkEVBNu3lUI80=
X-Google-Smtp-Source: AK7set8L0VR/tq7/utba6z1b5OC1F5KsVo0lRmwzZoq7V2gRlcQC0espZ1c74jDNcJAGsrHOuQVylC1WmbcpCN3XiwI=
X-Received: by 2002:a05:6870:63a2:b0:16a:a8b5:16fe with SMTP id
 t34-20020a05687063a200b0016aa8b516femr1400348oap.144.1676028970841; Fri, 10
 Feb 2023 03:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
 <20230210065621.598120-4-sergio.paracuellos@gmail.com> <21af8c63-f489-8c3f-e1e3-cf976b1d20d0@linaro.org>
In-Reply-To: <21af8c63-f489-8c3f-e1e3-cf976b1d20d0@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 10 Feb 2023 12:35:59 +0100
Message-ID: <CAMhs-H8O634ZbRW7BVkQmTA=B7p3Osu6d9hFGZ7DqXtXydkHBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] watchdog: mt7621-wdt: avoid globals and arch dependencies
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Feb 10, 2023 at 12:02 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 07:56, Sergio Paracuellos wrote:
> > MT7621 SoC has a system controller node. Watchdog need to access to reset
> > status register. Ralink architecture and related driver are old and from
> > the beggining they ar providing some architecture dependent operations
> > for accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
> > header file. However this is not ideal from a driver perspective which can
> > just access to the system controller registers in am arch independent way
> > using regmap syscon APIs. Hence, add a new structure for driver data and
> > use it along the code. This way architecture dependencies and global vars
> > are not needed anymore. Update Kconfig accordingly to select new added
> > dependencies and allow driver to be compile tested.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/watchdog/Kconfig      |   4 +-
> >  drivers/watchdog/mt7621_wdt.c | 121 ++++++++++++++++++++++------------
> >  2 files changed, 83 insertions(+), 42 deletions(-)
> >
>
>
> > -
> >  static int mt7621_wdt_probe(struct platform_device *pdev)
> >  {
> > +     struct device_node *np = pdev->dev.of_node;
> >       struct device *dev = &pdev->dev;
> > -     mt7621_wdt_base = devm_platform_ioremap_resource(pdev, 0);
> > -     if (IS_ERR(mt7621_wdt_base))
> > -             return PTR_ERR(mt7621_wdt_base);
> > +     struct watchdog_device *mt7621_wdt;
> > +     struct mt7621_wdt_data *drvdata;
> > +     int err;
> > +
> > +     drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +     if (!drvdata)
> > +             return -ENOMEM;
> >
> > -     mt7621_wdt_reset = devm_reset_control_get_exclusive(dev, NULL);
> > -     if (!IS_ERR(mt7621_wdt_reset))
> > -             reset_control_deassert(mt7621_wdt_reset);
> > +     drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "ralink,sysctl");
> > +     if (IS_ERR(drvdata->sysc))
> > +             return PTR_ERR(drvdata->sysc);
>
> You claim in commit title that you remove some global usage, but you add
> here several new features and refactor the code significantly. You need
> to split refactorings, improvements from completely new features. The
> entire patch is very difficult to understand in current form.

I am removing global usage and architecture dependencies using a
watchdog driver data structure so I thought the changes were easy
enough to review in this way. It seems they are not according to your
reply :). If preferred I can split this in two commits:
- Avoid globals using and introducing all the related new driver data
structure.
- Add request for regmap syscon from the phandle and remove the
architecture dependent calls and includes.

Thanks in advance for your comments.

Best regards,
    Sergio Paracuellos

>
> Best regards,
> Krzysztof
>
