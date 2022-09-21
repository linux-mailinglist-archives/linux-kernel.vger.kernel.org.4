Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51A65E5404
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIUTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiIUTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:53:36 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2047.outbound.protection.outlook.com [40.107.116.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5F6A220D;
        Wed, 21 Sep 2022 12:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXkstbn58C/rZtkUqaXXwiVlTeZtv6CBAK3d3MKX3MY4jFDNDXbVnQlGXlVQYVOUJ+G8f4wWw+cnfoJwobqxUlMl5X5IeBxE0fCQUqNkTorf1brSNJlaxXthNJdf8njEM97+ET2Fg/a5q4HWO+l5GnixmPQhEf/a6DXy+0GdKL5MkcW8E1SYzDANC5oI80af/yC11V7L20eZJKxCZ7sqbM1VN2wO6Ughk0aUxok0DUTLz2S2YElamO5M/Gk8DEeY+hOZDULk2mcfEG6fCFMNLH69kDI7b7JIZb4NjH0yvOajSYh6rgcWgJ5/BBOOLwIKJSp/mUaSluVnP/Ai0jdpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v65DzXUTcLDiA+y7ALeAnoW9v1qc2zxOUamV/Rp6Dys=;
 b=KDVGPW42I2RPKzG8ZYUIWLdT61ANS9ynQn7xhz63l3x5PxjNupKbFahRfGvuaGdnbrkOFg+q8c8Wa5uLk2hnGf2w4N91IrRLNmYBW9ql7z9/bUZ/kL6wcJnY49Yii7JUxiVhoVoCuRSAbRBQlXV2BOEsnZ61XtXuptMcyiBgZPOMx83E0QGDI69xISUNGZOlXCZ6Msjiz6KAAsWhxQoK4ZtGfMYQYUX7or+LhWrMtBpBr9kCEcxyvIoGK9Ts7nFjgFYC+trZAMIRGDicPYmTcRaBEsdftUxlWlIaAE/Zm2X0OtAGy6vkm/0HHNfumCWqwHma1zmFGNh8teWSZYVMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v65DzXUTcLDiA+y7ALeAnoW9v1qc2zxOUamV/Rp6Dys=;
 b=ixypXZh13YfK1x6uUAdRcY2D2iOuRXhPhyU3wZoNMTSp+F8vgk4ntAuIpzQ6Hbg48Ql+Glqy9TsplqMufG03IlE9zFzKkmbPhmfk6DgBcA0ndIota69iW/CZr4x6EwHMc5pt4aHy7ujtX0vC8mdmRy8RmgLvlIWbIw02AvV8s9ZYZ3zXS0Dpq5GmbnuF6otPX0EVDKOOxqUPpahxkxge8kMD6t74jO4BA3kGAho6JbnNVDvI0Kybhe2KFcInSI4lfV4rFigPq4iMcq2s34SmFmCP5OM2dZ2ubD/UDCO4ZgqtWNMhvFO6xBGT8uSz5y42iNaYUd6lAt9efRkG8Yas9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8835.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 19:53:32 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 19:53:32 +0000
Message-ID: <14ba275f-8ddc-33fc-2669-1c336436f473@efficios.com>
Date:   Wed, 21 Sep 2022 15:54:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH v4 00/25] RSEQ node id and virtual cpu id extensions
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
References: <20220921192454.231662-1-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20220921192454.231662-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 406f0021-3258-4ace-b45b-08da9c0af684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEzY/6M7VwFSrforao7wFGsL3TraXLs3R2tuGIUkGNcr2rLi92fti1lmrgPQ5kp7PWFRL3v+ZrTf+TKkCD4BxhiCY8vPX0Czf6Muu24GomIqskkUzjpguRR/cqdfi3Uk+kDTU5c1SAWhyooqg8VL8qf8dn5O0rbK1HHSS4zEGFZwRYom94vAcDjpcEwgMRj7+fTtOEpqV0EoD+yLDEf2/UsrfgdYQKsQaCD64VWoLmGvXkB1ZbbZO7s0MAEODp1wCBcngoW5TfBo6sMgn4wieU7lEOd2QtvFLUvtPinSbLiqYXeEsUkko4V4MbFoMrCP615oUKpzcaDYpsYC9rJL4X/4EkwOPGK62DvmXt95G3AzyowI9tzBjr9am7WYSK4vSWXGKqS5Rei66swD8Dtkym7qa+X4MuVJKQ4NcrYzdHR72BGtoCkiyjUtgIB1pTpJAasNaY9Up7/ZnzOkZ7ysv2BEzNh6R2ykzDiAYULvPNSIPoVnUSDNnJIslAW/IHhLodBFt5JP9jRvIpeDcTwNFwX4dnmqQkuqaJr89L9SfdvI860ku9s6wKvkSFOIfRbso3syEgM54pgJwoe57v3vVuq/aoyisitPEwDWzeT9/L/uG7FKqFxYnt/tsfW9eo5hchxymgwzt+DMSR3ylzY228NjG4NracgQR3L/OD6Ipl2YAW7+NEtZGUE2VdFvAlvmeL2DhAKI12d/MUYX6HwI+dN9N3QvwichgNzkcm7yho2mvlXzPpshm4d6tC2d/cMGZLHJi+Q40ZPQpCVzNnm1o/8X67iB5JSJ5OXUZSVTjwDf8xzDYeDYaaDeBYtn3FcG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(34096005)(39830400003)(396003)(136003)(34036004)(451199015)(186003)(44832011)(41300700001)(2616005)(7416002)(2906002)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(6666004)(26005)(36756003)(5660300002)(8936002)(6512007)(6506007)(53546011)(41320700001)(83380400001)(86362001)(31696002)(6916009)(498600001)(6486002)(586005)(966005)(66899012)(31686004)(54906003)(38610400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUVDL3ZWVWpCcms3MVBMT1BrRTVXWUxuelZjelBJbUFwM1V6QTJtUjl6ZUla?=
 =?utf-8?B?QktuL3c0Z3g4RHc1UlR3VFFUdmZFb1ZhTXloaDhENko4U1RJZjdiMzhiN2FJ?=
 =?utf-8?B?TSsxUFdNeHJla1VEdW5LN2E5KzhuOUFDNU9ka1RYUGp0S3lBUXJmY01maWJm?=
 =?utf-8?B?amxNQXM0Z05oeTdHRERyd0VIdHFmYUZBODVZblIyWWo3WjVJekNqUndtcU9x?=
 =?utf-8?B?SVc5R0dxNzg3OGlTNWhjVnVFaDFhOUJXb2hMa2pkdXEyTVBIeHFvNkRhZXZD?=
 =?utf-8?B?eVFzU2MrYnpDZ3J5SnEwYlE2M001ZU55MHYvL1VRc3p1TktFYlR6L3R6UXJK?=
 =?utf-8?B?MFcrZ20rKzhQdkJLMUx5ZGxYblhsYnNPcVNrOWFCbEFSWWNGTVpES2h3ZENp?=
 =?utf-8?B?LzBUcXZIVXBDUCs5VlBvdlhMMkdDQkJLamNkRC9BZ3I4SG1nN1ZPNHdGQTdO?=
 =?utf-8?B?T3lEb2lsbFlxTXl1NzVzSUwwYlYxZHRwdExPUlp4bGdlTG9vZThtRWNIYzho?=
 =?utf-8?B?UTZaNkxzUitYMExNOUMxYmdPNWwrQm5Fa1RMMzV6NlNVZnFodHlpc1lSaXdC?=
 =?utf-8?B?bW5Land1MXg3cjh0T29OM0VHKzh3SU9vNHlxRk9PV3Nhc3pueUZ2dDBJaHA4?=
 =?utf-8?B?TlRQQmhYRWR3bEZvcVM5OFJ4UDN5ODdOYWF3UGVQSUpBTEFZRUZUY3NCOFlZ?=
 =?utf-8?B?aEFTOHh1eDZpbUp0S1V4WnM0VjgrQURjcWNHcjIrSlFpRFh6aStpY1o4VGpQ?=
 =?utf-8?B?YXhDMlJEbkdZVkQybVFYUzNxeUMzdThlb0N5S0g2R2h0RXI2VUlORDhHMHo5?=
 =?utf-8?B?ejdRTjI4L3RwazliL2ZJeEUzNFl2b3hNNzVlZ1R2QmRCQXl5bHdvbGdQQ2xk?=
 =?utf-8?B?R3dnTTBiY1l0Mjl4NGorSm5kZU83T0FNN0MwZ2svYjJFSVFjL2hpaVV0TTZ3?=
 =?utf-8?B?eHhYWi9vcFM1Nm90Y1ZwMFF4ZHlvNUFVcTFNbkxTeEVFaU1xM3BZZTJGdVZB?=
 =?utf-8?B?UTZ5MDNiRDJnL2xNVnNTcUViZ2xQTk85WWdKOTdJeVVhZHp1Q1ZCaW41am1L?=
 =?utf-8?B?S1VRZmRJNlR4MFpEOEMxRTYwKzM4bmp4UnE1RWo4OVl2WGIzUDJlV0IzSlRm?=
 =?utf-8?B?R0tZYk5lZmRudGpmM0xnV1o2ejd0ZnFZWjB6ZlRKcUltbEgycXBpVDNHbitm?=
 =?utf-8?B?bmY5RDZic0ZqKzdtRmY1S3RyOGVqck5kUXF4dTArTmQ2bXNWNmN2cC9VMk5v?=
 =?utf-8?B?QW1odHVKQ3pXV0NkcU00RUlaQVZtWi80UkZFaTFSR1J0QU5CeWRuMDIvS3FM?=
 =?utf-8?B?MjJpVVRaNUEzOFJnNFowTUF6NnlXZVQxWG15cHNuajJLQ2ZtNmVDRDdEVWhr?=
 =?utf-8?B?Nm54M3RJenpyRmZkK3RqK1lSaUJoNTBYa0tPMTFlM29MOXY4NWZNU281WDR6?=
 =?utf-8?B?NTNpRytSY1JuODJyL1RWcFZZVE9xdXhjdDlBa1JpK0NRcVRrVUpPdFNlQlRK?=
 =?utf-8?B?RktTZklqaEMyUkpPZU9KRlkyQVpZMlQ1SGJveEx3U3RCdzZDQ1JGaUN4blJz?=
 =?utf-8?B?KzUxQ1N6R2lDbGtNVXorZU9KQjdCME02bzNtOE5tQllCSlpPV2ZWVjNBREt4?=
 =?utf-8?B?YXNhRUlydG5qazBsZXlWbGNCcUpSQXRIa3NtV3c1M2hucCtTd3VRTHQxcU11?=
 =?utf-8?B?QnVPQVhvLzU5RmgzUCtXeDBWbXduaHJ6dHlsYkxCZTMzUXdEM21NOTd5a0lr?=
 =?utf-8?B?SnNtV1NpdW5VdmJrcjEzU0oxZWdTMDF0Q1U1Q1gzT2NNUlNDV0R0L093WVN4?=
 =?utf-8?B?dkRraFI5RXNUMVZiQk9rQXhmS0MwNWwxY1BYN2JpMTFYc0FuVnNBZU52YVV4?=
 =?utf-8?B?OVNGSnZwb2RPTWdubE81Qk9pT0VKdTJSOS9OcDBJdy9EdnZRNHRPeWFSVWU2?=
 =?utf-8?B?TXp0VTNpY1ZnVEpFemZTV3Y5bytHd0Myd21HSTY3eGN5VkU1cjdyV2FVemRH?=
 =?utf-8?B?YWhlUVBtNWZ2c0xuNTkzTS8yQVA0Q1ErbTlmOTFMcEFzUU1oNGFJbzVSMDVU?=
 =?utf-8?B?dW1XSFpYL0dIZHBXSVdKRXppM2lQUEdDbnY4MDFKMDY0emZ1aXROM202RDI3?=
 =?utf-8?B?cjh1SEpDT0U3RFpJQ0hIYzR5cGxSZFBGMldQV21EajNEL3hOUVhWTnRLQnI5?=
 =?utf-8?Q?0zOHwf7fDXserHxKd9vMu/Q=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406f0021-3258-4ace-b45b-08da9c0af684
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 19:53:32.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QolEtCtG+lqaxqc+SH0n29SOmlc6/zFqZOaAQ4ILUQGosuSjOcysgI6P9u6PEwLXaCcFVzRwGJraohZvRWjH5M1/SQVqCGWWck6F3fD+Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8835
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-21 15:24, Mathieu Desnoyers wrote:
> Extend the rseq ABI to expose a NUMA node ID and a vm_vcpu_id field.
> 
> The NUMA node ID field allows implementing a faster getcpu(2) in libc.
> 
> The virtual cpu id allows ideal scaling (down or up) of user-space
> per-cpu data structures. The virtual cpu ids allocated within a memory
> space are tracked by the scheduler, which takes into account the number
> of concurrently running threads, thus implicitly considering the number
> of threads, the cpu affinity, the cpusets applying to those threads, and
> the number of logical cores on the system.
> 
> This series is based on the v5.19 tag.

Hi Peter,

I'm having MTA issues at the moment. I will resend the series as soon as 
I can get hold of my sysadmin.

Sorry about that.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> Mathieu Desnoyers (25):
>    rseq: Introduce feature size and alignment ELF auxiliary vector
>      entries
>    rseq: Introduce extensible rseq ABI
>    rseq: Extend struct rseq with numa node id
>    selftests/rseq: Use ELF auxiliary vector for extensible rseq
>    selftests/rseq: Implement rseq numa node id field selftest
>    lib: Invert _find_next_bit source arguments
>    lib: Implement find_{first,next}_{zero,one}_and_zero_bit
>    cpumask: Implement cpumask_{first,next}_{zero,one}_and_zero
>    sched: Introduce per memory space current virtual cpu id
>    rseq: Extend struct rseq with per memory space vcpu id
>    selftests/rseq: Remove RSEQ_SKIP_FASTPATH code
>    selftests/rseq: Implement rseq vm_vcpu_id field support
>    selftests/rseq: x86: Template memory ordering and percpu access mode
>    selftests/rseq: arm: Template memory ordering and percpu access mode
>    selftests/rseq: arm64: Template memory ordering and percpu access mode
>    selftests/rseq: mips: Template memory ordering and percpu access mode
>    selftests/rseq: ppc: Template memory ordering and percpu access mode
>    selftests/rseq: s390: Template memory ordering and percpu access mode
>    selftests/rseq: riscv: Template memory ordering and percpu access mode
>    selftests/rseq: Implement basic percpu ops vm_vcpu_id test
>    selftests/rseq: Implement parametrized vm_vcpu_id test
>    selftests/rseq: x86: Implement rseq_load_u32_u32
>    selftests/rseq: Implement numa node id vs vm_vcpu_id invariant test
>    selftests/rseq: parametrized test: Report/abort on negative cpu id
>    tracing/rseq: Add mm_vcpu_id field to rseq_update
> 
>   fs/binfmt_elf.c                               |    5 +
>   fs/exec.c                                     |    6 +
>   include/linux/cpumask.h                       |   86 ++
>   include/linux/find.h                          |  123 +-
>   include/linux/mm.h                            |   25 +
>   include/linux/mm_types.h                      |  110 +-
>   include/linux/sched.h                         |    9 +
>   include/trace/events/rseq.h                   |    7 +-
>   include/uapi/linux/auxvec.h                   |    2 +
>   include/uapi/linux/rseq.h                     |   22 +
>   init/Kconfig                                  |    4 +
>   kernel/fork.c                                 |   11 +-
>   kernel/ptrace.c                               |    2 +-
>   kernel/rseq.c                                 |   61 +-
>   kernel/sched/core.c                           |   49 +
>   kernel/sched/sched.h                          |  166 +++
>   kernel/signal.c                               |    2 +
>   lib/find_bit.c                                |   17 +-
>   tools/include/linux/find.h                    |    9 +-
>   tools/lib/find_bit.c                          |   17 +-
>   tools/testing/selftests/rseq/.gitignore       |    5 +
>   tools/testing/selftests/rseq/Makefile         |   20 +-
>   .../testing/selftests/rseq/basic_numa_test.c  |  117 ++
>   .../selftests/rseq/basic_percpu_ops_test.c    |   46 +-
>   tools/testing/selftests/rseq/basic_test.c     |    4 +
>   tools/testing/selftests/rseq/compiler.h       |    6 +
>   tools/testing/selftests/rseq/param_test.c     |  157 ++-
>   tools/testing/selftests/rseq/rseq-abi.h       |   22 +
>   tools/testing/selftests/rseq/rseq-arm-bits.h  |  505 +++++++
>   tools/testing/selftests/rseq/rseq-arm.h       |  701 +---------
>   .../testing/selftests/rseq/rseq-arm64-bits.h  |  392 ++++++
>   tools/testing/selftests/rseq/rseq-arm64.h     |  520 +------
>   .../testing/selftests/rseq/rseq-bits-reset.h  |   10 +
>   .../selftests/rseq/rseq-bits-template.h       |   39 +
>   tools/testing/selftests/rseq/rseq-mips-bits.h |  462 +++++++
>   tools/testing/selftests/rseq/rseq-mips.h      |  646 +--------
>   tools/testing/selftests/rseq/rseq-ppc-bits.h  |  454 +++++++
>   tools/testing/selftests/rseq/rseq-ppc.h       |  617 +--------
>   .../testing/selftests/rseq/rseq-riscv-bits.h  |  410 ++++++
>   tools/testing/selftests/rseq/rseq-riscv.h     |  529 +-------
>   tools/testing/selftests/rseq/rseq-s390-bits.h |  474 +++++++
>   tools/testing/selftests/rseq/rseq-s390.h      |  495 +------
>   tools/testing/selftests/rseq/rseq-skip.h      |   65 -
>   tools/testing/selftests/rseq/rseq-x86-bits.h  | 1036 ++++++++++++++
>   tools/testing/selftests/rseq/rseq-x86.h       | 1193 +----------------
>   tools/testing/selftests/rseq/rseq.c           |   86 +-
>   tools/testing/selftests/rseq/rseq.h           |  229 +++-
>   .../testing/selftests/rseq/run_param_test.sh  |    5 +
>   48 files changed, 5286 insertions(+), 4692 deletions(-)
>   create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c
>   create mode 100644 tools/testing/selftests/rseq/rseq-arm-bits.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-arm64-bits.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-bits-reset.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-bits-template.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-mips-bits.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-ppc-bits.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-riscv-bits.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-s390-bits.h
>   delete mode 100644 tools/testing/selftests/rseq/rseq-skip.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-x86-bits.h
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
