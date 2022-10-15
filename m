Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12925FFB50
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJOQ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJOQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:56:16 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F4C4A82D;
        Sat, 15 Oct 2022 09:56:15 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id f22so5519726qto.3;
        Sat, 15 Oct 2022 09:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1kGMyZ8iPn6jxS1RJptkgeK4wGXJYpfTtGZVw/vNYE=;
        b=OAHyOVWJ3B+spXrMUUgSWBrY+EC9Woc50xcs4SbAgIQWmEvrgFtNQA61kkWkAcgat3
         utwNtoforuVZjEYZf99l0xQJ7tw7CrhNsRuN3hBXp2CVSK1Jrsxep/cAvqR4j9gdWDVo
         a3vpCX1zIda9WN2d1P//B4cUQjDVatMROYTtn1HtJw8w8RTNE6OzZ9vP/fWXvDNdVEMt
         6jDcqtKffiVqc4NYetaDFMBo1obMp63WmNFU8Fht7KQpw+KmANPX4bvor74eZFQ3lw4j
         PqHpO4bTF8QtlGyB83NBUySq67bc95f7/Aa2eelX58I7IKVS2BidI8Be91uNsH3xpVS7
         sAwQ==
X-Gm-Message-State: ACrzQf3UIGkkyuG91wvqcdS83T5a8kzh2cJk0WFAkiXx/7+2NJFZuitF
        0Fytlm8P/LbAKit1E8wOGLN00O6Qq53NX6KiRL0=
X-Google-Smtp-Source: AMsMyM5VpXNSDHG6hH+avu+LLqK1F1gCjNc62IhcpK3HG0VAkIbFT/UxIhJSbkA8ILrSffofXqNATnqaVHOyZGSQocM=
X-Received: by 2002:ac8:5ac1:0:b0:39a:123c:9df5 with SMTP id
 d1-20020ac85ac1000000b0039a123c9df5mr2595647qtd.27.1665852974906; Sat, 15 Oct
 2022 09:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
 <YzYowYJpRTImmg4m@google.com> <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
 <YzcqdTxLMF5028yz@smile.fi.intel.com> <YzcthIfnpi8E6XVk@google.com>
In-Reply-To: <YzcthIfnpi8E6XVk@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 15 Oct 2022 18:56:04 +0200
Message-ID: <CAJZ5v0iKXWBGYPmmg9__g3oHK2GhY+xFMnSA6c5KctOv2kTfNQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 7:55 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Sep 30, 2022 at 08:42:13PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 30, 2022 at 07:13:37PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> >
> > ...
> >
> > > I think that patches [5-8/13] from this series are significant
> > > framework changes, so it would make sense to route them via the ACPI
> > > tree.
> > >
> > > If this is fine with everybody, I will queue them up for merging into
> > > 6.1 (probably in the second half of the upcoming merge window).
> >
> > I believe it's fine from GPIO ACPI perspective (there shouldn't be conflict,
> > but if you wish you always may take this PR [1] to your tree (it's already in
> > GPIO tree pending v6.1), it may be considered as immutable tag.
> >
> > [1]: https://lore.kernel.org/linux-gpio/Yym%2Fj+Y9MBOIhWtK@black.fi.intel.com/
>
> Yeah, having an immutable branch hanging off 6.0-rcN would be awesome -
> I could pull it and this would avoid any potential conflicts later.

This material is in the mainline now, but the branch is still there in
case you need it:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-wakeup

It won't be necessary any more after 6.1-rc1 is out, though, I suppose.
