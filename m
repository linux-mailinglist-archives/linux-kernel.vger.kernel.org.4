Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1666A9BF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjANGxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjANGx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:53:28 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 056D34695;
        Fri, 13 Jan 2023 22:53:25 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxKupkUcJj_JoBAA--.4960S3;
        Sat, 14 Jan 2023 14:53:24 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxD79hUcJjB04ZAA--.9353S3;
        Sat, 14 Jan 2023 14:53:22 +0800 (CST)
Subject: Re: kernel hangs when kprobe memcpy
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn>
 <19666c03-4bf6-7aac-3f1d-cd31ab7de2d5@loongson.cn>
 <20230112233629.fafdbbe07dddf364f8078df6@kernel.org>
 <d0484b6e-c8a3-65c8-2157-0da95c17b061@loongson.cn>
 <20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b20cfc27-0e46-7e3b-e4f1-2e185ea516ab@loongson.cn>
Date:   Sat, 14 Jan 2023 14:53:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxD79hUcJjB04ZAA--.9353S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gr4xCFW5JrWDtr4rtFW5ZFb_yoW3uF1fp3
        ZrAan8tFs5Jr1rAFy7tw18uFyIvrs7ArWUXr1DCryrA3Wqvrn3JrWIgay5Gry8Wr17KFyI
        vF18t347XFWUAa7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/14/2023 01:38 PM, Masami Hiramatsu (Google) wrote:
> Hi Tiezhu,
>
> On Fri, 13 Jan 2023 14:26:52 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>>
>>
>> On 01/12/2023 10:36 PM, Masami Hiramatsu (Google) wrote:
>>> Hi Tiezhu,
>>>
>>> On Thu, 12 Jan 2023 21:32:51 +0800
>>> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>
>>>>
>>>>
>>>> On 01/11/2023 07:38 PM, Tiezhu Yang wrote:
>>>>> Hi all,
>>>>>
>>>>> (1) I have the following test environment, kernel hangs when kprobe memcpy:
>>>>>
>>>>> system: x86_64 fedora 36
>>>>> kernel version: Linux 5.7 (compile and update)
>>>>> test case: modprobe kprobe_example symbol="memcpy"
>>>>> (CONFIG_SAMPLE_KPROBES=m)
>>>>>
>>>>> In order to fix build errors, it needs to unset CONFIG_NFP and do the
>>>>> following changes:
>>>>> commit 52a9dab6d892 ("libsubcmd: Fix use-after-free for realloc(..., 0)")
>>>>> commit de979c83574a ("x86/entry: Build thunk_$(BITS) only if
>>>>> CONFIG_PREEMPTION=y")
>>>>>
>>>>> (2) Using the latest upstream mainline kernel, no hang problem due to the
>>>>> commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr") to prohibit
>>>>> probing memcpy which is put into the .noinstr.text section.
>>>>>
>>>>>   # modprobe kprobe_example symbol="memcpy"
>>>>>   modprobe: ERROR: could not insert 'kprobe_example': Invalid argument
>>>>>
>>>>> In my opinion, according to the commit message, the above commit is not
>>>>> intended to fix the memcpy hang problem, the problem was fixed by accident.
>>>>>
>>>>> (3) If make handler_pre() and handler_post() as empty functions in the 5.7
>>>>> kernel code, the above hang problem does not exist.
>>>
>>>
>>>>>
>>>>> diff --git a/samples/kprobes/kprobe_example.c
>>>>> b/samples/kprobes/kprobe_example.c
>>>>> index fd346f58ddba..c194171d8a46 100644
>>>>> --- a/samples/kprobes/kprobe_example.c
>>>>> +++ b/samples/kprobes/kprobe_example.c
>>>>> @@ -28,8 +28,6 @@ static struct kprobe kp = {
>>>>>  static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
>>>>>  {
>>>>>  #ifdef CONFIG_X86
>>>>> -    pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
>>>>> -        p->symbol_name, p->addr, regs->ip, regs->flags);
>>>>>  #endif
>>>>>  #ifdef CONFIG_PPC
>>>>>      pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
>>>>> @@ -65,8 +63,6 @@ static void __kprobes handler_post(struct kprobe *p,
>>>>> struct pt_regs *regs,
>>>>>                  unsigned long flags)
>>>>>  {
>>>>>  #ifdef CONFIG_X86
>>>>> -    pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
>>>>> -        p->symbol_name, p->addr, regs->flags);
>>>>>  #endif
>>>>>  #ifdef CONFIG_PPC
>>>>>      pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",
>>>>>
>>>>> I want to know what is the real reason of the hang problem when kprobe
>>>>> memcpy,
>>>>> I guess it may be kprobe recursion, what do you think? Thank you.
>>>>>
>>>>> By the way, kprobe memset has no problem whether or not handler_pre() and
>>>>> handler_post() are empty functions.
>>>>>
>>>>> Thanks,
>>>>> Tiezhu
>>>>
>>>> I find out the following call trace:
>>>>
>>>> handler_pre()
>>>>    pr_info()
>>>>      printk()
>>>>        _printk()
>>>>          vprintk()
>>>>            vprintk_store()
>>>>              memcpy()
>>>>
>>>> I think it may cause recursive exceptions, so we should
>>>> mark memcpy as non-kprobe-able, right?
>>>
>>> Yes, and the .noinstr.text (noinstr function attribute) is including
>>> non-kprobe-able (nokprobe function attribute). I a function is nokprobe
>>> and notrace, it should be noinstr. "NOKPROBE_SYMBOL" is used for the
>>> symbol which is called in the kprobe processing path (e.g. x86 int3
>>> handler etc.).
>>>
>>> BTW, that the bug you reported is interesting. Even if another kprobe
>>> is called inside kprobe pre/post handler, it must be skipped.
>>> If you can share your kconfig, I can try to reproduce it.
>>>
>>> Thank you,
>>>
>>
>> Hi Masami,
>>
>> Thank you very much for your reply.
>>
>> Please use the attached config and diff file, here are the steps
>> to reproduce kernel hangs when kprobe memcpy on x86_64 fedora 36:
>>
>> (1) kernel 5.7
>> $ wget --no-check-certificate
>> https://git.kernel.org/torvalds/t/linux-5.7.tar.gz
>> $ ls
>> 5.7.config  5.7.diff  linux-5.7.tar.gz
>> $ tar xf linux-5.7.tar.gz
>> $ cd linux-5.7/
>> $ patch -p1 < ../5.7.diff
>> $ cp ../5.7.config .config
>> $ make -j8
>> # make modules_install -j8
>> # make install
>> # set the default kernel and reboot
>> # modprobe kprobe_example symbol="memcpy"
>>
>> (2) kernel 6.2-rc1
>> $ wget --no-check-certificate
>> https://git.kernel.org/torvalds/t/linux-6.2-rc1.tar.gz
>> $ ls
>> 6.2-rc1.config  6.2-rc1.diff  linux-6.2-rc1.tar.gz
>> $ tar xf linux-6.2-rc1.tar.gz
>> $ cd linux-6.2-rc1/
>> $ patch -p1 < ../6.2-rc1.diff
>> $ cp ../6.2-rc1.config .config
>> $ make -j8
>> # make modules_install -j8
>> # make install
>> # set the default kernel and reboot
>> # modprobe kprobe_example symbol="memcpy"
>>
>> By the way, I am developing and testing kprobe on LoongArch, I met the
>> same hang problems when probe some symbols, such as (1) handle_syscall,
>> like entry_SYSCALL_64 in arch/x86/entry/entry_64.S, used as syscall
>> exception handler, (2) memcpy, it may cause recursive exceptions like
>> x86.
>
> If you saw that without any change, please report it. At least
> memcpy is already marked as noinstr.

The current upstream mainline kernel has no problem, because it includes
commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr"), memcpy is
already marked as noinstr. But for the kernel without the above commit,
like kernel 5.7, it has problem.

>
>>
>> I do the following changes on LoongArch, could you please take a look
>> whether the code itself and the commit message are proper? Thank you.
>
> Yeah, this direction is good to me.
>

Thank you very much.

>>
>> LoongArch: Mark some assembler symbols as non-kprobe-able
>>
>> Some assembler symbols are not kprobe safe, such as handle_syscall
>> (used as syscall exception handler), *memcpy* (may cause recursive
>> exceptions), they can not be instrumented, just blacklist them for
>> kprobing.
>>
>> diff --git a/arch/loongarch/include/asm/asm.h
>> b/arch/loongarch/include/asm/asm.h
>> index 40eea6aa469e..c51a0914fc99 100644
>> --- a/arch/loongarch/include/asm/asm.h
>> +++ b/arch/loongarch/include/asm/asm.h
>> @@ -188,4 +188,14 @@
>>   #define PTRLOG		3
>>   #endif
>>
>> +/* Annotate a function as being unsuitable for kprobes. */
>> +#ifdef CONFIG_KPROBES
>> +#define ASM_NOKPROBE(name)				\
>
> As same as other archs, can you rename it _ASM_NOKPROBE()?

OK, will modify it in the normal patch.

>
> Others look good to me.

Thanks,
Tiezhu

>
> Thanks!
>
>> +	.pushsection "_kprobe_blacklist", "aw";		\
>> +	.quad	name;					\
>> +	.popsection;
>> +#else
>> +#define ASM_NOKPROBE(name)
>> +#endif
>> +
>>   #endif /* __ASM_ASM_H */
>> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
>> index d53b631c9022..05696bf7b69d 100644
>> --- a/arch/loongarch/kernel/entry.S
>> +++ b/arch/loongarch/kernel/entry.S
>> @@ -67,6 +67,7 @@ SYM_FUNC_START(handle_syscall)
>>
>>   	RESTORE_ALL_AND_RET
>>   SYM_FUNC_END(handle_syscall)
>> +ASM_NOKPROBE(handle_syscall)
>>
>>   SYM_CODE_START(ret_from_fork)
>>   	bl	schedule_tail		# a0 = struct task_struct *prev
>> diff --git a/arch/loongarch/lib/memcpy.S b/arch/loongarch/lib/memcpy.S
>> index 7c07d595ee89..b32dd25ce3a4 100644
>> --- a/arch/loongarch/lib/memcpy.S
>> +++ b/arch/loongarch/lib/memcpy.S
>> @@ -17,6 +17,7 @@ SYM_FUNC_START(memcpy)
>>   	ALTERNATIVE	"b __memcpy_generic", \
>>   			"b __memcpy_fast", CPU_FEATURE_UAL
>>   SYM_FUNC_END(memcpy)
>> +ASM_NOKPROBE(memcpy)
>>
>>   EXPORT_SYMBOL(memcpy)
>>
>> @@ -41,6 +42,7 @@ SYM_FUNC_START(__memcpy_generic)
>>   2:	move	a0, a3
>>   	jr	ra
>>   SYM_FUNC_END(__memcpy_generic)
>> +ASM_NOKPROBE(__memcpy_generic)
>>
>>   /*
>>    * void *__memcpy_fast(void *dst, const void *src, size_t n)
>> @@ -93,3 +95,4 @@ SYM_FUNC_START(__memcpy_fast)
>>   3:	move	a0, a3
>>   	jr	ra
>>   SYM_FUNC_END(__memcpy_fast)
>> +ASM_NOKPROBE(__memcpy_fast)
>>
>> Thanks,
>> Tiezhu
>
>

