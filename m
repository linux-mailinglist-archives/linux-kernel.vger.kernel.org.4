Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC136E42B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjDQIgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDQIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:36:33 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 166A23C01;
        Mon, 17 Apr 2023 01:36:24 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8DxUOUHBT1k0t0dAA--.46371S3;
        Mon, 17 Apr 2023 16:36:23 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axnr4DBT1kPZoqAA--.14313S3;
        Mon, 17 Apr 2023 16:36:21 +0800 (CST)
Subject: Re: [PATCH V2] tools/perf: Add basic support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
References: <20230410111823.2538831-1-chenhuacai@loongson.cn>
 <0a278ab5-751a-9433-3d1f-19a5a6b99d39@loongson.cn>
 <CAAhV-H5sxLDS7+MOaC_Y+gd-=Qrog7gzidKDkYa=DWC2Ci_5_Q@mail.gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Ming Wang <wangming01@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <d50d7779-3bff-1a83-2641-36abdb077ac1@loongson.cn>
Date:   Mon, 17 Apr 2023 16:36:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5sxLDS7+MOaC_Y+gd-=Qrog7gzidKDkYa=DWC2Ci_5_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axnr4DBT1kPZoqAA--.14313S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GryUuw1UJFWDZFy3CFWUXFb_yoW3KF4rpF
        W7CFs7tw48Wr1SkwsIyFWqgr13JrWfGFZav34fK3y7Aryjvwn3Jw48tr9xCFyxXw1kGry0
        9ws0kr4YkF1FyaDanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bsAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        WrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7xREWSoJUU
        UUU==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

On 04/17/2023 04:22 PM, Huacai Chen wrote:
> Hi, Youling,
>
> On Wed, Apr 12, 2023 at 5:44 PM Youling Tang <tangyouling@loongson.cn> wrote:
>>
>> Hi, Huacai
>>
>> On 04/10/2023 07:18 PM, Huacai Chen wrote:
>>> Add basic support for LoongArch, which is very similar to the MIPS
>>> version.
>>>
>>> Signed-off-by: Ming Wang <wangming01@loongson.cn>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>> V2: Add libdw support.
>>>
>>>  .../loongarch/include/uapi/asm/perf_regs.h    | 40 +++++++++
>>>  .../arch/loongarch/include/uapi/asm/unistd.h  |  9 ++
>>>  tools/perf/Makefile.config                    | 12 ++-
>>>  tools/perf/arch/loongarch/Build               |  1 +
>>>  tools/perf/arch/loongarch/Makefile            | 28 +++++++
>>>  .../arch/loongarch/annotate/instructions.c    | 45 ++++++++++
>>>  .../loongarch/entry/syscalls/mksyscalltbl     | 61 ++++++++++++++
>>>  .../arch/loongarch/include/dwarf-regs-table.h | 16 ++++
>>>  tools/perf/arch/loongarch/include/perf_regs.h | 15 ++++
>>>  tools/perf/arch/loongarch/util/Build          |  5 ++
>>>  tools/perf/arch/loongarch/util/dwarf-regs.c   | 44 ++++++++++
>>>  tools/perf/arch/loongarch/util/perf_regs.c    |  6 ++
>>>  tools/perf/arch/loongarch/util/unwind-libdw.c | 56 +++++++++++++
>>>  .../arch/loongarch/util/unwind-libunwind.c    | 82 +++++++++++++++++++
>>>  tools/perf/check-headers.sh                   |  1 +
>>>  tools/perf/util/annotate.c                    |  8 ++
>>>  tools/perf/util/dwarf-regs.c                  |  7 ++
>>>  tools/perf/util/env.c                         |  2 +
>>>  tools/perf/util/genelf.h                      |  3 +
>>>  tools/perf/util/perf_regs.c                   | 76 +++++++++++++++++
>>>  tools/perf/util/syscalltbl.c                  |  4 +
>>>  21 files changed, 518 insertions(+), 3 deletions(-)
>>>  create mode 100644 tools/arch/loongarch/include/uapi/asm/perf_regs.h
>>>  create mode 100644 tools/arch/loongarch/include/uapi/asm/unistd.h
>>>  create mode 100644 tools/perf/arch/loongarch/Build
>>>  create mode 100644 tools/perf/arch/loongarch/Makefile
>>>  create mode 100644 tools/perf/arch/loongarch/annotate/instructions.c
>>>  create mode 100755 tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
>>>  create mode 100644 tools/perf/arch/loongarch/include/dwarf-regs-table.h
>>>  create mode 100644 tools/perf/arch/loongarch/include/perf_regs.h
>>>  create mode 100644 tools/perf/arch/loongarch/util/Build
>>>  create mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
>>>  create mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
>>>  create mode 100644 tools/perf/arch/loongarch/util/unwind-libdw.c
>>>  create mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
>>>
>>> diff --git a/tools/arch/loongarch/include/uapi/asm/perf_regs.h b/tools/arch/loongarch/include/uapi/asm/perf_regs.h
>>> new file mode 100644
>>> index 000000000000..29d69c00fc7a
>>> --- /dev/null
>>> +++ b/tools/arch/loongarch/include/uapi/asm/perf_regs.h
>>> @@ -0,0 +1,40 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +#ifndef _ASM_LOONGARCH_PERF_REGS_H
>>> +#define _ASM_LOONGARCH_PERF_REGS_H
>>> +
>>> +enum perf_event_loongarch_regs {
>>> +     PERF_REG_LOONGARCH_PC,
>>
>> Why do we replace PERF_REG_LOONGARCH_PC with PERF_REG_LOONGARCH_R0
>> (although it is $zero) position (maybe refer to RISCV), but there are
>> many differences between LoongArch and RISCV, such as `struct
>> user_pt_regs` definition.
> This comes from arch/loongarch/include/uapi/asm/perf_regs.h, and I
> think the root cause is RISC-V, the trouble is we shouldn't change
> UAPI now.
OK, consistent with arch/loongarch/include/uapi/asm/perf_regs.h

>
>>
>> IMO, it may be better not to destroy $zero as much as possible, and to
>> keep it consistent with the definition in the libunwind tool.
>>
>> PERF_REG_LOONGARCH_PC = 33.
> If PERF_REG_LOONGARCH_PC is 33 in libunwind, I think we can only
> change libunwind now.
>
There is no need to change libunwind, and there is no requirement that
the order of the two be exactly the same (the original hope is to be
consistent with the order in pt_regs).

>>
>>> +     PERF_REG_LOONGARCH_R1,
>>> +     PERF_REG_LOONGARCH_R2,
>>> +     PERF_REG_LOONGARCH_R3,
>>> +     PERF_REG_LOONGARCH_R4,
>>> +     PERF_REG_LOONGARCH_R5,
>>> +     PERF_REG_LOONGARCH_R6,
>>> +     PERF_REG_LOONGARCH_R7,
>>> +     PERF_REG_LOONGARCH_R8,
>>> +     PERF_REG_LOONGARCH_R9,
>>> +     PERF_REG_LOONGARCH_R10,
>>> +     PERF_REG_LOONGARCH_R11,
>>> +     PERF_REG_LOONGARCH_R12,
>>> +     PERF_REG_LOONGARCH_R13,
>>> +     PERF_REG_LOONGARCH_R14,
>>> +     PERF_REG_LOONGARCH_R15,
>>> +     PERF_REG_LOONGARCH_R16,
>>> +     PERF_REG_LOONGARCH_R17,
>>> +     PERF_REG_LOONGARCH_R18,
>>> +     PERF_REG_LOONGARCH_R19,
>>> +     PERF_REG_LOONGARCH_R20,
>>> +     PERF_REG_LOONGARCH_R21,
>>> +     PERF_REG_LOONGARCH_R22,
>>> +     PERF_REG_LOONGARCH_R23,
>>> +     PERF_REG_LOONGARCH_R24,
>>> +     PERF_REG_LOONGARCH_R25,
>>> +     PERF_REG_LOONGARCH_R26,
>>> +     PERF_REG_LOONGARCH_R27,
>>> +     PERF_REG_LOONGARCH_R28,
>>> +     PERF_REG_LOONGARCH_R29,
>>> +     PERF_REG_LOONGARCH_R30,
>>> +     PERF_REG_LOONGARCH_R31,
>>> +     PERF_REG_LOONGARCH_MAX,
>>> +};
>>> +#endif /* _ASM_LOONGARCH_PERF_REGS_H */

/* snip */

>>> --- /dev/null
>>> +++ b/tools/perf/arch/loongarch/util/dwarf-regs.c
>>> @@ -0,0 +1,44 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
>>> + *
>>> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
>>> + */
>>> +
>>> +#include <stdio.h>
>>> +#include <errno.h> /* for EINVAL */
>>> +#include <string.h> /* for strcmp */
>>> +#include <dwarf-regs.h>
>>> +
>>> +struct pt_regs_dwarfnum {
>>> +     const char *name;
>>> +     unsigned int dwarfnum;
>>> +};
>>> +
>>> +static struct pt_regs_dwarfnum loongarch_gpr_table[] = {
>>> +     {"$0", 0}, {"$1", 1}, {"$2", 2}, {"$3", 3},
>>> +     {"$4", 4}, {"$5", 5}, {"$6", 6}, {"$7", 7},
>>> +     {"$8", 8}, {"$9", 9}, {"$10", 10}, {"$11", 11},
>>> +     {"$12", 12}, {"$13", 13}, {"$14", 14}, {"$15", 15},
>>> +     {"$16", 16}, {"$17", 17}, {"$18", 18}, {"$19", 19},
>>> +     {"$20", 20}, {"$21", 21}, {"$22", 22}, {"$23", 23},
>>> +     {"$24", 24}, {"$25", 25}, {"$26", 26}, {"$27", 27},
>>> +     {"$28", 28}, {"$29", 29}, {"$30", 30}, {"$31", 31},
>>> +     {NULL, 0}
>>> +};
>> Do you need to change it to the following:
>>
>> #define GPR_DWARFNUM_NAME(num) {.name = __stringify($r##num), .dwarfnum
>> = num}
>> #define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
>>
>> static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
>>          GPR_DWARFNUM_NAME(0),
>>          GPR_DWARFNUM_NAME(1),
>>          GPR_DWARFNUM_NAME(2),
>>          GPR_DWARFNUM_NAME(3),
>>          GPR_DWARFNUM_NAME(4),
>>          GPR_DWARFNUM_NAME(5),
>>          GPR_DWARFNUM_NAME(6),
>>          GPR_DWARFNUM_NAME(7),
>>          GPR_DWARFNUM_NAME(8),
>>          GPR_DWARFNUM_NAME(9),
>>          GPR_DWARFNUM_NAME(10),
>>          GPR_DWARFNUM_NAME(11),
>>          GPR_DWARFNUM_NAME(12),
>>          GPR_DWARFNUM_NAME(13),
>>          GPR_DWARFNUM_NAME(14),
>>          GPR_DWARFNUM_NAME(15),
>>          GPR_DWARFNUM_NAME(16),
>>          GPR_DWARFNUM_NAME(17),
>>          GPR_DWARFNUM_NAME(18),
>>          GPR_DWARFNUM_NAME(19),
>>          GPR_DWARFNUM_NAME(20),
>>          GPR_DWARFNUM_NAME(21),
>>          GPR_DWARFNUM_NAME(22),
>>          GPR_DWARFNUM_NAME(23),
>>          GPR_DWARFNUM_NAME(24),
>>          GPR_DWARFNUM_NAME(25),
>>          GPR_DWARFNUM_NAME(26),
>>          GPR_DWARFNUM_NAME(27),
>>          GPR_DWARFNUM_NAME(28),
>>          GPR_DWARFNUM_NAME(29),
>>          REG_DWARFNUM_NAME(30),
>>          REG_DWARFNUM_NAME(31),
>>          REG_DWARFNUM_END,
>> };
>>
>> At the same time, "$rx" is used in __perf_reg_name_loongarch and
>> loongarch_regstr_tbl, which is consistent with assembly.
> OK, I will use the "$rx" format, but I don't want to use macros.
Use the "rx" format to make regs_query_register_offset consistent with
arch/loongarch/kernel/ptrace.c (that is, the names in
loongarch_gpr_table and regoffset_table are consistent)

Youling.
>
> Huacai
>>
>>> +
>>> +const char *get_arch_regstr(unsigned int n)
>>> +{
>>> +     n %= 32;
>>> +     return loongarch_gpr_table[n].name;
>>> +}
>>> +
>>> +int regs_query_register_offset(const char *name)
>>> +{
>>> +     const struct pt_regs_dwarfnum *roff;
>>> +
>>> +     for (roff = loongarch_gpr_table; roff->name != NULL; roff++)
>>> +             if (!strcmp(roff->name, name))
>>> +                     return roff->dwarfnum;
>>> +     return -EINVAL;
>>> +}

