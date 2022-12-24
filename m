Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B9F655864
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 05:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiLXE3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 23:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiLXE3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 23:29:03 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E6AB7D5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 20:29:01 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:38360)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1p8w9b-003u2d-Jt; Fri, 23 Dec 2022 21:28:59 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:39140 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1p8w9a-003BAt-9Q; Fri, 23 Dec 2022 21:28:59 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Nicholas Piggin" <npiggin@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
References: <20221004094401.708299-1-npiggin@gmail.com>
        <CP6GJNNB62LY.N38DBL6D2S79@bobo>
Date:   Fri, 23 Dec 2022 22:28:27 -0600
In-Reply-To: <CP6GJNNB62LY.N38DBL6D2S79@bobo> (Nicholas Piggin's message of
        "Tue, 20 Dec 2022 17:14:05 +1000")
Message-ID: <874jtlo26s.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1p8w9a-003BAt-9Q;;;mid=<874jtlo26s.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/zp9owaAJU/uCXstuqSpsBdgDyky8+sRU=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Nicholas Piggin" <npiggin@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 742 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (1.7%), b_tie_ro: 11 (1.5%), parse: 1.07
        (0.1%), extract_message_metadata: 18 (2.4%), get_uri_detail_list: 1.95
        (0.3%), tests_pri_-2000: 14 (1.9%), tests_pri_-1000: 2.3 (0.3%),
        tests_pri_-950: 1.23 (0.2%), tests_pri_-900: 1.00 (0.1%),
        tests_pri_-200: 0.88 (0.1%), tests_pri_-100: 6 (0.8%), tests_pri_-90:
        66 (8.9%), check_bayes: 65 (8.8%), b_tokenize: 9 (1.2%),
        b_tok_get_all: 9 (1.2%), b_comp_prob: 2.8 (0.4%), b_tok_touch_all: 41
        (5.5%), b_finish: 0.85 (0.1%), tests_pri_0: 208 (28.1%),
        check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 2.7 (0.4%),
        poll_dns_idle: 387 (52.2%), tests_pri_10: 2.9 (0.4%), tests_pri_500:
        404 (54.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exit: Detect and fix irq disabled state in oops
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Tue Oct 4, 2022 at 7:44 PM AEST, Nicholas Piggin wrote:
>> If a task oopses with irqs disabled, this can cause various cascading
>> problems in the oops path such as sleep-from-invalid warnings, and
>> potentially worse.
>>
>> Since commit 0258b5fd7c712 ("coredump: Limit coredumps to a single
>> thread group"), the unconditional irq enable in coredump_task_exit()
>> will "fix" the irq state to be enabled early in do_exit(), so currently
>> this may not be triggerable, but that is coincidental and fragile.
>>
>> Detect and fix the irqs_disabled() condition in the oops path before
>> calling do_exit(), similarly to the way in_atomic() is handled.
>>
>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Hey Eric, did you have any thoughts on this?

No strong thoughts.

I agree that the unconditionally disabling then enabling irqs in
coredump_task_exit will mean there is likely to be little change in real
behavior.

I also agree that is something fragile to depend upon so we making
our assumptions explicit seems good.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Thanks,
> Nick
>
>> ---
>>  kernel/exit.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 84021b24f79e..fa696765f694 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -738,6 +738,7 @@ void __noreturn do_exit(long code)
>>  	struct task_struct *tsk = current;
>>  	int group_dead;
>>  
>> +	WARN_ON(irqs_disabled());
>>  	WARN_ON(tsk->plug);
>>  
>>  	kcov_task_exit(tsk);
>> @@ -865,6 +866,11 @@ void __noreturn make_task_dead(int signr)
>>  	if (unlikely(!tsk->pid))
>>  		panic("Attempted to kill the idle task!");
>>  
>> +	if (unlikely(irqs_disabled())) {
>> +		pr_info("note: %s[%d] exited with irqs disabled\n",
>> +			current->comm, task_pid_nr(current));
>> +		local_irq_enable();
>> +	}
>>  	if (unlikely(in_atomic())) {
>>  		pr_info("note: %s[%d] exited with preempt_count %d\n",
>>  			current->comm, task_pid_nr(current),
>> -- 
>> 2.37.2
