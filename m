Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD960156E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJQRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJQRb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:31:58 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C03F691B4;
        Mon, 17 Oct 2022 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1666027913;
        bh=dxTu0Y7RDqrVuGXgQ+oQAQn11d1BWCaYnfG0wGWKGRI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=A3sWe9zWq4Xst2DZGjucpJiCDvvDKyyE47dBVPbgQEeWI4L/0u889DKGqp8CCjzU9
         pzRyFOrpGiFRTwwKAB9OgzA215Ub8LUYYuAOJIOmj5VBK6lKyQGYAdZzrDWtK+ylTr
         RWNHun43Qq/obuSIXexBMTzxYpT/lPPoy18jBbGUCbPxw+VwALn+rh6sD4py0drwUQ
         0L4CDgyNugQZq7oFmhCOD4b4HxS8YLodh5ggYKqqPNxeVF9j5qI77VZBBEozXhT3nL
         oPEpk5TfM7Fz90c2GZGblc8AlOiFbtl/MzV6rpzxYN4gJwE+bm/vgFTq8uw9JyDjMI
         8ah7PxMwxjmjA==
Received: from [172.16.0.72] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MrkZK0799zTxj;
        Mon, 17 Oct 2022 13:31:53 -0400 (EDT)
Message-ID: <0a4a1a2c-964e-dcc6-948a-fd252962aaff@efficios.com>
Date:   Mon, 17 Oct 2022 13:32:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 01/25] rseq: Introduce feature size and alignment ELF
 auxiliary vector entries
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
In-Reply-To: <d128fb7d-6b24-5caf-8e3a-99d55922cd95@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-17 12:09, Mathieu Desnoyers wrote:
> On 2022-10-10 08:42, Florian Weimer wrote:
>> * Mathieu Desnoyers:
>>
>>> Export the rseq feature size supported by the kernel as well as the
>>> required allocation alignment for the rseq per-thread area to user-space
>>> through ELF auxiliary vector entries.
>>>
>>> This is part of the extensible rseq ABI.
>>>
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> ---
>>>   fs/binfmt_elf.c             | 5 +++++
>>>   include/uapi/linux/auxvec.h | 2 ++
>>>   include/uapi/linux/rseq.h   | 5 +++++
>>>   3 files changed, 12 insertions(+)
>>>
>>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>>> index 63c7ebb0da89..04fca1e4cbd2 100644
>>> --- a/fs/binfmt_elf.c
>>> +++ b/fs/binfmt_elf.c
>>> @@ -46,6 +46,7 @@
>>>   #include <linux/cred.h>
>>>   #include <linux/dax.h>
>>>   #include <linux/uaccess.h>
>>> +#include <linux/rseq.h>
>>>   #include <asm/param.h>
>>>   #include <asm/page.h>
>>> @@ -288,6 +289,10 @@ create_elf_tables(struct linux_binprm *bprm, 
>>> const struct elfhdr *exec,
>>>       if (bprm->have_execfd) {
>>>           NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
>>>       }
>>> +#ifdef CONFIG_RSEQ
>>> +    NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
>>> +    NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
>>> +#endif
>>>   #undef NEW_AUX_ENT
>>>       /* AT_NULL is zero; clear the rest too */
>>>       memset(elf_info, 0, (char *)mm->saved_auxv +
>>> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
>>> index c7e502bf5a6f..6991c4b8ab18 100644
>>> --- a/include/uapi/linux/auxvec.h
>>> +++ b/include/uapi/linux/auxvec.h
>>> @@ -30,6 +30,8 @@
>>>                    * differ from AT_PLATFORM. */
>>>   #define AT_RANDOM 25    /* address of 16 random bytes */
>>>   #define AT_HWCAP2 26    /* extension of AT_HWCAP */
>>> +#define AT_RSEQ_FEATURE_SIZE    27    /* rseq supported feature size */
>>> +#define AT_RSEQ_ALIGN        28    /* rseq allocation alignment */
>>>   #define AT_EXECFN  31    /* filename of program */
>>
>> Do we need the alignment?  Or can we keep it perpetually at 32?  Or we
>> could steal some bits from AT_RSEQ_FEATURE_SIZE?  (Not the lower
>> bits—they aren't unused due to the way the feature size works.)
> 
> I cannot imagine a use-case that would require us to bump the alignment 
> requirement over 32 bytes, so we may very well leave it at 32. But 
> perhaps someone else has a better imagination than mine ?

Actually, here is a scenario that warrants exposing the required alignment:

Note that struct rseq is *not* packed.

If we extend struct rseq to a size that makes the compiler use an 
alignment larger than 32 bytes in the future, and if the compiler uses 
that larger alignment knowledge to issue instructions that require the 
larger alignment, then it would be incorrect for user-space to allocate 
the struct rseq on an alignment lower than the required alignment.

Indeed, on rseq registration, we have the following check:

if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq))
[...]
    return -EINVAL;

Which would break if the size of struct rseq is large enough that the 
alignment grows larger than 32 bytes.

You mentioned we could steal some high bits from AT_RSEQ_FEATURE_SIZE to 
put the alignment. What is the issue with exposing an explicit 
AT_RSEQ_ALIGN ? It's just a auxv entry, so I don't see it as a huge 
performance concern to access 2 entries rather than one.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
>>
>> Thanks,
>> Florian
>>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

