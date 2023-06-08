Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE972755E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjFHDCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjFHDBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:01:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850202121
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1pSeer6LTRfgpLkZ4lsbyqU7VwZycu3hes5oM82RRY4V06Kh7zvi9hfEBXy2TTIutsG1w+RiBO3GVkbUjiLSq6nHw+5ELjIsG9DyTxmkvyjBR1sk6Sek/xkzmmJPnYsu43e/cL6QsbIxCb3eLidheaYPqNScdKl9GrG73csBhstoOe+3ttbYItBlGi6LfzJ0P27pUJiS1Or6z0jVFLAiX92ZgY7GjwkqyiIwhris5gMpn5Z3AxNP6LemCX+V5xwGhho/XCOCgw9leQvU+UvAR6oFjb1Kekx6YMhg2W83Qu/RSg5GarheAKdNQxPQp/TrJFc71eJMnXjpk0n3KVoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVrxV1BlS4ygdIKsobbHC6LsYwiEUR8bGEydhjDQc4o=;
 b=CZpwrLJLgBgu01S+S/0Mvjbvhlcvj/vL8c23Ie6T2qDOMA2esJpxMBlz2HVN41dAuzOQI7vC5T2iLbtb5QRjpsficN9MYjH07FcMxGpiF9Lw1aL9Ak1tWWLD9bS10iZfeEBm80gwx0YF9ZmbU99zHIXjptlaTOLtY2HLMRjGLMH9HBLiTBjUspYIRKQfMXhTqZpHo2fH3eTrcjPTYR47uvqtWG9oLw5Cn8hTrHazMiT3MX8LPGejWe3uww8knDTwkfR7jdZKllmEHsQviuztW2Fbs4MtrwVr7dgij2PUDmPrrnuumtU8OLpw58gGfr+z0LuruOKfjG7wiW5q5eI5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVrxV1BlS4ygdIKsobbHC6LsYwiEUR8bGEydhjDQc4o=;
 b=r/uOmozKdFudDn/fB7c8k+YdsPnS3tYz/Alp1ZklAjRmYotL+Dak6l5A119eQ/WdvsTxqpMnDna2msQKY9GaGVU6GCpHWZ1X0mH4wO0SkuWW08h+k6td2wD4YkKbJfEV8T1/A55ZqrYOal+iUFIgiet5ykYLH6JRlLMXVWI6ebA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 03:01:47 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Thu, 8 Jun 2023
 03:01:47 +0000
Message-ID: <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
Date:   Thu, 8 Jun 2023 08:31:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZIEBB-A1arYKSK2P@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::12) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: f33f9284-aeaf-4678-ba8e-08db67ccb1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRo9XabbTjj2/QD6q6aBOQG7uTxOfDz/nnye7DCr/JBRCPNQVnd6XLX8HEZ9yZDJXPT77gWJoy50C2jSXxcZ3pmAtTKljaZzwc4yVnXosVeWK/5gxyzpDQdZ25ooCCaPYurTYl801IXsQQVX0mPJ+jHJGl47RuCqaL3xBMTspSSiSZEtlgR7rE63/w0gYsiFOG3Yp6ybMs9el1Lec38SA7Ka/PhD5r83Y7tnDl5h9XxeWhYgLOoTeekSZh2sNreZuHLF1wCzS1g/BJZUJFbnUnldTILgtTg2pkvVkwz3tVLAzpiCb+EQS56hqChzVxBce1tZbTV5wXMa+J7bfMZkF8vY1NAYLzE/Gt/9o96/xvIZGJ+aN0oPmOm1v2pn/9C5yiZUnbHIasNeSlZVc2TdfH0QKT6DxGW6Q1dGcoAFOBonTUZqv42gcTzK3VG09F9ErDe2xBFcOR0EbVt5y6U/KI2Bmw45X8X1Z69dDpvmd/2lHnXf5mgdzA1Yeqnj8XbMGGSVlm56ofX1/KmdS2M4WdZgK/BNIXltS4r6OOJZqMd2gUVruY1Xn/SxEIKQXUKWi1qgOonE3RKvFF37l+SR1RJhBYSeOlyumbwT7VchjlQdUh1wPJnHqElliA82w4JpqLu/oTZEZZFGTCHIieDzsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(66946007)(86362001)(36756003)(38100700002)(31696002)(31686004)(45080400002)(6486002)(6666004)(30864003)(2906002)(478600001)(6506007)(53546011)(316002)(26005)(186003)(83380400001)(2616005)(5660300002)(41300700001)(6916009)(66476007)(66556008)(7416002)(8676002)(6512007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRqU3R4Y0ZDR3NxQU9MbUp6cVQ3L0JKRDI5NGNINHFkcHRBcnBtN1JBRVYv?=
 =?utf-8?B?eFFqQ1d4KzRCMUxVcFZ5Z3gyWmo1bnNtdndYWWQ2V01ISnlIWE9LVVdpaFdW?=
 =?utf-8?B?S1VOOHNlbVM5ZmlQNXFHZ3huNzhYQkxEaFMzY2pCUzVMMUhVRVhtU0JFMmxo?=
 =?utf-8?B?dHA5Z0Z6ZzFpTzFpbjllTnFWTWJKUjhvMlEzemg4b3QrbnFYWkZReTh0aUs0?=
 =?utf-8?B?VGU0Mk9pZG5RSmQxVm01QVpBMWFzQ1hLbDYzQXpvMmFGRVZTcU1acnB2Slpx?=
 =?utf-8?B?Q3l4cjFPTzlsWVdKYUNVTHhPSDJZSWV6L2tnNThvdDlJZlR0c0FVeGRLbDNE?=
 =?utf-8?B?UHl1bk1wT21RZkR0QWhiZDVXSlZCTlN4UGxESFM1ZzJ2clk0NjRVVFRnb3RU?=
 =?utf-8?B?Uk1FZHpFMmdOMDVJY2Y3aUUyN2wzMERZOEpzNDNzZmZEdnkrN1BJOGZIWkZU?=
 =?utf-8?B?aE5GbUF2MVNHcGx5YVNnTUlic1ZKNzdXL3J2Tk9ha0dMa0tCRlY2RTNzbjRR?=
 =?utf-8?B?bEs1cGxQREFlNGJRNzNXd21wK2FhUWU5ekxFSkNOSFBrU0xibnB6cEFqT1l1?=
 =?utf-8?B?RHA3dkRwWHVEcDMzckFrK2FySWdXMnlVZ2JvYW03MDRHNFNteDhJRXFmdEdS?=
 =?utf-8?B?SGpJSzlsU0lDTS9XQmRiRjZxdTJzNlBIN2V2dlBTL094TUswZ05kQXIzWDRO?=
 =?utf-8?B?RzUxdXlkd2M5UTBBMzBjeTVabXNDcy92aXBsZU5oRXpXcXI2dUF1TDY0MDhR?=
 =?utf-8?B?SS9oMFRBR2RkUUlJN20xaysxT3piUUhzMExRMlRqUGRjTHI3bVNyRmlRd2ZD?=
 =?utf-8?B?Vng0Z2tDMjRRNG1DZGUzbVZnUitCc1JqWGtFTGJ5OHhQRWNvT3dRT09EVHhR?=
 =?utf-8?B?clhBVnhlNlZjT3pzWmFnTUU2Sno0NDc4ZSsyYnREUUZxeCtUR3RmbG1jaEN5?=
 =?utf-8?B?RWgwODc1bWFsY1dscU1FSWE4Y3pwbVNJYTJUakV0OHN2RmVXdFVTK2tRb3dH?=
 =?utf-8?B?cTAvcmtMSlFXK2U1UEdHNzVYTWhHS3p4VjJJNVd5S3FhakdvSGhrZHpGbmFC?=
 =?utf-8?B?TitwVmVXZWErK0ZLby9QV0p2YnVkclk5TFNZdHlPeXNKUVBiOFpyQmFRdWJy?=
 =?utf-8?B?OXBONXpQQnR6bDFHUFJsSVRkeUNUVWM5bE9oSXhBWVp6cG0xZG1YekpUOW5p?=
 =?utf-8?B?Rncxc3NEMXUvTlc3YWwzejZLS2Z3bnliWW9RS2lKUFNYWnBqaG5HeDVudmx5?=
 =?utf-8?B?S0dVWG9wRGF5ajVobktyQS9IcDN5NHpvR1RwK3Rwa1djRHBtaTRvbFMyaGRv?=
 =?utf-8?B?bEJZMWh3MmtZQTZ6eG1vcnR2NXBFdmlWUEhPWDl5TWs2MXd2VUZPNithUFl6?=
 =?utf-8?B?MnFTUFNNKzZ2akUzREttN3hDelJZeXZTQnRseHlKRW9EL3VZWVFZT0dFZTE1?=
 =?utf-8?B?djdZTU90TDFSTkdOUHVYTDJrVGFQclNwYVBLbmoxY3N3Ujc5VmRFZ0NxMjJx?=
 =?utf-8?B?eWt4TG5qUkpPSTlmRDdwM2JXNnVialZlUG9Ya0I0V1hzZklwTDdDNHBZQTZU?=
 =?utf-8?B?N1VDdG5aMnRsVXFyMVRHZnZsbnJSMkNjRTMyWm85QWYyVkdYUHFaWFpLUXUz?=
 =?utf-8?B?NUhzdEJoQ0VaWkV5YTNYTndwQ05pckU2MHNZZmN2QXVCN0FWeHg4bXh6VW40?=
 =?utf-8?B?bURkSWJwaldWSUZ0NXpRZTlpdXpRcnJ2T1dObGlxWUk2bEpRa3NNWEl3aWIw?=
 =?utf-8?B?WXZxdVZwWUVNZW1sOUdBVEJrbFJycktQSXJZTFgxem1JcTdndDVSODJpYkFo?=
 =?utf-8?B?b0F4SjU4em1wYUo4SEpyZ1pEUWNWMVV5WFYxMEpmRVU3QnZpMmxjTkUzYWhR?=
 =?utf-8?B?a0R5Z055VlNwZko0ZWc5alJoRUUxRU1pUEc5Rk5TRkVCUjdpY1JMZTl0Vi9u?=
 =?utf-8?B?Y2drZC92NE5vSk1RT2F0Q2pwK1JhT1NGdm5jWkY0ay85eFVoV3NjL0JvMnEw?=
 =?utf-8?B?YTZNdUpmVXJzZENLbXlSMXRyQ3A2eG9KQmtnNXpjSHV0K3ZhVFdnd2RhcEpt?=
 =?utf-8?B?eDJGQU4zemxkRWVJeCtqbTBtUFlodTY5WGE3UHdWcnJ0a1JzZjB3VWE2aGth?=
 =?utf-8?Q?GOoUuqErTj6f+ULJOWgTnDVoY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33f9284-aeaf-4678-ba8e-08db67ccb1f8
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 03:01:46.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HI2TEg0So5rqzFCbnzqW8s16Oknh8hOxF/BoLkKHWMPgeIJ/x7UGEppKf1Ky9wFnns4MGZqrEK92usasEPzoFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 6/8/2023 3:43 AM, Tejun Heo wrote:
> Hello,
> 
> On Wed, May 31, 2023 at 05:44:57PM +0530, K Prateek Nayak wrote:
> ...
>> The RIP points to dereferencing sd_llc_shared->has_idle_cores
>>
>>     $ scripts/faddr2line vmlinux select_task_rq_fair+0x9bd
>>     select_task_rq_fair+0x9bd/0x2570:
>>     test_idle_cores at kernel/sched/fair.c:6830
>>     (inlined by) select_idle_sibling at kernel/sched/fair.c:7189
>>     (inlined by) select_task_rq_fair at kernel/sched/fair.c:7710
> 
> Hmm... the only thing I can think of is workqueue setting ->wake_cpu to
> something invalid.
> 
>> My kernel is somewhat stable (I have not seen a panic for ~45min but I
>> was not stress testing the system either during that time) with the
>> following changes:
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index b2e914655f05..a279cc9c2248 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -2247,7 +2247,7 @@ static void unbind_worker(struct worker *worker)
>>         if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
>>                 WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
>>         else
>> -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>> +               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
>>  }
> 
> I'm not sure why changing the cpus_allowed_ptr would make a difference here.
> Maybe the chain of events involves CPUs going offline and the above migrate
> the tasks resetting their ->wake_cpu.
> 
> Can you please try the following branch and see if any of the warnings
> triggers?
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-dbg-invalid-cpu

Thank you for sharing the debug branch. I've managed to hit some one of
the WARN_ON_ONCE() consistently but I still haven't seen a kernel panic
yet. Sharing the traces below:

o Early Boot

    [    4.182411] ------------[ cut here ]------------
    [    4.186313] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:1130 kick_pool+0xdb/0xe0
    [    4.186313] Modules linked in:
    [    4.186313] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc1-tj-wq-valid-cpu+ #481
    [    4.186313] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [    4.186313] RIP: 0010:kick_pool+0xdb/0xe0
    [    4.186313] Code: 6b c0 d0 01 73 24 41 89 45 64 49 8b 54 24 f8 48 89 d0 30 c0 83 e2 04 ba 00 00 00 00 48 0f 44 c2 48 83 80 c0 00 00 00 01 eb 82 <0f> 0b eb dc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
    [    4.186313] RSP: 0018:ffffbc1b800e7dd8 EFLAGS: 00010046
    [    4.186313] RAX: 0000000000000100 RBX: ffff97c73d2321c0 RCX: 0000000000000000
    [    4.186313] RDX: 0000000000000040 RSI: 0000000000000001 RDI: ffff9788c0159728
    [    4.186313] RBP: ffffbc1b800e7df0 R08: 0000000000000100 R09: ffff9788c01593e0
    [    4.186313] R10: ffff9788c01593c0 R11: 0000000000000001 R12: ffffffff8c582430
    [    4.186313] R13: ffff9788c03fcd40 R14: 0000000000000000 R15: ffff97c73d2324b0
    [    4.186313] FS:  0000000000000000(0000) GS:ffff97c73d200000(0000) knlGS:0000000000000000
    [    4.186313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    4.186313] CR2: ffff97cecee01000 CR3: 000000470d43a001 CR4: 0000000000770ef0
    [    4.186313] PKRU: 55555554
    [    4.186313] Call Trace:
    [    4.186313]  <TASK>
    [    4.186313]  create_worker+0x14e/0x280
    [    4.186313]  ? wake_up_process+0x15/0x20
    [    4.186313]  workqueue_init+0x22a/0x3d0
    [    4.186313]  kernel_init_freeable+0x1fe/0x4f0
    [    4.186313]  ? __pfx_kernel_init+0x10/0x10
    [    4.186313]  kernel_init+0x1b/0x1f0
    [    4.186313]  ? __pfx_kernel_init+0x10/0x10
    [    4.186313]  ret_from_fork+0x2c/0x50
    [    4.186313]  </TASK>
    [    4.186313] ---[ end trace 0000000000000000 ]---

o I consistently see a WARN_ON_ONCE() in kick_pool() being hit when I
  run "sudo ./stress-ng --iomix 96 --timeout 1m". I've seen few
  different stack traces so far. Including all below just in case:

  o First

    [  780.818319] ------------[ cut here ]------------
    [  780.822952] WARNING: CPU: 190 PID: 10639 at kernel/workqueue.c:1130 kick_pool+0xdb/0xe0
    [  780.830959] Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
    nf_defrag_ipv4 bpfilter br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio overlay binfmt_misc nls_iso8859_1 ipmi_ssif intel_rapl_msr intel_rapl_common
    amd64_edac kvm_amd dell_smbios dcdbas kvm acpi_ipmi rapl dell_wmi_descriptor wmi_bmof ccp ptdma k10temp ipmi_si acpi_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc 
    scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov 
    async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper syscopyarea sysfillrect sysimgblt 
    crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd drm tg3 cryptd xhci_pci
    [  780.831013]  xhci_pci_renesas megaraid_sas wmi
    [  780.925011] CPU: 190 PID: 10639 Comm: stress-ng-iomix Tainted: G        W          6.4.0-rc1-tj-wq-valid-cpu+ #481
    [  780.935351] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [  780.942917] RIP: 0010:kick_pool+0xdb/0xe0
    [  780.946938] Code: 6b c0 d0 01 73 24 41 89 45 64 49 8b 54 24 f8 48 89 d0 30 c0 83 e2 04 ba 00 00 00 00 48 0f 44 c2 48 83 80 c0 00 00 00 01 eb 82 <0f> 0b eb dc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
    [  780.965684] RSP: 0018:ffffbc1b943f7920 EFLAGS: 00010046
    [  780.970910] RAX: 0000000000000100 RBX: ffff97c73f1b24f0 RCX: 0000000000000000
    [  780.978040] RDX: 0000000000000040 RSI: 0000000000000001 RDI: ffff9788c0165648
    [  780.985167] RBP: ffffbc1b943f7938 R08: 0000000000000100 R09: ffffffff8c489768
    [  780.992298] R10: c8b223d88897ffff R11: 0000000000000000 R12: ffff9788c6fc3c48
    [  780.999422] R13: ffff978915854d40 R14: ffff9788cb82a000 R15: ffff9788c6fc3c40
    [  781.006547] FS:  00007fb7f5f39f00(0000) GS:ffff97c73f180000(0000) knlGS:0000000000000000
    [  781.014631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  781.020370] CR2: 00007fb7f5da0890 CR3: 0000000114810003 CR4: 0000000000770ee0
    [  781.027504] PKRU: 55555554
    [  781.030215] Call Trace:
    [  781.032663]  <TASK>
    [  781.034771]  __queue_work.part.0+0x1f2/0x4c0
    [  781.039040]  __queue_work+0x37/0x90
    [  781.042531]  __queue_delayed_work+0x67/0xa0
    [  781.046717]  mod_delayed_work_on+0x5e/0xa0
    [  781.050817]  kblockd_mod_delayed_work_on+0x1b/0x30
    [  781.055610]  blk_mq_delay_run_hw_queue+0xe1/0x150
    [  781.060316]  blk_mq_run_hw_queue+0x132/0x1a0
    [  781.064590]  blk_mq_submit_bio+0x3dd/0x600
    [  781.068689]  __submit_bio+0xa6/0x1a0
    [  781.072267]  submit_bio_noacct_nocheck+0x2c1/0x380
    [  781.077061]  ? page_mapping+0x18/0x50
    [  781.080726]  submit_bio_noacct+0x1b7/0x570
    [  781.084825]  submit_bio+0x47/0x70
    [  781.088144]  submit_bh_wbc+0x133/0x150
    [  781.091897]  submit_bh+0x10/0x20
    [  781.095129]  ext4_read_bh+0x51/0xb0
    [  781.098622]  ext4_read_inode_bitmap+0x41e/0x5d0
    [  781.103156]  __ext4_new_inode+0x370/0x1740
    [  781.107256]  ? ext4_fname_prepare_lookup+0x8f/0xd0
    [  781.112047]  ? from_kgid+0x12/0x20
    [  781.115454]  ext4_mkdir+0x157/0x330
    [  781.118947]  vfs_mkdir+0x195/0x250
    [  781.122353]  do_mkdirat+0x128/0x160
    [  781.125845]  __x64_sys_mkdir+0x4c/0x70
    [  781.129599]  do_syscall_64+0x5c/0x90
    [  781.133177]  ? exit_to_user_mode_prepare+0x35/0x170
    [  781.138058]  ? irqentry_exit_to_user_mode+0x9/0x20
    [  781.142850]  ? irqentry_exit+0x3b/0x50
    [  781.146602]  ? exc_page_fault+0x8a/0x180
    [  781.150528]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
    [  781.155579] RIP: 0033:0x7fb7f5d1460b
    [  781.159160] Code: 8b 05 29 48 10 00 41 bc ff ff ff ff 64 c7 00 16 00 00 00 e9 4f ff ff ff e8 22 21 02 00 66 90 f3 0f 1e fa b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 47 10 00 f7 d8 64 89 01 48
    [  781.177907] RSP: 002b:00007ffc6ad02d08 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
    [  781.185472] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007fb7f5d1460b
    [  781.192596] RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00007ffc6ad02d10
    [  781.199728] RBP: 000000000000298f R08: 00007fb7f5dd1460 R09: 00007ffc6ad02a60
    [  781.206853] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc6ad04e90
    [  781.213985] R13: 00007ffc6ad04fe0 R14: 00007ffc6ad02d10 R15: 00007fb7f5bbddc0
    [  781.221111]  </TASK>
    [  781.223302] ---[ end trace 0000000000000000 ]---

    o Second

    [  807.362430] ------------[ cut here ]------------
    [  807.367062] WARNING: CPU: 164 PID: 3274 at kernel/workqueue.c:1130 kick_pool+0xdb/0xe0
    [  807.374981] Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 
    nf_defrag_ipv4 bpfilter br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio overlay binfmt_misc nls_iso8859_1 ipmi_ssif intel_rapl_msr intel_rapl_common 
    amd64_edac kvm_amd dell_smbios dcdbas kvm acpi_ipmi rapl dell_wmi_descriptor wmi_bmof ccp ptdma k10temp ipmi_si acpi_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc 
    scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov 
    async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper syscopyarea sysfillrect sysimgblt 
    crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd drm tg3 cryptd xhci_pci
    [  807.375031]  xhci_pci_renesas megaraid_sas wmi
    [  807.469026] CPU: 164 PID: 3274 Comm: jbd2/sda4-8 Tainted: G        W          6.4.0-rc1-tj-wq-valid-cpu+ #481
    [  807.478931] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [  807.486497] RIP: 0010:kick_pool+0xdb/0xe0
    [  807.490510] Code: 6b c0 d0 01 73 24 41 89 45 64 49 8b 54 24 f8 48 89 d0 30 c0 83 e2 04 ba 00 00 00 00 48 0f 44 c2 48 83 80 c0 00 00 00 01 eb 82 <0f> 0b eb dc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
    [  807.509257] RSP: 0018:ffffbc1b9422f9a8 EFLAGS: 00010046
    [  807.514482] RAX: 0000000000000100 RBX: ffff97c73eb324f0 RCX: 0000000000000000
    [  807.521605] RDX: 0000000000000080 RSI: 0000000000000041 RDI: ffff9788c0165410
    [  807.528731] RBP: ffffbc1b9422f9c0 R08: 0000000000000100 R09: ffffffff8c489768
    [  807.535862] R10: 0000000000000000 R11: ffff97890272fff0 R12: ffff9788fd6f2248
    [  807.542995] R13: ffff9789198f4d40 R14: ffff9788cb05d000 R15: ffff9788fd6f2240
    [  807.550120] FS:  0000000000000000(0000) GS:ffff97c73eb00000(0000) knlGS:0000000000000000
    [  807.558205] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  807.563943] CR2: 00007fcda13a0890 CR3: 00000001172c6005 CR4: 0000000000770ee0
    [  807.571067] PKRU: 55555554
    [  807.573771] Call Trace:
    [  807.576220]  <TASK>
    [  807.578325]  __queue_work.part.0+0x1f2/0x4c0
    [  807.582604]  __queue_work+0x37/0x90
    [  807.586095]  __queue_delayed_work+0x67/0xa0
    [  807.590273]  mod_delayed_work_on+0x5e/0xa0
    [  807.594371]  kblockd_mod_delayed_work_on+0x1b/0x30
    [  807.599164]  blk_mq_kick_requeue_list+0x1c/0x30
    [  807.603698]  blk_flush_complete_seq+0x1c5/0x2c0
    [  807.608231]  ? __blk_mq_alloc_requests+0x2e8/0x330
    [  807.613024]  blk_insert_flush+0xfc/0x180
    [  807.616950]  blk_mq_submit_bio+0x539/0x600
    [  807.621048]  __submit_bio+0xa6/0x1a0
    [  807.624628]  submit_bio_noacct_nocheck+0x2c1/0x380
    [  807.629422]  ? page_mapping+0x18/0x50
    [  807.633095]  submit_bio_noacct+0x1b7/0x570
    [  807.637186]  submit_bio+0x60/0x70
    [  807.640498]  submit_bh_wbc+0x133/0x150
    [  807.644250]  submit_bh+0x10/0x20
    [  807.647484]  journal_submit_commit_record.part.0.constprop.0+0x11d/0x1d0
    [  807.654181]  jbd2_journal_commit_transaction+0x1448/0x1980
    [  807.659659]  ? lock_timer_base+0x3b/0xd0
    [  807.663586]  kjournald2+0xab/0x270
    [  807.666992]  ? __pfx_autoremove_wake_function+0x10/0x10
    [  807.672219]  ? __pfx_kjournald2+0x10/0x10
    [  807.676229]  kthread+0xf7/0x130
    [  807.679376]  ? __pfx_kthread+0x10/0x10
    [  807.683128]  ret_from_fork+0x2c/0x50
    [  807.686707]  </TASK>
    [  807.688891] ---[ end trace 0000000000000000 ]---

    o Third
    
    [ 1244.765696] ------------[ cut here ]------------
    [ 1244.770323] WARNING: CPU: 60 PID: 19932 at kernel/workqueue.c:1130 kick_pool+0xdb/0xe0
    [ 1244.778251] Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 
    nf_defrag_ipv4 bpfilter br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio overlay binfmt_misc nls_iso8859_1 ipmi_ssif intel_rapl_msr intel_rapl_common 
    amd64_edac kvm_amd dell_smbios dcdbas kvm acpi_ipmi rapl dell_wmi_descriptor wmi_bmof ccp ptdma k10temp ipmi_si acpi_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc 
    scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov 
    async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper syscopyarea sysfillrect sysimgblt 
    crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd drm tg3 cryptd xhci_pci
    [ 1244.778299]  xhci_pci_renesas megaraid_sas wmi
    [ 1244.872295] CPU: 60 PID: 19932 Comm: stress-ng Tainted: G        W          6.4.0-rc1-tj-wq-valid-cpu+ #481
    [ 1244.882061] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [ 1244.889628] RIP: 0010:kick_pool+0xdb/0xe0
    [ 1244.893640] Code: 6b c0 d0 01 73 24 41 89 45 64 49 8b 54 24 f8 48 89 d0 30 c0 83 e2 04 ba 00 00 00 00 48 0f 44 c2 48 83 80 c0 00 00 00 01 eb 82 <0f> 0b eb dc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
    [ 1244.912385] RSP: 0018:ffffbc1b8de10e08 EFLAGS: 00010046
    [ 1244.917604] RAX: 0000000000000100 RBX: ffff97c73e1321c0 RCX: 0000000000000000
    [ 1244.924737] RDX: 0000000000000040 RSI: 0000000000000039 RDI: ffff9788c015de68
    [ 1244.931869] RBP: ffffbc1b8de10e20 R08: 0000000000000100 R09: ffffffff8c489768
    [ 1244.939000] R10: 0000000000000002 R11: 000000000000013a R12: ffff97c73e120d20
    [ 1244.946125] R13: ffff9788fae73380 R14: ffff9788c0171400 R15: ffff97c73e120d18
    [ 1244.953252] FS:  00007f8747b89f00(0000) GS:ffff97c73e100000(0000) knlGS:0000000000000000
    [ 1244.961335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [ 1244.967074] CR2: 00007fff1207f170 CR3: 00000001182d8003 CR4: 0000000000770ee0
    [ 1244.974197] PKRU: 55555554
    [ 1244.976902] Call Trace:
    [ 1244.979347]  <IRQ>
    [ 1244.981369]  __queue_work.part.0+0x1f2/0x4c0
    [ 1244.985637]  delayed_work_timer_fn+0x3c/0x90
    [ 1244.989903]  ? __pfx_delayed_work_timer_fn+0x10/0x10
    [ 1244.994867]  call_timer_fn+0x2c/0x150
    [ 1244.998534]  ? __pfx_delayed_work_timer_fn+0x10/0x10
    [ 1245.003491]  __run_timers.part.0+0x16f/0x2a0
    [ 1245.007763]  ? ktime_get+0x46/0xc0
    [ 1245.011162]  ? native_apic_msr_write+0x30/0x40
    [ 1245.015606]  ? lapic_next_event+0x20/0x30
    [ 1245.019619]  ? clockevents_program_event+0xad/0x130
    [ 1245.024499]  run_timer_softirq+0x2a/0x60
    [ 1245.028418]  __do_softirq+0xdd/0x31a
    [ 1245.031996]  ? hrtimer_interrupt+0x12b/0x240
    [ 1245.036269]  __irq_exit_rcu+0x83/0xb0
    [ 1245.039934]  irq_exit_rcu+0xe/0x20
    [ 1245.043333]  sysvec_apic_timer_interrupt+0x80/0x90
    [ 1245.048126]  </IRQ>
    [ 1245.050231]  <TASK>
    [ 1245.052327]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
    [ 1245.057468] RIP: 0010:pcpu_alloc+0x3fe/0x830
    [ 1245.061741] Code: 98 32 4f 01 89 da 31 f6 83 c3 01 4c 01 e7 48 03 3c d0 4c 89 ea e8 f2 d3 c7 00 8b 35 6c 75 aa 01 48 63 d3 48 c7 c7 e0 5e 80 8c <e8> 6d da 3c 00 39 05 57 75 aa 01 48 89 c3 77 bf 48 8b 45 88 49 03
    [ 1245.080485] RSP: 0018:ffffbc1b9e607c00 EFLAGS: 00000246
    [ 1245.085705] RAX: ffffdc1b7548010c RBX: 00000000000000db RCX: 0000000000000000
    [ 1245.092838] RDX: 00000000000000db RSI: 0000000000000100 RDI: ffffffff8c805ee0
    [ 1245.099970] RBP: ffffbc1b9e607c88 R08: 00000000000000da R09: 0000000000000004
    [ 1245.107103] R10: ffffdc1b7548010c R11: 0000000000000044 R12: 000000000000010c
    [ 1245.114227] R13: 0000000000000004 R14: ffff97890e267800 R15: 0000000000000000
    [ 1245.121362]  __alloc_percpu_gfp+0x12/0x20
    [ 1245.125371]  __percpu_counter_init+0x23/0x90
    [ 1245.129643]  mm_init+0x2cb/0x430
    [ 1245.132878]  copy_process+0x10d6/0x1d70
    [ 1245.136716]  kernel_clone+0x9d/0x3c0
    [ 1245.140288]  ? __handle_mm_fault+0x8f2/0xd40
    [ 1245.144560]  __do_sys_clone+0x66/0x90
    [ 1245.148226]  __x64_sys_clone+0x25/0x30
    [ 1245.151971]  do_syscall_64+0x5c/0x90
    [ 1245.155548]  ? exit_to_user_mode_prepare+0x35/0x170
    [ 1245.160430]  ? irqentry_exit_to_user_mode+0x9/0x20
    [ 1245.165221]  ? irqentry_exit+0x3b/0x50
    [ 1245.168966]  ? exc_page_fault+0x8a/0x180
    [ 1245.172882]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
    [ 1245.177927] RIP: 0033:0x7f87478eabc7
    [ 1245.181506] Code: bb 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
    [ 1245.200243] RSP: 002b:00007fff1207ec08 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
    [ 1245.207801] RAX: ffffffffffffffda RBX: 00007f8747d0f040 RCX: 00007f87478eabc7
    [ 1245.214924] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
    [ 1245.222050] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fff1207f170
    [ 1245.229184] R10: 00007f8747b8a1d0 R11: 0000000000000246 R12: 0000000000000001
    [ 1245.236315] R13: 000000000000001e R14: 00007fff1207f170 R15: 00007f87477d2310
    [ 1245.243440]  </TASK>
    [ 1245.245624] ---[ end trace 0000000000000000 ]---

    o Fourth

    [ 1471.729126] ------------[ cut here ]------------
    [ 1471.733841] WARNING: CPU: 9 PID: 21785 at kernel/workqueue.c:1130 kick_pool+0xdb/0xe0
    [ 1471.741683] Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 
    nf_defrag_ipv4 bpfilter br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio overlay binfmt_misc nls_iso8859_1 ipmi_ssif intel_rapl_msr intel_rapl_common 
    amd64_edac kvm_amd dell_smbios dcdbas kvm acpi_ipmi rapl dell_wmi_descriptor wmi_bmof ccp ptdma k10temp ipmi_si acpi_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc 
    scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov 
    async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper syscopyarea sysfillrect sysimgblt 
    crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd drm tg3 cryptd xhci_pci
    [ 1471.741770]  xhci_pci_renesas
    [ 1471.763157] stress-ng-iomix (21877): drop_caches: 1
    [ 1471.771749] stress-ng-iomix (21863): drop_caches: 1
    [ 1471.771999] stress-ng-iomix (21870): drop_caches: 1
    [ 1471.831323]  megaraid_sas wmi
    [ 1471.831329] CPU: 9 PID: 21785 Comm: stress-ng-iomix Tainted: G        W          6.4.0-rc1-tj-wq-valid-cpu+ #481
    [ 1471.831336] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [ 1471.831338] RIP: 0010:kick_pool+0xdb/0xe0
    [ 1471.873732] Code: 6b c0 d0 01 73 24 41 89 45 64 49 8b 54 24 f8 48 89 d0 30 c0 83 e2 04 ba 00 00 00 00 48 0f 44 c2 48 83 80 c0 00 00 00 01 eb 82 <0f> 0b eb dc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
    [ 1471.892478] RSP: 0000:ffffbc1b809fce08 EFLAGS: 00010046
    [ 1471.897701] RAX: 0000000000000100 RBX: ffff97c73d4721c0 RCX: 0000000000000000
    [ 1471.904836] RDX: 0000000000000040 RSI: 000000000000000b RDI: ffff9788c015b2e8
    [ 1471.911967] RBP: ffffbc1b809fce20 R08: 0000000000000100 R09: ffffffff8c489768
    [ 1471.919101] R10: 0000000000000001 R11: 0000000000000201 R12: ffff97c73d46e8c8
    [ 1471.926233] R13: ffff9788e3b799c0 R14: ffff9788c02f7400 R15: ffff97c73d46e8c0
    [ 1471.933365] FS:  00007f7bcbc2bf00(0000) GS:ffff97c73d440000(0000) knlGS:0000000000000000
    [ 1471.941453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [ 1471.947196] CR2: 00007f7bcbd74048 CR3: 00000001240a6006 CR4: 0000000000770ee0
    [ 1471.954329] PKRU: 55555554
    [ 1471.957042] Call Trace:
    [ 1471.959490]  <IRQ>
    [ 1471.961511]  __queue_work.part.0+0x1f2/0x4c0
    [ 1471.965790]  delayed_work_timer_fn+0x3c/0x90
    [ 1471.970060]  ? __pfx_delayed_work_timer_fn+0x10/0x10
    [ 1471.975027]  call_timer_fn+0x2c/0x150
    [ 1471.978692]  ? __pfx_delayed_work_timer_fn+0x10/0x10
    [ 1471.983657]  __run_timers.part.0+0x16f/0x2a0
    [ 1471.987932]  ? ktime_get+0x46/0xc0
    [ 1471.991338]  ? native_apic_msr_write+0x30/0x40
    [ 1471.995785]  ? lapic_next_event+0x20/0x30
    [ 1471.999797]  ? clockevents_program_event+0xad/0x130
    [ 1472.004677]  run_timer_softirq+0x4b/0x60
    [ 1472.008603]  __do_softirq+0xdd/0x31a
    [ 1472.012183]  ? hrtimer_interrupt+0x12b/0x240
    [ 1472.016456]  __irq_exit_rcu+0x83/0xb0
    [ 1472.020121]  irq_exit_rcu+0xe/0x20
    [ 1472.023528]  sysvec_apic_timer_interrupt+0x80/0x90
    [ 1472.028319]  </IRQ>
    [ 1472.030427]  <TASK>
    [ 1472.032532]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
    [ 1472.037669] RIP: 0010:shmem_get_folio_gfp+0x109/0x750
    [ 1472.042722] Code: 49 0f ba 2f 00 0f 82 e2 03 00 00 48 8b 7d c8 48 8b 45 b8 48 39 47 18 0f 85 ea 03 00 00 83 7d c4 03 0f 84 ba 04 00 00 48 8b 07 <a8> 04 0f 84 5b 02 00 00 48 8b 7d c8 48 8b 45 a0 45 31 ff 48 89 38
    [ 1472.061470] RSP: 0000:ffffbc1bb58a7c30 EFLAGS: 00000297
    [ 1472.066697] RAX: 0017ffffc008001d RBX: ffff978928060fb0 RCX: 0000000000000002
    [ 1472.073826] RDX: 0000000080000000 RSI: 0000000000000000 RDI: fffff60845288200
    [ 1472.080951] RBP: ffffbc1bb58a7cb8 R08: 0000000000100cca R09: ffff9788e8d485c0
    [ 1472.088085] R10: 0000000000000000 R11: ffff9788e8d485c0 R12: ffff9788e8d485c0
    [ 1472.095219] R13: ffff9788e9d02a00 R14: 0000000000000000 R15: fffff60845288200
    [ 1472.102356]  shmem_fault+0x78/0x290
    [ 1472.105845]  __do_fault+0x39/0x140
    [ 1472.109250]  do_fault+0x2cf/0x430
    [ 1472.112569]  __handle_mm_fault+0x73b/0xd40
    [ 1472.116670]  handle_mm_fault+0x9e/0x2e0
    [ 1472.120506]  do_user_addr_fault+0x243/0x770
    [ 1472.124695]  exc_page_fault+0x79/0x180
    [ 1472.128448]  asm_exc_page_fault+0x27/0x30
    [ 1472.132458] RIP: 0033:0x5647c727779d
    [ 1472.136039] Code: ac 24 a8 00 00 00 48 8d 51 60 48 8b 4c 24 10 48 89 84 24 c8 00 00 00 48 8b 03 48 89 8c 24 c0 00 00 00 48 89 94 24 b8 00 00 00 <0f> 11 00 48 c7 40 10 00 00 00 00 48 8b 05 91 18 2e 00 48 8b 40 10
    [ 1472.154783] RSP: 002b:00007ffe655a2160 EFLAGS: 00010202
    [ 1472.160009] RAX: 00007f7bcbd74048 RBX: 00007ffe655a25a0 RCX: 00007f7bcb975cb8
    [ 1472.167142] RDX: 00007f7bcb759060 RSI: 0000000000000000 RDI: 00007ffe655a21e0
    [ 1472.174266] RBP: 00007ffe655a2330 R08: 00007f7bcbbd1460 R09: 00007ffe655a1f80
    [ 1472.181390] R10: 00007ffe655a2120 R11: 0000000000000246 R12: 00007f7bcb975390
    [ 1472.188523] R13: 0000000000005519 R14: 00007ffe655a25a0 R15: 00007f7bcb975e48
    [ 1472.195650]  </TASK>
    [ 1472.197842] ---[ end trace 0000000000000000 ]---


This is the same WARN_ON_ONCE() you had added in the HEAD commit:

    $ scripts/faddr2line vmlinux kick_pool+0xdb
    kick_pool+0xdb/0xe0:
    kick_pool at kernel/workqueue.c:1130 (discriminator 1)

    $ sed -n 1130,1132p kernel/workqueue.c
    if (!WARN_ON_ONCE(wake_cpu >= nr_cpu_ids))
        p->wake_cpu = wake_cpu;
    get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;

Let me know if you need any more data from my test setup.
P.S. The kernel is still up and running (~30min) despite hitting this
WARN_ON_ONCE() in my case :)

> 
> Thanks.
> 
 
--
Thanks and Regards,
Prateek
