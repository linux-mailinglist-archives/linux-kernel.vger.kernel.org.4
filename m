Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852E56456D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiLGJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLGJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:49:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4C5DF2B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670406527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MASnWMtKjgrzOnH8l7Qbr8ECCxYmmsuCOJdRlItHQeg=;
        b=SvU4l+SHrOoEBAPAJ2g0oYszCP2if/W/ZvYVciw2ugxEYTL38C/0iQ3I9mlNrnAFGR7nEN
        2UOEGOkGWvHHg0eTDHBxB830uBAg1sQ+EctHaCv3qg8YMMFI1Q3nayVgUzfEbZA5JWj0zB
        KpT7QwSVcodr6OYxpvz2tqaJg7Me1Yk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-vXXOsUgtOY6kLBNrfLQlzA-1; Wed, 07 Dec 2022 04:48:46 -0500
X-MC-Unique: vXXOsUgtOY6kLBNrfLQlzA-1
Received: by mail-il1-f198.google.com with SMTP id d6-20020a056e02214600b00303620c6e39so6295059ilv.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 01:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MASnWMtKjgrzOnH8l7Qbr8ECCxYmmsuCOJdRlItHQeg=;
        b=S3IO0qGg84b3uGyu/gY1FtCjfzVEat4yoEXWTj4czX47ZywiuuA/nLloEN6DyHmtrW
         lFPnxUPgH+zZzmxPwrHpXLDKicbOLQyT/fDIyglz98wRrg56PWPfB74DgZpTCUbmiq0K
         fLOgr8k0WNoddXu07u0iGAQVGUPvGJZRg80fgsE+Kxn2fco8Nux1KPPTUbvapquOU9FF
         cffkT3NjcAv1tvu4rgreXu6Qa7K9WOfjNTyjTdZeKTMSX20iWyE7geOEcPSfAd5JEzAs
         WJ+ZPLIMNTRHl1XarWkcYVpKyZebVBTcWqC48UQFTdAwITr0Wgu6fW3H5MJADKpaAeka
         6Wyg==
X-Gm-Message-State: ANoB5pnP1XSr3QORPhInRV4q3cOXhD8qRQuEc4ZikbgU53mw2vATnxD8
        UMFTtrurm36eQ2PZOyDCC0LiTqJGvpWRPLtJJZUAgWs1wybhuLfNyrb0c5N+H9AN4bvQdc7WNsl
        5ttNlcyk7fwWOGsWdYY/4bLMW3GZfZh1GuLycOvqy
X-Received: by 2002:a02:a089:0:b0:375:2a78:73fd with SMTP id g9-20020a02a089000000b003752a7873fdmr40667001jah.217.1670406525573;
        Wed, 07 Dec 2022 01:48:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf67ksHWPrFsPUlzc4mFy5yT7/TXmxd0FvwUDHzB6abb6mMR3WwC7DZpzDY50jBnMF03lSAqPKIBxSfiZ7HaHHQ=
X-Received: by 2002:a02:a089:0:b0:375:2a78:73fd with SMTP id
 g9-20020a02a089000000b003752a7873fdmr40666995jah.217.1670406525330; Wed, 07
 Dec 2022 01:48:45 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
 <2283816.ElGaqSPkdT@kreacher> <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
In-Reply-To: <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 7 Dec 2022 10:48:34 +0100
Message-ID: <CAO-hwJLoAXt_uhT7bwphw1PW=4oQsOc_G3yACg-LQrerNx3yFA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 10:29 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-12-07 at 10:12 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Evidently, Logitech Bluetooth Mouse M336/M337/M535 (0xb016) does not
> > work when HID++ is enabled for it,
>
> This needs the output of the hidpp-list-features tool mentioned earlier
> in the thread so we can avoid words like "evidently" and provide
> concrete proof.
>
> But why is it needed in this case? We purposefully try to avoid blanket
> blocklists. The lack of HID++ can be probed, so the device should work
> just as it used to (if the fallback code works).

If I read the probe function correctly, we should have the HID++
reports present, so a static analysis will not allow us to detect that
information.

However, this reminds me of the Litra Glow[0]. On this device,
hidpp_root_get_protocol_version() also reports an error when it is
obvious it is connected.
And AFAICT, a BLE device is supposed to always be connected when it is
presented to the kernel (because disconnect is handled in the BLE
layer, in bluez).

Apparently Rafael's mouse is Bluetooth classic, so I have a doubt on
what happens when it goes into low power.

>
> We should only list devices that need special handling, and the ones
> that don't work once HID++ was probed unsuccessfully.
>

Given the current state of Rafael's mouse it goes into the second
category. But I suspect we should be smarter in the probe's decision
to consider if a device is connected or not.

Cheers,
Benjamin

[0] https://lore.kernel.org/linux-input/CABfF9mO3SQZvkQGOC09H5s7EEd2UGhpE=GYB46g_zF3aEOVn=Q@mail.gmail.com/

