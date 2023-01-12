Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70601666B20
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 07:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbjALGOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 01:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbjALGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 01:14:47 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F82940867
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 22:14:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NsvQf1SL0z4f3v6l
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:14:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgBnDetKpb9jeJouBg--.14037S2;
        Thu, 12 Jan 2023 14:14:36 +0800 (CST)
Subject: Re: [PATCH v2 1/2] fscache: Use wait_on_bit() to wait for the freeing
 of relinquished volume
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com
References: <20221226103309.953112-1-houtao@huaweicloud.com>
 <20221226103309.953112-2-houtao@huaweicloud.com>
 <42d0b5da-73e8-59f2-c20b-ba1d6143da14@linux.alibaba.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <f8718e12-bb19-5c50-a825-3ea82399ae7e@huaweicloud.com>
Date:   Thu, 12 Jan 2023 14:14:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <42d0b5da-73e8-59f2-c20b-ba1d6143da14@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgBnDetKpb9jeJouBg--.14037S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45GF4xJr1fWw4kCw4DJwb_yoWrWFWxp3
        9F9a43tF48X342ywsYqr47Z34SgFyktan7Cr4vyFy7AF4xtFn5tF1jk3s8uay7C3yDJrWx
        Za1jq3sxWw1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/12/2023 11:47 AM, Jingbo Xu wrote:
>
> On 12/26/22 6:33 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The freeing of relinquished volume will wake up the pending volume
>> acquisition by using wake_up_bit(), however it is mismatched with
>> wait_var_event() used in fscache_wait_on_volume_collision() and it will
>> never wake up the waiter in the wait-queue because these two functions
>> operate on different wait-queues.
>>
>> According to the implementation in fscache_wait_on_volume_collision(),
>> if the wake-up of pending acquisition is delayed longer than 20 seconds
>> (e.g., due to the delay of on-demand fd closing), the first
>> wait_var_event_timeout() will timeout and the following wait_var_event()
>> will hang forever as shown below:
>>
>>  FS-Cache: Potential volume collision new=00000024 old=00000022
>>  ......
>>  INFO: task mount:1148 blocked for more than 122 seconds.
>>        Not tainted 6.1.0-rc6+ #1
>>  task:mount           state:D stack:0     pid:1148  ppid:1
>>  Call Trace:
>>   <TASK>
>>   __schedule+0x2f6/0xb80
>>   schedule+0x67/0xe0
>>   fscache_wait_on_volume_collision.cold+0x80/0x82
>>   __fscache_acquire_volume+0x40d/0x4e0
>>   erofs_fscache_register_volume+0x51/0xe0 [erofs]
>>   erofs_fscache_register_fs+0x19c/0x240 [erofs]
>>   erofs_fc_fill_super+0x746/0xaf0 [erofs]
>>   vfs_get_super+0x7d/0x100
>>   get_tree_nodev+0x16/0x20
>>   erofs_fc_get_tree+0x20/0x30 [erofs]
>>   vfs_get_tree+0x24/0xb0
>>   path_mount+0x2fa/0xa90
>>   do_mount+0x7c/0xa0
>>   __x64_sys_mount+0x8b/0xe0
>>   do_syscall_64+0x30/0x60
>>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> Considering that wake_up_bit() is more selective, so fixing it by using
> 							^
> 						       fix
>> wait_on_bit() instead of wait_var_event() to wait for the freeing of
>> relinquished volume. In addition because waitqueue_active() is used in
>> wake_up_bit() and clear_bit() doesn't imply any memory barrier, so also
>> adding smp_mb__after_atomic() before wake_up_bit().
> ... doesn't imply any memory barrier, add ...
Thanks for suggestions above. Will update in v3.
>
>> Fixes: 62ab63352350 ("fscache: Implement volume registration")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> Otherwise LGTM :)
>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Thanks for review.
>
>> ---
>>  fs/fscache/volume.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
>> index ab8ceddf9efa..fc3dd3bc851d 100644
>> --- a/fs/fscache/volume.c
>> +++ b/fs/fscache/volume.c
>> @@ -141,13 +141,14 @@ static bool fscache_is_acquire_pending(struct fscache_volume *volume)
>>  static void fscache_wait_on_volume_collision(struct fscache_volume *candidate,
>>  					     unsigned int collidee_debug_id)
>>  {
>> -	wait_var_event_timeout(&candidate->flags,
>> -			       !fscache_is_acquire_pending(candidate), 20 * HZ);
>> +	wait_on_bit_timeout(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
>> +			    TASK_UNINTERRUPTIBLE, 20 * HZ);
>>  	if (fscache_is_acquire_pending(candidate)) {
>>  		pr_notice("Potential volume collision new=%08x old=%08x",
>>  			  candidate->debug_id, collidee_debug_id);
>>  		fscache_stat(&fscache_n_volumes_collision);
>> -		wait_var_event(&candidate->flags, !fscache_is_acquire_pending(candidate));
>> +		wait_on_bit(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
>> +			    TASK_UNINTERRUPTIBLE);
>>  	}
>>  }
>>  
>> @@ -348,6 +349,11 @@ static void fscache_wake_pending_volume(struct fscache_volume *volume,
>>  		if (fscache_volume_same(cursor, volume)) {
>>  			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
>>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
>> +			/*
>> +			 * Paired with barrier in wait_on_bit(). Check
>> +			 * wake_up_bit() and waitqueue_active() for details.
>> +			 */
>> +			smp_mb__after_atomic();
>>  			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
>>  			return;
>>  		}

