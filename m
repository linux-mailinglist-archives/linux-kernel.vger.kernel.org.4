Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1243645718
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLGKGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLGKGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B306263D8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670407532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gC7Tw1M63CiH5wuJfxY1LLwctVc069fPba6nn04qrbA=;
        b=HHR9GUrfu8TqkG4a3bnHJYR5cIP/IzyGXbRgnwrVHLN5AixXOZRDUOdFBqLGeQoVgie5UR
        UNIYGNfIj2NGi6HYMQOAKGzgnHKqouqukzN9iHiBVa0ewtwnHbNmVd6NI/cYkAlf6EphZu
        rhHq5g1sOrea7jCqC6uKqLF1K1dNkyU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-1VmRg3wUPbu0MQHF47z3Ag-1; Wed, 07 Dec 2022 05:05:31 -0500
X-MC-Unique: 1VmRg3wUPbu0MQHF47z3Ag-1
Received: by mail-il1-f199.google.com with SMTP id l16-20020a056e02067000b0030325bbd570so16272108ilt.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gC7Tw1M63CiH5wuJfxY1LLwctVc069fPba6nn04qrbA=;
        b=4K1PCb9hUDN6FOXKamlZ9UpzuTndDXDLma5QwKk60jbGbEWz35CM6JNiObNCNO6EHY
         RbPKrk2ml9OWU/2wvMsxM+MOV0HJdgQwsM4i2RJMY7nXBdPQo9G6OaElvxHwPy2S6dlV
         YsNl3rm9nmOttxooWwcDY9iJ8hdwf2zYyPwmOYHgmL+vIX+S6D/Wg1h5H4c8rRxAuR8H
         +yo0aEud5Nk+VuB/ifpju2fmjPmR6OIp8IwM5GyMcbZOnVCS4pZT449eOeg6h9kWjmqm
         i4wknGAQ090964qjuzLFIz9NOyHPMLmAIGEcKdr/9xzG4XlPYMcSAxpvOofTvrRiCRcs
         TbXw==
X-Gm-Message-State: ANoB5plD5UDk+gCvtAiLIdgli7C/+6hbudT7BA1zknmESVbqWcafDJnv
        KemNZObpqxUpqxfrM54fMQ3kRYW3jisnPE/OBZlqOuUPPT0cjwzz5pHCn4ZXCRxCz4jviqCAPwO
        J3YpCeKoah66m6/F9qiZ60fFI8TqkIQQWevRmfbl3
X-Received: by 2002:a05:6e02:de1:b0:303:4414:8ea8 with SMTP id m1-20020a056e020de100b0030344148ea8mr9292850ilj.124.1670407531020;
        Wed, 07 Dec 2022 02:05:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6e4V87kwdqVxasnF7D5McMA69kgFJZNC8HqDnwv6ozmzPTIsBkyP7or6Un9PYFgv3P8AHraSl+cIXZAPfO1G0=
X-Received: by 2002:a05:6e02:de1:b0:303:4414:8ea8 with SMTP id
 m1-20020a056e020de100b0030344148ea8mr9292840ilj.124.1670407530824; Wed, 07
 Dec 2022 02:05:30 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
 <2283816.ElGaqSPkdT@kreacher> <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
 <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
In-Reply-To: <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 7 Dec 2022 11:05:19 +0100
Message-ID: <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 7, 2022 at 10:29 AM Bastien Nocera <hadess@hadess.net> wrote:
> >
> > On Wed, 2022-12-07 at 10:12 +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Evidently, Logitech Bluetooth Mouse M336/M337/M535 (0xb016) does not
> > > work when HID++ is enabled for it,
> >
> > This needs the output of the hidpp-list-features tool mentioned earlier
> > in the thread so we can avoid words like "evidently" and provide
> > concrete proof.
>
> Well, so point me to a binary of this, please.
>
> > But why is it needed in this case?
>
> Because it doesn't work otherwise.
>
> > We purposefully try to avoid blanket
> > blocklists. The lack of HID++ can be probed, so the device should work
> > just as it used to (if the fallback code works).
>
> No, because the hid-generic driver has no way to check that the probe
> function of your driver fails for this particular device.  The probing
> of hid-generic will fail so long as the device matches the device ID
> list of any specific HID driver.  With patch [1/2] from this series
> applied this is unless that specific driver has a ->match() callback
> rejecting the given device.
>
> You'd need a list of drivers that have been tried and failed somewhere
> for that and AFAICS no such list is present in the code.

That is the reason why I never wanted to enable HID++ on all Logitech
mice, and this comes back to bite us at the worst time possible, right
before the merge window opens :(

>
> So a minimum fix for 6.1 that actually works for me is to add the
> non-working device to the blocklist.  More sophisticated stuff can be
> done later.

Agree, but OTOH, Rafael, your mouse is not brand new AFAICT, so I am
worried that you won't be the only one complaining we just killed
their mouse.
So I think the even wiser solution would be to delay (and so revert in
6.1 or 6.2) the 2 patches that enable hid++ on all logitech mice
(8544c812e43ab7bdf40458411b83987b8cba924d and
532223c8ac57605a10e46dc0ab23dcf01c9acb43).

Cheers,
Benjamin

>
> > We should only list devices that need special handling, and the ones
> > that don't work once HID++ was probed unsuccessfully.
> >
> > >  so add it to the list of devices
> > > that are not handled by logitech-hidpp.
> > >
> > > Fixes: 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the
> > > Logitech Bluetooth devices")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > Index: linux-pm/drivers/hid/hid-logitech-hidpp.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/hid/hid-logitech-hidpp.c
> > > +++ linux-pm/drivers/hid/hid-logitech-hidpp.c
> > > @@ -4274,6 +4274,7 @@ static const struct hid_device_id unhand
> > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
> > >         /* Handled in hid-generic */
> > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb016) },
> > >         {}
> > >  };
>

