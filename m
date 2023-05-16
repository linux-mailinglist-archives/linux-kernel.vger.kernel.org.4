Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE0705865
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjEPUM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjEPUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:12:54 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD65421A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:12:52 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33060)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pz12Q-002ZBM-Ml; Tue, 16 May 2023 14:12:50 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41298 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pz12P-005t0v-G7; Tue, 16 May 2023 14:12:50 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Christie <michael.christie@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
        <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
        <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
        <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
        <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
        <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
        <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
        <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
        <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
        <87cz30s20y.fsf@email.froward.int.ebiederm.org>
        <20230516183757.GA1286@redhat.com>
Date:   Tue, 16 May 2023 15:12:10 -0500
In-Reply-To: <20230516183757.GA1286@redhat.com> (Oleg Nesterov's message of
        "Tue, 16 May 2023 20:37:57 +0200")
Message-ID: <87mt24ox2d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pz12P-005t0v-G7;;;mid=<87mt24ox2d.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1//rdFVubSWApRxlVrJbJVsmsZmIf/63yc=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 422 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.9 (1.2%), b_tie_ro: 3.2 (0.8%), parse: 1.15
        (0.3%), extract_message_metadata: 4.7 (1.1%), get_uri_detail_list: 2.4
        (0.6%), tests_pri_-2000: 2.4 (0.6%), tests_pri_-1000: 2.4 (0.6%),
        tests_pri_-950: 1.07 (0.3%), tests_pri_-900: 0.89 (0.2%),
        tests_pri_-200: 0.73 (0.2%), tests_pri_-100: 2.7 (0.6%),
        tests_pri_-90: 57 (13.5%), check_bayes: 55 (13.1%), b_tokenize: 7
        (1.6%), b_tok_get_all: 9 (2.2%), b_comp_prob: 1.87 (0.4%),
        b_tok_touch_all: 34 (8.2%), b_finish: 0.76 (0.2%), tests_pri_0: 327
        (77.6%), check_dkim_signature: 0.41 (0.1%), check_dkim_adsp: 3.3
        (0.8%), poll_dns_idle: 0.81 (0.2%), tests_pri_10: 2.8 (0.7%),
        tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/16, Eric W. Biederman wrote:
>>
>> A kernel thread can block SIGKILL and that is supported.
>>
>> For a thread that is part of a process you can't block SIGKILL when the
>> task is part of a user mode process.
>
> Or SIGSTOP. Another thread can call do_signal_stop()->signal_wake_up/etc.

Yes, ignoring SIGSTOP leads to the same kind of rendezvous issues as
SIGKILL.

>> There is this bit in complete_signal when SIGKILL is delivered to any
>> thread in the process.
>>
>> 			t = p;
>> 			do {
>> 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
>> 				sigaddset(&t->pending.signal, SIGKILL);
>> 				signal_wake_up(t, 1);
>> 			} while_each_thread(p, t);
>
> That is why the latest version adds try_set_pending_sigkill(). No, no,
> it is not that I think this is a good idea.

I see that try_set_pending_sigkill in the patch now.

That try_set_pending_sigkill just keeps the process from reporting
that it has exited, and extend the process exit indefinitely.

SIGNAL_GROUP_EXIT has already been set, so the KILL signal was
already delivered and the process is exiting.

>> For clarity that sigaddset(&t->pending.signal, SIGKILL);  Really isn't
>> setting SIGKILL pending,
>
> Hmm. it does? Nevermind.

The point is that what try_set_pending_sigkill in the patch is doing is
keeping the "you are dead exit now" flag, from being set.

That flag is what fatal_signal_pending always tests, because we can only
know if a fatal signal is pending if we have performed short circuit
delivery on the signal.

The result is the effects of the change are mostly what people expect.
The difference the semantics being changed aren't what people think they
are.

AKA process exit is being ignored for the thread, not that SIGKILL is
being blocked.

>> The important part of that code is that SIGNAL_GROUP_EXIT gets set.
>> That indicates the entire process is being torn down.
>
> Yes. and the same is true for io-thread even if it calls get_signal()
> and dequeues SIGKILL and clears TIF_SIGPENDING.
>
>> but in that case the vhost logic needs to act like a process, just
>> like io_uring does.
>
> confused... create_io_thread() creates a sub-thread too?

Yes, create_io_uring creates an ordinary user space thread that never
runs any code in user space.

> Although I never understood this logic. I can't even understand the usage
> of lower_32_bits() in create_io_thread().

As far as I can tell lower_32_bits(flags) is just defensive programming
that just copies the code in clone.  The code just as easily have said
u32 flags, or have just populated .flags directly.  Then .exit_signal
could have been set to 0.  Later copy_process will set .exit_signal = -1
because CLONE_THREAD is set.

The reason for adding create_io_thread calling copy_process as I recall
so that the new task does not start automatically.  This allows
functions like io_init_new_worker to initialize the new task without
races and then call wake_up_new_task.

Eric

