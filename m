Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93E64394F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiLEXLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiLEXLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:11:07 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E953220F8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:09:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y4so12272924plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e23CQ4Of3n71h16nlBdskc3Z0iSFIB79oIvFw9pwVsQ=;
        b=h7ukt0GCyk2bbM9YupPMrgxzGblOPOvkNeE6HRTNxj6vYaqfjHIINzWrFvwj4IXumC
         eytVJVwpUSxz4kSfqoZlyW5BC7eL4+3Z0HE8yF77gOIhHoHKrKyTSrpWJG2SkNy5itLD
         Qd+nv1WVc1uJ6ZpjXj0F/GhG32DXFkoFIaAWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e23CQ4Of3n71h16nlBdskc3Z0iSFIB79oIvFw9pwVsQ=;
        b=bboIcRODxxtoqaOEddA9SBX03+iLyNjgR0Z3mIKQKwAMXbkaUzTCsuJxIxk7ZIYZag
         lXKk1xVtoz5XIfkVzBBEH0gMFTUp7tHVRbgo9RDalj1I9tELSI61gQ3PP6i8Rx1M2tLr
         Xyg6zZgKl9fCNeLfk6pmeiDKa3/AhXKtH9lJNzB0/FQWwPFtTlEETb0Iv5lEGZc/LxmP
         2WYdfRncQHIgJf9PTboD3g8OAJb7NCtiYqXdEQATZsW22XEkZPkmcRV2X/N4jgwqgtpT
         c6pPDPeXcaX/41E0LQVupuXxi3dUHDRenq1YCcBmxSjs8OOqCTTJz6IS2iEYciRw4uB0
         DTXw==
X-Gm-Message-State: ANoB5pn9Lnafnojp6z9pYLz6RVBfcFQ74CW5ED5jpOwduCkNxn3XjnXV
        D/3pQ9Kp9eJjKadoe8HF0sCF1GaFMqC4uxW6AQY=
X-Google-Smtp-Source: AA0mqf5BlQ7wyk2UcRYPSHrrVe3BVOD0gxXybINbpr2SAs8KCC8M+zbzxMLt6Bp93IPVKNNeQ74XUw==
X-Received: by 2002:a17:902:b490:b0:189:5ba2:4907 with SMTP id y16-20020a170902b49000b001895ba24907mr58294816plr.113.1670281777424;
        Mon, 05 Dec 2022 15:09:37 -0800 (PST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709028f8100b00188fcc4fc00sm11125278plo.79.2022.12.05.15.09.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 15:09:36 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id w37so11816431pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:09:36 -0800 (PST)
X-Received: by 2002:aa7:8dd3:0:b0:573:4ae5:e475 with SMTP id
 j19-20020aa78dd3000000b005734ae5e475mr66539224pfr.64.1670281776004; Mon, 05
 Dec 2022 15:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-elgato-v3-0-57668054127f@chromium.org>
 <Y45zApHY34WocyeM@pendragon.ideasonboard.com> <CANiDSCvtUmGzxOZLPXP5bxg5HRDGkn_=8tGx8qqa6R_ssJUpww@mail.gmail.com>
 <Y452xN7BzTdYIEIM@pendragon.ideasonboard.com>
In-Reply-To: <Y452xN7BzTdYIEIM@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 6 Dec 2022 00:09:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCv=i=tOYK1HDrdPh0yxpPGtrtuHhAJz4c7MwMmzW2WhEw@mail.gmail.com>
Message-ID: <CANiDSCv=i=tOYK1HDrdPh0yxpPGtrtuHhAJz4c7MwMmzW2WhEw@mail.gmail.com>
Subject: Re: [PATCH v3] media: uvcvideo: Recover stalled ElGato devices
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 at 23:55, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Mon, Dec 05, 2022 at 11:45:43PM +0100, Ricardo Ribalda wrote:
> > On Mon, 5 Dec 2022 at 23:39, Laurent Pinchart wrote:
> > > On Mon, Dec 05, 2022 at 01:53:01PM +0100, Ricardo Ribalda wrote:
> > > > Elgato Cam Link 4k can be in a stalled state if the resolution of
> > > > the external source has changed while the firmware initializes.
> > > > Once in this state, the device is useless until it receives a
> > > > USB reset. It has even been observed that the stalled state will
> > > > continue even after unplugging the device.
> > >
> > > Why, =C3=B4, why :'-(
> > >
> > > > lsusb -v
> > > >
> > > > Bus 002 Device 002: ID 0fd9:0066 Elgato Systems GmbH Cam Link 4K
> > > > Device Descriptor:
> > > >   bLength                18
> > > >   bDescriptorType         1
> > > >   bcdUSB               3.00
> > > >   bDeviceClass          239 Miscellaneous Device
> > > >   bDeviceSubClass         2
> > > >   bDeviceProtocol         1 Interface Association
> > > >   bMaxPacketSize0         9
> > > >   idVendor           0x0fd9 Elgato Systems GmbH
> > > >   idProduct          0x0066
> > > >   bcdDevice            0.00
> > > >   iManufacturer           1 Elgato
> > > >   iProduct                2 Cam Link 4K
> > > >   iSerial                 4 0005AC52FE000
> > > >   bNumConfigurations      1
> > > >
> > > > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > > Recover stalled ElGato devices
> > > >
> > > > Just a resend of this hw fix.
> > > >
> > > > To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > To: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > > Cc: linux-media@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > Cc: Yunke Cao <yunkec@chromium.org>
> > > > ---
> > > > Changes in v3:
> > > > - Add Reviewed-by: Sergey
> > > > - Improve identation (Thanks Sergey!)
> > > > - Link to v2: https://lore.kernel.org/r/20220920-resend-elgato-v2-0=
-06b48b3b486a@chromium.org
> > > >
> > > > Changes in v2:
> > > > - Remove info from lsusb
> > > > - Link to v1: https://lore.kernel.org/r/20220920-resend-elgato-v1-0=
-8672a2380e3d@chromium.org
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 23 +++++++++++++++++++----
> > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/=
uvc/uvc_video.c
> > > > index 170a008f4006..a8323cf0e9f9 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -129,12 +129,13 @@ int uvc_query_ctrl(struct uvc_device *dev, u8=
 query, u8 unit,
> > > >       return -EPIPE;
> > > >  }
> > > >
> > > > +static const struct usb_device_id elgato_cam_link_4k =3D {
> > > > +     USB_DEVICE(0x0fd9, 0x0066)
> > > > +};
> > > > +
> > > >  static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
> > > >       struct uvc_streaming_control *ctrl)
> > > >  {
> > > > -     static const struct usb_device_id elgato_cam_link_4k =3D {
> > > > -             USB_DEVICE(0x0fd9, 0x0066)
> > > > -     };
> > > >       struct uvc_format *format =3D NULL;
> > > >       struct uvc_frame *frame =3D NULL;
> > > >       unsigned int i;
> > > > @@ -297,7 +298,7 @@ static int uvc_get_video_ctrl(struct uvc_stream=
ing *stream,
> > > >               dev_err(&stream->intf->dev,
> > > >                       "Failed to query (%u) UVC %s control : %d (ex=
p. %u).\n",
> > > >                       query, probe ? "probe" : "commit", ret, size)=
;
> > > > -             ret =3D -EIO;
> > > > +             ret =3D (ret =3D=3D -EPROTO) ? -EPROTO : -EIO;
> > >
> > > This will change the error returned by VIDIOC_S_FMT and VIDIOC_TRY_FM=
T,
> > > but I don't think that will cause issues.
> > >
> > > >               goto out;
> > > >       }
> > > >
> > > > @@ -2121,6 +2122,20 @@ int uvc_video_init(struct uvc_streaming *str=
eam)
> > > >        * request on the probe control, as required by the UVC speci=
fication.
> > > >        */
> > > >       ret =3D uvc_get_video_ctrl(stream, probe, 1, UVC_GET_CUR);
> > > > +
> > > > +     /*
> > > > +      * Elgato Cam Link 4k can be in a stalled state if the resolu=
tion of
> > > > +      * the external source has changed while the firmware initial=
izes.
> > > > +      * Once in this state, the device is useless until it receive=
s a
> > > > +      * USB reset. It has even been observed that the stalled stat=
e will
> > > > +      * continue even after unplugging the device.
> > > > +      */
> > > > +     if (usb_match_one_id(stream->dev->intf, &elgato_cam_link_4k) =
&&
> > > > +         (ret =3D=3D -EPROTO)) {
> > >
> > > I'd swap the tests, as the second one is cheaper. You also don't need
> > > the inner parentheses.
> > >
> > > > +             usb_reset_device(stream->dev->udev);
> > > > +             dev_err(&stream->intf->dev, "Restarting Elgato Cam Li=
nk 4K\n");
> > >
> > > I would also swap those two lines, if an error occurs when resetting =
the
> > > device, it's good to have the "restarting" message printed first.
> > >
> > > If I understand this correctly, probe will still fail, and the user w=
ill
> > > have to unplug and replug the device to fix this, right ? If so I'd
> > > expand the error message, maybe something along those lines:
> >
> > I kind of recall that it was not needed to replug the device. Will
> > test on real hardware to confirm.
>
> How does it get reprobed then ? By unloading and reloading the driver
> (or unbinding and rebinding the device through sysfs) ?

Just went through the internal bug report. We were rebinding the
driver during the test.

Will add the "unplug-replug" message

Thanks!



>
> > >                 dev_err(&stream->intf->dev, "Elgato Cam Link 4K firmw=
are crash detected\n");
> > >                 dev_err(&stream->intf->dev, "Resetting the device, un=
plug and replug to recover\n");
> > >
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >
> > > > +     }
> > > > +
> > > >       if (ret < 0)
> > > >               return ret;
> > > >
> > > >
> > > > ---
> > > > base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
> > > > change-id: 20220920-resend-elgato-a845482bdd02
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Ricardo Ribalda
