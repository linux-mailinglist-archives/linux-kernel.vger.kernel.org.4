Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2D6DC8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDJPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDJPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:42:52 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C194530EC;
        Mon, 10 Apr 2023 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=M+aCu+o9Pqbd/tZgLt2oYz5Sd1Uzxz4vi6MKq1okd2M=; b=ELWGXPwrWU2cKKGgASTQWcPHfR
        JOLXob38jcqh1LYyxJB3nNWCfVNW96ZljJZ8THDc3GIg/L7LSPyBeF3BS6CfUlAduhoD92O+5nDF1
        dVzVnZX8Ttvnrdeu+umJFt0E1uRyMbfgJLRtXe8HReZVkQcQ/Q4ELyr4v3Kp7/kIdOZZ0vYMprZkf
        j60dsQ8dDMxOc4Jw130KHUHaaWgvATNs8oGVGJBIrDqzwaanqUvGWnP4YXM4ZYfsUgPWySHPmTfAf
        lT0d0D3uVQuxjB47r4s1u+1AAdYjvpegfNE4BIMsAWeOgPG0yL6AkxL/Hj8L+HEmZFYnIEnFss8aQ
        kDkXEXmg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pltfB-005K4M-6h; Mon, 10 Apr 2023 09:42:38 -0600
Message-ID: <87c0efd2-c8b0-c6ab-764c-958883fe1d15@deltatee.com>
Date:   Mon, 10 Apr 2023 09:42:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
 <20230410113559.1610455-7-yukuai1@huaweicloud.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230410113559.1610455-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yukuai1@huaweicloud.com, song@kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH -next v5 6/6] md: protect md_thread with rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-10 05:35, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our test reports a uaf for 'mddev->sync_thread':
> 
> T1                      T2
> md_start_sync
>  md_register_thread
>  // mddev->sync_thread is set
> 			raid1d
> 			 md_check_recovery
> 			  md_reap_sync_thread
> 			   md_unregister_thread
> 			    kfree
> 
>  md_wakeup_thread
>   wake_up
>   ->sync_thread was freed
> 
> Root cause is that there is a small windown between register thread and
> wake up thread, where the thread can be freed concurrently.
> 
> Currently, a global spinlock 'pers_lock' is borrowed to protect
> 'mddev->thread', this problem can be fixed likewise, however, there might
> be similar problem elsewhere, and use a global lock for all the cases is
> not good.
> 
> This patch protect md_thread with rcu.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-bitmap.c   | 29 ++++++++++++-----
>  drivers/md/md.c          | 68 +++++++++++++++++++---------------------
>  drivers/md/md.h          | 10 +++---
>  drivers/md/raid1.c       |  4 +--
>  drivers/md/raid1.h       |  2 +-
>  drivers/md/raid10.c      | 10 ++++--
>  drivers/md/raid10.h      |  2 +-
>  drivers/md/raid5-cache.c | 15 +++++----
>  drivers/md/raid5.c       |  4 +--
>  drivers/md/raid5.h       |  2 +-
>  10 files changed, 81 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 29fd41ef55a6..b9baeea5605e 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1219,15 +1219,27 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
>  					       int create);
>  
>  static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
> -			      bool force)
> +			      bool force, bool protected)
>  {
> -	struct md_thread *thread = mddev->thread;
> +	struct md_thread *thread;
> +
> +	if (!protected) {
> +		rcu_read_lock();
> +		thread = rcu_dereference(mddev->thread);
> +	} else {
> +		thread = rcu_dereference_protected(mddev->thread,
> +				lockdep_is_held(&mddev->reconfig_mutex));
> +	}

Why not just always use rcu_read_lock()? Even if it's safe with
reconfig_mutex, it wouldn't harm much and would make the code a bit less
ugly.


> @@ -458,8 +454,10 @@ static void md_submit_bio(struct bio *bio)
>   */
>  void mddev_suspend(struct mddev *mddev)
>  {
> -	WARN_ON_ONCE(mddev->thread && current == mddev->thread->tsk);
> -	lockdep_assert_held(&mddev->reconfig_mutex);
> +	struct md_thread *thread = rcu_dereference_protected(mddev->thread,
> +			lockdep_is_held(&mddev->reconfig_mutex));

Do we know that reconfig_mutex is always held when we call
md_unregister_thread()? Seems plausible, but maybe it's worth adding a
lockdep_assert_held() to md_unregsiter_thread().

Thanks,

Logan
