Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E256ED995
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjDYBIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjDYBIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:08:07 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5259BB9F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:07:48 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-54974b54b77so668974eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682384866; x=1684976866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/ZWjY7nuk5g1EIAxsTfVtWoWtpDKDfGIWjpcW68trQ=;
        b=weiQyX8KOsXRMbfgEpDV4jc46gDkZCLR39FPGG73ZG9UKkO7XOnjIWUnAqQCmceIXk
         E9tPBnUnZwthuMdKbTQm21YVI/bcJirTwwAWUjFZ8a7Cpc6rWRDEd/TO68A5lkgKX0dP
         v7rtmr/8EfxkTQWPWGY+Qosyn69WmaPnNk6rCUt+YteTuy59hDrsZl/EoHoOemFqBubn
         uNGTxaSTN3Z9efC57IiQrePKFhmyUROr4kZKhbOOMe2o5GaZUMit9W50s08ORjMtJjkx
         ddjg69jH6P642od9fi9Py23cRMrUtqUE3GI9WrsaFveuZni7Lp/GqSiCGIPeQqy26ZKW
         6FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682384866; x=1684976866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/ZWjY7nuk5g1EIAxsTfVtWoWtpDKDfGIWjpcW68trQ=;
        b=I8ZpVyF1x+xqN9CAYydniWu57oAE31cglnwX0fQ54DXpdsOWmvmhHOVpP6HSNT6j2U
         G7suSI/RA4tmyMN1j9NfO/DRiDdKAeS72mUKZ7Pjthbr1K+BDGV+wEoXG0tLvL28DEgv
         +3NidZIm4sYW7lxCuEGmb2QzyMfOYSSLhFiLgORLFTmg+3Io1jKB44x2D1at9I2+ibv2
         UjLwPeII3CbJh31jajSiTs1MvVIq9LZe4bUT3wj1JHTp0gaHH/LkBip1d9742g/EuyXv
         w8KOsKvkWulZEl9mM+pWLhFki2UAJpZBi4nHhqY1APFf0C/6i/xh5wfpnJzqeL5+EUvh
         rRSA==
X-Gm-Message-State: AAQBX9fdbqi7z2G4dE5E/4GLoMyaHa8mizmufRFuYtan6EM92aQ0F2yq
        KzyoVRZgiATYSPsk0Nkru+ZHGbIlgamAff/cSsBvxg==
X-Google-Smtp-Source: AKy350YPdmeP5N/x4rnJSlGFuBGmaCuKAqMx2R9mYAKB4jr6dxryL4zr//uRbkEMbhLx5fEixbhy/2xuRR13iVbkMzY=
X-Received: by 2002:a4a:c112:0:b0:545:d4cf:177f with SMTP id
 s18-20020a4ac112000000b00545d4cf177fmr5277805oop.0.1682384865813; Mon, 24 Apr
 2023 18:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230307213536.2299487-1-svv@google.com> <df8538e8a97cb4547db7da51a4359c03657ab79f.camel@hadess.net>
 <CAKF84v2hm-wRNonbMV9PMBghhSL1jTQ8ot7gTzspVpEv5d2SDw@mail.gmail.com>
 <785eae0426a82ce5bc6891482b54d2629f5558aa.camel@hadess.net> <CAO-hwJKOjfThF_CdF8kj=SiXKKLe5gr-Zh4iqgDpLmLNyjmbnw@mail.gmail.com>
In-Reply-To: <CAO-hwJKOjfThF_CdF8kj=SiXKKLe5gr-Zh4iqgDpLmLNyjmbnw@mail.gmail.com>
From:   Siarhei Vishniakou <svv@google.com>
Date:   Mon, 24 Apr 2023 18:07:35 -0700
Message-ID: <CAKF84v0=LEfp9V1=PwF47qTd6vAYMuv7vR412oXfr2UpecC5Hw@mail.gmail.com>
Subject: Re: [PATCH v2] Add rumble support to latest xbox controllers
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks folks,
I uploaded a v3 patch with the following changes:
1. Added link to wikipedia
2. Removed Change-Id from commit message
3. Added Bastien's 'Reviewed-by'.

On Thu, Mar 9, 2023 at 6:56=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Mar 8, 2023 at 7:54=E2=80=AFPM Bastien Nocera <hadess@hadess.net>=
 wrote:
> >
> > On Wed, 2023-03-08 at 09:55 -0800, Siarhei Vishniakou wrote:
> > > Thanks Bastien!
> > >
> > > I can definitely add a link to the wikipedia page.
> > >
> > > Are you talking about adding the link to the commit message, or to
> > > hid-ids.h ?
> >
> > I think the commit message would be enough so we know which device
> > we're talking about, but now that you mention it, maybe the source code
> > would be a good idea too.
>
> Agree, adding the link in the source would be fine.
>
> >
> > As far as I've understood, and Benjamin can correct me, we don't need
> > to have IDs be in hid-ids.h because we don't need to declare them both
> > as a blocklist in the hid core, and then again in the driver itself.
>
> We don't need to have the blocklist anymore, but using hid-ids.h is
> still used, and sometimes has the benefit of raising eyebrows when you
> add support for a new device and realize that it was already defined.
> So keeping the list around is not so much of a bad thing.
>
> >
> > My take is that the patches could move the IDs from hid-ids.h to hid-
> > microsoft.c as they're changed. You then wouldn't need the macros, just
> > add a comment for each of variants, and that Wikipedia article can be
> > linked above the whole XBox controller section.
>
> We are definitely in the bikeshedding phase, but I would leave the
> code as it is in this patch :)
>
> One more comment below:
>
> >
> > What do you think?
> >
> > >
> > >
> > > On Wed, Mar 8, 2023 at 2:23=E2=80=AFAM Bastien Nocera <hadess@hadess.=
net>
> > > wrote:
> > > >
> > > > On Tue, 2023-03-07 at 13:35 -0800, Siarhei Vishniakou wrote:
> > > > > Currently, rumble is only supported via bluetooth on a single
> > > > > xbox
> > > > > controller, called 'model 1708'. On the back of the device, it's
> > > > > named
> > > > > 'wireless controller for xbox one'. However, in 2021, Microsoft
> > > > > released
> > > > > a firmware update for this controller. As part of this update,
> > > > > the
> > > > > HID
> > > > > descriptor of the device changed. The product ID was also changed
> > > > > from
> > > > > 0x02fd to 0x0b20. On this controller, rumble was supported via
> > > > > hid-microsoft, which matched against the old product id (0x02fd).
> > > > > As
> > > > > a
> > > > > result, the firmware update broke rumble support on this
> > > > > controller.
> > > > >
> > > > > The hid-microsoft driver actually supports rumble on the new
> > > > > firmware,
> > > > > as well. So simply adding new product id is sufficient to bring
> > > > > back
> > > > > this support.
> > > > >
> > > > > After discussing further with the xbox team, it was pointed out
> > > > > that
> > > > > another xbox controller, xbox elite series 2, can be supported in
> > > > > a
> > > > > similar way.
> > > > >
> > > > > Add rumble support for all of these devices in this patch. Two of
> > > > > the
> > > > > devices have received firmware updates that caused their product
> > > > > id's
> > > > > to
> > > > > change. Both old and new firmware versions of these devices were
> > > > > tested.
> > > > >
> > > > > The tested controllers are:
> > > > >
> > > > > 1. 'wireless controller for xbox one', model 1708
> > > > > 2. 'xbox wireless controller', model 1914. This is also sometimes
> > > > >    referred to as 'xbox series S|X'.
> > > > > 3. 'elite series 2', model 1797.
> > > > >
> > > > > The tested configurations are:
> > > > > 1. model 1708, pid 0x02fd (old firmware)
> > > > > 2. model 1708, pid 0x0b20 (new firmware)
> > > > > 3. model 1914, pid 0x0b13
> > > > > 4. model 1797, pid 0x0b05 (old firmware)
> > > > > 5. model 1797, pid 0x0b22 (new firmware)
> > > > >
> > > > > I verified rumble support on both bluetooth and usb.
> > > >
> > > > Looks good although I would personally have preferred separate
> > > > patches
> > > > for each controller.
> > > >
> > > > Reviewed-by: Bastien Nocera <hadess@hadess.net>
> > > >
> > > > Would a link to:
> > > > https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary
> > > > also be useful to make which model is which clearer in the minds of
> > > > future readers?
> > > >
> > > > Cheers
> > > >
> > > > >
> > > > > Signed-off-by: Siarhei Vishniakou <svv@google.com>
> > > > > Change-Id: I3337a7ab5f40759c85bf67bf0dbe5d4de31ce1ff
>
> That change-id should be dropped, it has no meaning to us.
>
> Cheers,
> Benjamin
>
> > > > > ---
> > > > >  drivers/hid/hid-ids.h       |  6 +++++-
> > > > >  drivers/hid/hid-microsoft.c | 11 ++++++++++-
> > > > >  2 files changed, 15 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > > index 053853a891c5..c9b75f8ba49a 100644
> > > > > --- a/drivers/hid/hid-ids.h
> > > > > +++ b/drivers/hid/hid-ids.h
> > > > > @@ -903,7 +903,11 @@
> > > > >  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> > > > >  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
> > > > >  #define USB_DEVICE_ID_MS_SURFACE3_COVER                0x07de
> > > > > -#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER 0x02fd
> > > > > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708    0x02fd
> > > > > +#define
> > > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE        0x0b20
> > > > > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914    0x0b13
> > > > > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797    0x0b05
> > > > > +#define
> > > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE        0x0b22
> > > > >  #define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
> > > > >  #define USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS      0x02e0
> > > > >
> > > > > diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-
> > > > > microsoft.c
> > > > > index 071fd093a5f4..9345e2bfd56e 100644
> > > > > --- a/drivers/hid/hid-microsoft.c
> > > > > +++ b/drivers/hid/hid-microsoft.c
> > > > > @@ -446,7 +446,16 @@ static const struct hid_device_id
> > > > > ms_devices[] =3D
> > > > > {
> > > > >                 .driver_data =3D MS_PRESENTER },
> > > > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
> > > > >                 .driver_data =3D MS_SURFACE_DIAL },
> > > > > -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
> > > > > +
> > > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708),
> > > > > +               .driver_data =3D MS_QUIRK_FF },
> > > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE),
> > > > > +               .driver_data =3D MS_QUIRK_FF },
> > > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914),
> > > > > +               .driver_data =3D MS_QUIRK_FF },
> > > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797),
> > > > > +               .driver_data =3D MS_QUIRK_FF },
> > > > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE),
> > > > >                 .driver_data =3D MS_QUIRK_FF },
> > > > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
> > > > >                 .driver_data =3D MS_QUIRK_FF },
> > > >
> >
>
