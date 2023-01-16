Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F227866BFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjAPNaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjAPNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:30:41 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED6EC1D924;
        Mon, 16 Jan 2023 05:30:33 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxIfB3UcVjDOABAA--.6085S3;
        Mon, 16 Jan 2023 21:30:31 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxjb50UcVjM0IaAA--.53573S3;
        Mon, 16 Jan 2023 21:30:28 +0800 (CST)
Subject: Re: kernel hangs when kprobe memcpy
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn>
 <19666c03-4bf6-7aac-3f1d-cd31ab7de2d5@loongson.cn>
 <20230112233629.fafdbbe07dddf364f8078df6@kernel.org>
 <d0484b6e-c8a3-65c8-2157-0da95c17b061@loongson.cn>
 <20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org>
 <b20cfc27-0e46-7e3b-e4f1-2e185ea516ab@loongson.cn>
 <20230116154123.a0ff8d6deaff3fe87b48461b@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e125edc7-9d01-04aa-4527-26fb7d282e64@loongson.cn>
Date:   Mon, 16 Jan 2023 21:30:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230116154123.a0ff8d6deaff3fe87b48461b@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bxjb50UcVjM0IaAA--.53573S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Cw18GF1UZry3Gw17ZF15CFg_yoWDtr47pF
        4DG3W5tF4rJrn5ZF9Fqw18AFyIyr4xArWUXr1kGryFyF1qq3s8Jr4Ig3yUKr4kWr109w1a
        yF18tFy7G3y7JaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jFa0PUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/16/2023 02:41 PM, Masami Hiramatsu (Google) wrote:
> Hi Tiezhu,
>
> On Sat, 14 Jan 2023 14:53:21 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>>
>>
>> On 01/14/2023 01:38 PM, Masami Hiramatsu (Google) wrote:
>>> Hi Tiezhu,
>>>
>>> On Fri, 13 Jan 2023 14:26:52 +0800
>>> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>
>>>>
>>>>
>>>> On 01/12/2023 10:36 PM, Masami Hiramatsu (Google) wrote:
>>>>> Hi Tiezhu,
>>>>>
>>>>> On Thu, 12 Jan 2023 21:32:51 +0800
>>>>> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>> On 01/11/2023 07:38 PM, Tiezhu Yang wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> (1) I have the following test environment, kernel hangs when kprobe memcpy:
>>>>>>>
>>>>>>> system: x86_64 fedora 36
>>>>>>> kernel version: Linux 5.7 (compile and update)
>>>>>>> test case: modprobe kprobe_example symbol="memcpy"
>>>>>>> (CONFIG_SAMPLE_KPROBES=m)
>>>>>>>
>>>>>>> In order to fix build errors, it needs to unset CONFIG_NFP and do the
>>>>>>> following changes:
>>>>>>> commit 52a9dab6d892 ("libsubcmd: Fix use-after-free for realloc(..., 0)")
>>>>>>> commit de979c83574a ("x86/entry: Build thunk_$(BITS) only if
>>>>>>> CONFIG_PREEMPTION=y")
>>>>>>>
>>>>>>> (2) Using the latest upstream mainline kernel, no hang problem due to the
>>>>>>> commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr") to prohibit
>>>>>>> probing memcpy which is put into the .noinstr.text section.
>>>>>>>
>>>>>>>   # modprobe kprobe_example symbol="memcpy"
>>>>>>>   modprobe: ERROR: could not insert 'kprobe_example': Invalid argument
>>>>>>>
>>>>>>> In my opinion, according to the commit message, the above commit is not
>>>>>>> intended to fix the memcpy hang problem, the problem was fixed by accident.
>>>>>>>
>>>>>>> (3) If make handler_pre() and handler_post() as empty functions in the 5.7
>>>>>>> kernel code, the above hang problem does not exist.
>>>>>
>>>>>
>>>>>>>
>>>>>>> diff --git a/samples/kprobes/kprobe_example.c
>>>>>>> b/samples/kprobes/kprobe_example.c
>>>>>>> index fd346f58ddba..c194171d8a46 100644
>>>>>>> --- a/samples/kprobes/kprobe_example.c
>>>>>>> +++ b/samples/kprobes/kprobe_example.c
>>>>>>> @@ -28,8 +28,6 @@ static struct kprobe kp = {
>>>>>>>  static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
>>>>>>>  {
>>>>>>>  #ifdef CONFIG_X86
>>>>>>> -    pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
>>>>>>> -        p->symbol_name, p->addr, regs->ip, regs->flags);
>>>>>>>  #endif
>>>>>>>  #ifdef CONFIG_PPC
>>>>>>>      pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
>>>>>>> @@ -65,8 +63,6 @@ static void __kprobes handler_post(struct kprobe *p,
>>>>>>> struct pt_regs *regs,
>>>>>>>                  unsigned long flags)
>>>>>>>  {
>>>>>>>  #ifdef CONFIG_X86
>>>>>>> -    pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
>>>>>>> -        p->symbol_name, p->addr, regs->flags);
>>>>>>>  #endif
>>>>>>>  #ifdef CONFIG_PPC
>>>>>>>      pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",
>>>>>>>
>>>>>>> I want to know what is the real reason of the hang problem when kprobe
>>>>>>> memcpy,
>>>>>>> I guess it may be kprobe recursion, what do you think? Thank you.
>>>>>>>
>>>>>>> By the way, kprobe memset has no problem whether or not handler_pre() and
>>>>>>> handler_post() are empty functions.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Tiezhu
>>>>>>
>>>>>> I find out the following call trace:
>>>>>>
>>>>>> handler_pre()
>>>>>>    pr_info()
>>>>>>      printk()
>>>>>>        _printk()
>>>>>>          vprintk()
>>>>>>            vprintk_store()
>>>>>>              memcpy()
>>>>>>
>>>>>> I think it may cause recursive exceptions, so we should
>>>>>> mark memcpy as non-kprobe-able, right?
>>>>>
>>>>> Yes, and the .noinstr.text (noinstr function attribute) is including
>>>>> non-kprobe-able (nokprobe function attribute). I a function is nokprobe
>>>>> and notrace, it should be noinstr. "NOKPROBE_SYMBOL" is used for the
>>>>> symbol which is called in the kprobe processing path (e.g. x86 int3
>>>>> handler etc.).
>>>>>
>>>>> BTW, that the bug you reported is interesting. Even if another kprobe
>>>>> is called inside kprobe pre/post handler, it must be skipped.
>>>>> If you can share your kconfig, I can try to reproduce it.
>>>>>
>>>>> Thank you,
>>>>>
>>>>
>>>> Hi Masami,
>>>>
>>>> Thank you very much for your reply.
>>>>
>>>> Please use the attached config and diff file, here are the steps
>>>> to reproduce kernel hangs when kprobe memcpy on x86_64 fedora 36:
>>>>
>>>> (1) kernel 5.7
>>>> $ wget --no-check-certificate
>>>> https://git.kernel.org/torvalds/t/linux-5.7.tar.gz
>>>> $ ls
>>>> 5.7.config  5.7.diff  linux-5.7.tar.gz
>>>> $ tar xf linux-5.7.tar.gz
>>>> $ cd linux-5.7/
>>>> $ patch -p1 < ../5.7.diff
>>>> $ cp ../5.7.config .config
>>>> $ make -j8
>>>> # make modules_install -j8
>>>> # make install
>>>> # set the default kernel and reboot
>>>> # modprobe kprobe_example symbol="memcpy"
>>>>
>>>> (2) kernel 6.2-rc1
>>>> $ wget --no-check-certificate
>>>> https://git.kernel.org/torvalds/t/linux-6.2-rc1.tar.gz
>>>> $ ls
>>>> 6.2-rc1.config  6.2-rc1.diff  linux-6.2-rc1.tar.gz
>>>> $ tar xf linux-6.2-rc1.tar.gz
>>>> $ cd linux-6.2-rc1/
>>>> $ patch -p1 < ../6.2-rc1.diff
>>>> $ cp ../6.2-rc1.config .config
>>>> $ make -j8
>>>> # make modules_install -j8
>>>> # make install
>>>> # set the default kernel and reboot
>>>> # modprobe kprobe_example symbol="memcpy"
>>>>
>>>> By the way, I am developing and testing kprobe on LoongArch, I met the
>>>> same hang problems when probe some symbols, such as (1) handle_syscall,
>>>> like entry_SYSCALL_64 in arch/x86/entry/entry_64.S, used as syscall
>>>> exception handler, (2) memcpy, it may cause recursive exceptions like
>>>> x86.
>>>
>>> If you saw that without any change, please report it. At least
>>> memcpy is already marked as noinstr.
>>
>> The current upstream mainline kernel has no problem, because it includes
>> commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr"), memcpy is
>> already marked as noinstr. But for the kernel without the above commit,
>> like kernel 5.7, it has problem.
>
> I've confirmed that kernel 5.4.228 (the latest stable tree) did not have
> this issue (it already rejects the memcpy). Since 5.7 is not a stable
> (maintained) tree, we can not send a patch to it.
> Anyway, it is better to add a test case for the recursed probe function.
> I made a patch below. Can your loongarch port pass this test case?

Yes, test_kprobes passed on LoongArch.

Without this patch:

[   58.536879]     KTAP version 1
[   58.536892]     # Subtest: kprobes_test
[   58.536895]     1..4
[   58.550235]     ok 1 test_kprobe
[   58.574234]     ok 2 test_kprobes
[   58.606237]     ok 3 test_kretprobe
[   58.630234]     ok 4 test_kretprobes
[   58.630237] # kprobes_test: pass:4 fail:0 skip:0 total:4
[   58.630240] # Totals: pass:4 fail:0 skip:0 total:4
[   58.630242] ok 1 kprobes_test

With this patch:

[   21.800697]     KTAP version 1
[   21.800710]     # Subtest: kprobes_test
[   21.800713]     1..5
[   21.818189]     ok 1 test_kprobe
[   21.838188]     ok 2 test_kprobes
[   21.858189]     ok 3 test_kprobe_missed
[   21.878190]     ok 4 test_kretprobe
[   21.898189]     ok 5 test_kretprobes
[   21.898192] # kprobes_test: pass:5 fail:0 skip:0 total:5
[   21.898195] # Totals: pass:5 fail:0 skip:0 total:5
[   21.898197] ok 1 kprobes_test

Thanks,
Tiezhu

>
> Thank you,
>
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Mon, 16 Jan 2023 15:19:52 +0900
> Subject: [PATCH] test_kprobes: Add recursed kprobe test case
>
> Add a recursed kprobe test case to the KUnit test module for kprobes.
> This will probe a function which is called from the pre_handler and
> post_handler itself. If the kprobe is correctly implemented, the recursed
> kprobe handlers will be skipped and the number of skipped kprobe will
> be counted on kprobe::nmissed.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  lib/test_kprobes.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/lib/test_kprobes.c b/lib/test_kprobes.c
> index 1c95e5719802..0648f7154f5c 100644
> --- a/lib/test_kprobes.c
> +++ b/lib/test_kprobes.c
> @@ -14,6 +14,7 @@
>
>  static u32 rand1, preh_val, posth_val;
>  static u32 (*target)(u32 value);
> +static u32 (*recursed_target)(u32 value);
>  static u32 (*target2)(u32 value);
>  static struct kunit *current_test;
>
> @@ -27,18 +28,27 @@ static noinline u32 kprobe_target(u32 value)
>  	return (value / div_factor);
>  }
>
> +static noinline u32 kprobe_recursed_target(u32 value)
> +{
> +	return (value / div_factor);
> +}
> +
>  static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  {
>  	KUNIT_EXPECT_FALSE(current_test, preemptible());
> -	preh_val = (rand1 / div_factor);
> +
> +	preh_val = recursed_target(rand1);
>  	return 0;
>  }
>
>  static void kp_post_handler(struct kprobe *p, struct pt_regs *regs,
>  		unsigned long flags)
>  {
> +	u32 expval = recursed_target(rand1);
> +
>  	KUNIT_EXPECT_FALSE(current_test, preemptible());
> -	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor));
> +	KUNIT_EXPECT_EQ(current_test, preh_val, expval);
> +
>  	posth_val = preh_val + div_factor;
>  }
>
> @@ -136,6 +146,29 @@ static void test_kprobes(struct kunit *test)
>  	unregister_kprobes(kps, 2);
>  }
>
> +static struct kprobe kp_missed = {
> +	.symbol_name = "kprobe_recursed_target",
> +	.pre_handler = kp_pre_handler,
> +	.post_handler = kp_post_handler,
> +};
> +
> +static void test_kprobe_missed(struct kunit *test)
> +{
> +	current_test = test;
> +	preh_val = 0;
> +	posth_val = 0;
> +
> +	KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp_missed));
> +
> +	recursed_target(rand1);
> +
> +	KUNIT_EXPECT_EQ(test, 2, kp_missed.nmissed);
> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> +	KUNIT_EXPECT_NE(test, 0, posth_val);
> +
> +	unregister_kprobe(&kp_missed);
> +}
> +
>  #ifdef CONFIG_KRETPROBES
>  static u32 krph_val;
>
> @@ -336,6 +369,7 @@ static int kprobes_test_init(struct kunit *test)
>  {
>  	target = kprobe_target;
>  	target2 = kprobe_target2;
> +	recursed_target = kprobe_recursed_target;
>  	stacktrace_target = kprobe_stacktrace_target;
>  	internal_target = kprobe_stacktrace_internal_target;
>  	stacktrace_driver = kprobe_stacktrace_driver;
> @@ -346,6 +380,7 @@ static int kprobes_test_init(struct kunit *test)
>  static struct kunit_case kprobes_testcases[] = {
>  	KUNIT_CASE(test_kprobe),
>  	KUNIT_CASE(test_kprobes),
> +	KUNIT_CASE(test_kprobe_missed),
>  #ifdef CONFIG_KRETPROBES
>  	KUNIT_CASE(test_kretprobe),
>  	KUNIT_CASE(test_kretprobes),
>

