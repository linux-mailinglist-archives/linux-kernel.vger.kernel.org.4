Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120696349E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiKVWNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiKVWNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:13:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EE832066;
        Tue, 22 Nov 2022 14:13:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so187381pjh.2;
        Tue, 22 Nov 2022 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AX85xZR/Z+/BFidSsN8cuPlIss1GzSZ5O8aUvSnWk0=;
        b=qtAroXIgR/kdmdgCvSWoRUBWUO7Q0R2oetA+DSgo8Im+qMa/WgDIzDI593eVDOfjmp
         /YNDGl7b6PbGXNqPzfD0FYgqkIGyDLdO86xQISGNXBMAGCXQuwwtVGVVEez+EP+fv2YT
         zEQKRaATTkqUxQrcsN0JxSecjm28Y7LeWESKEVAyR9T/wWVJF8MbJvxjjbNRQ2D+aCP3
         kyuy2Nz8vKEQvRzjE6We5EvrQZh7e5sd8wWjPyBazcOmKlUC/RA83uyT7heG/aZy8O8t
         QOUrE61bK1vgJYcSRRaY5D2iOxjwH6flA1rp/3fPzc5EB3D0BNxCi6I04NseacqdYRTz
         v75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AX85xZR/Z+/BFidSsN8cuPlIss1GzSZ5O8aUvSnWk0=;
        b=q0Fi4Ia0h0dgHRK03X1yF1Z8NwuxPrtSymaj1n+mbTSH66Kf1xKAZfDvApm6mHNPwu
         MJ2x02FMF2GFRfSmqbQMth8ctr3wFnIqV1AU3sih2h44qJ8MkgK5029/z7HzeVD2HBIP
         1NHvYFw5Ibhueu+I7KTHq6NA/5+Bktl8JeO+r5TduDxDSbifsLS/oD1HGtlIfrQk35Nk
         MavUxNn/iAo7fdWwe5x/y4b11EnwuyhPoWrmmfy8+lFaYo/XLRL++oc12pirV5Ll04c0
         LxS/P4NjKKGSgTWbhlrcDIyAOyUL3sv0mnWW8bt7AhF0C2R1IFJGuEyOLNaOurFK9HSL
         V8WQ==
X-Gm-Message-State: ANoB5pliJ2ugPGUI8r0Oq52Y5oy4PPx9E2UiXHxfnKQkNx7+KgNmNgMF
        MmP7Wya2k1uOFORcbFv4QAc=
X-Google-Smtp-Source: AA0mqf7SSV5Spx3SdIMHV/m3SHtcgR2doOiXV0pHeCoiNsvfzayliCTA8GTupUvJ8yUHKFE/rHkUJA==
X-Received: by 2002:a17:90a:e2c5:b0:214:1648:687d with SMTP id fr5-20020a17090ae2c500b002141648687dmr34036143pjb.78.1669155199951;
        Tue, 22 Nov 2022 14:13:19 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902868600b0018703bf42desm12536214plo.159.2022.11.22.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:13:18 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:13:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
        llvm@lists.linux.dev, Alexis Savery <asavery@google.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to
 acpi_dev_irq_flags
Message-ID: <Y31JezKDlQjmld03@google.com>
References: <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
 <YzYowYJpRTImmg4m@google.com>
 <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
 <YzcqdTxLMF5028yz@smile.fi.intel.com>
 <YzcthIfnpi8E6XVk@google.com>
 <CAJZ5v0iKXWBGYPmmg9__g3oHK2GhY+xFMnSA6c5KctOv2kTfNQ@mail.gmail.com>
 <CAHQZ30D0NmVytkmiVYYZdGMEOChsO93hYRrG6SNbFiRO4S=YGA@mail.gmail.com>
 <CAHQZ30D-vBHQG9tDXy_upKHzfFMA9ttUT72K4hqKNS+CtEek3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQZ30D-vBHQG9tDXy_upKHzfFMA9ttUT72K4hqKNS+CtEek3w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:36:07AM -0700, Raul Rangel wrote:
> On Mon, Oct 17, 2022 at 8:53 AM Raul Rangel <rrangel@chromium.org> wrote:
> >
> > On Sat, Oct 15, 2022 at 10:56 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Sep 30, 2022 at 7:55 PM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 30, 2022 at 08:42:13PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Sep 30, 2022 at 07:13:37PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
> > > > > > <dmitry.torokhov@gmail.com> wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > I think that patches [5-8/13] from this series are significant
> > > > > > framework changes, so it would make sense to route them via the ACPI
> > > > > > tree.
> > > > > >
> > > > > > If this is fine with everybody, I will queue them up for merging into
> > > > > > 6.1 (probably in the second half of the upcoming merge window).
> > > > >
> > > > > I believe it's fine from GPIO ACPI perspective (there shouldn't be conflict,
> > > > > but if you wish you always may take this PR [1] to your tree (it's already in
> > > > > GPIO tree pending v6.1), it may be considered as immutable tag.
> > > > >
> > > > > [1]: https://lore.kernel.org/linux-gpio/Yym%2Fj+Y9MBOIhWtK@black.fi.intel.com/
> > > >
> > > > Yeah, having an immutable branch hanging off 6.0-rcN would be awesome -
> > > > I could pull it and this would avoid any potential conflicts later.
> > >
> > > This material is in the mainline now, but the branch is still there in
> > > case you need it:
> > >
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > >  acpi-wakeup
> > >
> > > It won't be necessary any more after 6.1-rc1 is out, though, I suppose.
> >
> 
> >
> > Awesome, thanks for merging in the ACPI patches!
> 
> Dmitry,
>  What are the next steps to getting the I2C patches landed? Should I
> push out a new series that's rebased on 6.1-rc1?

Everything should be applied now and will be in 6.2.

Thanks.

-- 
Dmitry
