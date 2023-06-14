Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5023572F71E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbjFNH66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbjFNH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20B81721
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686729486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YcAMEaHdVXOHx/SWlAZvp5j/GEODCn66k3Tb3qtjpuM=;
        b=W+NTHX3d5vlRhBtm8icyo932d3RnE4L5yj4PmmOXzzAfCF0DUKZkv+nTVuKJb/xRiZXgzn
        6pjH/rzRm3jp/4nigYqQCIh/BTnuk7mnab7vMPkJknZmzKECf645lr7etuL4+Vy/alM80K
        3xByhE7XucZw++l2fE3cQIkwPlgAwKo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-xCKo1qsUPpO38Thw-5smBg-1; Wed, 14 Jun 2023 03:58:05 -0400
X-MC-Unique: xCKo1qsUPpO38Thw-5smBg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-25c2874b272so614919a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686729484; x=1689321484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcAMEaHdVXOHx/SWlAZvp5j/GEODCn66k3Tb3qtjpuM=;
        b=DRnxJXJoEHZpesaRiewxitFpnq4hXeYAZvj3QBMhZM7EgzYy00pzpIufk6MAbd37G/
         sbGkZseukbQs82cQntGPlLuD8WMaStXGa/T1Dfi8hDAQswUdsY4jg+n0zo1QJ+u6jwzp
         JJnvRF07pJarOChdLITpOki8+bG9sVtx0TuuC0Pc+ZmmbPI2Kul8X1DALPhBY1pbd7Z4
         oxO+/7aOWx1pdhH3C8O7nnwAEaMymFBhXkQqV8VJeMtLQ5OJojwYQ+ds18vtx+DfD3a4
         OjPxhvuOv/7wQthxEASezt7yTGJPHoH6/hcYt8OkXdgy5zrh3D63p4yXUoMqevbva1UX
         IZNA==
X-Gm-Message-State: AC+VfDwNR0uVQQ9leElJ7f9+UixNw7+aouBplb19LVJ4ka6S0gH/7v0h
        nLW4pH46fQ2VSOXO6qnf9MTNmNzzD6jPHo3j2M3Q5Zc6tBdgnGFkR+1SpZ4IrWLCh2uWozyo+n0
        I+xvEsfaquHy2fdZzoSw4cnxEd08NGP2Cl7wUZ5mc
X-Received: by 2002:a17:90a:19c4:b0:25b:8bed:d13b with SMTP id 4-20020a17090a19c400b0025b8bedd13bmr592561pjj.39.1686729484461;
        Wed, 14 Jun 2023 00:58:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WG/pWp7t9cmCjQuztIbIJnaTsFT1OU7Z9VL4N1ItOAF7I8tbmj8Xz9Buo8LI1Wbd+AjqUHNCjv3CTQe40Oks=
X-Received: by 2002:a17:90a:19c4:b0:25b:8bed:d13b with SMTP id
 4-20020a17090a19c400b0025b8bedd13bmr592549pjj.39.1686729484159; Wed, 14 Jun
 2023 00:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com> <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
 <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com> <6e738d9b-6e92-20b7-f9d9-e1cf71d26d73@huaweicloud.com>
 <CALTww292gwOe-WEjuBwJn0AXvJC4AbfMZXC43EvVt3GCeBoHfw@mail.gmail.com> <5bf97ec5-0cb4-1163-6917-2bc98d912c2b@huaweicloud.com>
In-Reply-To: <5bf97ec5-0cb4-1163-6917-2bc98d912c2b@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 14 Jun 2023 15:57:53 +0800
Message-ID: <CALTww28UapJnK+Xfx7O9uEd5ZH2E7ufPT_7pKY6YYuzTZ0Fbdw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor idle/frozen_sync_thread()
 to fix deadlock
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        yangerkun@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 3:38=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/14 15:12, Xiao Ni =E5=86=99=E9=81=93:
> > On Wed, Jun 14, 2023 at 10:04=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/06/14 9:48, Yu Kuai =E5=86=99=E9=81=93:
> >>
> >>
> >>>>
> >>>> In the patch, sync_seq is added in md_reap_sync_thread. In
> >>>> idle_sync_thread, if sync_seq isn't equal
> >>>>
> >>>> mddev->sync_seq, it should mean there is someone that stops the sync
> >>>> thread already, right? Why do
> >>>>
> >>>> you say 'new started sync thread' here?
> >>
> >> If someone stops the sync thread, and new sync thread is not started,
> >> then this sync_seq won't make a difference, above wait_event() will no=
t
> >> wait because !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) will pas=
s.
> >> So 'sync_seq' is only used when the old sync thread stops and new sync
> >> thread starts, add 'sync_seq' will bypass this case.
> >
> > Hi
> >
> > If a new sync thread starts, why can sync_seq be different? sync_seq
> > is only added in md_reap_sync_thread. And when a new sync request
> > starts, it can't stop the sync request again?
> >
> > Af first, the sync_seq is 0
> >
> > admin1
> > echo idle > sync_action
> > idle_sync_thread(sync_seq is 1)
>
> Wait, I'm confused here, how can sync_seq to be 1 here? I suppose you
> mean that there is a sync_thread just finished?

Hi Kuai

Yes. Because idle_sync_thread needs to wait until md_reap_sync_thread
finishes. And md_reap_sync_thread adds sync_seq. Do I understand your
patch right?

>
> Then the problem is that idle_sync_thread() read sync_seq after the old
> sync_thread is done, and new sync_thread start before wait_event() is
> called, should we wait for this new sync_thread?
>
> My answer here is that we should, but I'm also ok to not wait this new
> sync_thread, I don't think this behaviour matters. The key point here
> is that once wait_event() is called from idle_sync_thread(), this
> wait_event() should not wait for new sync_thread...

I think we should wait. If we don't wait for it, there is a problem.
One person echos idle to sync_action and it doesn't work sometimes.
It's a strange thing.

>
> > echo resync > sync_action (new sync)
>
> If this is behind "echo idle > sync_action", idle_sync_thread should not
> see that MD_RECOVERY_RUNNING is set and wait_event() won't wait at all.

`echo resync > sync_action` can't change the sync_seq. So 'echo idle >
sync_action' still waits until MD_RECOVERY_RUNNING is cleared?

Regards
Xiao

>
> Thanks,
> Kuai
> >
> > Then admin2 echos idle > sync_action, sync_seq is still 1
> >
> > Regards
> > Xiao
> >
> >>
> >> Thanks,
> >> Kuai
> >>
> >
> > .
> >
>

