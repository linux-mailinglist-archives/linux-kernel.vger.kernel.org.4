Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159E6A63AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjB1XKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjB1XKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:10:04 -0500
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 15:10:02 PST
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA7DBF8;
        Tue, 28 Feb 2023 15:10:02 -0800 (PST)
Received: from [128.177.82.146] (helo=srivatsab3MD6R.vmware.com)
        by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1pX8zx-0058Ry-Ep;
        Tue, 28 Feb 2023 18:03:05 -0500
Subject: Re: [PATCH 4.19-rt] workqueue: Fix deadlock due to recursive locking
 of pool->lock
To:     "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     blamoreaux@vmware.com, frederic.martinsons@gmail.com,
        vsirnapalli@vmware.com, amakhalov@vmware.com,
        keerthanak@vmware.com, ankitja@vmware.com, bordoloih@vmware.com,
        srivatsab@vmware.com, Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tejun Heo <tj@kernel.org>
References: <20230228224938.88035-1-brennanlamoreaux@gmail.com>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <36f64ecf-89cb-3314-35d6-589569d58133@csail.mit.edu>
Date:   Tue, 28 Feb 2023 15:03:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230228224938.88035-1-brennanlamoreaux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 2:49 PM, Brennan Lamoreaux (VMware) wrote:
> Upstream commit d8bb65ab70f7 ("workqueue: Use rcuwait for wq_manager_wait")
> replaced the waitqueue with rcuwait in the workqueue code. This change
> involved removing the acquisition of pool->lock in put_unbound_pool(),
> as it also adds the function wq_manager_inactive() which acquires this same
> lock and is called one line later as a parameter to rcu_wait_event().
> 
> However, the backport of this commit in the PREEMPT_RT patchset
> 4.19.255-rt114 (patch 347) missed the removal of the acquisition of
> pool->lock in put_unbound_pool(). This leads to a deadlock due to
> recursive locking of pool->lock, as shown below in lockdep:
> 
> [  252.083713] WARNING: possible recursive locking detected
> [  252.083718] 4.19.269-3.ph3-rt #1-photon Not tainted
> [  252.083721] --------------------------------------------
> [  252.083733] kworker/2:0/33 is trying to acquire lock:
> [  252.083747] 000000000b7b1ceb (&pool->lock/1){....}, at:
> put_unbound_pool+0x10d/0x260
> 
> [  252.083857]
>                but task is already holding lock:
> [  252.083860] 000000000b7b1ceb (&pool->lock/1){....}, at:
> put_unbound_pool+0xbd/0x260
> 
> [  252.083876]
>                other info that might help us debug this:
> [  252.083897]  Possible unsafe locking scenario:
> 
> [  252.083900]        CPU0
> [  252.083903]        ----
> [  252.083904]   lock(&pool->lock/1);
> [  252.083911]   lock(&pool->lock/1);
> [  252.083919]
>                 *** DEADLOCK ***
> 
> [  252.083921]  May be due to missing lock nesting notation
> 
> Fix this deadlock by removing the pool->lock acquisition in
> put_unbound_pool().
> 
> Signed-off-by: Brennan Lamoreaux (VMware) <brennanlamoreaux@gmail.com>
> Cc: Daniel Wagner <wagi@monom.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Tejun Heo <tj@kernel.org>

Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

> ---
>  kernel/workqueue.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index a9f3cc02bdc1..55ebdd56a5de 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3394,7 +3394,6 @@ static void put_unbound_pool(struct worker_pool *pool)
>  	 * Because of how wq_manager_inactive() works, we will hold the
>  	 * spinlock after a successful wait.
>  	 */
> -	raw_spin_lock_irq(&pool->lock);
>  	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
>  			   TASK_UNINTERRUPTIBLE);
>  	pool->flags |= POOL_MANAGER_ACTIVE;
> 

 
Regards,
Srivatsa
VMware Photon OS
