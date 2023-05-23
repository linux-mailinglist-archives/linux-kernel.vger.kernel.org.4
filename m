Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C9E70E12F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbjEWP5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjEWP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:57:21 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C511A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:57:14 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:43398)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q1UNt-005YDB-2I; Tue, 23 May 2023 09:57:13 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:48834 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q1UNr-008Meo-P3; Tue, 23 May 2023 09:57:12 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
        <20230522025124.5863-4-michael.christie@oracle.com>
        <20230522123029.GA22159@redhat.com>
        <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
        <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
Date:   Tue, 23 May 2023 10:57:04 -0500
In-Reply-To: <20230523121506.GA6562@redhat.com> (Oleg Nesterov's message of
        "Tue, 23 May 2023 14:15:06 +0200")
Message-ID: <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q1UNr-008Meo-P3;;;mid=<87bkib6nxr.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/ZYI+rgtjgtOjfAlPhkboPTJIRJCH5jOE=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 696 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 9 (1.3%), parse: 1.03 (0.1%),
         extract_message_metadata: 4.2 (0.6%), get_uri_detail_list: 2.2 (0.3%),
         tests_pri_-2000: 3.5 (0.5%), tests_pri_-1000: 2.4 (0.3%),
        tests_pri_-950: 1.13 (0.2%), tests_pri_-900: 0.88 (0.1%),
        tests_pri_-200: 0.72 (0.1%), tests_pri_-100: 3.4 (0.5%),
        tests_pri_-90: 274 (39.4%), check_bayes: 272 (39.0%), b_tokenize: 9
        (1.3%), b_tok_get_all: 11 (1.5%), b_comp_prob: 3.0 (0.4%),
        b_tok_touch_all: 244 (35.1%), b_finish: 1.07 (0.2%), tests_pri_0: 372
        (53.5%), check_dkim_signature: 0.64 (0.1%), check_dkim_adsp: 2.9
        (0.4%), poll_dns_idle: 0.81 (0.1%), tests_pri_10: 2.0 (0.3%),
        tests_pri_500: 12 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/22, Oleg Nesterov wrote:
>>
>> Right now I think that "int dead" should die,
>
> No, probably we shouldn't call get_signal() if we have already
> dequeued SIGKILL.

Very much agreed.  It is one thing to add a patch to move do_exit
out of get_signal.  It is another to keep calling get_signal after
that.  Nothing tests that case, and so we get some weird behaviors.


>> but let me think tomorrow.
>
> May be something like this... I don't like it but I can't suggest anything better
> right now.
>
> 	bool killed = false;
>
> 	for (;;) {
> 		...
> 	
> 		node = llist_del_all(&worker->work_list);
> 		if (!node) {
> 			schedule();
> 			/*
> 			 * When we get a SIGKILL our release function will
> 			 * be called. That will stop new IOs from being queued
> 			 * and check for outstanding cmd responses. It will then
> 			 * call vhost_task_stop to tell us to return and exit.
> 			 */
> 			if (signal_pending(current)) {
> 				struct ksignal ksig;
>
> 				if (!killed)
> 					killed = get_signal(&ksig);
>
> 				clear_thread_flag(TIF_SIGPENDING);
> 			}
>
> 			continue;
> 		}

I want to point out that we need to consider not just SIGKILL, but
SIGABRT that causes a coredump, as well as the process peforming
an ordinary exit(2).  All of which will cause get_signal to return
SIGKILL in this context.

>
> -------------------------------------------------------------------------------
> But let me ask a couple of questions.

I share most of these questions.

> Let's forget this patch, let's look at the
> current code:
>
> 		node = llist_del_all(&worker->work_list);
> 		if (!node)
> 			schedule();
>
> 		node = llist_reverse_order(node);
> 		... process works ...
>
> To me this looks a bit confusing. Shouldn't we do
>
> 		if (!node) {
> 			schedule();
> 			continue;
> 		}
>
> just to make the code a bit more clear? If node == NULL then
> llist_reverse_order() and llist_for_each_entry_safe() will do nothing.
> But this is minor.
>
>
>
> 		/* make sure flag is seen after deletion */
> 		smp_wmb();
> 		llist_for_each_entry_safe(work, work_next, node, node) {
> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>
> I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEUED,
> vhost_work_queue() can add this work again and change work->node->next.
>
> That is why we use _safe, but we need to ensure that llist_for_each_safe()
> completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.
>
> So it seems that smp_wmb() can't help and should be removed, instead we need
>
> 		llist_for_each_entry_safe(...) {
> 			smp_mb__before_atomic();
> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>
> Also, if the work->fn pointer is not stable, we should read it before
> smp_mb__before_atomic() as well.
>
> No?
>
>
> 			__set_current_state(TASK_RUNNING);
>
> Why do we set TASK_RUNNING inside the loop? Does this mean that work->fn()
> can return with current->state != RUNNING ?
>
>
> 			work->fn(work);
>
> Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
> before we call work->fn(). Is it "safe" to run this callback with
> signal_pending() or fatal_signal_pending() ?
>
>
> Finally. I never looked into drivers/vhost/ before so I don't understand
> this code at all, but let me ask anyway... Can we change vhost_dev_flush()
> to run the pending callbacks rather than wait for vhost_worker() ?
> I guess we can't, ->mm won't be correct, but can you confirm?

In a conversation long ago I remember hearing that vhost does not
support file descriptor passing.  Which means all of the file
descriptors should be in the same process.

Looking at the vhost code what I am seeing happening is that the
vhost_worker persists until vhost_dev_cleanup is called from
one of the vhost_???_release() functions.  The release functions
are only called after the last flush function completes.  See __fput
if you want to trace the details.


On one hand this all seems reasonable.  On the other hand I am not
seeing the code that prevents file descriptor passing.


It is probably not the worst thing in the world, but what this means
is now if you pass a copy of the vhost file descriptor to another
process the vhost_worker will persist, and thus the process will persist
until that copy of the file descriptor is closed.

Eric

