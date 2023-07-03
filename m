Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053D0745979
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGCJ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjGCJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:58:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24817172E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:54:44 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qGGF0-0001X4-1P; Mon, 03 Jul 2023 11:53:06 +0200
Message-ID: <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
Date:   Mon, 3 Jul 2023 11:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688378085;f7f9c399;
X-HE-SMSGID: 1qGGF0-0001X4-1P
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.23 14:27, Bagas Sanjaya wrote:
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> After upgrading to kernel version 6.4.0 from 6.3.9, I noticed frequent but random crashes in a user space program.  After a lot of reduction, I have come up with the following reproducer program:
> [...]
>> After tuning the various parameters for my computer, exit code 2, which indicates that memory corruption was detected, occurs approximately 99% of the time.  Exit code 1, which occurs approximately 1% of the time, means it ran out of statically-allocated memory before reproducing the issue, and increasing the memory usage any more only leads to diminishing returns.  There is also something like a 0.1% chance that it segfaults due to memory corruption elsewhere than in the statically-allocated buffer.
>>
>> With this reproducer in hand, I was able to perform the following bisection:
> [...]
>
> See Bugzilla for the full thread.

Additional details from
https://bugzilla.kernel.org/show_bug.cgi?id=217624#c5 :

```
I can confirm that v6.4 with 0bff0aaea03e2a3ed6bfa302155cca8a432a1829
reverted no longer causes any memory corruption with either my
reproducer or the original program.
```

FWIW: 0bff0aaea03 ("x86/mm: try VMA lock-based page fault handling
first") [merged for v6.4-rc1, authored by Suren Baghdasaryan [already CCed]]

That's the same commit that causes build problems with go:

https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot introduced: 0bff0aaea03e2a3
