Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED56E6456E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLGJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiLGJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:54:37 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043410041;
        Wed,  7 Dec 2022 01:54:37 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id jr1so15765384qtb.7;
        Wed, 07 Dec 2022 01:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3f+gdO/l4zoXmHbMZWEeq0qWLxYGubzRtoW6X4DXRo=;
        b=gPIsHfSaSpXVT/nShN4nSlCaIULuB6/a5WkBraXTPAdIRa1hr0qq5Ou7GK+QAOMEl8
         OYe2tw/DbEFd9zKn9QW6cfu+aqt6hioYFRZIK47xp8wHHDQmCugOkVExMLT7gtb6qISV
         BHV6WSnFJeky6gS2YHeuv1tp+s7LDVIVvawevCIzJN4L37N7WhzqIna8reFDGWRvT/ce
         BFThJ7IDpNW0NysAwLAYCEoovT8+tOe852bU3uXt4KP4dJhvVrhk2vT2M9euFs/SM1bB
         zwI0KHQ3XbXiaQHQlPNU3rP1D0v3IGJLOIr0YMqkmyvikQ5FqMSqG9+JKm3Uib+gbcoq
         PUqw==
X-Gm-Message-State: ANoB5pm0SMevoPvEJ4zjO3VtJBHz6TAAYwimIKuHdzsHyCOaxs9RDnae
        y85buTdImXu6cj8NIyuwoJCByT6JwkWfhlCJD7I=
X-Google-Smtp-Source: AA0mqf6whBmeuVF8x+kNNAo3AW4sEpx6bH08ItOsijasUfPje2VhzUPvs3yXVbAOdgL/hCX7rnwqGxso6OrltV/hkS0=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr83109409qtb.147.1670406876197; Wed, 07
 Dec 2022 01:54:36 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
 <4809717.31r3eYUQgx@kreacher> <CAO-hwJJkWOn3N-UrhjFxiKh7jxPk_BLeL-wj6fnD+mcgHMEHfg@mail.gmail.com>
In-Reply-To: <CAO-hwJJkWOn3N-UrhjFxiKh7jxPk_BLeL-wj6fnD+mcgHMEHfg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 10:54:25 +0100
Message-ID: <CAJZ5v0iToPPCaqNeRsamcorJAu3CVW3TOf7OsMWLgDP9vZorYA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] HID: generic: Add ->match() check to __check_hid_generic()
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
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

On Wed, Dec 7, 2022 at 10:27 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Dec 7, 2022 at 10:13 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Some special HID drivers (for example, hid-logitech-hidpp) use ->match()
> > callbacks to reject specific devices that otherwise would match the
> > driver's device ID list, with the expectation that those devices will
> > be handled by some other drivers.  However, this doesn't work if
> > hid-generic is expected to bind to the given device, because its
> > ->match() callback, hid_generic_match(), rejects all devices that match
> > device ID lists of the other HID drivers regardless of what is returned
> > by the other drivers' ->match() callbacks.
>
> Thanks Rafael for spotting that corner case in the ->match() processing.
>
> >
> > To make it work, amend the function used by hid_generic_match() for
> > checking an individual driver, __check_hid_generic(), with a check
> > involving the given driver's ->match() callback, so 0 is returned
> > when that callback rejects the device in question.
>
> Shouldn't we add that logic to hid_match_device() directly in
> hid-core.c instead?
> It feels wrong to have a function named "hid_match_device()" and have
> to manually call later "->match()" on the driver itself.

Well, I've followed the pattern present in hid_device_probe(), where
hid_match_device() is first called to check against the device ID list
and then ->match() is invoked later only if that doesn't fail.

Also changing hid_match_device() would change the way in which
hid_bus_match() works and that may lead to subsequent regressions,
potentially, so I'd rather avoid doing that ATM.

> Ack on the general idea anyway.

Thanks!

> >
> > Fixes: 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the Logitech Bluetooth devices")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/hid/hid-generic.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/hid/hid-generic.c
> > ===================================================================
> > --- linux-pm.orig/drivers/hid/hid-generic.c
> > +++ linux-pm/drivers/hid/hid-generic.c
> > @@ -31,7 +31,13 @@ static int __check_hid_generic(struct de
> >         if (hdrv == &hid_generic)
> >                 return 0;
> >
> > -       return hid_match_device(hdev, hdrv) != NULL;
> > +       if (!hid_match_device(hdev, hdrv))
> > +               return 0;
> > +
> > +       if (hdrv->match)
> > +               return hdrv->match(hdev, false);
> > +
> > +       return 1;
> >  }
> >
> >  static bool hid_generic_match(struct hid_device *hdev,
> >
> >
> >
>
