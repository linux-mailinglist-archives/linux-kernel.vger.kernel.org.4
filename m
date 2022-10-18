Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC2E6032F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJRTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJRTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:00:13 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4F9165BA;
        Tue, 18 Oct 2022 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1666119602;
        bh=ZBUv2uCs4jiCMgU+BGJpbZD2VUQHdbdxtg8tTxbJbl4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kamma+SeZhEBl5kiX3DSpPdnSONS8gk9tLhZi+94vSPoslsZVARP3t4shPm+u16Jw
         FYMhOnHOmspKu8vUYuVpC/8Rwgz2H60DwaYjV+XrvufmnxRsL9GlT1hZOI/qNcV0Ot
         QmcKAWJFBw2HLv78p85wXGk0aB00ieOYxd/yHhOcMutkOODvdKLssuntEBHenabpOv
         ZkXFh6Q+NzW6LNQBsKaO524Llrt2+6zYaN0Juex7IwCZPPX/GT8nK8YN1mQgpIU4NG
         Z8H/rDOCHa1yE5Atu7Cf2/V9L2Su4ZJy9z/d/Lrxk3E1Jtgvt6WyRvHbmko6EY69tT
         ck1DAufM69Ltg==
Received: from [10.1.0.219] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MsNTY6DRqzVSX;
        Tue, 18 Oct 2022 15:00:01 -0400 (EDT)
Message-ID: <40d75f05-ef87-d64d-2e4a-60066e49f265@efficios.com>
Date:   Tue, 18 Oct 2022 15:00:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 01/25] rseq: Introduce feature size and alignment ELF
 auxiliary vector entries
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
 <20220922105941.237830-2-mathieu.desnoyers@efficios.com>
 <877d1726kd.fsf@oldenburg.str.redhat.com>
 <d128fb7d-6b24-5caf-8e3a-99d55922cd95@efficios.com>
 <0a4a1a2c-964e-dcc6-948a-fd252962aaff@efficios.com>
 <87fsfli1r9.fsf@oldenburg.str.redhat.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87fsfli1r9.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-18 11:34, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> If we extend struct rseq to a size that makes the compiler use an
>> alignment larger than 32 bytes in the future, and if the compiler uses
>> that larger alignment knowledge to issue instructions that require the
>> larger alignment, then it would be incorrect for user-space to
>> allocate the struct rseq on an alignment lower than the required
>> alignment.
>>
>> Indeed, on rseq registration, we have the following check:
>>
>> if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq))
>> [...]
>>     return -EINVAL;
>>
>> Which would break if the size of struct rseq is large enough that the
>> alignment grows larger than 32 bytes.
> 
> I never quite understood the reason for that check, it certainly made
> the glibc implementation more complicated.  But to support variable
> sizes internally, we'll have to put in some extra effort anyway, so that
> it won't matter much in the end.  As long as the required alignment
> isn't larger than the page size. 8-/

I don't expect it to grow so large.

There is one more reason why increasing the alignment of struct rseq may 
become useful as the structure grows: it would guarantee that it fits in 
a single lower level cache line as its size increases. It's not 
something I expect would break if not properly aligned, but it's a nice 
optimization.

I see two possible approaches here:

1) We expose the rseq alignment explicitly through auxv, and we can keep 
the IS_ALIGNED validation on rseq registration. This "IS_ALIGNED" check 
would probably have to be tweaked though, because if the registered
rseq size is 32, then an alignment of 32 is all we require. It's only if 
the rseq_len is different from 32 that we need to validate that the 
alignment matches the alignment of struct rseq.

2) We don't expose the rseq alignment through auxv, effectively fixing 
it at 32. We would need to modify the IS_ALIGNED check on rseq 
registration so it validates an alignment of 32 rather than using the 
alignment of struct rseq.

> 
>> You mentioned we could steal some high bits from AT_RSEQ_FEATURE_SIZE
>> to put the alignment. What is the issue with exposing an explicit
>> AT_RSEQ_ALIGN ? It's just a auxv entry, so I don't see it as a huge
>> performance concern to access 2 entries rather than one.
> 
> I don't mind too much, we already have a large on-stack array in the
> loader so that we can decode the auxiliary vector without a humongous
> switch statement.  But eventually that approach will stop working if the
> set of interesting AT_* values become too large and discontinuous.

OK. So I guess the main question here is whether we want fixed-32-bytes 
alignment, or do we want to be able to increase the mandated alignment 
in the future as struct rseq expands ?

The possible reasons for increasing the alignment over 32-bytes would be:

- Unforeseen compiler requirement on a structure alignment larger than 
32-bytes as we extend the size of struct rseq.
- Optimization to fit within a single LLC cache line as struct rseq grows.

Thoughts ?

Thanks,

Mathieu

> 
> Thanks,
> Florian
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

