Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91613713760
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 03:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjE1BRk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 27 May 2023 21:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1BRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 21:17:39 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651C0D3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 18:17:37 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:49118)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q352N-00Bv4L-BZ; Sat, 27 May 2023 19:17:35 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:56428 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q352M-003tFt-0E; Sat, 27 May 2023 19:17:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
        <20230522025124.5863-4-michael.christie@oracle.com>
        <20230522123029.GA22159@redhat.com>
        <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
        <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
        <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
        <20230524141022.GA19091@redhat.com>
        <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
        <20230525115512.GA9229@redhat.com>
        <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
        <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
        <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
Date:   Sat, 27 May 2023 20:17:09 -0500
In-Reply-To: <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 27 May 2023 09:12:27 -0700")
Message-ID: <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1q352M-003tFt-0E;;;mid=<87mt1pmezu.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+/uLz/5gvsT9Lr5b/sz4lC4Q7fsNO8xzg=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 716 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 17 (2.3%), b_tie_ro: 14 (2.0%), parse: 2.2 (0.3%),
         extract_message_metadata: 31 (4.3%), get_uri_detail_list: 6 (0.8%),
        tests_pri_-2000: 21 (2.9%), tests_pri_-1000: 3.8 (0.5%),
        tests_pri_-950: 1.84 (0.3%), tests_pri_-900: 1.49 (0.2%),
        tests_pri_-200: 1.22 (0.2%), tests_pri_-100: 9 (1.3%), tests_pri_-90:
        115 (16.1%), check_bayes: 96 (13.4%), b_tokenize: 20 (2.8%),
        b_tok_get_all: 14 (2.0%), b_comp_prob: 6 (0.8%), b_tok_touch_all: 50
        (7.0%), b_finish: 1.41 (0.2%), tests_pri_0: 482 (67.4%),
        check_dkim_signature: 0.81 (0.1%), check_dkim_adsp: 6 (0.9%),
        poll_dns_idle: 0.57 (0.1%), tests_pri_10: 3.4 (0.5%), tests_pri_500:
        20 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, May 27, 2023 at 2:49 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The real sticky widget for me is how to handle one of these processes
>> coredumping.  It really looks like it will result in a reliable hang.
>
> Well, if *that* is the main worry, I think that's trivial enough to deal with.
>
> In particular, we could make the rule just be that user worker threads
> simply do not participate in core-dumps.
>
> THAT isn't hard.
>
> All we need to do is
>
>  (a) not count those threads in zap_threads()
>
>  (b) make sure that they don't add themselves to the "dumper" list by
> not calling "coredujmp_task_exit()"
>
>  (c) not initiate core-dumping themselves.
>
> and I think that's pretty much it.
>
> In fact, that really seems like a good model *regardless*, because
> honestly, a PF_IO_WORKER doesn't have valid register state for the
> core dump anyway, and anything that would have caused a IO thread to
> get a SIGSEGV *should* have caused a kernel oops already.
>
> So the only worry is that the core dump will now happen while an IO
> worker is still busy and so it's not "atomic" wrt possible VM changes,
> but while that used to be a big problem back in the dark ages when we
> didn't get the VM locks for core dumping, that got fixed a few years
> ago because it already caused lots of potential issues.


>
> End result: I think the attached patch is probably missing something,
> but the approach "FeelsRight(tm)" to me.
>
> Comments?

It seems like a good approach for including in the -rc series.
I think the change should look more like my change below.

nits:
  - The threads all need to participate in the group exit even if they
    aren't going to be in the coredump.

  - For vhost_worker we need s/PF_IO_WORKER/PF_USER_WORKER/.

  - Moving PF_IO_WORKER above the sig_kernel_coredump(signr) test is
    unnecessary.  The sig_kernel_coredump(signr) test can only become
    true if a process exit has not been initiated yet.  More importantly
    moving the test obscures the fact that only do_group_exit is
    moved out of get_signal for the PF_IO_WORKER special case.


Long term I think we want an approach that stops the worker threads
during the coredumps.  It will just yield a better quality of
implementation if we minimize the amount of concurrency during the
coredump.

I have a pending patchset that moves the coredump rendezvous into
get_signal.  At which point stopping all of the threads is just like
SIGSTOP something the worker threads can use and it won't introduce any
issues.  Today the problem is some of the worker thread code must run
before the coredump stop.

Looking forward I don't see not asking the worker threads to stop
for the coredump right now causing any problems in the future.
So I think we can use this to resolve the coredump issue I spotted.


diff --git a/fs/coredump.c b/fs/coredump.c
index ece7badf701b..620f7f9dc894 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -371,7 +371,8 @@ static int zap_process(struct task_struct *start, int exit_code)
 		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
 			sigaddset(&t->pending.signal, SIGKILL);
 			signal_wake_up(t, 1);
-			nr++;
+			if (!(t->flags & PF_IO_WORKER))
+				nr++;
 		}
 	}
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 34b90e2e7cf7..6082dba9131a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -411,7 +411,9 @@ static void coredump_task_exit(struct task_struct *tsk)
 	tsk->flags |= PF_POSTCOREDUMP;
 	core_state = tsk->signal->core_state;
 	spin_unlock_irq(&tsk->sighand->siglock);
-	if (core_state) {
+
+	/* I/O Workers don't participate in coredumps */
+	if (core_state && !(tsk->flags & PF_IO_WORKER) {
 		struct core_thread self;
 
 		self.task = current;


>  		current->flags |= PF_SIGNALED;
>  
> +		/*
> +		 * PF_IO_WORKER threads will catch and exit on fatal signals
> +		 * themselves and do not participate in core dumping.
> +		 *
> +		 * They have cleanup that must be performed, so we cannot
> +		 * call do_exit() on their behalf.
> +		 */
> +		if (current->flags & PF_IO_WORKER)
> +			goto out;
> +
>  		if (sig_kernel_coredump(signr)) {
>  			if (print_fatal_signals)
>  				print_fatal_signal(ksig->info.si_signo);
> @@ -2860,14 +2870,6 @@ bool get_signal(struct ksignal *ksig)
>  			do_coredump(&ksig->info);
>  		}
>  
> -		/*
> -		 * PF_IO_WORKER threads will catch and exit on fatal signals
> -		 * themselves. They have cleanup that must be performed, so
> -		 * we cannot call do_exit() on their behalf.
> -		 */
> -		if (current->flags & PF_IO_WORKER)
> -			goto out;
> -
>  		/*
>  		 * Death signals, no core dump.
>  		 */

Eric
