Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F616E439A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDQJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDQJXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:23:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A68165B8C;
        Mon, 17 Apr 2023 02:22:45 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxUU_aDz1kK+EdAA--.34623S3;
        Mon, 17 Apr 2023 17:22:34 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx8eTYDz1klqQqAA--.20178S3;
        Mon, 17 Apr 2023 17:22:33 +0800 (CST)
Subject: Re: [PATCH V2] tools/perf: Add basic support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
References: <20230410111823.2538831-1-chenhuacai@loongson.cn>
 <0a278ab5-751a-9433-3d1f-19a5a6b99d39@loongson.cn>
 <CAAhV-H5sxLDS7+MOaC_Y+gd-=Qrog7gzidKDkYa=DWC2Ci_5_Q@mail.gmail.com>
 <d50d7779-3bff-1a83-2641-36abdb077ac1@loongson.cn>
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
Message-ID: <b1cdd754-fa38-4b2e-0a93-b13d9cfd7a8a@loongson.cn>
Date:   Mon, 17 Apr 2023 17:22:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d50d7779-3bff-1a83-2641-36abdb077ac1@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cx8eTYDz1klqQqAA--.20178S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGw4DAFy5WFyrWFy7GFyfZwb_yoW5tw4UpF
        4xAFW7tF18Xr4jywn0vas8Wr9rt3yYqasYq34xGFy3Z3Wqy3Z3GwsxJrW5GF1xu347GFy8
        Za1YyFsxWF90yFJanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bsAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        WrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAF
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

/* snip */

>>>> --- /dev/null
>>>> +++ b/tools/perf/arch/loongarch/util/dwarf-regs.c
>>>> @@ -0,0 +1,44 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * dwarf-regs.c : Mapping of DWARF debug register numbers into
>>>> register names.
>>>> + *
>>>> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
>>>> + */
>>>> +
>>>> +#include <stdio.h>
>>>> +#include <errno.h> /* for EINVAL */
>>>> +#include <string.h> /* for strcmp */
>>>> +#include <dwarf-regs.h>
>>>> +
>>>> +struct pt_regs_dwarfnum {
>>>> +     const char *name;
>>>> +     unsigned int dwarfnum;
>>>> +};
>>>> +
>>>> +static struct pt_regs_dwarfnum loongarch_gpr_table[] = {
>>>> +     {"$0", 0}, {"$1", 1}, {"$2", 2}, {"$3", 3},
>>>> +     {"$4", 4}, {"$5", 5}, {"$6", 6}, {"$7", 7},
>>>> +     {"$8", 8}, {"$9", 9}, {"$10", 10}, {"$11", 11},
>>>> +     {"$12", 12}, {"$13", 13}, {"$14", 14}, {"$15", 15},
>>>> +     {"$16", 16}, {"$17", 17}, {"$18", 18}, {"$19", 19},
>>>> +     {"$20", 20}, {"$21", 21}, {"$22", 22}, {"$23", 23},
>>>> +     {"$24", 24}, {"$25", 25}, {"$26", 26}, {"$27", 27},
>>>> +     {"$28", 28}, {"$29", 29}, {"$30", 30}, {"$31", 31},
>>>> +     {NULL, 0}
>>>> +};
>>> Do you need to change it to the following:
>>>
>>> #define GPR_DWARFNUM_NAME(num) {.name = __stringify($r##num), .dwarfnum
>>> = num}
>>> #define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
>>>
>>> static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
>>>          GPR_DWARFNUM_NAME(0),
>>>          GPR_DWARFNUM_NAME(1),
>>>          GPR_DWARFNUM_NAME(2),
>>>          GPR_DWARFNUM_NAME(3),
>>>          GPR_DWARFNUM_NAME(4),
>>>          GPR_DWARFNUM_NAME(5),
>>>          GPR_DWARFNUM_NAME(6),
>>>          GPR_DWARFNUM_NAME(7),
>>>          GPR_DWARFNUM_NAME(8),
>>>          GPR_DWARFNUM_NAME(9),
>>>          GPR_DWARFNUM_NAME(10),
>>>          GPR_DWARFNUM_NAME(11),
>>>          GPR_DWARFNUM_NAME(12),
>>>          GPR_DWARFNUM_NAME(13),
>>>          GPR_DWARFNUM_NAME(14),
>>>          GPR_DWARFNUM_NAME(15),
>>>          GPR_DWARFNUM_NAME(16),
>>>          GPR_DWARFNUM_NAME(17),
>>>          GPR_DWARFNUM_NAME(18),
>>>          GPR_DWARFNUM_NAME(19),
>>>          GPR_DWARFNUM_NAME(20),
>>>          GPR_DWARFNUM_NAME(21),
>>>          GPR_DWARFNUM_NAME(22),
>>>          GPR_DWARFNUM_NAME(23),
>>>          GPR_DWARFNUM_NAME(24),
>>>          GPR_DWARFNUM_NAME(25),
>>>          GPR_DWARFNUM_NAME(26),
>>>          GPR_DWARFNUM_NAME(27),
>>>          GPR_DWARFNUM_NAME(28),
>>>          GPR_DWARFNUM_NAME(29),
>>>          REG_DWARFNUM_NAME(30),
>>>          REG_DWARFNUM_NAME(31),
>>>          REG_DWARFNUM_END,
>>> };
>>>
>>> At the same time, "$rx" is used in __perf_reg_name_loongarch and
>>> loongarch_regstr_tbl, which is consistent with assembly.
>> OK, I will use the "$rx" format, but I don't want to use macros.
> Use the "rx" format to make regs_query_register_offset consistent with
> arch/loongarch/kernel/ptrace.c (that is, the names in
> loongarch_gpr_table and regoffset_table are consistent)

If we want to be consistent with the usage of `trace probe`, we should
use "%rx".

eg:
    # echo "p:myuprobe /tmp/test:0x4194 %r4 %r5" > uprobe_events

parse_probe_arg()
          case '%': regs_query_register_offset()

Youling.
>
> Youling.
>>
>> Huacai
>>>
>>>> +
>>>> +const char *get_arch_regstr(unsigned int n)
>>>> +{
>>>> +     n %= 32;
>>>> +     return loongarch_gpr_table[n].name;
>>>> +}
>>>> +
>>>> +int regs_query_register_offset(const char *name)
>>>> +{
>>>> +     const struct pt_regs_dwarfnum *roff;
>>>> +
>>>> +     for (roff = loongarch_gpr_table; roff->name != NULL; roff++)
>>>> +             if (!strcmp(roff->name, name))
>>>> +                     return roff->dwarfnum;
>>>> +     return -EINVAL;
>>>> +}
>

