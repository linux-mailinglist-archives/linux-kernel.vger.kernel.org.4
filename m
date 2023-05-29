Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E107145CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjE2H6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjE2H6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE508AF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685347072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ga1P0GVY6m0hvwAmOY+QA2noKzIADmTMX1XUH+nnV6c=;
        b=gg56jNt0vwH9VTA4kOT72+5WMfGGfAjEPtyP7DU1pfTHZSjSVofm7VsigUOK/cm0DSYVCm
        QgOlOzsSEJWPIqLt/4JSlDkD5+Li7RvinZ8B+tDgp4xKEusYO6OKGyl6dZ/AAY5bCbK1Eh
        whhWR36l2ZCmQylJQCAAIPtQ63HCJ4w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-a59ShWF3PCG8sMRby72dYw-1; Mon, 29 May 2023 03:57:50 -0400
X-MC-Unique: a59ShWF3PCG8sMRby72dYw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-25669acf204so1325337a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347069; x=1687939069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ga1P0GVY6m0hvwAmOY+QA2noKzIADmTMX1XUH+nnV6c=;
        b=FZjzV8X/ipx2E/0QJ1SKfMooDAvk8Qrb40Nmi/TVL98LvROT0BYnPLDXxxvHDWk6qn
         cvh7eYhJOSYUW7NXGHENMPC/WlWNV+Hzwbj7KDmxLXeLPwdkrUUIGSzpKMMw3/55a1OA
         fpsNfwlEWSVK5bQ2VN/XZqmKZv1kyjA9uKph0DH8C/Hhde5lz/S7qeu3OsSrk515qmz5
         RYIqP0Od3l63SdWZEDUdiGIhD1Y1JxmFOPHE2OotyhAVmpFPx6J8LNkOtLuQ1PWtGwBt
         QzaZBKMlzoHYhuS7KxoeS9rCluJDaEwlaIeyxp+CuEJ6qWK7h0J2GLyIksOnkLwBRMNj
         Xb8w==
X-Gm-Message-State: AC+VfDygWpRqWDFtmIJKg840eiXFv7ipxZTA96zXw+n1I3h4+A9MXdvS
        5JA0wom/lhCRv0tyy3OV2M0EJqUq4SH4Id5eWK0RL9HBoRvpcTJJbcyfY5+naZiXj4APshpm3Mk
        Tpcy2dgsj0a5W5gsEu5Uuiv++mzr7YB/ko8tvKVbo+WN+J6djKJ4wg6eR
X-Received: by 2002:a17:90a:7f06:b0:237:ae7c:15be with SMTP id k6-20020a17090a7f0600b00237ae7c15bemr9723431pjl.30.1685347069690;
        Mon, 29 May 2023 00:57:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Dd+4jy7Ai/DhVofc3iAE7TYLcZtspyURVyeDU4pplpdxK5mGeM5C0yXxruUlW9UmH7gp8tE6L+ZuwqJJqFQw=
X-Received: by 2002:a17:90a:7f06:b0:237:ae7c:15be with SMTP id
 k6-20020a17090a7f0600b00237ae7c15bemr9723416pjl.30.1685347069387; Mon, 29 May
 2023 00:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
 <20230426082031.1299149-8-yukuai1@huaweicloud.com> <CALTww2-yTsHXNFgkAVu0v++HHahZCnvXEUv2qJqbvcGUhKanDw@mail.gmail.com>
 <5e9852fe-0d47-92fc-f6a9-16d028d09ad4@huaweicloud.com> <CALTww28ur_S0UpGQqq0TubSgkxGG7dicc1ZKrJ3Pno4CpSOWUw@mail.gmail.com>
 <25279079-2600-b0d3-5279-caaf6f664d71@huaweicloud.com>
In-Reply-To: <25279079-2600-b0d3-5279-caaf6f664d71@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Mon, 29 May 2023 15:57:37 +0800
Message-ID: <CALTww2-PjJ74J61jYz032t8K5tszN1tnhEbcv5h+MJjkKuVq2A@mail.gmail.com>
Subject: Re: [PATCH -next v2 7/7] md/raid1-10: limit the number of plugged bio
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, akpm@osdl.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:18=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2023/05/29 11:10, Xiao Ni =E5=86=99=E9=81=93:
> > On Mon, May 29, 2023 at 10:20=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/05/29 10:08, Xiao Ni =E5=86=99=E9=81=93:
> >>> Hi Kuai
> >>>
> >>> There is a limitation of the memory in your test. But for most
> >>> situations, customers should not set this. Can this change introduce =
a
> >>> performance regression against other situations?
> >>
> >> Noted that this limitation is just to triggered writeback as soon as
> >> possible in the test, and it's 100% sure real situations can trigger
> >> dirty pages write back asynchronously and continue to produce new dirt=
y
> >> pages.
> >
> > Hi
> >
> > I'm confused here. If we want to trigger write back quickly, it needs
> > to set these two values with a smaller number, rather than 0 and 60.
> > Right?
>
> 60 is not required, I'll remove this setting.
>
> 0 just means write back if there are any dirty pages.

Hi Kuai

Does 0 mean disabling write back? I tried to find the doc that
describes the meaning when setting dirty_background_ration to 0, but I
didn't find it.
In https://www.kernel.org/doc/html/next/admin-guide/sysctl/vm.html it
doesn't describe this. But it says something like this

Note:
  dirty_background_bytes is the counterpart of dirty_background_ratio. Only
  one of them may be specified at a time. When one sysctl is written it is
  immediately taken into account to evaluate the dirty memory limits and th=
e
  other appears as 0 when read.

Maybe you can specify dirty_background_ratio to 1 if you want to
trigger write back ASAP.

> >>
> >> If a lot of bio is not plugged, then it's the same as before; if a lot
> >> of bio is plugged, noted that before this patchset, these bio will spe=
nt
> >> quite a long time in plug, and hence I think performance should be
> >> better.
> >
> > Hmm, it depends on if it's sequential or not? If it's a big io
> > request, can it miss the merge opportunity?
>
> The bio will still be merged to underlying disks' rq(if it's rq based),
> underlying disk won't flush plug untill the number of request exceed
> threshold.

Thanks for this.

Regards
Xiao
>
> Thanks,
> Kuai
> >
> > Regards
> > Xiao
> >
> >>
> >> Thanks,
> >> Kuai
> >>>
> >>> Best Regards
> >>> Xiao
> >>>
> >>> On Wed, Apr 26, 2023 at 4:24=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
> >>>>
> >>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>
> >>>> bio can be added to plug infinitely, and following writeback test ca=
n
> >>>> trigger huge amount of plugged bio:
> >>>>
> >>>> Test script:
> >>>> modprobe brd rd_nr=3D4 rd_size=3D10485760
> >>>> mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
> >>>> echo 0 > /proc/sys/vm/dirty_background_ratio
> >>>> echo 60 > /proc/sys/vm/dirty_ratio
> >>>> fio -filename=3D/dev/md0 -ioengine=3Dlibaio -rw=3Dwrite -bs=3D4k -nu=
mjobs=3D1 -iodepth=3D128 -name=3Dtest
> >>>>
> >>>> Test result:
> >>>> Monitor /sys/block/md0/inflight will found that inflight keep increa=
sing
> >>>> until fio finish writing, after running for about 2 minutes:
> >>>>
> >>>> [root@fedora ~]# cat /sys/block/md0/inflight
> >>>>          0  4474191
> >>>>
> >>>> Fix the problem by limiting the number of plugged bio based on the n=
umber
> >>>> of copies for original bio.
> >>>>
> >>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>>> ---
> >>>>    drivers/md/raid1-10.c | 9 ++++++++-
> >>>>    drivers/md/raid1.c    | 2 +-
> >>>>    drivers/md/raid10.c   | 2 +-
> >>>>    3 files changed, 10 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> >>>> index 98d678b7df3f..35fb80aa37aa 100644
> >>>> --- a/drivers/md/raid1-10.c
> >>>> +++ b/drivers/md/raid1-10.c
> >>>> @@ -21,6 +21,7 @@
> >>>>    #define IO_MADE_GOOD ((struct bio *)2)
> >>>>
> >>>>    #define BIO_SPECIAL(bio) ((unsigned long)bio <=3D 2)
> >>>> +#define MAX_PLUG_BIO 32
> >>>>
> >>>>    /* for managing resync I/O pages */
> >>>>    struct resync_pages {
> >>>> @@ -31,6 +32,7 @@ struct resync_pages {
> >>>>    struct raid1_plug_cb {
> >>>>           struct blk_plug_cb      cb;
> >>>>           struct bio_list         pending;
> >>>> +       unsigned int            count;
> >>>>    };
> >>>>
> >>>>    static void rbio_pool_free(void *rbio, void *data)
> >>>> @@ -127,7 +129,7 @@ static inline void md_submit_write(struct bio *b=
io)
> >>>>    }
> >>>>
> >>>>    static inline bool md_add_bio_to_plug(struct mddev *mddev, struct=
 bio *bio,
> >>>> -                                     blk_plug_cb_fn unplug)
> >>>> +                                     blk_plug_cb_fn unplug, int cop=
ies)
> >>>>    {
> >>>>           struct raid1_plug_cb *plug =3D NULL;
> >>>>           struct blk_plug_cb *cb;
> >>>> @@ -147,6 +149,11 @@ static inline bool md_add_bio_to_plug(struct md=
dev *mddev, struct bio *bio,
> >>>>
> >>>>           plug =3D container_of(cb, struct raid1_plug_cb, cb);
> >>>>           bio_list_add(&plug->pending, bio);
> >>>> +       if (++plug->count / MAX_PLUG_BIO >=3D copies) {
> >>>> +               list_del(&cb->list);
> >>>> +               cb->callback(cb, false);
> >>>> +       }
> >>>> +
> >>>>
> >>>>           return true;
> >>>>    }
> >>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >>>> index 639e09cecf01..c6066408a913 100644
> >>>> --- a/drivers/md/raid1.c
> >>>> +++ b/drivers/md/raid1.c
> >>>> @@ -1562,7 +1562,7 @@ static void raid1_write_request(struct mddev *=
mddev, struct bio *bio,
> >>>>                                                 r1_bio->sector);
> >>>>                   /* flush_pending_writes() needs access to the rdev=
 so...*/
> >>>>                   mbio->bi_bdev =3D (void *)rdev;
> >>>> -               if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug)) =
{
> >>>> +               if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug, d=
isks)) {
> >>>>                           spin_lock_irqsave(&conf->device_lock, flag=
s);
> >>>>                           bio_list_add(&conf->pending_bio_list, mbio=
);
> >>>>                           spin_unlock_irqrestore(&conf->device_lock,=
 flags);
> >>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> >>>> index bd9e655ca408..7135cfaf75db 100644
> >>>> --- a/drivers/md/raid10.c
> >>>> +++ b/drivers/md/raid10.c
> >>>> @@ -1306,7 +1306,7 @@ static void raid10_write_one_disk(struct mddev=
 *mddev, struct r10bio *r10_bio,
> >>>>
> >>>>           atomic_inc(&r10_bio->remaining);
> >>>>
> >>>> -       if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
> >>>> +       if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug, conf->co=
pies)) {
> >>>>                   spin_lock_irqsave(&conf->device_lock, flags);
> >>>>                   bio_list_add(&conf->pending_bio_list, mbio);
> >>>>                   spin_unlock_irqrestore(&conf->device_lock, flags);
> >>>> --
> >>>> 2.39.2
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> > .
> >
>

