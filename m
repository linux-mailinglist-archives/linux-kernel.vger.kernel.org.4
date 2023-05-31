Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39EF717969
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjEaIBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjEaIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE3BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685520031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAvQZliaHITssjxk0Fif22wZ/eyyqyNijkEgyxbBb/M=;
        b=QQSUodLB9SQ8863QIIRCh8fUD7XBOrRlDwUACnspm38EMOaegWNEW+neijT8x9PuliwS/L
        MO/1Vt+VLeL6y/5gkRgMJoC9+IGXW0W2ukMLf94I2YKrXA+xnnKylhkCQbm804g3FNVo2L
        rZzgaNU4w0vvCb4sRIDk7B1FeBjFeR8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-NM_icx8VOnWDkwnnlY6MwQ-1; Wed, 31 May 2023 04:00:28 -0400
X-MC-Unique: NM_icx8VOnWDkwnnlY6MwQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2566e9b14a4so3582400a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685520027; x=1688112027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAvQZliaHITssjxk0Fif22wZ/eyyqyNijkEgyxbBb/M=;
        b=VF2tqpis6qSKqeTgFEu07OaOZe8Zb25ml/bGPa/hCIMIfjlJ7KIev5oVXAspSGMFXl
         9KOaRRCSDvv/v+u73ywLQDuruYmygqIj5+kLp2IW3U21Yq9oPSetDXMFQ1NLWQqZyZNQ
         v8YNbZ89WHao6ylYLtaoddb45NC5sz5ybmAapAqnyr7FV1tzhWQj6HcktEmBG04vpon2
         HQKzAlUQZT8FaxXn4L0wYNBRYB8+ZGbzbrOxcBlUyaBipB6wJmWbsBFgJ2dCkB/MFFps
         MWfyfHR4kYZ+YHfh8VyIA7ZI8sMjKO4nrvTXhXsFwjGbKXuvJ4wkwykOz/B+RR3BT0Sg
         W2fA==
X-Gm-Message-State: AC+VfDzMIfoxM0WeBWwBcun4M58U6fPOZE2+Lrv1W0l4z/k7K9x7od09
        iKQADD5Yd3m41xO4DbOnjYmcgAM+Kos+8AwQhVlIUyQo7m0LsuiGQ84YL5mKfFIouj1/TRmjldV
        2tCvBG8uBsmy3TpXvwOO6DpMRBkoTrauReu/Ajm4c
X-Received: by 2002:a17:90a:a58b:b0:256:d4a:ea4c with SMTP id b11-20020a17090aa58b00b002560d4aea4cmr4734709pjq.30.1685520026971;
        Wed, 31 May 2023 01:00:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7oru8zJf1UyeyyVm8LPPLnazLQhgnMurhTHbBS2RDSseMrxQ9S5zWOVTuUcuP9giy83td6lyly5BCldISqn+o=
X-Received: by 2002:a17:90a:a58b:b0:256:d4a:ea4c with SMTP id
 b11-20020a17090aa58b00b002560d4aea4cmr4734689pjq.30.1685520026507; Wed, 31
 May 2023 01:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
 <20230529131106.2123367-7-yukuai1@huaweicloud.com> <CALTww29ixKpcVknNe36D+x=2c1Aw-=z32SP-dJ_Hj8WxL2n4bg@mail.gmail.com>
 <830352e1-ecfa-f5dc-ce7c-349553bd3003@huaweicloud.com>
In-Reply-To: <830352e1-ecfa-f5dc-ce7c-349553bd3003@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 31 May 2023 16:00:15 +0800
Message-ID: <CALTww28_w3h1_viTp5L9SCytY7WmwmABqkXOmyvH_UD8T5odMg@mail.gmail.com>
Subject: Re: [PATCH -next v3 6/7] md/raid1-10: don't handle pluged bio by
 daemon thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
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

On Wed, May 31, 2023 at 3:55=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/05/31 15:50, Xiao Ni =E5=86=99=E9=81=93:
> > On Mon, May 29, 2023 at 9:14=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> current->bio_list will be set under submit_bio() context, in this case
> >> bitmap io will be added to the list and wait for current io submission=
 to
> >> finish, while current io submission must wait for bitmap io to be done=
.
> >> commit 874807a83139 ("md/raid1{,0}: fix deadlock in bitmap_unplug.") f=
ix
> >> the deadlock by handling plugged bio by daemon thread.
> >
> > Thanks for the historic introduction. I did a test and printed the
> > logs in raid10_unplug. The tools I used are dd and mkfs. from_schedule
> > is always true during I/O and it's 0 when io finishes. So I have a
> > question here, how can I trigger the condition that from_schedule is 0
> > and current->list is not NULL? In other words, is there really a
> > deadlock here? Before your patch it looks like all bios are merged
> > into conf->pending_bio_list and are handled by raid10d. It can't
> > submit bio directly in the originating process which mentioned in
> > 57c67df48866
> >
> As I mentioned below, after commit a214b949d8e3, this deadlock doesn't
> exist anymore, and without this patch, patch 7 will introduce this
> scenario again.
>
> Thanks,
> Kuai
> >>
> >> On the one hand, the deadlock won't exist after commit a214b949d8e3
> >> ("blk-mq: only flush requests from the plug in blk_mq_submit_bio"). On
> >> the other hand, current solution makes it impossible to flush plugged =
bio
> >> in raid1/10_make_request(), because this will cause that all the write=
s
> >> will goto daemon thread.
> >>
> >> In order to limit the number of plugged bio, commit 874807a83139
> >> ("md/raid1{,0}: fix deadlock in bitmap_unplug.") is reverted, and the
> >> deadlock is fixed by handling bitmap io asynchronously.
> >>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/raid1-10.c | 14 ++++++++++++++
> >>   drivers/md/raid1.c    |  4 ++--
> >>   drivers/md/raid10.c   |  8 +++-----
> >>   3 files changed, 19 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> >> index 73cc3cb9154d..17e55c1fd5a1 100644
> >> --- a/drivers/md/raid1-10.c
> >> +++ b/drivers/md/raid1-10.c
> >> @@ -151,3 +151,17 @@ static inline bool raid1_add_bio_to_plug(struct m=
ddev *mddev, struct bio *bio,
> >>
> >>          return true;
> >>   }
> >> +
> >> +/*
> >> + * current->bio_list will be set under submit_bio() context, in this =
case bitmap
> >> + * io will be added to the list and wait for current io submission to=
 finish,
> >> + * while current io submission must wait for bitmap io to be done. In=
 order to
> >> + * avoid such deadlock, submit bitmap io asynchronously.
> >> + */
> >> +static inline void raid1_prepare_flush_writes(struct bitmap *bitmap)
> >> +{
> >> +       if (current->bio_list)
> >> +               md_bitmap_unplug_async(bitmap);
> >> +       else
> >> +               md_bitmap_unplug(bitmap);
> >> +}
> >> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >> index 0778e398584c..006620fed595 100644
> >> --- a/drivers/md/raid1.c
> >> +++ b/drivers/md/raid1.c
> >> @@ -794,7 +794,7 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>   static void flush_bio_list(struct r1conf *conf, struct bio *bio)
> >>   {
> >>          /* flush any pending bitmap writes to disk before proceeding =
w/ I/O */
> >> -       md_bitmap_unplug(conf->mddev->bitmap);
> >> +       raid1_prepare_flush_writes(conf->mddev->bitmap);
> >
> > If we unplug bitmap asynchronously, can we make sure the bitmap are
> > flushed before the corresponding data?

Could you explain this question?

Regards
Xiao


> >
> > Regards
> > Xiao
> >
> >>          wake_up(&conf->wait_barrier);
> >>
> >>          while (bio) { /* submit pending writes */
> >> @@ -1166,7 +1166,7 @@ static void raid1_unplug(struct blk_plug_cb *cb,=
 bool from_schedule)
> >>          struct r1conf *conf =3D mddev->private;
> >>          struct bio *bio;
> >>
> >> -       if (from_schedule || current->bio_list) {
> >> +       if (from_schedule) {
> >>                  spin_lock_irq(&conf->device_lock);
> >>                  bio_list_merge(&conf->pending_bio_list, &plug->pendin=
g);
> >>                  spin_unlock_irq(&conf->device_lock);
> >> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> >> index 6640507ecb0d..fb22cfe94d32 100644
> >> --- a/drivers/md/raid10.c
> >> +++ b/drivers/md/raid10.c
> >> @@ -902,9 +902,7 @@ static void flush_pending_writes(struct r10conf *c=
onf)
> >>                  __set_current_state(TASK_RUNNING);
> >>
> >>                  blk_start_plug(&plug);
> >> -               /* flush any pending bitmap writes to disk
> >> -                * before proceeding w/ I/O */
> >> -               md_bitmap_unplug(conf->mddev->bitmap);
> >> +               raid1_prepare_flush_writes(conf->mddev->bitmap);
> >>                  wake_up(&conf->wait_barrier);
> >>
> >>                  while (bio) { /* submit pending writes */
> >> @@ -1108,7 +1106,7 @@ static void raid10_unplug(struct blk_plug_cb *cb=
, bool from_schedule)
> >>          struct r10conf *conf =3D mddev->private;
> >>          struct bio *bio;
> >>
> >> -       if (from_schedule || current->bio_list) {
> >> +       if (from_schedule) {
> >>                  spin_lock_irq(&conf->device_lock);
> >>                  bio_list_merge(&conf->pending_bio_list, &plug->pendin=
g);
> >>                  spin_unlock_irq(&conf->device_lock);
> >> @@ -1120,7 +1118,7 @@ static void raid10_unplug(struct blk_plug_cb *cb=
, bool from_schedule)
> >>
> >>          /* we aren't scheduling, so we can do the write-out directly.=
 */
> >>          bio =3D bio_list_get(&plug->pending);
> >> -       md_bitmap_unplug(mddev->bitmap);
> >> +       raid1_prepare_flush_writes(mddev->bitmap);
> >>          wake_up(&conf->wait_barrier);
> >>
> >>          while (bio) { /* submit pending writes */
> >> --
> >> 2.39.2
> >>
> >
> > .
> >
>

