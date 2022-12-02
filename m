Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9122964117F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiLBX3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiLBX3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:29:35 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A1E1746;
        Fri,  2 Dec 2022 15:29:34 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:51516)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1p1FTG-006kVV-Oy; Fri, 02 Dec 2022 16:29:30 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:45068 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1p1FTF-00HPxw-Mn; Fri, 02 Dec 2022 16:29:30 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
References: <20221125135500.1653800-1-frederic@kernel.org>
        <20221125135500.1653800-4-frederic@kernel.org>
        <871qpkqof8.fsf@email.froward.int.ebiederm.org>
        <20221202225428.GA1754872@lothringen>
Date:   Fri, 02 Dec 2022 17:28:54 -0600
In-Reply-To: <20221202225428.GA1754872@lothringen> (Frederic Weisbecker's
        message of "Fri, 2 Dec 2022 23:54:28 +0100")
Message-ID: <87ilitpeq1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1p1FTF-00HPxw-Mn;;;mid=<87ilitpeq1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18ScrhFGE1qiUX6HuHOf/JWfT6PWoVERUE=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Frederic Weisbecker <frederic@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 540 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 9 (1.6%), parse: 0.85 (0.2%),
         extract_message_metadata: 3.6 (0.7%), get_uri_detail_list: 1.56
        (0.3%), tests_pri_-1000: 3.8 (0.7%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-200: 0.80 (0.1%),
        tests_pri_-100: 3.3 (0.6%), tests_pri_-90: 58 (10.8%), check_bayes: 57
        (10.6%), b_tokenize: 7 (1.3%), b_tok_get_all: 8 (1.5%), b_comp_prob:
        2.6 (0.5%), b_tok_touch_all: 36 (6.7%), b_finish: 0.76 (0.1%),
        tests_pri_0: 439 (81.4%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> On Wed, Nov 30, 2022 at 12:37:15PM -0600, Eric W. Biederman wrote:
>> Frederic Weisbecker <frederic@kernel.org> writes:
>> Two questions.
>> 
>> 1) Is there any chance you need the exit_task_rcu_stop() and
>>    exit_tasks_rcu_start() around schedule in the part of this code that
>>    calls kernel_wait4.
>
> Indeed it could be relaxed there too if necessary.

I was just wondering how you tell if it is necessary and if perhaps
the kernel_wait4 was overlooked.

>> 2) I keep thinking zap_pid_ns_processes() should be changed so that
>>    after it sends SIGKILL to all of the relevant processes to not wait,
>>    and instead have wait_consider_task simply not allow the 
>>    init process of the pid namespace to be reaped.
>> 
>>    Am I right in thinking that such a change were to be made it would
>>    make remove the deadlock without having to have any special code?
>> 
>>    It is just tricky enough to do that I don't want to discourage your
>>    simpler change but this looks like a case that makes the pain of
>>    changing zap_pid_ns_processes worthwhile in the practice.
>
> So you mean it still reaps those that were EXIT_ZOMBIE before ignoring
> SIGCHLD (the kernel_wait4() call) but it doesn't sleep anymore on those
> that autoreap (or get reaped by a parent outside that namespace) after
> ignoring SIGCHLD? Namely it doesn't do the schedule() loop I'm working
> around here and proceeds with exit_notify() and notifies its parent?

Yes.  A change to make it work like when the thread group leader exits
before the other threads.  So any actual sleeping happens in the reaper
of the init process when the reaper calls wait(2).

> And then in this case the responsibility of sleeping, until the init_process
> of the namespace is the last task in the namespace, goes to the parent while
> waiting that init_process, right?
>
> But what if the init_process of the given namespace autoreaps? Should it then
> wait itself until the namespace is empty? And then aren't we back to the initial
> issue?

The idea is that we only care when the userspace cares.  I don't think
there is any kernel code that fundamentally cares.  There might be a few
bits that accidentally care and those would need to be take care of when
making the proposed change.  The wait would only exist for userspace so
the same semantics are observed.

Eric
