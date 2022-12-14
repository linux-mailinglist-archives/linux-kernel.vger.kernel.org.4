Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E07964D15E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiLNUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiLNUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:39:00 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9211B2C666;
        Wed, 14 Dec 2022 12:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671050211;
        bh=42hiEfvX2Y36168DMLrfaAMe71ofZ7gUQkp33pRi+lY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o2EjVNY7nsJ2a6wA2qmvdQRpxLsQ3h3jjjFWa1jY1I/VifxgdiREjb10wHk0PPJEz
         6x/ZQBS/2onS+hEP3AZzG36l9IsqCGHQaAWt1qe0RWha4Tdmo4gOsiB+hVF+b4Ibyk
         yHXZ42dJS8Hb0wMmOPDLQeQ5ZjYsAKTpAlHONptZ5lPIdhZU81126k7kwUbKaza3xj
         RDprLbdJ9yq61dAJPVyEJ05pV1GURo63igXEPK9pz5xJX+R//8wcjPbEmlWUd/LAVE
         kMPT2U2PKnLzwRUmrMxzB0GGkxJi1QVHHurX6SWNzisjmboAq/XVzllY0/aMdv9z3s
         UPro3UK6ynGRA==
Received: from [172.16.0.118] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NXRwy6NYXzbdh;
        Wed, 14 Dec 2022 15:36:50 -0500 (EST)
Message-ID: <f36375fb-fdd2-4be6-3d74-5137533b6264@efficios.com>
Date:   Wed, 14 Dec 2022 15:37:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Content-Language: en-US
To:     paulmck@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221213172429.7774f4ba@gandalf.local.home>
 <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
 <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-14 15:03, Paul E. McKenney wrote:
> On Wed, Dec 14, 2022 at 08:49:54AM +0900, Masami Hiramatsu wrote:
>> On Tue, 13 Dec 2022 17:24:29 -0500
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> If a trigger filter on the kernel command line fails to apply (due to
>>> syntax error), it will be freed. The freeing will call
>>> tracepoint_synchronize_unregister(), but this is not needed during early
>>> boot up, and will even trigger a lockdep splat.
>>>
>>> Avoid calling the synchronization function when system_state is
>>> SYSTEM_BOOTING.
>>
>> Shouldn't this be done inside tracepoint_synchronize_unregister()?
>> Then, it will prevent similar warnings if we expand boot time feature.
> 
> How about the following wide-spectrum fix within RCU_LOCKDEP_WARN()?
> Just in case there are ever additional issues of this sort?

Hi Paul,

Your approach makes sense. Thanks for looking into this.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit d493ffca2df6c1963bd1d7b8f8c652a172f095ae
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Dec 14 11:41:44 2022 -0800
> 
>      rcu: Make RCU_LOCKDEP_WARN() avoid early lockdep checks
>      
>      Currently, RCU_LOCKDEP_WARN() checks the condition before checking
>      to see if lockdep is still enabled.  This is necessary to avoid the
>      false-positive splats fixed by commit 3066820034b5dd ("rcu: Reject
>      RCU_LOCKDEP_WARN() false positives").  However, the current state can
>      result in false-positive splats during early boot before lockdep is fully
>      initialized.  This commit therefore checks debug_lockdep_rcu_enabled()
>      both before and after checking the condition, thus avoiding both sets
>      of false-positive error reports.
>      
>      Reported-by: Steven Rostedt <rostedt@goodmis.org>
>      Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>      Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>      Cc: Boqun Feng <boqun.feng@gmail.com>
>      Cc: Matthew Wilcox <willy@infradead.org>
>      Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index aa1b1c3546d7a..1aec1d53b0c91 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -364,11 +364,18 @@ static inline int debug_lockdep_rcu_enabled(void)
>    * RCU_LOCKDEP_WARN - emit lockdep splat if specified condition is met
>    * @c: condition to check
>    * @s: informative message
> + *
> + * This checks debug_lockdep_rcu_enabled() before checking (c) to
> + * prevent early boot splats due to lockdep not yet being initialized,
> + * and rechecks it after checking (c) to prevent false-positive splats
> + * due to races with lockdep being disabled.  See commit 3066820034b5dd
> + * ("rcu: Reject RCU_LOCKDEP_WARN() false positives") for more detail.
>    */
>   #define RCU_LOCKDEP_WARN(c, s)						\
>   	do {								\
>   		static bool __section(".data.unlikely") __warned;	\
> -		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
> +		if (debug_lockdep_rcu_enabled() && (c) &&		\
> +		    debug_lockdep_rcu_enabled() && !__warned) {		\
>   			__warned = true;				\
>   			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
>   		}							\

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

