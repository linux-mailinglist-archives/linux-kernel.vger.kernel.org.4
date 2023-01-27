Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19E267E136
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjA0KNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjA0KNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:13:45 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B3FDBC9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:13:19 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pLLiw-0000oP-SM; Fri, 27 Jan 2023 11:12:46 +0100
Message-ID: <20b4ad15-8ae4-bbc4-68a9-4fcd0b89e93c@leemhuis.info>
Date:   Fri, 27 Jan 2023 11:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] sched: Store restrict_cpus_allowed_ptr() call state
Content-Language: en-US, de-DE
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20230127015527.466367-1-longman@redhat.com>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230127015527.466367-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674814400;f0fae441;
X-HE-SMSGID: 1pLLiw-0000oP-SM
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.01.23 02:55, Waiman Long wrote:
> The user_cpus_ptr field was originally added by commit b90ca8badbd1
> ("sched: Introduce task_struct::user_cpus_ptr to track requested
> affinity"). It was used only by arm64 arch due to possible asymmetric
> CPU setup.
> [...]> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested
cpumask")
> Reported-by: Will Deacon <will@kernel.org>

Many thx for taking care of this. There is one small thing to improve,
please add the following tag here to make things easier for future code
archaeologists:

Link: https://lore.kernel.org/lkml/20230117160825.GA17756@willie-the-truck/

Maybe also...

Link: https://lore.kernel.org/lkml/20230124194805.GA27257@willie-the-truck/

...as it provides additional info that might be handy at some point.
BTW, Will, thx for CCing me on that.

To explain: Linus[1] and others considered proper link tags with the URL
to the report important in cases like this, as they allow anyone to look
into the backstory of a fix weeks or years later. That's nothing new,
the documentation[2] for some time says to place such tags in cases like
this. I care personally (and made it a bit more explicit in the docs a
while ago), because these tags make my regression tracking efforts a
whole lot easier, as they allow my tracking bot 'regzbot' to
automatically connect reports with patches posted or committed to fix
tracked regressions.

Apropos regzbot, let me tell regzbot to monitor this thread:

#regzbot ^backmonitor:
https://lore.kernel.org/lkml/20230117160825.GA17756@willie-the-truck/

> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
