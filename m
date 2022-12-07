Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505EF645674
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiLGJ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A37F240B3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670405271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vnpcakF0D2N+ctDD2M8NYlXoYAPqqKbAo8NR+IyVtOk=;
        b=gOHh2SJrqps/TZwLqIo6iHS+9WDKGc7sEUI6WyCoL0TPDQiwxI88AmLVKZ6NPDn4ZCVGfU
        1vwyJZq+kS8CtGTEv7/Dtpqlr9ifjbTd1P++si+XWM5bz01HdWwbLjDNmofi1716LrRFXa
        dSdLt3m1bBj3nCBTV12TwRR8af84MUs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-2j_pbCqXOWSXp8MloRwpgg-1; Wed, 07 Dec 2022 04:27:50 -0500
X-MC-Unique: 2j_pbCqXOWSXp8MloRwpgg-1
Received: by mail-io1-f71.google.com with SMTP id b24-20020a056602219800b006e2bf9902cbso434874iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 01:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnpcakF0D2N+ctDD2M8NYlXoYAPqqKbAo8NR+IyVtOk=;
        b=a0buy6/UIvHFp+FyBsuqx4XPnMGYQsD5L4R4PiZpKI0VKXysJTJV8PGGhsBErD0zgU
         spz/bW98/5CAvxbh1fRqtYz1SQPHe2MtPq8xX7IyWSDmEkyaW/90YfKFJBsbzP3VspBy
         L06Eh08JWPMYhYx2xsHzC2wtewyjpCcC0HxKpv17GpqZ2gxuEOx8aAX7Vf33wcRYk605
         BkyuGW7bNfCV0sr8aX71SuO4U0lNJIIhz4rHPnOk3axexkH92yOL8hfLzCOu2tRd/alE
         EJCT27RF68EeyUyrnnJV+6GAqbkjwFuxXkswLlI0rES946unGDTObKKIIa6qUX3lk9rv
         aL4w==
X-Gm-Message-State: ANoB5pk4GRMtF5fbhjN4kQnTlVKh+D1zPf1WwHoQi8+Y45PQQkWo4hcy
        Vx6+GsEeyliipB4pEAgFrK16rMgg60JYFj1YvI/BiaTTeFUaYktEwep7B0MOOgKmKJdmdBpiZOT
        +tOXkRbvkUxAciP575hK4T/LIdo6IhloFcbbcQqVl
X-Received: by 2002:a02:a089:0:b0:375:2a78:73fd with SMTP id g9-20020a02a089000000b003752a7873fdmr40641361jah.217.1670405269228;
        Wed, 07 Dec 2022 01:27:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5WxD50Jy8iY8xEumADCWBZxkrPAX9Ius1TK3asOoKktQM+CQvnTZKEtEsVRmuLXZeJp5mWivYYisdFbM4ndyI=
X-Received: by 2002:a02:a089:0:b0:375:2a78:73fd with SMTP id
 g9-20020a02a089000000b003752a7873fdmr40641352jah.217.1670405269012; Wed, 07
 Dec 2022 01:27:49 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher> <4809717.31r3eYUQgx@kreacher>
In-Reply-To: <4809717.31r3eYUQgx@kreacher>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 7 Dec 2022 10:27:37 +0100
Message-ID: <CAO-hwJJkWOn3N-UrhjFxiKh7jxPk_BLeL-wj6fnD+mcgHMEHfg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] HID: generic: Add ->match() check to __check_hid_generic()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
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

On Wed, Dec 7, 2022 at 10:13 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Some special HID drivers (for example, hid-logitech-hidpp) use ->match()
> callbacks to reject specific devices that otherwise would match the
> driver's device ID list, with the expectation that those devices will
> be handled by some other drivers.  However, this doesn't work if
> hid-generic is expected to bind to the given device, because its
> ->match() callback, hid_generic_match(), rejects all devices that match
> device ID lists of the other HID drivers regardless of what is returned
> by the other drivers' ->match() callbacks.

Thanks Rafael for spotting that corner case in the ->match() processing.

>
> To make it work, amend the function used by hid_generic_match() for
> checking an individual driver, __check_hid_generic(), with a check
> involving the given driver's ->match() callback, so 0 is returned
> when that callback rejects the device in question.

Shouldn't we add that logic to hid_match_device() directly in
hid-core.c instead?
It feels wrong to have a function named "hid_match_device()" and have
to manually call later "->match()" on the driver itself.

Ack on the general idea anyway.

>
> Fixes: 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the Logitech Bluetooth devices")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/hid/hid-generic.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/hid/hid-generic.c
> ===================================================================
> --- linux-pm.orig/drivers/hid/hid-generic.c
> +++ linux-pm/drivers/hid/hid-generic.c
> @@ -31,7 +31,13 @@ static int __check_hid_generic(struct de
>         if (hdrv == &hid_generic)
>                 return 0;
>
> -       return hid_match_device(hdev, hdrv) != NULL;
> +       if (!hid_match_device(hdev, hdrv))
> +               return 0;
> +
> +       if (hdrv->match)
> +               return hdrv->match(hdev, false);
> +
> +       return 1;
>  }
>
>  static bool hid_generic_match(struct hid_device *hdev,
>
>
>

