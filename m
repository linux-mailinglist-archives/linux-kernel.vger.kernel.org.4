Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5670589B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjEPUU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPUUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:20:25 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D021BC;
        Tue, 16 May 2023 13:20:24 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:36164)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pz19h-002ZkH-QH; Tue, 16 May 2023 14:20:21 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:56442 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pz19g-005u3c-ER; Tue, 16 May 2023 14:20:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20230516133810.171487-1-svens@linux.ibm.com>
        <20230516133810.171487-2-svens@linux.ibm.com>
        <20230516164221.GA2602133@hirez.programming.kicks-ass.net>
Date:   Tue, 16 May 2023 15:20:12 -0500
In-Reply-To: <20230516164221.GA2602133@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 16 May 2023 18:42:21 +0200")
Message-ID: <87a5y4owoz.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pz19g-005u3c-ER;;;mid=<87a5y4owoz.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+C6j5vbh8LAKBFQK+BQoVJqExhcgN7PAM=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 780 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (0.5%), b_tie_ro: 3.0 (0.4%), parse: 0.67
        (0.1%), extract_message_metadata: 9 (1.1%), get_uri_detail_list: 0.80
        (0.1%), tests_pri_-2000: 8 (1.0%), tests_pri_-1000: 1.98 (0.3%),
        tests_pri_-950: 1.08 (0.1%), tests_pri_-900: 0.82 (0.1%),
        tests_pri_-200: 0.68 (0.1%), tests_pri_-100: 3.0 (0.4%),
        tests_pri_-90: 83 (10.6%), check_bayes: 81 (10.4%), b_tokenize: 4.4
        (0.6%), b_tok_get_all: 5 (0.7%), b_comp_prob: 1.31 (0.2%),
        b_tok_touch_all: 67 (8.5%), b_finish: 0.85 (0.1%), tests_pri_0: 190
        (24.3%), check_dkim_signature: 0.38 (0.0%), check_dkim_adsp: 2.9
        (0.4%), poll_dns_idle: 464 (59.5%), tests_pri_10: 1.66 (0.2%),
        tests_pri_500: 474 (60.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] entry: move the exit path to header files
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, May 16, 2023 at 03:38:09PM +0200, Sven Schnelle wrote:
>> @@ -465,4 +470,175 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
>>   */
>>  void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
>>  
>> +static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>> +					    unsigned long ti_work)
>
> Should these things not grow __always_inline/inline when moved into a header?

Is that actually what is desired?

This is a header file that should only be included once isn't it?

>> +{
>
>> +}
>> +
>> +
>> +static void exit_to_user_mode_prepare(struct pt_regs *regs)
>
> idem
>
>> +{
>
>> +}
>
>> +static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>
> and more..
>
>> +{
>
>> +}
>> +

Perhaps it would make most sense just to change the idiom to include
the .c file.  That would give the optimizer every opportunity to inline
static functions, while strongly suggesting this file should be included
only once.

Is this maybe a s390 specific problem because the s390 has something
like ancient calling conventions that are not as efficient as they
should be.

Eric
