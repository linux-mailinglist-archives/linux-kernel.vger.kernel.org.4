Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A2A736634
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjFTI3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjFTI3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:29:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DC7C1B0;
        Tue, 20 Jun 2023 01:29:19 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.100.1])
        by gateway (Coremail) with SMTP id _____8Bx7epeY5FksyAHAA--.14670S3;
        Tue, 20 Jun 2023 16:29:18 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.100.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeRZY5Fkd3MhAA--.28519S3;
        Tue, 20 Jun 2023 16:29:14 +0800 (CST)
Subject: Re: [RFC PATCH v1 00/23] LoongArch: Add objtool and ORC unwinder
 support
To:     Xi Ruoyao <xry111@xry111.site>
References: <1687247209-31676-1-git-send-email-tangyouling@loongson.cn>
 <bed4d386c16701d14a2ea395edeb0368cb3d04ad.camel@xry111.site>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        madvenka@linux.microsoft.com, chenzhongjin@huawei.com,
        WANG Xuerui <kernel@xen0n.name>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        tangyouling00@gmail.com, youling.tang@outlook.com
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <62d25870-2caa-18ab-e58c-cee0bc383e16@loongson.cn>
Date:   Tue, 20 Jun 2023 16:29:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <bed4d386c16701d14a2ea395edeb0368cb3d04ad.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxNeRZY5Fkd3MhAA--.28519S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3AF1kZw1xuFWrXFW5JrWkAFc_yoWfZryfpF
        ZrCFZ3GrWUWryfZw1xtw1UurWDta1xWr12g3Waqry8CrW2qrnrJr4Syr97AF9Fgw4YgFyI
        qFsYgF15XF4jyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j
        6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        uc_3UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 06/20/2023 04:15 PM, Xi Ruoyao wrote:
> It looks like only 19 patches are successfully delivered, out of 23.
I'm sorry, somehow the patchset didn't reach the mailing list. Probably
due to the sending limit being reached.

>
> And AFAIK objtool needs libelf from elfutils, and the LoongArch support
> in elfutils is not complete (there are about ten failures in the test
> suite as at the latest 0.189 release).  Do we need to add more LoongArch
> support into libelf and/or declare a minimal needed libelf version for
> LoongArch objtool?
After the following series of patches [1], the elfutils test results
are passed.

[1]: https://sourceware.org/pipermail/elfutils-devel/2023q2/006107.html

Thanks,
Youling
>
> On Tue, 2023-06-20 at 15:46 +0800, Youling Tang wrote:
>> This series of patches adds objtool and ORC unwinder support for
>> LoongArch.
>>
>> Patch 01 - 07 are from "Madhavan T. Venkataraman" [1] with minor
>> code tweaks. The "objtool: Reorganize ORC types" patch was not
>> added, because LoongArch cannot share `strcut orc_entry`, it also
>> needs to include ra_offset and ra_reg.
>>
>> Since the changes in Patch 01 - 08 in [1] are architecture-
>> independent,
>> it might be better if they could be separated separately from the
>> series
>> of patches.
>>
>> ORC unwinder can get a reliable stack trace, which provides a
>> prerequisite
>> for the subsequent addition of livepatch support.
>>
>>
>> Instruction decoder
>> ===================
>>
>> To do this, an instruction decoder needs to be implemented. I have
>> implemented
>> a simple, table-driven decoder for LoongArch. Only a subset of the
>> instructions
>> needs to be fully decoded for this purpose:
>>
>>         - Load-Store instructions
>>         - Add instructions
>>         - Branch instructions
>>         - Call instructions
>>         - Return instructions
>>         - Stack pointer authentication instruction
>>
>>
>> Unwind hints
>> ============
>>
>> Unwind hints are collected in a special section. Objtool converts
>> unwind hints
>> to ORC data. The unwinder processes unwind hints to handle special
>> cases
>> mentioned above.
>>
>>
>> ORC unwinder
>> ============
>>
>> Before vmlinux created, we check all metadata, find the stack
>> operation,
>> note stack state and create orc data. Objtool insert two sections into
>> vmlinux. '.orc_unwind_ip' and '.orc_unwind'. (For modules, insert
>> '.rela.orc_unwind_ip' to relocate '.orc_unwind_ip'.) Each insn has
>> only
>> one stack state in .orc_unwind and orc_unwind_ip hint its pc address.
>> Through unwinding orc data, we can get stack info both kernel and
>> module.
>>
>>
>> This is a series of RFC patches, which may require long-term
>> discussions
>> and revisions. It is not based on the latest code but based on 6.3-
>> rc3.
>> Any ideas or suggestions are welcome.
>>
>> base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65 (Linux 6.3-rc3)
>>
>> Link:
>> [1]:
>> https://lore.kernel.org/lkml/20230202074036.507249-1-madvenka@linux.microsoft.com/#r
>>
>> Madhavan T. Venkataraman (7):
>>   objtool: Reorganize CFI code
>>   objtool: Reorganize instruction-related code
>>   objtool: Move decode_instructions() to a separate file
>>   objtool: Reorganize Unwind hint code
>>   objtool: Reorganize ORC code
>>   objtool: Reorganize ORC kernel code
>>   objtool: Introduce STATIC_CHECK
>>
>> Youling Tang (16):
>>   tools: LoongArch: Copy inst.h and asm.h to tools
>>   objtool: LoongArch: Add base definition for LoongArch
>>   objtool: LoongArch: Implement decoder
>>   objtool: Add annotate_reachable() for objtools
>>   LoongArch: bug: Add reachable annotation to warning macros
>>   objtool: Add next member in struct reloc
>>   objtool: Add orc_print_dump() package
>>   objtool: Add ORC support for LoongArch
>>   LoongArch: Add ORC unwinder support
>>   LoongArch: Support R_LARCH_32_PCREL relocation type in kernel module
>>   LoongArch: Fix fpu.S objtool warning
>>   LoongArch: Annotate unwind_hint
>>   LoongArch: Move some data definitions into the .data section
>>   objtool: Add arch-specific "noreturn" function handling
>>   objtool: Make update_cfi_state() arch-specific function
>>   LoongArch: objtool: Mark non-standard object files and directories
>>
>>  arch/loongarch/Kconfig                        |   2 +
>>  arch/loongarch/Kconfig.debug                  |  11 +
>>  arch/loongarch/Makefile                       |   4 +
>>  arch/loongarch/include/asm/bug.h              |   1 +
>>  arch/loongarch/include/asm/module.h           |   7 +
>>  arch/loongarch/include/asm/orc_types.h        |  58 ++
>>  arch/loongarch/include/asm/stackframe.h       |   3 +
>>  arch/loongarch/include/asm/unwind.h           |  17 +-
>>  arch/loongarch/include/asm/unwind_hints.h     | 110 +++
>>  arch/loongarch/kernel/Makefile                |   3 +
>>  arch/loongarch/kernel/entry.S                 |   2 +
>>  arch/loongarch/kernel/fpu.S                   |  11 +-
>>  arch/loongarch/kernel/genex.S                 |   2 +
>>  arch/loongarch/kernel/head.S                  |   1 +
>>  arch/loongarch/kernel/module.c                |  21 +-
>>  arch/loongarch/kernel/relocate_kernel.S       |  12 +-
>>  arch/loongarch/kernel/setup.c                 |   2 +
>>  arch/loongarch/kernel/stacktrace.c            |   1 +
>>  arch/loongarch/kernel/unwind_orc.c            | 301 +++++++++
>>  arch/loongarch/kernel/vmlinux.lds.S           |   3 +
>>  arch/loongarch/power/Makefile                 |   2 +
>>  arch/loongarch/vdso/Makefile                  |   2 +
>>  arch/x86/include/asm/unwind.h                 |   5 -
>>  arch/x86/include/asm/unwind_hints.h           |  86 +++
>>  arch/x86/kernel/module.c                      |   7 +-
>>  arch/x86/kernel/unwind_orc.c                  | 268 +-------
>>  arch/x86/kernel/vmlinux.lds.S                 |   2 +-
>>  .../asm => include/asm-generic}/orc_lookup.h  |  43 ++
>>  include/linux/compiler.h                      |   9 +
>>  include/linux/objtool.h                       |  70 --
>>  kernel/Makefile                               |   2 +
>>  kernel/orc_lookup.c                           | 261 ++++++++
>>  scripts/Makefile                              |   5 +-
>>  tools/arch/loongarch/include/asm/asm.h        | 201 ++++++
>>  tools/arch/loongarch/include/asm/inst.h       | 629
>> ++++++++++++++++++
>>  tools/arch/loongarch/include/asm/orc_types.h  |  58 ++
>>  .../arch/loongarch/include/asm/unwind_hints.h | 110 +++
>>  tools/arch/x86/include/asm/unwind_hints.h     | 160 +++++
>>  tools/include/linux/bitops.h                  |  10 +
>>  tools/include/linux/objtool.h                 |  70 --
>>  tools/objtool/Build                           |   8 +-
>>  tools/objtool/Makefile                        |   9 +-
>>  tools/objtool/arch/loongarch/Build            |   3 +
>>  tools/objtool/arch/loongarch/decode.c         | 352 ++++++++++
>>  .../arch/loongarch/include/arch/cfi_regs.h    |  14 +
>>  .../objtool/arch/loongarch/include/arch/elf.h |  15 +
>>  .../arch/loongarch/include/arch/special.h     |  21 +
>>  tools/objtool/arch/loongarch/orc.c            | 155 +++++
>>  tools/objtool/arch/loongarch/special.c        |  25 +
>>  tools/objtool/arch/powerpc/special.c          |   3 +
>>  tools/objtool/arch/x86/Build                  |   1 +
>>  tools/objtool/arch/x86/include/arch/elf.h     |   1 +
>>  tools/objtool/arch/x86/orc.c                  | 164 +++++
>>  tools/objtool/arch/x86/special.c              |   4 +
>>  tools/objtool/cfi.c                           | 108 +++
>>  tools/objtool/check.c                         | 568 +---------------
>>  tools/objtool/decode.c                        | 136 ++++
>>  tools/objtool/elf.c                           |  11 +-
>>  tools/objtool/include/objtool/arch.h          |   3 +
>>  tools/objtool/include/objtool/cfi.h           |  12 +
>>  tools/objtool/include/objtool/check.h         |  97 +--
>>  tools/objtool/include/objtool/elf.h           |   1 +
>>  tools/objtool/include/objtool/insn.h          | 166 +++++
>>  tools/objtool/include/objtool/objtool.h       |   3 +
>>  tools/objtool/include/objtool/orc.h           |  15 +
>>  tools/objtool/include/objtool/special.h       |   3 +
>>  tools/objtool/insn.c                          | 195 ++++++
>>  tools/objtool/orc_dump.c                      |  67 +-
>>  tools/objtool/orc_gen.c                       |  79 +--
>>  tools/objtool/sync-check.sh                   |   9 +
>>  tools/objtool/unwind_hints.c                  | 107 +++
>>  71 files changed, 3721 insertions(+), 1206 deletions(-)
>>  create mode 100644 arch/loongarch/include/asm/orc_types.h
>>  create mode 100644 arch/loongarch/include/asm/unwind_hints.h
>>  create mode 100644 arch/loongarch/kernel/unwind_orc.c
>>  rename {arch/x86/include/asm => include/asm-generic}/orc_lookup.h
>> (50%)
>>  create mode 100644 kernel/orc_lookup.c
>>  create mode 100644 tools/arch/loongarch/include/asm/asm.h
>>  create mode 100644 tools/arch/loongarch/include/asm/inst.h
>>  create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
>>  create mode 100644 tools/arch/loongarch/include/asm/unwind_hints.h
>>  create mode 100644 tools/arch/x86/include/asm/unwind_hints.h
>>  create mode 100644 tools/objtool/arch/loongarch/Build
>>  create mode 100644 tools/objtool/arch/loongarch/decode.c
>>  create mode 100644
>> tools/objtool/arch/loongarch/include/arch/cfi_regs.h
>>  create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
>>  create mode 100644
>> tools/objtool/arch/loongarch/include/arch/special.h
>>  create mode 100644 tools/objtool/arch/loongarch/orc.c
>>  create mode 100644 tools/objtool/arch/loongarch/special.c
>>  create mode 100644 tools/objtool/arch/x86/orc.c
>>  create mode 100644 tools/objtool/cfi.c
>>  create mode 100644 tools/objtool/decode.c
>>  create mode 100644 tools/objtool/include/objtool/insn.h
>>  create mode 100644 tools/objtool/include/objtool/orc.h
>>  create mode 100644 tools/objtool/insn.c
>>  create mode 100644 tools/objtool/unwind_hints.c
>>
>

