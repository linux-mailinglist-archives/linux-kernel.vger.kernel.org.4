Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9424B6A147F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBXBHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXBHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:07:44 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956651FA0;
        Thu, 23 Feb 2023 17:07:42 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f16so12607503ljq.10;
        Thu, 23 Feb 2023 17:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKP58RKTjVR9KbKXhS/DjQ9kFA0VAld4uhg1bNS+qr8=;
        b=ZTcsrlWN2VkHEIbo2LRmWq6lG9+cv0IeSGxoNK9tsbu63+hKVJD/mNUXmB21lYY5cN
         N8VG/N/XvmMHJUZi9smfcoe7Stqwyx0KOpU+IEPRqVBmMDmCQwodEy6YT67MjCmDyOiM
         BA4IXIsAOC494JtAr435X2WmLmFCFHeTCaCfCJc5gBjrlrD4NZ3I48+kqzXuxKMPL+Xg
         9wY0geuD4ST0rKisKRKqAWJ7o63FS9+Xa0Dp7qw+RXZSzTtRANEMZFO+H/+lLtJJp21N
         PJSSGbmxs1E+KlOqPmTCD8gx6UPLaVCTVehvGUAdOgP4G5hiTSI5g0ImPAAJlCHZNMUh
         RyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKP58RKTjVR9KbKXhS/DjQ9kFA0VAld4uhg1bNS+qr8=;
        b=s/hJ2Jl7yl22szjn2EdxvYQ4zi2alZT+C5DUIwz8CPp5HjkiFq9gJfI7G/0Og3cNr9
         OxoMAmh8zhSgAJYphQpMz9gCufFJ9897jXhLlg6qUYg8VMRyQYC3cSs79NFqfwVPfqfd
         g+zHtIBSFtNwUo6Aw6XRhS/DNPtfh7Gt9HfU0zaro5vAZ/2CUQgAHajKy3TltP2yz9Aq
         biu4H8kzBj3zyZi5EJhv+hITbDsMr0vuFwkCcU31xqH084MJTn3F66dD3pMFL2JFVAHD
         r+mZFHJtLPjTl+sjgVBOkAidu17I1LRMUpk6H6b1UHyuJsWRIcvuAW7R1ygrcrl3h4xZ
         IYqQ==
X-Gm-Message-State: AO0yUKVpenTD+LmsxeS7d1gRVA++l0YaL4SkCYYu4XcblC1Wc/8XJQZC
        c0PK7ZrL83DFfym2/4vilTaTPbeB0Llmc2H06xc=
X-Google-Smtp-Source: AK7set9MMzXskWYs/Ap1VEfv0l5QkrdYO+Pudf7Wfj6u9haqvLw19PBCpH2UmsjwHHw1UOGB1pFsqBmeSHqPpL+aCic=
X-Received: by 2002:a2e:a4b4:0:b0:295:a5cd:3baf with SMTP id
 g20-20020a2ea4b4000000b00295a5cd3bafmr33794ljm.9.1677200860816; Thu, 23 Feb
 2023 17:07:40 -0800 (PST)
MIME-Version: 1.0
References: <8ca5bf9ce1f544096a3ff88b743381bc9e60a76d.camel@intel.com>
 <20230217193142.6954-1-mat.jonczyk@o2.pl> <47a7437770e60480343ed9d719c66fdcac71c611.camel@intel.com>
In-Reply-To: <47a7437770e60480343ed9d719c66fdcac71c611.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Feb 2023 17:07:29 -0800
Message-ID: <CABBYNZKxbXUZVua3nuEJXjzAU7jFhsRA3M1e4vQrMEwW8OQi0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Thu, Feb 23, 2023 at 2:21 PM Gix, Brian <brian.gix@intel.com> wrote:
>
> Hi Luiz,
>
> Do you need the original patch re-generated, or can you find it in this
> thread?

Please resend it so CI can pick it up and ensures it still builds properly.

> On Fri, 2023-02-17 at 20:31 +0100, Mateusz Jo=C5=84czyk wrote:
> > W dniu 21.11.2022 o 19:48, Gix, Brian pisze:
> > > Hi Mateusz,
> > >
> > > On Sat, 2022-11-19 at 19:26 +0100, Mateusz Jo=C5=84czyk wrote:
> > > > W dniu 2.11.2022 o 18:59, Brian Gix pisze:
> > > > > The msft_set_filter_enable() command was using the deprecated
> > > > > hci_request mechanism rather than hci_sync. This caused the
> > > > > warning
> > > > > error:
> > > > > hci0: HCI_REQ-0xfcf0
> > > > >
> > > > > Signed-off-by: Brian Gix <brian.gix@intel.com>
> > > > > ---
> > > > >  net/bluetooth/msft.c | 36 +++++++++++-------------------------
> > > > >  1 file changed, 11 insertions(+), 25 deletions(-)
> > > >
> > > > Hello,
> > > >
> > > > On the first time I was testing this patch, I was heavily testing
> > > > various Bluetooth functionality. Eventually, something stopped
> > > > working
> > > > and I was no longer able to establish a Bluetooth connection
> > > > between
> > > > my mobile phone and my laptop. To try to resolve this issue, I
> > > > tried
> > > > suspending
> > > > my laptop, but after resume, I got a kernel panic (dmesg attached
> > > > below, I may
> > > > provide journal extracts on request).
> >
> > Hello,
> >
> > I have to apologize for the delay.
> >
> > This kernel panic happened to me again, without this patch so now I
> > can
> > say that it is unrelated. I have again tested the patch you provided
> > and
> > Bluetooth with it appeared to be working correctly. I have even
> > tested
> > with a mobile app called "Beacon Simulator" [1] and the beacon was
> > successfully found on my laptop.
> >
> > I have tested this on top of 6.2.0-rc8.
> >
> > Additionally, to see how it worked, I tested it with some debugging
> > printks and additional calls to
> >         msft_set_filter_enable(hdev, X);
> > (patch attached below) and the code appears to do as it is intended,
> > but
> > when I combined two
> >         msft_set_filter_enable(hdev, true);
> > calls one after the other, I got something like this:
> >
> >         Bluetooth: hci0: BEGIN msft_set_filter_enable(hdev, 1)
> >         Bluetooth: hci0: BEGIN
> > msft_le_set_advertisement_filter_enable_cb(hdev, user_data, 0)
> >         Bluetooth: hci0: END msft_set_filter_enable(hdev, 1), err =3D 0
> >         Bluetooth: hci0: BEGIN msft_set_filter_enable(hdev, 1)
> >         Bluetooth: hci0: Opcode 0xfcf0 failed: -16
> >         Bluetooth: hci0: BEGIN
> > msft_le_set_advertisement_filter_enable_cb(hdev, user_data, f0)
> >         Bluetooth: hci0: END msft_set_filter_enable(hdev, 1), err =3D -
> > 16
> >
> > instead of the error code 0x0C as is described in a comment in
> > msft_le_set_advertisement_filter_enable_cb() and the Microsoft
> > specification. Is this expected?
> >
> > In msft_set_filter_enable() your patch also casts err from int to u8
> > while calling msft_le_set_advertisement_filter_enable_cb() without
> > checking its sign.
> >
> > Greetings,
> >
> > Mateusz
> >
> > [1]
> > https://play.google.com/store/apps/details?id=3Dnet.alea.beaconsimulato=
r
> >
> > Cc: Luiz Von Dentz <luiz.von.dentz@intel.com>
> >
> > ---
> >  net/bluetooth/msft.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
> > index bf5cee48916c..a6f594bd0722 100644
> > --- a/net/bluetooth/msft.c
> > +++ b/net/bluetooth/msft.c
> > @@ -6,6 +6,7 @@
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <net/bluetooth/hci_core.h>
> >  #include <net/bluetooth/mgmt.h>
> > +#include <linux/delay.h>
> >
> >  #include "hci_request.h"
> >  #include "mgmt_util.h"
> > @@ -527,6 +528,12 @@ void msft_do_open(struct hci_dev *hdev)
> >         if (msft_monitor_supported(hdev)) {
> >                 msft->resuming =3D true;
> >                 msft_set_filter_enable(hdev, true);
> > +               mdelay(1);
> > +               msft_set_filter_enable(hdev, false);
> > +               mdelay(1);
> > +               msft_set_filter_enable(hdev, true);
> > +               mdelay(1);
> > +               msft_set_filter_enable(hdev, true);
> >                 /* Monitors get removed on power off, so we need to
> > explicitly
> >                  * tell the controller to re-monitor.
> >                  */
> > @@ -749,6 +756,8 @@ static void
> > msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
> >         struct msft_cp_le_set_advertisement_filter_enable *cp =3D
> > user_data;
> >         struct msft_data *msft =3D hdev->msft_data;
> >
> > +       bt_dev_warn(hdev, "BEGIN
> > msft_le_set_advertisement_filter_enable_cb(hdev, user_data, %x)",
> > (unsigned) status);
> > +
> >         /* Error 0x0C would be returned if the filter enabled status
> > is
> >          * already set to whatever we were trying to set.
> >          * Although the default state should be disabled, some
> > controller set
> > @@ -804,6 +813,8 @@ int msft_set_filter_enable(struct hci_dev *hdev,
> > bool enable)
> >         struct msft_data *msft =3D hdev->msft_data;
> >         int err;
> >
> > +       bt_dev_warn(hdev, "BEGIN msft_set_filter_enable(hdev, %d)",
> > (int) enable);
> > +
> >         if (!msft)
> >                 return -EOPNOTSUPP;
> >
> > @@ -814,6 +825,8 @@ int msft_set_filter_enable(struct hci_dev *hdev,
> > bool enable)
> >
> >         msft_le_set_advertisement_filter_enable_cb(hdev, &cp, err);
> >
> > +       bt_dev_warn(hdev, "END msft_set_filter_enable(hdev, %d), err
> > =3D %d", (int) enable, err);
> > +
> >         return 0;
> >  }
> >
>


--=20
Luiz Augusto von Dentz
