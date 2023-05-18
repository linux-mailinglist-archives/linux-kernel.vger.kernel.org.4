Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B251707815
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjERCel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjERCek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:34:40 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5CE2708
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:34:38 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:48126)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pzTTO-00E22Y-OV; Wed, 17 May 2023 20:34:34 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:42960 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pzTTN-00BSST-AS; Wed, 17 May 2023 20:34:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230518000920.191583-1-michael.christie@oracle.com>
        <20230518000920.191583-2-michael.christie@oracle.com>
Date:   Wed, 17 May 2023 21:34:01 -0500
In-Reply-To: <20230518000920.191583-2-michael.christie@oracle.com> (Mike
        Christie's message of "Wed, 17 May 2023 19:09:13 -0500")
Message-ID: <87mt22l65i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pzTTN-00BSST-AS;;;mid=<87mt22l65i.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18mx5PgcJMNNWl7RPzJ+HESs6gEuy+ye7o=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 839 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.2%), b_tie_ro: 8 (1.0%), parse: 1.19 (0.1%),
         extract_message_metadata: 6 (0.7%), get_uri_detail_list: 3.4 (0.4%),
        tests_pri_-2000: 3.5 (0.4%), tests_pri_-1000: 2.5 (0.3%),
        tests_pri_-950: 1.24 (0.1%), tests_pri_-900: 1.04 (0.1%),
        tests_pri_-200: 0.85 (0.1%), tests_pri_-100: 8 (1.0%), tests_pri_-90:
        375 (44.7%), check_bayes: 372 (44.4%), b_tokenize: 10 (1.2%),
        b_tok_get_all: 8 (1.0%), b_comp_prob: 3.0 (0.4%), b_tok_touch_all: 347
        (41.4%), b_finish: 0.94 (0.1%), tests_pri_0: 407 (48.5%),
        check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 2.7 (0.3%),
        poll_dns_idle: 1.02 (0.1%), tests_pri_10: 3.2 (0.4%), tests_pri_500:
        10 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> This has us deqeue SIGKILL even if SIGNAL_GROUP_EXIT/group_exec_task is
> set when we are dealing with PF_USER_WORKER tasks.

> When a vhost_task gets a SIGKILL, we could have outstanding IO in flight.
> We can easily stop new work/IO from being queued to the vhost_task, but
> for IO that's already been sent to something like the block layer we
> need to wait for the response then process it. These type of IO
> completions use the vhost_task to process the completion so we can't
> exit immediately.


I understand the concern.

> We need to handle wait for then handle those completions from the
> vhost_task, but when we have a SIGKLL pending, functions like
> schedule() return immediately so we can't wait like normal. Functions
> like vhost_worker() degrade to just a while(1); loop.
>
> This patch has get_signal drop down to the normal code path when
> SIGNAL_GROUP_EXIT/group_exec_task is set so the caller can still detect
> there is a SIGKILL but still perform some blocking cleanup.
>
> Note that in that chunk I'm now bypassing that does:
>
> sigdelset(&current->pending.signal, SIGKILL);
>
> we look to be ok, because in the places we set SIGNAL_GROUP_EXIT/
> group_exec_task we are already doing that on the threads in the
> group.

What you are doing does not make any sense to me.

First there is the semantic non-sense, of queuing something that
is not a signal.   The per task SIGKILL bit is used as a flag with
essentially the same meaning as SIGNAL_GROUP_EXIT, reporting that
the task has been scheduled for exit.

More so is what happens afterwards.

As I read your patch it is roughly equivalent to doing:

	if ((current->flags & PF_USER_WORKER) &&
       	    fatal_signal_pending(current)) {
		sigdelset(&current->pending.signal, SIGKILL);
	        clear_siginfo(&ksig->info);
                ksig->info.si_signo = SIGKILL;
                ksig->info.si_code = SI_USER;
                recalc_sigpending();
		trace_signal_deliver(SIGKILL, &ksig->info,
			&sighand->action[SIGKILL - 1]);
                goto fatal;
	}

Before the "(SIGNAL_GROUP_EXIT || signal->group_exec_task)" test.

To get that code I stripped the active statements out of the
dequeue_signal path the code executes after your change below.

I don't get why you are making it though because the code you
are opting out of does:

		/* Has this task already been marked for death? */
		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
		     signal->group_exec_task) {
			clear_siginfo(&ksig->info);
			ksig->info.si_signo = signr = SIGKILL;
			sigdelset(&current->pending.signal, SIGKILL);
			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
				&sighand->action[SIGKILL - 1]);
			recalc_sigpending();
			goto fatal;
		}

I don't see what in practice changes, other than the fact that by going
through the ordinary dequeue_signal path that other signals can be
processed after a SIGKILL has arrived.  Of course those signal all
should be blocked.




The trailing bit that expands the PF_IO_WORKER test to be PF_USER_WORKER
appears reasonable, and possibly needed.

Eric


> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  kernel/signal.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..ae4972eea5db 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2705,9 +2705,18 @@ bool get_signal(struct ksignal *ksig)
>  		struct k_sigaction *ka;
>  		enum pid_type type;
>  
> -		/* Has this task already been marked for death? */
> -		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
> -		     signal->group_exec_task) {
> +		/*
> +		 * Has this task already been marked for death?
> +		 *
> +		 * If this is a PF_USER_WORKER then the task may need to do
> +		 * extra work that requires waiting on running work, so we want
> +		 * to dequeue the signal below and tell the caller its time to
> +		 * start its exit procedure. When the work has completed then
> +		 * the task will exit.
> +		 */
> +		if (!(current->flags & PF_USER_WORKER) &&
> +		    ((signal->flags & SIGNAL_GROUP_EXIT) ||
> +		     signal->group_exec_task)) {
>  			clear_siginfo(&ksig->info);
>  			ksig->info.si_signo = signr = SIGKILL;
>  			sigdelset(&current->pending.signal, SIGKILL);
> @@ -2861,11 +2870,11 @@ bool get_signal(struct ksignal *ksig)
>  		}
>  
>  		/*
> -		 * PF_IO_WORKER threads will catch and exit on fatal signals
> +		 * PF_USER_WORKER threads will catch and exit on fatal signals
>  		 * themselves. They have cleanup that must be performed, so
>  		 * we cannot call do_exit() on their behalf.
>  		 */
> -		if (current->flags & PF_IO_WORKER)
> +		if (current->flags & PF_USER_WORKER)
>  			goto out;
>  
>  		/*
