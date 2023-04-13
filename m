Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7556E12A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDMQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDMQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:46:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B10493F4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:46:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c3so16670277pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681404381; x=1683996381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0h0KR6elNnNqXKvjoeKJcNlR6E45HlPbpf02lsirvk=;
        b=lAWIIiar6znvVMTNS5FSjWiS2KF5uQyvgo/lWJhKpkacy84wCkIK2xwiMiXySaOtEF
         AInrn4fdEd/AeLHvSiEjIuEFrHfyllQA1jRJwSXK76v7oRvdEByGtECDVriJPV/h8BJU
         di9BMUiJYsDU9ZlVd5SSqF0AsKcD8ajKcLDyGgnewzdPzWw2sLaVSA+SwcwI+ybJV2jC
         ht6zqz9d56yrjULi5T+BtsHEkjIsjRd+oxVNuM6o7qbr+CB3gTKhIyZuZQZU7okE3fVh
         8T6ACcRZXYK7UNd8iU17S1Shi5CeKzKk+Iz2c0ezB6EKhSjTlfzhNz6mplKGoTVum+ws
         1X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681404381; x=1683996381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0h0KR6elNnNqXKvjoeKJcNlR6E45HlPbpf02lsirvk=;
        b=dcKnerq+NjFVZi6PqNfNsIMvXxRWDT2xG3grBBN0i1zo15unLyF8ieGGzkRDKoCxpG
         Qe57q45fmcQOEZiKfx3yRZ4Rixbu6TpnNdco+iVg+wIYFnb7jv2M1plbxt1vWyR+clJG
         pj5GSC4m3otioGlbtexQC+U8R6bLEq+ReP7PT/XgJqMz0BwTCsAyEQrloFM5Azh5sleS
         qsGYpKvBHJQxfhj/XbkX1eACyoCd2PDbF+uSHnv9sVzu/v14LDnqLbxWdrtAE5nH7RUW
         4Jnf3HKmqH6nuOm/N3KgkH1glUOtcEHshfHEwDzNaDNDYTWVqeR3ofSZZo0b0zmfqkwg
         7jwA==
X-Gm-Message-State: AAQBX9ejGeDSt7LVWd34o/te+V9widZocAJYmGbwABD3Z0Yxf22S0Dsz
        03oqLrVmOVFVEznhmPZKZlwWEiocl3sEiv2FxC4=
X-Google-Smtp-Source: AKy350arFYZ6D74g3TZB+EM3aPiqTmYPjSCjq+EliPQ9eLzccDlMx7xTAbpkMDVQAr7rs889hanYqWLhw5wVVquUWdI=
X-Received: by 2002:a17:903:4051:b0:1a2:6e4d:7831 with SMTP id
 n17-20020a170903405100b001a26e4d7831mr859431pla.12.1681404380958; Thu, 13 Apr
 2023 09:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
 <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
 <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
 <2023041308-nerd-dry-98a6@gregkh> <CAJedcCyeM2a79i0=ffKwdKfnQayo7svhTTEth2ka6K9np0Ztiw@mail.gmail.com>
 <2023041308-unvisited-slinky-a56f@gregkh>
In-Reply-To: <2023041308-unvisited-slinky-a56f@gregkh>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 14 Apr 2023 00:46:08 +0800
Message-ID: <CAJedcCxzGbUSj0nh4xYp8P2zhYSM31CGi2fGE+9VJt7mkg6h4g@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        John Stultz <jstultz@google.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B 23:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Apr 13, 2023 at 11:35:17PM +0800, Zheng Hacker wrote:
> > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B 20:48=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wrote:
> > > > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hi, Zheng
> > > > >
> > > > > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@gmail.=
com> wrote:
> > > > > >
> > > > > > Friendly ping about the bug.
> > > > >
> > > > > Sorry, wasn't aware of this message before,
> > > > >
> > > > > Could you please help share the instructions to reproduce the pro=
blem
> > > > > this change fixes?
> > > > >
> > > >
> > > > Hi Yongqin,
> > > >
> > > > Thanks for your reply. This bug is found by static analysis. There =
is no PoC.
> > > >
> > > > >From my personal experience, triggering race condition bugs stably=
 in
> > > > the kernel needs some tricks.
> > > > For example, you can insert some sleep-time code to slow down the
> > > > thread until the related object is freed.
> > > > Besides, you can use gdb to control the time window. Also, there ar=
e
> > > > some other tricks as [1] said.
> > > >
> > > > As for the reproduction, this attack vector requires that the attac=
ker
> > > > can physically access the device.
> > > > When he/she unplugs the usb, the remove function is triggered, and =
if
> > > > the set callback is invoked, there might be a race condition.
> > >
> > > How does the removal of the USB device trigger a platform device
> > > removal?
> >
> > Sorry I made a mistake. The USB device usually calls disconnect
> > callback when it's unpluged.
>
> Yes, but you are changing the platform device disconnect, not the USB
> device disconnect.
>
> > What I want to express here is When the driver-related device(here
> > it's USB GPIO Hub) was removed, the remove function is triggered.
>
> And is this a patform device on a USB device?  If so, that's a bigger
> problem that we need to fix as that is not allowed.

No this is not a platform  device on a USB device.

>
> But in looking at the code, it does not seem to be that at all, this is
> just a "normal" platform device.  So how can it ever be removed from the
> system?  (and no, unloading the driver doesn't count, that can never
> happen on a normal machine.)
>

Yes, I finally figured out your meaning. I know it's hard to unplug
the platform device
directly. All I want to express is that it's a theoretical method
except  rmmod. I think it's better to fix the bug. But if the
developers think it's practically impossible, I think there's no need
to take further action.

Sorry for wasting your time and thanks for your explanation.

Best regards,
Zheng

> thanks,
>
> greg k-h
