Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82064734B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjFSEbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFSEbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:31:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA371BB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbYWDFr/lPQEsvVdSJRSRRb8v/vYmnAJrMx3tRU5WRhkydaDnogGRwAaRVWbdv9qm6Ik8QhPBogLoOgictSgEUtSVX13Er0UmCx7MyAilQGtVv7TSd0mHlK73yjywmRTicVl9rNuNhShjDpnl8eiJ6anFVS1ar1TlXIUD4TXyppclDoqvEzq4O9505yJpBfm8CsRwWJN73yuh4JFeAHjtfRZd631OLBe3WXMx7fh3tHI9vEm0o4R2OB8XRH9ieodYjaQkc7dhfV+fx5Uh7/znbmzordHr9zqMj3tVhVuCP2fWfr0NnS+DH69yq8oNOfaTBvqlmrM6hPdL483gQSR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWrUJui/jPgGaCOX4AWCE3G3l9nAq6/Tg6OOThInGdM=;
 b=MRRq3Y5Modf4j5S1lQNB15foiBTZRPaDL6b8EOYE0Tl7gCeVX2e508QJd/VHlQnLgl3ta7vHcWM8I7IEpxjV5COhGm2RDgrLVEx3/Ojny/pXD9Nw2hNIg1a0Qpam50wP/D8rCYfb9IYJ/5YY8KID5ik+JvEUdvVz6tOFHhlw7tcHCfmXh94zGpsAZaQLasK6tVqW9IsxJckHL70TA3wfej3zxeeC8kVyuyHqOu+LeDyrSRXSfj4r8N/1W+Nl+8Ukpe2ix+v05VRVmJU8Rm/3Nz+HxSX1x5aYHA68vF9vsHu+RGixAjPovn3KPzlY+xXV92g0YOJocxmQ44mZp0wqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWrUJui/jPgGaCOX4AWCE3G3l9nAq6/Tg6OOThInGdM=;
 b=OBIDfYkLvlsIOryLtQvoELAA+fGNJROTTSJdUJVLMkdA/GoI1zLi8znAGje9HYLSZavkhwOosSBf7j1TsD6GNHCYrEQNXwdXNO2vDUkx7xHe1w0BOfDHBlIryALSwbK3vJPRnmedIXWbv8vBCQuIf6ViJlAQgGGU7J/jVT5WbAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 04:30:49 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 04:30:49 +0000
Message-ID: <edfb9182-72e8-8bc2-bae9-2384e4e52577@amd.com>
Date:   Mon, 19 Jun 2023 10:00:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>
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
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
 <ZIJbMQOu_k07jkFf@slm.duckdns.org>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <ZIJbMQOu_k07jkFf@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: d8db2d57-f1fa-493c-b3e2-08db707df4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw46gqFGJWhzDmNHyEUgi/wb+ypm5erLhgfog9dbK8xqA/mRLCEjWTMVsf7dXXqbPUUFtUREzLOAEK8uGBS2GzKyGWv3Uz170v36HOIVo6kdpN1gJ8kvU0j9jjzgMUySS4I/Xlo/YFd2E5vCJaO86YVHqjNpmHYUJTzb5zNyPFSdASoSTEVRPmb5dlzUb3b9FE9C2p7lpAqiZ6nDxaulWW9NCL9jYNhy13pUIJWMv0lifWAiOUim2fn8P88Ji4Rxox5i7yxgDIq8Kd5RlUuxekyZ0GMZr/xqHQEFSJl9N5fEg4X0mWcpYz5s3llTMqRqRx6E+B9v1PKOjjUTXFi2jEimONuYAhzQnAG3Xq3BwCv/tqfwWFWFq5BKHOCMFLJStGuyHY0M1ESRksuntpusrP5xEhLrNB+zHErT1qUv2iunCMevWcn8DPdIHRD/1ViCxV+b823gYM7SjWwsaVNRdXlW9sYbHrWjNGYN3mcz6VIuTuxNinKs3xBkU1VMp4K2URKTEOnfUHw3K0xW9yN1BmoSGHMbUQD2Qv42WUsP/aTKFKL94z/VAIuqY+MP6eT4D34zwXybmkCEUIV1SFw1d8+BHvbY8XMwykQuUoGU7KScUm7WpfReD0l91dswzD0Kbbq31lpQg6CgAZupzdfq8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(66946007)(186003)(8676002)(8936002)(66556008)(66476007)(5660300002)(110136005)(4326008)(45080400002)(6666004)(6486002)(316002)(38100700002)(478600001)(41300700001)(36756003)(26005)(53546011)(6512007)(6506007)(6636002)(7416002)(30864003)(86362001)(31696002)(2906002)(83380400001)(31686004)(2616005)(45980500001)(43740500002)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFxdWVWc0t5aFRZVW4vRUN2alJoeXdMZXF6Wk9FVVFaZUJRVHo1VlgrbEd4?=
 =?utf-8?B?YnYwOU1GWUQ2OVNlN3IzQ1czL1BhM21lay90eTlkdlF6QUpOKytHSkJ4Z21n?=
 =?utf-8?B?VENhOExQM3NsVEp5aXVmSXh1UndWUm53bVV2bHk4Q2wrTGxWRUpyUzNyWmhD?=
 =?utf-8?B?d1BnSlRPMEpYajREd2dHVUhVZWVPVGpCT1ZpZ3JkRTZ6czB6WWtQeXc3Zkdx?=
 =?utf-8?B?Lytpd0RBakdqdUljLzdUdVRCK2krcWtYR0JKRUJLeTdTVGJzbXdxcDJOZTBi?=
 =?utf-8?B?VFRsZW1SNS93QktIa0syVzRWZC9OZ1MyR3I4dE03OWpDUDVTdlBzLzdQQnJW?=
 =?utf-8?B?amsvUTJzalBVd3FmbmZTQ3Zwa0t5eDI3VjVDS002b2tJQkpWbUx0ZHgwWkds?=
 =?utf-8?B?eUt3Y3o0NmJXTk9mNnNqdGIxZ1dScm4zWkV0WHFGNlNLeDJUQ2JaM1JvajVn?=
 =?utf-8?B?NkxqT1RpTGxuT1lBa2ZOdnpUc1g3YWZvSjMwTENINnR1Q0szU3RiclNkbVhz?=
 =?utf-8?B?MU93d2IxRnVkVVQ3Z3pjMHo2QzRvQzViWjdXQkYyOW82L1lrTTRIU3h3UCt1?=
 =?utf-8?B?bTlXUjVhS29DdnRTM1hsQlk3R1NlVEcyYU45SEc3SlFYeDY0ZWY3VFVzbWFY?=
 =?utf-8?B?NEpRNERBRXhhTm9vRXJtYkFQYTk1N2pQQ29JMHZ2RmxoeDJhdkRvYlREdFJQ?=
 =?utf-8?B?dlM3VkZkclVpL2hKQ0c5TmphWjAwY0hoMTBVVTlDMytQcHlXM1d0UVl6TTVk?=
 =?utf-8?B?VDVSNE5wQmFWU1d3QjBHVWRYSm5NWUR6d05DSlFSMURIWDhSVFF1VjBRV0FY?=
 =?utf-8?B?dGhyTk5sZ05DTG5rTENaSGRGRmxYdk9Db0pnZzR3d1hMQkVDN2JTZFZ4ZGg1?=
 =?utf-8?B?bHJRZUNvY2ttRWloQk9tWC9hOW1Fb3RNS20xY25uR2dJdjJCdlZWR1JxNGg0?=
 =?utf-8?B?OG96YVo5US9ibk1zSnVJVytSRlFzWi9IYUZOZ0s1MFJObmdLeGxUZ2VQaldY?=
 =?utf-8?B?cElQZVpOWUZvYlpjcVVqWU1JK2FzLy9KNFdNdFVJUHJBSHZySHhFZG95ZzJi?=
 =?utf-8?B?dkJSSW1yQVI1RnJqUE1hR2MxaXJSNDFLdlVZV3JYcEVRSm5hK3RoRW9id2hn?=
 =?utf-8?B?Wkt5QWZrbzN1SkpPT015aC9LYm9KT3R2OTNiRTU2dUNVU2dMVFZoeEFremM2?=
 =?utf-8?B?MHFqZ0l6d0hVb21tMSs2SHVqdnRnSWZCWlQzSVZNNVZjcXJTT1BFRW94TUNj?=
 =?utf-8?B?eFRKZ0kzYXpJV09vWnJxWVJaM2JtU1U1K09QZ2ZIVWc3NGtxQWVadm1ReElr?=
 =?utf-8?B?UFhKa2l0ZjdVQ0dpcEc4ZDVuSDVXdFdMR1hZTU9aK0dwMEV0dmNocGI5dXFU?=
 =?utf-8?B?VFhmUVZFOEFGNnh0NFY0UTJZOWFheURYWDJKRWVOa2I2dmxYdytqcDEzcGpi?=
 =?utf-8?B?YmlmZE5WY204R0JMUEFUOXpNVUR0QldCNHY4dHBHUS9qclNXeFFvWWZiRUJ0?=
 =?utf-8?B?eEZ6OW9CQWxnKy9DbnJGZVNhNEJrZ29qRkpyTEtwcWNCUjd6Zmt0QVI2Vk1Z?=
 =?utf-8?B?VjVBdk1jbzJNOHRJRDNFOEZJTjR2cDhMcXY2UmNudmlVRUdFbWQ1Y0Qxb2Zn?=
 =?utf-8?B?NWdPV0sraDgzRWxjV3dZN2NETm9lbC9hWE5pMlFVZGlyU3RnK1pjYzNyckNn?=
 =?utf-8?B?aXRvNWY1ZWNndDlJMCtjMnIzYVhOMmZaMk9HcENGOE5xajhXSkJITEpBRFNS?=
 =?utf-8?B?WWp2WEZFSTlUYVplSnBCYXRvTkJZMGlXZXA2SlRQNit6a0J1eGg1VStDdFc4?=
 =?utf-8?B?RzZpd21sN2p0MEprTDAyUnI4enVjbmkrMjlWc1hUcFFXVzQxZEltbHNvdFpa?=
 =?utf-8?B?bS92ZS9ZRHNnRDlhem10YmNWQmMrNU1MN3NHYlJrbUtWc2ZXWWtsaUU4SFU0?=
 =?utf-8?B?Z25qWFROTFNKUDBzaklIS0JlMXdWdURwWnNQNVQzU2JMK3dXNW95VTZ6YzVC?=
 =?utf-8?B?cGh5blNsekZFdzVNdFQzclZWSFQ3bngxN2ZNTXFXcmg5NVk0QU1sdGI3aHdC?=
 =?utf-8?B?ajFNVDV5d3g4TU1SOWVESlgweUpxTllHUExDU1MrUzlMeXV3amNQeUUxaG1u?=
 =?utf-8?Q?7FESxo74JOICqOdu6BSv2bGph?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8db2d57-f1fa-493c-b3e2-08db707df4aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 04:30:49.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwKEszIIr54CVKPQIgQ+D2izTMFwlk5ZQEv67VhxRNA8uaAAmIUUlduEJYeZspOXFSK0WJ04V9D+HuAYE6KH1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 6/9/2023 4:20 AM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jun 08, 2023 at 08:31:34AM +0530, K Prateek Nayak wrote:
> ...
>> Thank you for sharing the debug branch. I've managed to hit some one of
>> the WARN_ON_ONCE() consistently but I still haven't seen a kernel panic
>> yet. Sharing the traces below:
> 
> Yeah, that's good. It does a dirty fix-up. Shouldn't crash.
> 
>> o Early Boot
>>
>>      [    4.182411] ------------[ cut here ]------------
>>      [    4.186313] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:1130 kick_pool+0xdb/0xe0
>>      [    4.186313] Modules linked in:
>>      [    4.186313] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc1-tj-wq-valid-cpu+ #481
>>      [    4.186313] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
>>      [    4.186313] RIP: 0010:kick_pool+0xdb/0xe0
>>      [    4.186313] Code: 6b c0 d0 01 73 24 41 89 45 64 49 8b 54 24 f8 48 89 d0 30 c0 83 e2 04 ba 00 00 00 00 48 0f 44 c2 48 83 80 c0 00 00 00 01 eb 82 <0f> 0b eb dc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
>>      [    4.186313] RSP: 0018:ffffbc1b800e7dd8 EFLAGS: 00010046
>>      [    4.186313] RAX: 0000000000000100 RBX: ffff97c73d2321c0 RCX: 0000000000000000
>>      [    4.186313] RDX: 0000000000000040 RSI: 0000000000000001 RDI: ffff9788c0159728
>>      [    4.186313] RBP: ffffbc1b800e7df0 R08: 0000000000000100 R09: ffff9788c01593e0
>>      [    4.186313] R10: ffff9788c01593c0 R11: 0000000000000001 R12: ffffffff8c582430
>>      [    4.186313] R13: ffff9788c03fcd40 R14: 0000000000000000 R15: ffff97c73d2324b0
>>      [    4.186313] FS:  0000000000000000(0000) GS:ffff97c73d200000(0000) knlGS:0000000000000000
>>      [    4.186313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>      [    4.186313] CR2: ffff97cecee01000 CR3: 000000470d43a001 CR4: 0000000000770ef0
>>      [    4.186313] PKRU: 55555554
>>      [    4.186313] Call Trace:
>>      [    4.186313]  <TASK>
>>      [    4.186313]  create_worker+0x14e/0x280
>>      [    4.186313]  ? wake_up_process+0x15/0x20
>>      [    4.186313]  workqueue_init+0x22a/0x3d0
>>      [    4.186313]  kernel_init_freeable+0x1fe/0x4f0
>>      [    4.186313]  ? __pfx_kernel_init+0x10/0x10
>>      [    4.186313]  kernel_init+0x1b/0x1f0
>>      [    4.186313]  ? __pfx_kernel_init+0x10/0x10
>>      [    4.186313]  ret_from_fork+0x2c/0x50
>>      [    4.186313]  </TASK>
>>      [    4.186313] ---[ end trace 0000000000000000 ]---
>>
>> o I consistently see a WARN_ON_ONCE() in kick_pool() being hit when I
>>    run "sudo ./stress-ng --iomix 96 --timeout 1m". I've seen few
>>    different stack traces so far. Including all below just in case:
> ...
>> This is the same WARN_ON_ONCE() you had added in the HEAD commit:
>>
>>      $ scripts/faddr2line vmlinux kick_pool+0xdb
>>      kick_pool+0xdb/0xe0:
>>      kick_pool at kernel/workqueue.c:1130 (discriminator 1)
>>
>>      $ sed -n 1130,1132p kernel/workqueue.c
>>      if (!WARN_ON_ONCE(wake_cpu >= nr_cpu_ids))
>>          p->wake_cpu = wake_cpu;
>>      get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
>>
>> Let me know if you need any more data from my test setup.
>> P.S. The kernel is still up and running (~30min) despite hitting this
>> WARN_ON_ONCE() in my case :)
> 
> Okay, that was me being stupid and not initializing the new fields for
> per-cpu workqueues. Can you please test the following branch? It should have
> both bugs fixed properly.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-v2
> 
Thanks for the patchset. I tested the patchset with fiotests.
Tests were run on a dual socket 3rd Generation EPYC server(2 x64C/128T)
with NPS1, NPS2 and NPS4 modes.

With affinity-scopes-v2, below are the observations:
BW, LAT AVG and CLAT AVG shows improvement with some combinations
of the params in NPS1 and NPS2 while all other combinations of params
show no loss or gain in the performance. Those combinations showing
improvement are marked with ### and those showing drop in performance
are marked with ***. CLAT 99 shows mixed results in all the NPS modes.
SLAT 99 is suffering tremendously in all NPS mode.

Params:
TEST:
     * W  - Sequential Write
     * R  - Sequential Read
     * RW - Random Write
     * RR - Random Write

Threads: numjobs

BS: Block size

==================================================================================================================================
                                                       ~~~~~~~~~~~~~~~~NPS1~~~~~~~~~~~~~~~~
==================================================================================================================================

TEST Threads BS  IODEPTH   Metric   NPS1-6.4.0-rc1           CPU                 SMT             CACHE               NUMA                SYSTEM
W       1   1M     8         BW       444 MB/s       441 MB/s(-0.67)     451 MB/s( 1.57)     448 MB/s( 0.90)    449 MB/s( 1.12)     447 MB/s( 0.67)
R       1   1M     8         BW       668 MB/s       666 MB/s(-0.29)     770 MB/s(15.26)     654 MB/s(-2.09)    660 MB/s(-1.19)     775 MB/s(16.01)     ###
RW      1  64K    16         BW       438 MB/s       437 MB/s(-0.22)     437 MB/s(-0.22)     433 MB/s(-1.14)    436 MB/s(-0.45)     436 MB/s(-0.45)
RR      1  64K    16         BW       465 MB/s       461 MB/s(-0.86)     467 MB/s( 0.43)     465 MB/s( 0.00)    463 MB/s(-0.43)     463 MB/s(-0.43)
RW      1   8K    32         BW       257 MB/s       262 MB/s( 1.94)     278 MB/s( 8.17)     293 MB/s(14.00)    258 MB/s( 0.38)     282 MB/s( 9.72)     ###
RW      1   8K    32         BW       537 MB/s       537 MB/s( 0.00)     532 MB/s(-0.93)     531 MB/s(-1.11)    535 MB/s(-0.37)     533 MB/s(-0.74)
W       2   1M     8         BW       452 MB/s       452 MB/s( 0.00)     450 MB/s(-0.44)     448 MB/s(-0.88)    449 MB/s(-0.66)     451 MB/s(-0.22)
R       2   1M     8         BW       686 MB/s       685 MB/s(-0.14)     813 MB/s(18.51)     818 MB/s(19.24)    817 MB/s(19.09)     817 MB/s(19.09)     ###
RW      2  64K    16         BW       435 MB/s       434 MB/s(-0.22)     438 MB/s( 0.68)     439 MB/s( 0.91)    434 MB/s(-0.22)     437 MB/s( 0.45)
RR      2  64K    16         BW       565 MB/s       563 MB/s(-0.35)     569 MB/s( 0.70)     560 MB/s(-0.88)    566 MB/s( 0.17)     569 MB/s( 0.70)
RW      2   8K    32         BW       346 MB/s       349 MB/s( 0.86)     344 MB/s(-0.57)     348 MB/s( 0.57)    347 MB/s( 0.28)     338 MB/s(-2.31)
RW      2   8K    32         BW       549 MB/s       546 MB/s(-0.54)     545 MB/s(-0.72)     542 MB/s(-1.27)    540 MB/s(-1.63)     546 MB/s(-0.54)
W       4   1M     8         BW       451 MB/s       451 MB/s( 0.00)     449 MB/s(-0.44)     429 MB/s(-4.87)    451 MB/s( 0.00)     452 MB/s( 0.22)
R       4   1M     8         BW       832 MB/s       829 MB/s(-0.36)     830 MB/s(-0.24)     834 MB/s( 0.24)    825 MB/s(-0.84)     814 MB/s(-2.16)
RW      4  64K    16         BW       438 MB/s       434 MB/s(-0.91)     431 MB/s(-1.59)     433 MB/s(-1.14)    435 MB/s(-0.68)     436 MB/s(-0.45)
RR      4  64K    16         BW       558 MB/s       565 MB/s( 1.25)     566 MB/s( 1.43)     563 MB/s( 0.89)    567 MB/s( 1.61)     568 MB/s( 1.79)
RW      4   8K    32         BW       349 MB/s       343 MB/s(-1.71)     346 MB/s(-0.85)     349 MB/s( 0.00)    338 MB/s(-3.15)     345 MB/s(-1.14)
RW      4   8K    32         BW       548 MB/s       547 MB/s(-0.18)     546 MB/s(-0.36)     540 MB/s(-1.45)    548 MB/s( 0.00)     547 MB/s(-0.18)
W       8   1M     8         BW       452 MB/s       447 MB/s(-1.10)     450 MB/s(-0.44)     436 MB/s(-3.53)    450 MB/s(-0.44)     449 MB/s(-0.66)
R       8   1M     8         BW       831 MB/s       831 MB/s( 0.00)     830 MB/s(-0.12)     826 MB/s(-0.60)    834 MB/s( 0.36)     830 MB/s(-0.12)
RW      8  64K    16         BW       430 MB/s       436 MB/s( 1.39)     431 MB/s( 0.23)     434 MB/s( 0.93)    432 MB/s( 0.46)     436 MB/s( 1.39)
RR      8  64K    16         BW       559 MB/s       568 MB/s( 1.61)     560 MB/s( 0.17)     568 MB/s( 1.61)    562 MB/s( 0.53)     564 MB/s( 0.89)
RW      8   8K    32         BW       344 MB/s       349 MB/s( 1.45)     349 MB/s( 1.45)     345 MB/s( 0.29)    347 MB/s( 0.87)     345 MB/s( 0.29)
RW      8   8K    32         BW       545 MB/s       546 MB/s( 0.18)     547 MB/s( 0.36)     546 MB/s( 0.18)    534 MB/s(-2.01)     547 MB/s( 0.36)
W      16   1M     8         BW       450 MB/s       448 MB/s(-0.44)     449 MB/s(-0.22)     451 MB/s( 0.22)    450 MB/s( 0.00)     450 MB/s( 0.00)
R      16   1M     8         BW       831 MB/s       830 MB/s(-0.12)     833 MB/s( 0.24)     833 MB/s( 0.24)    835 MB/s( 0.48)     833 MB/s( 0.24)
RW     16  64K    16         BW       436 MB/s       435 MB/s(-0.22)     435 MB/s(-0.22)     432 MB/s(-0.91)    434 MB/s(-0.45)     428 MB/s(-1.83)
RR     16  64K    16         BW       568 MB/s       563 MB/s(-0.88)     568 MB/s( 0.00)     565 MB/s(-0.52)    563 MB/s(-0.88)     562 MB/s(-1.05)
RW     16   8K    32         BW       349 MB/s       349 MB/s( 0.00)     346 MB/s(-0.85)     346 MB/s(-0.85)    342 MB/s(-2.00)     345 MB/s(-1.14)
RW     16   8K    32         BW       543 MB/s       545 MB/s( 0.36)     542 MB/s(-0.18)     534 MB/s(-1.65)    535 MB/s(-1.47)     543 MB/s( 0.00)
W      32   1M     8         BW       450 MB/s       450 MB/s( 0.00)     452 MB/s( 0.44)     451 MB/s( 0.22)    449 MB/s(-0.22)     451 MB/s( 0.22)
R      32   1M     8         BW       832 MB/s       832 MB/s( 0.00)     834 MB/s( 0.24)     837 MB/s( 0.60)    834 MB/s( 0.24)     837 MB/s( 0.60)
RW     32  64K    16         BW       436 MB/s       434 MB/s(-0.45)     431 MB/s(-1.14)     435 MB/s(-0.22)    433 MB/s(-0.68)     434 MB/s(-0.45)
RR     32  64K    16         BW       559 MB/s       565 MB/s( 1.07)     566 MB/s( 1.25)     566 MB/s( 1.25)    559 MB/s( 0.00)     567 MB/s( 1.43)
RW     32   8K    32         BW       349 MB/s       349 MB/s( 0.00)     349 MB/s( 0.00)     342 MB/s(-2.00)    348 MB/s(-0.28)     343 MB/s(-1.71)
RW     32   8K    32         BW       535 MB/s       535 MB/s( 0.00)     524 MB/s(-2.05)     531 MB/s(-0.74)    534 MB/s(-0.18)     523 MB/s(-2.24)
W      64   1M     8         BW       451 MB/s       451 MB/s( 0.00)     450 MB/s(-0.22)     450 MB/s(-0.22)    451 MB/s( 0.00)     451 MB/s( 0.00)
R      64   1M     8         BW       831 MB/s       834 MB/s( 0.36)     837 MB/s( 0.72)     835 MB/s( 0.48)    835 MB/s( 0.48)     834 MB/s( 0.36)
RW     64  64K    16         BW       437 MB/s       435 MB/s(-0.45)     436 MB/s(-0.22)     437 MB/s( 0.00)    436 MB/s(-0.22)     437 MB/s( 0.00)
RR     64  64K    16         BW       568 MB/s       568 MB/s( 0.00)     563 MB/s(-0.88)     564 MB/s(-0.70)    564 MB/s(-0.70)     559 MB/s(-1.58)
RW     64   8K    32         BW       336 MB/s       347 MB/s( 3.27)     347 MB/s( 3.27)     346 MB/s( 2.97)    346 MB/s( 2.97)     347 MB/s( 3.27)
RW     64   8K    32         BW       523 MB/s       534 MB/s( 2.10)     531 MB/s( 1.52)     521 MB/s(-0.38)    528 MB/s( 0.95)     519 MB/s(-0.76)
W     128   1M     8         BW       452 MB/s       450 MB/s(-0.44)     449 MB/s(-0.66)     449 MB/s(-0.66)    451 MB/s(-0.22)     449 MB/s(-0.66)
R     128   1M     8         BW       832 MB/s       831 MB/s(-0.12)     834 MB/s( 0.24)     836 MB/s( 0.48)    834 MB/s( 0.24)     834 MB/s( 0.24)
RW    128  64K    16         BW       435 MB/s       435 MB/s( 0.00)     431 MB/s(-0.91)     433 MB/s(-0.45)    434 MB/s(-0.22)     431 MB/s(-0.91)
RR    128  64K    16         BW       561 MB/s       564 MB/s( 0.53)     555 MB/s(-1.06)     562 MB/s( 0.17)    567 MB/s( 1.06)     565 MB/s( 0.71)
RW    128   8K    32         BW       348 MB/s       335 MB/s(-3.73)     345 MB/s(-0.86)     347 MB/s(-0.28)    348 MB/s( 0.00)     345 MB/s(-0.86)
RW    128   8K    32         BW       518 MB/s       530 MB/s( 2.31)     530 MB/s( 2.31)     517 MB/s(-0.19)    531 MB/s( 2.50)     519 MB/s( 0.19)
W     256   1M     8         BW       448 MB/s       448 MB/s( 0.00)     450 MB/s( 0.44)     449 MB/s( 0.22)    451 MB/s( 0.66)     449 MB/s( 0.22)
R     256   1M     8         BW       833 MB/s       830 MB/s(-0.36)     833 MB/s( 0.00)     834 MB/s( 0.12)    836 MB/s( 0.36)     836 MB/s( 0.36)
RW    256  64K    16         BW       436 MB/s       433 MB/s(-0.68)     432 MB/s(-0.91)     434 MB/s(-0.45)    433 MB/s(-0.68)     433 MB/s(-0.68)
RR    256  64K    16         BW       569 MB/s       565 MB/s(-0.70)     566 MB/s(-0.52)     563 MB/s(-1.05)    565 MB/s(-0.70)     566 MB/s(-0.52)
RW    256   8K    32         BW       340 MB/s       337 MB/s(-0.88)     336 MB/s(-1.17)     332 MB/s(-2.35)    336 MB/s(-1.17)     332 MB/s(-2.35)
RW    256   8K    32         BW       530 MB/s       528 MB/s(-0.37)     528 MB/s(-0.37)     528 MB/s(-0.37)    528 MB/s(-0.37)     528 MB/s(-0.37)
W     512   1M     8         BW       449 MB/s       450 MB/s( 0.22)     450 MB/s( 0.22)     447 MB/s(-0.44)    451 MB/s( 0.44)     450 MB/s( 0.22)
R     512   1M     8         BW       830 MB/s       830 MB/s( 0.00)     833 MB/s( 0.36)     832 MB/s( 0.24)    833 MB/s( 0.36)     833 MB/s( 0.36)
RW    512  64K    16         BW       436 MB/s       431 MB/s(-1.14)     433 MB/s(-0.68)     434 MB/s(-0.45)    433 MB/s(-0.68)     430 MB/s(-1.37)
RR    512  64K    16         BW       567 MB/s       564 MB/s(-0.52)     567 MB/s( 0.00)     556 MB/s(-1.94)    565 MB/s(-0.35)     565 MB/s(-0.35)
RW    512   8K    32         BW       332 MB/s       333 MB/s( 0.30)     330 MB/s(-0.60)     334 MB/s( 0.60)    333 MB/s( 0.30)     326 MB/s(-1.80)
RW    512   8K    32         BW       524 MB/s       531 MB/s( 1.33)     520 MB/s(-0.76)     529 MB/s( 0.95)    531 MB/s( 1.33)     522 MB/s(-0.38)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS1-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    SLAT AVG           66.1 us           68.9 us (-4.23)         69.4 us (-4.91)         68.9 us (-4.23)      301.7 us (-356.15)     458.5 us (-593.22)
R       1   1M     8    SLAT AVG           57.2 us           50.8 us (11.22)         43.4 us (24.09)         50.8 us (11.22)      251.5 us (-339.65)        38.5 us (32.70)
RW      1  64K    16    SLAT AVG           16.5 us          20.4 us (-23.03)         18.0 us (-9.06)        20.4 us (-23.03)        20.5 us (-23.76)       20.2 us (-21.88)
RR      1  64K    16    SLAT AVG           10.6 us           10.9 us (-1.97)        11.8 us (-10.32)         10.9 us (-1.97)        16.0 us (-50.04)       12.5 us (-17.55)
RW      1   8K    32    SLAT AVG           28.1 us           22.7 us (19.15)         25.1 us (10.78)         22.7 us (19.15)         28.2 us (-0.39)        24.3 us (13.49)
RW      1   8K    32    SLAT AVG           11.0 us           11.1 us (-1.36)         11.1 us (-1.00)         11.1 us (-1.36)         11.0 us ( 0.00)        11.2 us (-1.82)
W       2   1M     8    SLAT AVG           72.6 us           79.5 us (-9.49)       100.8 us (-38.86)         79.5 us (-9.49)      346.4 us (-377.23)        59.9 us (17.44)
R       2   1M     8    SLAT AVG           57.3 us           44.3 us (22.70)        64.6 us (-12.65)         44.3 us (22.70)      255.9 us (-346.59)        43.4 us (24.22)	
RW      2  64K    16    SLAT AVG           17.3 us           18.2 us (-4.96)         17.6 us (-1.44)         18.2 us (-4.96)        21.5 us (-24.09)        16.8 us ( 2.88)
RR      2  64K    16    SLAT AVG           12.0 us           11.7 us ( 2.58)        13.3 us (-10.76)         11.7 us ( 2.58)        19.9 us (-66.02)       16.7 us (-39.31)
RW      2   8K    32    SLAT AVG           16.5 us           16.2 us ( 1.51)         15.6 us ( 5.10)         16.2 us ( 1.51)         15.8 us ( 4.19)        16.3 us ( 0.97)
RW      2   8K    32    SLAT AVG            7.8 us          10.3 us (-31.92)          8.4 us (-7.82)        10.3 us (-31.92)        12.9 us (-65.64)         8.2 us (-5.38)
W       4   1M     8    SLAT AVG           73.3 us       912.7 us (-1144.29)         78.5 us (-6.99)     912.7 us (-1144.29)        82.7 us (-12.70)       92.3 us (-25.82)
R       4   1M     8    SLAT AVG           25.5 us          44.5 us (-74.77)        41.0 us (-60.80)        44.5 us (-74.77)        40.8 us (-59.94)      56.3 us (-120.71)
RW      4  64K    16    SLAT AVG           18.9 us           20.7 us (-9.58)         19.0 us (-0.84)         20.7 us (-9.58)         17.8 us ( 5.87)        17.9 us ( 5.39)
RR      4  64K    16    SLAT AVG            9.3 us            9.0 us ( 2.69)          7.2 us (22.41)          9.0 us ( 2.69)          7.7 us (16.70)         8.6 us ( 7.43)
RW      4   8K    32    SLAT AVG           89.4 us           90.9 us (-1.61)         90.5 us (-1.18)         90.9 us (-1.61)         93.6 us (-4.68)        91.4 us (-2.25)
RW      4   8K    32    SLAT AVG           57.1 us           58.0 us (-1.61)         57.2 us (-0.31)         58.0 us (-1.61)         57.0 us ( 0.03)        57.2 us (-0.19)
W       8   1M     8    SLAT AVG         3944.1 us      12078.7 us (-206.24)        408.8 us (89.63)    12078.7 us (-206.24)        658.8 us (83.29)       684.3 us (82.65)
R       8   1M     8    SLAT AVG         1289.7 us       6871.1 us (-432.75)         31.7 us (97.54)     6871.1 us (-432.75)         32.3 us (97.49)    5000.1 us (-287.69)
RW      8  64K    16    SLAT AVG         1039.6 us         1035.4 us ( 0.40)       1051.6 us (-1.14)       1035.4 us ( 0.40)       1047.2 us (-0.73)      1035.9 us ( 0.35)
RR      8  64K    16    SLAT AVG          797.7 us          762.9 us ( 4.35)        767.2 us ( 3.82)        762.9 us ( 4.35)        762.9 us ( 4.35)       754.0 us ( 5.47)
RW      8   8K    32    SLAT AVG          188.9 us          187.9 us ( 0.51)        186.6 us ( 1.24)        187.9 us ( 0.51)        187.1 us ( 0.93)       188.4 us ( 0.25)
RW      8   8K    32    SLAT AVG          118.9 us          118.8 us ( 0.05)        118.4 us ( 0.40)        118.8 us ( 0.05)        121.1 us (-1.88)       118.6 us ( 0.26)
W      16   1M     8    SLAT AVG        34424.9 us        30639.2 us (10.99)      32747.9 us ( 4.87)      30639.2 us (10.99)      32097.8 us ( 6.75)     33219.7 us ( 3.50)
R      16   1M     8    SLAT AVG        16336.7 us       18195.1 us (-11.37)      16116.6 us ( 1.34)     18195.1 us (-11.37)      17533.2 us (-7.32)     17440.2 us (-6.75)
RW     16  64K    16    SLAT AVG         2394.8 us         2419.3 us (-1.02)       2403.7 us (-0.37)       2419.3 us (-1.02)       2410.5 us (-0.65)      2438.8 us (-1.83)
RR     16  64K    16    SLAT AVG         1839.5 us         1849.9 us (-0.56)       1835.8 us ( 0.20)       1849.9 us (-0.56)       1855.0 us (-0.84)      1856.0 us (-0.89)
RW     16   8K    32    SLAT AVG          373.5 us          376.4 us (-0.78)        377.4 us (-1.04)        376.4 us (-0.78)        382.0 us (-2.27)       378.4 us (-1.30)
RW     16   8K    32    SLAT AVG          239.9 us          243.8 us (-1.63)        240.4 us (-0.20)        243.8 us (-1.63)        243.3 us (-1.43)       239.8 us ( 0.02)
W      32   1M     8    SLAT AVG        73985.5 us        74152.6 us (-0.22)      73794.5 us ( 0.25)      74152.6 us (-0.22)      74439.5 us (-0.61)     74070.6 us (-0.11)
R      32   1M     8    SLAT AVG        40168.0 us        39981.1 us ( 0.46)      40034.8 us ( 0.33)      39981.1 us ( 0.46)      40110.7 us ( 0.14)     39998.8 us ( 0.42)
RW     32  64K    16    SLAT AVG         4803.5 us         4812.7 us (-0.18)       4858.6 us (-1.14)       4812.7 us (-0.18)       4842.3 us (-0.80)      4833.7 us (-0.62)
RR     32  64K    16    SLAT AVG         3751.9 us         3703.0 us ( 1.30)       3705.6 us ( 1.23)       3703.0 us ( 1.30)       3747.9 us ( 0.10)      3695.5 us ( 1.50)
RW     32   8K    32    SLAT AVG          748.2 us          765.0 us (-2.23)        749.8 us (-0.21)        765.0 us (-2.23)        750.0 us (-0.23)       762.4 us (-1.89)
RW     32   8K    32    SLAT AVG          488.1 us          492.2 us (-0.83)        498.1 us (-2.05)        492.2 us (-0.83)        489.2 us (-0.22)       498.9 us (-2.21)
W      64   1M     8    SLAT AVG       148152.2 us       148734.5 us (-0.39)     148558.1 us (-0.27)     148734.5 us (-0.39)     148389.2 us (-0.15)    148354.1 us (-0.13)
R      64   1M     8    SLAT AVG        80564.5 us        80255.7 us ( 0.38)      80000.7 us ( 0.69)      80255.7 us ( 0.38)      80228.2 us ( 0.41)     80298.6 us ( 0.32)
RW     64  64K    16    SLAT AVG         9587.7 us         9594.3 us (-0.06)       9615.0 us (-0.28)       9594.3 us (-0.06)       9625.2 us (-0.39)      9582.7 us ( 0.05)
RR     64  64K    16    SLAT AVG         7382.9 us         7433.5 us (-0.68)       7452.1 us (-0.93)       7433.5 us (-0.68)       7435.5 us (-0.71)      7493.8 us (-1.50)
RW     64   8K    32    SLAT AVG         1557.9 us         1511.4 us ( 2.98)       1506.5 us ( 3.29)       1511.4 us ( 2.98)       1512.7 us ( 2.90)      1510.4 us ( 3.04)
RW     64   8K    32    SLAT AVG         1000.1 us         1003.3 us (-0.31)        985.7 us ( 1.44)       1003.3 us (-0.31)        990.2 us ( 0.99)      1007.7 us (-0.75)
W     128   1M     8    SLAT AVG       295432.7 us       297571.5 us (-0.72)     297037.9 us (-0.54)     297571.5 us (-0.72)     295636.5 us (-0.06)    297350.6 us (-0.64)
R     128   1M     8    SLAT AVG       160875.1 us       160175.8 us ( 0.43)     160566.7 us ( 0.19)     160175.8 us ( 0.43)     160508.1 us ( 0.22)    160453.9 us ( 0.26)
RW    128  64K    16    SLAT AVG        19287.8 us        19382.9 us (-0.49)      19468.8 us (-0.93)      19382.9 us (-0.49)      19331.2 us (-0.22)     19439.9 us (-0.78)
RR    128  64K    16    SLAT AVG        14959.2 us        14924.1 us ( 0.23)      15106.7 us (-0.98)      14924.1 us ( 0.23)      14793.5 us ( 1.10)     14851.7 us ( 0.71)
RW    128   8K    32    SLAT AVG         3010.8 us         3018.8 us (-0.26)       3031.2 us (-0.67)       3018.8 us (-0.26)       3014.0 us (-0.10)      3039.5 us (-0.95)
RW    128   8K    32    SLAT AVG         2021.4 us         2027.9 us (-0.31)       1977.2 us ( 2.18)       2027.9 us (-0.31)       1974.2 us ( 2.33)      2020.2 us ( 0.06)
W     256   1M     8    SLAT AVG       594516.2 us       593344.6 us ( 0.19)     591076.4 us ( 0.57)     593344.6 us ( 0.19)     591613.2 us ( 0.48)    593075.6 us ( 0.24)
R     256   1M     8    SLAT AVG       320966.6 us       320537.3 us ( 0.13)     320940.2 us ( 0.00)     320537.3 us ( 0.13)     319791.9 us ( 0.36)    319869.3 us ( 0.34)
RW    256  64K    16    SLAT AVG        38470.8 us        38651.1 us (-0.46)      38834.8 us (-0.94)      38651.1 us (-0.46)      38680.5 us (-0.54)     38710.4 us (-0.62)
RR    256  64K    16    SLAT AVG        29492.5 us        29761.0 us (-0.91)      29622.6 us (-0.44)      29761.0 us (-0.91)      29695.4 us (-0.68)     29613.8 us (-0.41)
RW    256   8K    32    SLAT AVG         6158.0 us         6298.9 us (-2.28)       6242.2 us (-1.36)       6298.9 us (-2.28)       6227.6 us (-1.13)      6314.0 us (-2.53)
RW    256   8K    32    SLAT AVG         3953.4 us         3966.4 us (-0.32)       3966.6 us (-0.33)       3966.4 us (-0.32)       3966.1 us (-0.32)      3967.7 us (-0.36)
W     512   1M     8    SLAT AVG      1179263.7 us      1183382.0 us (-0.34)    1177489.5 us ( 0.15)    1183382.0 us (-0.34)    1176261.1 us ( 0.25)   1179015.2 us ( 0.02)
R     512   1M     8    SLAT AVG       642650.9 us       640613.8 us ( 0.31)     640251.1 us ( 0.37)     640613.8 us ( 0.31)     640184.1 us ( 0.38)    640297.9 us ( 0.36)
RW    512  64K    16    SLAT AVG        76900.6 us        77168.2 us (-0.34)      77472.5 us (-0.74)      77168.2 us (-0.34)      77447.1 us (-0.71)     77943.0 us (-1.35)
RR    512  64K    16    SLAT AVG        59081.4 us        60308.1 us (-2.07)      59080.9 us ( 0.00)      60308.1 us (-2.07)      59382.6 us (-0.50)     59304.8 us (-0.37)
RW    512   8K    32    SLAT AVG        12631.9 us        12528.2 us ( 0.82)      12693.9 us (-0.49)      12528.2 us ( 0.82)      12573.6 us ( 0.46)     12862.3 us (-1.82)
RW    512   8K    32    SLAT AVG         8005.1 us         7926.6 us ( 0.97)       8056.9 us (-0.64)       7926.6 us ( 0.97)       7898.8 us ( 1.32)      8030.2 us (-0.31)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS1-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    LAT AVG         18873.5 us        19012.7 us (-0.73)      18599.8 us ( 1.45)      18705.3 us ( 0.89)      18670.2 us ( 1.07)      18779.1 us ( 0.49)
R       1   1M     8    LAT AVG         12560.7 us        12584.7 us (-0.19)      10898.3 us (13.23)      12832.0 us (-2.15)      12698.5 us (-1.09)      10822.3 us (13.83)	###
RW      1  64K    16    LAT AVG          2393.5 us         2398.3 us (-0.19)       2400.1 us (-0.27)       2420.1 us (-1.11)       2404.4 us (-0.45)       2404.3 us (-0.44)
RR      1  64K    16    LAT AVG          2255.0 us         2272.7 us (-0.78)       2247.0 us ( 0.35)       2255.7 us (-0.03)       2264.7 us (-0.43)       2266.0 us (-0.48)
RW      1   8K    32    LAT AVG          1019.4 us          999.6 us ( 1.94)        941.9 us ( 7.60)        894.6 us (12.24)       1015.6 us ( 0.37)        927.5 us ( 9.01)	###
RW      1   8K    32    LAT AVG           488.1 us          488.1 us ( 0.00)        492.0 us (-0.80)        493.2 us (-1.05)        490.0 us (-0.39)        491.6 us (-0.72)
W       2   1M     8    LAT AVG         37154.1 us        37130.3 us ( 0.06)      37249.5 us (-0.25)      37464.1 us (-0.83)      37341.6 us (-0.50)      37166.3 us (-0.03)
R       2   1M     8    LAT AVG         24440.8 us        24500.7 us (-0.24)      20643.3 us (15.53)      20503.9 us (16.10)      20516.2 us (16.05)      20501.1 us (16.11)	###
RW      2  64K    16    LAT AVG          4818.2 us         4829.2 us (-0.22)       4789.4 us ( 0.59)       4778.7 us ( 0.81)       4832.8 us (-0.30)       4799.2 us ( 0.39)
RR      2  64K    16    LAT AVG          3709.9 us         3721.5 us (-0.31)       3682.9 us ( 0.72)       3744.2 us (-0.92)       3706.0 us ( 0.10)       3685.1 us ( 0.67)
RW      2   8K    32    LAT AVG          1515.3 us         1501.8 us ( 0.89)       1521.8 us (-0.42)       1505.7 us ( 0.62)       1509.5 us ( 0.37)       1549.5 us (-2.26)
RW      2   8K    32    LAT AVG           954.7 us          960.1 us (-0.57)        961.3 us (-0.70)        966.4 us (-1.22)        969.9 us (-1.59)        959.6 us (-0.51)
W       4   1M     8    LAT AVG         74360.0 us        74440.0 us (-0.10)      74720.0 us (-0.48)      78230.0 us (-5.20)      74380.0 us (-0.02)      74230.0 us ( 0.17)
R       4   1M     8    LAT AVG         40320.9 us        40481.1 us (-0.39)      40400.5 us (-0.19)      40217.7 us ( 0.25)      40650.0 us (-0.81)      41220.0 us (-2.22)
RW      4  64K    16    LAT AVG          9585.6 us         9672.2 us (-0.90)       9728.6 us (-1.49)       9691.8 us (-1.10)       9647.6 us (-0.64)       9611.9 us (-0.27)
RR      4  64K    16    LAT AVG          7519.7 us         7418.3 us ( 1.34)       7408.0 us ( 1.48)       7449.3 us ( 0.93)       7398.8 us ( 1.60)       7382.4 us ( 1.82)
RW      4   8K    32    LAT AVG          3000.6 us         3055.7 us (-1.83)       3027.2 us (-0.88)       3003.4 us (-0.09)       3099.8 us (-3.30)       3041.1 us (-1.34)
RW      4   8K    32    LAT AVG          1914.2 us         1915.4 us (-0.06)       1921.2 us (-0.36)       1939.9 us (-1.34)       1913.9 us ( 0.01)       1917.3 us (-0.16)
W       8   1M     8    LAT AVG        148540.0 us       150070.0 us (-1.03)     149050.0 us (-0.34)     153720.0 us (-3.48)     148920.0 us (-0.25)     149250.0 us (-0.47)
R       8   1M     8    LAT AVG         80670.0 us        80730.0 us (-0.07)      80830.0 us (-0.19)      81210.0 us (-0.66)      80410.0 us ( 0.32)      80860.0 us (-0.23)
RW      8  64K    16    LAT AVG         19487.3 us        19224.5 us ( 1.34)      19465.0 us ( 0.11)      19325.6 us ( 0.82)      19399.4 us ( 0.45)      19246.7 us ( 1.23)
RR      8  64K    16    LAT AVG         14994.2 us        14766.2 us ( 1.52)      14982.7 us ( 0.07)      14775.1 us ( 1.46)      14931.8 us ( 0.41)      14883.3 us ( 0.73)
RW      8   8K    32    LAT AVG          6098.8 us         6000.5 us ( 1.61)       6016.8 us ( 1.34)       6081.0 us ( 0.29)       6038.8 us ( 0.98)       6077.1 us ( 0.35)
RW      8   8K    32    LAT AVG          3846.1 us         3838.3 us ( 0.20)       3829.9 us ( 0.41)       3842.2 us ( 0.09)       3929.8 us (-2.17)       3834.1 us ( 0.31)
W      16   1M     8    LAT AVG        298020.0 us       299060.0 us (-0.34)     298760.0 us (-0.24)     297220.0 us ( 0.26)     298150.0 us (-0.04)     297920.0 us ( 0.03)
R      16   1M     8    LAT AVG        161430.0 us       161560.0 us (-0.08)     160960.0 us ( 0.29)     161000.0 us ( 0.26)     160620.0 us ( 0.50)     160910.0 us ( 0.32)
RW     16  64K    16    LAT AVG         38437.0 us        38550.0 us (-0.29)      38560.0 us (-0.31)      38828.1 us (-1.01)      38668.9 us (-0.60)      39151.1 us (-1.85)
RR     16  64K    16    LAT AVG         29535.4 us        29771.5 us (-0.79)      29506.2 us ( 0.09)      29689.1 us (-0.52)      29780.0 us (-0.82)      29833.0 us (-1.00)
RW     16   8K    32    LAT AVG         12007.2 us        12010.5 us (-0.02)      12129.0 us (-1.01)      12104.1 us (-0.80)      12279.2 us (-2.26)      12159.6 us (-1.26)
RW     16   8K    32    LAT AVG          7723.1 us         7693.3 us ( 0.38)       7739.2 us (-0.20)       7852.6 us (-1.67)       7835.0 us (-1.44)       7719.8 us ( 0.04)
W      32   1M     8    LAT AVG        594030.0 us       594460.0 us (-0.07)     592020.0 us ( 0.33)     593830.0 us ( 0.03)     596150.0 us (-0.35)     593740.0 us ( 0.04)
R      32   1M     8    LAT AVG        322030.0 us       321990.0 us ( 0.01)     321110.0 us ( 0.28)     320030.0 us ( 0.62)     321330.0 us ( 0.21)     320100.0 us ( 0.59)
RW     32  64K    16    LAT AVG         76880.0 us        77240.0 us (-0.46)      77760.0 us (-1.14)      77030.0 us (-0.19)      77500.0 us (-0.80)      77350.0 us (-0.61)
RR     32  64K    16    LAT AVG         60050.0 us        59360.0 us ( 1.14)      59300.0 us ( 1.24)      59270.0 us ( 1.29)      59990.0 us ( 0.09)      59140.0 us ( 1.51)
RW     32   8K    32    LAT AVG         24015.3 us        24011.3 us ( 0.01)      24060.5 us (-0.18)      24548.8 us (-2.22)      24066.4 us (-0.21)      24464.5 us (-1.87)
RW     32   8K    32    LAT AVG         15672.8 us        15679.1 us (-0.04)      15997.6 us (-2.07)      15803.4 us (-0.83)      15708.2 us (-0.22)      16024.3 us (-2.24)
W      64   1M     8    LAT AVG       1180380.0 us      1182930.0 us (-0.21)    1183380.0 us (-0.25)    1184430.0 us (-0.34)    1182230.0 us (-0.15)    1182160.0 us (-0.15)
R      64   1M     8    LAT AVG        643000.0 us       640920.0 us ( 0.32)     638430.0 us ( 0.71)     640520.0 us ( 0.38)     640210.0 us ( 0.43)     640790.0 us ( 0.34)
RW     64  64K    16    LAT AVG        153320.0 us       153940.0 us (-0.40)     153760.0 us (-0.28)     153420.0 us (-0.06)     153930.0 us (-0.39)     153230.0 us ( 0.05)
RR     64  64K    16    LAT AVG        118080.0 us       117950.0 us ( 0.11)     119190.0 us (-0.94)     118880.0 us (-0.67)     118920.0 us (-0.71)     119850.0 us (-1.49)
RW     64   8K    32    LAT AVG         49917.6 us        48266.9 us ( 3.30)      48276.1 us ( 3.28)      48412.1 us ( 3.01)      48469.3 us ( 2.90)      48382.5 us ( 3.07)
RW     64   8K    32    LAT AVG         32057.3 us        31420.8 us ( 1.98)      31590.3 us ( 1.45)      32162.1 us (-0.32)      31738.9 us ( 0.99)      32299.8 us (-0.75)
W     128   1M     8    LAT AVG       2333670.0 us      2346190.0 us (-0.53)    2346610.0 us (-0.55)    2350920.0 us (-0.73)    2335550.0 us (-0.08)    2348390.0 us (-0.63)
R     128   1M     8    LAT AVG       1278850.0 us      1280040.0 us (-0.09)    1276030.0 us ( 0.22)    1272630.0 us ( 0.48)    1275300.0 us ( 0.27)    1274870.0 us ( 0.31)
RW    128  64K    16    LAT AVG        308035.9 us       307683.7 us ( 0.11)     310932.1 us (-0.94)     309541.4 us (-0.48)     308725.3 us (-0.22)     310436.3 us (-0.77)
RR    128  64K    16    LAT AVG        239010.0 us       237570.0 us ( 0.60)     241340.0 us (-0.97)     238440.0 us ( 0.23)     236350.0 us ( 1.11)     237280.0 us ( 0.72)
RW    128   8K    32    LAT AVG         96345.8 us        99931.1 us (-3.72)      97013.5 us (-0.69)      96631.2 us (-0.29)      96438.0 us (-0.09)      97250.1 us (-0.93)
RW    128   8K    32    LAT AVG         64715.5 us        63316.5 us ( 2.16)      63299.7 us ( 2.18)      64922.5 us (-0.31)      63201.7 us ( 2.33)      64675.1 us ( 0.06)
W     256   1M     8    LAT AVG       4626300.0 us      4625540.0 us ( 0.01)    4602410.0 us ( 0.51)    4619430.0 us ( 0.14)    4595730.0 us ( 0.66)    4618030.0 us ( 0.17)
R     256   1M     8    LAT AVG       2529380.0 us      2537400.0 us (-0.31)    2528460.0 us ( 0.03)    2525920.0 us ( 0.13)    2520700.0 us ( 0.34)    2519440.0 us ( 0.39)
RW    256  64K    16    LAT AVG        612973.5 us       616360.7 us (-0.55)     618768.4 us (-0.94)     615890.4 us (-0.47)     616345.8 us (-0.55)     616782.3 us (-0.62)
RR    256  64K    16    LAT AVG        470350.0 us       473020.0 us (-0.56)     472380.0 us (-0.43)     474630.0 us (-0.90)     473600.0 us (-0.69)     472230.0 us (-0.39)
RW    256   8K    32    LAT AVG        196851.8 us       198838.9 us (-1.00)     199539.2 us (-1.36)     201364.1 us (-2.29)     199054.7 us (-1.11)     201788.0 us (-2.50)
RW    256   8K    32    LAT AVG        126451.5 us       126998.5 us (-0.43)     126875.7 us (-0.33)     126866.1 us (-0.32)     126859.2 us (-0.32)     126906.1 us (-0.35)
W     512   1M     8    LAT AVG       8904540.0 us      8898560.0 us ( 0.06)    8886410.0 us ( 0.20)    8926630.0 us (-0.24)    8885030.0 us ( 0.21)    8899820.0 us ( 0.05)
R     512   1M     8    LAT AVG       4978800.0 us      4977430.0 us ( 0.02)    4959540.0 us ( 0.38)    4960300.0 us ( 0.37)    4959810.0 us ( 0.38)    4958410.0 us ( 0.40)
RW    512  64K    16    LAT AVG       1220062.3 us      1234352.5 us (-1.17)    1228689.0 us (-0.70)    1223663.9 us (-0.29)    1227745.8 us (-0.62)    1236206.0 us (-1.32)
RR    512  64K    16    LAT AVG        938860.0 us       944890.1 us (-0.64)     938720.0 us ( 0.01)     958220.0 us (-2.06)     943460.0 us (-0.48)     942294.2 us (-0.36)
RW    512   8K    32    LAT AVG        403088.8 us       401876.5 us ( 0.30)     404934.0 us (-0.45)     399775.0 us ( 0.82)     401125.4 us ( 0.48)     410164.4 us (-1.75)
RW    512   8K    32    LAT AVG        255725.7 us       252158.8 us ( 1.39)     257406.7 us (-0.65)     253236.3 us ( 0.97)     252352.8 us ( 1.31)     256544.0 us (-0.31)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS1-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    CLAT AVG        18807.1 us        18955.8 us (-0.79)      18530.2 us ( 1.47)      18636.2 us ( 0.90)      18368.3 us ( 2.33)      18320.4 us ( 2.58)
R       1   1M     8    CLAT AVG        12503.4 us        12532.8 us (-0.23)      10854.8 us (13.18)      12781.1 us (-2.22)      12446.9 us ( 0.45)      10783.7 us (13.75)	###
RW      1  64K    16    CLAT AVG         2376.9 us         2382.9 us (-0.25)       2381.9 us (-0.21)       2399.7 us (-0.95)       2383.9 us (-0.29)       2384.0 us (-0.29)
RR      1  64K    16    CLAT AVG         2244.2 us         2262.0 us (-0.79)       2235.2 us ( 0.40)       2244.7 us (-0.02)       2248.6 us (-0.19)       2253.4 us (-0.40)
RW      1   8K    32    CLAT AVG          991.2 us          971.8 us ( 1.96)        916.7 us ( 7.51)        871.8 us (12.05)        987.3 us ( 0.39)        903.1 us ( 8.88)	###
RW      1   8K    32    CLAT AVG          477.0 us          477.2 us (-0.03)        480.8 us (-0.79)        482.0 us (-1.04)        479.0 us (-0.40)        480.4 us (-0.70)
W       2   1M     8    CLAT AVG        37081.3 us        37066.1 us ( 0.04)      37148.4 us (-0.18)      37384.4 us (-0.81)      36995.0 us ( 0.23)      37106.2 us (-0.06)
R       2   1M     8    CLAT AVG        24383.4 us        24442.0 us (-0.24)      20578.6 us (15.60)      20459.5 us (16.09)      20260.2 us (16.90)      20457.6 us (16.10)	###
RW      2  64K    16    CLAT AVG         4800.8 us         4806.5 us (-0.12)       4771.7 us ( 0.60)       4760.4 us ( 0.84)       4811.2 us (-0.21)       4782.3 us ( 0.38)
RR      2  64K    16    CLAT AVG         3697.9 us         3708.1 us (-0.27)       3669.6 us ( 0.76)       3732.5 us (-0.93)       3686.1 us ( 0.31)       3668.3 us ( 0.80)
RW      2   8K    32    CLAT AVG         1498.7 us         1486.6 us ( 0.81)       1506.1 us (-0.48)       1489.5 us ( 0.61)       1493.7 us ( 0.33)       1533.2 us (-2.29)
RW      2   8K    32    CLAT AVG          946.8 us          952.2 us (-0.57)        952.9 us (-0.64)        956.0 us (-0.97)        956.9 us (-1.06)        951.3 us (-0.47)
W       4   1M     8    CLAT AVG        74280.0 us        74350.0 us (-0.09)      74640.0 us (-0.48)      77320.0 us (-4.09)      74300.0 us (-0.02)      74140.0 us ( 0.18)
R       4   1M     8    CLAT AVG        40295.3 us        40456.7 us (-0.40)      40359.3 us (-0.15)      40173.0 us ( 0.30)      40610.0 us (-0.78)      41170.0 us (-2.17)
RW      4  64K    16    CLAT AVG         9566.6 us         9652.0 us (-0.89)       9709.4 us (-1.49)       9671.0 us (-1.09)       9629.8 us (-0.66)       9593.9 us (-0.28)
RR      4  64K    16    CLAT AVG         7510.3 us         7410.9 us ( 1.32)       7400.8 us ( 1.45)       7440.1 us ( 0.93)       7391.0 us ( 1.58)       7373.7 us ( 1.81)
RW      4   8K    32    CLAT AVG         2911.1 us         2963.5 us (-1.80)       2936.6 us (-0.87)       2912.4 us (-0.04)       3006.1 us (-3.26)       2949.6 us (-1.32)
RW      4   8K    32    CLAT AVG         1857.1 us         1858.2 us (-0.06)       1863.8 us (-0.36)       1881.8 us (-1.33)       1856.8 us ( 0.01)       1860.1 us (-0.15)
W       8   1M     8    CLAT AVG       144600.0 us       139300.0 us ( 3.66)     148640.0 us (-2.79)     141640.0 us ( 2.04)     148260.0 us (-2.53)     148570.0 us (-2.74)
R       8   1M     8    CLAT AVG        79380.0 us        79410.0 us (-0.03)      80800.0 us (-1.78)      74340.0 us ( 6.34)      80380.0 us (-1.25)      75860.0 us ( 4.43)
RW      8  64K    16    CLAT AVG        18447.5 us        18194.6 us ( 1.37)      18413.4 us ( 0.18)      18290.1 us ( 0.85)      18352.1 us ( 0.51)      18210.7 us ( 1.28)
RR      8  64K    16    CLAT AVG        14196.4 us        14012.8 us ( 1.29)      14215.4 us (-0.13)      14012.1 us ( 1.29)      14168.8 us ( 0.19)      14129.1 us ( 0.47)
RW      8   8K    32    CLAT AVG         5909.7 us         5814.4 us ( 1.61)       5830.2 us ( 1.34)       5893.0 us ( 0.28)       5851.5 us ( 0.98)       5888.5 us ( 0.35)
RW      8   8K    32    CLAT AVG         3727.1 us         3719.5 us ( 0.20)       3711.4 us ( 0.42)       3723.4 us ( 0.10)       3808.6 us (-2.18)       3715.5 us ( 0.31)
W      16   1M     8    CLAT AVG       263600.0 us       268210.0 us (-1.74)     266010.0 us (-0.91)     266580.0 us (-1.13)     266050.0 us (-0.92)     264700.0 us (-0.41)
R      16   1M     8    CLAT AVG       145090.0 us       145380.0 us (-0.19)     144850.0 us ( 0.16)     142800.0 us ( 1.57)     143080.0 us ( 1.38)     143470.0 us ( 1.11)
RW     16  64K    16    CLAT AVG        36042.1 us        36140.0 us (-0.27)      36154.9 us (-0.31)      36408.6 us (-1.01)      36258.2 us (-0.59)      36712.1 us (-1.85)
RR     16  64K    16    CLAT AVG        27695.8 us        27918.9 us (-0.80)      27670.3 us ( 0.09)      27839.1 us (-0.51)      27924.9 us (-0.82)      27976.8 us (-1.01)
RW     16   8K    32    CLAT AVG        11633.6 us        11636.8 us (-0.02)      11751.5 us (-1.01)      11727.5 us (-0.80)      11897.1 us (-2.26)      11781.2 us (-1.26)
RW     16   8K    32    CLAT AVG         7483.1 us         7454.2 us ( 0.38)       7498.7 us (-0.20)       7608.7 us (-1.67)       7591.6 us (-1.44)       7479.9 us ( 0.04)
W      32   1M     8    CLAT AVG       520040.0 us       520480.0 us (-0.08)     518230.0 us ( 0.34)     519670.0 us ( 0.07)     521710.0 us (-0.32)     519670.0 us ( 0.07)
R      32   1M     8    CLAT AVG       281860.0 us       281780.0 us ( 0.02)     281080.0 us ( 0.27)     280040.0 us ( 0.64)     281220.0 us ( 0.22)     280100.0 us ( 0.62)
RW     32  64K    16    CLAT AVG        72080.0 us        72420.0 us (-0.47)      72900.0 us (-1.13)      72210.0 us (-0.18)      72650.0 us (-0.79)      72520.0 us (-0.61)
RR     32  64K    16    CLAT AVG        56290.0 us        55650.0 us ( 1.13)      55599.2 us ( 1.22)      55560.0 us ( 1.29)      56240.0 us ( 0.08)      55450.0 us ( 1.49)
RW     32   8K    32    CLAT AVG        23266.9 us        23262.7 us ( 0.01)      23310.6 us (-0.18)      23783.6 us (-2.22)      23316.3 us (-0.21)      23702.0 us (-1.87)
RW     32   8K    32    CLAT AVG        15184.6 us        15190.7 us (-0.04)      15499.3 us (-2.07)      15311.1 us (-0.83)      15218.8 us (-0.22)      15525.3 us (-2.24)
W      64   1M     8    CLAT AVG      1032230.0 us      1034480.0 us (-0.21)    1034820.0 us (-0.25)    1035700.0 us (-0.33)    1033840.0 us (-0.15)    1033810.0 us (-0.15)
R      64   1M     8    CLAT AVG       562430.0 us       560610.0 us ( 0.32)     558430.0 us ( 0.71)     560270.0 us ( 0.38)     559980.0 us ( 0.43)     560490.0 us ( 0.34)
RW     64  64K    16    CLAT AVG       143730.0 us       144310.0 us (-0.40)     144140.0 us (-0.28)     143830.0 us (-0.06)     144300.0 us (-0.39)     143650.0 us ( 0.05)
RR     64  64K    16    CLAT AVG       110696.6 us       110580.0 us ( 0.10)     111730.0 us (-0.93)     111450.0 us (-0.68)     111480.0 us (-0.70)     112360.0 us (-1.50)
RW     64   8K    32    CLAT AVG        48359.6 us        46760.4 us ( 3.30)      46769.4 us ( 3.28)      46900.6 us ( 3.01)      46956.4 us ( 2.90)      46872.0 us ( 3.07)
RW     64   8K    32    CLAT AVG        31057.0 us        30440.2 us ( 1.98)      30604.5 us ( 1.45)      31158.7 us (-0.32)      30748.6 us ( 0.99)      31291.9 us (-0.75)
W     128   1M     8    CLAT AVG      2038230.0 us      2049330.0 us (-0.54)    2049570.0 us (-0.55)    2053340.0 us (-0.74)    2039920.0 us (-0.08)    2051040.0 us (-0.62)
R     128   1M     8    CLAT AVG      1117970.0 us      1118990.0 us (-0.09)    1115460.0 us ( 0.22)    1112450.0 us ( 0.49)    1114790.0 us ( 0.28)    1114420.0 us ( 0.31)
RW    128  64K    16    CLAT AVG       288747.9 us       288417.1 us ( 0.11)     291463.0 us (-0.94)     290158.2 us (-0.48)     289393.9 us (-0.22)     290996.2 us (-0.77)
RR    128  64K    16    CLAT AVG       224050.0 us       222700.0 us ( 0.60)     226233.8 us (-0.97)     223514.1 us ( 0.23)     221560.0 us ( 1.11)     222430.0 us ( 0.72)
RW    128   8K    32    CLAT AVG        93334.8 us        96808.4 us (-3.72)      93982.1 us (-0.69)      93612.2 us (-0.29)      93423.9 us (-0.09)      94210.4 us (-0.93)
RW    128   8K    32    CLAT AVG        62693.9 us        61338.6 us ( 2.16)      61322.3 us ( 2.18)      62894.5 us (-0.31)      61227.4 us ( 2.33)      62654.8 us ( 0.06)
W     256   1M     8    CLAT AVG      4031780.0 us      4031190.0 us ( 0.01)    4011330.0 us ( 0.50)    4026090.0 us ( 0.14)    4004120.0 us ( 0.68)    4024950.0 us ( 0.16)
R     256   1M     8    CLAT AVG      2208410.0 us      2215390.0 us (-0.31)    2207520.0 us ( 0.04)    2205380.0 us ( 0.13)    2200910.0 us ( 0.33)    2199570.0 us ( 0.40)
RW    256  64K    16    CLAT AVG       574502.5 us       577676.6 us (-0.55)     579933.4 us (-0.94)     577239.0 us (-0.47)     577665.1 us (-0.55)     578071.7 us (-0.62)
RR    256  64K    16    CLAT AVG       440852.9 us       443354.7 us (-0.56)     442760.0 us (-0.43)     444870.0 us (-0.91)     443903.7 us (-0.69)     442620.0 us (-0.40)
RW    256   8K    32    CLAT AVG       190693.7 us       192617.6 us (-1.00)     193296.9 us (-1.36)     195065.0 us (-2.29)     192827.0 us (-1.11)     195473.8 us (-2.50)
RW    256   8K    32    CLAT AVG       122497.9 us       123027.8 us (-0.43)     122909.0 us (-0.33)     122899.6 us (-0.32)     122892.9 us (-0.32)     122938.3 us (-0.35)
W     512   1M     8    CLAT AVG      7725280.0 us      7720740.0 us ( 0.05)    7708920.0 us ( 0.21)    7743240.0 us (-0.23)    7708770.0 us ( 0.21)    7720800.0 us ( 0.05)
R     512   1M     8    CLAT AVG      4336150.0 us      4334880.0 us ( 0.02)    4319290.0 us ( 0.38)    4319680.0 us ( 0.37)    4319620.0 us ( 0.38)    4318120.0 us ( 0.41)
RW    512  64K    16    CLAT AVG      1143161.4 us      1156521.8 us (-1.16)    1151216.1 us (-0.70)    1146495.4 us (-0.29)    1150298.3 us (-0.62)    1158262.8 us (-1.32)
RR    512  64K    16    CLAT AVG       879775.4 us       885430.6 us (-0.64)     879635.5 us ( 0.01)     897911.9 us (-2.06)     884080.0 us (-0.48)     882989.2 us (-0.36)
RW    512   8K    32    CLAT AVG       390456.8 us       389277.5 us ( 0.30)     392239.9 us (-0.45)     387246.6 us ( 0.82)     388551.7 us ( 0.48)     397301.9 us (-1.75)
RW    512   8K    32    CLAT AVG       247720.5 us       244265.8 us ( 1.39)     249349.6 us (-0.65)     245309.5 us ( 0.97)     244453.8 us ( 1.31)     248513.6 us (-0.32)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS1-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    CLAT  99        27132.0 us        27395.0 us (-0.96)       21890.0 us (19.32)      22414.0 us (17.38)      22152.0 us (18.35)      22414.0 us (17.38)
R       1   1M     8    CLAT  99        13829.0 us        13829.0 us ( 0.00)      16188.0 us (-17.05)      14222.0 us (-2.84)      14484.0 us (-4.73)      14091.0 us (-1.89)
RW      1  64K    16    CLAT  99         2802.0 us         2868.0 us (-2.35)        2868.0 us (-2.35)       2999.0 us (-7.03)       2933.0 us (-4.67)       2868.0 us (-2.35)
RR      1  64K    16    CLAT  99         4178.0 us         4228.0 us (-1.19)        4228.0 us (-1.19)       4228.0 us (-1.19)       4293.0 us (-2.75)       4293.0 us (-2.75)
RW      1   8K    32    CLAT  99         1418.0 us         1303.0 us ( 8.11)        1221.0 us (13.89)       1221.0 us (13.89)       1270.0 us (10.43)       1237.0 us (12.76)
RW      1   8K    32    CLAT  99          766.0 us          775.0 us (-1.17)         766.0 us ( 0.00)        775.0 us (-1.17)        766.0 us ( 0.00)        766.0 us ( 0.00)
W       2   1M     8    CLAT  99        42730.0 us        42206.0 us ( 1.22)       43254.0 us (-1.22)      44827.0 us (-4.90)      44827.0 us (-4.90)      43779.0 us (-2.45)
R       2   1M     8    CLAT  99        27132.0 us        27132.0 us ( 0.00)       25035.0 us ( 7.72)      22938.0 us (15.45)      28181.0 us (-3.86)      22938.0 us (15.45)
RW      2  64K    16    CLAT  99         5604.0 us         5735.0 us (-2.33)        5538.0 us ( 1.17)       5473.0 us ( 2.33)       5866.0 us (-4.67)       5604.0 us ( 0.00)
RR      2  64K    16    CLAT  99         6587.0 us         6587.0 us ( 0.00)        6521.0 us ( 1.00)       6652.0 us (-0.98)       6587.0 us ( 0.00)       6456.0 us ( 1.98)
RW      2   8K    32    CLAT  99         3523.0 us         3490.0 us ( 0.93)        3556.0 us (-0.93)       3458.0 us ( 1.84)       3523.0 us ( 0.00)       3556.0 us (-0.93)
RW      2   8K    32    CLAT  99         2311.0 us         2343.0 us (-1.38)        2311.0 us ( 0.00)       2278.0 us ( 1.42)       2180.0 us ( 5.66)       2311.0 us ( 0.00)
W       4   1M     8    CLAT  99        91000.0 us        93000.0 us (-2.19)       92000.0 us (-1.09)      93000.0 us (-2.19)      89000.0 us ( 2.19)      89000.0 us ( 2.19)
R       4   1M     8    CLAT  99        49546.0 us        49546.0 us ( 0.00)       42730.0 us (13.75)      42206.0 us (14.81)     58000.0 us (-17.06)     66000.0 us (-33.20)
RW      4  64K    16    CLAT  99        22676.0 us        22938.0 us (-1.15)       23462.0 us (-3.46)      23200.0 us (-2.31)      23200.0 us (-2.31)      23462.0 us (-3.46)
RR      4  64K    16    CLAT  99        17695.0 us        17695.0 us ( 0.00)       17695.0 us ( 0.00)      17695.0 us ( 0.00)      17433.0 us ( 1.48)      17433.0 us ( 1.48)
RW      4   8K    32    CLAT  99         6259.0 us         6390.0 us (-2.09)        6259.0 us ( 0.00)       6259.0 us ( 0.00)       6456.0 us (-3.14)       6390.0 us (-2.09)
RW      4   8K    32    CLAT  99         3949.0 us         3949.0 us ( 0.00)        3982.0 us (-0.83)       3949.0 us ( 0.00)       3949.0 us ( 0.00)       3982.0 us (-0.83)
W       8   1M     8    CLAT  99       262000.0 us      334000.0 us (-27.48)      236000.0 us ( 9.92)    338000.0 us (-29.00)     226000.0 us (13.74)     239000.0 us ( 8.77)
R       8   1M     8    CLAT  99        92000.0 us        89000.0 us ( 3.26)       85000.0 us ( 7.60)    171000.0 us (-85.86)      84000.0 us ( 8.69)    171000.0 us (-85.86)
RW      8  64K    16    CLAT  99        43779.0 us        42730.0 us ( 2.39)       42730.0 us ( 2.39)      42730.0 us ( 2.39)      42730.0 us ( 2.39)      42730.0 us ( 2.39)
RR      8  64K    16    CLAT  99        33817.0 us        34866.0 us (-3.10)       35390.0 us (-4.65)      34341.0 us (-1.54)      35390.0 us (-4.65)      35914.0 us (-6.20)
RW      8   8K    32    CLAT  99        11600.0 us        11469.0 us ( 1.12)       11469.0 us ( 1.12)      11731.0 us (-1.12)      11600.0 us ( 0.00)      11469.0 us ( 1.12)
RW      8   8K    32    CLAT  99         7177.0 us         7177.0 us ( 0.00)        7177.0 us ( 0.00)       7177.0 us ( 0.00)       7242.0 us (-0.90)       7177.0 us ( 0.00)
W      16   1M     8    CLAT  99       600000.0 us      684000.0 us (-14.00)      659000.0 us (-9.83)     659000.0 us (-9.83)    676000.0 us (-12.66)     651000.0 us (-8.50)
R      16   1M     8    CLAT  99       388000.0 us       393000.0 us (-1.28)      393000.0 us (-1.28)     334000.0 us (13.91)     363000.0 us ( 6.44)     376000.0 us ( 3.09)
RW     16  64K    16    CLAT  99        63177.0 us        64226.0 us (-1.66)       64226.0 us (-1.66)      64750.0 us (-2.48)      64750.0 us (-2.48)      66847.0 us (-5.80)
RR     16  64K    16    CLAT  99        49021.0 us        48497.0 us ( 1.06)       48497.0 us ( 1.06)      48497.0 us ( 1.06)      49021.0 us ( 0.00)      50070.0 us (-2.13)
RW     16   8K    32    CLAT  99        19530.0 us        19530.0 us ( 0.00)       20000.0 us (-2.40)      20055.0 us (-2.68)      21000.0 us (-7.52)      20000.0 us (-2.40)
RW     16   8K    32    CLAT  99        12518.0 us        12256.0 us ( 2.09)       12387.0 us ( 1.04)      12780.0 us (-2.09)      12780.0 us (-2.09)      12387.0 us ( 1.04)
W      32   1M     8    CLAT  99       894000.0 us       919000.0 us (-2.79)      919000.0 us (-2.79)     911000.0 us (-1.90)     902000.0 us (-0.89)     852000.0 us ( 4.69)
R      32   1M     8    CLAT  99       460000.0 us       451000.0 us ( 1.95)      464000.0 us (-0.86)     472000.0 us (-2.60)     456000.0 us ( 0.86)     485000.0 us (-5.43)
RW     32  64K    16    CLAT  99       102000.0 us       103000.0 us (-0.98)      104000.0 us (-1.96)     102000.0 us ( 0.00)     104000.0 us (-1.96)     105000.0 us (-2.94)
RR     32  64K    16    CLAT  99        78119.0 us        77071.0 us ( 1.34)       77071.0 us ( 1.34)      79168.0 us (-1.34)      79168.0 us (-1.34)      79168.0 us (-1.34)
RW     32   8K    32    CLAT  99        35390.0 us        38536.0 us (-8.88)       35390.0 us ( 0.00)     42000.0 us (-18.67)      35390.0 us ( 0.00)     39000.0 us (-10.20)
RW     32   8K    32    CLAT  99        22938.0 us        22938.0 us ( 0.00)       23725.0 us (-3.43)      23462.0 us (-2.28)      23200.0 us (-1.14)      23725.0 us (-3.43)
W      64   1M     8    CLAT  99      1418000.0 us      1401000.0 us ( 1.19)     1536000.0 us (-8.32)   1620000.0 us (-14.24)    1469000.0 us (-3.59)   1586000.0 us (-11.84)
R      64   1M     8    CLAT  99       835000.0 us       902000.0 us (-8.02)      911000.0 us (-9.10)     844000.0 us (-1.07)     911000.0 us (-9.10)     852000.0 us (-2.03)
RW     64  64K    16    CLAT  99       184000.0 us       188000.0 us (-2.17)      186000.0 us (-1.08)     197000.0 us (-7.06)     188000.0 us (-2.17)     194000.0 us (-5.43)
RR     64  64K    16    CLAT  99       153000.0 us       153000.0 us ( 0.00)      159000.0 us (-3.92)     157000.0 us (-2.61)     157000.0 us (-2.61)     159000.0 us (-3.92)
RW     64   8K    32    CLAT  99        99000.0 us        85000.0 us (14.14)       86000.0 us (13.13)      93000.0 us ( 6.06)      83000.0 us (16.16)      85000.0 us (14.14)
RW     64   8K    32    CLAT  99        48497.0 us        45876.0 us ( 5.40)       46924.0 us ( 3.24)      48497.0 us ( 0.00)      47973.0 us ( 1.08)      49021.0 us (-1.08)
W     128   1M     8    CLAT  99      3004000.0 us      3104000.0 us (-3.32)     3138000.0 us (-4.46)    3004000.0 us ( 0.00)    2903000.0 us ( 3.36)    2836000.0 us ( 5.59)
R     128   1M     8    CLAT  99      1720000.0 us      1552000.0 us ( 9.76)     1754000.0 us (-1.97)    1838000.0 us (-6.86)    1653000.0 us ( 3.89)    1804000.0 us (-4.88)
RW    128  64K    16    CLAT  99       405000.0 us       393000.0 us ( 2.96)      397000.0 us ( 1.97)     426000.0 us (-5.18)     397000.0 us ( 1.97)     418000.0 us (-3.20)
RR    128  64K    16    CLAT  99       342000.0 us       326000.0 us ( 4.67)      351000.0 us (-2.63)     338000.0 us ( 1.16)     317000.0 us ( 7.30)     342000.0 us ( 0.00)
RW    128   8K    32    CLAT  99       180000.0 us      207000.0 us (-15.00)      182000.0 us (-1.11)     184000.0 us (-2.22)     176000.0 us ( 2.22)     194000.0 us (-7.77)
RW    128   8K    32    CLAT  99       103000.0 us       100000.0 us ( 2.91)       99000.0 us ( 3.88)     103000.0 us ( 0.00)      99000.0 us ( 3.88)     103000.0 us ( 0.00)
W     256   1M     8    CLAT  99      5403000.0 us      5403000.0 us ( 0.00)     5403000.0 us ( 0.00)    5537000.0 us (-2.48)    5403000.0 us ( 0.00)    5537000.0 us (-2.48)
R     256   1M     8    CLAT  99      3138000.0 us      3138000.0 us ( 0.00)     3239000.0 us (-3.21)    3037000.0 us ( 3.21)    2937000.0 us ( 6.40)   3473000.0 us (-10.67)
RW    256  64K    16    CLAT  99       802000.0 us       802000.0 us ( 0.00)      785000.0 us ( 2.11)     818000.0 us (-1.99)     844000.0 us (-5.23)     810000.0 us (-0.99)
RR    256  64K    16    CLAT  99       659000.0 us      760000.0 us (-15.32)      651000.0 us ( 1.21)     684000.0 us (-3.79)     634000.0 us ( 3.79)     651000.0 us ( 1.21)
RW    256   8K    32    CLAT  99       393000.0 us       405000.0 us (-3.05)      409000.0 us (-4.07)     401000.0 us (-2.03)     397000.0 us (-1.01)    435000.0 us (-10.68)
RW    256   8K    32    CLAT  99       201000.0 us       207000.0 us (-2.98)      203000.0 us (-0.99)     203000.0 us (-0.99)     203000.0 us (-0.99)     205000.0 us (-1.99)
W     512   1M     8    CLAT  99     10402000.0 us     10537000.0 us (-1.29)    10805000.0 us (-3.87)   10537000.0 us (-1.29)   10402000.0 us ( 0.00)   10939000.0 us (-5.16)
R     512   1M     8    CLAT  99      5738000.0 us      5738000.0 us ( 0.00)     5873000.0 us (-2.35)    6275000.0 us (-9.35)    5671000.0 us ( 1.16)    6074000.0 us (-5.85)
RW    512  64K    16    CLAT  99      1502000.0 us      1502000.0 us ( 0.00)     1519000.0 us (-1.13)    1536000.0 us (-2.26)    1485000.0 us ( 1.13)    1536000.0 us (-2.26)
RR    512  64K    16    CLAT  99      1301000.0 us      1351000.0 us (-3.84)     1217000.0 us ( 6.45)    1318000.0 us (-1.30)    1267000.0 us ( 2.61)    1250000.0 us ( 3.92)
RW    512   8K    32    CLAT  99       802000.0 us       802000.0 us ( 0.00)      793000.0 us ( 1.12)     793000.0 us ( 1.12)     844000.0 us (-5.23)    894000.0 us (-11.47)
RW    512   8K    32    CLAT  99       414000.0 us       405000.0 us ( 2.17)      414000.0 us ( 0.00)     405000.0 us ( 2.17)     405000.0 us ( 2.17)     422000.0 us (-1.93)

==================================================================================================================================
                                                     ~~~~~~~~~~~~~~~~NPS2~~~~~~~~~~~~~~~~
==================================================================================================================================

TEST Threads BS  IODEPTH Metric   NPS2-6.4.0-rc1       CPU                 SMT                 CACHE               NUMA              SYSTEM
W       1   1M     8        BW       435 MB/s      446 MB/s( 2.52)     447 MB/s( 2.75)     449 MB/s( 3.21)     445 MB/s( 2.29)     451 MB/s( 3.67)
R       1   1M     8        BW       678 MB/s      766 MB/s(12.97)     763 MB/s(12.53)     770 MB/s(13.56)     763 MB/s(12.53)     668 MB/s(-1.47)      ###
RW      1  64K    16        BW       436 MB/s      434 MB/s(-0.45)     437 MB/s( 0.22)     434 MB/s(-0.45)     435 MB/s(-0.22)     434 MB/s(-0.45)
RR      1  64K    16        BW       467 MB/s      465 MB/s(-0.42)     462 MB/s(-1.07)     462 MB/s(-1.07)     461 MB/s(-1.28)     467 MB/s( 0.00)
RW      1   8K    32        BW       250 MB/s      253 MB/s( 1.20)     231 MB/s(-7.60)     211 MB/s(-15.60)    229 MB/s(-8.40)     213 MB/s(-14.80)     ***
RW      1   8K    32        BW       537 MB/s      535 MB/s(-0.37)     536 MB/s(-0.18)     544 MB/s( 1.30)     535 MB/s(-0.37)     539 MB/s( 0.37)
W       2   1M     8        BW       451 MB/s      449 MB/s(-0.44)     450 MB/s(-0.22)     452 MB/s( 0.22)     450 MB/s(-0.22)     449 MB/s(-0.44)
R       2   1M     8        BW       678 MB/s      814 MB/s(20.05)     782 MB/s(15.33)     805 MB/s(18.73)     819 MB/s(20.79)     807 MB/s(19.02)      ###
RW      2  64K    16        BW       438 MB/s      438 MB/s( 0.00)     434 MB/s(-0.91)     436 MB/s(-0.45)     434 MB/s(-0.91)     433 MB/s(-1.14)
RR      2  64K    16        BW       565 MB/s      566 MB/s( 0.17)     561 MB/s(-0.70)     566 MB/s( 0.17)     564 MB/s(-0.17)     565 MB/s( 0.00)
RW      2   8K    32        BW       350 MB/s      336 MB/s(-4.00)     349 MB/s(-0.28)     348 MB/s(-0.57)     336 MB/s(-4.00)     348 MB/s(-0.57)
RW      2   8K    32        BW       547 MB/s      545 MB/s(-0.36)     544 MB/s(-0.54)     546 MB/s(-0.18)     544 MB/s(-0.54)     545 MB/s(-0.36)
W       4   1M     8        BW       429 MB/s      449 MB/s( 4.66)     450 MB/s( 4.89)     443 MB/s( 3.26)     449 MB/s( 4.66)     445 MB/s( 3.72)
R       4   1M     8        BW       823 MB/s      823 MB/s( 0.00)     828 MB/s( 0.60)     828 MB/s( 0.60)     833 MB/s( 1.21)     833 MB/s( 1.21)
RW      4  64K    16        BW       437 MB/s      433 MB/s(-0.91)     436 MB/s(-0.22)     434 MB/s(-0.68)     433 MB/s(-0.91)     433 MB/s(-0.91)
RR      4  64K    16        BW       565 MB/s      560 MB/s(-0.88)     566 MB/s( 0.17)     567 MB/s( 0.35)     560 MB/s(-0.88)     565 MB/s( 0.00)
RW      4   8K    32        BW       347 MB/s      347 MB/s( 0.00)     343 MB/s(-1.15)     349 MB/s( 0.57)     348 MB/s( 0.28)     337 MB/s(-2.88)
RW      4   8K    32        BW       546 MB/s      545 MB/s(-0.18)     545 MB/s(-0.18)     543 MB/s(-0.54)     546 MB/s( 0.00)     541 MB/s(-0.91)
W       8   1M     8        BW       447 MB/s      449 MB/s( 0.44)     450 MB/s( 0.67)     448 MB/s( 0.22)     449 MB/s( 0.44)     449 MB/s( 0.44)
R       8   1M     8        BW       822 MB/s      825 MB/s( 0.36)     827 MB/s( 0.60)     826 MB/s( 0.48)     834 MB/s( 1.45)     834 MB/s( 1.45)
RW      8  64K    16        BW       433 MB/s      430 MB/s(-0.69)     433 MB/s( 0.00)     437 MB/s( 0.92)     432 MB/s(-0.23)     436 MB/s( 0.69)
RR      8  64K    16        BW       569 MB/s      566 MB/s(-0.52)     564 MB/s(-0.87)     567 MB/s(-0.35)     564 MB/s(-0.87)     566 MB/s(-0.52)
RW      8   8K    32        BW       348 MB/s      344 MB/s(-1.14)     340 MB/s(-2.29)     347 MB/s(-0.28)     347 MB/s(-0.28)     342 MB/s(-1.72)
RW      8   8K    32        BW       544 MB/s      534 MB/s(-1.83)     536 MB/s(-1.47)     536 MB/s(-1.47)     530 MB/s(-2.57)     542 MB/s(-0.36)
W      16   1M     8        BW       451 MB/s      446 MB/s(-1.10)     451 MB/s( 0.00)     449 MB/s(-0.44)     451 MB/s( 0.00)     449 MB/s(-0.44)
R      16   1M     8        BW       833 MB/s      831 MB/s(-0.24)     833 MB/s( 0.00)     833 MB/s( 0.00)     833 MB/s( 0.00)     834 MB/s( 0.12)
RW     16  64K    16        BW       433 MB/s      436 MB/s( 0.69)     430 MB/s(-0.69)     436 MB/s( 0.69)     435 MB/s( 0.46)     434 MB/s( 0.23)
RR     16  64K    16        BW       566 MB/s      566 MB/s( 0.00)     565 MB/s(-0.17)     561 MB/s(-0.88)     562 MB/s(-0.70)     560 MB/s(-1.06)
RW     16   8K    32        BW       347 MB/s      339 MB/s(-2.30)     345 MB/s(-0.57)     331 MB/s(-4.61)     342 MB/s(-1.44)     346 MB/s(-0.28)
RW     16   8K    32        BW       538 MB/s      538 MB/s( 0.00)     532 MB/s(-1.11)     536 MB/s(-0.37)     537 MB/s(-0.18)     539 MB/s( 0.18)
W      32   1M     8        BW       451 MB/s      446 MB/s(-1.10)     451 MB/s( 0.00)     450 MB/s(-0.22)     450 MB/s(-0.22)     449 MB/s(-0.44)
R      32   1M     8        BW       830 MB/s      831 MB/s( 0.12)     835 MB/s( 0.60)     834 MB/s( 0.48)     834 MB/s( 0.48)     837 MB/s( 0.84)
RW     32  64K    16        BW       435 MB/s      432 MB/s(-0.68)     433 MB/s(-0.45)     433 MB/s(-0.45)     436 MB/s( 0.22)     431 MB/s(-0.91)
RR     32  64K    16        BW       571 MB/s      567 MB/s(-0.70)     563 MB/s(-1.40)     568 MB/s(-0.52)     567 MB/s(-0.70)     560 MB/s(-1.92)
RW     32   8K    32        BW       349 MB/s      341 MB/s(-2.29)     345 MB/s(-1.14)     347 MB/s(-0.57)     345 MB/s(-1.14)     347 MB/s(-0.57)
RW     32   8K    32        BW       534 MB/s      521 MB/s(-2.43)     533 MB/s(-0.18)     530 MB/s(-0.74)     522 MB/s(-2.24)     522 MB/s(-2.24)
W      64   1M     8        BW       450 MB/s      441 MB/s(-2.00)     447 MB/s(-0.66)     450 MB/s( 0.00)     448 MB/s(-0.44)     449 MB/s(-0.22)
R      64   1M     8        BW       832 MB/s      832 MB/s( 0.00)     835 MB/s( 0.36)     835 MB/s( 0.36)     835 MB/s( 0.36)     835 MB/s( 0.36)
RW     64  64K    16        BW       432 MB/s      435 MB/s( 0.69)     434 MB/s( 0.46)     435 MB/s( 0.69)     432 MB/s( 0.00)     434 MB/s( 0.46)
RR     64  64K    16        BW       569 MB/s      565 MB/s(-0.70)     558 MB/s(-1.93)     567 MB/s(-0.35)     565 MB/s(-0.70)     562 MB/s(-1.23)
RW     64   8K    32        BW       346 MB/s      343 MB/s(-0.86)     346 MB/s( 0.00)     347 MB/s( 0.28)     347 MB/s( 0.28)     345 MB/s(-0.28)
RW     64   8K    32        BW       527 MB/s      526 MB/s(-0.18)     521 MB/s(-1.13)     526 MB/s(-0.18)     528 MB/s( 0.18)     526 MB/s(-0.18)
W     128   1M     8        BW       449 MB/s      449 MB/s( 0.00)     450 MB/s( 0.22)     448 MB/s(-0.22)     446 MB/s(-0.66)     451 MB/s( 0.44)
R     128   1M     8        BW       832 MB/s      831 MB/s(-0.12)     835 MB/s( 0.36)     833 MB/s( 0.12)     834 MB/s( 0.24)     835 MB/s( 0.36)
RW    128  64K    16        BW       436 MB/s      432 MB/s(-0.91)     434 MB/s(-0.45)     432 MB/s(-0.91)     435 MB/s(-0.22)     432 MB/s(-0.91)
RR    128  64K    16        BW       564 MB/s      565 MB/s( 0.17)     564 MB/s( 0.00)     559 MB/s(-0.88)     562 MB/s(-0.35)     561 MB/s(-0.53)
RW    128   8K    32        BW       346 MB/s      345 MB/s(-0.28)     328 MB/s(-5.20)     342 MB/s(-1.15)     346 MB/s( 0.00)     347 MB/s( 0.28)
RW    128   8K    32        BW       519 MB/s      527 MB/s( 1.54)     525 MB/s( 1.15)     530 MB/s( 2.11)     518 MB/s(-0.19)     526 MB/s( 1.34)
W     256   1M     8        BW       450 MB/s      449 MB/s(-0.22)     451 MB/s( 0.22)     450 MB/s( 0.00)     447 MB/s(-0.66)     448 MB/s(-0.44)
R     256   1M     8        BW       832 MB/s      830 MB/s(-0.24)     834 MB/s( 0.24)     834 MB/s( 0.24)     834 MB/s( 0.24)     833 MB/s( 0.12)
RW    256  64K    16        BW       436 MB/s      431 MB/s(-1.14)     434 MB/s(-0.45)     432 MB/s(-0.91)     431 MB/s(-1.14)     433 MB/s(-0.68)
RR    256  64K    16        BW       565 MB/s      573 MB/s( 1.41)     569 MB/s( 0.70)     559 MB/s(-1.06)     560 MB/s(-0.88)     558 MB/s(-1.23)
RW    256   8K    32        BW       332 MB/s      339 MB/s( 2.10)     337 MB/s( 1.50)     334 MB/s( 0.60)     328 MB/s(-1.20)     340 MB/s( 2.40)
RW    256   8K    32        BW       521 MB/s      524 MB/s( 0.57)     524 MB/s( 0.57)     528 MB/s( 1.34)     528 MB/s( 1.34)     529 MB/s( 1.53)
W     512   1M     8        BW       450 MB/s      448 MB/s(-0.44)     446 MB/s(-0.88)     449 MB/s(-0.22)     448 MB/s(-0.44)     450 MB/s( 0.00)
R     512   1M     8        BW       832 MB/s      830 MB/s(-0.24)     834 MB/s( 0.24)     832 MB/s( 0.00)     833 MB/s( 0.12)     834 MB/s( 0.24)
RW    512  64K    16        BW       430 MB/s      433 MB/s( 0.69)     435 MB/s( 1.16)     431 MB/s( 0.23)     430 MB/s( 0.00)     432 MB/s( 0.46)
RR    512  64K    16        BW       564 MB/s      559 MB/s(-0.88)     563 MB/s(-0.17)     568 MB/s( 0.70)     564 MB/s( 0.00)     563 MB/s(-0.17)
RW    512   8K    32        BW       338 MB/s      332 MB/s(-1.77)     320 MB/s(-5.32)     329 MB/s(-2.66)     328 MB/s(-2.95)     332 MB/s(-1.77)
RW    512   8K    32        BW       530 MB/s      531 MB/s( 0.18)     529 MB/s(-0.18)     531 MB/s( 0.18)     526 MB/s(-0.75)     528 MB/s(-0.37)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS2-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8     SLAT AVG           69.1 us          55.6 us (19.51)        78.8 us (-14.05)        78.2 us (-13.27)      424.9 us (-515.12)      366.1 us (-430.01)
R       1   1M     8     SLAT AVG           50.8 us          49.8 us ( 1.96)         54.6 us (-7.46)         38.8 us (23.64)      300.3 us (-491.10)      264.5 us (-420.72)
RW      1  64K    16     SLAT AVG           15.5 us          15.7 us (-0.90)        18.1 us (-16.62)        18.5 us (-19.32)        20.8 us (-34.21)        23.6 us (-51.99)
RR      1  64K    16     SLAT AVG           11.0 us          10.8 us ( 1.36)        12.8 us (-17.04)         11.0 us ( 0.00)        12.4 us (-13.30)        14.7 us (-34.18)
RW      1   8K    32     SLAT AVG           30.0 us          28.5 us ( 4.96)         32.7 us (-8.88)        36.4 us (-21.23)        33.1 us (-10.31)        36.1 us (-20.23)
RW      1   8K    32     SLAT AVG           10.8 us          10.9 us (-0.83)         10.9 us (-0.27)          9.0 us (17.00)         10.9 us (-1.20)          9.8 us ( 9.33)
W       2   1M     8     SLAT AVG           76.9 us         96.2 us (-25.12)      176.0 us (-128.84)         73.3 us ( 4.70)      606.3 us (-688.56)      334.7 us (-335.33)
R       2   1M     8     SLAT AVG           54.8 us          44.9 us (18.04)        90.1 us (-64.31)         57.5 us (-4.97)      337.8 us (-516.10)         59.5 us (-8.62)
RW      2  64K    16     SLAT AVG           17.9 us          16.5 us ( 7.94)         16.2 us ( 9.56)         16.0 us (10.51)        29.0 us (-62.24)        21.5 us (-20.19)
RR      2  64K    16     SLAT AVG           11.1 us          11.6 us (-4.32)         11.4 us (-2.25)         11.6 us (-4.50)        20.4 us (-83.16)        17.0 us (-52.83)
RW      2   8K    32     SLAT AVG           15.1 us         20.1 us (-33.26)         14.6 us ( 2.91)         16.1 us (-6.89)        20.9 us (-38.23)        19.3 us (-27.96)
RW      2   8K    32     SLAT AVG            7.7 us           7.6 us ( 1.42)          8.2 us (-6.20)          8.0 us (-3.61)          7.6 us ( 1.80)          7.7 us ( 0.64)
W       4   1M     8     SLAT AVG          648.3 us          96.6 us (85.10)         91.6 us (85.86)         77.3 us (88.06)         94.6 us (85.41)         77.2 us (88.08)
R       4   1M     8     SLAT AVG           29.0 us         34.5 us (-18.99)        38.9 us (-34.39)        33.8 us (-16.71)        40.7 us (-40.46)        42.7 us (-47.34)
RW      4  64K    16     SLAT AVG           18.1 us          18.5 us (-1.93)         19.0 us (-4.96)        20.4 us (-12.30)        21.7 us (-19.53)         17.4 us ( 4.24)
RR      4  64K    16     SLAT AVG            8.1 us           8.6 us (-7.45)        10.4 us (-29.81)          7.4 us ( 7.70)        10.6 us (-31.05)          7.7 us ( 3.97)
RW      4   8K    32     SLAT AVG           91.4 us          91.0 us ( 0.35)         91.9 us (-0.62)         90.8 us ( 0.55)         91.1 us ( 0.33)         94.1 us (-2.98)
RW      4   8K    32     SLAT AVG           57.2 us          57.5 us (-0.41)         57.5 us (-0.40)         57.6 us (-0.62)         57.3 us (-0.12)         58.0 us (-1.25)
W       8   1M     8     SLAT AVG        12322.7 us       12821.8 us (-4.05)        398.1 us (96.76)       9293.3 us (24.58)      11211.7 us ( 9.01)        821.0 us (93.33)
R       8   1M     8     SLAT AVG         6641.7 us        5776.2 us (13.03)       5578.0 us (16.01)       5779.9 us (12.97)         39.9 us (99.39)         31.8 us (99.52)
RW      8  64K    16     SLAT AVG         1032.7 us        1045.4 us (-1.23)       1036.4 us (-0.35)       1027.5 us ( 0.50)       1037.6 us (-0.47)       1031.1 us ( 0.15)
RR      8  64K    16     SLAT AVG          782.9 us         786.7 us (-0.47)        784.8 us (-0.23)        780.7 us ( 0.29)        755.5 us ( 3.50)        786.5 us (-0.45)
RW      8   8K    32     SLAT AVG          186.6 us         188.7 us (-1.11)        190.6 us (-2.16)        187.3 us (-0.38)        186.9 us (-0.15)        189.9 us (-1.77)
RW      8   8K    32     SLAT AVG          119.1 us         121.0 us (-1.61)        120.7 us (-1.36)        120.7 us (-1.32)        122.0 us (-2.45)        119.6 us (-0.38)
W      16   1M     8     SLAT AVG        32861.6 us       32716.3 us ( 0.44)      31509.8 us ( 4.11)      30533.0 us ( 7.08)      32283.6 us ( 1.75)      32754.9 us ( 0.32)
R      16   1M     8     SLAT AVG        16347.8 us       17288.0 us (-5.75)      15926.0 us ( 2.58)      16020.2 us ( 2.00)     18334.2 us (-12.15)      15997.7 us ( 2.14)
RW     16  64K    16     SLAT AVG         2417.2 us        2400.9 us ( 0.67)       2433.3 us (-0.66)       2399.3 us ( 0.74)       2405.2 us ( 0.49)       2409.3 us ( 0.32)
RR     16  64K    16     SLAT AVG         1845.4 us        1847.9 us (-0.13)       1848.6 us (-0.17)       1862.7 us (-0.93)       1857.8 us (-0.67)       1866.0 us (-1.11)
RW     16   8K    32     SLAT AVG          375.6 us         385.2 us (-2.55)        377.8 us (-0.55)        393.8 us (-4.82)        381.1 us (-1.45)        377.5 us (-0.48)
RW     16   8K    32     SLAT AVG          241.8 us         242.2 us (-0.15)        244.7 us (-1.18)        242.8 us (-0.41)        242.6 us (-0.33)        241.9 us (-0.02)
W      32   1M     8     SLAT AVG        73911.1 us       74878.8 us (-1.30)      74155.4 us (-0.33)      74296.7 us (-0.52)      74348.2 us (-0.59)      74324.0 us (-0.55)
R      32   1M     8     SLAT AVG        40310.4 us       40317.9 us (-0.01)      40044.0 us ( 0.66)      40068.1 us ( 0.60)      40102.7 us ( 0.51)      40012.5 us ( 0.73)
RW     32  64K    16     SLAT AVG         4817.5 us        4845.3 us (-0.57)       4837.6 us (-0.41)       4844.4 us (-0.55)       4801.6 us ( 0.33)       4866.2 us (-1.01)
RR     32  64K    16     SLAT AVG         3669.8 us        3692.9 us (-0.62)       3722.4 us (-1.43)       3688.1 us (-0.49)       3692.9 us (-0.63)       3739.9 us (-1.91)
RW     32   8K    32     SLAT AVG          749.1 us         766.7 us (-2.34)        756.2 us (-0.95)        754.2 us (-0.67)        757.9 us (-1.17)        752.8 us (-0.49)
RW     32   8K    32     SLAT AVG          489.0 us         501.6 us (-2.56)        490.2 us (-0.22)        492.7 us (-0.74)        500.0 us (-2.24)        500.3 us (-2.30)
W      64   1M     8     SLAT AVG       148503.8 us      151397.1 us (-1.94)     149573.1 us (-0.72)     148545.5 us (-0.02)     149269.4 us (-0.51)     148909.0 us (-0.27)
R      64   1M     8     SLAT AVG        80548.3 us       80499.8 us ( 0.06)      80232.7 us ( 0.39)      80205.2 us ( 0.42)      80258.1 us ( 0.36)      80230.6 us ( 0.39)
RW     64  64K    16     SLAT AVG         9695.2 us        9633.5 us ( 0.63)       9655.9 us ( 0.40)       9633.2 us ( 0.63)       9706.1 us (-0.11)       9655.1 us ( 0.41)
RR     64  64K    16     SLAT AVG         7369.6 us        7416.4 us (-0.63)       7515.1 us (-1.97)       7390.9 us (-0.28)       7425.1 us (-0.75)       7459.2 us (-1.21)
RW     64   8K    32     SLAT AVG         1513.6 us        1527.1 us (-0.89)       1513.4 us ( 0.00)       1508.3 us ( 0.35)       1509.7 us ( 0.25)       1518.2 us (-0.30)
RW     64   8K    32     SLAT AVG          993.1 us         994.2 us (-0.11)       1004.7 us (-1.16)        994.7 us (-0.15)        990.9 us ( 0.22)        995.1 us (-0.19)
W     128   1M     8     SLAT AVG       297703.8 us      297483.3 us ( 0.07)     296868.0 us ( 0.28)     298124.7 us (-0.14)     299233.1 us (-0.51)     296398.2 us ( 0.43)
R     128   1M     8     SLAT AVG       161014.5 us      161170.9 us (-0.09)     160367.7 us ( 0.40)     160632.0 us ( 0.23)     160586.0 us ( 0.26)     160336.6 us ( 0.42)
RW    128  64K    16     SLAT AVG        19211.9 us       19422.0 us (-1.09)      19306.8 us (-0.49)      19395.6 us (-0.95)      19289.8 us (-0.40)      19392.3 us (-0.93)
RR    128  64K    16     SLAT AVG        14862.2 us       14833.2 us ( 0.19)      14860.5 us ( 0.01)      15005.8 us (-0.96)      14911.1 us (-0.32)      14940.7 us (-0.52)
RW    128   8K    32     SLAT AVG         3030.6 us        3030.9 us (-0.01)       3192.1 us (-5.33)       3058.8 us (-0.93)       3029.4 us ( 0.04)       3022.2 us ( 0.27)
RW    128   8K    32     SLAT AVG         2018.3 us        1987.8 us ( 1.51)       1996.1 us ( 1.10)       1976.4 us ( 2.07)       2020.3 us (-0.09)       1992.0 us ( 1.30)
W     256   1M     8     SLAT AVG       592084.3 us      594206.8 us (-0.35)     590998.4 us ( 0.18)     592508.6 us (-0.07)     595737.1 us (-0.61)     594953.0 us (-0.48)
R     256   1M     8     SLAT AVG       321411.8 us      322217.7 us (-0.25)     320759.6 us ( 0.20)     320717.4 us ( 0.21)     320562.7 us ( 0.26)     320770.3 us ( 0.19)
RW    256  64K    16     SLAT AVG        38441.5 us       38932.8 us (-1.27)      38603.2 us (-0.42)      38838.2 us (-1.03)      38852.9 us (-1.07)      38748.7 us (-0.79)
RR    256  64K    16     SLAT AVG        29700.6 us       29264.1 us ( 1.46)      29467.9 us ( 0.78)      30018.6 us (-1.07)      29943.0 us (-0.81)      30025.3 us (-1.09)
RW    256   8K    32     SLAT AVG         6306.1 us        6183.0 us ( 1.95)       6215.5 us ( 1.43)       6270.0 us ( 0.57)       6378.8 us (-1.15)       6153.7 us ( 2.41)
RW    256   8K    32     SLAT AVG         4021.9 us        3997.3 us ( 0.61)       4000.6 us ( 0.53)       3971.6 us ( 1.25)       3968.0 us ( 1.34)       3964.8 us ( 1.41)
W     512   1M     8     SLAT AVG      1178070.9 us     1184901.3 us (-0.57)    1186833.2 us (-0.74)    1180252.0 us (-0.18)    1182115.7 us (-0.34)    1178710.0 us (-0.05)
R     512   1M     8     SLAT AVG       641182.0 us      642169.6 us (-0.15)     639244.4 us ( 0.30)     640601.4 us ( 0.09)     640300.0 us ( 0.13)     639403.3 us ( 0.27)
RW    512  64K    16     SLAT AVG        77976.6 us       77342.1 us ( 0.81)      77068.0 us ( 1.16)      77776.2 us ( 0.25)      77920.1 us ( 0.07)      77561.6 us ( 0.53)
RR    512  64K    16     SLAT AVG        59461.4 us       60000.9 us (-0.90)      59580.6 us (-0.20)      59058.1 us ( 0.67)      59463.6 us ( 0.00)      59570.8 us (-0.18)
RW    512   8K    32     SLAT AVG        12415.5 us       12622.5 us (-1.66)      13094.8 us (-5.47)      12724.1 us (-2.48)      12763.2 us (-2.80)      12630.6 us (-1.73)
RW    512   8K    32     SLAT AVG         7909.1 us        7887.7 us ( 0.27)       7918.4 us (-0.11)       7895.4 us ( 0.17)       7964.5 us (-0.70)       7934.6 us (-0.32)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS2-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    LAT AVG          19297.0 us       18791.7 us ( 2.61)      18753.9 us ( 2.81)      18699.8 us ( 3.09)      18845.7 us ( 2.33)      18609.5 us ( 3.56)
R       1   1M     8    LAT AVG          12365.8 us       10945.3 us (11.48)      10996.6 us (11.07)      10897.7 us (11.87)      10983.9 us (11.17)      12542.8 us (-1.43)	###
RW      1  64K    16    LAT AVG           2403.7 us        2417.9 us (-0.59)       2397.6 us ( 0.25)       2412.8 us (-0.37)       2407.2 us (-0.14)       2416.9 us (-0.55)
RR      1  64K    16    LAT AVG           2243.4 us        2252.7 us (-0.41)       2269.8 us (-1.17)       2269.5 us (-1.16)       2274.8 us (-1.40)       2246.7 us (-0.14)
RW      1   8K    32    LAT AVG           1048.6 us        1036.3 us ( 1.17)       1132.8 us (-8.03)      1240.9 us (-18.34)       1144.5 us (-9.14)      1230.1 us (-17.30)	***
RW      1   8K    32    LAT AVG            487.5 us         489.4 us (-0.38)        489.0 us (-0.30)        481.4 us ( 1.24)        489.7 us (-0.46)        485.9 us ( 0.31)
W       2   1M     8    LAT AVG          37195.7 us       37376.8 us (-0.48)      37257.8 us (-0.16)      37149.2 us ( 0.12)      37268.1 us (-0.19)      37394.1 us (-0.53)
R       2   1M     8    LAT AVG          24724.5 us       20605.9 us (16.65)      20925.6 us (15.36)      20822.3 us (15.78)      20452.6 us (17.27)      20788.8 us (15.91)	###
RW      2  64K    16    LAT AVG           4785.8 us        4787.2 us (-0.02)       4831.0 us (-0.94)       4809.7 us (-0.49)       4835.9 us (-1.04)       4842.3 us (-1.17)
RR      2  64K    16    LAT AVG           3709.1 us        3705.3 us ( 0.10)       3734.4 us (-0.68)       3705.5 us ( 0.09)       3714.5 us (-0.14)       3712.1 us (-0.08)
RW      2   8K    32    LAT AVG           1498.2 us        1558.8 us (-4.04)       1503.5 us (-0.35)       1505.8 us (-0.50)       1559.9 us (-4.12)       1507.3 us (-0.61)
RW      2   8K    32    LAT AVG            958.9 us         961.4 us (-0.26)        964.0 us (-0.52)        959.3 us (-0.03)        963.1 us (-0.43)        962.4 us (-0.36)
W       4   1M     8    LAT AVG          78130.0 us       74680.0 us ( 4.41)      74480.0 us ( 4.67)      75710.0 us ( 3.09)      74690.0 us ( 4.40)      75400.0 us ( 3.49)
R       4   1M     8    LAT AVG          40768.6 us       40740.5 us ( 0.06)      40510.0 us ( 0.63)      40505.2 us ( 0.64)      40259.2 us ( 1.24)      40254.5 us ( 1.26)
RW      4  64K    16    LAT AVG           9605.4 us        9691.5 us (-0.89)       9620.0 us (-0.15)       9656.0 us (-0.52)       9678.1 us (-0.75)       9682.3 us (-0.80)
RR      4  64K    16    LAT AVG           7420.9 us        7487.2 us (-0.89)       7414.9 us ( 0.08)       7398.6 us ( 0.30)       7483.0 us (-0.83)       7424.1 us (-0.04)
RW      4   8K    32    LAT AVG           3023.4 us        3020.3 us ( 0.10)       3056.4 us (-1.09)       3002.8 us ( 0.68)       3012.6 us ( 0.36)       3112.2 us (-2.93)
RW      4   8K    32    LAT AVG           1919.6 us        1924.9 us (-0.28)       1925.0 us (-0.28)       1929.6 us (-0.52)       1921.2 us (-0.08)       1938.1 us (-0.96)
W       8   1M     8    LAT AVG         149910.0 us      149250.0 us ( 0.44)     148870.0 us ( 0.69)     149530.0 us ( 0.25)     149350.0 us ( 0.37)     149450.0 us ( 0.30)
R       8   1M     8    LAT AVG          81590.0 us       81300.0 us ( 0.35)      81080.0 us ( 0.62)      81180.0 us ( 0.50)      80480.0 us ( 1.36)      80460.0 us ( 1.38)
RW      8  64K    16    LAT AVG          19367.0 us       19502.8 us (-0.70)      19363.3 us ( 0.01)      19211.2 us ( 0.80)      19430.5 us (-0.32)      19240.7 us ( 0.65)
RR      8  64K    16    LAT AVG          14734.9 us       14824.1 us (-0.60)      14859.8 us (-0.84)      14788.1 us (-0.36)      14861.6 us (-0.85)      14823.3 us (-0.59)
RW      8   8K    32    LAT AVG           6021.7 us        6086.8 us (-1.08)       6158.6 us (-2.27)       6049.4 us (-0.45)       6043.2 us (-0.35)       6138.1 us (-1.93)
RW      8   8K    32    LAT AVG           3854.7 us        3927.1 us (-1.87)       3910.6 us (-1.45)       3909.6 us (-1.42)       3953.4 us (-2.55)       3869.2 us (-0.37)
W      16   1M     8    LAT AVG         297360.0 us      300350.0 us (-1.00)     297290.0 us ( 0.02)     298660.0 us (-0.43)     297220.0 us ( 0.04)     298610.0 us (-0.42)
R      16   1M     8    LAT AVG         160930.0 us      161420.0 us (-0.30)     161070.0 us (-0.08)     161030.0 us (-0.06)     161050.0 us (-0.07)     160890.0 us ( 0.02)
RW     16  64K    16    LAT AVG          38766.1 us       38505.2 us ( 0.67)      39020.0 us (-0.65)      38490.0 us ( 0.71)      38600.0 us ( 0.42)      38630.0 us ( 0.35)
RR     16  64K    16    LAT AVG          29626.2 us       29661.3 us (-0.11)      29674.6 us (-0.16)      29892.6 us (-0.89)      29823.5 us (-0.66)      29943.9 us (-1.07)
RW     16   8K    32    LAT AVG          12076.9 us       12381.3 us (-2.52)      12146.7 us (-0.57)      12670.9 us (-4.91)      12262.3 us (-1.53)      12135.0 us (-0.48)
RW     16   8K    32    LAT AVG           7789.0 us        7799.5 us (-0.13)       7884.9 us (-1.23)       7818.6 us (-0.37)       7814.3 us (-0.32)       7787.8 us ( 0.01)
W      32   1M     8    LAT AVG         592290.0 us      599280.0 us (-1.18)     593750.0 us (-0.24)     594670.0 us (-0.40)     594960.0 us (-0.45)     595560.0 us (-0.55)
R      32   1M     8    LAT AVG         322550.0 us      322490.0 us ( 0.01)     321040.0 us ( 0.46)     321260.0 us ( 0.39)     321170.0 us ( 0.42)     320170.0 us ( 0.73)
RW     32  64K    16    LAT AVG          77090.0 us       77550.0 us (-0.59)      77420.0 us (-0.42)      77540.0 us (-0.58)      76840.0 us ( 0.32)      77880.0 us (-1.02)
RR     32  64K    16    LAT AVG          58730.0 us       59110.0 us (-0.64)      59570.0 us (-1.43)      59030.0 us (-0.51)      59100.0 us (-0.63)      59860.0 us (-1.92)
RW     32   8K    32    LAT AVG          24033.6 us       24611.1 us (-2.40)      24278.6 us (-1.01)      24196.4 us (-0.67)      24323.3 us (-1.20)      24150.8 us (-0.48)
RW     32   8K    32    LAT AVG          15705.9 us       16108.6 us (-2.56)      15740.4 us (-0.21)      15823.3 us (-0.74)      16059.2 us (-2.24)      16067.6 us (-2.30)
W      64   1M     8    LAT AVG        1181790.0 us     1205320.0 us (-1.99)    1191750.0 us (-0.84)    1182410.0 us (-0.05)    1187650.0 us (-0.49)    1185000.0 us (-0.27)
R      64   1M     8    LAT AVG         642870.0 us      642440.0 us ( 0.06)     640340.0 us ( 0.39)     640070.0 us ( 0.43)     640470.0 us ( 0.37)     640230.0 us ( 0.41)
RW     64  64K    16    LAT AVG         155034.9 us      154060.0 us ( 0.62)     154420.0 us ( 0.39)     154036.2 us ( 0.64)     155193.0 us (-0.10)     154390.0 us ( 0.41)
RR     64  64K    16    LAT AVG         117870.0 us      118620.0 us (-0.63)     120190.0 us (-1.96)     118210.0 us (-0.28)     118760.0 us (-0.75)     119300.0 us (-1.21)
RW     64   8K    32    LAT AVG          48484.2 us       48924.7 us (-0.90)      48494.8 us (-0.02)      48313.4 us ( 0.35)      48365.4 us ( 0.24)      48633.1 us (-0.30)
RW     64   8K    32    LAT AVG          31832.3 us       31867.7 us (-0.11)      32206.7 us (-1.17)      31882.3 us (-0.15)      31764.6 us ( 0.21)      31893.0 us (-0.19)
W     128   1M     8    LAT AVG        2352040.0 us     2348600.0 us ( 0.14)    2345670.0 us ( 0.27)    2356160.0 us (-0.17)    2364560.0 us (-0.53)    2339640.0 us ( 0.52)
R     128   1M     8    LAT AVG        1279470.0 us     1280950.0 us (-0.11)    1274610.0 us ( 0.37)    1276170.0 us ( 0.25)    1276130.0 us ( 0.26)    1274270.0 us ( 0.40)
RW    128  64K    16    LAT AVG         306840.0 us      310198.0 us (-1.09)     308347.0 us (-0.49)     309761.9 us (-0.95)     308085.9 us (-0.40)     309698.6 us (-0.93)
RR    128  64K    16    LAT AVG         237460.0 us      237000.0 us ( 0.19)     237440.0 us ( 0.00)     239750.0 us (-0.96)     238230.0 us (-0.32)     238720.0 us (-0.53)
RW    128   8K    32    LAT AVG          96980.1 us       97003.4 us (-0.02)     102153.3 us (-5.33)      97877.5 us (-0.92)      96946.7 us ( 0.03)      96710.6 us ( 0.27)
RW    128   8K    32    LAT AVG          64616.8 us       63642.1 us ( 1.50)      63909.6 us ( 1.09)      63277.5 us ( 2.07)      64682.4 us (-0.10)      63776.5 us ( 1.30)
W     256   1M     8    LAT AVG        4606440.0 us     4622600.0 us (-0.35)    4600690.0 us ( 0.12)    4611210.0 us (-0.10)    4634460.0 us (-0.60)    4622390.0 us (-0.34)
R     256   1M     8    LAT AVG        2532970.0 us     2538450.0 us (-0.21)    2528080.0 us ( 0.19)    2527250.0 us ( 0.22)    2525630.0 us ( 0.28)    2528030.0 us ( 0.19)
RW    256  64K    16    LAT AVG         612510.0 us      620369.9 us (-1.28)     615088.4 us (-0.42)     618839.9 us (-1.03)     619143.8 us (-1.08)     617441.3 us (-0.80)
RR    256  64K    16    LAT AVG         473690.0 us      466760.0 us ( 1.46)     469950.0 us ( 0.78)     478720.0 us (-1.06)     477500.0 us (-0.80)     478822.6 us (-1.08)
RW    256   8K    32    LAT AVG         201568.8 us      197627.5 us ( 1.95)     198687.3 us ( 1.42)     200441.8 us ( 0.55)     203869.3 us (-1.14)     196735.5 us ( 2.39)
RW    256   8K    32    LAT AVG         128646.6 us      127860.1 us ( 0.61)     127963.8 us ( 0.53)     127036.7 us ( 1.25)     126916.1 us ( 1.34)     126818.1 us ( 1.42)
W     512   1M     8    LAT AVG        8881860.0 us     8927670.0 us (-0.51)    8946760.0 us (-0.73)    8904220.0 us (-0.25)    8919030.0 us (-0.41)    8891800.0 us (-0.11)
R     512   1M     8    LAT AVG        4966570.0 us     4973960.0 us (-0.14)    4952160.0 us ( 0.29)    4961550.0 us ( 0.10)    4961600.0 us ( 0.10)    4952570.0 us ( 0.28)
RW    512  64K    16    LAT AVG        1236690.4 us     1226780.1 us ( 0.80)    1222633.1 us ( 1.13)    1233756.8 us ( 0.23)    1235800.0 us ( 0.07)    1230154.7 us ( 0.52)
RR    512  64K    16    LAT AVG         944850.0 us      953374.4 us (-0.90)     946790.0 us (-0.20)     938402.2 us ( 0.68)     944849.6 us ( 0.00)     946559.5 us (-0.18)
RW    512   8K    32    LAT AVG         396049.9 us      402844.4 us (-1.71)     417229.0 us (-5.34)     405910.2 us (-2.48)     407128.3 us (-2.79)     403012.6 us (-1.75)
RW    512   8K    32    LAT AVG         252679.3 us      251994.9 us ( 0.27)     252958.8 us (-0.11)     252244.2 us ( 0.17)     254444.5 us (-0.69)     253498.1 us (-0.32)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS2-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    CLAT AVG         19227.7 us       18736.0 us ( 2.55)      18674.9 us ( 2.87)      18621.4 us ( 3.15)      18420.7 us ( 4.19)      18243.2 us ( 5.12)
R       1   1M     8    CLAT AVG         12315.0 us       10895.4 us (11.52)      10941.9 us (11.14)      10858.8 us (11.82)      10683.5 us (13.24)      12278.2 us ( 0.29)	###
RW      1  64K    16    CLAT AVG          2388.1 us        2402.2 us (-0.59)       2379.4 us ( 0.36)       2394.2 us (-0.25)       2386.2 us ( 0.07)       2393.2 us (-0.21)
RR      1  64K    16    CLAT AVG          2232.4 us        2241.8 us (-0.42)       2256.9 us (-1.09)       2258.5 us (-1.17)       2262.3 us (-1.34)       2231.9 us ( 0.02)
RW      1   8K    32    CLAT AVG          1018.5 us        1007.6 us ( 1.06)       1099.9 us (-8.00)      1204.4 us (-18.25)       1111.2 us (-9.10)      1193.8 us (-17.21)	***
RW      1   8K    32    CLAT AVG           476.6 us         478.4 us (-0.37)        478.1 us (-0.31)        472.3 us ( 0.89)        478.7 us (-0.44)        476.0 us ( 0.11)
W       2   1M     8    CLAT AVG         37118.6 us       37280.3 us (-0.43)      37081.5 us ( 0.09)      37075.6 us ( 0.11)      36661.6 us ( 1.23)      37059.1 us ( 0.16)
R       2   1M     8    CLAT AVG         24669.6 us       20560.8 us (16.65)      20835.4 us (15.54)      20764.6 us (15.82)      20114.7 us (18.46)      20729.2 us (15.97)	###
RW      2  64K    16    CLAT AVG          4767.9 us        4770.6 us (-0.05)       4814.7 us (-0.98)       4793.6 us (-0.54)       4806.8 us (-0.81)       4820.7 us (-1.10)
RR      2  64K    16    CLAT AVG          3697.9 us        3693.6 us ( 0.11)       3723.0 us (-0.67)       3693.8 us ( 0.11)       3694.1 us ( 0.10)       3695.1 us ( 0.07)
RW      2   8K    32    CLAT AVG          1483.0 us        1538.6 us (-3.74)       1488.8 us (-0.38)       1489.6 us (-0.43)       1539.0 us (-3.77)       1487.9 us (-0.32)
RW      2   8K    32    CLAT AVG           951.1 us         953.7 us (-0.27)        955.7 us (-0.48)        951.2 us ( 0.00)        955.4 us (-0.45)        954.7 us (-0.37)
W       4   1M     8    CLAT AVG         77480.0 us       74580.0 us ( 3.74)      74380.0 us ( 4.00)      75630.0 us ( 2.38)      74600.0 us ( 3.71)      75330.0 us ( 2.77)
R       4   1M     8    CLAT AVG         40739.5 us       40705.9 us ( 0.08)      40470.0 us ( 0.66)      40471.2 us ( 0.65)      40218.4 us ( 1.27)      40211.7 us ( 1.29)
RW      4  64K    16    CLAT AVG          9587.1 us        9673.0 us (-0.89)       9600.8 us (-0.14)       9635.6 us (-0.50)       9656.3 us (-0.72)       9664.9 us (-0.81)
RR      4  64K    16    CLAT AVG          7412.8 us        7478.5 us (-0.88)       7404.4 us ( 0.11)       7391.1 us ( 0.29)       7472.3 us (-0.80)       7416.3 us (-0.04)
RW      4   8K    32    CLAT AVG          2932.0 us        2929.1 us ( 0.09)       2964.4 us (-1.10)       2911.8 us ( 0.68)       2921.4 us ( 0.36)       3018.1 us (-2.93)
RW      4   8K    32    CLAT AVG          1862.3 us        1867.4 us (-0.27)       1867.5 us (-0.27)       1871.9 us (-0.51)       1863.8 us (-0.08)       1880.0 us (-0.95)
W       8   1M     8    CLAT AVG        137590.0 us      136420.0 us ( 0.85)     148470.0 us (-7.90)     140240.0 us (-1.92)     138140.0 us (-0.39)     148630.0 us (-8.02)
R       8   1M     8    CLAT AVG         74950.0 us       75530.0 us (-0.77)      75500.0 us (-0.73)      75400.0 us (-0.60)      80440.0 us (-7.32)      80430.0 us (-7.31)
RW      8  64K    16    CLAT AVG         18334.2 us       18457.3 us (-0.67)      18326.8 us ( 0.04)      18183.5 us ( 0.82)      18392.8 us (-0.31)      18209.5 us ( 0.68)
RR      8  64K    16    CLAT AVG         13951.9 us       14037.3 us (-0.61)      14074.9 us (-0.88)      14007.3 us (-0.39)      14106.0 us (-1.10)      14036.7 us (-0.60)
RW      8   8K    32    CLAT AVG          5835.0 us        5898.0 us (-1.07)       5967.8 us (-2.27)       5861.9 us (-0.46)       5856.2 us (-0.36)       5948.0 us (-1.93)
RW      8   8K    32    CLAT AVG          3735.5 us        3806.0 us (-1.88)       3789.8 us (-1.45)       3788.9 us (-1.42)       3831.2 us (-2.56)       3749.6 us (-0.37)
W      16   1M     8    CLAT AVG        264490.0 us      267630.0 us (-1.18)     265780.0 us (-0.48)     268120.0 us (-1.37)     264940.0 us (-0.17)     265860.0 us (-0.51)
R      16   1M     8    CLAT AVG        144590.0 us      144140.0 us ( 0.31)     145140.0 us (-0.38)     145010.0 us (-0.29)     142710.0 us ( 1.30)     144890.0 us (-0.20)
RW     16  64K    16    CLAT AVG         36348.8 us       36104.2 us ( 0.67)      36591.5 us (-0.66)      36091.1 us ( 0.70)      36190.0 us ( 0.43)      36225.1 us ( 0.34)
RR     16  64K    16    CLAT AVG         27780.7 us       27813.2 us (-0.11)      27825.8 us (-0.16)      28029.8 us (-0.89)      27965.6 us (-0.66)      28077.8 us (-1.06)
RW     16   8K    32    CLAT AVG         11701.2 us       11996.0 us (-2.51)      11768.8 us (-0.57)      12277.0 us (-4.92)      11881.0 us (-1.53)      11757.5 us (-0.48)
RW     16   8K    32    CLAT AVG          7547.1 us        7557.2 us (-0.13)       7640.1 us (-1.23)       7575.6 us (-0.37)       7571.5 us (-0.32)       7545.8 us ( 0.01)
W      32   1M     8    CLAT AVG        518380.0 us      524400.0 us (-1.16)     519600.0 us (-0.23)     520380.0 us (-0.38)     520620.0 us (-0.43)     521230.0 us (-0.54)
R      32   1M     8    CLAT AVG        282240.0 us      282180.0 us ( 0.02)     280990.0 us ( 0.44)     281190.0 us ( 0.37)     281070.0 us ( 0.41)     280160.0 us ( 0.73)
RW     32  64K    16    CLAT AVG         72280.0 us       72710.0 us (-0.59)      72580.0 us (-0.41)      72690.0 us (-0.56)      72040.0 us ( 0.33)      73020.0 us (-1.02)
RR     32  64K    16    CLAT AVG         55060.0 us       55410.0 us (-0.63)      55850.0 us (-1.43)      55340.0 us (-0.50)      55410.0 us (-0.63)      56120.0 us (-1.92)
RW     32   8K    32    CLAT AVG         23284.4 us       23844.2 us (-2.40)      23522.2 us (-1.02)      23442.1 us (-0.67)      23565.3 us (-1.20)      23397.8 us (-0.48)
RW     32   8K    32    CLAT AVG         15216.7 us       15606.9 us (-2.56)      15250.1 us (-0.21)      15330.5 us (-0.74)      15559.1 us (-2.24)      15567.2 us (-2.30)
W      64   1M     8    CLAT AVG       1033280.0 us     1053920.0 us (-1.99)    1042180.0 us (-0.86)    1033870.0 us (-0.05)    1038380.0 us (-0.49)    1036090.0 us (-0.27)
R      64   1M     8    CLAT AVG        562320.0 us      561940.0 us ( 0.06)     560110.0 us ( 0.39)     559860.0 us ( 0.43)     560210.0 us ( 0.37)     560000.0 us ( 0.41)
RW     64  64K    16    CLAT AVG        145339.5 us      144420.0 us ( 0.63)     144760.0 us ( 0.39)     144402.8 us ( 0.64)     145486.7 us (-0.10)     144730.0 us ( 0.41)
RR     64  64K    16    CLAT AVG        110500.0 us      111200.0 us (-0.63)     112670.0 us (-1.96)     110814.7 us (-0.28)     111330.0 us (-0.75)     111840.0 us (-1.21)
RW     64   8K    32    CLAT AVG         46970.5 us       47397.5 us (-0.90)      46981.2 us (-0.02)      46805.0 us ( 0.35)      46855.6 us ( 0.24)      47114.7 us (-0.30)
RW     64   8K    32    CLAT AVG         30839.1 us       30873.3 us (-0.11)      31201.9 us (-1.17)      30887.5 us (-0.15)      30773.6 us ( 0.21)      30897.8 us (-0.19)
W     128   1M     8    CLAT AVG       2054340.0 us     2051110.0 us ( 0.15)    2048800.0 us ( 0.26)    2058030.0 us (-0.17)    2065320.0 us (-0.53)    2043240.0 us ( 0.54)
R     128   1M     8    CLAT AVG       1118460.0 us     1119780.0 us (-0.11)    1114250.0 us ( 0.37)    1115540.0 us ( 0.26)    1115540.0 us ( 0.26)    1113930.0 us ( 0.40)
RW    128  64K    16    CLAT AVG        287625.9 us      290775.8 us (-1.09)     289040.0 us (-0.49)     290366.1 us (-0.95)     288795.9 us (-0.40)     290306.1 us (-0.93)
RR    128  64K    16    CLAT AVG        222601.0 us      222170.0 us ( 0.19)     222580.0 us ( 0.00)     224743.7 us (-0.96)     223320.0 us (-0.32)     223775.6 us (-0.52)
RW    128   8K    32    CLAT AVG         93949.4 us       93972.4 us (-0.02)      98961.0 us (-5.33)      94818.5 us (-0.92)      93917.1 us ( 0.03)      93688.3 us ( 0.27)
RW    128   8K    32    CLAT AVG         62598.3 us       61654.1 us ( 1.50)      61913.4 us ( 1.09)      61301.0 us ( 2.07)      62662.0 us (-0.10)      61784.4 us ( 1.30)
W     256   1M     8    CLAT AVG       4014360.0 us     4028390.0 us (-0.34)    4009690.0 us ( 0.11)    4018700.0 us (-0.10)    4038720.0 us (-0.60)    4027440.0 us (-0.32)
R     256   1M     8    CLAT AVG       2211560.0 us     2216230.0 us (-0.21)    2207320.0 us ( 0.19)    2206530.0 us ( 0.22)    2205070.0 us ( 0.29)    2207260.0 us ( 0.19)
RW    256  64K    16    CLAT AVG        574070.0 us      581436.9 us (-1.28)     576484.9 us (-0.42)     580001.4 us (-1.03)     580290.6 us (-1.08)     578692.3 us (-0.80)
RR    256  64K    16    CLAT AVG        443990.0 us      437491.6 us ( 1.46)     440490.0 us ( 0.78)     448700.0 us (-1.06)     447560.0 us (-0.80)     448797.1 us (-1.08)
RW    256   8K    32    CLAT AVG        195262.5 us      191444.3 us ( 1.95)     192471.6 us ( 1.42)     194171.7 us ( 0.55)     197490.4 us (-1.14)     190581.6 us ( 2.39)
RW    256   8K    32    CLAT AVG        124624.6 us      123862.7 us ( 0.61)     123963.1 us ( 0.53)     123065.0 us ( 1.25)     122948.0 us ( 1.34)     122853.2 us ( 1.42)
W     512   1M     8    CLAT AVG       7703790.0 us     7742770.0 us (-0.50)    7759930.0 us (-0.72)    7723970.0 us (-0.26)    7736920.0 us (-0.43)    7713090.0 us (-0.12)
R     512   1M     8    CLAT AVG       4325390.0 us     4331790.0 us (-0.14)    4312920.0 us ( 0.28)    4320950.0 us ( 0.10)    4321300.0 us ( 0.09)    4313160.0 us ( 0.28)
RW    512  64K    16    CLAT AVG       1158713.5 us     1149437.7 us ( 0.80)    1145564.9 us ( 1.13)    1155980.4 us ( 0.23)    1157880.0 us ( 0.07)    1152592.9 us ( 0.52)
RR    512  64K    16    CLAT AVG        885387.7 us      893373.2 us (-0.90)     887200.0 us (-0.20)     879343.9 us ( 0.68)     885385.7 us ( 0.00)     886988.4 us (-0.18)
RW    512   8K    32    CLAT AVG        383634.2 us      390221.6 us (-1.71)     404134.0 us (-5.34)     393185.9 us (-2.48)     394364.9 us (-2.79)     390381.9 us (-1.75)
RW    512   8K    32    CLAT AVG        244770.0 us      244107.0 us ( 0.27)     245040.3 us (-0.11)     244348.7 us ( 0.17)     246479.8 us (-0.69)     245563.4 us (-0.32)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS2-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    CLAT  99        25560.0 us         22676.0 us (11.28)      22414.0 us (12.30)      22414.0 us (12.30)      22414.0 us (12.30)      21103.0 us (17.43)
R       1   1M     8    CLAT  99        13829.0 us         13829.0 us ( 0.00)      13829.0 us ( 0.00)     15664.0 us (-13.26)      14615.0 us (-5.68)      14091.0 us (-1.89)
RW      1  64K    16    CLAT  99         2900.0 us          3064.0 us (-5.65)       2835.0 us ( 2.24)       2999.0 us (-3.41)       2868.0 us ( 1.10)       2868.0 us ( 1.10)
RR      1  64K    16    CLAT  99         4113.0 us          4228.0 us (-2.79)       4359.0 us (-5.98)       4293.0 us (-4.37)       4293.0 us (-4.37)       4080.0 us ( 0.80)
RW      1   8K    32    CLAT  99         1237.0 us         1418.0 us (-14.63)       1303.0 us (-5.33)      1418.0 us (-14.63)      1467.0 us (-18.59)      1418.0 us (-14.63)
RW      1   8K    32    CLAT  99          766.0 us           766.0 us ( 0.00)        766.0 us ( 0.00)        758.0 us ( 1.04)        766.0 us ( 0.00)        766.0 us ( 0.00)
W       2   1M     8    CLAT  99        43254.0 us         44303.0 us (-2.42)      43779.0 us (-1.21)      43779.0 us (-1.21)      43254.0 us ( 0.00)      46400.0 us (-7.27)
R       2   1M     8    CLAT  99        27395.0 us         27395.0 us ( 0.00)      25822.0 us ( 5.74)      26084.0 us ( 4.78)      25560.0 us ( 6.69)      25297.0 us ( 7.65)
RW      2  64K    16    CLAT  99         5538.0 us          5604.0 us (-1.19)       5932.0 us (-7.11)       5800.0 us (-4.73)       5735.0 us (-3.55)       5997.0 us (-8.28)
RR      2  64K    16    CLAT  99         6521.0 us          6521.0 us ( 0.00)       6587.0 us (-1.01)       6521.0 us ( 0.00)       6587.0 us (-1.01)       6587.0 us (-1.01)
RW      2   8K    32    CLAT  99         3490.0 us          3621.0 us (-3.75)       3490.0 us ( 0.00)       3490.0 us ( 0.00)       3589.0 us (-2.83)       3490.0 us ( 0.00)
RW      2   8K    32    CLAT  99         2311.0 us          2343.0 us (-1.38)       2311.0 us ( 0.00)       2311.0 us ( 0.00)       2343.0 us (-1.38)       2343.0 us (-1.38)
W       4   1M     8    CLAT  99        90000.0 us         92000.0 us (-2.22)      88000.0 us ( 2.22)    130000.0 us (-44.44)      92000.0 us (-2.22)      95000.0 us (-5.55)
R       4   1M     8    CLAT  99        45351.0 us         47449.0 us (-4.62)      49021.0 us (-8.09)     58459.0 us (-28.90)      42730.0 us ( 5.77)      42730.0 us ( 5.77)
RW      4  64K    16    CLAT  99        22938.0 us         23200.0 us (-1.14)      22676.0 us ( 1.14)      23200.0 us (-1.14)      23200.0 us (-1.14)      23462.0 us (-2.28)
RR      4  64K    16    CLAT  99        17695.0 us         17695.0 us ( 0.00)      17695.0 us ( 0.00)      17433.0 us ( 1.48)      17695.0 us ( 0.00)      17695.0 us ( 0.00)
RW      4   8K    32    CLAT  99         6259.0 us          6325.0 us (-1.05)       6325.0 us (-1.05)       6259.0 us ( 0.00)       6259.0 us ( 0.00)       6325.0 us (-1.05)
RW      4   8K    32    CLAT  99         3982.0 us          3949.0 us ( 0.82)       3949.0 us ( 0.82)       3949.0 us ( 0.82)       3982.0 us ( 0.00)       3949.0 us ( 0.82)
W       8   1M     8    CLAT  99       321000.0 us        326000.0 us (-1.55)     241000.0 us (24.92)     317000.0 us ( 1.24)     321000.0 us ( 0.00)     234000.0 us (27.10)
R       8   1M     8    CLAT  99       171000.0 us        167000.0 us ( 2.33)     169000.0 us ( 1.16)     169000.0 us ( 1.16)      85000.0 us (50.29)      84000.0 us (50.87)
RW      8  64K    16    CLAT  99        43254.0 us         43254.0 us ( 0.00)      42730.0 us ( 1.21)      42730.0 us ( 1.21)      43254.0 us ( 0.00)      42730.0 us ( 1.21)
RR      8  64K    16    CLAT  99        32900.0 us         33162.0 us (-0.79)      33424.0 us (-1.59)      33162.0 us (-0.79)      35390.0 us (-7.56)      33162.0 us (-0.79)
RW      8   8K    32    CLAT  99        11469.0 us         11469.0 us ( 0.00)      12125.0 us (-5.71)      11731.0 us (-2.28)      11994.0 us (-4.57)      11994.0 us (-4.57)
RW      8   8K    32    CLAT  99         7242.0 us          7242.0 us ( 0.00)       7242.0 us ( 0.00)       7242.0 us ( 0.00)       7308.0 us (-0.91)       7242.0 us ( 0.00)
W      16   1M     8    CLAT  99       634000.0 us        667000.0 us (-5.20)     684000.0 us (-7.88)     693000.0 us (-9.30)     659000.0 us (-3.94)     651000.0 us (-2.68)
R      16   1M     8    CLAT  99       376000.0 us        355000.0 us ( 5.58)     401000.0 us (-6.64)     393000.0 us (-4.52)     326000.0 us (13.29)     393000.0 us (-4.52)
RW     16  64K    16    CLAT  99        63701.0 us         63701.0 us ( 0.00)      64226.0 us (-0.82)      62653.0 us ( 1.64)      63177.0 us ( 0.82)      62653.0 us ( 1.64)
RR     16  64K    16    CLAT  99        48497.0 us         48497.0 us ( 0.00)      48497.0 us ( 0.00)      49021.0 us (-1.08)      49021.0 us (-1.08)      49021.0 us (-1.08)
RW     16   8K    32    CLAT  99        21000.0 us         20000.0 us ( 4.76)      21000.0 us ( 0.00)      23000.0 us (-9.52)      21365.0 us (-1.73)      21000.0 us ( 0.00)
RW     16   8K    32    CLAT  99        12518.0 us         12518.0 us ( 0.00)      12649.0 us (-1.04)      12780.0 us (-2.09)      12649.0 us (-1.04)      12518.0 us ( 0.00)
W      32   1M     8    CLAT  99       902000.0 us        844000.0 us ( 6.43)     844000.0 us ( 6.43)     894000.0 us ( 0.88)     894000.0 us ( 0.88)     936000.0 us (-3.76)
R      32   1M     8    CLAT  99       464000.0 us        477000.0 us (-2.80)     468000.0 us (-0.86)     451000.0 us ( 2.80)     456000.0 us ( 1.72)     481000.0 us (-3.66)
RW     32  64K    16    CLAT  99       103000.0 us        103000.0 us ( 0.00)     103000.0 us ( 0.00)     103000.0 us ( 0.00)     102000.0 us ( 0.97)     104000.0 us (-0.97)
RR     32  64K    16    CLAT  99        77071.0 us         78119.0 us (-1.35)      78119.0 us (-1.35)      77071.0 us ( 0.00)      77071.0 us ( 0.00)      78119.0 us (-1.35)
RW     32   8K    32    CLAT  99        38011.0 us        45000.0 us (-18.38)      40109.0 us (-5.51)     43000.0 us (-13.12)      40000.0 us (-5.23)      37000.0 us ( 2.65)
RW     32   8K    32    CLAT  99        22938.0 us         23987.0 us (-4.57)      22938.0 us ( 0.00)      23200.0 us (-1.14)      23725.0 us (-3.43)      23725.0 us (-3.43)
W      64   1M     8    CLAT  99      1687000.0 us       1687000.0 us ( 0.00)    1552000.0 us ( 8.00)    1620000.0 us ( 3.97)    1687000.0 us ( 0.00)    1687000.0 us ( 0.00)
R      64   1M     8    CLAT  99       885000.0 us        885000.0 us ( 0.00)     877000.0 us ( 0.90)     919000.0 us (-3.84)     919000.0 us (-3.84)     902000.0 us (-1.92)
RW     64  64K    16    CLAT  99       199000.0 us        190000.0 us ( 4.52)     197000.0 us ( 1.00)     199000.0 us ( 0.00)     201000.0 us (-1.00)     190000.0 us ( 4.52)
RR     64  64K    16    CLAT  99       155000.0 us        157000.0 us (-1.29)     153000.0 us ( 1.29)     159000.0 us (-2.58)     157000.0 us (-1.29)     157000.0 us (-1.29)
RW     64   8K    32    CLAT  99        93000.0 us         89000.0 us ( 4.30)      94000.0 us (-1.07)      87000.0 us ( 6.45)      85000.0 us ( 8.60)      91000.0 us ( 2.15)
RW     64   8K    32    CLAT  99        48497.0 us         47973.0 us ( 1.08)      48497.0 us ( 0.00)      48497.0 us ( 0.00)      47973.0 us ( 1.08)      47973.0 us ( 1.08)
W     128   1M     8    CLAT  99      3205000.0 us       3104000.0 us ( 3.15)    3239000.0 us (-1.06)    3239000.0 us (-1.06)    3339000.0 us (-4.18)    3104000.0 us ( 3.15)
R     128   1M     8    CLAT  99      1770000.0 us       1703000.0 us ( 3.78)    1888000.0 us (-6.66)    1687000.0 us ( 4.68)    1821000.0 us (-2.88)    1720000.0 us ( 2.82)
RW    128  64K    16    CLAT  99       355000.0 us       430000.0 us (-21.12)    393000.0 us (-10.70)    430000.0 us (-21.12)    393000.0 us (-10.70)     363000.0 us (-2.25)
RR    128  64K    16    CLAT  99       326000.0 us        342000.0 us (-4.90)     338000.0 us (-3.68)     338000.0 us (-3.68)     338000.0 us (-3.68)     326000.0 us ( 0.00)
RW    128   8K    32    CLAT  99       190000.0 us        184000.0 us ( 3.15)    224000.0 us (-17.89)     192000.0 us (-1.05)     188000.0 us ( 1.05)     182000.0 us ( 4.21)
RW    128   8K    32    CLAT  99       103000.0 us        100000.0 us ( 2.91)     101000.0 us ( 1.94)      99000.0 us ( 3.88)     103000.0 us ( 0.00)     101000.0 us ( 1.94)
W     256   1M     8    CLAT  99      5336000.0 us       5671000.0 us (-6.27)    5537000.0 us (-3.76)    5671000.0 us (-6.27)    5470000.0 us (-2.51)    5470000.0 us (-2.51)
R     256   1M     8    CLAT  99      3004000.0 us      3675000.0 us (-22.33)    3138000.0 us (-4.46)    3205000.0 us (-6.69)    3239000.0 us (-7.82)    3037000.0 us (-1.09)
RW    256  64K    16    CLAT  99       709000.0 us       793000.0 us (-11.84)     726000.0 us (-2.39)    869000.0 us (-22.56)     776000.0 us (-9.44)    818000.0 us (-15.37)
RR    256  64K    16    CLAT  99       651000.0 us        600000.0 us ( 7.83)     642000.0 us ( 1.38)     642000.0 us ( 1.38)     709000.0 us (-8.90)     709000.0 us (-8.90)
RW    256   8K    32    CLAT  99       443000.0 us        393000.0 us (11.28)     418000.0 us ( 5.64)     418000.0 us ( 5.64)     422000.0 us ( 4.74)     397000.0 us (10.38)
RW    256   8K    32    CLAT  99       207000.0 us        207000.0 us ( 0.00)     205000.0 us ( 0.96)     201000.0 us ( 2.89)     205000.0 us ( 0.96)     201000.0 us ( 2.89)
W     512   1M     8    CLAT  99     10537000.0 us      10402000.0 us ( 1.28)   10537000.0 us ( 0.00)   10671000.0 us (-1.27)   10402000.0 us ( 1.28)   10805000.0 us (-2.54)
R     512   1M     8    CLAT  99      5604000.0 us       5805000.0 us (-3.58)    5805000.0 us (-3.58)    6007000.0 us (-7.19)    5805000.0 us (-3.58)    5873000.0 us (-4.80)
RW    512  64K    16    CLAT  99      1552000.0 us       1485000.0 us ( 4.31)    1452000.0 us ( 6.44)    1620000.0 us (-4.38)    1502000.0 us ( 3.22)    1519000.0 us ( 2.12)
RR    512  64K    16    CLAT  99      1167000.0 us      1301000.0 us (-11.48)    1217000.0 us (-4.28)   1334000.0 us (-14.31)   1301000.0 us (-11.48)   1301000.0 us (-11.48)
RW    512   8K    32    CLAT  99       785000.0 us        810000.0 us (-3.18)     827000.0 us (-5.35)     793000.0 us (-1.01)    869000.0 us (-10.70)     802000.0 us (-2.16)
RW    512   8K    32    CLAT  99       409000.0 us        422000.0 us (-3.17)     405000.0 us ( 0.97)     426000.0 us (-4.15)     409000.0 us ( 0.00)     409000.0 us ( 0.00)

==================================================================================================================================
                                                 ~~~~~~~~~~~~~~~~NPS4~~~~~~~~~~~~~~~~
==================================================================================================================================

TEST Threads BS  IODEPTH Metric   NPS4-6.4.0-rc1       CPU                 SMT                 CACHE               NUMA                SYSTEM
W       1   1M     8        BW       448 MB/s      448 MB/s( 0.00)     450 MB/s( 0.44)     447 MB/s(-0.22)     447 MB/s(-0.22)     450 MB/s( 0.44)
R       1   1M     8        BW       670 MB/s      660 MB/s(-1.49)     664 MB/s(-0.89)     671 MB/s( 0.14)     660 MB/s(-1.49)     762 MB/s(13.73)      ###
RW      1  64K    16        BW       434 MB/s      435 MB/s( 0.23)     438 MB/s( 0.92)     437 MB/s( 0.69)     436 MB/s( 0.46)     434 MB/s( 0.00)
RR      1  64K    16        BW       467 MB/s      462 MB/s(-1.07)     467 MB/s( 0.00)     466 MB/s(-0.21)     466 MB/s(-0.21)     465 MB/s(-0.42)
RW      1   8K    32        BW       251 MB/s      230 MB/s(-8.36)     243 MB/s(-3.18)     213 MB/s(-15.13)    238 MB/s(-5.17)     224 MB/s(-10.75)     ***
RW      1   8K    32        BW       536 MB/s      514 MB/s(-4.10)     536 MB/s( 0.00)     536 MB/s( 0.00)     536 MB/s( 0.00)     537 MB/s( 0.18)
W       2   1M     8        BW       451 MB/s      451 MB/s( 0.00)     451 MB/s( 0.00)     450 MB/s(-0.22)     450 MB/s(-0.22)     450 MB/s(-0.22)
R       2   1M     8        BW       819 MB/s      689 MB/s(-15.87)    673 MB/s(-17.82)    789 MB/s(-3.66)     792 MB/s(-3.29)     784 MB/s(-4.27)      ***
RW      2  64K    16        BW       434 MB/s      437 MB/s( 0.69)     439 MB/s( 1.15)     438 MB/s( 0.92)     437 MB/s( 0.69)     436 MB/s( 0.46)
RR      2  64K    16        BW       570 MB/s      566 MB/s(-0.70)     564 MB/s(-1.05)     565 MB/s(-0.87)     567 MB/s(-0.52)     568 MB/s(-0.35)
RW      2   8K    32        BW       349 MB/s      348 MB/s(-0.28)     339 MB/s(-2.86)     345 MB/s(-1.14)     348 MB/s(-0.28)     346 MB/s(-0.85)
RW      2   8K    32        BW       535 MB/s      544 MB/s( 1.68)     545 MB/s( 1.86)     546 MB/s( 2.05)     545 MB/s( 1.86)     545 MB/s( 1.86)
W       4   1M     8        BW       441 MB/s      434 MB/s(-1.58)     448 MB/s( 1.58)     448 MB/s( 1.58)     452 MB/s( 2.49)     448 MB/s( 1.58)
R       4   1M     8        BW       824 MB/s      834 MB/s( 1.21)     821 MB/s(-0.36)     831 MB/s( 0.84)     825 MB/s( 0.12)     828 MB/s( 0.48)
RW      4  64K    16        BW       434 MB/s      438 MB/s( 0.92)     431 MB/s(-0.69)     435 MB/s( 0.23)     434 MB/s( 0.00)     434 MB/s( 0.00)
RR      4  64K    16        BW       565 MB/s      562 MB/s(-0.53)     566 MB/s( 0.17)     566 MB/s( 0.17)     565 MB/s( 0.00)     564 MB/s(-0.17)
RW      4   8K    32        BW       349 MB/s      346 MB/s(-0.85)     347 MB/s(-0.57)     346 MB/s(-0.85)     346 MB/s(-0.85)     337 MB/s(-3.43)
RW      4   8K    32        BW       544 MB/s      542 MB/s(-0.36)     544 MB/s( 0.00)     543 MB/s(-0.18)     539 MB/s(-0.91)     543 MB/s(-0.18)
W       8   1M     8        BW       449 MB/s      447 MB/s(-0.44)     452 MB/s( 0.66)     450 MB/s( 0.22)     449 MB/s( 0.00)     448 MB/s(-0.22)
R       8   1M     8        BW       829 MB/s      825 MB/s(-0.48)     827 MB/s(-0.24)     830 MB/s( 0.12)     834 MB/s( 0.60)     831 MB/s( 0.24)
RW      8  64K    16        BW       431 MB/s      436 MB/s( 1.16)     435 MB/s( 0.92)     432 MB/s( 0.23)     436 MB/s( 1.16)     436 MB/s( 1.16)
RR      8  64K    16        BW       567 MB/s      565 MB/s(-0.35)     567 MB/s( 0.00)     555 MB/s(-2.11)     562 MB/s(-0.88)     567 MB/s( 0.00)
RW      8   8K    32        BW       347 MB/s      346 MB/s(-0.28)     344 MB/s(-0.86)     348 MB/s( 0.28)     348 MB/s( 0.28)     348 MB/s( 0.28)
RW      8   8K    32        BW       540 MB/s      541 MB/s( 0.18)     542 MB/s( 0.37)     539 MB/s(-0.18)     540 MB/s( 0.00)     541 MB/s( 0.18)
W      16   1M     8        BW       452 MB/s      450 MB/s(-0.44)     450 MB/s(-0.44)     450 MB/s(-0.44)     450 MB/s(-0.44)     452 MB/s( 0.00)
R      16   1M     8        BW       831 MB/s      831 MB/s( 0.00)     833 MB/s( 0.24)     834 MB/s( 0.36)     834 MB/s( 0.36)     834 MB/s( 0.36)
RW     16  64K    16        BW       436 MB/s      437 MB/s( 0.22)     434 MB/s(-0.45)     434 MB/s(-0.45)     434 MB/s(-0.45)     438 MB/s( 0.45)
RR     16  64K    16        BW       566 MB/s      556 MB/s(-1.76)     560 MB/s(-1.06)     565 MB/s(-0.17)     560 MB/s(-1.06)     570 MB/s( 0.70)
RW     16   8K    32        BW       348 MB/s      348 MB/s( 0.00)     348 MB/s( 0.00)     347 MB/s(-0.28)     346 MB/s(-0.57)     348 MB/s( 0.00)
RW     16   8K    32        BW       539 MB/s      540 MB/s( 0.18)     538 MB/s(-0.18)     538 MB/s(-0.18)     534 MB/s(-0.92)     536 MB/s(-0.55)
W      32   1M     8        BW       452 MB/s      452 MB/s( 0.00)     450 MB/s(-0.44)     451 MB/s(-0.22)     448 MB/s(-0.88)     451 MB/s(-0.22)
R      32   1M     8        BW       831 MB/s      832 MB/s( 0.12)     833 MB/s( 0.24)     837 MB/s( 0.72)     835 MB/s( 0.48)     835 MB/s( 0.48)
RW     32  64K    16        BW       435 MB/s      431 MB/s(-0.91)     436 MB/s( 0.22)     436 MB/s( 0.22)     434 MB/s(-0.22)     438 MB/s( 0.68)
RR     32  64K    16        BW       568 MB/s      560 MB/s(-1.40)     560 MB/s(-1.40)     559 MB/s(-1.58)     562 MB/s(-1.05)     565 MB/s(-0.52)
RW     32   8K    32        BW       347 MB/s      345 MB/s(-0.57)     345 MB/s(-0.57)     346 MB/s(-0.28)     341 MB/s(-1.72)     346 MB/s(-0.28)
RW     32   8K    32        BW       524 MB/s      536 MB/s( 2.29)     536 MB/s( 2.29)     536 MB/s( 2.29)     532 MB/s( 1.52)     531 MB/s( 1.33)
W      64   1M     8        BW       450 MB/s      452 MB/s( 0.44)     450 MB/s( 0.00)     450 MB/s( 0.00)     447 MB/s(-0.66)     451 MB/s( 0.22)
R      64   1M     8        BW       831 MB/s      832 MB/s( 0.12)     835 MB/s( 0.48)     835 MB/s( 0.48)     833 MB/s( 0.24)     835 MB/s( 0.48)
RW     64  64K    16        BW       429 MB/s      434 MB/s( 1.16)     434 MB/s( 1.16)     431 MB/s( 0.46)     430 MB/s( 0.23)     438 MB/s( 2.09)
RR     64  64K    16        BW       568 MB/s      564 MB/s(-0.70)     558 MB/s(-1.76)     567 MB/s(-0.17)     562 MB/s(-1.05)     566 MB/s(-0.35)
RW     64   8K    32        BW       342 MB/s      342 MB/s( 0.00)     345 MB/s( 0.87)     339 MB/s(-0.87)     344 MB/s( 0.58)     346 MB/s( 1.16)
RW     64   8K    32        BW       532 MB/s      529 MB/s(-0.56)     530 MB/s(-0.37)     529 MB/s(-0.56)     533 MB/s( 0.18)     530 MB/s(-0.37)
W     128   1M     8        BW       451 MB/s      451 MB/s( 0.00)     449 MB/s(-0.44)     450 MB/s(-0.22)     447 MB/s(-0.88)     451 MB/s( 0.00)
R     128   1M     8        BW       831 MB/s      832 MB/s( 0.12)     834 MB/s( 0.36)     833 MB/s( 0.24)     834 MB/s( 0.36)     835 MB/s( 0.48)
RW    128  64K    16        BW       435 MB/s      435 MB/s( 0.00)     434 MB/s(-0.22)     430 MB/s(-1.14)     430 MB/s(-1.14)     433 MB/s(-0.45)
RR    128  64K    16        BW       565 MB/s      568 MB/s( 0.53)     561 MB/s(-0.70)     562 MB/s(-0.53)     567 MB/s( 0.35)     566 MB/s( 0.17)
RW    128   8K    32        BW       339 MB/s      338 MB/s(-0.29)     340 MB/s( 0.29)     340 MB/s( 0.29)     343 MB/s( 1.17)     339 MB/s( 0.00)
RW    128   8K    32        BW       528 MB/s      533 MB/s( 0.94)     524 MB/s(-0.75)     527 MB/s(-0.18)     528 MB/s( 0.00)     526 MB/s(-0.37)
W     256   1M     8        BW       449 MB/s      451 MB/s( 0.44)     450 MB/s( 0.22)     450 MB/s( 0.22)     450 MB/s( 0.22)     447 MB/s(-0.44)
R     256   1M     8        BW       831 MB/s      831 MB/s( 0.00)     834 MB/s( 0.36)     834 MB/s( 0.36)     837 MB/s( 0.72)     835 MB/s( 0.48)
RW    256  64K    16        BW       434 MB/s      432 MB/s(-0.46)     434 MB/s( 0.00)     430 MB/s(-0.92)     430 MB/s(-0.92)     436 MB/s( 0.46)
RR    256  64K    16        BW       567 MB/s      567 MB/s( 0.00)     559 MB/s(-1.41)     566 MB/s(-0.17)     569 MB/s( 0.35)     558 MB/s(-1.58)
RW    256   8K    32        BW       331 MB/s      336 MB/s( 1.51)     332 MB/s( 0.30)     333 MB/s( 0.60)     331 MB/s( 0.00)     332 MB/s( 0.30)
RW    256   8K    32        BW       520 MB/s      528 MB/s( 1.53)     533 MB/s( 2.50)     529 MB/s( 1.73)     531 MB/s( 2.11)     530 MB/s( 1.92)
W     512   1M     8        BW       449 MB/s      451 MB/s( 0.44)     451 MB/s( 0.44)     450 MB/s( 0.22)     446 MB/s(-0.66)     451 MB/s( 0.44)
R     512   1M     8        BW       830 MB/s      830 MB/s( 0.00)     834 MB/s( 0.48)     834 MB/s( 0.48)     835 MB/s( 0.60)     835 MB/s( 0.60)
RW    512  64K    16        BW       430 MB/s      432 MB/s( 0.46)     429 MB/s(-0.23)     435 MB/s( 1.16)     434 MB/s( 0.93)     434 MB/s( 0.93)
RR    512  64K    16        BW       564 MB/s      557 MB/s(-1.24)     567 MB/s( 0.53)     568 MB/s( 0.70)     567 MB/s( 0.53)     565 MB/s( 0.17)
RW    512   8K    32        BW       335 MB/s      334 MB/s(-0.29)     325 MB/s(-2.98)     333 MB/s(-0.59)     329 MB/s(-1.79)     317 MB/s(-5.37)
RW    512   8K    32        BW       529 MB/s      534 MB/s( 0.94)     529 MB/s( 0.00)     532 MB/s( 0.56)     526 MB/s(-0.56)     525 MB/s(-0.75)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS4-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    SLAT AVG           62.3 us            58.1 us ( 6.69)        71.8 us (-15.40)        79.8 us (-28.17)     434.2 us (-597.41)      434.3 us (-597.51)
R       1   1M     8    SLAT AVG           50.0 us            51.3 us (-2.68)         51.5 us (-3.12)         53.3 us (-6.70)     253.7 us (-407.90)      188.8 us (-278.05)
RW      1  64K    16    SLAT AVG           19.3 us            18.9 us ( 2.48)         19.0 us ( 1.49)         19.4 us (-0.20)       21.6 us (-11.63)        21.6 us (-11.94)
RR      1  64K    16    SLAT AVG           10.9 us            10.9 us (-0.18)         10.9 us ( 0.09)         11.3 us (-3.66)       15.7 us (-43.68)        15.0 us (-36.99)
RW      1   8K    32    SLAT AVG           29.2 us           33.1 us (-13.31)         30.7 us (-4.99)        35.6 us (-21.93)        31.3 us (-7.22)        33.9 us (-16.05)
RW      1   8K    32    SLAT AVG           11.0 us           13.5 us (-22.79)         10.9 us ( 0.90)         11.0 us ( 0.00)        11.0 us ( 0.45)         11.0 us ( 0.27)
W       2   1M     8    SLAT AVG           60.2 us           73.9 us (-22.74)        75.5 us (-25.36)        79.8 us (-32.61)     353.4 us (-487.09)      402.5 us (-568.68)
R       2   1M     8    SLAT AVG           38.1 us           53.8 us (-41.15)        54.2 us (-42.28)        56.6 us (-48.58)     244.2 us (-541.02)      230.8 us (-505.72)
RW      2  64K    16    SLAT AVG           17.2 us            18.6 us (-8.09)         18.2 us (-6.11)         15.6 us ( 9.31)        18.8 us (-9.26)         18.8 us (-9.26)
RR      2  64K    16    SLAT AVG           11.8 us            11.3 us ( 3.90)         12.1 us (-2.37)         11.6 us ( 2.03)       17.0 us (-44.35)        15.6 us (-32.06)
RW      2   8K    32    SLAT AVG           19.2 us            19.2 us ( 0.00)        22.1 us (-15.21)         18.8 us ( 1.92)        17.3 us ( 9.79)         19.1 us ( 0.26)
RW      2   8K    32    SLAT AVG           15.9 us             9.8 us (38.49)          9.8 us (38.68)          8.1 us (49.46)         8.0 us (50.03)          7.8 us (51.15)
W       4   1M     8    SLAT AVG           50.5 us         233.5 us (-362.32)        77.3 us (-52.95)        56.7 us (-12.27)       66.9 us (-32.48)        99.0 us (-95.96)
R       4   1M     8    SLAT AVG           26.8 us            26.5 us ( 1.15)        31.8 us (-18.45)         28.1 us (-4.88)       38.0 us (-41.53)        31.1 us (-16.03)
RW      4  64K    16    SLAT AVG           18.7 us            16.8 us (10.33)         16.4 us (12.04)         17.9 us ( 4.06)        20.2 us (-8.40)         20.4 us (-9.10)
RR      4  64K    16    SLAT AVG            8.7 us             8.3 us ( 4.83)        10.4 us (-19.44)          7.6 us (12.31)       11.9 us (-37.16)          8.1 us ( 7.24)
RW      4   8K    32    SLAT AVG           90.6 us            91.1 us (-0.64)         91.0 us (-0.49)         91.6 us (-1.11)        91.4 us (-0.97)         94.2 us (-4.04)
RW      4   8K    32    SLAT AVG           57.6 us            57.9 us (-0.52)         57.5 us ( 0.20)         57.7 us (-0.17)        58.2 us (-1.09)         57.7 us (-0.19)
W       8   1M     8    SLAT AVG          853.9 us        9189.1 us (-976.13)     8983.1 us (-952.01)     7175.0 us (-740.25)    8332.7 us (-875.83)     5838.1 us (-583.70)
R       8   1M     8    SLAT AVG         3294.6 us         5723.9 us (-73.73)      4980.4 us (-51.16)      4666.1 us (-41.62)        36.7 us (98.88)      3956.3 us (-20.08)
RW      8  64K    16    SLAT AVG         1041.9 us          1024.4 us ( 1.68)       1029.9 us ( 1.15)       1043.6 us (-0.15)      1030.3 us ( 1.11)       1025.5 us ( 1.57)
RR      8  64K    16    SLAT AVG          787.3 us           787.9 us (-0.08)        786.5 us ( 0.10)        800.7 us (-1.70)       794.5 us (-0.92)        783.9 us ( 0.42)
RW      8   8K    32    SLAT AVG          187.2 us           187.1 us ( 0.06)        188.1 us (-0.48)        186.6 us ( 0.33)       186.7 us ( 0.28)        186.3 us ( 0.47)
RW      8   8K    32    SLAT AVG          119.8 us           119.7 us ( 0.12)        119.5 us ( 0.27)        120.0 us (-0.10)       119.8 us ( 0.02)        119.6 us ( 0.17)
W      16   1M     8    SLAT AVG        30315.0 us         30625.4 us (-1.02)      32137.1 us (-6.01)      30116.3 us ( 0.65)     31053.4 us (-2.43)      31008.5 us (-2.28)
R      16   1M     8    SLAT AVG        16275.2 us         16990.0 us (-4.39)      17302.0 us (-6.30)      17030.9 us (-4.64)     16874.7 us (-3.68)      17401.9 us (-6.92)
RW     16  64K    16    SLAT AVG         2400.1 us          2392.8 us ( 0.30)       2407.4 us (-0.30)       2410.8 us (-0.44)      2408.7 us (-0.35)       2386.5 us ( 0.56)
RR     16  64K    16    SLAT AVG         1846.4 us          1877.7 us (-1.69)       1864.6 us (-0.98)       1849.9 us (-0.18)      1865.6 us (-1.03)       1833.6 us ( 0.69)
RW     16   8K    32    SLAT AVG          374.5 us           375.3 us (-0.20)        374.1 us ( 0.09)        376.0 us (-0.39)       376.9 us (-0.64)        375.1 us (-0.17)
RW     16   8K    32    SLAT AVG          241.4 us           241.2 us ( 0.09)        242.0 us (-0.26)        242.0 us (-0.26)       243.5 us (-0.86)        242.7 us (-0.54)
W      32   1M     8    SLAT AVG        73872.1 us         73953.3 us (-0.10)      74297.0 us (-0.57)      74054.8 us (-0.24)     74434.9 us (-0.76)      74080.7 us (-0.28)
R      32   1M     8    SLAT AVG        40261.1 us         40265.5 us (-0.01)      40204.9 us ( 0.13)      40013.5 us ( 0.61)     40080.2 us ( 0.44)      40067.1 us ( 0.48)
RW     32  64K    16    SLAT AVG         4816.5 us          4863.3 us (-0.97)       4811.5 us ( 0.10)       4800.6 us ( 0.33)      4823.0 us (-0.13)       4788.6 us ( 0.57)
RR     32  64K    16    SLAT AVG         3688.6 us          3739.6 us (-1.38)       3743.9 us (-1.49)       3746.3 us (-1.56)      3726.2 us (-1.01)       3711.5 us (-0.62)
RW     32   8K    32    SLAT AVG          754.1 us           755.9 us (-0.24)        758.1 us (-0.53)        755.5 us (-0.18)       766.4 us (-1.63)        754.2 us (-0.01)
RW     32   8K    32    SLAT AVG          498.7 us           487.0 us ( 2.35)        487.0 us ( 2.35)        487.3 us ( 2.28)       491.3 us ( 1.48)        492.1 us ( 1.33)
W      64   1M     8    SLAT AVG       148752.0 us        147926.2 us ( 0.55)     148587.9 us ( 0.11)     148633.2 us ( 0.07)    149428.0 us (-0.45)     148405.9 us ( 0.23)
R      64   1M     8    SLAT AVG        80606.5 us         80529.7 us ( 0.09)      80204.7 us ( 0.49)      80194.3 us ( 0.51)     80396.8 us ( 0.26)      80189.6 us ( 0.51)
RW     64  64K    16    SLAT AVG         9772.9 us          9666.2 us ( 1.09)       9655.6 us ( 1.20)       9723.9 us ( 0.50)      9749.5 us ( 0.23)       9577.8 us ( 1.99)
RR     64  64K    16    SLAT AVG         7383.6 us          7438.6 us (-0.74)       7506.0 us (-1.65)       7396.8 us (-0.17)      7459.8 us (-1.03)       7412.2 us (-0.38)
RW     64   8K    32    SLAT AVG         1529.0 us          1530.1 us (-0.07)       1516.3 us ( 0.82)       1540.0 us (-0.72)      1520.8 us ( 0.53)       1509.7 us ( 1.25)
RW     64   8K    32    SLAT AVG          983.7 us           989.8 us (-0.62)        986.5 us (-0.27)        989.2 us (-0.56)       981.8 us ( 0.18)        986.5 us (-0.27)
W     128   1M     8    SLAT AVG       296380.6 us        296001.7 us ( 0.12)     297235.8 us (-0.28)     296878.9 us (-0.16)    298735.0 us (-0.79)     296306.0 us ( 0.02)
R     128   1M     8    SLAT AVG       161104.5 us        160888.0 us ( 0.13)     160462.5 us ( 0.39)     160671.3 us ( 0.26)    160605.6 us ( 0.30)     160380.7 us ( 0.44)
RW    128  64K    16    SLAT AVG        19256.4 us         19254.8 us ( 0.00)      19327.9 us (-0.37)      19506.9 us (-1.30)     19488.9 us (-1.20)      19378.4 us (-0.63)
RR    128  64K    16    SLAT AVG        14851.0 us         14771.8 us ( 0.53)      14936.6 us (-0.57)      14914.6 us (-0.42)     14793.7 us ( 0.38)      14815.2 us ( 0.24)
RW    128   8K    32    SLAT AVG         3091.8 us          3101.3 us (-0.30)       3080.1 us ( 0.38)       3078.0 us ( 0.44)      3051.1 us ( 1.31)       3089.4 us ( 0.07)
RW    128   8K    32    SLAT AVG         1984.3 us          1964.1 us ( 1.01)       1998.0 us (-0.68)       1987.0 us (-0.13)      1982.6 us ( 0.08)       1989.6 us (-0.26)
W     256   1M     8    SLAT AVG       593779.9 us        590960.2 us ( 0.47)     592330.2 us ( 0.24)     591166.7 us ( 0.44)    591994.6 us ( 0.30)     595833.3 us (-0.34)
R     256   1M     8    SLAT AVG       321605.7 us        321601.3 us ( 0.00)     320435.1 us ( 0.36)     320533.0 us ( 0.33)    319474.0 us ( 0.66)     320265.3 us ( 0.41)
RW    256  64K    16    SLAT AVG        38612.8 us         38783.6 us (-0.44)      38644.0 us (-0.08)      39005.2 us (-1.01)     39029.8 us (-1.07)      38475.6 us ( 0.35)
RR    256  64K    16    SLAT AVG        29577.9 us         29557.0 us ( 0.07)      29991.3 us (-1.39)      29626.1 us (-0.16)     29478.7 us ( 0.33)      30031.8 us (-1.53)
RW    256   8K    32    SLAT AVG         6322.1 us          6239.8 us ( 1.30)       6322.0 us ( 0.00)       6289.9 us ( 0.50)      6322.6 us ( 0.00)       6315.4 us ( 0.10)
RW    256   8K    32    SLAT AVG         4031.9 us          3971.9 us ( 1.48)       3931.0 us ( 2.50)       3958.5 us ( 1.82)      3946.0 us ( 2.13)       3952.8 us ( 1.96)
W     512   1M     8    SLAT AVG      1181861.0 us       1175091.3 us ( 0.57)    1176164.6 us ( 0.48)    1178815.3 us ( 0.25)   1188861.1 us (-0.59)    1175876.0 us ( 0.50)
R     512   1M     8    SLAT AVG       642286.7 us        642470.8 us (-0.02)     639078.2 us ( 0.49)     639487.9 us ( 0.43)    638784.9 us ( 0.54)     638974.1 us ( 0.51)
RW    512  64K    16    SLAT AVG        77948.1 us         77613.7 us ( 0.42)      78153.8 us (-0.26)      76970.0 us ( 1.25)     77217.4 us ( 0.93)      77266.0 us ( 0.87)
RR    512  64K    16    SLAT AVG        59445.2 us         60176.2 us (-1.22)      59122.7 us ( 0.54)      59027.2 us ( 0.70)     59118.5 us ( 0.54)      59320.5 us ( 0.20)
RW    512   8K    32    SLAT AVG        12500.4 us         12531.4 us (-0.24)      12888.5 us (-3.10)      12581.7 us (-0.64)     12723.7 us (-1.78)      13221.9 us (-5.77)
RW    512   8K    32    SLAT AVG         7916.5 us          7849.6 us ( 0.84)       7923.1 us (-0.08)       7879.0 us ( 0.47)      7975.6 us (-0.74)       7984.2 us (-0.85)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS4-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    LAT AVG         18732.9 us         18737.9 us (-0.02)      18658.4 us ( 0.39)      18753.9 us (-0.11)      18773.9 us (-0.21)      18628.3 us ( 0.55)
R       1   1M     8    LAT AVG         12524.3 us         12699.7 us (-1.40)      12631.6 us (-0.85)      12502.5 us ( 0.17)      12701.1 us (-1.41)      10995.7 us (12.20)
RW      1  64K    16    LAT AVG          2417.7 us          2407.6 us ( 0.42)       2392.5 us ( 1.04)       2396.7 us ( 0.86)       2406.7 us ( 0.45)       2417.2 us ( 0.02)
RR      1  64K    16    LAT AVG          2243.9 us          2269.1 us (-1.12)       2245.3 us (-0.06)       2251.8 us (-0.35)       2251.4 us (-0.33)       2256.0 us (-0.54)
RW      1   8K    32    LAT AVG          1044.2 us          1138.0 us (-8.98)       1076.8 us (-3.12)      1228.3 us (-17.63)       1098.8 us (-5.23)      1167.5 us (-11.80)	***
RW      1   8K    32    LAT AVG           488.3 us           509.5 us (-4.32)        488.4 us (-0.01)        488.4 us (-0.01)        488.9 us (-0.10)        488.2 us ( 0.03)
W       2   1M     8    LAT AVG         37167.4 us         37207.4 us (-0.10)      37168.2 us ( 0.00)      37254.2 us (-0.23)      37268.1 us (-0.27)      37257.1 us (-0.24)
R       2   1M     8    LAT AVG         20469.5 us        24349.5 us (-18.95)     24938.8 us (-21.83)      21267.6 us (-3.89)      21178.3 us (-3.46)      21380.9 us (-4.45)	***
RW      2  64K    16    LAT AVG          4829.4 us          4793.6 us ( 0.74)       4777.0 us ( 1.08)       4791.1 us ( 0.79)       4799.4 us ( 0.62)       4807.6 us ( 0.45)
RR      2  64K    16    LAT AVG          3681.5 us          3704.5 us (-0.62)       3718.6 us (-1.00)       3711.2 us (-0.80)       3700.3 us (-0.51)       3690.4 us (-0.24)
RW      2   8K    32    LAT AVG          1502.4 us          1505.2 us (-0.18)       1544.4 us (-2.79)       1517.3 us (-0.98)       1505.7 us (-0.21)       1512.7 us (-0.68)
RW      2   8K    32    LAT AVG           979.6 us           962.6 us ( 1.73)        961.7 us ( 1.82)        960.2 us ( 1.97)        960.9 us ( 1.90)        961.7 us ( 1.82)
W       4   1M     8    LAT AVG         76080.0 us         77240.0 us (-1.52)      74850.0 us ( 1.61)      74810.0 us ( 1.66)      74300.0 us ( 2.33)      74850.0 us ( 1.61)
R       4   1M     8    LAT AVG         40700.0 us         40213.8 us ( 1.19)      40840.0 us (-0.34)      40380.0 us ( 0.78)      40649.6 us ( 0.12)      40535.9 us ( 0.40)
RW      4  64K    16    LAT AVG          9672.1 us          9584.1 us ( 0.91)       9734.8 us (-0.64)       9651.5 us ( 0.21)       9668.8 us ( 0.03)       9665.8 us ( 0.06)
RR      4  64K    16    LAT AVG          7425.0 us          7464.0 us (-0.52)       7403.0 us ( 0.29)       7410.8 us ( 0.19)       7416.3 us ( 0.11)       7430.8 us (-0.07)
RW      4   8K    32    LAT AVG          3001.2 us          3026.7 us (-0.84)       3023.0 us (-0.72)       3030.3 us (-0.96)       3026.6 us (-0.84)       3113.3 us (-3.73)
RW      4   8K    32    LAT AVG          1928.3 us          1935.5 us (-0.37)       1925.9 us ( 0.12)       1930.1 us (-0.09)       1944.0 us (-0.81)       1932.3 us (-0.20)
W       8   1M     8    LAT AVG        149300.0 us        149980.0 us (-0.45)     148300.0 us ( 0.66)     149120.0 us ( 0.12)     149390.0 us (-0.06)     149770.0 us (-0.31)
R       8   1M     8    LAT AVG         80870.0 us         81320.0 us (-0.55)      81070.0 us (-0.24)      80850.0 us ( 0.02)      80390.0 us ( 0.59)      80720.0 us ( 0.18)
RW      8  64K    16    LAT AVG         19448.9 us         19242.6 us ( 1.06)      19262.2 us ( 0.95)      19398.2 us ( 0.26)      19232.1 us ( 1.11)      19218.6 us ( 1.18)
RR      8  64K    16    LAT AVG         14796.3 us         14847.3 us (-0.34)      14797.2 us ( 0.00)      15119.5 us (-2.18)      14916.2 us (-0.81)      14781.4 us ( 0.10)
RW      8   8K    32    LAT AVG          6047.7 us          6050.1 us (-0.04)       6101.5 us (-0.89)       6022.9 us ( 0.40)       6025.6 us ( 0.36)       6026.6 us ( 0.34)
RW      8   8K    32    LAT AVG          3882.6 us          3876.6 us ( 0.15)       3870.5 us ( 0.31)       3887.3 us (-0.12)       3879.9 us ( 0.06)       3873.8 us ( 0.22)
W      16   1M     8    LAT AVG        296370.0 us        298100.0 us (-0.58)     297800.0 us (-0.48)     298200.0 us (-0.61)     297680.0 us (-0.44)     296310.0 us ( 0.02)
R      16   1M     8    LAT AVG        161300.0 us        161390.0 us (-0.05)     160980.0 us ( 0.19)     160780.0 us ( 0.32)     160810.0 us ( 0.30)     160880.0 us ( 0.26)
RW     16  64K    16    LAT AVG         38487.7 us         38374.7 us ( 0.29)      38610.0 us (-0.31)      38658.2 us (-0.44)      38630.0 us (-0.36)      38275.5 us ( 0.55)
RR     16  64K    16    LAT AVG         29638.3 us         30145.1 us (-1.70)      29932.4 us (-0.99)      29696.0 us (-0.19)      29948.7 us (-1.04)      29431.4 us ( 0.69)
RW     16   8K    32    LAT AVG         12044.0 us         12065.8 us (-0.18)      12037.5 us ( 0.05)      12092.1 us (-0.39)      12115.0 us (-0.58)      12066.7 us (-0.18)
RW     16   8K    32    LAT AVG          7775.6 us          7766.6 us ( 0.11)       7799.4 us (-0.30)       7799.3 us (-0.30)       7848.9 us (-0.94)       7818.1 us (-0.54)
W      32   1M     8    LAT AVG        591510.0 us        592030.0 us (-0.08)     593750.0 us (-0.37)     593550.0 us (-0.34)     596040.0 us (-0.76)     592030.0 us (-0.08)
R      32   1M     8    LAT AVG        322210.0 us        322200.0 us ( 0.00)     321640.0 us ( 0.17)     320260.0 us ( 0.60)     320870.0 us ( 0.41)     320820.0 us ( 0.43)
RW     32  64K    16    LAT AVG         77081.9 us         77833.3 us (-0.97)      76997.1 us ( 0.10)      76827.8 us ( 0.32)      77182.7 us (-0.13)      76637.3 us ( 0.57)
RR     32  64K    16    LAT AVG         59040.0 us         59850.0 us (-1.37)      59920.0 us (-1.49)      59960.0 us (-1.55)      59640.0 us (-1.01)      59410.0 us (-0.62)
RW     32   8K    32    LAT AVG         24199.4 us         24268.3 us (-0.28)      24336.6 us (-0.56)      24245.6 us (-0.19)      24589.6 us (-1.61)      24201.8 us ( 0.00)
RW     32   8K    32    LAT AVG         16018.1 us         15645.5 us ( 2.32)      15643.5 us ( 2.33)      15655.9 us ( 2.26)      15780.0 us ( 1.48)      15803.1 us ( 1.34)
W      64   1M     8    LAT AVG       1183590.0 us       1178070.0 us ( 0.46)    1182430.0 us ( 0.09)    1182590.0 us ( 0.08)    1188620.0 us (-0.42)    1181150.0 us ( 0.20)
R      64   1M     8    LAT AVG        643320.0 us        642690.0 us ( 0.09)     640020.0 us ( 0.51)     640020.0 us ( 0.51)     641200.0 us ( 0.32)     639880.0 us ( 0.53)
RW     64  64K    16    LAT AVG        156286.8 us        154573.7 us ( 1.09)     154403.1 us ( 1.20)     155494.2 us ( 0.50)     155897.6 us ( 0.24)     153158.4 us ( 2.00)
RR     64  64K    16    LAT AVG        118090.0 us        118970.0 us (-0.74)     120053.2 us (-1.66)     118300.0 us (-0.17)     119310.0 us (-1.03)     118560.0 us (-0.39)
RW     64   8K    32    LAT AVG         49002.3 us         49039.6 us (-0.07)      48583.4 us ( 0.85)      49376.2 us (-0.76)      48719.0 us ( 0.57)      48381.2 us ( 1.26)
RW     64   8K    32    LAT AVG         31536.2 us         31728.7 us (-0.61)      31620.2 us (-0.26)      31709.0 us (-0.54)      31472.4 us ( 0.20)      31624.2 us (-0.27)
W     128   1M     8    LAT AVG       2340540.0 us       2337820.0 us ( 0.11)    2348970.0 us (-0.36)    2346440.0 us (-0.25)    2360080.0 us (-0.83)    2340320.0 us ( 0.00)
R     128   1M     8    LAT AVG       1280260.0 us       1278600.0 us ( 0.12)    1275210.0 us ( 0.39)    1276960.0 us ( 0.25)    1276230.0 us ( 0.31)    1274360.0 us ( 0.46)
RW    128  64K    16    LAT AVG        307561.4 us        307534.7 us ( 0.00)     308677.7 us (-0.36)     311555.9 us (-1.29)     311239.9 us (-1.19)     309502.9 us (-0.63)
RR    128  64K    16    LAT AVG        237280.0 us        236010.0 us ( 0.53)     238640.0 us (-0.57)     238290.0 us (-0.42)     236336.6 us ( 0.39)     236710.0 us ( 0.24)
RW    128   8K    32    LAT AVG         98969.2 us         99287.5 us (-0.32)      98565.9 us ( 0.40)      98519.5 us ( 0.45)      97638.0 us ( 1.34)      98877.1 us ( 0.09)
RW    128   8K    32    LAT AVG         63532.9 us         62884.8 us ( 1.02)      63967.4 us (-0.68)      63616.2 us (-0.13)      63476.9 us ( 0.08)      63700.4 us (-0.26)
W     256   1M     8    LAT AVG       4619020.0 us       4598290.0 us ( 0.44)    4609920.0 us ( 0.19)    4602230.0 us ( 0.36)    4607110.0 us ( 0.25)    4635140.0 us (-0.34)
R     256   1M     8    LAT AVG       2534380.0 us       2534220.0 us ( 0.00)    2525090.0 us ( 0.36)    2525490.0 us ( 0.35)    2517740.0 us ( 0.65)    2523890.0 us ( 0.41)
RW    256  64K    16    LAT AVG        615320.0 us        618037.1 us (-0.44)     615780.0 us (-0.07)     621510.0 us (-1.00)     621920.9 us (-1.07)     613060.0 us ( 0.36)
RR    256  64K    16    LAT AVG        471690.4 us        471371.8 us ( 0.06)     478251.4 us (-1.39)     472438.7 us (-0.15)     470120.0 us ( 0.33)     478930.0 us (-1.53)
RW    256   8K    32    LAT AVG        202092.8 us        199491.8 us ( 1.28)     202068.0 us ( 0.01)     201072.0 us ( 0.50)     202110.8 us ( 0.00)     201913.0 us ( 0.08)
RW    256   8K    32    LAT AVG        128962.1 us        127047.8 us ( 1.48)     125736.9 us ( 2.50)     126621.1 us ( 1.81)     126219.0 us ( 2.12)     126436.9 us ( 1.95)
W     512   1M     8    LAT AVG       8903560.0 us       8865780.0 us ( 0.42)    8874540.0 us ( 0.32)    8885480.0 us ( 0.20)    8958760.0 us (-0.61)    8868010.0 us ( 0.39)
R     512   1M     8    LAT AVG       4974260.0 us       4977280.0 us (-0.06)    4950860.0 us ( 0.47)    4953810.0 us ( 0.41)    4948690.0 us ( 0.51)    4949640.0 us ( 0.49)
RW    512  64K    16    LAT AVG       1236179.1 us       1231250.0 us ( 0.39)    1239790.0 us (-0.29)    1221070.0 us ( 1.22)    1225070.0 us ( 0.89)    1225888.4 us ( 0.83)
RR    512  64K    16    LAT AVG        944620.0 us        956230.0 us (-1.22)     939480.0 us ( 0.54)     938029.6 us ( 0.69)     939450.0 us ( 0.54)     942670.0 us ( 0.20)
RW    512   8K    32    LAT AVG        399053.1 us        399963.3 us (-0.22)     411143.4 us (-3.02)     401355.4 us (-0.57)     406139.1 us (-1.77)     421692.5 us (-5.67)
RW    512   8K    32    LAT AVG        252931.0 us        250780.0 us ( 0.85)     253137.2 us (-0.08)     251712.5 us ( 0.48)     254804.8 us (-0.74)     255068.4 us (-0.84)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS4-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    CLAT AVG        18670.5 us         18679.7 us (-0.04)      18586.3 us ( 0.45)       18673.9 us (-0.01)     18339.6 us ( 1.77)      18193.9 us ( 2.55)
R       1   1M     8    CLAT AVG        12474.2 us         12648.3 us (-1.39)      12579.9 us (-0.84)       12449.1 us ( 0.20)     12447.3 us ( 0.21)      10806.7 us (13.36)
RW      1  64K    16    CLAT AVG         2398.3 us          2388.6 us ( 0.40)       2373.3 us ( 1.04)        2377.2 us ( 0.87)      2385.0 us ( 0.55)       2395.4 us ( 0.11)
RR      1  64K    16    CLAT AVG         2232.9 us          2258.1 us (-1.13)       2234.3 us (-0.06)        2240.4 us (-0.33)      2235.6 us (-0.12)       2241.0 us (-0.36)
RW      1   8K    32    CLAT AVG         1014.8 us          1104.8 us (-8.87)       1045.9 us (-3.07)       1192.6 us (-17.52)      1067.4 us (-5.18)      1133.4 us (-11.69)	***
RW      1   8K    32    CLAT AVG          477.2 us           495.9 us (-3.90)        477.4 us (-0.04)         477.3 us (-0.02)       477.8 us (-0.11)        477.1 us ( 0.02)
W       2   1M     8    CLAT AVG        37106.9 us         37133.3 us (-0.07)      37092.5 us ( 0.03)       37174.2 us (-0.18)     36914.5 us ( 0.51)      36854.4 us ( 0.68)
R       2   1M     8    CLAT AVG        20431.3 us        24295.6 us (-18.91)     24884.5 us (-21.79)       21210.8 us (-3.81)     20933.9 us (-2.46)      21149.9 us (-3.51)	***
RW      2  64K    16    CLAT AVG         4812.1 us          4774.9 us ( 0.77)       4758.7 us ( 1.11)        4775.5 us ( 0.76)      4780.5 us ( 0.65)       4788.8 us ( 0.48)
RR      2  64K    16    CLAT AVG         3669.6 us          3693.1 us (-0.63)       3706.4 us (-1.00)        3699.6 us (-0.81)      3683.2 us (-0.36)       3674.8 us (-0.14)
RW      2   8K    32    CLAT AVG         1483.1 us          1485.9 us (-0.18)       1522.2 us (-2.63)        1498.4 us (-1.02)      1488.3 us (-0.34)       1493.4 us (-0.69)
RW      2   8K    32    CLAT AVG          963.5 us           952.7 us ( 1.11)        951.8 us ( 1.21)         952.0 us ( 1.18)       952.8 us ( 1.10)        953.8 us ( 1.00)
W       4   1M     8    CLAT AVG        76030.0 us         77010.0 us (-1.28)      74770.0 us ( 1.65)       74750.0 us ( 1.68)     74230.0 us ( 2.36)      74750.0 us ( 1.68)
R       4   1M     8    CLAT AVG        40670.0 us         40187.1 us ( 1.18)      40810.0 us (-0.34)       40350.0 us ( 0.78)     40611.6 us ( 0.14)      40504.6 us ( 0.40)
RW      4  64K    16    CLAT AVG         9653.3 us          9567.3 us ( 0.89)       9718.3 us (-0.67)        9633.5 us ( 0.20)      9648.4 us ( 0.05)       9645.3 us ( 0.08)
RR      4  64K    16    CLAT AVG         7416.2 us          7455.6 us (-0.53)       7392.5 us ( 0.31)        7403.1 us ( 0.17)      7404.3 us ( 0.16)       7422.6 us (-0.08)
RW      4   8K    32    CLAT AVG         2910.6 us          2935.5 us (-0.85)       2931.9 us (-0.73)        2938.7 us (-0.96)      2935.1 us (-0.84)       3018.9 us (-3.72)
RW      4   8K    32    CLAT AVG         1870.6 us          1877.5 us (-0.37)       1868.3 us ( 0.12)        1872.3 us (-0.09)      1885.6 us (-0.80)       1874.5 us (-0.21)
W       8   1M     8    CLAT AVG       148450.0 us        140790.0 us ( 5.15)     139320.0 us ( 6.15)      141940.0 us ( 4.38)    141060.0 us ( 4.97)     143930.0 us ( 3.04)
R       8   1M     8    CLAT AVG        77580.0 us         75600.0 us ( 2.55)      76090.0 us ( 1.92)       76180.0 us ( 1.80)     80360.0 us (-3.58)      76770.0 us ( 1.04)
RW      8  64K    16    CLAT AVG        18406.9 us         18218.1 us ( 1.02)      18232.2 us ( 0.94)       18354.5 us ( 0.28)     18201.7 us ( 1.11)      18192.9 us ( 1.16)
RR      8  64K    16    CLAT AVG        14008.9 us         14059.2 us (-0.35)      14010.7 us (-0.01)       14318.7 us (-2.21)     14121.6 us (-0.80)      13997.4 us ( 0.08)
RW      8   8K    32    CLAT AVG         5860.4 us          5863.0 us (-0.04)       5913.3 us (-0.90)        5836.2 us ( 0.41)      5838.8 us ( 0.36)       5840.2 us ( 0.34)
RW      8   8K    32    CLAT AVG         3762.6 us          3756.9 us ( 0.15)       3750.9 us ( 0.31)        3767.2 us (-0.12)      3760.0 us ( 0.06)       3754.1 us ( 0.22)
W      16   1M     8    CLAT AVG       266060.0 us        267470.0 us (-0.52)     265670.0 us ( 0.14)      268080.0 us (-0.75)    266620.0 us (-0.21)     265300.0 us ( 0.28)
R      16   1M     8    CLAT AVG       145030.0 us        144400.0 us ( 0.43)     143680.0 us ( 0.93)      143750.0 us ( 0.88)    143940.0 us ( 0.75)     143480.0 us ( 1.06)
RW     16  64K    16    CLAT AVG        36087.5 us         35981.8 us ( 0.29)      36200.0 us (-0.31)       36247.3 us (-0.44)     36220.0 us (-0.36)      35888.9 us ( 0.55)
RR     16  64K    16    CLAT AVG        27791.8 us         28267.3 us (-1.71)      28067.7 us (-0.99)       27846.0 us (-0.19)     28083.0 us (-1.04)      27597.7 us ( 0.69)
RW     16   8K    32    CLAT AVG        11669.4 us         11690.4 us (-0.17)      11663.3 us ( 0.05)       11716.0 us (-0.39)     11738.0 us (-0.58)      11691.4 us (-0.18)
RW     16   8K    32    CLAT AVG         7534.0 us          7525.3 us ( 0.11)       7557.2 us (-0.30)        7557.1 us (-0.30)      7605.3 us (-0.94)       7575.3 us (-0.54)
W      32   1M     8    CLAT AVG       517640.0 us        518070.0 us (-0.08)     519450.0 us (-0.34)      519490.0 us (-0.35)    521610.0 us (-0.76)     517950.0 us (-0.05)
R      32   1M     8    CLAT AVG       281950.0 us        281940.0 us ( 0.00)     281430.0 us ( 0.18)      280250.0 us ( 0.60)    280790.0 us ( 0.41)     280750.0 us ( 0.42)
RW     32  64K    16    CLAT AVG        72265.2 us         72969.8 us (-0.97)      72185.4 us ( 0.11)       72027.0 us ( 0.32)     72359.4 us (-0.13)      71848.5 us ( 0.57)
RR     32  64K    16    CLAT AVG        55350.0 us         56110.0 us (-1.37)      56180.0 us (-1.49)       56214.0 us (-1.56)     55910.0 us (-1.01)      55690.0 us (-0.61)
RW     32   8K    32    CLAT AVG        23445.2 us         23512.2 us (-0.28)      23578.3 us (-0.56)       23490.0 us (-0.19)     23823.0 us (-1.61)      23447.4 us ( 0.00)
RW     32   8K    32    CLAT AVG        15519.2 us         15158.3 us ( 2.32)      15156.3 us ( 2.33)       15168.5 us ( 2.26)     15288.6 us ( 1.48)      15310.9 us ( 1.34)
W      64   1M     8    CLAT AVG      1034840.0 us       1030150.0 us ( 0.45)    1033850.0 us ( 0.09)     1033950.0 us ( 0.08)   1039190.0 us (-0.42)    1032740.0 us ( 0.20)
R      64   1M     8    CLAT AVG       562710.0 us        562160.0 us ( 0.09)     559810.0 us ( 0.51)      559830.0 us ( 0.51)    560810.0 us ( 0.33)     559690.0 us ( 0.53)
RW     64  64K    16    CLAT AVG       146513.6 us        144907.3 us ( 1.09)     144747.3 us ( 1.20)      145770.1 us ( 0.50)    146147.9 us ( 0.24)     143580.4 us ( 2.00)
RR     64  64K    16    CLAT AVG       110708.2 us        111530.0 us (-0.74)     112546.9 us (-1.66)      110910.0 us (-0.18)    111850.0 us (-1.03)     111140.0 us (-0.39)
RW     64   8K    32    CLAT AVG        47473.1 us         47509.3 us (-0.07)      47066.9 us ( 0.85)       47836.0 us (-0.76)     47198.1 us ( 0.57)      46871.4 us ( 1.26)
RW     64   8K    32    CLAT AVG        30552.4 us         30738.8 us (-0.61)      30633.6 us (-0.26)       30719.6 us (-0.54)     30490.4 us ( 0.20)      30637.7 us (-0.27)
W     128   1M     8    CLAT AVG      2044160.0 us       2041810.0 us ( 0.11)    2051730.0 us (-0.37)     2049560.0 us (-0.26)   2061340.0 us (-0.84)    2044010.0 us ( 0.00)
R     128   1M     8    CLAT AVG      1119150.0 us       1117720.0 us ( 0.12)    1114750.0 us ( 0.39)     1116290.0 us ( 0.25)   1115630.0 us ( 0.31)    1113980.0 us ( 0.46)
RW    128  64K    16    CLAT AVG       288304.8 us        288279.7 us ( 0.00)     289349.5 us (-0.36)      292048.8 us (-1.29)    291750.7 us (-1.19)     290124.2 us (-0.63)
RR    128  64K    16    CLAT AVG       222423.9 us        221240.0 us ( 0.53)     223699.9 us (-0.57)      223371.5 us (-0.42)    221542.7 us ( 0.39)     221900.0 us ( 0.23)
RW    128   8K    32    CLAT AVG        95877.2 us         96186.1 us (-0.32)      95485.6 us ( 0.40)       95441.3 us ( 0.45)     94586.7 us ( 1.34)      95787.5 us ( 0.09)
RW    128   8K    32    CLAT AVG        61548.4 us         60920.6 us ( 1.02)      61969.3 us (-0.68)       61629.1 us (-0.13)     61494.1 us ( 0.08)      61710.7 us (-0.26)
W     256   1M     8    CLAT AVG      4025240.0 us       4007330.0 us ( 0.44)    4017590.0 us ( 0.19)     4011060.0 us ( 0.35)   4015110.0 us ( 0.25)    4039310.0 us (-0.34)
R     256   1M     8    CLAT AVG      2212780.0 us       2212620.0 us ( 0.00)    2204660.0 us ( 0.36)     2204950.0 us ( 0.35)   2198270.0 us ( 0.65)    2203630.0 us ( 0.41)
RW    256  64K    16    CLAT AVG       576700.0 us        579253.3 us (-0.44)     577130.0 us (-0.07)      582507.9 us (-1.00)    582890.8 us (-1.07)     574580.0 us ( 0.36)
RR    256  64K    16    CLAT AVG       442112.2 us        441814.6 us ( 0.06)     448260.0 us (-1.39)      442812.3 us (-0.15)    440640.0 us ( 0.33)     448895.9 us (-1.53)
RW    256   8K    32    CLAT AVG       195770.5 us        193251.8 us ( 1.28)     195745.9 us ( 0.01)      194781.9 us ( 0.50)    195788.0 us ( 0.00)     195597.5 us ( 0.08)
RW    256   8K    32    CLAT AVG       124930.0 us        123075.7 us ( 1.48)     121805.7 us ( 2.50)      122662.4 us ( 1.81)    122272.8 us ( 2.12)     122484.0 us ( 1.95)
W     512   1M     8    CLAT AVG      7721700.0 us       7690690.0 us ( 0.40)    7698370.0 us ( 0.30)     7706670.0 us ( 0.19)   7769900.0 us (-0.62)    7692130.0 us ( 0.38)
R     512   1M     8    CLAT AVG      4331980.0 us       4334810.0 us (-0.06)    4311790.0 us ( 0.46)     4314320.0 us ( 0.40)   4309900.0 us ( 0.50)    4310660.0 us ( 0.49)
RW    512  64K    16    CLAT AVG      1158230.7 us       1153641.0 us ( 0.39)    1161630.0 us (-0.29)     1144103.0 us ( 1.21)   1147850.0 us ( 0.89)    1148622.1 us ( 0.82)
RR    512  64K    16    CLAT AVG       885170.0 us        896058.4 us (-1.23)     880356.7 us ( 0.54)      879002.1 us ( 0.69)    880330.0 us ( 0.54)     883352.1 us ( 0.20)
RW    512   8K    32    CLAT AVG       386552.5 us        387431.7 us (-0.22)     398254.8 us (-3.02)      388773.6 us (-0.57)    393415.3 us (-1.77)     408470.4 us (-5.67)
RW    512   8K    32    CLAT AVG       245014.4 us        242930.3 us ( 0.85)     245214.0 us (-0.08)      243833.3 us ( 0.48)    246829.0 us (-0.74)     247084.1 us (-0.84)

==================================================================================================================================

TEST Threads BS  IODEPTH Metric       NPS4-6.4.0-rc1              CPU                     SMT                    CACHE                   NUMA                    SYSTEM
W       1   1M     8    CLAT  99        22414.0 us         23725.0 us (-5.84)      22152.0 us ( 1.16)      22414.0 us ( 0.00)      22414.0 us ( 0.00)      21103.0 us ( 5.84)
R       1   1M     8    CLAT  99        13960.0 us         14353.0 us (-2.81)      13960.0 us ( 0.00)      13698.0 us ( 1.87)      14353.0 us (-2.81)      13829.0 us ( 0.93)
RW      1  64K    16    CLAT  99         3064.0 us          2966.0 us ( 3.19)       2802.0 us ( 8.55)       2769.0 us ( 9.62)       2966.0 us ( 3.19)       2999.0 us ( 2.12)
RR      1  64K    16    CLAT  99         4146.0 us          4293.0 us (-3.54)       4178.0 us (-0.77)       4178.0 us (-0.77)       4228.0 us (-1.97)       4293.0 us (-3.54)
RW      1   8K    32    CLAT  99         1287.0 us          1352.0 us (-5.05)       1237.0 us ( 3.88)      1500.0 us (-16.55)       1369.0 us (-6.37)      1467.0 us (-13.98)
RW      1   8K    32    CLAT  99          766.0 us           783.0 us (-2.21)        766.0 us ( 0.00)        766.0 us ( 0.00)        766.0 us ( 0.00)        766.0 us ( 0.00)
W       2   1M     8    CLAT  99        43254.0 us         43254.0 us ( 0.00)      42730.0 us ( 1.21)      43779.0 us (-1.21)      43779.0 us (-1.21)      45876.0 us (-6.06)
R       2   1M     8    CLAT  99        26608.0 us         26608.0 us ( 0.00)      27919.0 us (-4.92)      25822.0 us ( 2.95)      26346.0 us ( 0.98)      26346.0 us ( 0.98)
RW      2  64K    16    CLAT  99         5997.0 us          5604.0 us ( 6.55)       5473.0 us ( 8.73)       5538.0 us ( 7.65)       5735.0 us ( 4.36)       5604.0 us ( 6.55)
RR      2  64K    16    CLAT  99         6390.0 us          6521.0 us (-2.05)       6587.0 us (-3.08)       6521.0 us (-2.05)       6456.0 us (-1.03)       6456.0 us (-1.03)
RW      2   8K    32    CLAT  99         3490.0 us          3523.0 us (-0.94)       3556.0 us (-1.89)       3523.0 us (-0.94)       3490.0 us ( 0.00)       3523.0 us (-0.94)
RW      2   8K    32    CLAT  99         2147.0 us          2278.0 us (-6.10)       2278.0 us (-6.10)       2278.0 us (-6.10)       2311.0 us (-7.63)       2343.0 us (-9.12)
W       4   1M     8    CLAT  99        89000.0 us         90000.0 us (-1.12)    100000.0 us (-12.35)      91000.0 us (-2.24)      92000.0 us (-3.37)    109000.0 us (-22.47)
R       4   1M     8    CLAT  99        57934.0 us         45351.0 us (21.71)      54789.0 us ( 5.42)      52167.0 us ( 9.95)      57410.0 us ( 0.90)      54264.0 us ( 6.33)
RW      4  64K    16    CLAT  99        23462.0 us         22938.0 us ( 2.23)      23200.0 us ( 1.11)      23200.0 us ( 1.11)      23200.0 us ( 1.11)      23462.0 us ( 0.00)
RR      4  64K    16    CLAT  99        17695.0 us         17957.0 us (-1.48)      17695.0 us ( 0.00)      17695.0 us ( 0.00)      17695.0 us ( 0.00)      17695.0 us ( 0.00)
RW      4   8K    32    CLAT  99         6194.0 us          6325.0 us (-2.11)       6325.0 us (-2.11)       6325.0 us (-2.11)       6194.0 us ( 0.00)       6259.0 us (-1.04)
RW      4   8K    32    CLAT  99         3916.0 us          3884.0 us ( 0.81)       3916.0 us ( 0.00)       3884.0 us ( 0.81)       3851.0 us ( 1.65)       3949.0 us (-0.84)
W       8   1M     8    CLAT  99       213000.0 us       309000.0 us (-45.07)    309000.0 us (-45.07)    292000.0 us (-37.08)    305000.0 us (-43.19)    288000.0 us (-35.21)
R       8   1M     8    CLAT  99       148000.0 us       169000.0 us (-14.18)    163000.0 us (-10.13)     161000.0 us (-8.78)      84000.0 us (43.24)     155000.0 us (-4.72)
RW      8  64K    16    CLAT  99        42730.0 us         42730.0 us ( 0.00)      42730.0 us ( 0.00)      42730.0 us ( 0.00)      42730.0 us ( 0.00)      42730.0 us ( 0.00)
RR      8  64K    16    CLAT  99        32900.0 us         33162.0 us (-0.79)      32900.0 us ( 0.00)      33817.0 us (-2.78)      33817.0 us (-2.78)      33162.0 us (-0.79)
RW      8   8K    32    CLAT  99        11731.0 us         11731.0 us ( 0.00)      11863.0 us (-1.12)      11600.0 us ( 1.11)      11731.0 us ( 0.00)      11731.0 us ( 0.00)
RW      8   8K    32    CLAT  99         7177.0 us          7242.0 us (-0.90)       7242.0 us (-0.90)       7242.0 us (-0.90)       7242.0 us (-0.90)       7242.0 us (-0.90)
W      16   1M     8    CLAT  99       667000.0 us        676000.0 us (-1.34)     667000.0 us ( 0.00)     718000.0 us (-7.64)     676000.0 us (-1.34)     684000.0 us (-2.54)
R      16   1M     8    CLAT  99       384000.0 us        363000.0 us ( 5.46)     359000.0 us ( 6.51)     363000.0 us ( 5.46)     372000.0 us ( 3.12)     355000.0 us ( 7.55)
RW     16  64K    16    CLAT  99        62653.0 us         61604.0 us ( 1.67)      63177.0 us (-0.83)      63177.0 us (-0.83)      64226.0 us (-2.51)      62653.0 us ( 0.00)
RR     16  64K    16    CLAT  99        48497.0 us         49546.0 us (-2.16)      49021.0 us (-1.08)      48497.0 us ( 0.00)      50594.0 us (-4.32)      47973.0 us ( 1.08)
RW     16   8K    32    CLAT  99        21000.0 us         21000.0 us ( 0.00)      20579.0 us ( 2.00)      21000.0 us ( 0.00)      21000.0 us ( 0.00)      20579.0 us ( 2.00)
RW     16   8K    32    CLAT  99        12518.0 us         12518.0 us ( 0.00)      12387.0 us ( 1.04)      12387.0 us ( 1.04)      12387.0 us ( 1.04)      12649.0 us (-1.04)
W      32   1M     8    CLAT  99       877000.0 us        927000.0 us (-5.70)     894000.0 us (-1.93)     902000.0 us (-2.85)    969000.0 us (-10.49)     877000.0 us ( 0.00)
R      32   1M     8    CLAT  99       477000.0 us        477000.0 us ( 0.00)     468000.0 us ( 1.88)     464000.0 us ( 2.72)     472000.0 us ( 1.04)     485000.0 us (-1.67)
RW     32  64K    16    CLAT  99       102000.0 us        104000.0 us (-1.96)     102000.0 us ( 0.00)     102000.0 us ( 0.00)     105000.0 us (-2.94)     101000.0 us ( 0.98)
RR     32  64K    16    CLAT  99        78119.0 us         79168.0 us (-1.34)      79168.0 us (-1.34)      79168.0 us (-1.34)      82000.0 us (-4.96)      78119.0 us ( 0.00)
RW     32   8K    32    CLAT  99        43000.0 us         44000.0 us (-2.32)      41000.0 us ( 4.65)      38000.0 us (11.62)      40000.0 us ( 6.97)      37000.0 us (13.95)
RW     32   8K    32    CLAT  99        23987.0 us         22414.0 us ( 6.55)      21890.0 us ( 8.74)      22152.0 us ( 7.64)      22938.0 us ( 4.37)      23200.0 us ( 3.28)
W      64   1M     8    CLAT  99      1636000.0 us       1620000.0 us ( 0.97)    1703000.0 us (-4.09)    1620000.0 us ( 0.97)    1737000.0 us (-6.17)    1687000.0 us (-3.11)
R      64   1M     8    CLAT  99       927000.0 us        885000.0 us ( 4.53)     944000.0 us (-1.83)     894000.0 us ( 3.55)     927000.0 us ( 0.00)     936000.0 us (-0.97)
RW     64  64K    16    CLAT  99       199000.0 us        197000.0 us ( 1.00)     197000.0 us ( 1.00)     205000.0 us (-3.01)     207000.0 us (-4.02)     184000.0 us ( 7.53)
RR     64  64K    16    CLAT  99       157000.0 us        159000.0 us (-1.27)     161000.0 us (-2.54)     159000.0 us (-1.27)     163000.0 us (-3.82)     155000.0 us ( 1.27)
RW     64   8K    32    CLAT  99       100000.0 us        101000.0 us (-1.00)      94000.0 us ( 6.00)      94000.0 us ( 6.00)      88000.0 us (12.00)      87000.0 us (13.00)
RW     64   8K    32    CLAT  99        47449.0 us         47973.0 us (-1.10)      46924.0 us ( 1.10)      47973.0 us (-1.10)      45876.0 us ( 3.31)      47449.0 us ( 0.00)
W     128   1M     8    CLAT  99      2903000.0 us       3004000.0 us (-3.47)    3171000.0 us (-9.23)    3071000.0 us (-5.78)    3138000.0 us (-8.09)    2970000.0 us (-2.30)
R     128   1M     8    CLAT  99      1854000.0 us       1770000.0 us ( 4.53)    1720000.0 us ( 7.22)    1737000.0 us ( 6.31)    1687000.0 us ( 9.00)    1905000.0 us (-2.75)
RW    128  64K    16    CLAT  99       422000.0 us        363000.0 us (13.98)     376000.0 us (10.90)     418000.0 us ( 0.94)     430000.0 us (-1.89)     405000.0 us ( 4.02)
RR    128  64K    16    CLAT  99       347000.0 us        342000.0 us ( 1.44)     363000.0 us (-4.61)     355000.0 us (-2.30)     342000.0 us ( 1.44)     355000.0 us (-2.30)
RW    128   8K    32    CLAT  99       201000.0 us        203000.0 us (-0.99)     194000.0 us ( 3.48)     190000.0 us ( 5.47)     192000.0 us ( 4.47)     199000.0 us ( 0.99)
RW    128   8K    32    CLAT  99       101000.0 us         95000.0 us ( 5.94)     101000.0 us ( 0.00)     101000.0 us ( 0.00)     101000.0 us ( 0.00)     101000.0 us ( 0.00)
W     256   1M     8    CLAT  99      5671000.0 us       5738000.0 us (-1.18)    5336000.0 us ( 5.90)    5537000.0 us ( 2.36)    5805000.0 us (-2.36)    5805000.0 us (-2.36)
R     256   1M     8    CLAT  99      2970000.0 us       3037000.0 us (-2.25)    2903000.0 us ( 2.25)    3171000.0 us (-6.76)   3440000.0 us (-15.82)    3004000.0 us (-1.14)
RW    256  64K    16    CLAT  99       793000.0 us        760000.0 us ( 4.16)     676000.0 us (14.75)     835000.0 us (-5.29)     869000.0 us (-9.58)     735000.0 us ( 7.31)
RR    256  64K    16    CLAT  99       760000.0 us        651000.0 us (14.34)     667000.0 us (12.23)     827000.0 us (-8.81)     760000.0 us ( 0.00)     684000.0 us (10.00)
RW    256   8K    32    CLAT  99       435000.0 us        418000.0 us ( 3.90)     439000.0 us (-0.91)     439000.0 us (-0.91)     418000.0 us ( 3.90)     422000.0 us ( 2.98)
RW    256   8K    32    CLAT  99       211000.0 us        203000.0 us ( 3.79)     197000.0 us ( 6.63)     201000.0 us ( 4.73)     201000.0 us ( 4.73)     199000.0 us ( 5.68)
W     512   1M     8    CLAT  99     11476000.0 us      10671000.0 us ( 7.01)   10000000.0 us (12.86)   10939000.0 us ( 4.67)   10939000.0 us ( 4.67)   10939000.0 us ( 4.67)
R     512   1M     8    CLAT  99      6007000.0 us       5873000.0 us ( 2.23)    5738000.0 us ( 4.47)    5738000.0 us ( 4.47)    5873000.0 us ( 2.23)    5604000.0 us ( 6.70)
RW    512  64K    16    CLAT  99      1485000.0 us       1469000.0 us ( 1.07)    1536000.0 us (-3.43)    1435000.0 us ( 3.36)    1552000.0 us (-4.51)    1485000.0 us ( 0.00)
RR    512  64K    16    CLAT  99      1351000.0 us       1234000.0 us ( 8.66)    1301000.0 us ( 3.70)    1200000.0 us (11.17)    1267000.0 us ( 6.21)    1234000.0 us ( 8.66)
RW    512   8K    32    CLAT  99       793000.0 us        810000.0 us (-2.14)    885000.0 us (-11.60)     793000.0 us ( 0.00)     818000.0 us (-3.15)     827000.0 us (-4.28)
RW    512   8K    32    CLAT  99       414000.0 us        393000.0 us ( 5.07)     426000.0 us (-2.89)     397000.0 us ( 4.10)     414000.0 us ( 0.00)     418000.0 us (-0.96)

==================================================================================================================================
--
Thanks and Regards,
Swapnil

> If that doesn't crash, I'd love to hear how it affects the perf regressions
> reported over that past few months.
> 
> Thanks.
> 

