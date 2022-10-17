Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3C36011BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJQOyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiJQOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D134D691AB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:53:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y8so11278742pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jveD8Fr76glp1DYxH8RBX8//jU+rwCCAw4goKV+WEYA=;
        b=UJIoHx/gk4qgZaNeRdbeKXp0RWtmWsifoNxgVvBVZKdSitOOLM8ii0b5MMfBMYzdY2
         OrEpEtj7HKemElQL9lCXKCVZrZD1jDtjbVsrQnOtOUOPW2Ny+9R8g/0uALspK835lnWR
         fWGTsdbdlq1DJI8l3MHLMVIF7b/28sgZW9zZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jveD8Fr76glp1DYxH8RBX8//jU+rwCCAw4goKV+WEYA=;
        b=EraVMA/PdMXvW6EjwuxSn6kBMaX6YMM8SGhUtGNqT6bd2R/o2SXrAz2QQuZ18EqgK1
         3DE9D8KXtbyjmUpEP8oPF5piGKluCPJJO67NEDKDxC+s5M2bKmHkKznTWKpXfBsuxPUT
         ImjROSbeZnQQViMrD8lvjco+2ogawGx9I0Cgh8NW109m2a3nqCYZBMrQ0AIxHPf3ZuXT
         sAuNRq9OKvhRC6LeSm7+LIYXOuA+0TgK5y4H/XZPA9jaWqYKkKDEPApQoM9iwELk0YtN
         L6pQrkJHUPaA2ZwEyvUkGYodwn3xK7WkZiWQg4w2Tmzf2vPAwe0rzWHmE06i2oeoUzoi
         gQww==
X-Gm-Message-State: ACrzQf1OunWBpTsvTjT3ztkFtvj9L5AXFd40sjeFsk2uM76o7TWpeOSq
        fBKHD1dHFulnjfaFvmX8iaXErZCtheA8IQ==
X-Google-Smtp-Source: AMsMyM7hwZwG5Glqm9U3KESulHPa/1vdt6kNykCGxK8qLJ8XtiAfEjejTmFP2egdQUPEanpSVJzgfw==
X-Received: by 2002:a05:6a02:202:b0:42b:d711:f27c with SMTP id bh2-20020a056a02020200b0042bd711f27cmr10917165pgb.246.1666018424445;
        Mon, 17 Oct 2022 07:53:44 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id w4-20020a17090a6b8400b0020d6fc00072sm9895733pjj.9.2022.10.17.07.53.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 07:53:42 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id 67so11291954pfz.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:53:42 -0700 (PDT)
X-Received: by 2002:a63:1326:0:b0:439:40b5:77cc with SMTP id
 i38-20020a631326000000b0043940b577ccmr11277758pgl.473.1666018421795; Mon, 17
 Oct 2022 07:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
 <YzYowYJpRTImmg4m@google.com> <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
 <YzcqdTxLMF5028yz@smile.fi.intel.com> <YzcthIfnpi8E6XVk@google.com> <CAJZ5v0iKXWBGYPmmg9__g3oHK2GhY+xFMnSA6c5KctOv2kTfNQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iKXWBGYPmmg9__g3oHK2GhY+xFMnSA6c5KctOv2kTfNQ@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 17 Oct 2022 08:53:29 -0600
X-Gmail-Original-Message-ID: <CAHQZ30D0NmVytkmiVYYZdGMEOChsO93hYRrG6SNbFiRO4S=YGA@mail.gmail.com>
Message-ID: <CAHQZ30D0NmVytkmiVYYZdGMEOChsO93hYRrG6SNbFiRO4S=YGA@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 10:56 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Sep 30, 2022 at 7:55 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Sep 30, 2022 at 08:42:13PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 30, 2022 at 07:13:37PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > ...
> > >
> > > > I think that patches [5-8/13] from this series are significant
> > > > framework changes, so it would make sense to route them via the ACPI
> > > > tree.
> > > >
> > > > If this is fine with everybody, I will queue them up for merging into
> > > > 6.1 (probably in the second half of the upcoming merge window).
> > >
> > > I believe it's fine from GPIO ACPI perspective (there shouldn't be conflict,
> > > but if you wish you always may take this PR [1] to your tree (it's already in
> > > GPIO tree pending v6.1), it may be considered as immutable tag.
> > >
> > > [1]: https://lore.kernel.org/linux-gpio/Yym%2Fj+Y9MBOIhWtK@black.fi.intel.com/
> >
> > Yeah, having an immutable branch hanging off 6.0-rcN would be awesome -
> > I could pull it and this would avoid any potential conflicts later.
>
> This material is in the mainline now, but the branch is still there in
> case you need it:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-wakeup
>
> It won't be necessary any more after 6.1-rc1 is out, though, I suppose.

Awesome, thanks for merging in the ACPI patches!
