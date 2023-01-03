Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE59265C337
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjACPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjACPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:41:08 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CFC112F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:41:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 18so8630078pfx.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zN43642gf6m2iJUfZd4fbuXcS7p5ZWKPgIXLavZJc80=;
        b=hAyKDVhXHfSe07gBZbIH52NGV52T983hzKY328Bsw3nN1xYmmbDMjL2CqNVsuahwkH
         YbUNBaLRZmVE7oQvdkWHmLSm3ho7lW8Xb3MdK/AG4oSzt/nhlVJio2QNYDRgwiK5YBJG
         xPjLinGQxV2EGm7l62yva+ajGQhGCMBoGKVT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN43642gf6m2iJUfZd4fbuXcS7p5ZWKPgIXLavZJc80=;
        b=CdstINpa6KZDFd2jufVetVQYp4f+Xvj+BTJl2oVKGymnxrtLACDjMSK3rgS0F59+75
         v2EX8MZuDgU1oQJXR6mWJRm9UdQEuWeklEvzakDyhNPHjWMQ7PAq5s/A5XootM1xI7ck
         XSbGcExzXDm31SkXbHsUFgXZwRKuATlhesRfdOlR7jZ5QOKk7oi0WJpyrIYv9l8EzPsu
         Rv0ZCToLL61rTe3HSnWVDr8ofkmgnrjiB0GTZIrp1v0hxkGkadSzzMZ4cR8ITRU4JJ6Z
         PWBo/28O5DqgNfEHd5/EyfMC8wMuMOJmpGPOzaBS5YqagB5hSZpXst5aJHG9652QAov0
         Mngg==
X-Gm-Message-State: AFqh2kpilXrjVTKJd+Gt1hMQzBmEyj1POrHDtlB1dhomfN5Lvs/ezpyb
        iFFwmx3b86c11IlYnkRP2oKQVfgKpxKoKNluHiA=
X-Google-Smtp-Source: AMrXdXtO1ArnD7OW9vhCZvAcTIPNzNYlouNICN7Q8FC7wDamhvic67Fw12+F9GqARuJ08ZbqUWdd1w==
X-Received: by 2002:a62:5e04:0:b0:575:62f8:be3 with SMTP id s4-20020a625e04000000b0057562f80be3mr43373903pfb.23.1672760461586;
        Tue, 03 Jan 2023 07:41:01 -0800 (PST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com. [209.85.210.172])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056283e2bdbdsm20633039pfx.138.2023.01.03.07.41.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 07:41:00 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id k137so16027231pfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 07:41:00 -0800 (PST)
X-Received: by 2002:a65:5b88:0:b0:495:fb5f:4395 with SMTP id
 i8-20020a655b88000000b00495fb5f4395mr1805013pgr.63.1672760459505; Tue, 03 Jan
 2023 07:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-2-0d7978a817cc@chromium.org> <Y67qWROM7rKywU3s@pendragon.ideasonboard.com>
In-Reply-To: <Y67qWROM7rKywU3s@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 3 Jan 2023 16:40:48 +0100
X-Gmail-Original-Message-ID: <CANiDSCs_36D5t5FOL+XuSCSz+H8RWQmV8F2TiAqDJTQUh-K2JQ@mail.gmail.com>
Message-ID: <CANiDSCs_36D5t5FOL+XuSCSz+H8RWQmV8F2TiAqDJTQUh-K2JQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/8] media: uvc: Allow quirking by entity guid
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Fri, 30 Dec 2022 at 14:40, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
>
> On Fri, Dec 02, 2022 at 06:02:42PM +0100, Ricardo Ribalda wrote:
> > When an IP is shared by multiple devices its erratas will be shared by
> > all of them. Instead of creating a long list of device quirks, or
> > waiting for the users to report errors in their hardware lets add a
> > routine to add quirks based on the entity guid.
>
> I'm not thrilled by this. An entity is not an "IP". Quirks are needed to
> handle issues with particular firmware versions on particular devices.
> The same entity GUID can be used by different devices running different
> firmware versions, some that would require a quirk and some that
> wouldn't.

Unfortunately there are ISPs that do not support firmware upgrading
that have an error on their firmware (or in this particular case a
different interpretation of the standard). Those ISPs are mounted in
different boards with a VID:PID that is chosen by the module
manufacturer.
In those cases we cannot get a list of the devices that are broken, we
could only get a sublist that we will keep updating indefinitely as
users keep reporting bugs (if they do so).

We are lucky enough that SunplusIT has been very active and provided
us a way to detect what hardware requires quirking. In those
situations where the vendor is on board and there is no upgrade
mechanism I think that this is a good compromise.

>
> > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 9c05776f11d1..c63ecfd4617d 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1493,6 +1493,28 @@ static int uvc_parse_control(struct uvc_device *dev)
> >       return 0;
> >  }
> >
> > +static const struct uvc_entity_quirk {
> > +     u8 guid[16];
> > +     u32 quirks;
> > +} uvc_entity_quirk[] = {
> > +};
> > +
> > +static void uvc_entity_quirks(struct uvc_device *dev)
> > +{
> > +     struct uvc_entity *entity;
> > +     int i;
>
> unsigned int
>
> > +
> > +     list_for_each_entry(entity, &dev->entities, list) {
> > +             for (i = 0; i < ARRAY_SIZE(uvc_entity_quirk); i++) {
> > +                     if (memcmp(entity->guid, uvc_entity_quirk[i].guid,
> > +                                sizeof(entity->guid)) == 0) {
> > +                             dev->quirks |= uvc_entity_quirk[i].quirks;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> >  /* -----------------------------------------------------------------------------
> >   * Privacy GPIO
> >   */
> > @@ -2452,6 +2474,9 @@ static int uvc_probe(struct usb_interface *intf,
> >               goto error;
> >       }
> >
> > +     /* Apply entity based quirks */
> > +     uvc_entity_quirks(dev);
> > +
> >       dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
> >                dev->uvc_version >> 8, dev->uvc_version & 0xff,
> >                udev->product ? udev->product : "<unnamed>",
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
