Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3776A1A89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBXKrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:47:19 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C4244B4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:47:18 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pVVbf-0001Ao-FL; Fri, 24 Feb 2023 11:47:15 +0100
Message-ID: <07e61f29-5a0e-be38-ad24-01aefdf970bd@leemhuis.info>
Date:   Fri, 24 Feb 2023 11:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC] ipc/mqueue: introduce msg cache
Content-Language: en-US, de-DE
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Sven Luther <Sven.Luther@windriver.com>
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
 <7a3e0cb1-54f0-73b2-d9e5-db4d28836bfc@leemhuis.info>
 <Y+/GxJcNykVQxcG+@P9FQF9L96D.corp.robot.car>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Y+/GxJcNykVQxcG+@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677235638;7323fbfc;
X-HE-SMSGID: 1pVVbf-0001Ao-FL
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 17.02.23 19:26, Roman Gushchin wrote:
> On Thu, Feb 16, 2023 at 01:29:59PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> On 20.12.22 19:48, Roman Gushchin wrote:
>>> Sven Luther reported a regression in the posix message queues
>>> performance caused by switching to the per-object tracking of
>>> slab objects introduced by patch series ending with the
>>> commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
>>> allocations").
>>
>> Quick inquiry: what happened to below patch? It was supposed to fix a
>> performance regression reported here:
> 
> I wouldn't call it simple a regression,

Well, performance regressions are regressions, too. That being said:

> things a bit more complicated:
> it was a switch to a different approach with different trade-offs,
> which IMO make more sense for the majority of real-world workloads.
> In two words: individual kernel memory allocations became somewhat slower
> (but still fast), but we've saved 40%+ of slab memory on typical systems
> and reduced the memory fragmentation.
>
> The regression reported by Sven and my "fix" are related to one very specific
> case: posix message queues. To my knowledge they are not widely used for
> anything that performance-sensitive, so it's quite a niche use case.
> My "fix" was also hand-crafted for the benchmark provided by Sven, so it might
> not work for a more generic case. And I don't think it can be easily generalized
> without adding cpu or memory overhead.
> 
> On the other hand I'm working on improving the speed of kernel memory allocations
> in general (I posted early versions some weeks ago). Hopefully it will mitigate
> the problem for Sven as well, so we won't need these message queue-specific
> hacks.

Thx for the explanation. Sven didn't complain and it seems no one else
run into this, so I think we can live with that state of affairs.

#regzbot inconclusive: not fixed, but cause by a trade-off and a likely
corner-case anyway; more optimizations planned to improve things
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
