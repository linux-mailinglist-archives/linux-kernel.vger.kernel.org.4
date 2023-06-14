Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B372F506
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbjFNGjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbjFNGjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91FC2101
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686724689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5k1uTdFKNnZoPvkrzeDCXgtuJb8TSEwllYNQtChNT4=;
        b=bR3sxIuk0FDimHVer6ug3p61pLUKKAOaxZ7zkvq9YwgUC/DaaI00kz0PYQ0lIchLsSqvS8
        qu3DvRmLVfQdNOdcc5opkdoiQ59a4ZitrF/O7FgWXg5k07+UXPjZj313LjM+BC7aZ6fXoI
        Eo12UaX6bIXHF1N5NUXH2h0eidhKJF0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-PwnlvAudOCig-VgSs3N0Dw-1; Wed, 14 Jun 2023 02:38:06 -0400
X-MC-Unique: PwnlvAudOCig-VgSs3N0Dw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-25e0bab24aaso160506a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686724685; x=1689316685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5k1uTdFKNnZoPvkrzeDCXgtuJb8TSEwllYNQtChNT4=;
        b=VCVOhd+vHfDDnRzD+G2TbixgVMspDGV3jIRjZJmXsfa22jsT2eFc7w5SR8x/d/tgV3
         VibsKjtbK5VOs1g9/W5H+2r2Q4Uj9OzEBylmD5YOh7/eX2eIgGhE3ZqCTTnaGmPHr5A/
         whZg8kZFHcyF2dWRqk4UPeR3QbMxMWuX1oKVRPK2naulpJyBScjKVBktooixH+soqrCe
         an8imIK1JbklgxR6zQaBKxF+maLUJdS+JZ6UyfaFW9MftwTfHsMVW0d3ri0SL32B8TnG
         H7q/S17nUkn8thf3r55+1VlfRtr6PQfnxdVIP6UgY1c+0GuFpIsIjeihgmhKuA9dKgJh
         xd6w==
X-Gm-Message-State: AC+VfDzNMnpY3V7IJ3529y4wrJyPSebkmOkIN+5Ojh0yXJ74zZ3C7IzD
        GiHewxKJrGSATgwwWtOon2tnFKYJNXS7DBwWQBSZxNv7FaVrt4pk5/AXpjUefzKe5/0vOLoAJea
        LIfgKyPaakTJ3cKBtd2nYFDflU/zdNAcgMiWb0Mgs
X-Received: by 2002:a17:90a:1b21:b0:256:9b75:84cf with SMTP id q30-20020a17090a1b2100b002569b7584cfmr868671pjq.6.1686724685017;
        Tue, 13 Jun 2023 23:38:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fZLy+FWqn8O4O5SMC+HnwHFAUBN710YNQaqDxUVxNDWfEbCJ9vbEuFEiKJMKPSgHK5V1e3bIiPliaSykzs/E=
X-Received: by 2002:a17:90a:1b21:b0:256:9b75:84cf with SMTP id
 q30-20020a17090a1b2100b002569b7584cfmr868663pjq.6.1686724684668; Tue, 13 Jun
 2023 23:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com> <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
 <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com> <CALTww2_9U0Ez-NCHmzdcd48qXjWpkjvhwunSmYOfKVnX=5=HTg@mail.gmail.com>
 <8f466830-56e7-1106-c935-3e73a2206916@huaweicloud.com>
In-Reply-To: <8f466830-56e7-1106-c935-3e73a2206916@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 14 Jun 2023 14:37:53 +0800
Message-ID: <CALTww2_ZXr5kHeRdJ_=xpGQHk97GuZ_cY9i5gAs8a8K-TQLkPQ@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 2:05=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/14 11:47, Xiao Ni =E5=86=99=E9=81=93:
> > On Wed, Jun 14, 2023 at 9:48=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/06/13 22:50, Xiao Ni =E5=86=99=E9=81=93:
> >>>
> >>> =E5=9C=A8 2023/5/29 =E4=B8=8B=E5=8D=889:20, Yu Kuai =E5=86=99=E9=81=
=93:
> >>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>
> >>>> Our test found a following deadlock in raid10:
> >>>>
> >>>> 1) Issue a normal write, and such write failed:
> >>>>
> >>>>     raid10_end_write_request
> >>>>      set_bit(R10BIO_WriteError, &r10_bio->state)
> >>>>      one_write_done
> >>>>       reschedule_retry
> >>>>
> >>>>     // later from md thread
> >>>>     raid10d
> >>>>      handle_write_completed
> >>>>       list_add(&r10_bio->retry_list, &conf->bio_end_io_list)
> >>>>
> >>>>     // later from md thread
> >>>>     raid10d
> >>>>      if (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
> >>>>       list_move(conf->bio_end_io_list.prev, &tmp)
> >>>>       r10_bio =3D list_first_entry(&tmp, struct r10bio, retry_list)
> >>>>       raid_end_bio_io(r10_bio)
> >>>>
> >>>> Dependency chain 1: normal io is waiting for updating superblock
> >>>
> >>> Hi Kuai
> >>>
> >>> It looks like the above situation is more complex. It only needs a
> >>> normal write and md_write_start needs to
> >>>
> >>> wait until the metadata is written to member disks, right? If so, it
> >>> doesn't need to introduce raid10 write failure
> >>>
> >>> here. I guess, it should be your test case. It's nice, if you can put
> >>> your test steps in the patch. But for the analysis
> >>>
> >>> of the deadlock here, it's better to be simple.
> >>
> >> Test script can be found here, it's pretty easy to trigger:
> >>
> >> https://patchwork.kernel.org/project/linux-raid/patch/20230529132826.2=
125392-4-yukuai1@huaweicloud.com/
> >
> > Thanks for this.
> >>
> >> While reviewing the related code, I found that io can only be added to
> >> list bio_end_io_list from handle_write_completed() if such io failed, =
so
> >> I think io failure is needed to trigger deadlock from daemon thread.
> >>
> >> I think the key point is how MD_SB_CHANGE_PENDING is set:
> >>
> >> 1) raid10_error() and rdev_set_badblocks(), trigger by io failure;
> >> 2) raid10_write_request() related to reshape;
> >> 3) md_write_start() and md_allow_write(), and mddev->in_sync is set,
> >> however, I was thinking this is not a common case;
> >>
> >> 1) is used here because it's quite easy to trigger and this is what
> >> we meet in real test. 3) is possible but I will say let's keep 1), I
> >> don't think it's necessary to reporduce this deadlock through another
> >> path again.
> >
> > It makes sense. Let's go back to the first path mentioned in the patch.
> >
> >> 1) Issue a normal write, and such write failed:
> >>
> >>     raid10_end_write_request
> >>      set_bit(R10BIO_WriteError, &r10_bio->state)
> >>      one_write_done
> >>       reschedule_retry
> >
> > This is good.
> >>
> >>     // later from md thread
> >>     raid10d
> >>      handle_write_completed
> >>       list_add(&r10_bio->retry_list, &conf->bio_end_io_list)
> >
> > I have a question here. It should run narrow_write_error in
> > handle_write_completed. In the test case, will narrow_write_error run
> > successfully? Or it fails and will call rdev_set_badblocks and
> > md_error. So MD_RECOVERY_PENDING will be set?
>
> r10_bio will always be added to bio_end_io_list, no matter
> narrow_write_error() succeed or not. The dependecy chain 1 here is just
> indicate handle this r10_bio will wait for updating super block, it's
> not where MD_RECOVERY_PENDING is set...
>
> And MD_RECOVERY_PENDING can be set from narrow_write_error() and other
> places where rdev_set_badblocks() is called.

Because in your patch, it doesn't show which step sets
MD_RECOVERY_PENDING. It's the reason I need to guess. It's a normal
write, so md_write_start can set the flag. In this case, it can cause
the same deadlock. So it's better to give which step sets the flag.
> >
> >>
> >>     // later from md thread
> >>     raid10d
> >>      if (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>         -> It's here, if the flag is set, bio won't be handled.

Yes.

> >>       list_move(conf->bio_end_io_list.prev, &tmp)
> >>       r10_bio =3D list_first_entry(&tmp, struct r10bio, retry_list)
> >>       raid_end_bio_io(r10_bio)
> >>
> >> Dependency chain 1: normal io is waiting for updating superblock
> >
> > It's a little hard to understand. Because it doesn't show how normal
> > io waits for a superblock update. And based on your last email, I
> > guess you want to say rdev_set_badblock sets MD_RECOVERY_PENDING, but
> > the flag can't be cleared, so the bios can't be added to
> > bio_end_io_list, so the io rquests can't be finished.
>
> It's not that bio can't be added to bio_end_io_list, it's that bio in
> this list can't be handled if sb_flags is set.

Sorry for this. I wanted to say the same thing. I understand the case total=
ly.

Regards
Xiao
>
> Thanks,
> Kuai
> >
> > Regards
> > Xiao
> >>
> >> Thanks,
> >> Kuai
> >>>
> >>>>
> >>>> 2) Trigger a recovery:
> >>>>
> >>>>     raid10_sync_request
> >>>>      raise_barrier
> >>>>
> >>>> Dependency chain 2: sync thread is waiting for normal io
> >>>>
> >>>> 3) echo idle/frozen to sync_action:
> >>>>
> >>>>     action_store
> >>>>      mddev_lock
> >>>>       md_unregister_thread
> >>>>        kthread_stop
> >>>>
> >>>> Dependency chain 3: drop 'reconfig_mutex' is waiting for sync thread
> >>>>
> >>>> 4) md thread can't update superblock:
> >>>>
> >>>>     raid10d
> >>>>      md_check_recovery
> >>>>       if (mddev_trylock(mddev))
> >>>>        md_update_sb
> >>>>
> >>>> Dependency chain 4: update superblock is waiting for 'reconfig_mutex=
'
> >>>>
> >>>> Hence cyclic dependency exist, in order to fix the problem, we must
> >>>> break one of them. Dependency 1 and 2 can't be broken because they a=
re
> >>>> foundation design. Dependency 4 may be possible if it can be guarant=
eed
> >>>> that no io can be inflight, however, this requires a new mechanism w=
hich
> >>>> seems complex. Dependency 3 is a good choice, because idle/frozen on=
ly
> >>>> requires sync thread to finish, which can be done asynchronously tha=
t is
> >>>> already implemented, and 'reconfig_mutex' is not needed anymore.
> >>>>
> >>>> This patch switch 'idle' and 'frozen' to wait sync thread to be done
> >>>> asynchronously, and this patch also add a sequence counter to record=
 how
> >>>> many times sync thread is done, so that 'idle' won't keep waiting on=
 new
> >>>> started sync thread.
> >>>
> >>> In the patch, sync_seq is added in md_reap_sync_thread. In
> >>> idle_sync_thread, if sync_seq isn't equal
> >>>
> >>> mddev->sync_seq, it should mean there is someone that stops the sync
> >>> thread already, right? Why do
> >>>
> >>> you say 'new started sync thread' here?
> >>>
> >>> Regards
> >>>
> >>> Xiao
> >>>
> >>>
> >>>>
> >>>> Noted that raid456 has similiar deadlock([1]), and it's verified[2] =
this
> >>>> deadlock can be fixed by this patch as well.
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/linux-raid/5ed54ffc-ce82-bf66-4eff-390cb23bc=
1ac@molgen.mpg.de/T/#t
> >>>>
> >>>> [2]
> >>>> https://lore.kernel.org/linux-raid/e9067438-d713-f5f3-0d3d-9e6b0e9ef=
a0e@huaweicloud.com/
> >>>>
> >>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>>> ---
> >>>>    drivers/md/md.c | 23 +++++++++++++++++++----
> >>>>    drivers/md/md.h |  2 ++
> >>>>    2 files changed, 21 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >>>> index 63a993b52cd7..7912de0e4d12 100644
> >>>> --- a/drivers/md/md.c
> >>>> +++ b/drivers/md/md.c
> >>>> @@ -652,6 +652,7 @@ void mddev_init(struct mddev *mddev)
> >>>>        timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
> >>>>        atomic_set(&mddev->active, 1);
> >>>>        atomic_set(&mddev->openers, 0);
> >>>> +    atomic_set(&mddev->sync_seq, 0);
> >>>>        spin_lock_init(&mddev->lock);
> >>>>        atomic_set(&mddev->flush_pending, 0);
> >>>>        init_waitqueue_head(&mddev->sb_wait);
> >>>> @@ -4776,19 +4777,27 @@ static void stop_sync_thread(struct mddev *m=
ddev)
> >>>>        if (work_pending(&mddev->del_work))
> >>>>            flush_workqueue(md_misc_wq);
> >>>> -    if (mddev->sync_thread) {
> >>>> -        set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> >>>> -        md_reap_sync_thread(mddev);
> >>>> -    }
> >>>> +    set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> >>>> +    /*
> >>>> +     * Thread might be blocked waiting for metadata update which wi=
ll
> >>>> now
> >>>> +     * never happen
> >>>> +     */
> >>>> +    md_wakeup_thread_directly(mddev->sync_thread);
> >>>>        mddev_unlock(mddev);
> >>>>    }
> >>>>    static void idle_sync_thread(struct mddev *mddev)
> >>>>    {
> >>>> +    int sync_seq =3D atomic_read(&mddev->sync_seq);
> >>>> +
> >>>>        mutex_lock(&mddev->sync_mutex);
> >>>>        clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>>>        stop_sync_thread(mddev);
> >>>> +
> >>>> +    wait_event(resync_wait, sync_seq !=3D atomic_read(&mddev->sync_=
seq) ||
> >>>> +            !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> >>>> +
> >>>>        mutex_unlock(&mddev->sync_mutex);
> >>>>    }
> >>>> @@ -4797,6 +4806,10 @@ static void frozen_sync_thread(struct mddev
> >>>> *mddev)
> >>>>        mutex_init(&mddev->delete_mutex);
> >>>>        set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>>>        stop_sync_thread(mddev);
> >>>> +
> >>>> +    wait_event(resync_wait, mddev->sync_thread =3D=3D NULL &&
> >>>> +            !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> >>>> +
> >>>>        mutex_unlock(&mddev->sync_mutex);
> >>>>    }
> >>>> @@ -9472,6 +9485,8 @@ void md_reap_sync_thread(struct mddev *mddev)
> >>>>        /* resync has finished, collect result */
> >>>>        md_unregister_thread(&mddev->sync_thread);
> >>>> +    atomic_inc(&mddev->sync_seq);
> >>>> +
> >>>>        if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
> >>>>            !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
> >>>>            mddev->degraded !=3D mddev->raid_disks) {
> >>>> diff --git a/drivers/md/md.h b/drivers/md/md.h
> >>>> index 2fa903de5bd0..7cab9c7c45b8 100644
> >>>> --- a/drivers/md/md.h
> >>>> +++ b/drivers/md/md.h
> >>>> @@ -539,6 +539,8 @@ struct mddev {
> >>>>        /* Used to synchronize idle and frozen for action_store() */
> >>>>        struct mutex            sync_mutex;
> >>>> +    /* The sequence number for sync thread */
> >>>> +    atomic_t sync_seq;
> >>>>        bool    has_superblocks:1;
> >>>>        bool    fail_last_dev:1;
> >>>
> >>> --
> >>> dm-devel mailing list
> >>> dm-devel@redhat.com
> >>> https://listman.redhat.com/mailman/listinfo/dm-devel
> >>
> >
> > .
> >
>

