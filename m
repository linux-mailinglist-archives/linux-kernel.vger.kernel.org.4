Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EDC6B107A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCHRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCHRzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:55:15 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9BCC3E12
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:55:13 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t22so12757373oiw.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678298113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJB0uEFZy/6MAVKabKPNgYxMOfzy8GKwC4p9P3PtYzY=;
        b=eVp3vQJHlGmIuoFfc33UZGjhDIawS1wbNoXeZ25+CsG5cifizuSRnvzeHr9oq24UXm
         HfBovf/wQhvhS6pzXpQh61QyDcS4udJRKawvXI8NMavuLvnz8fZhwZcmxwnAMj733PaX
         mFxz9tGPe8NyQhfjTJZSTmWltjxMSF1e8YdSfKKkx1onMP2KSyBprqJ7Ime72lhTaGt+
         HcrzrWFpzrufHfZRmC/mSAsRTG68L19yFPraTt+p0gDui61sp259xebMBpxPxOzNO8y9
         qS8T7FoxKIYawrgqJsvN2rFU6TFRlLh9h//pKD7gprRff5nm0fb9QW0pszpbAzMtq1EC
         qwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJB0uEFZy/6MAVKabKPNgYxMOfzy8GKwC4p9P3PtYzY=;
        b=nV6N6JbKFU/P4sQije8gAY7CDBFuxOZVOwU/JRHRx/kO1tt8HlE9iKTZFZbDkpZiTh
         gIwzFDacrsBq5WCxd3xUKFDK/lzbkN5TUbG+yYOsnbd0zhNtJUYbH9uf1ywrIfhWrHmI
         Hy9sh3gIJknsjuRa6ZbRtTwybEjMmyBiW9QPjJnRXSUbvrciLHSmjWhgVqARCiDDiQg3
         Z+YSU/+0V3QVoF9biPNB68UtB+vMRwx0xGjTQE2zM5LUttJKWRTsxlkhm44gyV+2TFuP
         i+KIop32f6wUmx9CCu7UbWb7DSmO2W1c0UXYV4ofxIaTDLcjeZqdqdSdKcWSZuVNwseZ
         5bGw==
X-Gm-Message-State: AO0yUKWg3IbgbsFtFPjwz50nhZsJeQwOXnmoJR17yoDtb9MlDpQqVPyn
        BD2hd1J84vXnsQVHTQ5MYgDw8fnmC7ZHUQMke4bbJw==
X-Google-Smtp-Source: AK7set/p4JuRmBIOUxe387+u5jOsJ11MbI1eUrrgc5E9Dnj/TZdxuGkzDN1XZUaaLgvsln9u+nm/CRvE+HttQCJ7PKY=
X-Received: by 2002:aca:130f:0:b0:384:f72:a6cb with SMTP id
 e15-20020aca130f000000b003840f72a6cbmr6385962oii.1.1678298112806; Wed, 08 Mar
 2023 09:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20230307213536.2299487-1-svv@google.com> <df8538e8a97cb4547db7da51a4359c03657ab79f.camel@hadess.net>
In-Reply-To: <df8538e8a97cb4547db7da51a4359c03657ab79f.camel@hadess.net>
From:   Siarhei Vishniakou <svv@google.com>
Date:   Wed, 8 Mar 2023 09:55:01 -0800
Message-ID: <CAKF84v2hm-wRNonbMV9PMBghhSL1jTQ8ot7gTzspVpEv5d2SDw@mail.gmail.com>
Subject: Re: [PATCH v2] Add rumble support to latest xbox controllers
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bastien!

I can definitely add a link to the wikipedia page.

Are you talking about adding the link to the commit message, or to hid-ids.=
h ?


On Wed, Mar 8, 2023 at 2:23=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Tue, 2023-03-07 at 13:35 -0800, Siarhei Vishniakou wrote:
> > Currently, rumble is only supported via bluetooth on a single xbox
> > controller, called 'model 1708'. On the back of the device, it's
> > named
> > 'wireless controller for xbox one'. However, in 2021, Microsoft
> > released
> > a firmware update for this controller. As part of this update, the
> > HID
> > descriptor of the device changed. The product ID was also changed
> > from
> > 0x02fd to 0x0b20. On this controller, rumble was supported via
> > hid-microsoft, which matched against the old product id (0x02fd). As
> > a
> > result, the firmware update broke rumble support on this controller.
> >
> > The hid-microsoft driver actually supports rumble on the new
> > firmware,
> > as well. So simply adding new product id is sufficient to bring back
> > this support.
> >
> > After discussing further with the xbox team, it was pointed out that
> > another xbox controller, xbox elite series 2, can be supported in a
> > similar way.
> >
> > Add rumble support for all of these devices in this patch. Two of the
> > devices have received firmware updates that caused their product id's
> > to
> > change. Both old and new firmware versions of these devices were
> > tested.
> >
> > The tested controllers are:
> >
> > 1. 'wireless controller for xbox one', model 1708
> > 2. 'xbox wireless controller', model 1914. This is also sometimes
> >    referred to as 'xbox series S|X'.
> > 3. 'elite series 2', model 1797.
> >
> > The tested configurations are:
> > 1. model 1708, pid 0x02fd (old firmware)
> > 2. model 1708, pid 0x0b20 (new firmware)
> > 3. model 1914, pid 0x0b13
> > 4. model 1797, pid 0x0b05 (old firmware)
> > 5. model 1797, pid 0x0b22 (new firmware)
> >
> > I verified rumble support on both bluetooth and usb.
>
> Looks good although I would personally have preferred separate patches
> for each controller.
>
> Reviewed-by: Bastien Nocera <hadess@hadess.net>
>
> Would a link to:
> https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary
> also be useful to make which model is which clearer in the minds of
> future readers?
>
> Cheers
>
> >
> > Signed-off-by: Siarhei Vishniakou <svv@google.com>
> > Change-Id: I3337a7ab5f40759c85bf67bf0dbe5d4de31ce1ff
> > ---
> >  drivers/hid/hid-ids.h       |  6 +++++-
> >  drivers/hid/hid-microsoft.c | 11 ++++++++++-
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 053853a891c5..c9b75f8ba49a 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -903,7 +903,11 @@
> >  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> >  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
> >  #define USB_DEVICE_ID_MS_SURFACE3_COVER                0x07de
> > -#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER 0x02fd
> > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708    0x02fd
> > +#define
> > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE        0x0b20
> > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914    0x0b13
> > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797    0x0b05
> > +#define
> > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE        0x0b22
> >  #define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
> >  #define USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS      0x02e0
> >
> > diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-
> > microsoft.c
> > index 071fd093a5f4..9345e2bfd56e 100644
> > --- a/drivers/hid/hid-microsoft.c
> > +++ b/drivers/hid/hid-microsoft.c
> > @@ -446,7 +446,16 @@ static const struct hid_device_id ms_devices[] =3D
> > {
> >                 .driver_data =3D MS_PRESENTER },
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
> >                 .driver_data =3D MS_SURFACE_DIAL },
> > -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
> > +
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708),
> > +               .driver_data =3D MS_QUIRK_FF },
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE),
> > +               .driver_data =3D MS_QUIRK_FF },
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914),
> > +               .driver_data =3D MS_QUIRK_FF },
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797),
> > +               .driver_data =3D MS_QUIRK_FF },
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE),
> >                 .driver_data =3D MS_QUIRK_FF },
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
> >                 .driver_data =3D MS_QUIRK_FF },
>
