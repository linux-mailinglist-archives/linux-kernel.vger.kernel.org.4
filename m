Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DB5BB553
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiIQBZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:25:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7183D3C8D5;
        Fri, 16 Sep 2022 18:25:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y8so26952093edc.10;
        Fri, 16 Sep 2022 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fKNu5JDDhhCBUD2J00caOEQEqr1oN52PVb8a7juWWHY=;
        b=cgurN0q1vqsd9sE1CFqcLw3KEU35OXRtz+Dmypuvkl0fPGHQkmNVKcfKgrnkmq7c5i
         j74JymNXC+ky8M3qRy2W+wpVjG81vof1tZjDzJkoJtndQnEHi/Zdw1P+miBUCOkEoMSB
         MnuJP9U1add5khOM1n5nXSP6JaXaJf3yZpBHahEcHMqWaf2H7VPWhitqPA4wMc3906LX
         t11XiPahDa3WeEr47Uj6MjrZHfxw99iTWPXYzWcNWkT/N0cZyGSukSCRtRwkETvm9km7
         DtndEw+2wedG16XVTSuH+09sdNWIl15bBnxHZTCbebJMLdCRgbxKlSaHbTnlIVjnYLQo
         rhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fKNu5JDDhhCBUD2J00caOEQEqr1oN52PVb8a7juWWHY=;
        b=IkL6tRhnfDJUY27p46UAsll7lnliawhdhWiszyOozM7cA4RYHshea0avMsSRHCjxbR
         9/BIpPInVxdccrpq4ZC5W8Iu6u7HY3Rmc8bPS+CuFos+MTx7ZlCPtWnt9CQMAyzEofk/
         cP1C2Q1D62+cGUsRN+IyV9DNmAc/EYM1WHkOYAy0zB83I9iYhsBieQHibgt03IprmTAh
         I5QdF1pBIle5yAWj5+OZqL9wEMtErI3bqoT+aV1XU6zs4zLu0qal1nqVjm8SPjWLxdyH
         gSAYCxGwSwbt/iMHAqTkbzDWrYw2hUvJrpC4rTsMFE/PvSK8++ekajWSlSiYtcS3ICMY
         fdMw==
X-Gm-Message-State: ACrzQf04Vmb52Nza3fHpTm0IP2KKxfV29MJXLJSZWGmkMbi5xPlrMF08
        bUaV7eZJzc4uxSFzRp2+wuceD9Q4BmlzeWGLqns3BpPn6/E=
X-Google-Smtp-Source: AMsMyM4jcYB5nV1Sr49WF/7mMPPzVYSFioSKIRSngFeDx6zLx00DTUfAQU516/dfW4JSbQhvy3UDBaaQFD8H0TMdEHk=
X-Received: by 2002:aa7:d51a:0:b0:453:9086:fc37 with SMTP id
 y26-20020aa7d51a000000b004539086fc37mr1649732edq.174.1663377918891; Fri, 16
 Sep 2022 18:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220902074144.2209674-1-floridsleeves@gmail.com> <CAJZ5v0jXjmgV8vAVgJzVfmPKFXOPbeXYojxOnqKQu4wukFSt-A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jXjmgV8vAVgJzVfmPKFXOPbeXYojxOnqKQu4wukFSt-A@mail.gmail.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Fri, 16 Sep 2022 18:25:07 -0700
Message-ID: <CAMEuxRq=G0zrCkefQL1CZFRw4WocRic4yKjrmKerK3ugGMXOYA@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/acpi/acpi_video: check return value of acpi_get_parent()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Sep 10, 2022 at 9:17 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Sep 2, 2022 at 9:42 AM Li Zhong <floridsleeves@gmail.com> wrote:
> >
> > Check return status of acpi_get_parent() to confirm whether it fails.
> >
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > ---
> >  drivers/acpi/acpi_video.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 5cbe2196176d..5fca9a39b1a4 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0-or-later
> > +       // SPDX-License-Identifier: GPL-2.0-or-later
>
> This change surely is not intended?
>
> >  /*
> >   *  video.c - ACPI Video Driver
> >   *
> > @@ -1753,6 +1753,7 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
> >         int result;
> >         static int count;
> >         char *name;
> > +       acpi_status status;
> >
> >         result = acpi_video_init_brightness(device);
> >         if (result)
> > @@ -1766,8 +1767,9 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
> >                 return;
> >         count++;
> >
> > -       acpi_get_parent(device->dev->handle, &acpi_parent);
> > -
> > +       status = acpi_get_parent(device->dev->handle, &acpi_parent);
> > +       if (ACPI_FAILURE(status))
> > +               return;
>
> But device->dev->handle is known to be valid, so the only case in
> which acpi_get_parent() above can fail is when the given namespace
> object has no parent, in which case acpi_parent will be NULL, so that
> should be caught my the check below, shouldn't it?
>
> >         pdev = acpi_get_pci_dev(acpi_parent);
> >         if (pdev) {
> >                 parent = &pdev->dev;
> > --

That makes sense. Thank you!
