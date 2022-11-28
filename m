Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9CE63A25B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiK1H4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiK1H4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:56:41 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFD15FDB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 23:56:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VVqxcrL_1669622195;
Received: from 30.221.131.211(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVqxcrL_1669622195)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 15:56:36 +0800
Message-ID: <e1069bfc-be19-df66-dfeb-8a7aac0a9b97@linux.alibaba.com>
Date:   Mon, 28 Nov 2022 15:56:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] fscache: Use wake_up_var() to wake up pending volume
 acquisition
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        houtao1@huawei.com
References: <20221128031929.3918348-1-houtao@huaweicloud.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221128031929.3918348-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for catching this.


On 11/28/22 11:19 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The freeing of relinquished volume will wake up the pending volume
> acquisition by using wake_up_bit(), however it is mismatched with
> wait_var_event() used in fscache_wait_on_volume_collision() and it will
> never wake up the waiter in the wait-queue because these two functions
> operate on different wait-queues.
> 
> According to the implementation in fscache_wait_on_volume_collision(),
> if the wake-up of pending acquisition is delayed longer than 20 seconds
> (e.g., due to the delay of on-demand fd closing), the first
> wait_var_event_timeout() will timeout and the following wait_var_event()
> will hang forever as shown below:
> 
>  FS-Cache: Potential volume collision new=00000024 old=00000022
>  ......
>  INFO: task mount:1148 blocked for more than 122 seconds.
>        Not tainted 6.1.0-rc6+ #1
>  task:mount           state:D stack:0     pid:1148  ppid:1
>  Call Trace:
>   <TASK>
>   __schedule+0x2f6/0xb80
>   schedule+0x67/0xe0
>   fscache_wait_on_volume_collision.cold+0x80/0x82
>   __fscache_acquire_volume+0x40d/0x4e0
>   erofs_fscache_register_volume+0x51/0xe0 [erofs]
>   erofs_fscache_register_fs+0x19c/0x240 [erofs]
>   erofs_fc_fill_super+0x746/0xaf0 [erofs]
>   vfs_get_super+0x7d/0x100
>   get_tree_nodev+0x16/0x20
>   erofs_fc_get_tree+0x20/0x30 [erofs]
>   vfs_get_tree+0x24/0xb0
>   path_mount+0x2fa/0xa90
>   do_mount+0x7c/0xa0
>   __x64_sys_mount+0x8b/0xe0
>   do_syscall_64+0x30/0x60
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Fixing it by using wake_up_var() instead of wake_up_bit(). In addition
> because waitqueue_active() is used in wake_up_var() and clear_bit()
> doesn't imply any memory barrier, so do smp_mb__after_atomic() before
> invoking wake_up_var().
> 
> Fixes: 62ab63352350 ("fscache: Implement volume registration")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-and-tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/fscache/volume.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index ab8ceddf9efa..cf8293bb1aca 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -348,7 +348,12 @@ static void fscache_wake_pending_volume(struct fscache_volume *volume,
>  		if (fscache_volume_same(cursor, volume)) {
>  			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
> -			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
> +			/*
> +			 * Paired with barrier in wait_var_event(). Check
> +			 * waitqueue_active() and wake_up_var() for details.
> +			 */
> +			smp_mb__after_atomic();
> +			wake_up_var(&cursor->flags);
>  			return;
>  		}
>  	}

-- 
Thanks,
Jingbo
