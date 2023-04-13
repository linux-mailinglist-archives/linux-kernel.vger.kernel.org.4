Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCC56E10AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjDMPLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDMPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:11:14 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B02210DF;
        Thu, 13 Apr 2023 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=UYgY+Jc5tV+vuRR3xCQtdYSUVhJdL1c0C1D9hQyQ6oA=; b=fVq1Zr0KPw6l5hQ7aPS0u5EKaP
        uLzu13KNBK5cCj4yldrOwlmYpZ/8CKIKkiFB38/2E0DFvR7sIA5R2IEa6QXSuRV3ULEHyJL/8X/yV
        W3a/L6USOqP90Nt6Zz6u+bmTyhskRTOq+3H4cp0wnS4RnXm6XBi+jbHKadt1A10BWxErVPAXORqBu
        w36cbfdeJnmqD1Rb9640OCSxWYJfNhu8Z3pziZdJR7ozrfeYWvL52WJw888lBH6pyHwyVU/T2F5EY
        /yfG/ozqF3OjQmCDkrgssSmmRgR8JuZBrCtAabSeF9hQ+P/FfSWbxRfmSxchgvbaFSStOvvjMYgSh
        s9CjMkTA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pmyb1-007m0l-TO; Thu, 13 Apr 2023 09:10:48 -0600
Message-ID: <961691d0-7224-caad-6c19-d9c8ca07a801@deltatee.com>
Date:   Thu, 13 Apr 2023 09:10:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230413113217.1934353-1-yukuai1@huaweicloud.com>
 <20230413113217.1934353-6-yukuai1@huaweicloud.com>
Content-Language: en-CA
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230413113217.1934353-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: yukuai1@huaweicloud.com, dm-devel@redhat.com, song@kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH -next v6 5/5] md: protect md_thread with rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-13 05:32, Yu Kuai wrote:
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
> 'mddev->thread', this problem can be fixed likewise, however, there are
> similar problems elsewhere, and use a global lock for all the cases is
> not good.
> 
> This patch protect all md_thread with rcu.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-bitmap.c    | 10 ++++--
>  drivers/md/md-cluster.c   |  7 ++--
>  drivers/md/md-multipath.c |  4 +--
>  drivers/md/md.c           | 69 ++++++++++++++++++---------------------
>  drivers/md/md.h           |  8 ++---
>  drivers/md/raid1.c        |  7 ++--
>  drivers/md/raid1.h        |  2 +-
>  drivers/md/raid10.c       | 21 +++++++-----
>  drivers/md/raid10.h       |  2 +-
>  drivers/md/raid5-cache.c  | 22 ++++++++-----
>  drivers/md/raid5.c        | 15 +++++----
>  drivers/md/raid5.h        |  2 +-
>  12 files changed, 91 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 29fd41ef55a6..ab27f66dbb1f 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1221,13 +1221,19 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
>  static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
>  			      bool force)
>  {
> -	struct md_thread *thread = mddev->thread;
> +	struct md_thread *thread;
> +
> +	rcu_read_lock();
> +	thread = rcu_dereference(mddev->thread);
>  
>  	if (!thread)
> -		return;
> +		goto out;
>  
>  	if (force || thread->timeout < MAX_SCHEDULE_TIMEOUT)
>  		thread->timeout = timeout;
> +
> +out:
> +	rcu_read_unlock();
>  }
>  
>  /*
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 10e0c5381d01..672dfa6a40ec 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -362,8 +362,8 @@ static void __recover_slot(struct mddev *mddev, int slot)
>  
>  	set_bit(slot, &cinfo->recovery_map);
>  	if (!cinfo->recovery_thread) {
> -		cinfo->recovery_thread = md_register_thread(recover_bitmaps,
> -				mddev, "recover");
> +		rcu_assign_pointer(cinfo->recovery_thread,
> +			md_register_thread(recover_bitmaps, mddev, "recover"));
>  		if (!cinfo->recovery_thread) {
>  			pr_warn("md-cluster: Could not create recovery thread\n");
>  			return;
> @@ -889,7 +889,8 @@ static int join(struct mddev *mddev, int nodes)
>  	}
>  	/* Initiate the communication resources */
>  	ret = -ENOMEM;
> -	cinfo->recv_thread = md_register_thread(recv_daemon, mddev, "cluster_recv");
> +	rcu_assign_pointer(cinfo->recv_thread,
> +			md_register_thread(recv_daemon, mddev, "cluster_recv"));
>  	if (!cinfo->recv_thread) {

This looks like it'll hit sparse warnings. without an
rcu_access_pointer(). Might be nicer to use a temporary variable, check
that it's not null, then call rcu_assign_pointer().
