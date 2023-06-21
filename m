Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45796738B88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjFUQhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjFUQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:37:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD631FD9;
        Wed, 21 Jun 2023 09:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/5ZScoe5hplK9owxbVtZAfUltKfxU/aAkXqvf2n+pk6yzrysyxJ8pYkvp+eOLw8pQbLwhhqcEqNMnGAUyivG8R2OjmLlYJmcZr7RcDmBO3fGi//i0avUquhmf2uMgFyfKWlsOJ4mUiyB/Tf/AY+X9nTZnV3Mat02oE9qgYrUIxJxtKaJ/AwmTm5uINKt3xjmHPzeUDqzdMMfdyVqnAbMpAvt9rsuE9Xvmu1BO/Zj1mNSb2YiJDozB7beSaqmNYZ8RWfqgmVl5Odm2POeBWYyWt5Ii04T5ZM3qvqOwYsCY3zYjwad/J1F5uXwxfaD/CUuCseIRv8j7LLDErBU/gqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwYWuFTss1Huf7Rv0/psfjsTLEpSJwFIiFQbyFa96J0=;
 b=QMlljmsDz5kSX+UMN5ilGTnPGO2pcfvS4sdKw8UFm52xtu4DiYe74XF3gl9DRtHDZIUGbKInTRCfHGaUc1q3nPut9/TZQotUFqkCSYc7FxfdA/ttDjjF4bvo0198UtTXYag4IIMQ7IJ1m5cXVFk2e7/qSAkl4ZqIL6a7rx5ncXaV5d+Wtzxb9QZZPzaTO9G3K8rgea6DaN/4rpiB0drFL8kikt8YhbXZbBxBQidT5OK7MrfU+GqGa03d+vFdv3YzvSMz3JoPB/vZf7uuYLtXW9ebZrn+BGaxK+Qa7pUMzD7sv5oc2i5YQIRLFQ3xqK9xJTDA7bL7d6hZbk0a8J7hQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwYWuFTss1Huf7Rv0/psfjsTLEpSJwFIiFQbyFa96J0=;
 b=IRfWP5flYXr0caT/3ZryHCo65Nl8YFyrWl6Wj8SdmgmXW6hyVlY+trZbqcfzT5Yh8YfFJVZ3vIYhXJEtCJQS/ldJvbda83JhFDyPzRSMEKPRCJCjl62l/+TW6cbojpRkKW5h+9jwZMRav5wcjW4z4JCG1yjJUxJkChz0yoUsR2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 21 Jun 2023 16:36:47 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 16:36:47 +0000
Message-ID: <ddbd1564-8135-5bc3-72b4-afb7c6e9caba@amd.com>
Date:   Wed, 21 Jun 2023 22:06:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
 <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::10) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|SA0PR12MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: c5975a27-3751-465c-4f36-08db7275b4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hlkplOJOFQR4tzLp1Cmb19xUfD9bX3kNbB/4a2Q5E3YrcSi6tcvsbkh6QklFt4F9FAmra3qafEMKlL6WFv4HohZ1lxJuIqMQNRH4MYZMR93A0l2vULENanUKyfE0Baj4ld3sRBob6f1vjIAXfTvZPfY4x9vD02JMtBm37FNMtcvU+SGe25ODiIea1R1KE6jhs1UqllFMCgZgOd3/ioPiPZBk69Sr4IGErWiSL1YQq47CFrWRLhxyjkxrf8OiPBnbNUy8ZzQN76wDcH9EQCWQtJHpoZ6fKaLB2FxIh11XBtQnarvEpQqxmYA+l+5g3LKUvUhpKIDUpsnNNQdx/Voft6UUes8wubUqNH2pyN50Zoy4ZIX3gPDufq+tH16Te0LN9a/VoSC0iIvK4UTj7bqP1b1v/WqZP/caLJhZaIqw2REbbgZ3dEYpjZ9halNr6mvKPTxyWlLSlF5hbOj3KQTJ/cDlMqUP3rxiUs3R0eqfQix10lxjrxhL2YZxYYNSJKSJKeUKDYmf4gK9MomRx1aVhB+qckuILMuQX54D0LZcHZJmWmbv6/u0EPsRhElFNbNbNwM0utTPTo9Ae/OfvAe8/fPsP3mQrj84punRYtta26UwVloGZmRPSHSvkgK+96Uix0ng5qCCPqk6OnrK+1XTpq1axgfCxhWdwPbFd0riesDwLokSXGl2lyAcY72ZG01
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(6486002)(6666004)(478600001)(36756003)(83380400001)(38100700002)(2616005)(31696002)(86362001)(186003)(53546011)(966005)(6506007)(26005)(6512007)(8936002)(8676002)(41300700001)(31686004)(5660300002)(30864003)(2906002)(54906003)(110136005)(316002)(66946007)(66476007)(66556008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhqclprUUxnS2E2K1dsYXZ1T0d6TDE0R1lvWmxEbWo5WGZMR2x5aTNvNEVY?=
 =?utf-8?B?WXpPdVc1L0IvVEliQ0RJOWRzNkFIU0R2d1BlbW5CZEppQ09VOEdEREpWSEc3?=
 =?utf-8?B?cS80Z0NWczB2UU9xTVlpdVcvcGR0ek1USldMSWw5UldERXZYd0s0c25Pcms3?=
 =?utf-8?B?VDJ4SlNnK2dBa2EwaUd3ODFWaTh1b1pQN3F6Z1QxMkVUUVVjYW0ydzh2MEZi?=
 =?utf-8?B?bmdhUVlPZThGS212UWVLdlg1MlBxQWZ0ZWdMaUNUeUhicXNOZGp6ckM2aGV2?=
 =?utf-8?B?TGxPTHlQUitNUjR4OVpjeVpVOGMwb2IvTUc0Z1ZHZThWWlV3N3RZVHJNSzZL?=
 =?utf-8?B?TUdORkduc0hlN2lNTGhLdGRWd0dVUG43SGc2RG5sN0R2c0xaN1dMRElWanYz?=
 =?utf-8?B?dm1pMEFwQkhhMURGMUVaWDZ3WE5NTllqUk9WOS9xK0JYbXhOdHFFbWpxT1Qr?=
 =?utf-8?B?Z01UeUhqbHQxNVdOUklUUFVzWkFIRDhuekJEcWQrSnVmeGRlTFcxdWZJNDNm?=
 =?utf-8?B?Yy9sR1o1M3I5ZFduT2R3eE1MdGp3aEhGa2FsSFRGUzlyQ1A2aGRQcysvZWd2?=
 =?utf-8?B?VlBUbUFYWnAzZlg3a0JyZHkwNDhubjE1cUd3K2VrK0Fjemo3WCs4a2J0TzRY?=
 =?utf-8?B?NE5CeUdnQ203QkpoU2FRMVVWcEtCME5aYVRycjYySlZKcCtHdks1SnJ0ZDUx?=
 =?utf-8?B?eGo0OVFlQi9KNUtOYXpLZ2RZTkJydVMvYkY3Tyt2VDZnOFFyNkRqamlWckhT?=
 =?utf-8?B?N1JyT0Qybis2RlBTMCs0d2tDeFZENXVuV3doWlVpVlRuUmJrTVhvTmNLaUNL?=
 =?utf-8?B?b3RLaUp5VExKNnBvTXFOZWZ4Q1BtZkx5ZFFhYTBWT3EvV1FLQ1k2SWp3QUg2?=
 =?utf-8?B?U2hQQTRRNi91czhhcEljWHdDTzdNa0NhMGpkNW9WVVo3MGlOSHJ5Tm9ZUEFT?=
 =?utf-8?B?Z2lxYitIZElyNVdVazFPbW9zRFF0NVQ3RTdyRENPOUpaSXB6bi9oRFo4SkEy?=
 =?utf-8?B?Q3h3c2c4REdEQnVYcnhlV0Nha2RlWURML1JlSU9xRFV3K0tvQUtjSDI3YmJG?=
 =?utf-8?B?RVgvQmx3UjNEQWdLaVZLL1lwRjNFR1NUYWNlSHhTSkRKa2N3T21DaDhNdU5s?=
 =?utf-8?B?ZWkvdWZEZGIyWUVkSnZ0MEEzMXN0aUtMNGZLejdqeUdtVDMzZ2IwclYveHA2?=
 =?utf-8?B?VUtjazhEUXROOTJEV2EzaStjbmpPUmUyWVliK1FFSnUvSFhFOEdVa2VkZnh0?=
 =?utf-8?B?K0szODNKeHlFaGVSV2I5ZTZMMVlTUVdmSCtxYTBOUENndkhHRmN4L0lrOExM?=
 =?utf-8?B?Nmlwc2drMXR1UnV0QmFrdzV0OFlKbVUxSDA5WDI5NmFzTUVpcE4wcjZtY3FR?=
 =?utf-8?B?N0IzYUxLMEF6M3RsRlpaTUNPdk90RGhHOThkWHNQMDh5SjNjT1c1VHhTTWJS?=
 =?utf-8?B?Y0NVU29laUJLMFdBSHJtY0JQb0ZhbXIzTnE1Z0hTaWMxVFYvS09TbTNxUjlT?=
 =?utf-8?B?aTB5SDQ2SnlicjlvWVc4bjdlQmZmbk94WE8zTnJUS1E4Zk9vbVlRTVJsWWd4?=
 =?utf-8?B?VGQ0NXB3VVdVQ3dpSnlpZzVnUzk1bm1SNExUbE1HMC91cXZiK3VNQVhZRzJ0?=
 =?utf-8?B?R1poQWYxKzhUNE01VnloNlord05OQjVMN0JoQnVZTllQaXJkUjEwMVNocTFY?=
 =?utf-8?B?ZmNBVG81Uk1WSTQ4MUxWUzJpRVlVS2dKQkNQalVOc1RpQkdjejN0YUpRVGV5?=
 =?utf-8?B?R3RRNHFCOUorMkEyN2N4NXpmT3NxUFVRc3lwL2UvN1kxczhRWWhybEY5OTdi?=
 =?utf-8?B?RU9hamZJVXRHc0dYUGc3ekpCR3lCMzJMWEtQUXBnckZJcVFXd3B6RXZiZHZl?=
 =?utf-8?B?VFBaSWJESXR4bzF0aktaVG9lU0tqNG8rQVhIdlAxZkhXVVMxRGJuSmpleVkr?=
 =?utf-8?B?UmpmYm5scm1wUzJZcmp1T2xaWENEWUh5N1M2UVJ3ZnQ2Z2JiL0Q5RVVjemJy?=
 =?utf-8?B?RWs1cHU1VVJHZDRaczhZOEZScGkxcEJsQzA0RWlSNXVMSnR5T2VXMDh0QmpH?=
 =?utf-8?B?YmZHR3o0MXpLQTY1MVdQM1IyRytpaVJpVkRSWHNwbjc0by9SUHF3WEJYODRY?=
 =?utf-8?Q?ap76NKv8Sy/c9tRjJ8IAcTDco?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5975a27-3751-465c-4f36-08db7275b4ca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:36:47.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR3PfJIZMoSCbkIFFbP0uT8Z6OI0kfXiQdN4NMECKRSE3O93ec3hoaG90H6R1/GQ9gKogSut5hAJMcSEPmtX2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 6/20/2023 4:21 PM, Mathieu Desnoyers wrote:
> On 6/20/23 06:35, Swapnil Sapkal wrote:
>> Hello Peter,
>>
>> On 6/20/2023 2:41 PM, Peter Zijlstra wrote:
>>> On Tue, Jun 20, 2023 at 01:44:32PM +0530, Swapnil Sapkal wrote:
>>>> Hello Mathieu,
>>>>
>>>> On 4/22/2023 1:13 PM, tip-bot2 for Mathieu Desnoyers wrote:
>>>>> The following commit has been merged into the sched/core branch of tip:
>>>>>
>>>>> Commit-ID:     223baf9d17f25e2608dbdff7232c095c1e612268
>>>>> Gitweb: https://git.kernel.org/tip/223baf9d17f25e2608dbdff7232c095c1e612268
>>>>> Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>> AuthorDate:    Thu, 20 Apr 2023 10:55:48 -04:00
>>>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>>>> CommitterDate: Fri, 21 Apr 2023 13:24:20 +02:00
>>>>>
>>>>> sched: Fix performance regression introduced by mm_cid
>>>>>
>>>>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>>>>> sysbench regression reported by Aaron Lu.
>>>>>
>>>>> Keep track of the currently allocated mm_cid for each mm/cpu rather than
>>>>> freeing them immediately on context switch. This eliminates most atomic
>>>>> operations when context switching back and forth between threads
>>>>> belonging to different memory spaces in multi-threaded scenarios (many
>>>>> processes, each with many threads). The per-mm/per-cpu mm_cid values are
>>>>> serialized by their respective runqueue locks.
>>>>>
>>>>> Thread migration is handled by introducing invocation to
>>>>> sched_mm_cid_migrate_to() (with destination runqueue lock held) in
>>>>> activate_task() for migrating tasks. If the destination cpu's mm_cid is
>>>>> unset, and if the source runqueue is not actively using its mm_cid, then
>>>>> the source cpu's mm_cid is moved to the destination cpu on migration.
>>>>>
>>>>> Introduce a task-work executed periodically, similarly to NUMA work,
>>>>> which delays reclaim of cid values when they are unused for a period of
>>>>> time.
>>>>>
>>>>> Keep track of the allocation time for each per-cpu cid, and let the task
>>>>> work clear them when they are observed to be older than
>>>>> SCHED_MM_CID_PERIOD_NS and unused. This task work also clears all
>>>>> mm_cids which are greater or equal to the Hamming weight of the mm
>>>>> cidmask to keep concurrency ids compact.
>>>>>
>>>>> Because we want to ensure the mm_cid converges towards the smaller
>>>>> values as migrations happen, the prior optimization that was done when
>>>>> context switching between threads belonging to the same mm is removed,
>>>>> because it could delay the lazy release of the destination runqueue
>>>>> mm_cid after it has been replaced by a migration. Removing this prior
>>>>> optimization is not an issue performance-wise because the introduced
>>>>> per-mm/per-cpu mm_cid tracking also covers this more specific case.
>>>>>
>>>>> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
>>>>> Reported-by: Aaron Lu <aaron.lu@intel.com>
>>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>>> Tested-by: Aaron Lu <aaron.lu@intel.com>
>>>>> Link: https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
>>>>
>>>> I run standard benchmarks as a part of kernel performance regression
>>>> testing. When I run these benchmarks against v6.3.0 to v6.4-rc1,
>>>> I have seen performance regression in hackbench running with threads. When I did
>>>> git bisect it pointed to this commit and reverting this commit helps regains
>>>> the performance. This regression is not seen with hackbench processes.
>>>
>>> Well, *this* commit was supposed to help fix the horrible contention on
>>> cid_lock that was introduced with af7f588d8f73.
>>
>> I went back and tested the commit that introduced mm_cid and I found that the
>> original implementation actually helped hackbench. Following are numbers from
>> 2 Socket Zen3 Server (2 X 64C/128T):
>>
>> Test:           base (v6.2-rc1)      base + orig_mm_cid
>>   1-groups:     4.29 (0.00 pct)     4.32 (-0.69 pct)
>>   2-groups:     4.96 (0.00 pct)     4.94 (0.40 pct)
>>   4-groups:     5.21 (0.00 pct)     4.10 (21.30 pct)
>>   8-groups:     5.44 (0.00 pct)     4.50 (17.27 pct)
>> 16-groups:     7.09 (0.00 pct)     5.28 (25.52 pct)
>>
>> I see following IBS traces in this case:
>>
>> Base:
>>
>>     6.69%  sched-messaging  [kernel.vmlinux]          [k] copy_user_generic_string
>>     5.38%  sched-messaging  [kernel.vmlinux]          [k] native_queued_spin_lock_slowpath
>>     3.73%  swapper          [kernel.vmlinux]          [k] __switch_to_asm
>>     3.23%  sched-messaging  [kernel.vmlinux]          [k] __calc_delta
>>     2.93%  sched-messaging  [kernel.vmlinux]          [k] try_to_wake_up
>>     2.63%  sched-messaging  [kernel.vmlinux]          [k] dequeue_task_fair
>>     2.56%  sched-messaging  [kernel.vmlinux]          [k] osq_lock
>>
>> Base + orig_mm_cid:
>>
>>    13.70%  sched-messaging  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
>>    11.87%  swapper          [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
>>     8.99%  sched-messaging  [kernel.vmlinux]      [k] copy_user_generic_string
>>     6.08%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
>>     4.79%  sched-messaging  [kernel.vmlinux]      [k] apparmor_file_permission
>>     3.71%  sched-messaging  [kernel.vmlinux]      [k] mutex_spin_on_owner
>>     3.66%  sched-messaging  [kernel.vmlinux]      [k] ktime_get_coarse_real_ts64
>>     3.11%  sched-messaging  [kernel.vmlinux]      [k] _copy_from_iter
>>
>>>
>>>> Following are the results from 1 Socket 4th generation EPYC
>>>> Processor(1 X 96C/192T) configured in NPS1 mode. This regression
>>>> becomes more severe as the number of core count increases.
>>>>
>>>> The numbers on a 1 Socket Bergamo (1 X 128 cores/256 threads) is significantly worse.
>>>>
>>>> Threads:
>>>>
>>>> Test:             With-mmcid-patch        Without-mmcid-patch
>>>>   1-groups:         5.23 (0.00 pct)         4.61 (+11.85 pct)
>>>>   2-groups:         4.99 (0.00 pct)         4.72 (+5.41 pct)
>>>>   4-groups:         5.96 (0.00 pct)         4.87 (+18.28 pct)
>>>>   8-groups:         6.58 (0.00 pct)         5.44 (+17.32 pct)
>>>> 16-groups:        11.48 (0.00 pct)         8.07 (+29.70 pct)
>>>
>>> I'm really confused, so you're saying that having a process wide
>>> spinlock is better than what this patch does? Or are you testing against
>>> something without mm-cid entirely?
>>
>> It does look like the lock contention introduced by the original mm_cid patch helped
>> hackbench in this case. In that case, I see hackbench threads run for longer on average (avg_atom)
>> and total idle entries are down significantly. Even on disabling C1 and C2, I see
>> similar behavior. With the new mm_cid patch that gets rid of the lock contention, we see a drop
>> in the hackbench performance.
>>
>> I will go dig into this further meanwhile if you have any pointers please do let me know.
> 
> I suspect the baseline don't have spinlock contention because the test-case
> schedules between threads belonging to the same process, for which the initial
> mm_cid patch had an optimization which skips the spinlock entirely.
> 
> This optimization for inter-thread scheduling had to be removed in the following
> patch to address the performance issue more generally, covering the inter-process
> scheduling.
> 
> I suspect the regression is caused by the mm_count cache line bouncing.
> 
> Please try with this additional patch applied:
> 
> https://lore.kernel.org/lkml/20230515143536.114960-1-mathieu.desnoyers@efficios.com/

Thanks for the suggestion. I tried out with the patch you suggested. I am seeing
improvement in hackbench numbers with mm_count padding. But this is not matching
with what we achieved through reverting the new mm_cid patch.

Below are the results on the 1 Socket 4th Generation EPYC Processor (1 x 96C/192T):

Threads:

Test:              Base (v6.4-rc1)   Base + new_mmcid_reverted  Base + mm_count_padding
  1-groups:         5.23 (0.00 pct)         4.61 (11.85 pct)        5.11 (2.29 pct)
  2-groups:         4.99 (0.00 pct)         4.72 (5.41 pct)         5.00 (-0.20 pct)
  4-groups:         5.96 (0.00 pct)         4.87 (18.28 pct)        5.86 (1.67 pct)
  8-groups:         6.58 (0.00 pct)         5.44 (17.32 pct)        6.20 (5.77 pct)
16-groups:        11.48 (0.00 pct)         8.07 (29.70 pct)       10.68 (6.96 pct)

Processes:

Test:              Base (v6.4-rc1)  Base + new_mmcid_reverted   Base + mm_count_padding
  1-groups:         5.19 (0.00 pct)         4.90 (5.58 pct)         5.19 (0.00 pct)
  2-groups:         5.44 (0.00 pct)         5.39 (0.91 pct)         5.39 (0.91 pct)
  4-groups:         5.69 (0.00 pct)         5.64 (0.87 pct)         5.64 (0.87 pct)
  8-groups:         6.08 (0.00 pct)         6.01 (1.15 pct)         6.04 (0.65 pct)
16-groups:        10.87 (0.00 pct)        10.83 (0.36 pct)        10.93 (-0.55 pct)

The ibs profile shows that function __switch_to_asm() is coming at top in baseline
run and is not seen with mm_count padding patch. Will be attaching full ibs profile
data for all the 3 runs:

# Base (v6.4-rc1)
Threads:
Total time: 11.486 [sec]

    5.15%  sched-messaging  [kernel.vmlinux]      [k] __switch_to_asm
    4.31%  sched-messaging  [kernel.vmlinux]      [k] copyout
    4.29%  sched-messaging  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
    4.22%  sched-messaging  [kernel.vmlinux]      [k] copyin
    3.92%  sched-messaging  [kernel.vmlinux]      [k] apparmor_file_permission
    2.91%  sched-messaging  [kernel.vmlinux]      [k] __schedule
    2.34%  swapper          [kernel.vmlinux]      [k] __switch_to_asm
    2.10%  sched-messaging  [kernel.vmlinux]      [k] prepare_to_wait_event
    2.10%  sched-messaging  [kernel.vmlinux]      [k] try_to_wake_up
    2.07%  sched-messaging  [kernel.vmlinux]      [k] finish_task_switch.isra.0
    2.00%  sched-messaging  [kernel.vmlinux]      [k] pipe_write
    1.82%  sched-messaging  [kernel.vmlinux]      [k] check_preemption_disabled
    1.73%  sched-messaging  [kernel.vmlinux]      [k] exit_to_user_mode_prepare
    1.52%  sched-messaging  [kernel.vmlinux]      [k] __entry_text_start
    1.49%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
    1.45%  sched-messaging  libc.so.6             [.] write
    1.44%  swapper          [kernel.vmlinux]      [k] native_sched_clock
    1.38%  sched-messaging  [kernel.vmlinux]      [k] psi_group_change
    1.38%  sched-messaging  [kernel.vmlinux]      [k] pipe_read
    1.37%  sched-messaging  libc.so.6             [.] read
    1.06%  sched-messaging  [kernel.vmlinux]      [k] vfs_read
    1.01%  swapper          [kernel.vmlinux]      [k] psi_group_change
    1.00%  sched-messaging  [kernel.vmlinux]      [k] update_curr

# Base + mm_count_padding
Threads:
Total time: 11.384 [sec]

    4.43%  sched-messaging  [kernel.vmlinux]         [k] copyin
    4.39%  sched-messaging  [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
    4.07%  sched-messaging  [kernel.vmlinux]         [k] apparmor_file_permission
    4.07%  sched-messaging  [kernel.vmlinux]         [k] copyout
    2.49%  sched-messaging  [kernel.vmlinux]         [k] entry_SYSCALL_64
    2.37%  sched-messaging  [kernel.vmlinux]         [k] update_cfs_group
    2.19%  sched-messaging  [kernel.vmlinux]         [k] pipe_write
    2.00%  sched-messaging  [kernel.vmlinux]         [k] check_preemption_disabled
    1.93%  swapper          [kernel.vmlinux]         [k] update_load_avg
    1.81%  sched-messaging  [kernel.vmlinux]         [k] exit_to_user_mode_prepare
    1.69%  sched-messaging  [kernel.vmlinux]         [k] try_to_wake_up
    1.58%  sched-messaging  libc.so.6                [.] write
    1.53%  sched-messaging  [kernel.vmlinux]         [k] psi_group_change
    1.50%  sched-messaging  libc.so.6                [.] read
    1.50%  sched-messaging  [kernel.vmlinux]         [k] pipe_read
    1.39%  sched-messaging  [kernel.vmlinux]         [k] update_load_avg
    1.39%  sched-messaging  [kernel.vmlinux]         [k] osq_lock
    1.30%  sched-messaging  [kernel.vmlinux]         [k] update_curr
    1.28%  swapper          [kernel.vmlinux]         [k] psi_group_change
    1.16%  sched-messaging  [kernel.vmlinux]         [k] vfs_read
    1.12%  sched-messaging  [kernel.vmlinux]         [k] vfs_write
    1.10%  sched-messaging  [kernel.vmlinux]         [k] entry_SYSRETQ_unsafe_stack
    1.09%  sched-messaging  [kernel.vmlinux]         [k] __switch_to_asm
    1.08%  sched-messaging  [kernel.vmlinux]         [k] do_syscall_64
    1.06%  sched-messaging  [kernel.vmlinux]         [k] select_task_rq_fair
    1.03%  swapper          [kernel.vmlinux]         [k] update_cfs_group
    1.00%  swapper          [kernel.vmlinux]         [k] rb_insert_color

# Base + reverted_new_mm_cid
Threads:
Total time: 7.847 [sec]

   12.14%  sched-messaging  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
    8.86%  swapper          [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
    6.13%  sched-messaging  [kernel.vmlinux]      [k] copyin
    5.54%  sched-messaging  [kernel.vmlinux]      [k] apparmor_file_permission
    3.59%  sched-messaging  [kernel.vmlinux]      [k] copyout
    2.61%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
    2.48%  sched-messaging  [kernel.vmlinux]      [k] pipe_write
    2.33%  sched-messaging  [kernel.vmlinux]      [k] exit_to_user_mode_prepare
    2.01%  sched-messaging  [kernel.vmlinux]      [k] check_preemption_disabled
    1.96%  sched-messaging  [kernel.vmlinux]      [k] __entry_text_start
    1.91%  sched-messaging  libc.so.6             [.] write
    1.77%  sched-messaging  libc.so.6             [.] read
    1.64%  sched-messaging  [kernel.vmlinux]      [k] mutex_spin_on_owner
    1.58%  sched-messaging  [kernel.vmlinux]      [k] pipe_read
    1.52%  sched-messaging  [kernel.vmlinux]      [k] try_to_wake_up
    1.38%  sched-messaging  [kernel.vmlinux]      [k] ktime_get_coarse_real_ts64
    1.35%  sched-messaging  [kernel.vmlinux]      [k] vfs_write
    1.28%  sched-messaging  [kernel.vmlinux]      [k] entry_SYSRETQ_unsafe_stack
    1.28%  sched-messaging  [kernel.vmlinux]      [k] vfs_read
    1.25%  sched-messaging  [kernel.vmlinux]      [k] do_syscall_64
    1.22%  sched-messaging  [kernel.vmlinux]      [k] __fget_light
    1.18%  sched-messaging  [kernel.vmlinux]      [k] mutex_lock
    1.12%  sched-messaging  [kernel.vmlinux]      [k] file_update_time
    1.04%  sched-messaging  [kernel.vmlinux]      [k] _copy_from_iter
    1.01%  sched-messaging  [kernel.vmlinux]      [k] current_time

So with the reverted new_mm_cid patch, we are seeing a lot of time being spent in
native_queued_spin_lock_slowpath and yet, hackbench finishes faster.

I keep further digging into this please let me know if you have any pointers for me.

> 
> This patch has recently been merged into the mm tree.
> 
> Thanks,
> 
> Mathieu
> 
--
Thanks and Regards,
Swapnil
