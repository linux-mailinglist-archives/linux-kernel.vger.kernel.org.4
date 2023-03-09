Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09446B2814
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjCIPCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjCIPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6B31E39
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678373803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkAp9zFq9b4mw6BsKEGYzVCx2cmzao2Md4cteGoh2lo=;
        b=LY35TBQY7VpOQsPWS9T9/dhL+p5IVg9s6JjFFPVA1yyHkKfQ9gMTFPPdj/NybExQxPJAXX
        UBaP9/oHcdFx9fEJGybRJw58yK7KmHS2aZAFSImjhbvYYq69k6p48EsQj9psl82YUqgYfX
        0UEoRZS3seVO8ubEC3rCTDmGCdGd+V4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-aMC5b7vVMv-yzk9B5_W_xA-1; Thu, 09 Mar 2023 09:56:41 -0500
X-MC-Unique: aMC5b7vVMv-yzk9B5_W_xA-1
Received: by mail-yb1-f198.google.com with SMTP id r13-20020a25760d000000b0096c886848c9so2502599ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkAp9zFq9b4mw6BsKEGYzVCx2cmzao2Md4cteGoh2lo=;
        b=FUDzebFXpxXWpAKT9gXGiGaJivnHtlFasuTfje6oEsbp29nQ1OrnQIUt0/2uccYcu7
         Ksv1eCTGKL5vCmozqgyKB2Hiy4JKukhbQKn29P8bzxDiVFFcJ632ZLOA3nTh6SbwgaFR
         SmwXHu3BJhgZOfeeKS059CvOTo+8dOeYwcWMuJw7funbfG6VBAuZgsBk68Xhh2DkQdsM
         BH2DvgPlUcI2NTDZ3yH+L5BDHZztb+c1mAjOuCnA31emjr4wRojh76dew1AoFtbOkp04
         2ifltbyhThK4MUZ5ygTQnqQTmHOkQ36Eccej5f7O4adKwldK221xOQw8Vyoagso+Q/A4
         RGrQ==
X-Gm-Message-State: AO0yUKWcB+lZDo3e+TH3nDIIgJLleY4xB2j2G+v2WkFXRVd9gMrrjqgs
        I4t3bxkofpWBM1GbTuky2lB33wShH6M3ONzgcBnLxUIR1hoF7vOjbpfLsthw2TqevIpu5uq0OAi
        MHODq7D2ntBlrSJmiWYkXjius43WY3Z4KAnH2mvid
X-Received: by 2002:a81:af4b:0:b0:533:91d2:9d94 with SMTP id x11-20020a81af4b000000b0053391d29d94mr14287229ywj.5.1678373800739;
        Thu, 09 Mar 2023 06:56:40 -0800 (PST)
X-Google-Smtp-Source: AK7set9veEFtXp9mMkEnSetAD+AvO9HZMSdYaPy8wr0uH4YegOd+kRr8AtgQW8T5KMvMpsm+4JuAcY2D6+UctCWL4L8=
X-Received: by 2002:a81:af4b:0:b0:533:91d2:9d94 with SMTP id
 x11-20020a81af4b000000b0053391d29d94mr14287215ywj.5.1678373800453; Thu, 09
 Mar 2023 06:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20230307213536.2299487-1-svv@google.com> <df8538e8a97cb4547db7da51a4359c03657ab79f.camel@hadess.net>
 <CAKF84v2hm-wRNonbMV9PMBghhSL1jTQ8ot7gTzspVpEv5d2SDw@mail.gmail.com> <785eae0426a82ce5bc6891482b54d2629f5558aa.camel@hadess.net>
In-Reply-To: <785eae0426a82ce5bc6891482b54d2629f5558aa.camel@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 9 Mar 2023 15:56:29 +0100
Message-ID: <CAO-hwJKOjfThF_CdF8kj=SiXKKLe5gr-Zh4iqgDpLmLNyjmbnw@mail.gmail.com>
Subject: Re: [PATCH v2] Add rumble support to latest xbox controllers
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Siarhei Vishniakou <svv@google.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 7:54=E2=80=AFPM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Wed, 2023-03-08 at 09:55 -0800, Siarhei Vishniakou wrote:
> > Thanks Bastien!
> >
> > I can definitely add a link to the wikipedia page.
> >
> > Are you talking about adding the link to the commit message, or to
> > hid-ids.h ?
>
> I think the commit message would be enough so we know which device
> we're talking about, but now that you mention it, maybe the source code
> would be a good idea too.

Agree, adding the link in the source would be fine.

>
> As far as I've understood, and Benjamin can correct me, we don't need
> to have IDs be in hid-ids.h because we don't need to declare them both
> as a blocklist in the hid core, and then again in the driver itself.

We don't need to have the blocklist anymore, but using hid-ids.h is
still used, and sometimes has the benefit of raising eyebrows when you
add support for a new device and realize that it was already defined.
So keeping the list around is not so much of a bad thing.

>
> My take is that the patches could move the IDs from hid-ids.h to hid-
> microsoft.c as they're changed. You then wouldn't need the macros, just
> add a comment for each of variants, and that Wikipedia article can be
> linked above the whole XBox controller section.

We are definitely in the bikeshedding phase, but I would leave the
code as it is in this patch :)

One more comment below:

>
> What do you think?
>
> >
> >
> > On Wed, Mar 8, 2023 at 2:23=E2=80=AFAM Bastien Nocera <hadess@hadess.ne=
t>
> > wrote:
> > >
> > > On Tue, 2023-03-07 at 13:35 -0800, Siarhei Vishniakou wrote:
> > > > Currently, rumble is only supported via bluetooth on a single
> > > > xbox
> > > > controller, called 'model 1708'. On the back of the device, it's
> > > > named
> > > > 'wireless controller for xbox one'. However, in 2021, Microsoft
> > > > released
> > > > a firmware update for this controller. As part of this update,
> > > > the
> > > > HID
> > > > descriptor of the device changed. The product ID was also changed
> > > > from
> > > > 0x02fd to 0x0b20. On this controller, rumble was supported via
> > > > hid-microsoft, which matched against the old product id (0x02fd).
> > > > As
> > > > a
> > > > result, the firmware update broke rumble support on this
> > > > controller.
> > > >
> > > > The hid-microsoft driver actually supports rumble on the new
> > > > firmware,
> > > > as well. So simply adding new product id is sufficient to bring
> > > > back
> > > > this support.
> > > >
> > > > After discussing further with the xbox team, it was pointed out
> > > > that
> > > > another xbox controller, xbox elite series 2, can be supported in
> > > > a
> > > > similar way.
> > > >
> > > > Add rumble support for all of these devices in this patch. Two of
> > > > the
> > > > devices have received firmware updates that caused their product
> > > > id's
> > > > to
> > > > change. Both old and new firmware versions of these devices were
> > > > tested.
> > > >
> > > > The tested controllers are:
> > > >
> > > > 1. 'wireless controller for xbox one', model 1708
> > > > 2. 'xbox wireless controller', model 1914. This is also sometimes
> > > >    referred to as 'xbox series S|X'.
> > > > 3. 'elite series 2', model 1797.
> > > >
> > > > The tested configurations are:
> > > > 1. model 1708, pid 0x02fd (old firmware)
> > > > 2. model 1708, pid 0x0b20 (new firmware)
> > > > 3. model 1914, pid 0x0b13
> > > > 4. model 1797, pid 0x0b05 (old firmware)
> > > > 5. model 1797, pid 0x0b22 (new firmware)
> > > >
> > > > I verified rumble support on both bluetooth and usb.
> > >
> > > Looks good although I would personally have preferred separate
> > > patches
> > > for each controller.
> > >
> > > Reviewed-by: Bastien Nocera <hadess@hadess.net>
> > >
> > > Would a link to:
> > > https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary
> > > also be useful to make which model is which clearer in the minds of
> > > future readers?
> > >
> > > Cheers
> > >
> > > >
> > > > Signed-off-by: Siarhei Vishniakou <svv@google.com>
> > > > Change-Id: I3337a7ab5f40759c85bf67bf0dbe5d4de31ce1ff

That change-id should be dropped, it has no meaning to us.

Cheers,
Benjamin

> > > > ---
> > > >  drivers/hid/hid-ids.h       |  6 +++++-
> > > >  drivers/hid/hid-microsoft.c | 11 ++++++++++-
> > > >  2 files changed, 15 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > index 053853a891c5..c9b75f8ba49a 100644
> > > > --- a/drivers/hid/hid-ids.h
> > > > +++ b/drivers/hid/hid-ids.h
> > > > @@ -903,7 +903,11 @@
> > > >  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> > > >  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
> > > >  #define USB_DEVICE_ID_MS_SURFACE3_COVER                0x07de
> > > > -#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER 0x02fd
> > > > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708    0x02fd
> > > > +#define
> > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE        0x0b20
> > > > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914    0x0b13
> > > > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797    0x0b05
> > > > +#define
> > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE        0x0b22
> > > >  #define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
> > > >  #define USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS      0x02e0
> > > >
> > > > diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-
> > > > microsoft.c
> > > > index 071fd093a5f4..9345e2bfd56e 100644
> > > > --- a/drivers/hid/hid-microsoft.c
> > > > +++ b/drivers/hid/hid-microsoft.c
> > > > @@ -446,7 +446,16 @@ static const struct hid_device_id
> > > > ms_devices[] =3D
> > > > {
> > > >                 .driver_data =3D MS_PRESENTER },
> > > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
> > > >                 .driver_data =3D MS_SURFACE_DIAL },
> > > > -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
> > > > +
> > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708),
> > > > +               .driver_data =3D MS_QUIRK_FF },
> > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE),
> > > > +               .driver_data =3D MS_QUIRK_FF },
> > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914),
> > > > +               .driver_data =3D MS_QUIRK_FF },
> > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797),
> > > > +               .driver_data =3D MS_QUIRK_FF },
> > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE),
> > > >                 .driver_data =3D MS_QUIRK_FF },
> > > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
> > > >                 .driver_data =3D MS_QUIRK_FF },
> > >
>

