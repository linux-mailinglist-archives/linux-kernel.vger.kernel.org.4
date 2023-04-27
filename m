Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255CA6F0107
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbjD0GsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjD0GsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:48:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ABEA2D76;
        Wed, 26 Apr 2023 23:48:01 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8Bx7eqfGkpk9XABAA--.2494S3;
        Thu, 27 Apr 2023 14:47:59 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxsrSZGkpkNDo+AA--.18663S3;
        Thu, 27 Apr 2023 14:47:54 +0800 (CST)
Subject: Re: [PATCH v2 5/5] LoongArch: Abstract DYNAMIC_FTRACE_WITH_ARGS
 accesses
To:     Enze Li <lienze@kylinos.cn>
References: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
 <1682561552-32324-6-git-send-email-tangyouling@loongson.cn>
 <87h6t17sux.fsf@kylinos.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <b52aff74-17a6-3a91-62b3-d11477645e81@loongson.cn>
Date:   Thu, 27 Apr 2023 14:47:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <87h6t17sux.fsf@kylinos.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxsrSZGkpkNDo+AA--.18663S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZrW3uFW8ZFy7WFyDXr15XFb_yoW5Zr1xpF
        Zak3Z8GFW7AFZ2kF429w45XryrJryrJry8Cr92kw13AFyDXr1kGrW29ryqkF1jyry8JryI
        vF1Yqwnxurn0va7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bsAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        WrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7xRiTKZJUU
        UUU==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enze

On 04/27/2023 02:16 PM, Enze Li wrote:
> On Thu, Apr 27 2023 at 10:12:32 AM +0800, Youling Tang wrote:
>
>> From: Qing Zhang <zhangqing@loongson.cn>
>>
>> 1. Adds new ftrace_regs_{get,set}_*() helpers which can be used to manipulate
>> ftrace_regs. When CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y, these can always
>> be used on any ftrace_regs, and when CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n
>> these can be used when regs are available. A new ftrace_regs_has_args(fregs)
>> helper is added which code can use to check when these are usable.
>>
>> 2. Prepare ftrace_regs_set_instruction_pointer support in advance.
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>  arch/loongarch/include/asm/ftrace.h | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
>> index f789e680f633..30ee01243416 100644
>> --- a/arch/loongarch/include/asm/ftrace.h
>> +++ b/arch/loongarch/include/asm/ftrace.h
>> @@ -54,6 +54,31 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
>>  	return &fregs->regs;
>>  }
>>
>> +static __always_inline void
>> +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>> +				    unsigned long ip)
>> +{
>> +	regs_set_return_value(&fregs->regs, ip);
>> +}
>> +
>> +static __always_inline unsigned long
>> +ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
>> +{
>> +	return instruction_pointer(&fregs->regs);
>> +}
>> +
>> +#define ftrace_regs_get_argument(fregs, n) \
>> +	regs_get_kernel_argument(&(fregs)->regs, n)
>> +#define ftrace_regs_get_stack_pointer(fregs) \
>> +	kernel_stack_pointer(&(fregs)->regs)
>> +#define ftrace_regs_return_value(fregs) \
>> +	regs_return_value(&(fregs)->regs)
>> +#define ftrace_regs_set_return_value(fregs, ret) \
>
> Hi Youling,
>
>> +	regs_set_return_value(&(fregs)->regs, ret)
>        ^^^^^^^^^^^^^^^^^^^^^^^^
> I can not find the implementation of this function, am I missing
> something?
Note: This patch depends on regs_set_return_value() in the patch
"LoongArch: Add support for function error injection".

https://github.com/chenhuacai/linux/commit/c78e80c75b98feeb02b9a6eefb9de759f9036f42

>
>> +#define ftrace_override_function_with_return(fregs) \
>> +	override_function_with_return(&(fregs)->regs)
>> +#define ftrace_regs_query_register_offset(name) \
>                                                  ^^^^^^
> There seems to be a missing function here.  Otherwise, the backslash
> should be redundant.  Did I understand correctly?
Sorry for my oversight.

ftrace_regs_query_register_offset() will reuse
regs_query_register_offset(), I will modify it as follows,

#define ftrace_regs_query_register_offset(name) \
          regs_query_register_offset(name)

Thanks,
Youling.
>
> Best Regards,
> Enze
>
>> +
>>  #define ftrace_graph_func ftrace_graph_func
>>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>>  		       struct ftrace_ops *op, struct ftrace_regs *fregs);

