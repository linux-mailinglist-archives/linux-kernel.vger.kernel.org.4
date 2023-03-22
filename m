Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEED6C43EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCVHTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVHTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:19:38 -0400
Received: from out-61.mta1.migadu.com (out-61.mta1.migadu.com [IPv6:2001:41d0:203:375::3d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E852472F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:19:37 -0700 (PDT)
Message-ID: <2c2599ec-ac35-6494-aedf-93ecca1969ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679469571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o53k2p6glaoiDYukHCSRh6Btu1bVKewMBR7QFKWgLkg=;
        b=wld8e54hz0YaDG0EW96ru7CuSB6m9mtzo96/G6wzVio56T3k/ju2LVrEnz87MG+GLUYoAR
        Rxn9ezgruV7GBo55cPmDJWD5m4rzZO92t7hLJtep9TjWm8SzUIYO119RRGu+ZQjBZW+uqO
        LU0os+e5hrT4F+hap7LecbyLbRlhVdA=
Date:   Wed, 22 Mar 2023 15:19:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH -next 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
To:     Yu Kuai <yukuai1@huaweicloud.com>, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
 <20230322064122.2384589-2-yukuai1@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230322064122.2384589-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/23 14:41, Yu Kuai wrote:
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

If the workqueue subsystem can have such problem because of md flag,
then I have to think workqueue is fragile.

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

Assume you mean below,

1551 if(!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
1552                 __queue_work(cpu, wq, work);
1553                 ret = true;
1554         }

Could you explain how the same work can be re-queued? Isn't the PENDING_BIT
is already set in t3? I believe queue_work shouldn't do that per the comment
but I am not expert ...

Returns %false if @work was already on a queue, %true otherwise.

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
> This patch revert the commit to fix the problem, the deadlock this
> commit tries to fix will be fixed in following patches.

Pls cc the previous users who had encounter the problem to test the
second patch.

And can you share your test which can trigger the re-queued issue?
I'd like to try with latest mainline such as 6.3-rc3, and your test is
not only run against 5.10 kernel as you described before, right?

Thanks,
Guoqing

