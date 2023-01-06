Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2C65F91A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjAFB3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjAFB2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:28:33 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 318D865AD1;
        Thu,  5 Jan 2023 17:23:20 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxaeoHeLdjH0EMAA--.23773S3;
        Fri, 06 Jan 2023 09:23:19 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHuSmaLdj_t0UAA--.62930S3;
        Fri, 06 Jan 2023 08:17:42 +0800 (CST)
Subject: Re: [PATCH v5 0/4] perf: Add more syscalls to benchmark
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1668052208-14047-1-git-send-email-yangtiezhu@loongson.cn>
 <c71e9666-c62a-83ae-0d7b-580dc717e9f1@loongson.cn>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <dbf82707-df17-466b-f882-aa4e25d4f629@loongson.cn>
Date:   Fri, 6 Jan 2023 08:17:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <c71e9666-c62a-83ae-0d7b-580dc717e9f1@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxHuSmaLdj_t0UAA--.62930S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7Gr4xKr1DCrWfGF1xXw45trb_yoWfCwb_Xa
        4IkrWkGrW8XasIyF98Grn8ZFyDtayIqrWkAF97Wry7tr4DXFyUJF4v9Fyku3WrKF4kZrZx
        Can5ZryfArW5KjkaLaAFLSUrUUUj2b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO
        r7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS
        14v26Fy26r43JwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVW3AVW8Zr1l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_ZF0_GFyUMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY
        6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUnAHUDUUUUU==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2022 05:19 PM, Tiezhu Yang wrote:
>
>
> On 11/10/2022 11:50 AM, Tiezhu Yang wrote:
>> Tested on x86_64, arm64, mips64 and loongarch64.
>>
>> Tiezhu Yang (4):
>>   tools x86: Keep list sorted by number in unistd_{32,64}.h
>>   perf bench syscall: Introduce bench_syscall_common()
>>   perf bench syscall: Add getpgid syscall benchmark
>>   perf bench syscall: Add execve syscall benchmark
>>
>>  tools/arch/x86/include/uapi/asm/unistd_32.h | 23 ++++++---
>>  tools/arch/x86/include/uapi/asm/unistd_64.h | 23 ++++++---
>>  tools/perf/bench/bench.h                    |  2 +
>>  tools/perf/bench/syscall.c                  | 76
>> +++++++++++++++++++++++++++--
>>  tools/perf/builtin-bench.c                  |  2 +
>>  5 files changed, 108 insertions(+), 18 deletions(-)
>>
>
> Ping, any more comments?
>
> Thanks,
> Tiezhu

Hi all,

If this patch series has no value and is not acceptable,
or what should I do to update, please let me know.

Thanks,
Tiezhu

