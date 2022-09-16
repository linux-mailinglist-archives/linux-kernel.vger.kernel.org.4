Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146575BB45B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIPWTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIPWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:19:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB3B82
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:19:16 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h21so17026202qta.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Tk2u/s6sRgGMLRQAuOfvmpgu8lIuCMGaWAOQeLrHHow=;
        b=x4KMUEi6euKbbOxz6uCp1po4atzgq6f4FL19t3Ws9Rz0RTmp/miH0rR/a6JkB6zy3q
         yi3rkYe0L3TIrTtelNNC7EodjyWHVj96GurimecJ1iVWzxAp9WNNsfeXi/UzjvTVE/t3
         phEp71U25z8Q5xxrOpCjT6SG8v4ljp0l5GqS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Tk2u/s6sRgGMLRQAuOfvmpgu8lIuCMGaWAOQeLrHHow=;
        b=t6gfDDiXyKYyq6GcNlLjILlG1SW5n/NuSGdhVFvJKk216nhMQAY0IIfu6wDPYXZi2V
         4GRM4OATunViSck9pg9AfT24AsJlE0FvgTUzH7ovxuC4UAlmPH5ZZXfCukVsNyw6oekh
         dBEr814OPp5DV6aI3FGUUxQN40tFHWze8+SWRHROjwQ9P3h6dXv1+FtikM5hy0S/4vlI
         VtJO0dxakdYtiFOHwycmIT8qcEHusmvVjXKeMYw1ck0ZhnU5rxkFvNjyOdS5yohOcqw8
         wKUfTuCVulEIT8vnPmeGddnunZClbxcE6DkWJliRrT34E27Dxv4dLszxQXmFjDl//cDH
         mhwA==
X-Gm-Message-State: ACrzQf02fDD/QlZUMv7+6Nx1VMoLnaBWgT0NalXi/DExCdua1suyTJsZ
        ny+78Uo8/xoecBij7goilhS63A==
X-Google-Smtp-Source: AMsMyM4y1JSt8DsHb8nebf4zfOPOL4Sme1sk/bUYjUzyfHwO/aGIhP6Akg3gNi4n2EqKvgGZCjKWug==
X-Received: by 2002:ac8:5bd5:0:b0:35c:b058:92ec with SMTP id b21-20020ac85bd5000000b0035cb05892ecmr6453244qtb.83.1663366755199;
        Fri, 16 Sep 2022 15:19:15 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006bbe7ded98csm7132509qki.112.2022.09.16.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:19:14 -0700 (PDT)
Date:   Fri, 16 Sep 2022 22:19:14 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/next 2/3] rcu: Move trace_rcu_callback() before
 bypassing
Message-ID: <YyT2YlI9HK/Z2GPT@google.com>
References: <20220915001419.55617-1-joel@joelfernandes.org>
 <20220915001419.55617-3-joel@joelfernandes.org>
 <20220916110949.GB25456@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916110949.GB25456@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/2022 7:09 AM, Frederic Weisbecker wrote:
> On Thu, Sep 15, 2022 at 12:14:18AM +0000, Joel Fernandes (Google) wrote:
>> If any CB is queued into the bypass list, then trace_rcu_callback() does
>> not show it. This makes it not clear when a callback was actually
>> queued, as you only end up getting a trace_rcu_invoke_callback() trace.
>> Fix it by moving trace_rcu_callback() before
>> trace_rcu_nocb_try_bypass().
>>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  kernel/rcu/tree.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 5ec97e3f7468..9fe581be8696 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2809,10 +2809,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t
>> func)
>>  	}
>>  
>>  	check_cb_ovld(rdp);
>> -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
>> -		return; // Enqueued onto ->nocb_bypass, so just leave.
>> -	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired
>> ->nocb_lock.
>> -	rcu_segcblist_enqueue(&rdp->cblist, head);
>> +
>>  	if (__is_kvfree_rcu_offset((unsigned long)func))
>>  		trace_rcu_kvfree_callback(rcu_state.name, head,
>>  					 (unsigned long)func,
>> @@ -2821,6 +2818,11 @@ void call_rcu(struct rcu_head *head, rcu_callback_t
>> func)
>>  		trace_rcu_callback(rcu_state.name, head,
>>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>>  
>> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
>> +		return; // Enqueued onto ->nocb_bypass, so just leave.
>> +	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired
>> ->nocb_lock.
>> +	rcu_segcblist_enqueue(&rdp->cblist, head);
>> +
>>  	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
>>  
>>  	/* Go handle any RCU core processing required. */
>
> Two subtle changes induced here:
>
> * rcu_segcblist_n_cbs() is now read lockless. It's just tracing so no huge
> deal
>   but still, if this races with callbacks invocation, we may on some rare
>   occasion
>   read stale numbers on traces while enqueuing (think about rcu_top for
>   example)

Actually I disagree with this point now. Changes to the number of callbacks
in the main ->cblist can be lockless. It uses atomic on CONFIG_RCU_NOCB. On
non CONFIG_RCU_NOCB, CB cannot be queued as interrupts will be disabled.

Also, in rcu_do_batch(), the count is manipulated after calling
rcu_nocb_lock_irqsave(rdp, flags);

> * trace_rcu_callback() will now show the number of callbacks _before_
> enqueuing
>   instead of _after_. Not sure if it matters, but sometimes tools rely on
>   trace
>   events.

Yeah this is fixable and good point. So how about the below?

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] rcu: Call trace_rcu_callback() also for bypass queuing

If any CB is queued into the bypass list, then trace_rcu_callback() does
not show it. This makes it not clear when a callback was actually
queued, as you only end up getting a trace_rcu_invoke_callback() trace.
Fix it by calling the tracing function even for bypass queue.

Also, while at it, optimize the tracing so that rcu_state is not
accessed here if tracing is disabled, because that's useless if we are
not tracing. A quick inspection of the generated assembler shows that
rcu_state is accessed even if the jump label for the tracepoint is
disabled.

__trace_rcu_callback:
        movq    8(%rdi), %rcx
        movq    rcu_state+3640(%rip), %rax
        movq    %rdi, %rdx
        cmpq    $4095, %rcx
        ja      .L3100
        movq    192(%rsi), %r8
        1:jmp .L3101 # objtool NOPs this
        .pushsection __jump_table,  "aw"
         .balign 8
        .long 1b - .
        .long .L3101 - .
         .quad __tracepoint_rcu_kvfree_callback+8 + 2 - .
        .popsection

With this change, the jump label check which is NOOPed is moved to the
beginning of the function.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..b64df55f7f55 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2728,6 +2728,23 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
+/*
+ * Trace RCU callback helper, call after enqueuing callback.
+ * The ->cblist must be locked when called.
+ */
+void __trace_rcu_callback(struct rcu_head *head,
+				      struct rcu_data *rdp)
+{
+	if (trace_rcu_kvfree_callback_enabled() &&
+	    __is_kvfree_rcu_offset((unsigned long)head->func))
+		trace_rcu_kvfree_callback(rcu_state.name, head,
+					 (unsigned long)head->func,
+					 rcu_segcblist_n_cbs(&rdp->cblist));
+	else if (trace_rcu_callback_enabled())
+		trace_rcu_callback(rcu_state.name, head,
+				   rcu_segcblist_n_cbs(&rdp->cblist));
+}
+
 /**
  * call_rcu() - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -2809,17 +2826,15 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
+		__trace_rcu_callback(head, rdp);
 		return; // Enqueued onto ->nocb_bypass, so just leave.
+	}
+
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kvfree_rcu_offset((unsigned long)func))
-		trace_rcu_kvfree_callback(rcu_state.name, head,
-					 (unsigned long)func,
-					 rcu_segcblist_n_cbs(&rdp->cblist));
-	else
-		trace_rcu_callback(rcu_state.name, head,
-				   rcu_segcblist_n_cbs(&rdp->cblist));
+	__trace_rcu_callback(head, rdp);
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
-- 
2.37.3.968.ga6b4b080e4-goog

