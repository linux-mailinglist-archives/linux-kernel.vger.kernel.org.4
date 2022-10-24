Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24B660B3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJXRVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiJXRUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:20:36 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF618E09A8;
        Mon, 24 Oct 2022 08:55:29 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id s17so6286319qkj.12;
        Mon, 24 Oct 2022 08:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9JNURUXQEdoailh8cSWsW1gqRLK/OiiBgpx3G6yCs4=;
        b=ESqwTw8fL4Z+rrOKFuq9eK/iFx0KQ0htWC7PLF2FyMCyTL7E8HqT41/aSRpawiM4fA
         ey06v2mJWG3I+17QoSrK3r1D2+eFYEcg9A0GZbJO7VSXBMzLd8fGs0XDZG9xatDtf2KS
         6AoR6F4nkwW4LCNg0Q9VbSX/lQgL41BzOFsH0pL17IEpA1R1zrll/IxICi3m7gY/KzXF
         tNjwtrLMHCjufQOQDAH96B/nRqoJcALCujw/dPQEPTljjCatWX0DfvkynREUjqaVf2+J
         gxMXhLKfzKv0xX+DV7EDm/e/p8Ya3GSiRV8w1aJIdxUI5VsukSH0zaAVuusKbNMPRSh4
         mmWQ==
X-Gm-Message-State: ACrzQf0Wj+F3qTv44aDa7Y5FYI3Iy871hgJN4ch6wH321t3HXnZe41rM
        BQW5t0TFxlm+UbQmjJFF9LbvHEut5PJTrEA4TmQRetFx
X-Google-Smtp-Source: AMsMyM5SGXDg7cTE4lSjEiW49oL5yy1bPzXNvArWudgdK+XShf3cJ3UksyBK75y9XAWqp8MXMLDTd7Nhsr5DfB5EEyc=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr23009768qkl.443.1666622720212; Mon, 24
 Oct 2022 07:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221024141210.67784-1-dmitry.osipenko@collabora.com> <dda4b024-69d2-1d1d-da23-e922e5b6128a@redhat.com>
In-Reply-To: <dda4b024-69d2-1d1d-da23-e922e5b6128a@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Oct 2022 16:45:09 +0200
Message-ID: <CAJZ5v0irmk3aAK9t3UYcus+SXDL+AaT88LPXfyJU2PrXbkgfMg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Fix missing native backlight on Chromebooks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, kernel@collabora.com,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 4:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 10/24/22 16:12, Dmitry Osipenko wrote:
> > Chromebooks don't have backlight in ACPI table, they suppose to use
> > native backlight in this case. Check presence of the CrOS embedded
> > controller ACPI device and prefer the native backlight if EC found.
> >
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Fixes: 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native() helper")
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >
> > Changelog:
> >
> > v2: - Added explanatory comment to the code and added check for the
> >       native backlight presence, like was requested by Hans de Goede.
>
> Thanks this version looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Rafael, can you pick this up and send it in a fixes pull-req
> for 6.1 to Linus? Or shall I pick this one up and include it
> in my next pull-req?

It would be better if you could pick this up IMV, so please free to add

Acled-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it.

Thanks!

> >
> >  drivers/acpi/video_detect.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> > index 0d9064a9804c..9cd8797d12bb 100644
> > --- a/drivers/acpi/video_detect.c
> > +++ b/drivers/acpi/video_detect.c
> > @@ -668,6 +668,11 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
> >       { },
> >  };
> >
> > +static bool google_cros_ec_present(void)
> > +{
> > +     return acpi_dev_found("GOOG0004");
> > +}
> > +
> >  /*
> >   * Determine which type of backlight interface to use on this system,
> >   * First check cmdline, then dmi quirks, then do autodetect.
> > @@ -730,6 +735,13 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
> >                       return acpi_backlight_video;
> >       }
> >
> > +     /*
> > +      * Chromebooks that don't have backlight handle in ACPI table
> > +      * are supposed to use native backlight if it's available.
> > +      */
> > +     if (google_cros_ec_present() && native_available)
> > +             return acpi_backlight_native;
> > +
> >       /* No ACPI video (old hw), use vendor specific fw methods. */
> >       return acpi_backlight_vendor;
> >  }
>
