Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DE601331
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJQQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiJQQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:08:48 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A5BC1C;
        Mon, 17 Oct 2022 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1666022926;
        bh=+lKaN0IItvWWonqQbCbMsOdeZs7HD01F0Idpk78NBgY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XTyWWNOOsn8qb6BdeR9QHdBRXY02MjXILSKXlObhomvEJisXz2TOdavvX4mBJRdN2
         4XEIUX1aBa9A0d8xDu7Ba79yr/OwypG7TLbOK7xZb42ru1rT6zOGK2u9JyQtrJ5iqQ
         ThS7ReFu3SbGH+51txRTq7GAJpKc9I2DhVeVkDl9F/s+OWpsvf+0l0IKDMQfMlLxx6
         jtluX97FfPbk+henZVxgSgucrN2B0ZqFrh+Ht45oea2FJHKhQoKqVnO+i990ZwpoJC
         njmz2EarWNvn/VTNDfNzF9mmg3SY14BtxymhtSzh1NDC7CjrK9IzNn8Uf3NAlbaRjj
         g9jnvFc1OjLVw==
Received: from [172.16.0.72] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MrhkQ1dwWzV0k;
        Mon, 17 Oct 2022 12:08:46 -0400 (EDT)
Message-ID: <d128fb7d-6b24-5caf-8e3a-99d55922cd95@efficios.com>
Date:   Mon, 17 Oct 2022 12:09:03 -0400
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <877d1726kd.fsf@oldenburg.str.redhat.com>
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

On 2022-10-10 08:42, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> Export the rseq feature size supported by the kernel as well as the
>> required allocation alignment for the rseq per-thread area to user-space
>> through ELF auxiliary vector entries.
>>
>> This is part of the extensible rseq ABI.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>>   fs/binfmt_elf.c             | 5 +++++
>>   include/uapi/linux/auxvec.h | 2 ++
>>   include/uapi/linux/rseq.h   | 5 +++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 63c7ebb0da89..04fca1e4cbd2 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -46,6 +46,7 @@
>>   #include <linux/cred.h>
>>   #include <linux/dax.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/rseq.h>
>>   #include <asm/param.h>
>>   #include <asm/page.h>
>>   
>> @@ -288,6 +289,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>>   	if (bprm->have_execfd) {
>>   		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
>>   	}
>> +#ifdef CONFIG_RSEQ
>> +	NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
>> +	NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
>> +#endif
>>   #undef NEW_AUX_ENT
>>   	/* AT_NULL is zero; clear the rest too */
>>   	memset(elf_info, 0, (char *)mm->saved_auxv +
>> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
>> index c7e502bf5a6f..6991c4b8ab18 100644
>> --- a/include/uapi/linux/auxvec.h
>> +++ b/include/uapi/linux/auxvec.h
>> @@ -30,6 +30,8 @@
>>   				 * differ from AT_PLATFORM. */
>>   #define AT_RANDOM 25	/* address of 16 random bytes */
>>   #define AT_HWCAP2 26	/* extension of AT_HWCAP */
>> +#define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
>> +#define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
>>   
>>   #define AT_EXECFN  31	/* filename of program */
> 
> Do we need the alignment?  Or can we keep it perpetually at 32?  Or we
> could steal some bits from AT_RSEQ_FEATURE_SIZE?  (Not the lower
> bits—they aren't unused due to the way the feature size works.)

I cannot imagine a use-case that would require us to bump the alignment 
requirement over 32 bytes, so we may very well leave it at 32. But 
perhaps someone else has a better imagination than mine ?

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

