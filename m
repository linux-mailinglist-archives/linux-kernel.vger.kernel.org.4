Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE10639F09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 02:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiK1Boc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 20:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK1Bob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 20:44:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DED63AE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 17:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669599814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE8kAFeoA7biKR8q9fjAYev92yn5jNTMW1oUFKBFLTE=;
        b=JZ8vOWLwinzhkaRasyfHpNQImEh/CC2b1UjupdovWPPD5B/0EGO/vrz8gNB1u2pBSjoHOK
        VtsuPRtiRNoJ+KUfWCs7GPQqewNCjRv42EbSvNKepLpqPjHkUOCWi0bz/XKBG+Xd4bW7hJ
        UxjXqLZ1zwMiWknewpngUhDZPa+pQ3c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-pEJ7eoB5MmmxCsCn4SN_og-1; Sun, 27 Nov 2022 20:43:31 -0500
X-MC-Unique: pEJ7eoB5MmmxCsCn4SN_og-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7881B29AA3B6;
        Mon, 28 Nov 2022 01:43:30 +0000 (UTC)
Received: from [10.22.32.57] (unknown [10.22.32.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD6E3492B05;
        Mon, 28 Nov 2022 01:43:29 +0000 (UTC)
Message-ID: <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
Date:   Sun, 27 Nov 2022 20:43:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-tip v4] sched: Fix NULL user_cpus_ptr check in
 dup_user_cpus_ptr()
Content-Language: en-US
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        =?UTF-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>,
        linux-kernel@vger.kernel.org
References: <20221125023943.1118603-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221125023943.1118603-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 21:39, Waiman Long wrote:
> In general, a non-null user_cpus_ptr will remain set until the task dies.
> A possible exception to this is the fact that do_set_cpus_allowed()
> will clear a non-null user_cpus_ptr. To allow this possible racing
> condition, we need to check for NULL user_cpus_ptr under the pi_lock
> before duping the user mask.
>
> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> Signed-off-by: Waiman Long <longman@redhat.com>

This is actually a pre-existing use-after-free bug since commit 
07ec77a1d4e8 ("sched: Allow task CPU affinity to be restricted on 
asymmetric systems"). So it needs to be fixed in the stable release as 
well. Will resend the patch with an additional fixes tag and updated 
commit log.

Cheers,
Longman

> ---
>   kernel/sched/core.c | 32 ++++++++++++++++++++++++++++----
>   1 file changed, 28 insertions(+), 4 deletions(-)
>
>   [v4] Minor comment update
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8df51b08bb38..f2b75faaf71a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2624,19 +2624,43 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>   int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>   		      int node)
>   {
> +	cpumask_t *user_mask;
>   	unsigned long flags;
>   
> +	/*
> +	 * Always clear dst->user_cpus_ptr first as their user_cpus_ptr's
> +	 * may differ by now due to racing.
> +	 */
> +	dst->user_cpus_ptr = NULL;
> +
> +	/*
> +	 * This check is racy and losing the race is a valid situation.
> +	 * It is not worth the extra overhead of taking the pi_lock on
> +	 * every fork/clone.
> +	 */
>   	if (!src->user_cpus_ptr)
>   		return 0;
>   
> -	dst->user_cpus_ptr = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
> -	if (!dst->user_cpus_ptr)
> +	user_mask = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
> +	if (!user_mask)
>   		return -ENOMEM;
>   
> -	/* Use pi_lock to protect content of user_cpus_ptr */
> +	/*
> +	 * Use pi_lock to protect content of user_cpus_ptr
> +	 *
> +	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
> +	 * do_set_cpus_allowed().
> +	 */
>   	raw_spin_lock_irqsave(&src->pi_lock, flags);
> -	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> +	if (src->user_cpus_ptr) {
> +		swap(dst->user_cpus_ptr, user_mask);
> +		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> +	}
>   	raw_spin_unlock_irqrestore(&src->pi_lock, flags);
> +
> +	if (unlikely(user_mask))
> +		kfree(user_mask);
> +
>   	return 0;
>   }
>   

