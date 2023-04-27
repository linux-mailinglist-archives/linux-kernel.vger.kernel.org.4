Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792306F0A47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbjD0QxZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjD0QxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:53:23 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E4710DC;
        Thu, 27 Apr 2023 09:53:22 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9594916df23so161287466b.1;
        Thu, 27 Apr 2023 09:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614401; x=1685206401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAAK43FYkSPDkbKb63f0rFAtXfzexYyx0WPl0XP2SNA=;
        b=iMbcqs3MmH4nHcsbfeoqWM54GEiLxoqxypMYenYLaxlXQJ7e6Z8u9oWz5YnBFJ1hTk
         ooiULehopR5xxXS3ZjP2eddOpo1p2RSukyCwt7EGPQHTgHwU9qyZldoHekRlojDMcjso
         tkhE+oGmiMnEX0UECdd8PH+zsbcWFf36y4RiIBMTmGC57uL3vSALn1G/Qtos2Xogm7uu
         IH/V8we1KXgFSRbZjukgsMpLRhBup2KcvQQnccWW7HOU2zt0tD1PM7jK0WEYSGet7oY3
         S1kgSUYh3Qv+RuDGT9ngS6uMUxgb0I2iMdZtmmBFgc6osIj+mRe/3pFrJcH14+1b7Fop
         QqBw==
X-Gm-Message-State: AC+VfDwpqKvxPRvPzerA2GJXawNGxudnAIKt8Klu8c/E0w8p6WCZQcC3
        s4wlZCx0Cfh5tk8EDV17f9cY+AjhQfgxpuKyyAeDQcrn
X-Google-Smtp-Source: ACHHUZ7NGjITqL/sy2iSIAPXZltOBWku1HfzRFNGpHkStaYyFxMoonQWvtsR8Jry6e1d5K3SsBgAQ9HfDcmTp2Uz6PI=
X-Received: by 2002:a17:906:738a:b0:94e:9235:d77d with SMTP id
 f10-20020a170906738a00b0094e9235d77dmr2207225ejl.0.1682614400728; Thu, 27 Apr
 2023 09:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230422164401.5986-1-mail@mariushoch.de> <5ff4416c-a195-7ac7-9eb1-16d667fd3ad6@redhat.com>
In-Reply-To: <5ff4416c-a195-7ac7-9eb1-16d667fd3ad6@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Apr 2023 18:53:09 +0200
Message-ID: <CAJZ5v0j7ZoGRAeASR1UtJTDANFHC=5VP7-5vSC-ouXozrwG6pw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: utils: Remove Lenovo Yoga Tablet 2's MAGN0001
To:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 7:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 4/22/23 18:44, Marius Hoch wrote:
> > The LSM303D on the Lenovo Yoga Tablet 2 series is present
> > as both ACCL0001 and MAGN0001. As we can only ever register an
> > i2c client for one of them, ignore MAGN0001.
> >
> > Currently this errors:
> > i2c i2c-4: Failed to register i2c client MAGN0001:00 at 0x1d (-16)
> >
> > Tested on a Lenovo Yoga Tablet 2 1051-F.
> >
> > Signed-off-by: Marius Hoch <mail@mariushoch.de>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.4-rc material, thanks!

> > ---
> >  drivers/acpi/x86/utils.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> > index ba420a28a4aa..9c2d6f35f88a 100644
> > --- a/drivers/acpi/x86/utils.c
> > +++ b/drivers/acpi/x86/utils.c
> > @@ -143,6 +143,16 @@ static const struct override_status_id override_status_ids[] = {
> >               DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
> >               DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
> >             }),
> > +
> > +     /*
> > +      * The LSM303D on the Lenovo Yoga Tablet 2 series is present
> > +      * as both ACCL0001 and MAGN0001. As we can only ever register an
> > +      * i2c client for one of them, ignore MAGN0001.
> > +      */
> > +     NOT_PRESENT_ENTRY_HID("MAGN0001", "1", ATOM_SILVERMONT, {
> > +             DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +             DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
> > +           }),
> >  };
> >
> >  bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status)
>
