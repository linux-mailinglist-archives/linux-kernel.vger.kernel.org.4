Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A86373B703
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjFWMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:21:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29EE01BE4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:21:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94B51042;
        Fri, 23 Jun 2023 05:22:06 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 760B33F59C;
        Fri, 23 Jun 2023 05:21:19 -0700 (PDT)
Message-ID: <509d5ee4-45ec-1279-97da-a308ec7f51aa@arm.com>
Date:   Fri, 23 Jun 2023 14:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/13] locking/ww_mutex: Remove wakeups from under
 mutex::wait_lock
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Connor O'Brien <connoro@google.com>
References: <20230601055846.2349566-1-jstultz@google.com>
 <20230601055846.2349566-3-jstultz@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230601055846.2349566-3-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 01/06/2023 07:58, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> In preparation to nest mutex::wait_lock under rq::lock we need to remove
> wakeups from under it.

[...]

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v2:
> * Move wake_q_init() as suggested by Waiman Long
> ---
>  include/linux/ww_mutex.h  |  3 +++
>  kernel/locking/mutex.c    |  8 ++++++++
>  kernel/locking/ww_mutex.h | 10 ++++++++--
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index bb763085479a..9335b2202017 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -19,6 +19,7 @@
>  
>  #include <linux/mutex.h>
>  #include <linux/rtmutex.h>
> +#include <linux/sched/wake_q.h>
>  
>  #if defined(CONFIG_DEBUG_MUTEXES) || \
>     (defined(CONFIG_PREEMPT_RT) && defined(CONFIG_DEBUG_RT_MUTEXES))
> @@ -58,6 +59,7 @@ struct ww_acquire_ctx {
>  	unsigned int acquired;
>  	unsigned short wounded;
>  	unsigned short is_wait_die;
> +	struct wake_q_head wake_q;

you told me that there is already an issue in this patch even w/o PE
when running `insmod /lib/modules/test-ww_mutex.ko`.

The issue is related to Connor's version (1):

https://lkml.kernel.org/r/20221003214501.2050087-2-connoro@google.com

  struct ww_acquire_ctx {

	  struct wake_q_head wake_q;


  __mutex_lock_common()

    if (ww_ctx)
        ww_ctx_wake(ww_ctx)

          wake_up_q(&ww_ctx->wake_q);
          wake_q_init(&ww_ctx->wake_q);


Juri's version (2):

https://lkml.kernel.org/r/20181009092434.26221-3-juri.lelli@redhat.com

  __mutex_lock_common()

      DEFINE_WAKE_Q(wake_q) <-- !!!

      __ww_mutex_check_waiters(..., wake_q)

        __ww_mutex_die(..., wake_q)

          wake_q_add(wake_q, waiter->task)

      wake_up_q(&wake_q)


`insmod /lib/modules/test-ww_mutex.ko` runs fine with (2) but not with
(1) (both w/o the remaining PE patches).

So to test the PE issues we talked about already which come with `[PATCH
v4 09/13] sched: Add proxy execution` and CONFIG_PROXY_EXEC=y we need to
fix (1) or go back to (2).

I haven't found any clues why (2) was changed to (1) so far.

[...]
