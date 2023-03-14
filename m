Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6E6B9C58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCNQ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCNQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA716A1F5;
        Tue, 14 Mar 2023 09:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645ED61864;
        Tue, 14 Mar 2023 16:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6242C4339B;
        Tue, 14 Mar 2023 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678813143;
        bh=0iRXseBaBW3dOM2E5gQSiIHz/gPiUsuvdyPPVZrDdSI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GyQ3+HTIduF2/5OGLd/5o91I9/ONCFkkufOl+RMUuImql61WyeTwfKbjszGZ/FMPs
         xBVYEDWxynKUopwTrlAGz6sm/2balrfSw2/V2J1FpBMK+g22NFqNIJLw+7TSrHxmmu
         5ziENesTXMrfsYGDsQZKSG4tqfLyRzE4gb1Y105zWjTGwSxyq+0Qpz26JDueL9urD1
         LNybLR4w4JBtl8W0INkMjaW+Yt1hhwoEY7Wc6LY3QF4Lbt5Jqncwv9HS59JxEXrZr3
         OKurB1Pry5cOPiouY103vyLAvh6jtXIwOivIjnHn9JG6zXnIo37FkH84rhdmTVgujb
         AqkkAgpirBn5Q==
Received: by mail-lf1-f52.google.com with SMTP id x17so4756599lfu.5;
        Tue, 14 Mar 2023 09:59:03 -0700 (PDT)
X-Gm-Message-State: AO0yUKUoYA159tlPm5BReATm5kPD8ispH/xTnBT/txOdJmh+fzn06wmu
        KbmhgeoB/4OJDIHrbuQFgTz52QEuNXDi6ZmbUso=
X-Google-Smtp-Source: AK7set88LvcW/9k/fiKDKFmIEXq4h0Xa5PH3Jc4UMa6M0DvmNIegcEUnCPSAP+RgeTSpqA3BizmaAWn9z1HiJpXWH2E=
X-Received: by 2002:ac2:50cf:0:b0:4dd:a74d:aca3 with SMTP id
 h15-20020ac250cf000000b004dda74daca3mr1005658lfm.3.1678813141872; Tue, 14 Mar
 2023 09:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
 <20230311093148.2595222-6-yukuai1@huaweicloud.com> <69e04735-b3f6-2d82-9920-eac330a69792@huawei.com>
In-Reply-To: <69e04735-b3f6-2d82-9920-eac330a69792@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 14 Mar 2023 09:58:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW67eNSJqtrmok14AUsRRvYKbZn=jFxDtzWLECEEQ2J=WA@mail.gmail.com>
Message-ID: <CAPhsuW67eNSJqtrmok14AUsRRvYKbZn=jFxDtzWLECEEQ2J=WA@mail.gmail.com>
Subject: Re: [PATCH -next 5/5] md: protect md_thread with a new disk level
 spin lock
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com,
        snitzer@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 3:54=E2=80=AFAM Yu Kuai <yukuai3@huawei.com> wrote:
>
> Hi, song!
>
> =E5=9C=A8 2023/03/11 17:31, Yu Kuai =E5=86=99=E9=81=93:
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > Our test reports a uaf for 'mddev->sync_thread':
> >
> > T1                      T2
> > md_start_sync
> >   md_register_thread
> >                       raid1d
> >                        md_check_recovery
> >                         md_reap_sync_thread
> >                          md_unregister_thread
> >                           kfree
> >
> >   md_wakeup_thread
> >    wake_up
> >    ->sync_thread was freed
> >
> > Currently, a global spinlock 'pers_lock' is borrowed to protect
> > 'mddev->thread', this problem can be fixed likewise, however, there mig=
ht
> > be similar problem for other md_thread, and I really don't like the ide=
a to
> > borrow a global lock.
> >
> > This patch use a disk level spinlock to protect md_thread in relevant a=
pis.
> >
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >   drivers/md/md.c | 23 ++++++++++-------------
> >   drivers/md/md.h |  1 +
> >   2 files changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index ab9299187cfe..a952978884a5 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -663,6 +663,7 @@ void mddev_init(struct mddev *mddev)
> >       atomic_set(&mddev->active, 1);
> >       atomic_set(&mddev->openers, 0);
> >       spin_lock_init(&mddev->lock);
> > +     spin_lock_init(&mddev->thread_lock);
> >       atomic_set(&mddev->flush_pending, 0);
> >       init_waitqueue_head(&mddev->sb_wait);
> >       init_waitqueue_head(&mddev->recovery_wait);
> > @@ -801,13 +802,8 @@ void mddev_unlock(struct mddev *mddev)
> >       } else
> >               mutex_unlock(&mddev->reconfig_mutex);
> >
> > -     /* As we've dropped the mutex we need a spinlock to
> > -      * make sure the thread doesn't disappear
> > -      */
> > -     spin_lock(&pers_lock);
> >       md_wakeup_thread(&mddev->thread, mddev);
> >       wake_up(&mddev->sb_wait);
> > -     spin_unlock(&pers_lock);
> >   }
> >   EXPORT_SYMBOL_GPL(mddev_unlock);
> >
> > @@ -7895,13 +7891,16 @@ static int md_thread(void *arg)
> >
> >   void md_wakeup_thread(struct md_thread **threadp, struct mddev *mddev=
)
> >   {
> > -     struct md_thread *thread =3D *threadp;
> > +     struct md_thread *thread;
> >
> > +     spin_lock(&mddev->thread_lock);
> > +     thread =3D *threadp;
> >       if (thread) {
> >               pr_debug("md: waking up MD thread %s.\n", thread->tsk->co=
mm);
> >               set_bit(THREAD_WAKEUP, &thread->flags);
> >               wake_up(&thread->wqueue);
> >       }
> > +     spin_unlock(&mddev->thread_lock);
>
> I just found that md_wakeup_thread can be called from irq context:
>
> md_safemode_timeout
>   md_wakeup_thread
>
> And I need to use irq safe spinlock apis here.
>
> Can you drop this verion from md-next? I'll send a new version after I
> verified that there are no new regression, at least for mdadm tests.

I will drop it from md-next. Please send a new version.

Thanks,
Song
