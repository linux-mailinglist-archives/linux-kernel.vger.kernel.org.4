Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB75EFE18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiI2Ti1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiI2TiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:38:23 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD4718B4B4;
        Thu, 29 Sep 2022 12:38:18 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id s18so1432190qtx.6;
        Thu, 29 Sep 2022 12:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jPC3WVw4976dpKvKKCFdU/lc0ZuMPbNLKCqStUeM09s=;
        b=Bn8uRgVhbpOL9LXoGIjhCC3rG4s+CBBtqpxyR/+L0Frr5ryxCtUdsCM9ZWVlEjewS8
         ec5HW8TwFAglYQB+WIjWcHdArOn1H80adwV+KA5ymx6fGJOP/w2GSiKF0xnZhpt1u9ij
         Kt1imFFhSiL//fAn4D3clrrNd+EOWo3HQzq85m/G9FYN51mkuvXAsYhy+SDeVnvulPO8
         BXt3WtIwOpVs5pwrKIq+q35dzggwEb8H2LWzL+wE7lXJkuEDK0Hug1ECWR4K4T74q+dg
         4KhBJyqLuLKdSf+vJtWwDNGJDdZle3Wz45UZe6o0+9zrKGawmMo0cXsunv6Fed+nwmlo
         6mIA==
X-Gm-Message-State: ACrzQf0BCiNtkIEZsWmvdo+ZMrTvLw3ePElP59zravTvwRRcj27zBd6C
        L7SbhcXnXhJj4WaNiCkrjQywZBWpHx3Fh4BVa3w=
X-Google-Smtp-Source: AMsMyM5G7CeP5pzAjJNsf6JlxYv6iJeuEdMrT888CC84awqhVlhiietKyxD+8M2ROSANmCXZJIPVS8Qujfwyj3EdZ4k=
X-Received: by 2002:a05:622a:64e:b0:35d:5213:284f with SMTP id
 a14-20020a05622a064e00b0035d5213284fmr3863424qtb.49.1664480297559; Thu, 29
 Sep 2022 12:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com> <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
In-Reply-To: <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Sep 2022 21:38:06 +0200
Message-ID: <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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

On Thu, Sep 29, 2022 at 9:27 PM Raul Rangel <rrangel@chromium.org> wrote:
>
> On Thu, Sep 29, 2022 at 1:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Sep 29, 2022 at 6:19 PM Raul E Rangel <rrangel@chromium.org> wrote:
> > >
> > > ACPI IRQ/Interrupt resources contain a bit that describes if the
> > > interrupt should wake the system. This change exposes that bit via
> > > a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> >
> > I would call this IORESOURCE_IRQ_WAKE which is (a) simpler and easier
> > to read and (b) it sort of matches the "wakeirq" naming convention.
>
> It was Dmitry who originally suggested the name. I personally like the
> CAPABLE in the name. It makes it clear that it's capable of acting as
> a wake source, not to be confused with being enabled as a wake source.

Well, so be it then.

As I said elsewhere, I can apply this patch too if that's useful at this point.

> >
> > This is not a big deal if you insist on this name and for a good
> > reason, but just something I would do differently.
> >
> > The patch LGTM otherwise.
> >
