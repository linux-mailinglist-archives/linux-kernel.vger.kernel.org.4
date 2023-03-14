Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1EB6BA06E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCNUIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCNUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:08:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF94347C;
        Tue, 14 Mar 2023 13:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8A9FB81BAA;
        Tue, 14 Mar 2023 20:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F6CC4339E;
        Tue, 14 Mar 2023 20:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678824511;
        bh=1H8RN7X2BWD74bdgCSk+rZiFjxzqLdqAP9jkAoyRA4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tGd6Asikuix6tFlw3YdxD3dOn+8Sz37bn0tVJtCxfSfIN02I03L5Ui0iM792V/Z8a
         15V++N3Nn5jClIcpZengGY0zbcc4pSTCoPSAP6pKiA6aJ9nBkuXoPIjR28KsxCYj19
         IgvS40Al1HNzpizIRXQsjR3xIsu5j2H8dgzLIWDCk0LfhbUFYe+GXdY3u93Tw72//v
         JYxcpL+PtpQLHCpBw+8GoY/Yzh58KM7vhidSndzDYD6UM/LsBHyOcA5Cb3KwXURLZX
         /um8EmjCTaxWDPYK1grCV9Id00oITKwnYYcdKzggnaejnzKK2OP5iiKHNO9opuBSEo
         j2Am4lxeDRaMA==
Received: by mail-lf1-f45.google.com with SMTP id d36so21547631lfv.8;
        Tue, 14 Mar 2023 13:08:31 -0700 (PDT)
X-Gm-Message-State: AO0yUKUvgX5rLzwK1jvcDyYXS+jsJFve0hWPli4NUuBBz/plubAWLNk6
        BUVIMjoo0Rs6LZGhtVwHfOa4/8WsA3LZoPZGgHk=
X-Google-Smtp-Source: AK7set+VFhcRPDJ56g9Frs1WNAWoq6Vrpr0EkOm7zHNRmDP1j9cS+y+n4vhii7lrzREs8qioVa6uUPCyU0D96AFOeLw=
X-Received: by 2002:ac2:46ee:0:b0:4d5:ca42:e43a with SMTP id
 q14-20020ac246ee000000b004d5ca42e43amr1130928lfo.3.1678824509381; Tue, 14 Mar
 2023 13:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
 <20230311093148.2595222-6-yukuai1@huaweicloud.com> <69e04735-b3f6-2d82-9920-eac330a69792@huawei.com>
 <CAPhsuW67eNSJqtrmok14AUsRRvYKbZn=jFxDtzWLECEEQ2J=WA@mail.gmail.com>
In-Reply-To: <CAPhsuW67eNSJqtrmok14AUsRRvYKbZn=jFxDtzWLECEEQ2J=WA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 14 Mar 2023 13:08:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4nNJLuPff9trbsKYsBSQGtBC++Zo1Y3JQHphX2j4kMVw@mail.gmail.com>
Message-ID: <CAPhsuW4nNJLuPff9trbsKYsBSQGtBC++Zo1Y3JQHphX2j4kMVw@mail.gmail.com>
Subject: Re: [PATCH -next 5/5] md: protect md_thread with a new disk level
 spin lock
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com,
        snitzer@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 9:58=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Tue, Mar 14, 2023 at 3:54=E2=80=AFAM Yu Kuai <yukuai3@huawei.com> wrot=
e:
> >
> > Hi, song!
> >
> > =E5=9C=A8 2023/03/11 17:31, Yu Kuai =E5=86=99=E9=81=93:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > >
> > > Our test reports a uaf for 'mddev->sync_thread':
> > >
> > > T1                      T2
> > > md_start_sync
> > >   md_register_thread
> > >                       raid1d
> > >                        md_check_recovery
> > >                         md_reap_sync_thread
> > >                          md_unregister_thread
> > >                           kfree
> > >
> > >   md_wakeup_thread
> > >    wake_up
> > >    ->sync_thread was freed
> > >
> > > Currently, a global spinlock 'pers_lock' is borrowed to protect
> > > 'mddev->thread', this problem can be fixed likewise, however, there m=
ight
> > > be similar problem for other md_thread, and I really don't like the i=
dea to
> > > borrow a global lock.
> > >
> > > This patch use a disk level spinlock to protect md_thread in relevant=
 apis.
> > >
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   drivers/md/md.c | 23 ++++++++++-------------
> > >   drivers/md/md.h |  1 +
> > >   2 files changed, 11 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > > index ab9299187cfe..a952978884a5 100644
> > > --- a/drivers/md/md.c
> > > +++ b/drivers/md/md.c
> > > @@ -663,6 +663,7 @@ void mddev_init(struct mddev *mddev)
> > >       atomic_set(&mddev->active, 1);
> > >       atomic_set(&mddev->openers, 0);
> > >       spin_lock_init(&mddev->lock);
> > > +     spin_lock_init(&mddev->thread_lock);
> > >       atomic_set(&mddev->flush_pending, 0);
> > >       init_waitqueue_head(&mddev->sb_wait);
> > >       init_waitqueue_head(&mddev->recovery_wait);
> > > @@ -801,13 +802,8 @@ void mddev_unlock(struct mddev *mddev)
> > >       } else
> > >               mutex_unlock(&mddev->reconfig_mutex);
> > >
> > > -     /* As we've dropped the mutex we need a spinlock to
> > > -      * make sure the thread doesn't disappear
> > > -      */
> > > -     spin_lock(&pers_lock);
> > >       md_wakeup_thread(&mddev->thread, mddev);
> > >       wake_up(&mddev->sb_wait);
> > > -     spin_unlock(&pers_lock);
> > >   }
> > >   EXPORT_SYMBOL_GPL(mddev_unlock);
> > >
> > > @@ -7895,13 +7891,16 @@ static int md_thread(void *arg)
> > >
> > >   void md_wakeup_thread(struct md_thread **threadp, struct mddev *mdd=
ev)
> > >   {
> > > -     struct md_thread *thread =3D *threadp;
> > > +     struct md_thread *thread;
> > >
> > > +     spin_lock(&mddev->thread_lock);
> > > +     thread =3D *threadp;
> > >       if (thread) {
> > >               pr_debug("md: waking up MD thread %s.\n", thread->tsk->=
comm);
> > >               set_bit(THREAD_WAKEUP, &thread->flags);
> > >               wake_up(&thread->wqueue);
> > >       }
> > > +     spin_unlock(&mddev->thread_lock);
> >
> > I just found that md_wakeup_thread can be called from irq context:
> >
> > md_safemode_timeout
> >   md_wakeup_thread
> >
> > And I need to use irq safe spinlock apis here.
> >
> > Can you drop this verion from md-next? I'll send a new version after I
> > verified that there are no new regression, at least for mdadm tests.
>
> I will drop it from md-next. Please send a new version.

To clarify: I dropped the whole set from md-next. Please resend the set
after fixing the issue.

Thanks,
Song
