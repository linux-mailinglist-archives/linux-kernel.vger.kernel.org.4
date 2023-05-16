Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A765704D72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjEPMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjEPMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:09:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437EB2117
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D41A762588
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3876AC433EF;
        Tue, 16 May 2023 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684238949;
        bh=UH9AdtyU/O26/6N2tKr+tlfOYfrwoBgP4YOkOTJhbtw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RBplGKlViNGRuwycg1n9dPM/M9AbLUuR703dyFvd1L+gkOzsEOjQ6sOjb2JVaV95d
         e1VowH9THSo5pzZXc5xZpCGTJEkOe3aBOPJm4yr48FPsZgTk5BHIyJQBpmuqSmD1Bs
         WmagHBdCwh7+yO7eH7II00GyMzEodxjMB5SxNcXAgI1OiIDtAaGuR01KiWz91oyBS3
         3nEa22jlZEhwZOR9kKdcB36OveBinERkn6kj1RcPerKjc6UqlG+qARRNjBS8ABom+3
         G0AtaP3mRy+ApAObbIHQDDY0+IfX3HzXMNtK/WDpmFWEIi91JyEdonfp3GmsLa/wBT
         3i503cfQBFboQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF21FCE1432; Tue, 16 May 2023 05:09:08 -0700 (PDT)
Date:   Tue, 16 May 2023 05:09:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] smp: Reduce NMI traffic from CSD waiters to
 CSD destination.
Message-ID: <c0ca0c9f-a93b-4159-a7cc-b73eeac3fdc2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230508223124.1438167-1-imran.f.khan@oracle.com>
 <20230508223124.1438167-3-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508223124.1438167-3-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:31:24AM +1000, Imran Khan wrote:
> On systems with hundreds of CPUs, if few hundred or most of the CPUs
> detect a CSD hang, then all of these waiters endup sending an NMI to
> destination CPU to dump its backtrace.
> Depending on the number of such NMIs, destination CPU can spent
> a significant amount of time handling these NMIs and thus making
> it more difficult for this CPU to address those pending CSDs timely.
> In worst case it can happen that by the time destination CPU is done
> handling all of the above mentioned backtrace NMIs, csd wait time
> may have elapsed and all of the waiters start sending backtrace NMI
> again and this behaviour continues in loop.
> 
> To avoid the above mentioned scenario, issue backtrace NMI only from
> first waiter. The other waiters to same CSD destination can make use
> of backtrace obtained via fist waiter's NMI.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/smp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index b7ccba677a0a0..a1cd21ea8b308 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -43,6 +43,8 @@ static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
>  
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
>  
> +static DEFINE_PER_CPU(atomic_t, trigger_backtrace) = ATOMIC_INIT(1);
> +
>  static void __flush_smp_call_function_queue(bool warn_cpu_offline);
>  
>  int smpcfd_prepare_cpu(unsigned int cpu)
> @@ -242,7 +244,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
>  	}
>  	if (cpu >= 0) {
> -		dump_cpu_task(cpu);
> +		if (atomic_cmpxchg_acquire(&per_cpu(trigger_backtrace, cpu), 1, 0))
> +			dump_cpu_task(cpu);
>  		if (!cpu_cur_csd) {
>  			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
>  			arch_send_call_function_single_ipi(cpu);
> @@ -423,9 +426,14 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
>  	struct llist_node *entry, *prev;
>  	struct llist_head *head;
>  	static bool warned;
> +	atomic_t *tbt;
>  
>  	lockdep_assert_irqs_disabled();
>  
> +	/* Allow waiters to send backtrace NMI from here onwards */
> +	tbt = this_cpu_ptr(&trigger_backtrace);
> +	atomic_set_release(tbt, 1);
> +
>  	head = this_cpu_ptr(&call_single_queue);
>  	entry = llist_del_all(head);
>  	entry = llist_reverse_order(entry);
> -- 
> 2.34.1
> 
