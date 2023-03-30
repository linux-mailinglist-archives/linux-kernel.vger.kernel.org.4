Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613A46D0EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjC3Tfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjC3Tfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:35:48 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41526195;
        Thu, 30 Mar 2023 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=6iPlweaVoC3evjbevPt/I1/K/+EOpwnFBna9xVH19Lo=; b=qXd5OCqYPnGow+Oz3mZ9DTkkx7
        XunwCUvSM1QeRCmOaRJkgI1EfhfpQedhoCWpWzOJIvjIxPE2Xn7jZeQgWHQ25ABEm1MZY15NQC9z/
        n9NrKfWBOyBkzjHtEonTOm4Xfs4S8nc4cnI6TgJWOCsNO84Li8WdliBbUmq9qaLY4h8CWx76MJKGf
        Ucz1++n+s7An9SnUQC4yfuvl9XmxII2Azjg5W8H0sVBXFmnoAtYSCUPvb8Z8a6nfhBpru43JuJWa8
        LUY6q0QKps0ZWeuo7S2cu0MIKNVpcvEg5KkmHXhcbNesDPAG/lRkDWMiNQq1WLamvuFVpfSMibExR
        xPCPsHMw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1phy3X-00DjYL-JS; Thu, 30 Mar 2023 13:35:32 -0600
Message-ID: <67b0f0fb-e9f3-b716-f22f-0ca091a291b0@deltatee.com>
Date:   Thu, 30 Mar 2023 13:35:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230330202046.795213-1-yukuai1@huaweicloud.com>
 <20230330202046.795213-4-yukuai1@huaweicloud.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230330202046.795213-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: yukuai1@huaweicloud.com, song@kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 3/3] md: protect md_thread with rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-30 14:20, Yu Kuai wrote:
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
> be similar problem for other md_thread, and I really don't like the idea to
> borrow a global lock.
> 
> This patch protect md_thread with rcu.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9e80c5491c9a..161231e01faa 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -70,11 +70,7 @@
>  #include "md-bitmap.h"
>  #include "md-cluster.h"
>  
> -/* pers_list is a list of registered personalities protected
> - * by pers_lock.
> - * pers_lock does extra service to protect accesses to
> - * mddev->thread when the mutex cannot be held.
> - */
> +/* pers_list is a list of registered personalities protected by pers_lock. */
>  static LIST_HEAD(pers_list);
>  static DEFINE_SPINLOCK(pers_lock);
>  
> @@ -802,13 +798,8 @@ void mddev_unlock(struct mddev *mddev)
>  	} else
>  		mutex_unlock(&mddev->reconfig_mutex);
>  
> -	/* As we've dropped the mutex we need a spinlock to
> -	 * make sure the thread doesn't disappear
> -	 */
> -	spin_lock(&pers_lock);
>  	md_wakeup_thread(&mddev->thread);
>  	wake_up(&mddev->sb_wait);
> -	spin_unlock(&pers_lock);
>  }
>  EXPORT_SYMBOL_GPL(mddev_unlock);
>  
> @@ -7921,13 +7912,16 @@ static int md_thread(void *arg)
>  
>  void md_wakeup_thread(struct md_thread **threadp)
>  {
> -	struct md_thread *thread = *threadp;
> +	struct md_thread *thread;
>  
> +	rcu_read_lock();
> +	thread = rcu_dereference(*threadp);

A couple points:

I don't think we need a double pointer here. rcu_dereference() doesn't
actually do anything but annotate the fact that we are accessing a
pointer protected by rcu. It does require annotations on that pointer
(__rcu) which is checked by sparse (I suspect this patch will produce a
lot of sparse errors from kbuild bot).

I think all we need is:

void md_wakeup_thread(struct md_thread __rcu *rthread)
{
	struct md_thread *thread;
   	
	rcu_read_lock();
	thread = rcu_dereference(rthread);
	...
	rcu_read_unlock();
	
}

The __rcu annotation will have to be added to all the pointers this
function is called on as well as to md_register_thread() and
md_unregister_thread(). And anything else that uses those pointers.
Running sparse on the code and eliminating all new errors for the patch
is important.

Thanks,

Logan
