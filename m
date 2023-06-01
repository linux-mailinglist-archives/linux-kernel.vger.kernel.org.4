Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA271EEA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjFAQVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjFAQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:21:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94464137
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC66C6114E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F37BC433D2;
        Thu,  1 Jun 2023 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685636461;
        bh=5bjcADpccbmZ62QA2CPcr2CQsIlOFFWbag5E1XqJJYs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CtcXYpwXrMGjpIxJ+jC0yiVkKqBU3/R9HElsMN7titQsuUXZEp08QaKeJue9BRvaK
         xkb8zKragDuT6zmyvo7Ss2sv1+hdirI2smeYGVz0xQ9qd9pp/ugZzO3TDiFMUYMEaS
         dV+pwXXjIU3IH5BcLBqU6xV3ot4wz2Bm8gHZIYh9Er6oT58Iqqbbn/4W0ccc44pchA
         BUV8K3SRq5uBQgS38DtTmbcg83/7Y2mAb2oJEtJwGJOp9eQPFQxUSoZWjH63CDpVKj
         sSRcbxiNsafn8ZUnuV29hBKlikfrWMCC4B/7kRz16CwbHOCCDJHf2zfGZRuLZEt5mw
         IMnyelnKI1F8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AA7B4CE04B0; Thu,  1 Jun 2023 09:21:00 -0700 (PDT)
Date:   Thu, 1 Jun 2023 09:21:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [RESEND PATCH 2/2] smp: Reduce NMI traffic from CSD waiters to
 CSD destination.
Message-ID: <8a30005f-e87c-40bf-a49f-c9f049cfbdb2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230508223124.1438167-1-imran.f.khan@oracle.com>
 <20230508223124.1438167-3-imran.f.khan@oracle.com>
 <c0ca0c9f-a93b-4159-a7cc-b73eeac3fdc2@paulmck-laptop>
 <a29619cc-4195-75c4-e49a-0e4ab433cf53@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a29619cc-4195-75c4-e49a-0e4ab433cf53@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:24:00AM +1000, Imran Khan wrote:
> Hello Paul,
> 
> On 16/5/2023 10:09 pm, Paul E. McKenney wrote:
> > On Tue, May 09, 2023 at 08:31:24AM +1000, Imran Khan wrote:
> >> On systems with hundreds of CPUs, if few hundred or most of the CPUs
> >> detect a CSD hang, then all of these waiters endup sending an NMI to
> >> destination CPU to dump its backtrace.
> >> Depending on the number of such NMIs, destination CPU can spent
> >> a significant amount of time handling these NMIs and thus making
> >> it more difficult for this CPU to address those pending CSDs timely.
> >> In worst case it can happen that by the time destination CPU is done
> >> handling all of the above mentioned backtrace NMIs, csd wait time
> >> may have elapsed and all of the waiters start sending backtrace NMI
> >> again and this behaviour continues in loop.
> >>
> >> To avoid the above mentioned scenario, issue backtrace NMI only from
> >> first waiter. The other waiters to same CSD destination can make use
> >> of backtrace obtained via fist waiter's NMI.
> >>
> >> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks a lot for reviewing this and [1]. Could you kindly let me know
> if you plan to pick these in your tree, at some point of time.

I have done so, and they should make it to -next early next week,
assuming testing goes well.

							Thanx, Paul

> Thanks,
> Imran
> 
> [1]:
> https://lore.kernel.org/all/088edfa0-c1b7-407f-8b20-caf0fecfbb79@paulmck-laptop/
> 
> >> ---
> >>  kernel/smp.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/smp.c b/kernel/smp.c
> >> index b7ccba677a0a0..a1cd21ea8b308 100644
> >> --- a/kernel/smp.c
> >> +++ b/kernel/smp.c
> >> @@ -43,6 +43,8 @@ static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
> >>  
> >>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
> >>  
> >> +static DEFINE_PER_CPU(atomic_t, trigger_backtrace) = ATOMIC_INIT(1);
> >> +
> >>  static void __flush_smp_call_function_queue(bool warn_cpu_offline);
> >>  
> >>  int smpcfd_prepare_cpu(unsigned int cpu)
> >> @@ -242,7 +244,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> >>  			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
> >>  	}
> >>  	if (cpu >= 0) {
> >> -		dump_cpu_task(cpu);
> >> +		if (atomic_cmpxchg_acquire(&per_cpu(trigger_backtrace, cpu), 1, 0))
> >> +			dump_cpu_task(cpu);
> >>  		if (!cpu_cur_csd) {
> >>  			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
> >>  			arch_send_call_function_single_ipi(cpu);
> >> @@ -423,9 +426,14 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
> >>  	struct llist_node *entry, *prev;
> >>  	struct llist_head *head;
> >>  	static bool warned;
> >> +	atomic_t *tbt;
> >>  
> >>  	lockdep_assert_irqs_disabled();
> >>  
> >> +	/* Allow waiters to send backtrace NMI from here onwards */
> >> +	tbt = this_cpu_ptr(&trigger_backtrace);
> >> +	atomic_set_release(tbt, 1);
> >> +
> >>  	head = this_cpu_ptr(&call_single_queue);
> >>  	entry = llist_del_all(head);
> >>  	entry = llist_reverse_order(entry);
> >> -- 
> >> 2.34.1
> >>
