Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25EA5F1132
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiI3RyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiI3RyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:54:13 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F162D74E;
        Fri, 30 Sep 2022 10:54:12 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id r20so3114698qtn.12;
        Fri, 30 Sep 2022 10:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HELMaTyjtjhoi6PlS/lrYVTcmHlgwprNubgdTucekMw=;
        b=lMBTBFpxvvg+nwLVDWMdO6LUexKAEEjLGuoj0eawq5XtcEGp9NJAO75FAav1Gu86l1
         6uZ9m8CVyCzQxp/3aXiuVSSpTrPMyfY/uGW46qohlR2TvWBOiMM5TIJEcdCXE9q+7eS1
         Z6DT3oAxmB8DnlLAw0yGBIvSj5t2KU8tfPJfxGUvJZCJlZISm7HmaCCGccrvt/y/RgaL
         Q20E1atx4isaSm05/yz0Ygo6Ks7O721uXxQ/Q7wPXS/KaGx1FAxFdhcp9E/aqw84pqw5
         2yvXKsoYeXzZ3E5VVYYikQg5dfqNdkQxxQ9S8GhRVdzIDwMIv1PqRt9YmkZBoqURlaEp
         J2Pg==
X-Gm-Message-State: ACrzQf28n8T4S8zq+K86NUcTtnh9aoMGRXjfUtrP7ky+Zk8ld5CZ+bpU
        cFyBIM158XbWi8+DYjYWMgZfdIca9aQqAbtPQP8=
X-Google-Smtp-Source: AMsMyM6gUKsfNdNlP0krr+unzlH0ZtWUYXzYLAgQBWxCiR/BoWt2ZuPLZvK19ukpMbjR+S3MhzBOSlW6W9ac9cM3Tlw=
X-Received: by 2002:a05:622a:64e:b0:35d:5213:284f with SMTP id
 a14-20020a05622a064e00b0035d5213284fmr7809313qtb.49.1664560451538; Fri, 30
 Sep 2022 10:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
 <YzYowYJpRTImmg4m@google.com> <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
 <YzcqdTxLMF5028yz@smile.fi.intel.com>
In-Reply-To: <YzcqdTxLMF5028yz@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Sep 2022 19:54:00 +0200
Message-ID: <CAJZ5v0jE+53MZrPL9F_=f89cJHW8CPHPRM8PXb-i9DK8Ln=iDg@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 7:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 30, 2022 at 07:13:37PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
>
> ...
>
> > I think that patches [5-8/13] from this series are significant
> > framework changes, so it would make sense to route them via the ACPI
> > tree.
> >
> > If this is fine with everybody, I will queue them up for merging into
> > 6.1 (probably in the second half of the upcoming merge window).
>
> I believe it's fine from GPIO ACPI perspective (there shouldn't be conflict,
> but if you wish you always may take this PR [1] to your tree (it's already in
> GPIO tree pending v6.1), it may be considered as immutable tag.
>
> [1]: https://lore.kernel.org/linux-gpio/Yym%2Fj+Y9MBOIhWtK@black.fi.intel.com/

Thanks for the pointer!
