Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC75E62C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiIVMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIVMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:50:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE7E05FE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWC5R/NoKG84bcgCVNBzJq4BtSK54OSyc+dsIkfrLWWGIVFaTR2GH6M6nlRPiLobzLkZ/aJI39c5RFv9OObXV7nLCQNzBxab9/y4gqpvgkftIlOiyvTzInTwkomhPh3ZdWz3kjW+EtOrpTOHvaP5hNrFariPGQK+Eg6ad+SLbpaTbNZ3BlYQVRWRkhlOfIVDVs44CW9SZeMXAwYJPhuIgkO1bx24qqfQEzhzDXVC1fzpmFecU+znrFzjTfzbgY3FdnRnfkC1FmKiVnLg0Ka3102RcFbeYtTfxiPl7Rk9PllBGcMiloVFZrDutcabB2GcElIdYho3yU+sJCspYTwacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQvDjuhBEVCv6w+w6kOaYyJczvg1Vnm7oyQv4o1ulTk=;
 b=XlRqDrCXp8Rg5+sWEv5Fhnjbe+napmQBSHa7TvLiUEwE+yIPtxYz2rS/gcLGWLZWKF4c3Y86zlejB0QzENEyzXPCcmCAJcMVpaGbYRl3EVQ4M05HI8CFi9/SIXllBeKHynTPyt0caNf2KygJjMPXMyfy+tA1OrBS+rOTq+x3lzRN5avcKWjJ87nU40zxoiz21YDjKT8i9TInykpLhPaFy1p+dLDlkJNpLOYw0Rj2Hchh7+HLORidSLZGip4fxJu01WP0bkrg1CQ5WVD8FWgtkO2cOdaXn05ACq5x5+BbetSO+xPTJiR+x5exLSI9HiXRkX+YEW9w65Uzpjp3Qv0asA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQvDjuhBEVCv6w+w6kOaYyJczvg1Vnm7oyQv4o1ulTk=;
 b=Y9NXmpxZAOtrN7RTDjr2UJ6zpPJMBnkpJCy0oOULTKUrskYITEWdCn6ZYaGKWi5nx+9P2l/TFjSGRl3KoH3H00XVlC4XvUWZlIQS3vYboGJoUObj3WDf2XJNpC2D4o4/GiOf3OZJc4gVHxZ0HTZlHLFGahsT6lZI6TUhECLIf2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 12:50:41 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::94bd:ece7:2685:a44a]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::94bd:ece7:2685:a44a%3]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 12:50:41 +0000
Message-ID: <477e50ab-9045-0ca2-6979-e2dca71be263@amd.com>
Date:   Thu, 22 Sep 2022 18:20:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20220921060616.73086-1-ying.huang@intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220921060616.73086-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf2c89d-2dea-4043-9046-08da9c990e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8VrrOQFDp11B7e0yJdpXKXtBRMmy04oAwdjG9cVpGtlbb1EsRkikHBP+zTs2WqIGDxGpuEF8xg3MvfEYn6/mM5KWUDdk45yoS55243cEjrzANhZN8fbGBhrZnrG54HZN2AZwn2pZc+4HCpPzqUT9UKqqyB0Mg6MSGSe2rnwRu+LJeazd+benY05E1Mh+IaZ2bzSF2FtQmu1vKVwhU5b4JEI6hEjNXDquowQ2/y8eRHAlIayS9P+J2Fi4PqKXWJMQ5wm7za5NIRurAL352auZaTWRuX90KXEi87QiLiftDz5plfXAU38GgFrMEPok4lQ1P6NWRTwb32FEK3TuLFSOa3bDenzKQvxluLZXyoEmRimJUCzhdDOO8latmCs38hNP7kvoyeHfNczu1aef0ADM27qFwaj+/U4tBqyPF+5hYHuR3sCoExyfWQid6opqjJ/K/wcs4VpzXe1aZXJiVGzWszChaT6DFPwbyIMjnhAgWEoS8O7IpGtBakboD4oPsUVkGR8lPpRF39mWpX8xOrZOLRmBMTz98np2Dc8vI+5ZSTfb8FmAkOx4pBYnDcR9nBkoAluJiyqw75LkkwC6hJ7loTvtv7bDzNN29VwEorVNQVRC6NoPNCWiqLSMkaMnwCx7n4AySjC5ltuqTjJQSEP+d1zDZi21BuTa3Idr5tdkTiRzGegn5bLQZWSeqqZi6l7SkYzNyrmCRIF7VkwXvnsCvxoDkSN7mfK+mgYzsmq+FxOFdAbJ1sH7k113DeoPzp5FjsWozXTURzlWmb7pRSp73LmAa2emJj1LkLrSfrIT4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(478600001)(6486002)(54906003)(66899012)(31686004)(5660300002)(6506007)(8936002)(26005)(316002)(53546011)(6512007)(66946007)(186003)(2616005)(4326008)(66476007)(8676002)(6666004)(2906002)(66556008)(83380400001)(41300700001)(86362001)(31696002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1WTklobjRGV0pHUXRVdnRpZjlJREpUUVY3L0VQZFgrL0dCLy9NQ0FJT0Zz?=
 =?utf-8?B?MDY4TkNWRXI3MTRMR3hrR2V1Tm1uREdJL3YxVzFOMXRXVGNweDYxZlZZbUtP?=
 =?utf-8?B?bFNub3RWVU1MMlBNOVdJd1NpTzZGMlF5a1QvMzNJd2lqYWk5cll3QlRvRVBD?=
 =?utf-8?B?NXNpUjBSUlgxZEFHeWRzdVdib1RZdkszYzI2S0NvbXNVc0RCRnpNVmtGNTZT?=
 =?utf-8?B?YUJsY05GNCtzbnpoNFlHdEhFc1dIUzVIVlBTQ0oyRCtVbXJJVXpNeFl6VlZw?=
 =?utf-8?B?S3R2TjYwVzEvcVFsdWpMcW5OT2lYeVRSYllPOWhMYzFiSzNEWCt3OUFTVFlR?=
 =?utf-8?B?TGlEVjJFcE1qaDM3N245T2hzRmJveGxMQXoyWG8xQjNyY0ovQ080bFFVRERn?=
 =?utf-8?B?U0ljZHNGTEk1SE42ZFJQZWFBMVdTSW5UdEdCUXZYWXRYQnBUczVZSHRUN2pm?=
 =?utf-8?B?M1AwTnpyWUk3QWlSWEhNWTh3cCtFd2V5aVhXcjUxcmJpYW4yRlZPN3FEUGVr?=
 =?utf-8?B?UVMxVXRFempaQVppNngxeUQvUDBVWHNKSGZwS2lNMXlzaVJ2MTljMWlPdzRx?=
 =?utf-8?B?NTNtTWZlU0hOKzVwM1RrK2pMeS9GNkltVGNHbExUSHhLTXNWN0taaGxkcUJ6?=
 =?utf-8?B?SjNYYmpXOU9aZHBYVlhickF0TFJZOHpQeUtHL21VYmRURTVIM1ZWbDBaWFlU?=
 =?utf-8?B?RmtmU1Y4cVRqKzB5YTJTTW4vV2dGN01ySUtYTXEvSDgySDArTVFnMEZaU3Q3?=
 =?utf-8?B?cjduV1NJOUd3WkRUOEpSL0ZoVVE2OXlOOTJvL3BSNTk1cG4xWlgzWmczS3Y5?=
 =?utf-8?B?TDVmeW1NNWNIdGNaL0lvL3o1NWx3VUM0RG11TVl2WVpTU0kyU2ZGODUxU2hV?=
 =?utf-8?B?Y0Q4ZGgxRWZLODluc2piSUlMcE5QS2JaNGU3Tnhqa284Si9oOVJOSE5GblY0?=
 =?utf-8?B?ekNmWWhYaW1WbHNwOUdaZFltajBzZXRvLytNR1FKSEdkaFNhV2VWR3BXOWhR?=
 =?utf-8?B?U1c5TTFyK081eXRGV2k3RjhyTWw3ZXVlMm8wZkFCTW1ZbkFLMWx0SHNoYWt2?=
 =?utf-8?B?U0FTUytZa3Q2ejBaMjg4eSt3SUlldmozNHVmeUlvc0ZmZmNzZ3cvWW01b1gy?=
 =?utf-8?B?NHF5WTd0QzJObmsvVDBMcVFXa3kvWGRMbUE3czg1SEVxUU5UUjRCSnJFTnJz?=
 =?utf-8?B?N0NTak5xRmxBK3lFbmt1ZjVycHNkQVJKUTdGZy9Na3I1RTJyVEdnNDJuYWJm?=
 =?utf-8?B?R2tLOS9mbm16M2xYQWZYeDMyL21tTm9wOWlOMFRvME9IUm5CTDdNL29UUS85?=
 =?utf-8?B?OWZpWllBSTNrbHpkQmpzeWsySDVYK2ZJTllsUklEeEJTWHdDTlBhK1dvT3R6?=
 =?utf-8?B?QzFXU1RTVjhYd01GdmVZb2pkOElnd1BiUThjWE9KU2tCYk4wdXRodTRZN0pt?=
 =?utf-8?B?MVhIMEtKaTBGam5VWjFsMW9ERDNSeit1OUtzSkR4WW5BeVBYYjh5NVhGTWlE?=
 =?utf-8?B?aDM4QjNFTGhSaUJjV1lpeUxpTnpybjVyVTArSmZpNk9XTzJHSVVwWGw1Z0xq?=
 =?utf-8?B?VzVqRGtzSCtTMVZqTUtMZndieS9JVjJlUTJWcWF0ZFJBaWp3dzgvTkpVWDRM?=
 =?utf-8?B?QTdjbHVHK1YvWjBlRnlDSG56YW9aVkQ4NUdFbk9LWVNZaGpXazMwNjNHQ3lK?=
 =?utf-8?B?T1EwS3o5U3Y3dWlOclFDbm0wcVFvYTZPajNhRE82NWliZFc4UUFZMWFKRUs1?=
 =?utf-8?B?MDhWMXJ3c2c5UHZ1UGNuNTk5ZmFmaXZ3Umx6VU5OTWN6UGRIUXVvMjhzczl2?=
 =?utf-8?B?UW4yR016cUdjTVdPN1BpTmhnWVNRYVFOVnpOellqTnVFbjJMK1FRZlBrdFZV?=
 =?utf-8?B?Z2tZSHZkV1Q1NkR4b05tT0lKWUlJOUVIU1dseFZwVHN1blVDMmZyaVZuais3?=
 =?utf-8?B?b0tZS2haVm9sSjBDTFpXRGRENWNVU1BOSUVIcGl4cUtUY1J5anhuQVNtaEh6?=
 =?utf-8?B?dHdQYmk2ajM5N1JwOWh0enA5MXhXS1pORFh1czE0M2hyYXhNZnpaM0xyRDJt?=
 =?utf-8?B?WWlWcDZjdDI4cnpGZElMc1hrNXVURkt3UERNbW1XeUtMUWs4RHQ4dk5DdWlm?=
 =?utf-8?Q?Qo/+AAKY3ReU32guzzSGGYnj8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf2c89d-2dea-4043-9046-08da9c990e3c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 12:50:41.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DXLpkwK8ZLEcBKDJ0dgBgjOyVmw/yDSCSk9moq3oFcz8yC75oeEYQZQ0/vLImc/8EtNWuJoZRi4kyrWgoyOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2022 11:36 AM, Huang Ying wrote:
> From: "Huang, Ying" <ying.huang@intel.com>
> 
> Now, migrate_pages() migrate pages one by one, like the fake code as
> follows,
> 
>   for each page
>     unmap
>     flush TLB
>     copy
>     restore map
> 
> If multiple pages are passed to migrate_pages(), there are
> opportunities to batch the TLB flushing and copying.  That is, we can
> change the code to something as follows,
> 
>   for each page
>     unmap
>   for each page
>     flush TLB
>   for each page
>     copy
>   for each page
>     restore map
> 
> The total number of TLB flushing IPI can be reduced considerably.  And
> we may use some hardware accelerator such as DSA to accelerate the
> page copying.
> 
> So in this patch, we refactor the migrate_pages() implementation and
> implement the TLB flushing batching.  Base on this, hardware
> accelerated page copying can be implemented.
> 
> If too many pages are passed to migrate_pages(), in the naive batched
> implementation, we may unmap too many pages at the same time.  The
> possibility for a task to wait for the migrated pages to be mapped
> again increases.  So the latency may be hurt.  To deal with this
> issue, the max number of pages be unmapped in batch is restricted to
> no more than HPAGE_PMD_NR.  That is, the influence is at the same
> level of THP migration.

Thanks for the patchset. I find it hitting the following BUG() when
running mmtests/autonumabench:

kernel BUG at mm/migrate.c:2432!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 PID: 7150 Comm: numa01 Not tainted 6.0.0-rc5+ #171
Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.5.6 10/06/2021
RIP: 0010:migrate_misplaced_page+0x670/0x830 
Code: 36 48 8b 3c c5 e0 7a 19 8d e8 dc 10 f7 ff 4c 89 e7 e8 f4 43 f5 ff 8b 55 bc 85 d2 75 6f 48 8b 45 c0 4c 39 e8 0f 84 b0 fb ff ff <0f> 0b 48 8b 7d 90 e9 ec fc ff ff 48 83 e8 01 e9 48 fa ff ff 48 83
RSP: 0000:ffffb1b29ec3fd38 EFLAGS: 00010202
RAX: ffffe946460f8248 RBX: 0000000000000001 RCX: ffffe946460f8248
RDX: 0000000000000000 RSI: ffffe946460f8248 RDI: ffffb1b29ec3fce0
RBP: ffffb1b29ec3fda8 R08: 0000000000000000 R09: 0000000000000005
R10: 0000000000000001 R11: 0000000000000000 R12: ffffe946460f8240
R13: ffffb1b29ec3fd68 R14: 0000000000000001 R15: ffff9698beed5000
FS:  00007fcc31fee640(0000) GS:ffff9697b0000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc3a3a5000 CR3: 000000016e89c002 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 <TASK>
 __handle_mm_fault+0xb87/0xff0
 handle_mm_fault+0x126/0x3c0
 do_user_addr_fault+0x1ed/0x690
 exc_page_fault+0x84/0x2c0
 asm_exc_page_fault+0x27/0x30 
RIP: 0033:0x7fccfa1a1180
Code: 81 fa 80 00 00 00 76 d2 c5 fe 7f 40 40 c5 fe 7f 40 60 48 83 c7 80 48 81 fa 00 01 00 00 76 2b 48 8d 90 80 00 00 00 48 83 e2 c0 <c5> fd 7f 02 c5 fd 7f 42 20 c5 fd 7f 42 40 c5 fd 7f 42 60 48 83 ea
RSP: 002b:00007fcc31fede38 EFLAGS: 00010283
RAX: 00007fcc39fff010 RBX: 000000000000002c RCX: 00007fccfa11ea3d
RDX: 00007fcc3a3a5000 RSI: 0000000000000000 RDI: 00007fccf9ffef90
RBP: 00007fcc39fff010 R08: 00007fcc31fee640 R09: 00007fcc31fee640
R10: 00007ffdecef614f R11: 0000000000000246 R12: 00000000c0000000
R13: 0000000000000000 R14: 00007fccfa094850 R15: 00007ffdecef6190

This is BUG_ON(!list_empty(&migratepages)) in migrate_misplaced_page().

Regards,
Bharata.

