Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A46A6B6DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCMDZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCMDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:25:10 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2171.outbound.protection.outlook.com [40.92.62.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A82CFC3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwucUkOenpQ6P1LaDGJE/2tAwk2j28zndLwtkBvtRp1NGWMSJpyMx4jJWyidQ61XHhJIaFO+kWqPcety7Zb52aB7dH5NtsQ2J1b0m7mLnaaec7lEpiJXzNhSy4yFN01XbnftDniLATTxBp5OlnABIf6uDdlQvt4bICA5MInRI711lPPeBz5rbeQAa6ZMixVNyhBI1yvI2adWB+RTtZ04LTJ2z6u3E95a7id2oxYS0UYtMZ/Y9pYMEOjmNcNCkgnOCHAyWp0Ib/xxbRahOKxaYbeO9uKjB9SONFhZrNjfUODevjUXb5e5Fndr2jzrQbfAR5WuZ+SYFfK3O9P1uFkX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GaA/jrFjOFd/s80qv9m+H5kWKwod42FATjv/0lzoY8=;
 b=FQwakUpXx2XdGPkRZocPTCEkBbwpV3EFW6NVRVXh63jRjdd1aLatQ6FzzPDZpQxfiwyXrkMViDsMlSrABmqqIDUBdnZEFr0/IOrConHjETN6O2L065LXSB4kGHfk+dnUYT1o7hPOFEbxfhoaoyc6arBK3LTXjQg1BZEiku2SB8AfZhaYBzmavkO1See/TzQ/Xxz5MX/jkAr/R7e47jeMJ1bXj2yoqLUftsnGZU3lgdl6VvT2lVZ+qPw0cYUmGHepD5TwnzaQVQN5eVjGytoZHgEB4vhXy/KpZJbndN0O4R0hJonp1BClIsWn0p/ATxqJN/9xV1t6BBquoxvMETXKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GaA/jrFjOFd/s80qv9m+H5kWKwod42FATjv/0lzoY8=;
 b=cK0WEWnfv7YEcQ9NHCJgy0KR7vMjrKzJ6RUqRo1jOExACxxRJxVyR4aDU/bh+hMf1cPSNL2EU6hl1UD48KIDlzAqqYh1386yk2cPzoRMyzs3kiIQUhOloAZLs5N/6kcUGA9GTl32mT7bd1c/+MUPMDEXQ+0qiC3VpWbEboIAr1G9ywSPfg/cgbvAAQeobIVc1wxYwY9KICTADU3St0osCex4Kb4k+L6A+f5ubzxzOFZWLnN7QlYSuCMzfZF66Nox7f4tgdjQMY80hWnC+9ZTMbg8DBAzrixSVwfyk20WbV1rXV/ORQJtPl7dJRzD/IyUCr06+qs5QFXI0BpGHvNl8Q==
Received: from SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b5::14)
 by SYZP282MB3110.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 03:25:03 +0000
Received: from SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9228:eccc:9476:7a53]) by SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9228:eccc:9476:7a53%3]) with mapi id 15.20.6178.016; Mon, 13 Mar 2023
 03:25:03 +0000
Message-ID: <SY4P282MB351816A0B972E606E5527AEDC0B99@SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM>
Date:   Mon, 13 Mar 2023 11:24:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Add support for function error injection
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <1678173001-16852-1-git-send-email-yangtiezhu@loongson.cn>
 <fb573603-edc1-9c87-5739-a33e5e1db6e1@loongson.cn>
Content-Language: en-US
From:   Hengqi Chen <chenhengqi@outlook.com>
In-Reply-To: <fb573603-edc1-9c87-5739-a33e5e1db6e1@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [loquxw57F/+HhYl/NhhTgBW3w7L9dXjS]
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1b5::14)
X-Microsoft-Original-Message-ID: <5dd725b0-1301-7466-f425-4d8b6b1183e1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3518:EE_|SYZP282MB3110:EE_
X-MS-Office365-Filtering-Correlation-Id: f27efaf9-535e-4902-9b3c-08db23728842
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIKAqEzstcWVeNRg59TmgNK9RHr6c//eyn0OG3KKu/r/n65PSI95wB5ONoY8ymi5UM38M2bbqWuGK/IMgxQaBsE9aRMNGMOXDTEXhX94xtZz7PQAzJXKtpAItbo2SfLVQjClWVJGnE89wHtUQLQuAY1XqJb6MKcidi/B0vA8VI9hQ38zBYDYiX+Jc7zSEXCt0J9dIJjSG1Yb6+CP4GchpjYEOBscZqWwoqBrKL6pnW+0nGoeED5EyqdxSnXk8E7LHAZHuLfPLyGH2Vf+5AnkOqK/1OGtQ0iUEVwMHkhjpYuOAGD1yf+o5wz52KyCDvID5pbAeTCr8kWgiuKmAlX3Bzj/35m8f4CAaNJp21u6ofhO6KHn1LiycTve2vpF1/sERrYmWQSpoOu8Pp03yQBcRshHBPD9ykFakkudQnNRToUOTZA4smbOPo7FFE6J4f3FjkgrZFWlAP/EsRdulk2/vRPj1HSOT5VKXFiwvklpNZQU6okOc7+dnLc0yTOTWIi88pkbPgzsnQ6IdOmr2LOLA3W1cw+Oong/z3zqFea9d8nZv/u7l0wrmSY+rPPx+aIfeBxbXntG8DyB4ixAnfv2s6a5yUh3fpBz/yUK+P9WSC51tlGJF7Eh87eYAq3c1oJuJ9MUcW4eKZRgYnJlZt15yw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WllWVkgyQUFjbmhOVGdHZU5iQWVKYXpOcnFOem0yNHNvVmdvaTYvazZFbjBm?=
 =?utf-8?B?bzg1UVBacnN2ZERrcFhMRUNnM2lQTTZqTVM3b0VXdXpoVnZCN1pKUERUU2cy?=
 =?utf-8?B?RWdRMlZDbGV6YU0xOEFOaHhKMGxPNzBsZlIwcHlZMEluOFcyYXVvQlpwNTNE?=
 =?utf-8?B?N2lIRWs1WnFhZkJYMjRYYXhsdStmWlFNa04xSmVHakMzMnpRaXkzaVV1TWJz?=
 =?utf-8?B?eGZJS2lvS01XVzZ3WkNQcFVKS0FPemZNYmRnRHo1Yi8rSlhCY3N3dWgrdDBh?=
 =?utf-8?B?QzZ6MjRLUlpkMjBtcTNyQ3JvdG5zbWVTSDBEbWgrZkE3SWh4MTJnaHZhT0Zl?=
 =?utf-8?B?eXJCMjY5L2xHcUpXelpYUW9WM3dUaVNoVytUbTJWajd4enJ6RWZNVzBDTTg2?=
 =?utf-8?B?dTdxWUlZYWdSVUovVG41MG9XNUlWbFZQaitsZnhsZGZWMjlYWlk0bVVjb1h0?=
 =?utf-8?B?a0NEeGtmUFhKalBSaXNmdndnazF2RkVQZmEzaVRFNmJBWUhGcC8rdnBQUEgw?=
 =?utf-8?B?c2FDZUlYbXJ4R2xqenEraXlZRGQxNUQxR3pLVnU5ZjAxSVAzYkdmU2xBdlV6?=
 =?utf-8?B?SnpkRktra2VLVTEyZkh1Wk1NN3V6N1djUlJLYUZqR2dvUC9SbnE5bkRNY0RG?=
 =?utf-8?B?OVZuSSsrajBTSDB6ZFJGQVlicWNSUEZ2WGhNeXdpUnp1Wk56RnVnVmFBS0JW?=
 =?utf-8?B?WEQ3SlN6aWcxaG9STVZvMzNVcTBJVkNJeVJmZS9HV3ZZVGNnTHprak1LUktk?=
 =?utf-8?B?VzU4NmNzNk1pNDBGVFAzRTNHSU9WeWd5S2llNllsOCtSNmpUNDRGeW03elhY?=
 =?utf-8?B?dUdQUm9aSUtWVmFydWQzV1BvbVVZOXpIQllVVGZiOVRPSVgzdlNUN3lCb0VR?=
 =?utf-8?B?c1FjMUZYZW5DY2IvZU1wckIvZXB1cjRieWdBRW40R1JVV1EwdjZQTGVSdmZ4?=
 =?utf-8?B?YlNyRHBQNWtFbEtad3JtU2JJckwzdDBKK0Q2d2JLNHkyQ2FxVDhVb1dqVzhF?=
 =?utf-8?B?TnQ3UVRLWHpzQ1NuUStzZE1pRzBzVWZ2eGttL3h2OG9EbktSa1BrdUJxQkZO?=
 =?utf-8?B?TWdmL1B5aDhhbHZRY2tydllTejRSQldHbnc1dEJxdkR0SGxiRlVxZm1NTkFN?=
 =?utf-8?B?UTVzQ0VrdjBxL1RMdkw4L2phbWdEdjZBc2JGbERNeVF2TkpBZFZWamVoVG9t?=
 =?utf-8?B?eGpLS0tId3E5ZDBQRUtzcGFwdFlpTSs3Y2VxT1ZZV1d1S2lYaXEwT1ltc1li?=
 =?utf-8?B?RlE4QkZiV2dkZnRoOFljaVJLdDdVR3NleUcxYUtIZ3NRWk5WZEhwMUVLR3kx?=
 =?utf-8?B?NEt3VUNCQ1FWRmJhUVJNUEFaS21pemFvNUx1NGRRS3g2Zm1iaUxhYjUvN0tL?=
 =?utf-8?B?cVZ2ZTh2ejgxVlB3TDhiZXoyNEY1dmE5Nm84N05vR1N5RVJ3NXQ2MnlYODY3?=
 =?utf-8?B?Q05Rd0wwWUxIS2F1R0dvb1dDTDRuQmVyQUVwNlpxK2tOclB1aXNvWVczbGpq?=
 =?utf-8?B?SzF2SEZxR2dTYVFQMFc2YXZOOTZMZGdaWXhCVU44Y214cUo4WDZLMXNIUkc5?=
 =?utf-8?B?RUIzOVp2NkJQWGo4Q2dLUkVuZWI5dm4xc2dWTUQxbldxVU85NVE3Wkl1MVRR?=
 =?utf-8?B?VmZkMWxMZXZIT2NQY3JDTzZjTm1wOVdmVlI0Tlkya0Vrc210b2l5T251U1oz?=
 =?utf-8?B?NUY1S1BpcCs2ZjJVejVmNmR0S1Zpend1cHpxSndGMmd5amgrYUQ1aUZBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27efaf9-535e-4902-9b3c-08db23728842
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 03:25:03.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYZP282MB3110
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/10 10:07, Tiezhu Yang wrote:
> This feature is related with kprobes, add Masami to CC.
> 
> On 03/07/2023 03:10 PM, Tiezhu Yang wrote:
>> Inspired by the commit 42d038c4fb00 ("arm64: Add support for function error
>> injection") and commit ee55ff803b38 ("riscv: Add support for function error
>> injection"), support function error injection for LoongArch.
>>
>> Mainly implement two functions:
>> (1) regs_set_return_value() which is used to overwrite the return value,
>> (2) override_function_with_return() which is used to override the probed
>> function returning and jump to its caller.
>>
>> Here is a simple test under CONFIG_FUNCTION_ERROR_INJECTION and
>> CONFIG_FAIL_FUNCTION:
>>
>>   # echo sys_clone > /sys/kernel/debug/fail_function/inject
>>   # echo 100 > /sys/kernel/debug/fail_function/probability
>>   # dmesg
>>   bash: fork: Invalid argument
>>   # dmesg
>>   ...
>>   FAULT_INJECTION: forcing a failure.
>>   name fail_function, interval 1, probability 100, space 0, times 1
>>   ...
>>   Call Trace:
>>   [<90000000002238f4>] show_stack+0x5c/0x180
>>   [<90000000012e384c>] dump_stack_lvl+0x60/0x88
>>   [<9000000000b1879c>] should_fail_ex+0x1b0/0x1f4
>>   [<900000000032ead4>] fei_kprobe_handler+0x28/0x6c
>>   [<9000000000230970>] kprobe_breakpoint_handler+0xf0/0x118
>>   [<90000000012e3e60>] do_bp+0x2c4/0x358
>>   [<9000000002241924>] exception_handlers+0x1924/0x10000
>>   [<900000000023b7d0>] sys_clone+0x0/0x4
>>   [<90000000012e4744>] do_syscall+0x7c/0x94
>>   [<9000000000221e44>] handle_syscall+0xc4/0x160
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  arch/loongarch/Kconfig              |  1 +
>>  arch/loongarch/include/asm/ptrace.h |  6 ++++++
>>  arch/loongarch/lib/Makefile         |  2 ++
>>  arch/loongarch/lib/error-inject.c   | 10 ++++++++++
>>  4 files changed, 19 insertions(+)
>>  create mode 100644 arch/loongarch/lib/error-inject.c
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 7fd5125..b16ff7e 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -99,6 +99,7 @@ config LOONGARCH
>>      select HAVE_FAST_GUP
>>      select HAVE_FTRACE_MCOUNT_RECORD
>>      select HAVE_FUNCTION_ARG_ACCESS_API
>> +    select HAVE_FUNCTION_ERROR_INJECTION
>>      select HAVE_FUNCTION_GRAPH_TRACER
>>      select HAVE_FUNCTION_TRACER
>>      select HAVE_GENERIC_VDSO
>> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
>> index d761db9..db7332a 100644
>> --- a/arch/loongarch/include/asm/ptrace.h
>> +++ b/arch/loongarch/include/asm/ptrace.h
>> @@ -154,6 +154,12 @@ static inline long regs_return_value(struct pt_regs *regs)
>>      return regs->regs[4];
>>  }
>>
>> +static inline void regs_set_return_value(struct pt_regs *regs,
>> +                     unsigned long val)
>> +{
>> +    regs->regs[4] = val;
>> +}
>> +
>>  #define instruction_pointer(regs) ((regs)->csr_era)
>>  #define profile_pc(regs) instruction_pointer(regs)
>>
>> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
>> index 40bde63..30b1595 100644
>> --- a/arch/loongarch/lib/Makefile
>> +++ b/arch/loongarch/lib/Makefile
>> @@ -5,3 +5,5 @@
>>
>>  lib-y    += delay.o memset.o memcpy.o memmove.o \
>>         clear_user.o copy_user.o dump_tlb.o unaligned.o
>> +
>> +obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>> diff --git a/arch/loongarch/lib/error-inject.c b/arch/loongarch/lib/error-inject.c
>> new file mode 100644
>> index 0000000..afc9e1c
>> --- /dev/null
>> +++ b/arch/loongarch/lib/error-inject.c
>> @@ -0,0 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/error-injection.h>
>> +#include <linux/kprobes.h>
>> +
>> +void override_function_with_return(struct pt_regs *regs)
>> +{
>> +    instruction_pointer_set(regs, regs->regs[1]);
>> +}
>> +NOKPROBE_SYMBOL(override_function_with_return);
>>
> 
> 

Tested-by: Hengqi Chen <hengqi.chen@gmail.com>
