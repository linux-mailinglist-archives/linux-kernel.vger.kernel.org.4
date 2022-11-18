Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064D262F0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbiKRJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241798AbiKRJMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:12:24 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16CBBF72
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:12:18 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n188so3382844iof.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NLsExkTQRD/KnCK+VgZa80ipWuwDokxoxfdxECYJsw=;
        b=k514VFb7op0zkhFildJQXj/PR0qQCyUXaviqec2rGZ5m3ibzB77sNI+6k94AvMal+m
         2DF5idsx4KJsOfJX4q5eFZNYLCuZRb6JKJhEMJhKdS8qSdPGkpOPpml/iOoWzowfs99/
         oeQR99VlpUPuof25iTCBQV+ogXZmS1t/HVUCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NLsExkTQRD/KnCK+VgZa80ipWuwDokxoxfdxECYJsw=;
        b=1KMkWLOpa1fVydQRNETARO7cTavnfqfnSsO2A2nLv5YgePyCq0HtF1LAwmIipPhwI4
         Rt7JcCIyswpkCqtKhV4goPTnOCqiFrAJDdzIuyaCZDjjdSAWaU1hQXUy5tlj1wjCX1oc
         iVvRxfKRukYUjIS7/QW8crulDYoHWife9NLxw+gQG44do3fdBSxMTep9MqZzq744lkUt
         bpC+/urHwfSh8ROIhgQHOLzT8c+dTnhpmmcIgfeuVFSja/MYrnVck4F8ThUXjkqfa1QM
         xNbVchhxN67nM2BCikEh6Xl3A7lvz2HM2zK+/raJIegLc5d+mzMyuEx+e3Akj0t0qd5g
         Iq6w==
X-Gm-Message-State: ANoB5pkfLtgCjoLxuoZN9NYWCsi1ME6c/WKNz+ypdAnYIixsgiGy2Wj8
        vj+Pvvx8my8s9sL3PVurWINOYb++gEW/8A==
X-Google-Smtp-Source: AA0mqf51bWY99n564qMG2zLtLNKRT/IaiC97awJ88drNVj9+OI4NEptM8DLFLYDga7iUCe//GU4DYA==
X-Received: by 2002:a02:7829:0:b0:363:ae32:346f with SMTP id p41-20020a027829000000b00363ae32346fmr2915984jac.31.1668762737933;
        Fri, 18 Nov 2022 01:12:17 -0800 (PST)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id x3-20020a056638026300b003759b13c639sm1046326jaq.97.2022.11.18.01.12.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 01:12:16 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id h2so1555971ile.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:12:16 -0800 (PST)
X-Received: by 2002:a05:6e02:c61:b0:300:f4ed:47f8 with SMTP id
 f1-20020a056e020c6100b00300f4ed47f8mr2831778ilj.243.1668762735853; Fri, 18
 Nov 2022 01:12:15 -0800 (PST)
MIME-Version: 1.0
References: <19g9yqb7lrp-19gb8o4mnli@nsmail6.0>
In-Reply-To: <19g9yqb7lrp-19gb8o4mnli@nsmail6.0>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 18 Nov 2022 10:12:05 +0100
X-Gmail-Original-Message-ID: <CANiDSCs2y6zOu09sxU60NX7se-N=wq3Z6USQz+XckQt7rC=3xg@mail.gmail.com>
Message-ID: <CANiDSCs2y6zOu09sxU60NX7se-N=wq3Z6USQz+XckQt7rC=3xg@mail.gmail.com>
Subject: Re: Re: [PATCH v3] media: uvcvideo: Fix bandwidth error for Alcor camera
To:     =?UTF-8?B?6Im+6LaF?= <aichao@kylinos.cn>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Ai

On Fri, 18 Nov 2022 at 10:09, =E8=89=BE=E8=B6=85 <aichao@kylinos.cn> wrote:
>
> Hi Ricardo
>
>
> > 3072 is smaller than 0x1000.
> > It is ok to have values between 1024 and 0x1000 (4096) ?

Wouldn't it make more sense ?
  ctrl->dwMaxPayloadTransferSize =3D 0x1000;


The value 1000 seems a bit random, specially when your compare your
range with 4096
>
>
> Yes,  for some new device which requested 3072 B/frame bandwidth,  that t=
he camera preview normally.
>
>
>
>
> ----
>
>
>
>
>
>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH v3] media: uvcvideo: Fix b=
andwidth error for Alcor camera
> =E6=97=A5=E3=80=80=E6=9C=9F=EF=BC=9A2022-11-18 16:15
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Aribalda@chromium.org
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E8=89=BE=E8=B6=85
>
>
> Hi Ai
>
> Thanks for your patch!
>
> On Fri, 18 Nov 2022 at 03:23, Ai Chao <aichao@kylinos.cn> wrote:
> >
> > For Alcor Corp. Slave camera(1b17:6684/2017:0011), it support to
> > output compressed video data, and it return a wrong
> > dwMaxPayloadTransferSize fields. This is a fireware issue,
> s/fireware/firmware/
> > but the manufacturer cannot provide a const return fields
> > by the fireware. For some device, device requested 2752512
> >  B/frame bandwidth. For some device, device requested 3072
> >  B/frame bandwidth. so we check the dwMaxPayloadTransferSize
> >  fields,if it large than 0x1000, reset dwMaxPayloadTransferSize
> > to 1024, and the camera preview normally.
>
> 3072 is smaller than 0x1000.
>
> It is ok to have values between 1024 and 0x1000 (4096) ?
>
> Thanks
>
> >
> > Signed-off-by: Ai Chao <aichao@kylinos.cn>
> >
> > ---
> > change for v3
> > - Add VID/PID 2017:0011
> >
> > change for v2
> > - Used usb_match_one_id to check VID and PID
> > ---
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/=
uvc_video.c
> > index d2eb9066e4dc..1260800ef8bd 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -135,6 +135,10 @@ static void uvc_fixup_video_ctrl(struct uvc_stream=
ing *stream,
> >         static const struct usb_device_id elgato_cam_link_4k =3D {
> >                 USB_DEVICE(0x0fd9, 0x0066)
> >         };
> > +       static const struct usb_device_id alcor_corp_slave_cam =3D {
> > +               USB_DEVICE(0x1b17, 0x6684),
> > +               USB_DEVICE(0x2017, 0x0011),
> > +       };
> >         struct uvc_format *format =3D NULL;
> >         struct uvc_frame *frame =3D NULL;
> >         unsigned int i;
> > @@ -234,6 +238,13 @@ static void uvc_fixup_video_ctrl(struct uvc_stream=
ing *stream,
> >
> >                 ctrl->dwMaxPayloadTransferSize =3D bandwidth;
> >         }
> > +
> > +       /* Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSi=
ze */
> > +       if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
> > +           (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
> > +            usb_match_one_id(stream->dev->intf, &alcor_corp_slave_cam)=
) {
> > +               ctrl->dwMaxPayloadTransferSize =3D 1024;
> > +       }
> >  }
> >
> >  static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
> > --
> > 2.25.1
> >
>
>
> --
> Ricardo Ribalda



--=20
Ricardo Ribalda
