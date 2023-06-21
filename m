Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA5738A66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjFUQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFUQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF32E2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687363459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmT3Gc0lW/ucUiaDWp2AxDA5W8tEtcDlIAyVVWyU4Hk=;
        b=cCrXrIkMnhnZDnvXvNw7nz8Az5ZQjKMpqSz8A6o2nVKclHIPu7nUHwnlpfvmA8MkY37Uzp
        A41l0a3+V0a3wJM28eazQqBhAniLtQuEiZJmgJadKnS4g3woO8EkOHQMthJ6Aw1i9R+/cr
        xnN7z7+i8gh9nvC6m8KSVY7O5Q6nEcY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-r_7JhxSXN6KrsIQRxPtbnA-1; Wed, 21 Jun 2023 12:04:17 -0400
X-MC-Unique: r_7JhxSXN6KrsIQRxPtbnA-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-bb2a7308f21so7891764276.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363456; x=1689955456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmT3Gc0lW/ucUiaDWp2AxDA5W8tEtcDlIAyVVWyU4Hk=;
        b=cpl51L916b9wNu7LbULD9jfdz88JQDpBx+e+lsfxmYVKiH6ZtwMgfcaGob0TyB6Tw2
         kIXruz+zTPHsm14GXIqWA0B88bzFF9fDjLTdGUQ+j9vOWGVmMTK40tsy69Or633ebKx4
         QPZwcd/NFOjecs0svxxOWtcLO4D7JGEjWH3dqu3YIQ/6SqO6MlztF3YENuoOlzV0NgLV
         0ACG59Oid5fL5lHDmi0Hqflx5Zdi9zhwx7DjYJ4SNm5MBDhADipvvMXcnW+vIi3C/ekX
         zXv9/xat02lRlcz5LFVCUahnxGHaV14OiJqn+5JHCPA9WrK79SBO1KQDd1DTJN0BI+6m
         oi7w==
X-Gm-Message-State: AC+VfDxAqzoMDkWkbR8wz1OlFEAPC/kHr2KsLW6wz7qkQliZ/yxi5VhW
        84sHkLa5+eCRK+CzXshQv4B1gpIFDNPu9cqwI5i7Q1WR+JDchkEtOPsH0i6fqyKiXtNPDPXW5tw
        zhD4Abjageh7k4Ad26n8V+Xehf3nG8SvwK3Iiguku
X-Received: by 2002:a05:6902:cd:b0:bd5:9d1e:7182 with SMTP id i13-20020a05690200cd00b00bd59d1e7182mr12128740ybs.8.1687363456505;
        Wed, 21 Jun 2023 09:04:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kFwrrvmPXuFgNQH/CV48S0tndy+CEIheFsur0TrgAkaHEYIA3UQOJ56+HqPbjpaZnLwzdWC8X6uaAgsytr9M=
X-Received: by 2002:a05:6902:cd:b0:bd5:9d1e:7182 with SMTP id
 i13-20020a05690200cd00b00bd59d1e7182mr12128724ybs.8.1687363456267; Wed, 21
 Jun 2023 09:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230607214102.2113-1-jason.gerecke@wacom.com>
 <20230608213828.2108-1-jason.gerecke@wacom.com> <CANRwn3R-XbfB+mP9AQ-J7R_19jLi4eS3MhswaWjL+LCEih-7pg@mail.gmail.com>
In-Reply-To: <CANRwn3R-XbfB+mP9AQ-J7R_19jLi4eS3MhswaWjL+LCEih-7pg@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 21 Jun 2023 18:04:05 +0200
Message-ID: <CAO-hwJJC12dRhmykE+P_LBcEJ2G0gHy3Nh1gvWULjdA=4qa-ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Use ktime_t rather than int when dealing
 with timestamps
To:     Jason Gerecke <killertofu@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Joshua Dickens <Joshua@joshua-dickens.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 5:18=E2=80=AFPM Jason Gerecke <killertofu@gmail.com=
> wrote:
>
> Following up since no action seems to have been taken on this patch yet.

Sorry, this went through the cracks (I seem to have a lot of cracks recentl=
y...)

>
> On Thu, Jun 8, 2023 at 2:38=E2=80=AFPM Jason Gerecke <killertofu@gmail.co=
m> wrote:
> >
> > Code which interacts with timestamps needs to use the ktime_t type
> > returned by functions like ktime_get. The int type does not offer
> > enough space to store these values, and attempting to use it is a
> > recipe for problems. In this particular case, overflows would occur
> > when calculating/storing timestamps leading to incorrect values being
> > reported to userspace. In some cases these bad timestamps cause input
> > handling in userspace to appear hung.

I have to ask, is this something we should consider writing a test for? :)

Also, you are missing the rev-by from Peter, not sure if the tools
will pick it up automatically then.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> >
> > Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/901
> > Fixes: 17d793f3ed53 ("HID: wacom: insert timestamp to packed Bluetooth =
(BT) events")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> > ---
> > v2: Use div_u64 to perform division to deal with ARC and ARM architectu=
res
> >     (as found by the kernel test robot)
> >
> >  drivers/hid/wacom_wac.c | 6 +++---
> >  drivers/hid/wacom_wac.h | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index 2ccf838371343..174bf03908d7c 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -1314,7 +1314,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom=
_wac *wacom)
> >         struct input_dev *pen_input =3D wacom->pen_input;
> >         unsigned char *data =3D wacom->data;
> >         int number_of_valid_frames =3D 0;
> > -       int time_interval =3D 15000000;
> > +       ktime_t time_interval =3D 15000000;
> >         ktime_t time_packet_received =3D ktime_get();
> >         int i;
> >
> > @@ -1348,7 +1348,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom=
_wac *wacom)
> >         if (number_of_valid_frames) {
> >                 if (wacom->hid_data.time_delayed)
> >                         time_interval =3D ktime_get() - wacom->hid_data=
.time_delayed;
> > -               time_interval /=3D number_of_valid_frames;
> > +               time_interval =3D div_u64(time_interval, number_of_vali=
d_frames);
> >                 wacom->hid_data.time_delayed =3D time_packet_received;
> >         }
> >
> > @@ -1359,7 +1359,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom=
_wac *wacom)
> >                 bool range =3D frame[0] & 0x20;
> >                 bool invert =3D frame[0] & 0x10;
> >                 int frames_number_reversed =3D number_of_valid_frames -=
 i - 1;
> > -               int event_timestamp =3D time_packet_received - frames_n=
umber_reversed * time_interval;
> > +               ktime_t event_timestamp =3D time_packet_received - fram=
es_number_reversed * time_interval;
> >
> >                 if (!valid)
> >                         continue;
> > diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> > index 1a40bb8c5810c..ee21bb260f22f 100644
> > --- a/drivers/hid/wacom_wac.h
> > +++ b/drivers/hid/wacom_wac.h
> > @@ -324,7 +324,7 @@ struct hid_data {
> >         int ps_connected;
> >         bool pad_input_event_flag;
> >         unsigned short sequence_number;
> > -       int time_delayed;
> > +       ktime_t time_delayed;
> >  };
> >
> >  struct wacom_remote_data {
> > --
> > 2.41.0
> >
>

