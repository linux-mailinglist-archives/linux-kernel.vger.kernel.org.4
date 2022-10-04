Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89A35F470F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJDQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJDQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D16053A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664899279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xM+zyAOnxDRj+m9eSoILBxLQtaLNaq//fM/4R+jhI8M=;
        b=C3PO2l2d4SlXvpLkCLCvwKpX6tEAiVkY+SbSWX0/OKF2+7vK2ZnwTphbmoXnbJ4t67GQTc
        I+KnowwZPeNqSD4vSyMPTD+pbWWiknqUG71l/fMfTNXW5dojkNGVkl7Kc8NishRJcy+5PB
        ps+Gk2pkFesr71W/nE/5deOCkBpU3Fc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-r4qG9XG0MBiXZ3Jn18jrww-1; Tue, 04 Oct 2022 12:01:15 -0400
X-MC-Unique: r4qG9XG0MBiXZ3Jn18jrww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18F79299E76E;
        Tue,  4 Oct 2022 16:01:15 +0000 (UTC)
Received: from [10.22.10.217] (unknown [10.22.10.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33BD12166B26;
        Tue,  4 Oct 2022 16:01:14 +0000 (UTC)
Message-ID: <73859883-78c4-1080-7846-e8d644ad397a@redhat.com>
Date:   Tue, 4 Oct 2022 12:01:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 01/11] locking/ww_mutex: Remove wakeups from under
 mutex::wait_lock
Content-Language: en-US
To:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-2-connoro@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221003214501.2050087-2-connoro@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 17:44, Connor O'Brien wrote:
> diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> index 56f139201f24..dfc174cd96c6 100644
> --- a/kernel/locking/ww_mutex.h
> +++ b/kernel/locking/ww_mutex.h
> @@ -161,6 +161,11 @@ static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
>   
>   #endif /* WW_RT */
>   
> +void ww_ctx_wake(struct ww_acquire_ctx *ww_ctx)
> +{
> +	wake_up_q(&ww_ctx->wake_q);
> +}
> +
>   /*
>    * Wait-Die:
>    *   The newer transactions are killed when:
> @@ -284,7 +289,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
>   #ifndef WW_RT
>   		debug_mutex_wake_waiter(lock, waiter);
>   #endif
> -		wake_up_process(waiter->task);
> +		wake_q_add(&ww_ctx->wake_q, waiter->task);
>   	}
>   
>   	return true;
> @@ -331,7 +336,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
>   		 * wakeup pending to re-read the wounded state.
>   		 */
>   		if (owner != current)
> -			wake_up_process(owner);
> +			wake_q_add(&ww_ctx->wake_q, owner);
>   
>   		return true;
>   	}
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ee28253c9ac0..617e737392be 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1013,6 +1013,13 @@ void wake_up_q(struct wake_q_head *head)
>   		wake_up_process(task);
>   		put_task_struct(task);
>   	}
> +	/*
> +	 * XXX connoro: seems this is needed now that ww_ctx_wake() passes in a
> +	 * wake_q_head that is embedded in struct ww_acquire_ctx rather than
> +	 * declared locally.
> +	 */
> +	head->first = node;
> +	head->lastp = &head->first;
>   }
>   

You shouldn't do wake_q_init() here in wake_up_q(). Instead, you should 
do it in ww_ctx_wake() right after the wake_up_q() call.

Cheers,
Longman

