Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5673B87C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjFWNMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFWNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:12:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0FC9D;
        Fri, 23 Jun 2023 06:12:33 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qCgaQ-0005IP-MF; Fri, 23 Jun 2023 15:12:26 +0200
Message-ID: <ab67a069-81f1-cbf9-3bf0-a388c1cf3ef9@leemhuis.info>
Date:   Fri, 23 Jun 2023 15:12:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US, de-DE
To:     Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687525953;2d858438;
X-HE-SMSGID: 1qCgaQ-0005IP-MF
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 20.06.23 10:14, Swapnil Sapkal wrote:
> 
> On 4/22/2023 1:13 PM, tip-bot2 for Mathieu Desnoyers wrote:
>> The following commit has been merged into the sched/core branch of tip:
>>
>> Commit-ID:     223baf9d17f25e2608dbdff7232c095c1e612268
>> Gitweb:       
>> https://git.kernel.org/tip/223baf9d17f25e2608dbdff7232c095c1e612268
>> Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> AuthorDate:    Thu, 20 Apr 2023 10:55:48 -04:00
>> Committer:     Peter Zijlstra <peterz@infradead.org>
>> CommitterDate: Fri, 21 Apr 2023 13:24:20 +02:00
>>
>> sched: Fix performance regression introduced by mm_cid
>>
>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>> sysbench regression reported by Aaron Lu.
> [...]
> I run standard benchmarks as a part of kernel performance regression
> testing. When I run these benchmarks against v6.3.0 to v6.4-rc1,
> I have seen performance regression in hackbench running with threads.
> When I did
> git bisect it pointed to this commit and reverting this commit helps
> regains
> the performance. This regression is not seen with hackbench processes.
> Following are the results from 1 Socket 4th generation EPYC
> Processor(1 X 96C/192T) configured in NPS1 mode. This regression
> becomes more severe as the number of core count increases.
> 
> The numbers on a 1 Socket Bergamo (1 X 128 cores/256 threads) is
> significantly worse.
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 223baf9d17f
#regzbot title sched: performance regression in hackbench (partly solved
in -next by c1753fd02a00, partially caused by df323337e50)
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
