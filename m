Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300272D9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbjFMG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjFMG0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA3E4A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686637551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dk4w/dlhnM14+5Pc/Gjm/pjDzAHKz0WKmVblyd15aqY=;
        b=cMaUvktPXuWDcQYNAYWBgcCFQHucyWMcdyxQqlAViYLGcLKNvDyYOAnI6dhfAq522W4Hom
        FZK/1eZr1xvl6V10Eo0LVVei3dfTDvdJLQd+uvTHtKzCHoyAMVOe2tLjwGmpef5DlmrSRA
        u4Db1cgofgWykQ3gqQPNBKkNtk3v2d4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-3JGzVT4dM5eSQ3ZA8KpF3w-1; Tue, 13 Jun 2023 02:25:48 -0400
X-MC-Unique: 3JGzVT4dM5eSQ3ZA8KpF3w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-653bbc6e2fdso2874288b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686637547; x=1689229547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dk4w/dlhnM14+5Pc/Gjm/pjDzAHKz0WKmVblyd15aqY=;
        b=DRZ7DtNaeMqTijqUiYOwBxPIfvUBoo8OM77NfnKKnwfDLO1eK84eUM5LYmzn/aoNFn
         l+KuEW/SD6/qhf6v+BgwIRIuMyDzXop2d9EiSHs7UqmJH1F3ziyJiVhIeiTzG4NiJsvh
         vPC4dhjLpSqrgvlh+Ivs29iF4B1+Dm8mlDG5lW7R1hdCqF3T3U7+CkEDintTCS9XadLS
         iMycjFwJpKaVvr83O8OdqI8csvZclGWVAEfn34d8n2ByDDyAVeMlgUA1hgr6sZ4eHuMV
         EK5BTkykBOV1qBuQj/VLNG37Qers7LL8H8vxaGDl3L517Olki/E7kOG/DkaRXSKcpDJT
         KyTQ==
X-Gm-Message-State: AC+VfDxGgm4/e+kbZTUIZZyfis5cO2U3COlL2VHn7m0upe/49xdZ4IDw
        +UqLaqxnyObpfdOIw4ehalZmc8ASQjo3vMyk0EEnfpY+19WIzZbqKMWEQVhoYFxq80l4BSKdFG2
        4dMjhjBXQxc+AhoVF3FMqfvbe
X-Received: by 2002:a05:6a20:a5a8:b0:10b:6b1f:c8c8 with SMTP id bc40-20020a056a20a5a800b0010b6b1fc8c8mr9951054pzb.31.1686637547089;
        Mon, 12 Jun 2023 23:25:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4u3LPIN5hkek6lUp2dJz1pyTMTONqTlT2y5JtlLRtJ1OFqReJODea6RGuFRUGvABTUi5JnGQ==
X-Received: by 2002:a05:6a20:a5a8:b0:10b:6b1f:c8c8 with SMTP id bc40-20020a056a20a5a800b0010b6b1fc8c8mr9951043pzb.31.1686637546719;
        Mon, 12 Jun 2023 23:25:46 -0700 (PDT)
Received: from [10.72.13.126] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a10-20020aa780ca000000b00640f1e4a811sm7868913pfn.22.2023.06.12.23.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 23:25:46 -0700 (PDT)
Message-ID: <2d9f34b1-48e1-73a7-8548-bfd1843d3a0a@redhat.com>
Date:   Tue, 13 Jun 2023 14:25:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH -next v2 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
To:     Yu Kuai <yukuai1@huaweicloud.com>, guoqing.jiang@linux.dev,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-2-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
In-Reply-To: <20230529132037.2124527-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/29 下午9:20, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> This reverts commit 9dfbdafda3b34e262e43e786077bab8e476a89d1.
>
> Because it will introduce a defect that sync_thread can be running while
> MD_RECOVERY_RUNNING is cleared, which will cause some unexpected problems,
> for example:
>
> list_add corruption. prev->next should be next (ffff0001ac1daba0), but was ffff0000ce1a02a0. (prev=ffff0000ce1a02a0).
> Call trace:
>   __list_add_valid+0xfc/0x140
>   insert_work+0x78/0x1a0
>   __queue_work+0x500/0xcf4
>   queue_work_on+0xe8/0x12c
>   md_check_recovery+0xa34/0xf30
>   raid10d+0xb8/0x900 [raid10]
>   md_thread+0x16c/0x2cc
>   kthread+0x1a4/0x1ec
>   ret_from_fork+0x10/0x18
>
> This is because work is requeued while it's still inside workqueue:
>
> t1:			t2:
> action_store
>   mddev_lock
>    if (mddev->sync_thread)
>     mddev_unlock
>     md_unregister_thread
>     // first sync_thread is done
> 			md_check_recovery
> 			 mddev_try_lock
> 			 /*
> 			  * once MD_RECOVERY_DONE is set, new sync_thread
> 			  * can start.
> 			  */
> 			 set_bit(MD_RECOVERY_RUNNING, &mddev->recovery)
> 			 INIT_WORK(&mddev->del_work, md_start_sync)
> 			 queue_work(md_misc_wq, &mddev->del_work)
> 			  test_and_set_bit(WORK_STRUCT_PENDING_BIT, ...)
> 			  // set pending bit
> 			  insert_work
> 			   list_add_tail
> 			 mddev_unlock
>     mddev_lock_nointr
>     md_reap_sync_thread
>     // MD_RECOVERY_RUNNING is cleared
>   mddev_unlock
>
> t3:
>
> // before queued work started from t2
> md_check_recovery
>   // MD_RECOVERY_RUNNING is not set, a new sync_thread can be started
>   INIT_WORK(&mddev->del_work, md_start_sync)
>    work->data = 0
>    // work pending bit is cleared
>   queue_work(md_misc_wq, &mddev->del_work)
>    insert_work
>     list_add_tail
>     // list is corrupted
>
> The above commit is reverted to fix the problem, the deadlock this
> commit tries to fix will be fixed in following patches.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/dm-raid.c |  1 -
>   drivers/md/md.c      | 19 ++-----------------
>   2 files changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index 8846bf510a35..1f22bef27841 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3725,7 +3725,6 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
>   	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
>   		if (mddev->sync_thread) {
>   			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -			md_unregister_thread(&mddev->sync_thread);
>   			md_reap_sync_thread(mddev);
>   		}
>   	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index a5a7af2f4e59..9b97731e1fe4 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4772,19 +4772,6 @@ action_store(struct mddev *mddev, const char *page, size_t len)
>   			if (work_pending(&mddev->del_work))
>   				flush_workqueue(md_misc_wq);
>   			if (mddev->sync_thread) {
> -				sector_t save_rp = mddev->reshape_position;
> -
> -				mddev_unlock(mddev);
> -				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -				md_unregister_thread(&mddev->sync_thread);
> -				mddev_lock_nointr(mddev);
> -				/*
> -				 * set RECOVERY_INTR again and restore reshape
> -				 * position in case others changed them after
> -				 * got lock, eg, reshape_position_store and
> -				 * md_check_recovery.
> -				 */
> -				mddev->reshape_position = save_rp;
>   				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>   				md_reap_sync_thread(mddev);
>   			}
> @@ -6184,7 +6171,6 @@ static void __md_stop_writes(struct mddev *mddev)
>   		flush_workqueue(md_misc_wq);
>   	if (mddev->sync_thread) {
>   		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -		md_unregister_thread(&mddev->sync_thread);
>   		md_reap_sync_thread(mddev);
>   	}
>   
> @@ -9336,7 +9322,6 @@ void md_check_recovery(struct mddev *mddev)
>   			 * ->spare_active and clear saved_raid_disk
>   			 */
>   			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -			md_unregister_thread(&mddev->sync_thread);
>   			md_reap_sync_thread(mddev);
>   			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
>   			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> @@ -9372,7 +9357,6 @@ void md_check_recovery(struct mddev *mddev)
>   			goto unlock;
>   		}
>   		if (mddev->sync_thread) {
> -			md_unregister_thread(&mddev->sync_thread);
>   			md_reap_sync_thread(mddev);
>   			goto unlock;
>   		}
> @@ -9452,7 +9436,8 @@ void md_reap_sync_thread(struct mddev *mddev)
>   	sector_t old_dev_sectors = mddev->dev_sectors;
>   	bool is_reshaped = false;
>   
> -	/* sync_thread should be unregistered, collect result */
> +	/* resync has finished, collect result */
> +	md_unregister_thread(&mddev->sync_thread);
>   	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
>   	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
>   	    mddev->degraded != mddev->raid_disks) {


Hi Kuai

Thanks for the patch and the explanation in V1. In version1, I took much 
time to try to understand the problem. Maybe we can use the problem

itself as the subject. Something like "Don't allow two sync processes 
running at the same time"? And could you add the test steps which talked 
in v1

in the patch? It can help to understand the problem very much.

Best Regards

Xiao

