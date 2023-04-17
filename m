Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B913A6E437C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDQJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDQJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:19:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E46B14492
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:19:02 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Axz_8FDz1k2+AdAA--.46266S3;
        Mon, 17 Apr 2023 17:19:01 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxur0DDz1kGKMqAA--.50497S3;
        Mon, 17 Apr 2023 17:19:00 +0800 (CST)
Subject: Re: [PATCH v2 4/4] LoongArch: Add uprobes support
To:     Youling Tang <tangyouling@loongson.cn>
References: <1681464781-4428-1-git-send-email-yangtiezhu@loongson.cn>
 <1681464781-4428-5-git-send-email-yangtiezhu@loongson.cn>
 <26d4d13f-d678-be54-6b40-b87c71856eff@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <6cadd23c-6aca-a0f6-f862-a6b23b5c7d0a@loongson.cn>
Date:   Mon, 17 Apr 2023 17:18:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <26d4d13f-d678-be54-6b40-b87c71856eff@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxur0DDz1kGKMqAA--.50497S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ar1ktF1xtr1rZr48Kw1xKrg_yoW8WF17pF
        WDCFWUGFZ5GFn5JFyDX39a9F12qr95Gr4Ik3W2yayrAF42vrn3ur1kursrJa4jy390qr40
        gFy8tayF9ay5tF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/17/2023 10:04 AM, Youling Tang wrote:
> Hi, Tiezhu
>
> On 04/14/2023 05:33 PM, Tiezhu Yang wrote:
>
> /* snip */
>
>> diff --git a/arch/loongarch/kernel/traps.c
>> b/arch/loongarch/kernel/traps.c
>> index de8ebe2..cfc2e0c 100644
>> --- a/arch/loongarch/kernel/traps.c
>> +++ b/arch/loongarch/kernel/traps.c
>> @@ -45,6 +45,7 @@
>>  #include <asm/tlb.h>
>>  #include <asm/types.h>
>>  #include <asm/unwind.h>
>> +#include <asm/uprobes.h>
>>
>>  #include "access-helper.h"
>>
>> @@ -440,7 +441,6 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>>      if (regs->csr_prmd & CSR_PRMD_PIE)
>>          local_irq_enable();
>>
>> -    current->thread.trap_nr = read_csr_excode();
>>      if (__get_inst(&opcode, (u32 *)era, user))
>>          goto out_sigsegv;
>>
>> @@ -462,18 +462,17 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>>          else
>>              break;
>>      case BRK_UPROBE_BP:
>> -        if (notify_die(DIE_UPROBE, "Uprobe", regs, bcode,
>> -                   current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
>> +        if (uprobe_breakpoint_handler(regs))
>>              goto out;
>>          else
>>              break;
>>      case BRK_UPROBE_XOLBP:
>> -        if (notify_die(DIE_UPROBE_XOL, "Uprobe_XOL", regs, bcode,
>> -                   current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
>> +        if (uprobe_singlestep_handler(regs))
>
> After the above modification, we should remove the DIE_UPROBE and
> DIE_UPROBE_XOL definitions in arch/loongarch/include/asm/kdebug.h.
>
> At the same time DIE_BREAK, DIE_SSTEPBP and DIE_PAGE_FAULT also need to
> be removed after 6d4cc40fb5f581 ("LoongArch: Add kprobes support").
>

OK, thank you, will do it.

Thanks,
Tiezhu

