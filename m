Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7975664384E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiLEWqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLEWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:45:58 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E3EFCC9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:45:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c13so5730080pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s+bm99+doIkRwfVELN2qRHh3B9ntF+AKQD6hPTAD4Y=;
        b=mUAztfqIBGhPSvlFGL2ng+ET9BndKJfc+GSM6KcZdFsp33W5Cf8tZ9c65k/JuE2pKZ
         RLIfISxkiB2kDN0KFOsEUt16MWROcdvt2Lh0PYXxMvozAhuI+Xe6+1dA0FGfp9n6h0cu
         4Om3aOAcDmZJ5j0HTekhIFuKkZTIw/eu751Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s+bm99+doIkRwfVELN2qRHh3B9ntF+AKQD6hPTAD4Y=;
        b=N3nV6BLKs7hJ5BpGJrg1G53xpKn9M20eo6B4ECG9M7uODzM9H1u5WLFM6oFh7CWO/7
         2e2TvjGHgt8NFRkn9O+44ipcgssP1GbZfYmLRriqPiYqiXMyrIT7OPhkyYVPYUvnkY0I
         XUv43wnfuGoeb3C2BZXuYOg1tRYwYjuy1I080gAejH1ZiQzKD/zy4J+PcswKyBLuq46g
         DoJlNGIZWCAWovsTVLuBN+J6di4zximfxlUX3DV2b0dmi9RH9Hie+IcU/fQCNcL3EHQE
         XeFXUDIovk+4fvaBB24VGZ4nRiPVr4sAx7lPtNlksWMP1WoyuckTWljNWHvzjYt/V0OC
         0M6Q==
X-Gm-Message-State: ANoB5pktXNkhjjSKiSDjzsjLZw/TgW7ACArkD2MedVbPl12OpfvRtN8i
        Bv/ahYBi2ASSSdZhe+1uUh4Gbjar6jGrYuYWlJk=
X-Google-Smtp-Source: AA0mqf4ktx27tn5Z0hTZ/9eXXRNzkNILIsVJDbXvS7WaCzQwdnblCoOEVVPIWPfhxIqWeYh9P1A6Ww==
X-Received: by 2002:a63:6e01:0:b0:478:d6ed:1e97 with SMTP id j1-20020a636e01000000b00478d6ed1e97mr1918142pgc.554.1670280355916;
        Mon, 05 Dec 2022 14:45:55 -0800 (PST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a384400b00212c27abcaesm11527844pjf.17.2022.12.05.14.45.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 14:45:55 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id d82so4089665pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:45:54 -0800 (PST)
X-Received: by 2002:a63:e646:0:b0:470:15cd:d428 with SMTP id
 p6-20020a63e646000000b0047015cdd428mr77885660pgj.213.1670280354383; Mon, 05
 Dec 2022 14:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-elgato-v3-0-57668054127f@chromium.org> <Y45zApHY34WocyeM@pendragon.ideasonboard.com>
In-Reply-To: <Y45zApHY34WocyeM@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 5 Dec 2022 23:45:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCvtUmGzxOZLPXP5bxg5HRDGkn_=8tGx8qqa6R_ssJUpww@mail.gmail.com>
Message-ID: <CANiDSCvtUmGzxOZLPXP5bxg5HRDGkn_=8tGx8qqa6R_ssJUpww@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

Thanks for your review

On Mon, 5 Dec 2022 at 23:39, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, Dec 05, 2022 at 01:53:01PM +0100, Ricardo Ribalda wrote:
> > Elgato Cam Link 4k can be in a stalled state if the resolution of
> > the external source has changed while the firmware initializes.
> > Once in this state, the device is useless until it receives a
> > USB reset. It has even been observed that the stalled state will
> > continue even after unplugging the device.
>
> Why, =C3=B4, why :'-(
>
> > lsusb -v
> >
> > Bus 002 Device 002: ID 0fd9:0066 Elgato Systems GmbH Cam Link 4K
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               3.00
> >   bDeviceClass          239 Miscellaneous Device
> >   bDeviceSubClass         2
> >   bDeviceProtocol         1 Interface Association
> >   bMaxPacketSize0         9
> >   idVendor           0x0fd9 Elgato Systems GmbH
> >   idProduct          0x0066
> >   bcdDevice            0.00
> >   iManufacturer           1 Elgato
> >   iProduct                2 Cam Link 4K
> >   iSerial                 4 0005AC52FE000
> >   bNumConfigurations      1
> >
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Recover stalled ElGato devices
> >
> > Just a resend of this hw fix.
> >
> > To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > To: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: Yunke Cao <yunkec@chromium.org>
> > ---
> > Changes in v3:
> > - Add Reviewed-by: Sergey
> > - Improve identation (Thanks Sergey!)
> > - Link to v2: https://lore.kernel.org/r/20220920-resend-elgato-v2-0-06b=
48b3b486a@chromium.org
> >
> > Changes in v2:
> > - Remove info from lsusb
> > - Link to v1: https://lore.kernel.org/r/20220920-resend-elgato-v1-0-867=
2a2380e3d@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/=
uvc_video.c
> > index 170a008f4006..a8323cf0e9f9 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -129,12 +129,13 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 que=
ry, u8 unit,
> >       return -EPIPE;
> >  }
> >
> > +static const struct usb_device_id elgato_cam_link_4k =3D {
> > +     USB_DEVICE(0x0fd9, 0x0066)
> > +};
> > +
> >  static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
> >       struct uvc_streaming_control *ctrl)
> >  {
> > -     static const struct usb_device_id elgato_cam_link_4k =3D {
> > -             USB_DEVICE(0x0fd9, 0x0066)
> > -     };
> >       struct uvc_format *format =3D NULL;
> >       struct uvc_frame *frame =3D NULL;
> >       unsigned int i;
> > @@ -297,7 +298,7 @@ static int uvc_get_video_ctrl(struct uvc_streaming =
*stream,
> >               dev_err(&stream->intf->dev,
> >                       "Failed to query (%u) UVC %s control : %d (exp. %=
u).\n",
> >                       query, probe ? "probe" : "commit", ret, size);
> > -             ret =3D -EIO;
> > +             ret =3D (ret =3D=3D -EPROTO) ? -EPROTO : -EIO;
>
> This will change the error returned by VIDIOC_S_FMT and VIDIOC_TRY_FMT,
> but I don't think that will cause issues.
>
> >               goto out;
> >       }
> >
> > @@ -2121,6 +2122,20 @@ int uvc_video_init(struct uvc_streaming *stream)
> >        * request on the probe control, as required by the UVC specifica=
tion.
> >        */
> >       ret =3D uvc_get_video_ctrl(stream, probe, 1, UVC_GET_CUR);
> > +
> > +     /*
> > +      * Elgato Cam Link 4k can be in a stalled state if the resolution=
 of
> > +      * the external source has changed while the firmware initializes=
.
> > +      * Once in this state, the device is useless until it receives a
> > +      * USB reset. It has even been observed that the stalled state wi=
ll
> > +      * continue even after unplugging the device.
> > +      */
> > +     if (usb_match_one_id(stream->dev->intf, &elgato_cam_link_4k) &&
> > +         (ret =3D=3D -EPROTO)) {
>
> I'd swap the tests, as the second one is cheaper. You also don't need
> the inner parentheses.
>
> > +             usb_reset_device(stream->dev->udev);
> > +             dev_err(&stream->intf->dev, "Restarting Elgato Cam Link 4=
K\n");
>
> I would also swap those two lines, if an error occurs when resetting the
> device, it's good to have the "restarting" message printed first.
>
> If I understand this correctly, probe will still fail, and the user will
> have to unplug and replug the device to fix this, right ? If so I'd
> expand the error message, maybe something along those lines:

I kind of recall that it was not needed to replug the device. Will
test on real hardware to confirm.


>
>                 dev_err(&stream->intf->dev, "Elgato Cam Link 4K firmware =
crash detected\n");
>                 dev_err(&stream->intf->dev, "Resetting the device, unplug=
 and replug to recover\n");
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > +     }
> > +
> >       if (ret < 0)
> >               return ret;
> >
> >
> > ---
> > base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
> > change-id: 20220920-resend-elgato-a845482bdd02
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Ricardo Ribalda
