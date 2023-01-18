Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC26712B1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjAREnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAREnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:43:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09643552BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:43:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gxl7imkfepMVqx5sVVLe0z4eglMpder8twDjcRgbDWyNkdroZQAMnAAnsh1dslwV9gUApMqxgwKmyZxATVxHCSr4R3xa4XwgLORrt8ym6ePbFBqAn1vDu+bFYW4lMSyduC95wW+41CDXylakFD7F31nbagadz6/VmNSWsQTyiEVFZOBOP+hm9v3xCyxj2EPcJ47GT9b6/K2CRCFjA/lE7LgwJRQMQ2ybRuWQZAAOypDbPsiIwwQgqeLsi7tyds1g//q9dnujXfQwaNZDX4KTY+L1XS+D4ahBDXUlQR/AkqA1XBTiu0sae3kPC8NJhHT+qOemFCwSzAluoJ+bVL1QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bGQn/ggPaSmGMaHYKe3UYyqXYfGhTTVKzvcFMkYIjM=;
 b=eBe7RK6TGb0ZWuEJjwKg0aNaRbtrsbJKUxvYPeN3uV+hUqBBBLlDBJziS+o3JO3Xsug8G7Aj0BoPZ5A7RiTbmHl5Le9usu62vLxA1nN8vfnDMJXiXPFSflAfB117sB2wUpa9VAo5dSaXYBG9IJJDvQfF63dvBI7qx3R9ApU28L/pSbXFUTL7cR0UN03lIiMNtAoXXU1Sko2ALgx6QU+qKgBHYXqHB8QZ4jPSWzErzzwqT5gl7vJoqAIdrRm5gvJavYfe1K9r+YhYr4QcJ+Q6w7JXHjwKSTcPzeDCZ61VQr1t4UCFRCiEiTXxaTA8x/F7GxYH1ONf2il196Lg3mt7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bGQn/ggPaSmGMaHYKe3UYyqXYfGhTTVKzvcFMkYIjM=;
 b=JQs06JQ+eKh1x2AFjj3DNvi7tf0h4irDVb3eIxj3wReHhHz197kw7sA1w6ofS8E0bWk+2RNV4IUccpSJiYxq9g9xLGWvx48Bh/zNHRJ2zNvgZtYz3q7QdRsw6lCCFiWvwGbhvZCeEWEB9D9ueoG73nalVS9LXyYf+Yt1lzjxuuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 04:43:35 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::7d0f:f507:40d3:902b]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::7d0f:f507:40d3:902b%6]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 04:43:35 +0000
Message-ID: <933d1843-be6c-cbd4-ffb2-b0adcbeeccd5@amd.com>
Date:   Wed, 18 Jan 2023 10:13:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>,
        Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Sean Christopherson <seanjc@google.com>, jhubbard@nvidia.com,
        ligang.bdlg@bytedance.com, "Kalra, Ashish" <Ashish.Kalra@amd.com>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
 <20230117145951.s2jmva4v54lfrhds@suse.de>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20230117145951.s2jmva4v54lfrhds@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: bec2b5dc-c7fc-4160-e3e9-08daf90e8ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1cmyNCAQXbIs3g3Wh37o6hcgk6VcvNYP5ghyYL7KfX3n0UwZcaa7nWDEAHXQEZjURn58QAIHk/8WPegSaEmWVAzJ5F8Bqd7GKJ5pkIi5pHqycQLXcGIOzqkCz957LHAKyQW8phoETu0Wvq8x8YX73mNJGaVGhCLPKqiM4ookR1SjUHvZK2B999TLVM3FLlFj9XC6zOtVyZYhfnGWVbSWc/QFbyAlIiExw/4WpzFh7Ur4gxNKxK2zPr7XRGujgmE4mbwnPB9n2kOgYVuIncQtIRMqNR7r3//ljXfaIZwTkTWfmlE/rJh39LehKPadDQG/dKKUY8FJ2uICFoixHpjZtcXSGcHDn7VMR8n7HEg4sbYcBCkTyBK7VBFF89ZL8f9vzwTdBzoQq2XQp2FkZueGukmuKa8bdV7nJD039VmijmXjwdD2Yn2zxPx8ByHybJj9JoAhuu+9QXwQj4KWe4AONSUfrsRR4yrSRBqMGNhBesOXJlO35F1vY63E0biUrztLleGaYbGTVt4m+VcLFjUuzFG3LsPNidt/6YBAe+k1g6CHqu5IhmPg7RKThxMXIc/chDSzfd3AzCUP58ssDXxS95S3fhsEiTPD+cdPtK3gxyyRwU2J5P3K4WfwRjSASmxnKOUCQdSAHyL8RaVXX0a6eygumVjtfO6fxqQJwIRkvbXkC5ZF/C78zjDhvqRT23lUYBMFy3h85If6HSXgtEU8zIGNGbppQd9CCNHHRlZSZo+VmStjkD9+Gard6pllUA6Chd8jQzGrWMWMi8cmN5oOKOAyBwMqTYhwAEcjRpVJz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(36756003)(53546011)(86362001)(26005)(4326008)(8676002)(186003)(6512007)(31696002)(66556008)(2616005)(41300700001)(66476007)(66946007)(316002)(6636002)(54906003)(478600001)(6506007)(110136005)(6666004)(6486002)(38100700002)(966005)(2906002)(7416002)(5660300002)(83380400001)(8936002)(31686004)(66899015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0R5cU14ZlhnMitBRG9LR2k2ajJZN29nbHg5VHArN3dCSmp6TW4rcWF6TGVh?=
 =?utf-8?B?UlpicUxuMjliNi94VDNESnFFUFpQTitTVzhxYldLU1o0VmZjU2pmcEJ1SGx5?=
 =?utf-8?B?dDZQekc5TDVLL0FRSi8wZGcwRDkvN25hR1NyUmdFN00zV0xwanlxc3pkZExW?=
 =?utf-8?B?TEt2SS9VTXpDaWQvTDVoYlBxaHVYRFZQaHdLVHBCRTRBMlRQTUhjQjhLNWtj?=
 =?utf-8?B?OVZBZGF0Zmp3R0owMUNONm1QSXJOTk5QNXgrQnpZZlZ5eG1zemY4VmNGdUZl?=
 =?utf-8?B?d1FTbFQrSnlVMjZaVkVwZE92RDlyRjMrWHNRSjdEN1NaUitqdmZCN0tvYUd2?=
 =?utf-8?B?VmFUNmQ0Y0FyaWlyWkt3RE43ZXdTVFBvZWV3MFA0dG9oc3pSQWFTczd6OHI4?=
 =?utf-8?B?T3N2Z3VWNWFCNkdWVnBjRkdYU0FGYitUdUM5SUVOT25xMXB6eU9MTTVHaE9M?=
 =?utf-8?B?aU5FNHhlVGpqeCtVVHNsMk9lUDdNckVuZ1NUSXNFT3F5VDhoQlg1Yit3c1ph?=
 =?utf-8?B?bW1mRU40UllRMUd4dEJ3cVB2K1BzVlFRN01LMHBaWHQvVTQ5cjZiOWRGb2pw?=
 =?utf-8?B?NDhzVXZaSllGLzRKN2hWT296RjNjV0lFUjUwTU1lejdsN1FyTE02cjhFTnM2?=
 =?utf-8?B?Q0JjWEZZTGxCSDBVTmE0Q093RUpXZndYeVNnVklXVDZqeGhyRmtVODhOdnQz?=
 =?utf-8?B?bWhUUGp1bzNVMWpRWURrYVE3eEhKUzd3QVlZZlpBY3kwYmFvQXZyYm9pRVZR?=
 =?utf-8?B?VyttMmF1c1RrRktwRzhWcitqYS90ekM0V0FRRXREbHkvYW80OUlwZlBUWDND?=
 =?utf-8?B?UXlrc2RLb3dEbVdDazYrT1U0c2NMWm9OazJ6clZ5R0ZBWHpBNytmMjByd3Ra?=
 =?utf-8?B?dEJvZzhTOUlBL0ZoNTZ2SjFNNFU5VGNrUGNuQStZdUF3b3ZNZGJYWHJnblZV?=
 =?utf-8?B?eVl5N3FqT0EzSHNCdVpnSGRNeDhCLy9tR0Z2WWQ3c1dPZjN4dVV6Nnk5aVdW?=
 =?utf-8?B?RXl3M2FZNzBwcmhmcnZYTml0eHZqbTZaMmVhdTlxY2VUTVduY3RmbXFnajNW?=
 =?utf-8?B?ZnlQR1d1Q1NWY3p5NjVuMzRzekZmTURqN0hhZ0QyQ2duSjJDZkxUTEozNHl3?=
 =?utf-8?B?RjloaFBxYjM3UUpBUmEwdnpKNVpseXRlN29MUzNqZWtVaGhoNFJXY21MTVdQ?=
 =?utf-8?B?blNVWjRtWXRRZE9KR3BxSmhUano1S2QvRzJVeExnSjRZQWFGdjdBZGNpWWFG?=
 =?utf-8?B?eHhRVDlJMGRQa1JKREFUajUvMGFDL1YwWWF3bXlka1JRTERneFZ4TWJIM2Y3?=
 =?utf-8?B?bkFKTjl4QWxQNG8xcUlPR0pIVzArM3BqOVltdWtlVTNiL1VmQ2Q1cC9lU3Uv?=
 =?utf-8?B?SGZPUDNlYzdXZU9VbE81d3RkNGR3ZHpScVZaTzRzanNjcFdUWTBoODA0Y3BV?=
 =?utf-8?B?YmFxMWJNaU5jdEc1d0pMOWN3bnhYcUM3a1FMNSt1K2d4YlhtZnA1Skd4NEU2?=
 =?utf-8?B?MnhOcTVmeTVuazdmWXlxVHdPdmQyUUNBNTBURWlOcUlpZVA3V0pvdlBLRllZ?=
 =?utf-8?B?K0lpMjZORWxSWjFUMll2L29EOVk1OVhTWmRwU3BaWjZPRXFBV1hoNHI4c1dz?=
 =?utf-8?B?Vk9zLzVxRTV1OXdOQlVuVjhGQ2FsZ2txNDBhNzc0bzVHTm5pb2VDcXJGUmlH?=
 =?utf-8?B?SkNicHNuSHZUZXpOdDA4ckRjYk9oekZDeW4zSDlmb2grRFE5dTlSOXZkaUo1?=
 =?utf-8?B?bDUyTGZjNCsybjVqYVBkc2FsbHd5enRlaHlnYXBuNm1CQ2pCRWhqaVJsMndk?=
 =?utf-8?B?OFRpTVRvZ0hFTSt6a2FqaEZqaSsybWZHbFkzc3J3VWZlakU1VGpXLzBkV1NS?=
 =?utf-8?B?R2hiZjVBKzB0aWlnOC8zTVZhRFlkYlUyUmxHK2toNldRMFExYWVNb1YyNzFQ?=
 =?utf-8?B?b2g2Q3RuWUJQNkFFdnl2Uk9Hbjh3L1RIZ3ZteDJPdWJ0VUNLWkpMcUcvOWtZ?=
 =?utf-8?B?UDNjNjBNaldwWERMdENEVHhiYXI0aE8zVUtadjloRVRpdWNvRGU5WElITysy?=
 =?utf-8?B?cWNNVlBVc2h5R1FqQmpkZlJQUmVhYlArcytaa2VjU0J6SWI1SEcyL1k0azh5?=
 =?utf-8?Q?SF6ocIsFZxDh3WYMgzWTjyIbw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec2b5dc-c7fc-4160-e3e9-08daf90e8ef8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 04:43:35.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXuysbpGP7XPhd8iNEcTCwxM582vGGOw/Qll8I6kf16Uezcc3ylZfwnFyjqm/tjtRly4u9yK+8l8JSZ46G889w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2023 8:29 PM, Mel Gorman wrote:
> Note that the cc list is excessive for the topic.

(Wasn't sure about pruning the CC list mid-thread, hence continuing with it)

<snip>

> 
> This is a build-tested only prototype to illustrate how VMA could track
> NUMA balancing state. It starts with applying the scan delay to every VMA
> instead of every task to avoid scanning new or very short-lived VMAs. I
> went back to my old notes on how I hoped to reduce excessive scanning in
> NUMA balancing and it happened to be second on my list and straight-forward
> to prototype in a few minutes.

While on the topic of improving NUMA balancer scanning relevancy, the following
additional points may be worth noting:

Recently there have been reports about NUMA balancing induced scanning and
subsequent MMU notifier invalidations causing problems in different scenarios.

1. Currently NUMA balancing won't check at scan time, if a page (or a VMA )is
not migratable since the page (or the address range) is pinned. It will go ahead
with MMU invalidation notifications and changes the PTE protection to PAGE_NONE
only to realize later that the pinned pages can't be migrated before reinstalling
the original PTE.

This was found to cause issues to SEV guests whose pages are completely pinned.
This was discussed here - https://lore.kernel.org/all/20220927000729.498292-1-Ashish.Kalra@amd.com/

We could probably use page_maybe_dma_pinned() to determine if the page is long
term pinned and avoid MMU invalidation and protection change for such a page.
However then we would have to do per-page invalidations (as against one time
PMD range invalidation that is done currently) which is probably not desirable.

Also MMU invalidations are expected to be issued under sleepable context (mostly
except in the OOM notification which uses nonblock verion, AFAICS). This makes it
difficult to check the pinned state of the page prior to MMU invalidation. Some of
this is discussed here: https://lore.kernel.org/linux-arm-kernel/YuEMkKY2RU%2F2KiZW@monolith.localdoman/

This current patchset where we attempt to restrict scanning to relevant VMAs may
help the above case partially, but any ideas on addressing this issue
comprehensively? It would have been ideal if we could identify such non-migratable
pages (long term pinned) clearly and avoid them entirely from scanning and protection
change. 

2. Applications that run on GPUs may like to avoid the NUMA balancing activity
completely and they benefit from per-process enabling/disabling of NUMA balancing.
The patchset (which has a different use case for per-process control) that helps
this is here - https://lore.kernel.org/all/49ed07b1-e167-7f94-9986-8e86fb60bb09@nvidia.com/

Improvements to increase the relevant scanning can help this case to an extent
but per-process NUMA balancing control should be a useful control to have.

Regards,
Bharata.

