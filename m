Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F436992F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjBPLTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBPLTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:19:03 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F8403346F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:19:02 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8BxNNgkEe5jxU4BAA--.2231S3;
        Thu, 16 Feb 2023 19:19:00 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axvr4hEe5j3ow0AA--.37035S3;
        Thu, 16 Feb 2023 19:18:57 +0800 (CST)
Subject: Re: [PATCH v4 2/5] LoongArch: Use la.pcrel instead of la.abs for
 exception handlers
To:     Xi Ruoyao <xry111@xry111.site>, Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
References: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
 <1676018856-26520-3-git-send-email-tangyouling@loongson.cn>
 <CAAhV-H4Bs5n_ek3mq6zwxAgVw0nvER1XUA+WUA8M12eKcYVPDQ@mail.gmail.com>
 <05ef2d91-ab87-b8d9-85fa-6a90a92f8f39@loongson.cn>
 <848e2985-9ba3-c14d-23ac-a7f1c218215f@loongson.cn>
 <5adf0fc4-b75c-f7f2-311c-0f5d8f14311b@loongson.cn>
 <48c4b1f81c21950e9fd46d4acb5196d979b147cb.camel@xry111.site>
 <295efdc0-388e-cda4-120c-5f9c4740b208@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin lv <lvjianmin@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <33b173e4-d61d-5f43-b2f2-d96ec2897361@loongson.cn>
Date:   Thu, 16 Feb 2023 19:18:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <295efdc0-388e-cda4-120c-5f9c4740b208@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Axvr4hEe5j3ow0AA--.37035S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuryfCF1fZFWDXr1ftr15twb_yoWrGw4DpF
        W29a4vqF45Grn3Aa1DJ3ykZry5tanrWw4agF9rKFy8Zay29r1rtFykC3srZ3WDGa10ka1S
        qFyYqasFvF45AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bO8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
        0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE
        44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26rWlOx8S6xCaFVCjc4
        AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vI
        r41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7xRE6wZ7
        UUUUU==
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/16/2023 04:03 PM, Youling Tang wrote:
>
>
> On 02/16/2023 03:10 PM, Xi Ruoyao wrote:
>> On Thu, 2023-02-16 at 14:59 +0800, Jinyang He wrote:
>>> +.macro la.abs reg, sym
>>> +766:
>>> +    nop
>>> +    nop
>>> +    nop
>>> +    nop
>>
>> In the "formal" version we can code
>>
>> lu12i.w        reg, 0
>> ori        reg, reg, 0
>> lu32i.d        reg, 0
>> lu52i.d        reg, reg, 0
>>
>> here.  Then we only need to fixup the immediate slot so we can avoid
>> using parse_r.
>>
>>
>>> +    .pushsection ".laabs", "aw", %progbits
>>> +768:
>>> +    .word 768b-766b
>>> +    parse_r regno, \reg
>>> +    .word regno
>>> +    .dword \sym
>>> +    .popsection
>>> +.endm
>
> I will try to modify a version for testing, using the following
> definition, when the RELOCATABLE is turned on, the "la.abs macro" is
> used, otherwise the "la.abs pseudo instruction" is still used as before.
>
> #ifdef CONFIG_RELOCATABLE
> .macro la.abs reg, sym
> lu12i.w        reg, 0
> ori        reg, reg, 0
> lu32i.d        reg, 0
> lu52i.d        reg, reg, 0
> .endm
> #endif

On the basis of the v4 patch set, remove patch2, and then add the 
following patches, and the test is successful on qemu.

If this method is more acceptable to everyone, I will send v5.

diff --git a/arch/loongarch/include/asm/asmmacro.h 
b/arch/loongarch/include/asm/asmmacro.h
index 328bb956f241..adb04ae6b208 100644
--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -667,4 +667,19 @@
         nor     \dst, \src, zero
  .endm

+#ifdef CONFIG_RELOCATABLE
+.macro la.abs reg, sym
+766:
+       lu12i.w \reg, 0
+       ori     \reg, \reg, 0
+       lu32i.d \reg, 0
+       lu52i.d \reg, \reg, 0
+       .pushsection ".laabs", "aw", %progbits
+768:
+       .dword 768b-766b
+       .dword \sym
+       .popsection
+.endm
+#endif
+
  #endif /* _ASM_ASMMACRO_H */
diff --git a/arch/loongarch/kernel/relocate.c 
b/arch/loongarch/kernel/relocate.c
index 7d19cc0d2185..7ad327a554f9 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -12,6 +12,7 @@
  #include <linux/start_kernel.h>
  #include <asm/bootinfo.h>
  #include <asm/early_ioremap.h>
+#include <asm/inst.h>
  #include <asm/sections.h>

  #define RELOCATED(x) ((void *)((long)x + reloc_offset))
@@ -45,6 +46,32 @@ static inline __init void relocate_relative(void)
         }
  }

+static inline void __init relocate_laabs(long offset)
+{
+       extern void *__laabs_begin;
+       extern void *__laabs_end;
+       struct laabs {
+               long offset;
+               long symvalue;
+       } *p;
+
+       for (p = (void *)&__laabs_begin; (void *)p < (void 
*)&__laabs_end; p++) {
+               long v = p->symvalue + reloc_offset;
+               union loongarch_instruction *insn = (void *)p - 
p->offset + offset;
+               u32 lu12iw, ori, lu32id, lu52id;
+
+               lu12iw = (v >> 12) & 0xfffff;
+               ori = v & 0xfff;
+               lu32id = (v >> 32) & 0xfffff;
+               lu52id = v >> 52;
+
+               insn[0].reg1i20_format.immediate = lu12iw;
+               insn[1].reg2i12_format.immediate = ori;
+               insn[2].reg1i20_format.immediate = lu32id;
+               insn[3].reg2i12_format.immediate = lu52id;
+    }
+}
+
  #ifdef CONFIG_RANDOMIZE_BASE
  static inline __init unsigned long rotate_xor(unsigned long hash,
                                               const void *area, size_t 
size)
@@ -168,8 +195,10 @@ void *__init do_kaslr(void)
                 update_reloc_offset(&reloc_offset, offset);
         }

-       if (reloc_offset)
+       if (reloc_offset) {
                 relocate_relative();
+               relocate_laabs(offset);
+       }

         return kernel_entry;
  }
@@ -181,6 +210,8 @@ void __init relocate_kernel(void)

         if (reloc_offset)
                 relocate_relative();
+
+       relocate_laabs(0);
  }

  /*
diff --git a/arch/loongarch/kernel/vmlinux.lds.S 
b/arch/loongarch/kernel/vmlinux.lds.S
index aec0b6567d24..0e58c68bf427 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -66,6 +66,13 @@ SECTIONS
                 __alt_instructions_end = .;
         }

+       . = ALIGN(8);
+       .laabs : AT(ADDR(.laabs) - LOAD_OFFSET) {
+               __laabs_begin = .;
+               *(.laabs)
+               __laabs_end = .;
+       }
+
         .got : ALIGN(16) { *(.got) }


Youling.

