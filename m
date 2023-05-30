Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD17152BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjE3A7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE3A7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BBFC7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685408323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXGAF0eFaU8FvA7WXhPqBXzyXcEEu4exGsf04nQzAHM=;
        b=Kicx7s+uivP34e5bpbopCjq5vuRwD/yt7GNyNL8F7+yPHAxEQtUynnyyjmypeFoZC7TF2s
        LyNs4LhDjSfDBrS0Wuv0EyUI4u2kyhmf4EfIl/mu28+j4yO/iE47+Fbnd5WnW+8fRihvLQ
        UNlW5nvc2OkdavgDSzIMjTCnhxOp3fQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-tMeTgLv-PquGdT9V_OQAYQ-1; Mon, 29 May 2023 20:58:42 -0400
X-MC-Unique: tMeTgLv-PquGdT9V_OQAYQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-256797b570eso946805a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685408321; x=1688000321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXGAF0eFaU8FvA7WXhPqBXzyXcEEu4exGsf04nQzAHM=;
        b=amImwwAPJH3w7VuLI1MCa2wLGQI6jXUhRE2kYnOmXiDCjxih/qw6NSpkV+sWysos5q
         u0DEgj4ejgJizxM3iIiJ85CsaQK4fNgbbxvIUSY9g0oeZ5e7li9LPgEQOPutYjWwaGom
         TNHERlgfDzKVv1IR5YM/OphU0D3Q8iKcn/Xchd0GaaGq8OecyYTuh2IvOueYEJv/+QjB
         GtfFZSXE1GCLUvrVQCeWfecuPeX0HuAYUhx0Cxp1ZDavPktHwnInYJr67PG5br/+yCvs
         DYt31YFC4HRzhglLdq6/v8HTwEoSwDc3PGEfGJmn2KbFM+BCrzuu5Dfrn0QonhB/59HI
         9Krw==
X-Gm-Message-State: AC+VfDw99ZLNIDA1ggKhQvNYIqve0MA3lJ8kyaAP3xAHtrjXAP0tsvk5
        xifcDyEqfo+6JsVgNiEAYnNIQ2YlyahWjTPoBVQwX3q+1xA8jWbWG6DkVDGjXvb14M3sNfbmPqi
        PMn8wfgRN7thURpbhA3nIsi5bSnj3HfiesJGHY26x
X-Received: by 2002:a17:902:e74f:b0:1b0:2658:db00 with SMTP id p15-20020a170902e74f00b001b02658db00mr974412plf.31.1685408321149;
        Mon, 29 May 2023 17:58:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vdKPRmgtsWroXvtduGgX5e+Q7zW8blNKEpgwDOA9HggBzhA/WOPXz6InXjMtmBbFzt3GiDQ99XEjljmn1sYY=
X-Received: by 2002:a17:902:e74f:b0:1b0:2658:db00 with SMTP id
 p15-20020a170902e74f00b001b02658db00mr974392plf.31.1685408320745; Mon, 29 May
 2023 17:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
 <20230426082031.1299149-8-yukuai1@huaweicloud.com> <CALTww2-yTsHXNFgkAVu0v++HHahZCnvXEUv2qJqbvcGUhKanDw@mail.gmail.com>
 <5e9852fe-0d47-92fc-f6a9-16d028d09ad4@huaweicloud.com> <CALTww28ur_S0UpGQqq0TubSgkxGG7dicc1ZKrJ3Pno4CpSOWUw@mail.gmail.com>
 <25279079-2600-b0d3-5279-caaf6f664d71@huaweicloud.com> <CALTww2-PjJ74J61jYz032t8K5tszN1tnhEbcv5h+MJjkKuVq2A@mail.gmail.com>
 <c56e7e9c-90ca-29ca-2003-1a9a88d75fa6@huaweicloud.com>
In-Reply-To: <c56e7e9c-90ca-29ca-2003-1a9a88d75fa6@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 30 May 2023 08:58:29 +0800
Message-ID: <CALTww2_JAmqU19Stb1UBVVL-w=ecRFt8WNZo+TmMJVD+O2RJqw@mail.gmail.com>
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

On Mon, May 29, 2023 at 4:50=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/05/29 15:57, Xiao Ni =E5=86=99=E9=81=93:
> > On Mon, May 29, 2023 at 11:18=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/05/29 11:10, Xiao Ni =E5=86=99=E9=81=93:
> >>> On Mon, May 29, 2023 at 10:20=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud=
.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> =E5=9C=A8 2023/05/29 10:08, Xiao Ni =E5=86=99=E9=81=93:
> >>>>> Hi Kuai
> >>>>>
> >>>>> There is a limitation of the memory in your test. But for most
> >>>>> situations, customers should not set this. Can this change introduc=
e a
> >>>>> performance regression against other situations?
> >>>>
> >>>> Noted that this limitation is just to triggered writeback as soon as
> >>>> possible in the test, and it's 100% sure real situations can trigger
> >>>> dirty pages write back asynchronously and continue to produce new di=
rty
> >>>> pages.
> >>>
> >>> Hi
> >>>
> >>> I'm confused here. If we want to trigger write back quickly, it needs
> >>> to set these two values with a smaller number, rather than 0 and 60.
> >>> Right?
> >>
> >> 60 is not required, I'll remove this setting.
> >>
> >> 0 just means write back if there are any dirty pages.
> >
> > Hi Kuai
> >
> > Does 0 mean disabling write back? I tried to find the doc that
> > describes the meaning when setting dirty_background_ratio to 0, but I
> > didn't find it.
> > In https://www.kernel.org/doc/html/next/admin-guide/sysctl/vm.html it
> > doesn't describe this. But it says something like this
> >
> > Note:
> >    dirty_background_bytes is the counterpart of dirty_background_ratio.=
 Only
> >    one of them may be specified at a time. When one sysctl is written i=
t is
> >    immediately taken into account to evaluate the dirty memory limits a=
nd the
> >    other appears as 0 when read.
> >
> > Maybe you can specify dirty_background_ratio to 1 if you want to
> > trigger write back ASAP.
>
> The purpose here is to trigger write back ASAP, I'm not an expert here,
> but based on test result, 0 obviously doesn't mean disable write back.
>
> Set dirty_background_bytes to a value, dirty_background_ratio will be
> set to 0 together, which means dirty_background_ratio is disabled.
> However, change dirty_background_ratio from default value to 0, will end
> up both dirty_background_ratio and dirty_background_bytes to be 0, and
> based on following related code, I think 0 just means write back if
> there are any dirty pages.
>
> domain_dirty_limits:
>   bg_bytes =3D dirty_background_bytes -> 0
>   bg_ratio =3D (dirty_background_ratio * PAGE_SIZE) / 100 -> 0
>
>   if (bg_bytes)
>          bg_thresh =3D DIV_ROUND_UP(bg_bytes, PAGE_SIZE);
>   else
>          bg_thresh =3D (bg_ratio * available_memory) / PAGE_SIZE; -> 0
>
>   dtc->bg_thresh =3D bg_thresh; -> 0
>
> balance_dirty_pages
>   nr_reclaimable =3D global_node_page_state(NR_FILE_DIRTY);
>   if (!laptop_mode && nr_reclaimable > gdtc->bg_thresh &&
>        !writeback_in_progress(wb))
>     wb_start_background_writeback(wb); -> writeback ASAP
>
> Thanks,
> Kuai

Hi Kuai

I'm not an expert about this either. Thanks for all your patches, I
can study more things too. But I still have some questions.

I did a test in my environment something like this:
modprobe brd rd_nr=3D4 rd_size=3D10485760
mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
echo 0 > /proc/sys/vm/dirty_background_ratio
fio -filename=3D/dev/md0 -ioengine=3Dlibaio -rw=3Dwrite -thread -bs=3D1k-8k
-numjobs=3D1 -iodepth=3D128 --runtime=3D10 -name=3Dxxx
It will cause OOM and the system hangs

modprobe brd rd_nr=3D4 rd_size=3D10485760
mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
echo 1 > /proc/sys/vm/dirty_background_ratio (THIS is the only different pl=
ace)
fio -filename=3D/dev/md0 -ioengine=3Dlibaio -rw=3Dwrite -thread -bs=3D1k-8k
-numjobs=3D1 -iodepth=3D128 --runtime=3D10 -name=3Dxxx
It can finish successfully.  The value of dirty_background_ration is 1
here means it flushes ASAP

So your method should be the opposite way as you designed. All the
memory can't be flushed in time, so it uses all memory very soon and
the memory runs out and the system hangs. The reason I'm looking at
the test is that do we really need this change. Because in the real
world, most customers don't disable write back. Anyway, it depends on
Song's decision and thanks for your patches again. I'll review V3 and
try to do some performance tests.

Best Regards
Xiao
> >
> >>>>
> >>>> If a lot of bio is not plugged, then it's the same as before; if a l=
ot
> >>>> of bio is plugged, noted that before this patchset, these bio will s=
pent
> >>>> quite a long time in plug, and hence I think performance should be
> >>>> better.
> >>>
> >>> Hmm, it depends on if it's sequential or not? If it's a big io
> >>> request, can it miss the merge opportunity?
> >>
> >> The bio will still be merged to underlying disks' rq(if it's rq based)=
,
> >> underlying disk won't flush plug untill the number of request exceed
> >> threshold.
> >
> > Thanks for this.
> >
> > Regards
> > Xiao
> >>
> >> Thanks,
> >> Kuai
> >>>
> >>> Regards
> >>> Xiao
> >>>
> >>>>
> >>>> Thanks,
> >>>> Kuai
> >>>>>
> >>>>> Best Regards
> >>>>> Xiao
> >>>>>
> >>>>> On Wed, Apr 26, 2023 at 4:24=E2=80=AFPM Yu Kuai <yukuai1@huaweiclou=
d.com> wrote:
> >>>>>>
> >>>>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>>>
> >>>>>> bio can be added to plug infinitely, and following writeback test =
can
> >>>>>> trigger huge amount of plugged bio:
> >>>>>>
> >>>>>> Test script:
> >>>>>> modprobe brd rd_nr=3D4 rd_size=3D10485760
> >>>>>> mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
> >>>>>> echo 0 > /proc/sys/vm/dirty_background_ratio
> >>>>>> echo 60 > /proc/sys/vm/dirty_ratio
> >>>>>> fio -filename=3D/dev/md0 -ioengine=3Dlibaio -rw=3Dwrite -bs=3D4k -=
numjobs=3D1 -iodepth=3D128 -name=3Dtest
> >>>>>>
> >>>>>> Test result:
> >>>>>> Monitor /sys/block/md0/inflight will found that inflight keep incr=
easing
> >>>>>> until fio finish writing, after running for about 2 minutes:
> >>>>>>
> >>>>>> [root@fedora ~]# cat /sys/block/md0/inflight
> >>>>>>           0  4474191
> >>>>>>
> >>>>>> Fix the problem by limiting the number of plugged bio based on the=
 number
> >>>>>> of copies for original bio.
> >>>>>>
> >>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>>>>> ---
> >>>>>>     drivers/md/raid1-10.c | 9 ++++++++-
> >>>>>>     drivers/md/raid1.c    | 2 +-
> >>>>>>     drivers/md/raid10.c   | 2 +-
> >>>>>>     3 files changed, 10 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> >>>>>> index 98d678b7df3f..35fb80aa37aa 100644
> >>>>>> --- a/drivers/md/raid1-10.c
> >>>>>> +++ b/drivers/md/raid1-10.c
> >>>>>> @@ -21,6 +21,7 @@
> >>>>>>     #define IO_MADE_GOOD ((struct bio *)2)
> >>>>>>
> >>>>>>     #define BIO_SPECIAL(bio) ((unsigned long)bio <=3D 2)
> >>>>>> +#define MAX_PLUG_BIO 32
> >>>>>>
> >>>>>>     /* for managing resync I/O pages */
> >>>>>>     struct resync_pages {
> >>>>>> @@ -31,6 +32,7 @@ struct resync_pages {
> >>>>>>     struct raid1_plug_cb {
> >>>>>>            struct blk_plug_cb      cb;
> >>>>>>            struct bio_list         pending;
> >>>>>> +       unsigned int            count;
> >>>>>>     };
> >>>>>>
> >>>>>>     static void rbio_pool_free(void *rbio, void *data)
> >>>>>> @@ -127,7 +129,7 @@ static inline void md_submit_write(struct bio =
*bio)
> >>>>>>     }
> >>>>>>
> >>>>>>     static inline bool md_add_bio_to_plug(struct mddev *mddev, str=
uct bio *bio,
> >>>>>> -                                     blk_plug_cb_fn unplug)
> >>>>>> +                                     blk_plug_cb_fn unplug, int c=
opies)
> >>>>>>     {
> >>>>>>            struct raid1_plug_cb *plug =3D NULL;
> >>>>>>            struct blk_plug_cb *cb;
> >>>>>> @@ -147,6 +149,11 @@ static inline bool md_add_bio_to_plug(struct =
mddev *mddev, struct bio *bio,
> >>>>>>
> >>>>>>            plug =3D container_of(cb, struct raid1_plug_cb, cb);
> >>>>>>            bio_list_add(&plug->pending, bio);
> >>>>>> +       if (++plug->count / MAX_PLUG_BIO >=3D copies) {
> >>>>>> +               list_del(&cb->list);
> >>>>>> +               cb->callback(cb, false);
> >>>>>> +       }
> >>>>>> +
> >>>>>>
> >>>>>>            return true;
> >>>>>>     }
> >>>>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >>>>>> index 639e09cecf01..c6066408a913 100644
> >>>>>> --- a/drivers/md/raid1.c
> >>>>>> +++ b/drivers/md/raid1.c
> >>>>>> @@ -1562,7 +1562,7 @@ static void raid1_write_request(struct mddev=
 *mddev, struct bio *bio,
> >>>>>>                                                  r1_bio->sector);
> >>>>>>                    /* flush_pending_writes() needs access to the r=
dev so...*/
> >>>>>>                    mbio->bi_bdev =3D (void *)rdev;
> >>>>>> -               if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug)=
) {
> >>>>>> +               if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug,=
 disks)) {
> >>>>>>                            spin_lock_irqsave(&conf->device_lock, f=
lags);
> >>>>>>                            bio_list_add(&conf->pending_bio_list, m=
bio);
> >>>>>>                            spin_unlock_irqrestore(&conf->device_lo=
ck, flags);
> >>>>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> >>>>>> index bd9e655ca408..7135cfaf75db 100644
> >>>>>> --- a/drivers/md/raid10.c
> >>>>>> +++ b/drivers/md/raid10.c
> >>>>>> @@ -1306,7 +1306,7 @@ static void raid10_write_one_disk(struct mdd=
ev *mddev, struct r10bio *r10_bio,
> >>>>>>
> >>>>>>            atomic_inc(&r10_bio->remaining);
> >>>>>>
> >>>>>> -       if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
> >>>>>> +       if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug, conf->=
copies)) {
> >>>>>>                    spin_lock_irqsave(&conf->device_lock, flags);
> >>>>>>                    bio_list_add(&conf->pending_bio_list, mbio);
> >>>>>>                    spin_unlock_irqrestore(&conf->device_lock, flag=
s);
> >>>>>> --
> >>>>>> 2.39.2
> >>>>>>
> >>>>>
> >>>>> .
> >>>>>
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> > .
> >
>

