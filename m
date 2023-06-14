Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8E72F7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbjFNIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjFNIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:38:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E0F186
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:38:09 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9M0t-0000Xr-Sh; Wed, 14 Jun 2023 10:37:59 +0200
Message-ID: <2cf7bd0e-39b8-b1ac-5b60-2d67144d43ad@leemhuis.info>
Date:   Wed, 14 Jun 2023 10:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
Content-Language: en-US, de-DE
To:     Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz, vbabka@suse.cz,
        regressions@lists.linux.dev, Yu Ma <yu.ma@intel.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20221024052841.3291983-1-shakeelb@google.com>
 <20230608111408.s2minsenlcjow7q3@quack3>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230608111408.s2minsenlcjow7q3@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686731889;7ef56f57;
X-HE-SMSGID: 1q9M0t-0000Xr-Sh
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

On 08.06.23 13:14, Jan Kara wrote:
> On Mon 24-10-22 05:28:41, Shakeel Butt wrote:
>> Currently mm_struct maintains rss_stats which are updated on page fault
>> and the unmapping codepaths. For page fault codepath the updates are
>> cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
>> The reason for caching is performance for multithreaded applications
>> otherwise the rss_stats updates may become hotspot for such
>> applications.
>>
>> However this optimization comes with the cost of error margin in the rss
>> stats. The rss_stats for applications with large number of threads can
>> be very skewed. At worst the error margin is (nr_threads * 64) and we
>> have a lot of applications with 100s of threads, so the error margin can
>> be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
>>
>> Recently we started seeing the unbounded errors for rss_stats for
>> specific applications which use TCP rx0cp. It seems like
>> vm_insert_pages() codepath does not sync rss_stats at all.
>>
>> This patch converts the rss_stats into percpu_counter to convert the
>> error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
>> However this conversion enable us to get the accurate stats for
>> situations where accuracy is more important than the cpu cost. Though
>> this patch does not make such tradeoffs.
>>
>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> 
> Somewhat late to the game but our performance testing grid has noticed this
> commit causes a performance regression on shell-heavy workloads. For
> example running 'make test' in git sources on our test machine with 192
> CPUs takes about 4% longer, system time is increased by about 9%:

Thanks for the report.

I noticed this is nothing urgent. Nevertheless to be sure the issue
doesn't fall through the cracks unnoticed, I'm adding it to regzbot, the
Linux kernel regression tracking bot:

#regzbot ^introduced f1a7941243c
#regzbot title mm: performance regression on shell-heavy workloads
#regzbot backburner: not urgent according to reporter
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
