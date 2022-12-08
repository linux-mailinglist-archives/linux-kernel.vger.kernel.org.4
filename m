Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452D76470D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiLHNda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLHNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA34588B57
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670506348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2Y2q8xXkweyHb7q+LdaF3QQfL2xTZoL/8BGcjmlxh0=;
        b=J97WSX3v3WSOLRKu2RMUOtr0bGSrLyazoRhquClf405eYV7I7Udpap040JiWtkCJyTh05k
        t6syP4m0dC1cq1Yq2aPxFgyKYLgrBtpBD8z0L2E9E0lna1/GmyXPQWo225pXJVn2OVMgaj
        bAUQ8kt85btXwDFdW+pGyyfiPvs5I5w=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-jF1BhhrTN4649YEczzUO7g-1; Thu, 08 Dec 2022 08:32:26 -0500
X-MC-Unique: jF1BhhrTN4649YEczzUO7g-1
Received: by mail-il1-f197.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso1114736ilu.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 05:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2Y2q8xXkweyHb7q+LdaF3QQfL2xTZoL/8BGcjmlxh0=;
        b=lAYLFx9NsprluPTqbaFGcIOtjx391UxQmQ0uF9hwXCg6HMDlsWRi3CSIm461eu9544
         OIqRtmWfhdUBosnkQcUhtdkKgVwshAuRgfsYAuyoo9Alg0FGT2IJJtPr7Uc3SaJiR6yb
         R4qcwlMphSw3bmSiIfzghz3NvMQFZXe/R2Wv4SnOkL5GOkJrH3nbP+F5dlF//gdy7V9e
         rPq13wJKU7QW47Bl5sj6GieVY2sysUY0nNwXozsro7Utg0HNOlt6SMXOOOpyGePRDk8A
         UmoRKvw4BwRxYnNr1bU0g4TBcghZ4BLQF5CqPfLVqcki1UvT7hmNU7pVvbYpMZsoBgLa
         zyyg==
X-Gm-Message-State: ANoB5pnOfdozrsdT1ZMicezMvskrqSLim15fAQ25oEz9k9sWHYle1RiF
        rp4Ox9ps7kqqajUpgEQtSnuPiBKXNU5bv5l6ny8vteJzROs2W8j/AnmgVK/UCpo7RS6Cq5wG7Ea
        xYIfRjRueqOlv5cg9qkHddT1admILroD6jNPewEto
X-Received: by 2002:a05:6602:418b:b0:6dd:813a:bfaa with SMTP id bx11-20020a056602418b00b006dd813abfaamr34563939iob.146.1670506346282;
        Thu, 08 Dec 2022 05:32:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7zMSooRXlr4Posz/K2aHy6BiWNhWiEb2ADqwEFUNsUAPtJeFCgZxCy96OWNwpvW54MEYGv7AxIPPX4bTVseZA=
X-Received: by 2002:a05:6602:418b:b0:6dd:813a:bfaa with SMTP id
 bx11-20020a056602418b00b006dd813abfaamr34563933iob.146.1670506345920; Thu, 08
 Dec 2022 05:32:25 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
 <2283816.ElGaqSPkdT@kreacher> <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
 <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
 <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
 <nycvar.YFH.7.76.2212071117420.6045@cbobk.fhfr.pm> <f0ccee0d2f85099c146ee682b25d30c832155fa3.camel@hadess.net>
 <8c28a60ede7b568352141d2aae2952d2923234a7.camel@hadess.net>
In-Reply-To: <8c28a60ede7b568352141d2aae2952d2923234a7.camel@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 8 Dec 2022 14:32:14 +0100
Message-ID: <CAO-hwJLTeNXAYQdVBgo4=VrS53=9YAtpCY8puvXQAvQWGA20bQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Dec 7, 2022 at 3:24 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-12-07 at 13:43 +0100, Bastien Nocera wrote:
> > On Wed, 2022-12-07 at 11:19 +0100, Jiri Kosina wrote:
> > > On Wed, 7 Dec 2022, Benjamin Tissoires wrote:
> > >
> > > > Agree, but OTOH, Rafael, your mouse is not brand new AFAICT, so I
> > > > am
> > > > worried that you won't be the only one complaining we just killed
> > > > their
> > > > mouse. So I think the even wiser solution would be to delay (and
> > > > so
> > > > revert in 6.1 or 6.2) the 2 patches that enable hid++ on all
> > > > logitech
> > > > mice (8544c812e43ab7bdf40458411b83987b8cba924d and
> > > > 532223c8ac57605a10e46dc0ab23dcf01c9acb43).
> > >
> > > If we were not at -rc8 timeframe, I'd be in favor to coming up with
> > > proper
> > > fix still for 6.1. But as things currently are, let's just revert
> > > those
> > > and reschedule them with proper fix for 6.2+.
> >
> > Has anyone seen any other reports?
> >
> > Because, honestly, seeing work that adds support for dozens of
> > devices
> > getting tossed out at the last minute based on a single report with
> > no
> > opportunity to fix the problem is really frustrating.
>
> FWIW, I went out to buy a Logitech device that uses Bluetooth Classic,
> the only one I could find in 2 different shops among dozens of Logitech
> devices, tested it, and it worked correctly.

Again, I understand the frustration. But the problem is not so much
that we might or might not ever need another entry in that list. The
problem is that some devices were supported previously (not in a fancy
way), and now we have a chance to just disable those devices. Of
course, we could say "just rmmod hid-logitech-hidpp". I have already
been through that as well, and then you fight for 10 years on some
forums where everybody says that if you have an issue with your
touchscreen, just disable <insert any driver here> when the particular
touchscreen is *not* using that driver at all.

Anyway, let me write down my thoughts since yesterday:
1. Rafael already realized that the ->match() function was not working
outside any other driver than hid-generic (and this was the design at
the time)
2. We have an issue in hid-logitech-hidpp where during probe calling
hidpp_root_get_protocol_version() returns an error, when userspace
tools are working fine for the exact same command
3. IMO, the way hid-logitech-hidpp probe function is behaving is not
resilient enough to be able to have a generic catch-all, because there
is a non-zero chance the probe returns -ENODEV (see all the exit paths
that return -ENODEV in probe).

To solve 1, it needs a little bit of tinkering and Rafael already sent
a v1 for that. IMO we should refine it, but that's an already ongoing
process

To solve 2, Bastien already mentioned one piece of the puzzle (the
error code not being correctly reported and the signification changed
between HID++ 1.0 and 2.0). But I am still yet to understand why there
is a difference between userspace call of the function, and kernel
space.

To solve 3, I initially started to work on a simple, more resilient
probe in hid-logitech-hidpp. I thought that we could regroup all
device initialization we do in a hidpp_preinit() call, and if that
call fails, revert to the generic hid processing.

But then, looking at the bigger picture, it would make sense to not do
that exactly. Instead of returning 0 and handling the device through
hid-logitech-hidpp, maybe we should actually return -ENODEV, and have
a fallback mechanism in hid-core that says "it seems I have tried all
possible drivers, all of them failed, let's force hid-generic for this
one".

And as I type those lines, how about the cases when we actually want
to disable a USB interface from HID because it is legitimate to do so?

I'll need to think about this a little bit more.

To be able to reintroduce the bluetooth catch-all, I think we need to
solve 1 and 3. 2 would be nice to understand but is not preventing the
series from being merged back.

Cheers,
Benjamin

