Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA570742B06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjF2RGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2RGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:06:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938542D4C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:06:34 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qEv5m-0004tO-Fr; Thu, 29 Jun 2023 19:06:02 +0200
Message-ID: <90150fe2-e07d-d991-5bab-0a931abda9a3@leemhuis.info>
Date:   Thu, 29 Jun 2023 19:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling
 first
Content-Language: en-US, de-DE
To:     Jiri Slaby <jirislaby@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org
Cc:     michel@lespinasse.org, joelaf@google.com, songliubraving@fb.com,
        mhocko@suse.com, leewalsh@google.com, david@redhat.com,
        peterz@infradead.org, bigeasy@linutronix.de, peterx@redhat.com,
        dhowells@redhat.com, linux-mm@kvack.org, edumazet@google.com,
        jglisse@google.com, punit.agrawal@bytedance.com, will@kernel.org,
        arjunroy@google.com, chriscli@google.com, dave@stgolabs.net,
        minchan@google.com, x86@kernel.org, hughd@google.com,
        willy@infradead.org, gurua@google.com, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org, rientjes@google.com,
        axelrasmussen@google.com, kernel-team@android.com,
        michalechner92@googlemail.com, soheil@google.com,
        paulmck@kernel.org, jannh@google.com, liam.howlett@oracle.com,
        shakeelb@google.com, luto@kernel.org, gthelen@google.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, posk@google.com,
        lstoakes@gmail.com, peterjung1337@gmail.com,
        linuxppc-dev@lists.ozlabs.org, kent.overstreet@linux.dev,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        tatashin@google.com, mgorman@techsingularity.net, rppt@kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-30-surenb@google.com>
 <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688058394;ddf8da5c;
X-HE-SMSGID: 1qEv5m-0004tO-Fr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 29.06.23 16:40, Jiri Slaby wrote:
> 
> On 27. 02. 23, 18:36, Suren Baghdasaryan wrote:
>> Attempt VMA lock-based page fault handling first, and fall back to the
>> existing mmap_lock-based handling if that fails.
> [...]
>> +    fault = handle_mm_fault(vma, address, flags |
>> FAULT_FLAG_VMA_LOCK, regs);
>> +    vma_end_read(vma);
>> +
>> +    if (!(fault & VM_FAULT_RETRY)) {
>> +        count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>> +        goto done;
>> +    }
>> +    count_vm_vma_lock_event(VMA_LOCK_RETRY);
> 
> This is apparently not strong enough as it causes go build failures like:
> 
> [  409s] strconv
> [  409s] releasep: m=0x579e2000 m->p=0x5781c600 p->m=0x0 p->status=2
> [  409s] fatal error: releasep: invalid p state
> [  409s]
> 
> [  325s] hash/adler32
> [  325s] hash/crc32
> [  325s] cmd/internal/codesign
> [  336s] fatal error: runtime: out of memory
> 
> There are many kinds of similar errors. It happens in 1-3 out of 20
> builds only.
> 
> If I revert the commit on top of 6.4, they all dismiss. Any idea?
> 
> The downstream report:
> https://bugzilla.suse.com/show_bug.cgi?id=1212775
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 0bff0aaea03e2a3ed6bfa3021
https://bugzilla.suse.com/show_bug.cgi?id=1212775
#regzbot title mm: failures when building go in 1-3 out of 20 builds
#regzbot ignore-activity

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
