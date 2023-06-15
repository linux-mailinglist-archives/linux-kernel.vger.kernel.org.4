Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234AC7311AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbjFOICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245222AbjFOICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD685199D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686816090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQWDXrZbWAVoRYBMaKcwwAPg+tUuAljoMwPz6OAacLc=;
        b=EeL1g49v02Ku5U25tEwqLSdu9RpTix/ZdcNfhXw1Oh9O2VvXvAGRdpDx2NPENOPC6OIDxB
        DWCXEzEOK9sfephKenTouiRGDitlDWiPdzks4KI8xtX6p1py2cadDkc4+aOqSDxuN/9KvQ
        3fZv1MjwtLILWaUYOObKCUoZHSNcDMA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-rBkG3XSsPemhmyUfLZ8qhQ-1; Thu, 15 Jun 2023 04:01:29 -0400
X-MC-Unique: rBkG3XSsPemhmyUfLZ8qhQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62de823a3aeso36373796d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686816089; x=1689408089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQWDXrZbWAVoRYBMaKcwwAPg+tUuAljoMwPz6OAacLc=;
        b=LRxtsrEdkYjLV68eZhFQpdv7nwlKzwqEqvfn11pRw6/fuPniS8wSYv1zbX99K4U1hb
         qz6lI4KHkwv2tNv6XEU1jmPodHlhv9swaA2sQ98D0eaGXmUuUkdKHL40DxOc0H/3Sbq7
         SOjq+AINOKr9l7HS1uZTDKJ0VlEifIa/XVLIU6arFnEiWtyrnV7rV7Ce+gXiFEkiY0ga
         Xy1VF1z+lV99XaRkYY4AyUt3SIqJ/10E9yDRu78/tamqUvOOAUCm9btYkgUIP1Pto4a+
         P5qnUHE0JJAxSVUI7LnLqBoQtcQNf86ItCD1XRWqCu2S7PVoW6ykilLY72aWThYiO60k
         ezKg==
X-Gm-Message-State: AC+VfDyFIJ7ctRPmSvpnDWHRHX1DR9Kzoe2aclwaMa7srVBR99vpgLII
        xE6WTFo/Vt3APKKn4Heq3UCk5N5VxBqeApLGx9eRc82rk6vu1+AH59/I1OrPOgw/CNFBhfZe8/4
        lO+b0fWQiMMPCEp4trJa5IcU2EfwCSMjoFS+s/lWp
X-Received: by 2002:a05:6214:b6c:b0:626:1fe8:bbc9 with SMTP id ey12-20020a0562140b6c00b006261fe8bbc9mr17232594qvb.32.1686816088997;
        Thu, 15 Jun 2023 01:01:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KCE4A+SKvSwxPT5wW/pwzpT/V0TAa+G9BMizaSX7JkXMUCmL9Ijl1gAGyeKyyyshbQxicyahmJM2R2vQgcYM=
X-Received: by 2002:a05:6214:b6c:b0:626:1fe8:bbc9 with SMTP id
 ey12-20020a0562140b6c00b006261fe8bbc9mr17232576qvb.32.1686816088739; Thu, 15
 Jun 2023 01:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com> <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
 <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com> <6e738d9b-6e92-20b7-f9d9-e1cf71d26d73@huaweicloud.com>
 <CALTww292gwOe-WEjuBwJn0AXvJC4AbfMZXC43EvVt3GCeBoHfw@mail.gmail.com>
 <5bf97ec5-0cb4-1163-6917-2bc98d912c2b@huaweicloud.com> <CALTww28UapJnK+Xfx7O9uEd5ZH2E7ufPT_7pKY6YYuzTZ0Fbdw@mail.gmail.com>
 <b96ec15b-6102-17bb-2c18-a487f224865b@huaweicloud.com> <CALTww2-knHOoX35NB73X-sMn1u8EJHLA=0aOnoVqVm83+fdG5Q@mail.gmail.com>
 <04700f85-62a2-1dbd-f330-80f9a13b7d2e@huaweicloud.com>
In-Reply-To: <04700f85-62a2-1dbd-f330-80f9a13b7d2e@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 15 Jun 2023 16:01:17 +0800
Message-ID: <CALTww2-Wr8UbNFaLOyYv5Syh5q4J+hzRuo8Eakj_nOW+P4Cx7A@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor idle/frozen_sync_thread()
 to fix deadlock
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com, snitzer@kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        song@kernel.org, dm-devel@redhat.com, guoqing.jiang@linux.dev,
        "yukuai (C)" <yukuai3@huawei.com>, agk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 9:29=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/14 17:08, Xiao Ni =E5=86=99=E9=81=93:
> > On Wed, Jun 14, 2023 at 4:29=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/06/14 15:57, Xiao Ni =E5=86=99=E9=81=93:
> >>> On Wed, Jun 14, 2023 at 3:38=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> =E5=9C=A8 2023/06/14 15:12, Xiao Ni =E5=86=99=E9=81=93:
> >>>>> On Wed, Jun 14, 2023 at 10:04=E2=80=AFAM Yu Kuai <yukuai1@huaweiclo=
ud.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> =E5=9C=A8 2023/06/14 9:48, Yu Kuai =E5=86=99=E9=81=93:
> >>>>>>
> >>>>>>
> >>>>>>>>
> >>>>>>>> In the patch, sync_seq is added in md_reap_sync_thread. In
> >>>>>>>> idle_sync_thread, if sync_seq isn't equal
> >>>>>>>>
> >>>>>>>> mddev->sync_seq, it should mean there is someone that stops the =
sync
> >>>>>>>> thread already, right? Why do
> >>>>>>>>
> >>>>>>>> you say 'new started sync thread' here?
> >>>>>>
> >>>>>> If someone stops the sync thread, and new sync thread is not start=
ed,
> >>>>>> then this sync_seq won't make a difference, above wait_event() wil=
l not
> >>>>>> wait because !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) will=
 pass.
> >>>>>> So 'sync_seq' is only used when the old sync thread stops and new =
sync
> >>>>>> thread starts, add 'sync_seq' will bypass this case.
> >>>>>
> >>>>> Hi
> >>>>>
> >>>>> If a new sync thread starts, why can sync_seq be different? sync_se=
q
> >>>>> is only added in md_reap_sync_thread. And when a new sync request
> >>>>> starts, it can't stop the sync request again?
> >>>>>
> >>>>> Af first, the sync_seq is 0
> >>>>>
> >>>>> admin1
> >>>>> echo idle > sync_action
> >>>>> idle_sync_thread(sync_seq is 1)
> >>>>
> >>>> Wait, I'm confused here, how can sync_seq to be 1 here? I suppose yo=
u
> >>>> mean that there is a sync_thread just finished?
> >>>
> >>> Hi Kuai
> >>>
> >>> Yes. Because idle_sync_thread needs to wait until md_reap_sync_thread
> >>> finishes. And md_reap_sync_thread adds sync_seq. Do I understand your
> >>> patch right?
> >>
> >> Yes, noted that idle_sync_thread() will only wait if MD_RECOVERY_RUNNI=
NG
> >> is set.
> >>
> >>>
> >>>>
> >>>> Then the problem is that idle_sync_thread() read sync_seq after the =
old
> >>>> sync_thread is done, and new sync_thread start before wait_event() i=
s
> >>>> called, should we wait for this new sync_thread?
> >>>>
> >>>> My answer here is that we should, but I'm also ok to not wait this n=
ew
> >>>> sync_thread, I don't think this behaviour matters. The key point her=
e
> >>>> is that once wait_event() is called from idle_sync_thread(), this
> >>>> wait_event() should not wait for new sync_thread...
> >>>
> >>> I think we should wait. If we don't wait for it, there is a problem.
> >>> One person echos idle to sync_action and it doesn't work sometimes.
> >>> It's a strange thing.
> >>>
> >>
> >> Ok. I'll add new comment to emphasize that idle_sync_thread() won't wa=
it
> >> for new sync_thread that is started after wait_event().
> >
> > I suggest removing this function. Without this change, it's more
> > simple and it can work well without problem. The people that echo idle
> > to sync_action needs to wait until the sync action finishes. The code
> > semantic is clear and simple.
> >>
> >>>>
> >>>>> echo resync > sync_action (new sync)
> >>>>
> >>>> If this is behind "echo idle > sync_action", idle_sync_thread should=
 not
> >>>> see that MD_RECOVERY_RUNNING is set and wait_event() won't wait at a=
ll.
> >>>
> >>> `echo resync > sync_action` can't change the sync_seq. So 'echo idle =
>
> >>> sync_action' still waits until MD_RECOVERY_RUNNING is cleared?
> >>
> >> This is not accurate, if `echo resync > sync_action` triggers a new
> >> sync_thread, then sync_seq is updated when this sync_thread is done,
> >> during this period, MD_RECOVERY_RUNNING is still set, so `echo idle
> >>   >sync_action` will wait for sync_thread to be done.
> >
> > I can understand your comment, but sorry, I still can't get how
> > sync_seq works. Could you give a specific case that explains how it
> > works?
>
> Ok, the problem is that echo ilde is supposed to interrupt sync_thread
> and stop sync_thread quickly. Now that we don't hold mutex here, we
> can't prevent new sync_thread to start. For exapmle:
>
> 1) a sync_thread A is runing, MD_RECOVERY_RUNNING is set;
>
> 2) echo idle, A will be interrupted, mutex is not hold and
> idle_sync_thread() is waiting for MD_RECOVERY_RUNNING to be cleared.
>
> 3) A is interrupted, it'll clear MD_RECOVERY_RUNNING and try to wakeup
> idle_sync_thread(), however, before idle_sync_thread() is woken, A can
> be done and a new sync_thread B can be started, and MD_RECOVERY_RUNNING
> will be set again.
>
> 4) idle_sync_thread() finially wake up, however, MD_RECOVERY_RUNNING is
> set and it will still waiting. And this time B won't be interrupted.

Thanks for the example. I can understand the usage of it. It's the
side effect that removes the mutex protection for idle_sync_thread.

There is a problem. New sync thread is started in md_check_recovery.
After your patch, md_reap_sync_thread is called in md_check_recovery
too. So it looks like they can't happen at the same time?

Regards
Xiao

>
> Thanks,
> Kuai
>
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel

