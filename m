Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13996D5C65
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjDDJxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjDDJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:53:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1E1BF4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:53:12 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pjdLg-0002IN-MX; Tue, 04 Apr 2023 11:53:08 +0200
Message-ID: <cfcf852c-e9f0-f560-542d-0f72777a85b2@leemhuis.info>
Date:   Tue, 4 Apr 2023 11:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: rq lock contention due to commit af7f588d8f73
Content-Language: en-US, de-DE
To:     Aaron Lu <aaron.lu@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230327080502.GA570847@ziqianlu-desk2>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230327080502.GA570847@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680601992;21241e90;
X-HE-SMSGID: 1pjdLg-0002IN-MX
X-Spam-Status: No, score=-1.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

On 27.03.23 10:05, Aaron Lu wrote:
> 
> I was doing some optimization work[1] for kernel scheduler using a
> database workload: sysbench+postgres and before I submit my work, I
> rebased my patch on top of latest v6.3-rc kernels to see if everything
> still works expected and then I found rq's lock became very heavily
> contended as compared to v6.2 based kernels.
> 
> Using the above mentioned workload, before commit af7f588d8f73("sched:
> Introduce per-memory-map concurrency ID"), the profile looked like:
> 
>      7.30%     0.71%  [kernel.vmlinux]            [k] __schedule
>      0.03%     0.03%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> 
> After that commit:
> 
>     49.01%     0.87%  [kernel.vmlinux]            [k] __schedule
>     43.20%    43.18%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
>

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced af7f588d8f73
#regzbot monitor
https://lore.kernel.org/lkml/20230403181342.210896-1-mathieu.desnoyers@efficios.com/
#regzbot monitor
https://lore.kernel.org/all/20230330230911.228720-1-mathieu.desnoyers@efficios.com/
#regzbot title sched: PostgreSQL performance regression introduced by mm_cid
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
