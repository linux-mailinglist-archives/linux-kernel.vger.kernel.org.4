Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C548B5F1096
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiI3RNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiI3RNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:13:50 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF5B1B0E2D;
        Fri, 30 Sep 2022 10:13:49 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id u28so3205539qku.2;
        Fri, 30 Sep 2022 10:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/wx9U+dObGcu3vd67LH5xUyn1SE13wYoTWeTVT1V/Xk=;
        b=GmKkzNK5uL1Yq9YhVBrtlyFfHYHzJ30VTNpFhc2tjyl9fQVRra5xt0pZWp1ndi2xG/
         M7ymwiGqZ6/HAOFONY3tRqiZHXeUKFFgXjLm9RgUxeR+AIecMdDUbHJcpH/9+HELjTLL
         7YsYvH/4Dj2ap8YFkpf6E66LPuDPoWvVZEQD9mP9rUGXc5roTM8zvsBK8/bGuwPZIu2c
         tf2BzAy9kz7f7VVNd2pzvctbctqb2E1TojqJj/1KPd/wjS2sHXlfKuRxvLX4RrNU+ilx
         u1oJNE0m6LtiN2d054+QkUgEJ1QRjWafcSfWkj3X47YRaPMQsq3q7Mkc9Dhfuk/XrViY
         5lzA==
X-Gm-Message-State: ACrzQf1Kk6bzs39kMfDTaJAaYE12HPY8WK/iJz6bDXa15zksI8QwoF7d
        XIhjYNLXFDRyxkr+IcunrBf1xvaFuIdJjfd3AWs=
X-Google-Smtp-Source: AMsMyM6JZ4b6gxDDEv2hOrUMsgceqPELInWBc5V8VaaTUwAfQPUvRJjifLHwS5Zy8GMSTiimX+3A1JeQCZkKLJlJsrQ=
X-Received: by 2002:a05:620a:4008:b0:6ce:8725:cb7 with SMTP id
 h8-20020a05620a400800b006ce87250cb7mr7047317qko.480.1664558028487; Fri, 30
 Sep 2022 10:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com> <YzYowYJpRTImmg4m@google.com>
In-Reply-To: <YzYowYJpRTImmg4m@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Sep 2022 19:13:37 +0200
Message-ID: <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul Rangel <rrangel@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Sep 29, 2022 at 03:20:12PM -0600, Raul Rangel wrote:
> > On Thu, Sep 29, 2022 at 1:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Sep 29, 2022 at 9:27 PM Raul Rangel <rrangel@chromium.org> wrote:
> > > >
> > > > On Thu, Sep 29, 2022 at 1:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 29, 2022 at 6:19 PM Raul E Rangel <rrangel@chromium.org> wrote:
> > > > > >
> > > > > > ACPI IRQ/Interrupt resources contain a bit that describes if the
> > > > > > interrupt should wake the system. This change exposes that bit via
> > > > > > a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> > > > >
> > > > > I would call this IORESOURCE_IRQ_WAKE which is (a) simpler and easier
> > > > > to read and (b) it sort of matches the "wakeirq" naming convention.
> > > >
> > > > It was Dmitry who originally suggested the name. I personally like the
> > > > CAPABLE in the name. It makes it clear that it's capable of acting as
> > > > a wake source, not to be confused with being enabled as a wake source.
> > >
> > > Well, so be it then.
> > >
> > > As I said elsewhere, I can apply this patch too if that's useful at this point.
> > >
> >
> > We just need to make sure the ACPI patches 5-8 land before the i2c
> > patches 9-13. The i2c patches 1-4 can land before or after the ACPI
> > changes. I'm not sure how things get coordinated across subsystems.
>
> I am fine with all input stuff going through ACPI tree to ease landing.
> Or I can pick up everything if Rafael and Jiri/Benjamin agree.

I think that patches [5-8/13] from this series are significant
framework changes, so it would make sense to route them via the ACPI
tree.

If this is fine with everybody, I will queue them up for merging into
6.1 (probably in the second half of the upcoming merge window).
