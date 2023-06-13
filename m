Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6780872E64B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbjFMOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbjFMOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD11BD7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686667849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikgXDkZHBsCjzY+A0qkf0lU60eX77I2cT+RYzCffXOs=;
        b=Z4sB0AQa93lt1kBxUQYaAoK7mD3+2rPLOSq/I8XrlbAVi+HHhDgKlg4pQZcvNC/ghMtJyw
        zsYD/YLqOJ1IOWL/J+2NrjiJZ4Eqwxu6IPLcvcKWdWRldZZQ7kPvHZNufTbH7InnoFTuDF
        LY1xq2Yo4JdYIFdUs8T7KH2L9T5Sqdc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-BP40pQ8QMgaZxoYEJnOnYQ-1; Tue, 13 Jun 2023 10:50:47 -0400
X-MC-Unique: BP40pQ8QMgaZxoYEJnOnYQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-25b79a5cf1aso2559994a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686667845; x=1689259845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ikgXDkZHBsCjzY+A0qkf0lU60eX77I2cT+RYzCffXOs=;
        b=GTrD8E+PVDZ3zk59vrvdSumqiTqgKklC/EM+Ltm420t/HSFB2xdZxnTFZECuwBws/l
         1uhdoJQfZDCmzfZnKMDqp1rqoD3sAJM5TvSuFpmfyfhtkLx6DoD6yA5/0eZLgNWrlj+t
         EqtFADrI0lWvUzzuy14ESbjs2FYBGjqSaX3qqNeJGK2rDec/nOfGPoKFSeQhoiS4SjqH
         BJSf33lwQxf/RQcX+U4A3XZ276lVVIlFzS5cRI8R3x6T1l0FYEjbLhhvKrA5ZdTDAByA
         ve+fdz71PHMP1c1I8BDNR57f8FY1g3jJRMgY9seKVhhdlWxiO+l/SForC3wci7MKnwc7
         DpLg==
X-Gm-Message-State: AC+VfDxgicuyGfFQ7ps8nVlbr+U6uewaqbR4wiDsUxOR9ae7tVKw5TtF
        bSBZxihDs5/s0YYgRFv/ilDb55brvDtPR59PcQJbZKWDlbZ+cI4R8wUa9pdBBqFGijfdmd3Ddil
        b772v2X3hGrqOlNWJFgn3W/gq
X-Received: by 2002:a17:90a:194:b0:253:2816:2a12 with SMTP id 20-20020a17090a019400b0025328162a12mr15317190pjc.14.1686667844895;
        Tue, 13 Jun 2023 07:50:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Bt2CRY2VUetf0DarnAuK1U13D3rFv/ig4TcfKha1cByA48VHNrec0OAISqzDERasKpJFtkw==
X-Received: by 2002:a17:90a:194:b0:253:2816:2a12 with SMTP id 20-20020a17090a019400b0025328162a12mr15317162pjc.14.1686667844560;
        Tue, 13 Jun 2023 07:50:44 -0700 (PDT)
Received: from [10.72.13.126] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a3c8300b0024e33c69ee5sm9324231pjc.5.2023.06.13.07.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 07:50:44 -0700 (PDT)
Message-ID: <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
Date:   Tue, 13 Jun 2023 22:50:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor
 idle/frozen_sync_thread() to fix deadlock
To:     Yu Kuai <yukuai1@huaweicloud.com>, guoqing.jiang@linux.dev,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
In-Reply-To: <20230529132037.2124527-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/29 下午9:20, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Our test found a following deadlock in raid10:
>
> 1) Issue a normal write, and such write failed:
>
>    raid10_end_write_request
>     set_bit(R10BIO_WriteError, &r10_bio->state)
>     one_write_done
>      reschedule_retry
>
>    // later from md thread
>    raid10d
>     handle_write_completed
>      list_add(&r10_bio->retry_list, &conf->bio_end_io_list)
>
>    // later from md thread
>    raid10d
>     if (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>      list_move(conf->bio_end_io_list.prev, &tmp)
>      r10_bio = list_first_entry(&tmp, struct r10bio, retry_list)
>      raid_end_bio_io(r10_bio)
>
> Dependency chain 1: normal io is waiting for updating superblock

Hi Kuai

It looks like the above situation is more complex. It only needs a 
normal write and md_write_start needs to

wait until the metadata is written to member disks, right? If so, it 
doesn't need to introduce raid10 write failure

here. I guess, it should be your test case. It's nice, if you can put 
your test steps in the patch. But for the analysis

of the deadlock here, it's better to be simple.

>
> 2) Trigger a recovery:
>
>    raid10_sync_request
>     raise_barrier
>
> Dependency chain 2: sync thread is waiting for normal io
>
> 3) echo idle/frozen to sync_action:
>
>    action_store
>     mddev_lock
>      md_unregister_thread
>       kthread_stop
>
> Dependency chain 3: drop 'reconfig_mutex' is waiting for sync thread
>
> 4) md thread can't update superblock:
>
>    raid10d
>     md_check_recovery
>      if (mddev_trylock(mddev))
>       md_update_sb
>
> Dependency chain 4: update superblock is waiting for 'reconfig_mutex'
>
> Hence cyclic dependency exist, in order to fix the problem, we must
> break one of them. Dependency 1 and 2 can't be broken because they are
> foundation design. Dependency 4 may be possible if it can be guaranteed
> that no io can be inflight, however, this requires a new mechanism which
> seems complex. Dependency 3 is a good choice, because idle/frozen only
> requires sync thread to finish, which can be done asynchronously that is
> already implemented, and 'reconfig_mutex' is not needed anymore.
>
> This patch switch 'idle' and 'frozen' to wait sync thread to be done
> asynchronously, and this patch also add a sequence counter to record how
> many times sync thread is done, so that 'idle' won't keep waiting on new
> started sync thread.

In the patch, sync_seq is added in md_reap_sync_thread. In 
idle_sync_thread, if sync_seq isn't equal

mddev->sync_seq, it should mean there is someone that stops the sync 
thread already, right? Why do

you say 'new started sync thread' here?

Regards

Xiao


>
> Noted that raid456 has similiar deadlock([1]), and it's verified[2] this
> deadlock can be fixed by this patch as well.
>
> [1] https://lore.kernel.org/linux-raid/5ed54ffc-ce82-bf66-4eff-390cb23bc1ac@molgen.mpg.de/T/#t
> [2] https://lore.kernel.org/linux-raid/e9067438-d713-f5f3-0d3d-9e6b0e9efa0e@huaweicloud.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 23 +++++++++++++++++++----
>   drivers/md/md.h |  2 ++
>   2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 63a993b52cd7..7912de0e4d12 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -652,6 +652,7 @@ void mddev_init(struct mddev *mddev)
>   	timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
>   	atomic_set(&mddev->active, 1);
>   	atomic_set(&mddev->openers, 0);
> +	atomic_set(&mddev->sync_seq, 0);
>   	spin_lock_init(&mddev->lock);
>   	atomic_set(&mddev->flush_pending, 0);
>   	init_waitqueue_head(&mddev->sb_wait);
> @@ -4776,19 +4777,27 @@ static void stop_sync_thread(struct mddev *mddev)
>   	if (work_pending(&mddev->del_work))
>   		flush_workqueue(md_misc_wq);
>   
> -	if (mddev->sync_thread) {
> -		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -		md_reap_sync_thread(mddev);
> -	}
> +	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> +	/*
> +	 * Thread might be blocked waiting for metadata update which will now
> +	 * never happen
> +	 */
> +	md_wakeup_thread_directly(mddev->sync_thread);
>   
>   	mddev_unlock(mddev);
>   }
>   
>   static void idle_sync_thread(struct mddev *mddev)
>   {
> +	int sync_seq = atomic_read(&mddev->sync_seq);
> +
>   	mutex_lock(&mddev->sync_mutex);
>   	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>   	stop_sync_thread(mddev);
> +
> +	wait_event(resync_wait, sync_seq != atomic_read(&mddev->sync_seq) ||
> +			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> +
>   	mutex_unlock(&mddev->sync_mutex);
>   }
>   
> @@ -4797,6 +4806,10 @@ static void frozen_sync_thread(struct mddev *mddev)
>   	mutex_init(&mddev->delete_mutex);
>   	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>   	stop_sync_thread(mddev);
> +
> +	wait_event(resync_wait, mddev->sync_thread == NULL &&
> +			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> +
>   	mutex_unlock(&mddev->sync_mutex);
>   }
>   
> @@ -9472,6 +9485,8 @@ void md_reap_sync_thread(struct mddev *mddev)
>   
>   	/* resync has finished, collect result */
>   	md_unregister_thread(&mddev->sync_thread);
> +	atomic_inc(&mddev->sync_seq);
> +
>   	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
>   	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
>   	    mddev->degraded != mddev->raid_disks) {
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 2fa903de5bd0..7cab9c7c45b8 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -539,6 +539,8 @@ struct mddev {
>   
>   	/* Used to synchronize idle and frozen for action_store() */
>   	struct mutex			sync_mutex;
> +	/* The sequence number for sync thread */
> +	atomic_t sync_seq;
>   
>   	bool	has_superblocks:1;
>   	bool	fail_last_dev:1;

