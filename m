Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD16A014C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjBWCtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjBWCtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:49:05 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3103C3A841;
        Wed, 22 Feb 2023 18:48:53 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxttgU1PZjkPMDAA--.7504S3;
        Thu, 23 Feb 2023 10:48:52 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax97wQ1PZjL2E5AA--.38714S3;
        Thu, 23 Feb 2023 10:48:48 +0800 (CST)
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Check
 __ARCH_WANT_SET_GET_RLIMIT before syscall(__NR_getrlimit)
To:     Mykola Lysenko <mykolal@meta.com>
References: <1677066908-15224-1-git-send-email-yangtiezhu@loongson.cn>
 <1677066908-15224-4-git-send-email-yangtiezhu@loongson.cn>
 <CAADnVQLLborN3ABxRPUhSL5jQ1XcWNM9DBfjaEbvnF9qdE_CJA@mail.gmail.com>
 <D90B1D7B-8B75-4790-8D09-1106240B2377@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f8d8f114-2fa7-f6da-7c99-b72fcf8b106f@loongson.cn>
Date:   Thu, 23 Feb 2023 10:48:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <D90B1D7B-8B75-4790-8D09-1106240B2377@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Ax97wQ1PZjL2E5AA--.38714S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJF4rtr4xZr48Xw1DWFyrCrg_yoWrWryfpa
        yfta42yF4SyF17tw17Kr4xZrySqrZrAF4FkF18Jr95Zw1UZ3saqF1IgF4Fgr9Igr95tr4S
        v34UKasa9r4UA37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2023 04:03 AM, Mykola Lysenko wrote:
> Hi Tiezhu,
>
> You can run BPF CI tests on your patch before sending it out by following these instructions:
> https://docs.kernel.org/bpf/bpf_devel_QA.html#q-how-do-i-run-bpf-ci-on-my-changes-before-sending-them-out-for-review

OK, thank you.

After commit 80d7da1cac62 ("asm-generic: Drop getrlimit and setrlimit
syscalls from default list"), new architectures won't need to include
getrlimit and setrlimit, they are superseded with prlimit64.

In order to maintain compatibility for the new architectures, such as
LoongArch which does not define __NR_getrlimit, it is better to use
__NR_prlimit64 instead of __NR_getrlimit in user_ringbuf.c to fix the
build error.

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c 
b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index 3a13e10..e51721d 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -590,7 +590,7 @@ static void *kick_kernel_cb(void *arg)
         /* Kick the kernel, causing it to drain the ring buffer and 
then wake
          * up the test thread waiting on epoll.
          */
-       syscall(__NR_getrlimit);
+       syscall(__NR_prlimit64);

         return NULL;
  }

I will test it and then send v2. If you have more suggestions,
please let me know.

Thanks,
Tiezhu

>
> Thanks,
> Mykola
>
>> On Feb 22, 2023, at 10:06 AM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  This Message Is From an External Sender
>>
>> |-------------------------------------------------------------------!
>>
>> On Wed, Feb 22, 2023 at 3:55 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>
>>> __NR_getrlimit is defined only if __ARCH_WANT_SET_GET_RLIMIT is defined:
>>>
>>>  #ifdef __ARCH_WANT_SET_GET_RLIMIT
>>>  /* getrlimit and setrlimit are superseded with prlimit64 */
>>>  #define __NR_getrlimit 163
>>>  ...
>>>  #endif
>>>
>>> Some archs do not define __ARCH_WANT_SET_GET_RLIMIT, it should check
>>> __ARCH_WANT_SET_GET_RLIMIT before syscall(__NR_getrlimit) to fix the
>>> following build error:
>>>
>>>    TEST-OBJ [test_progs] user_ringbuf.test.o
>>>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c: In function 'kick_kernel_cb':
>>>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:593:17: error: '__NR_getrlimit' undeclared (first use in this function)
>>>    593 |         syscall(__NR_getrlimit);
>>>        |                 ^~~~~~~~~~~~~~
>>>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:593:17: note: each undeclared identifier is reported only once for each function it appears in
>>>  make: *** [Makefile:573: tools/testing/selftests/bpf/user_ringbuf.test.o] Error 1
>>>  make: Leaving directory 'tools/testing/selftests/bpf'
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>> tools/testing/selftests/bpf/prog_tests/user_ringbuf.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>>> index 3a13e10..0550307 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>>> @@ -590,7 +590,9 @@ static void *kick_kernel_cb(void *arg)
>>>        /* Kick the kernel, causing it to drain the ring buffer and then wake
>>>         * up the test thread waiting on epoll.
>>>         */
>>> +#ifdef __ARCH_WANT_SET_GET_RLIMIT
>>>        syscall(__NR_getrlimit);
>>> +#endif
>>
>> This is clearly breaks user_ringbuf test on x86:
>> https://github.com/kernel-patches/bpf/actions/runs/4242660318/jobs/7374845859
>>
>> Please do not send patches that make selftest compile on your favorite arch.
>> Make sure the patches work correctly on other archs too.

