Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4569243F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjBJRPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjBJRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:15:36 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3F5222FE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:15:32 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pQWzd-0005Kj-2N; Fri, 10 Feb 2023 18:15:25 +0100
Message-ID: <82db210b-c23d-1e59-e3c8-73e1b27cb945@leemhuis.info>
Date:   Fri, 10 Feb 2023 18:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 2/5] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
To:     Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, qperret@google.com
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-3-longman@redhat.com>
 <20230117160825.GA17756@willie-the-truck>
 <cc637c44-3217-21f4-8843-66e99249b38c@leemhuis.info>
In-Reply-To: <cc637c44-3217-21f4-8843-66e99249b38c@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676049332;2e9cbe57;
X-HE-SMSGID: 1pQWzd-0005Kj-2N
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. There afaics is a fix for the regression discussed in this
thread, but it did not use a Link: tag to point to the report, as Linus
and the documentation call for. Things happen, no worries -- but it
forces me to write this mail to make the regression tracking bot aware
of the fix. See link in footer if these mails annoy you.]

On 26.01.23 13:52, Linux kernel regression tracking (#adding) wrote:
> On 17.01.23 17:08, Will Deacon wrote:
>>
>> On Thu, Sep 22, 2022 at 02:00:38PM -0400, Waiman Long wrote:
>>> The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
>>> Introduce task_struct::user_cpus_ptr to track requested affinity"). It
>>> is currently used only by arm64 arch due to possible asymmetric CPU
>>> setup. This patch extends its usage to save user provided cpumask
>>> when sched_setaffinity() is called for all arches. With this patch
>>> applied, user_cpus_ptr, once allocated after a successful call to
>>> sched_setaffinity(), will only be freed when the task exits.
>> [...]
>> We've tracked this down as the cause of an arm64 regression in Android and I've
>> reproduced the issue with mainline.
>>
>> Basically, if an arm64 system is booted with "allow_mismatched_32bit_el0" on
>> the command-line, then the arch code will (amongst other things) call
>> force_compatible_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
>> when exec()'ing a 32-bit or a 64-bit task respectively.
>> [...]
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 8f9ea86fdf99

#regzbot fix: 3fb906e7fabbb5b76c3c
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
