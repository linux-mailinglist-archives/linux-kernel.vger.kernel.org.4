Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082B062396B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiKJCCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiKJCAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:00:30 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1ED52AC48;
        Wed,  9 Nov 2022 17:59:02 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx7NjlWmxjSKwFAA--.18108S3;
        Thu, 10 Nov 2022 09:59:01 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxiFfjWmxj2_EPAA--.25957S3;
        Thu, 10 Nov 2022 09:59:00 +0800 (CST)
Subject: Re: [PATCH v4 0/4] perf: Add more syscalls to benchmark
To:     Namhyung Kim <namhyung@kernel.org>
References: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
 <CAM9d7ciVpT05OCSzB9t9v71Yb7pfhSat3XpK3cTwn-z+DVkJqQ@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <96aa3dc5-fa86-918a-68ff-bbf7b626fcab@loongson.cn>
Date:   Thu, 10 Nov 2022 09:58:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciVpT05OCSzB9t9v71Yb7pfhSat3XpK3cTwn-z+DVkJqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxiFfjWmxj2_EPAA--.25957S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7XFW7WFyftr1rKF48KFW7Arb_yoWfJwcEva
        92yrykGr48ArnFy3W5Krs8ZF9rA3srXrW5ArZ7X3y7Kw1UZrWxJa1FkryruF18JF4kZrZx
        KwsrZ3sxCryakjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO
        17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2022 02:15 AM, Namhyung Kim wrote:
> Hello,
>
> On Wed, Nov 9, 2022 at 12:29 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Tiezhu Yang (4):
>>   tools x86: Keep list sorted by number in unistd_{32,64}.h
>>   perf bench syscall: Introduce bench_syscall_common()
>>   perf bench syscall: Add getpgrp syscall benchmark
>>   perf bench syscall: Add execve syscall benchmark
>
> Have you tested it on non-x86 too?  It seems you only added the syscall
> numbers to x86.
>

Hi Namhyung,

Thank you for your reply.

I tested only on x86, when build on arm64, there exists
the following build error:

error: ‘__NR_getpgrp’ undeclared (first use in this function)

this is because __NR_getpgrp is deprecated on some archs.

Sorry for that, let me use getpgid, I will test on x86_64, arm64,
mips64 and loongarch64, and then send v5, thank you.

Thanks,
Tiezhu

