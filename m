Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF5F73393A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbjFPTHW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 15:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFPTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:07:20 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F5CC3;
        Fri, 16 Jun 2023 12:07:19 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9827714a479so31203566b.1;
        Fri, 16 Jun 2023 12:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686942438; x=1689534438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjd1Ph18xx56C7K7G9MOYBJwS203VPnnlb4VxXO3yFM=;
        b=ITqjTp3ob0FmIJZ0yDdOhYg887uH/7z9UFfISkN15YKJvV//kBj0GFnvQwtk7jyyii
         E8lOyNS17pP40TDXCSMwcGJ2FLg6rnkmkgXr+EPPDKwuKXLmXUNHQc51xmVBc0m/h/uG
         fn/uv6SznPL7WU0s2G+UoEdk4MoXcxx//PAnk65TSIe6GInL9ihh8+m5jQJ7tEBcE9BS
         LZX7uXkFPSQeGgqJ2vu79c9x/ygc4huTW93dmAhbJmF0GKm2PG8vlPddt8KgcsPTe9kZ
         bPU7CdRjzri3uwNWvNcecugwhK8EeXpxAu8onQPIyQkd1sw+T7rVR2OH3MSJWeTokeX+
         JJ9w==
X-Gm-Message-State: AC+VfDxzHJN5FPHG/mGryB/PU7UoCFDFCz+EUKEOntfaiufEZyPs+1xF
        vpktqMVqISqEhBRXMTEhHVRZSkwP9X6gDCdnlJE=
X-Google-Smtp-Source: ACHHUZ7XWd4rjaEriHBuTzP8gLIxEf/ycmpr0I5QZAZNPdGq8Vbs3N01fPyoxpwESBUM2Zk4oHB9ALiRGeEbKjFEEOE=
X-Received: by 2002:a17:906:11a:b0:94e:9efa:a9ed with SMTP id
 26-20020a170906011a00b0094e9efaa9edmr2594740eje.7.1686942437885; Fri, 16 Jun
 2023 12:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0hgNMWNtkAF7YY24cFvsnGYYYHMW1c4NekaNmyqYf=0tA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hgNMWNtkAF7YY24cFvsnGYYYHMW1c4NekaNmyqYf=0tA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jun 2023 21:07:06 +0200
Message-ID: <CAJZ5v0gX9h_Edj2aMcAvH=dvLTwg=+_aZbpcgbkz-8uK737SVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] device property: Introduce device_is_compatible()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 7:55 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jun 12, 2023 at 6:12 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Introduce a new helper to tell if device (node) is compatible to the
> > given string value. This will help some drivers to get rid of unneeded
> > OF APIs/etc and in may help others to be agnostic to OF/ACPI.
> >
> > While doing it, I have noticed that ACPI_DEVICE_CLASS() macro seems
> > defined in unsuitable location. Move it to the better one.
> >
> > Last patch is an example of what the first two are doing.
> >
> > The entire series can go, I believe, via ACPI (linux-pm) tree in case
> > the last patch gets tag from the respective maintainer.
> >
> > In v3:
> > - added tag to patch 1 (Rafael), patches 2&3 (Sakari)
> > - made commit message text wider in patch 3 (Sakari)
> >
> > In v2:
> > - updated commit message and added kernel doc for a new API (Greg)
> > - also replaced acpi_device_get_match_data() with the agnostic API
> > - tried to keep header inclusions ordered (to some extent)
> >
> > Andy Shevchenko (3):
> >   ACPI: Move ACPI_DEVICE_CLASS() to mod_devicetable.h
> >   device property: Implement device_is_compatible()
> >   ata: ahci_platform: Make code agnostic to OF/ACPI
> >
> >  drivers/ata/ahci_platform.c     |  8 ++++----
> >  include/linux/acpi.h            | 14 --------------
> >  include/linux/mod_devicetable.h | 13 +++++++++++++
> >  include/linux/property.h        | 12 ++++++++++++
> >  4 files changed, 29 insertions(+), 18 deletions(-)
> >
> > --
>
> All applied as 6.5 material, thanks!

But I see that Greg has taken it too, so I'll drop it.
