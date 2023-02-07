Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B268CFA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBGGmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBGGma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:42:30 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF666EC73
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:42:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSOp/b8UnEE7t3KwCfTrc4YviuiImY+8bMy29rMbYm0sW8h++t4vCz++etYtZZa/8Cuu2/K+PSqyEJp05NoMrtjVqsvoQCkAyhkstAxfqy2VVN/5kq0Ah9Ou8MOP/unaq5W6Ly4iUr1MVskROzaY0yYok3NXTkkyTxsCATbwn0JTV426P92zEjJhlwVC4QhcRX6ISzSN8nrJ3hl34MUzfN6pQbE0O11MXqYzj5GGaB34/W39s+7x4jGybm/BNajMWSPpyPx3zevddm++C/V8yyEiIOhKkUvokRtyojXT1NHx1Y14nS60iEUO479W9KgOiHnqdDyodFqKmTggt28V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LGvZyfF0ACSeEjteCU6cNDyAuRlyi7Gj1zr+m4JgfY=;
 b=H0beTEu9E5HxnQHABegrrCX44FJ+et8MASHsBt0IpcbWajJ2866udft60HK5Ee/T9cTHyVMNqxjwLxN37xldogn6caPjVNj4hjJKv4dvHwoCW8httFCcIjccbiTzMooqA9MkdAMNOshB1G0ou444HEBsfOqGNb9jq2Fot4iaYMRanPt292mhcgbSl2xyR+2m0mhmV2Z5zJwBJ/0bZUPuU4NJo2apee5LfrxlZunNgTEcClk9O0waYEHxRZb6tbb5E2rAlJNhgePSnTtgA8EYVvk0vxnDf/DyWKDqXWL7mQdmjLTqRCphVG3gx8oX6ZFz9KLqWNGjpqNCRop7lNr0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LGvZyfF0ACSeEjteCU6cNDyAuRlyi7Gj1zr+m4JgfY=;
 b=mRJDWv7kAWvJBu0zOYE2Vg9QL8xEydX/x0dxiPz0eyuHHoP2iR39+h122GfblhC//eTKSEjtxTU5/+wMoCCCKNx1x62hbtjWzGS7KyG4XYP/I1X99FgPP1cKsPibg7Np7vX1TSyuI70XeaHmtcdYemXkGX7zq6VBnljgeQcp39I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 06:41:59 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 06:41:58 +0000
Message-ID: <ccba1a65-fe4f-89d5-a32b-2efba30a1350@amd.com>
Date:   Tue, 7 Feb 2023 12:11:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Content-Language: en-US
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
 <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
 <048964e8-179f-de7b-1190-831779d9911f@amd.com>
In-Reply-To: <048964e8-179f-de7b-1190-831779d9911f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::19) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d4188c-2e63-40fa-b8a0-08db08d668bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56HjtZlXR+nUsB2JV0JShhKCJRKVBuTo8TLVOS7r2VsjRmZX3uQDXhXaSSbtJcR3WLJkhfWbhmD7TEKu/L3UfTF+Xr9l/qsgvImLJNo+WXBn17F4Ewy59NZRLqo3zsY6IZiriNOJE0DVK8ZYFY+YY8YPKR8KWhW8FTZ0iK/jYoaRDV3cQLAJ9TuNcy5aQOEItIL2hfd0FT07EcO+ng+j6viBJIdGFBxlK85EG8mJfvd3YjwzlDjkDrXzdVbE2l7mManLFSimz5ZaGCF1tLmhuYL+hjv9Qt7Ci/NaRQAAJIuMadkwikY8/wu1r7QvZFbwNX/jm3eo/OSA4jiHuzjZmJwUFH4SqpohCsl76BEfTC1ZmZM4j342g4G5N4mJ9tiAIxiWank6P9cxz9bC63k3SqQpbl/pGSn20bvEGYeN08GQR3sxNwMAxJKJ3sH62XKnqpba6b9GByjqpcmrfnQVb128fSgd6ZaRj+5tSv9nUPeQDvLq6wVr5Q4ZjUDGIaFec20/gyOCqipHs8CeUN6FbxigDrMq6J+4b1Ivlvt2Ks/1Etbl5q5ClMIUI7CUWjjuQjbMGOZKSFpB1/ZUpC9xGwDP5dt8toYHa7GV4cSv3uBgl2OfK8SKNaLxE54BHR4+P47uPyokMNReAKMPsM8HiOeFxtRRve2ssRWJZU6hw04fiICrOEu65TjzxEJLu7a1W5mj+k0ARlmXL8Bjhc7qQ++4hKxSj89okSBE7smQrqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(54906003)(316002)(6486002)(6666004)(31696002)(6512007)(38100700002)(186003)(53546011)(2616005)(6506007)(478600001)(26005)(2906002)(5660300002)(83380400001)(36756003)(66946007)(8936002)(8676002)(4326008)(41300700001)(66476007)(6916009)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHd6RHd0VUZWN1FLeEhRZERpVURGVndWc001bnBUQ1kzNGxzMUxyZUpWaXRE?=
 =?utf-8?B?VFgwVDh0dGpMeTV0eEE0UnZ0Q3BBQkZqRG5xR09FMFVtL3UwaGFoZkNnZ2Q4?=
 =?utf-8?B?bUhUOEsrdyt2WW5oa1J2S0s1Y09qU0w4QWhRR2FDZXBuNnl5cHRSYmM4VWxz?=
 =?utf-8?B?dWd4alg0VGpXL0V5KzFoV3M0WDJEWFNxd1RrR2dsbEFJN09zVVduS3VtVnRI?=
 =?utf-8?B?UStmY0tsQkd0Q3k3aDUzcWlIWlRtZVNDM2NxU3RwREMzdmVuQTVkZnNQd1JN?=
 =?utf-8?B?WWxodk9zVU52QjZrYjN2aFh2L1NZaW5EOXVxR2kxdHdhWXRxYUE5aDNLKzE2?=
 =?utf-8?B?eXpBWnJMOURocTUxNlRuY3ZRVlNuR2JneTg4SHQ0WnlKUzhsaGpYZ2N4RGFM?=
 =?utf-8?B?UzBTOHF2TE5NdzR5a0lmYm9xQ0xIajBDVHVtd25Bdzk4SlVMcW85Y2hmRVhF?=
 =?utf-8?B?QWxXMjBveHlIYWVJN3lJbFV3cmVubGsvS3NKVHBHaGxoTG1neWJMQk16MVpZ?=
 =?utf-8?B?S1E3SCtGZmxVQkp1MGlELzd2VzdoeGhqZUFndnZDZ2kxN2thSEp6LzVnZFA0?=
 =?utf-8?B?T1Vxb1RKbklNZG84OEpLM20rTDRPb0sxSXQ4V1JTYUROZllGMHROUE1JUmNp?=
 =?utf-8?B?TGN3QW8yZjFneEUxVVJ5YUFxLzVCM1hBQ3RFMTFlNnFwcElwK3g5dFljYnZu?=
 =?utf-8?B?cHVyL3RtendwRExXSnhyaDVXU3dDclhsdGNCOUx6V1VrR1pJUGJQcklqQUkx?=
 =?utf-8?B?UXRKM05ZVnJSbFA2MEtUYWNvWGpxcDJHY29iK0VpQzJuekhkVUZiRGo2dVdR?=
 =?utf-8?B?VVc0d2NZR0F3aVdDaHRTSWMzOXNmWWZDOXBqN0VrdU9jQTBUSmdFUDROYk03?=
 =?utf-8?B?d05FRllFVHZhYTRkMXZZcG40ZUd1elhVUGY3Z3p2dzVYUEZRc2xIVk5IMmhx?=
 =?utf-8?B?Y3NiVUwxWmFqcXFJRGdqbk1Takdrc2hDY0RwVzAxQ040ek4xOS8xazJRV2xl?=
 =?utf-8?B?ZEl2NXhQUFlxSUR3UURqczhnTFJMMkREVmt1S2R5YkdSazk3NUswYklLVnBO?=
 =?utf-8?B?MGIrWm95WGJ4NjV0WmV0bWlza1JHWThsL0o3ZjRQTnE2MVF0VWpTRlJpUnkr?=
 =?utf-8?B?cWd3L05XaCtHczNZM2I4d0psZVNiK2xXRUdHM1Nwd1cyMWJ3bm11NERLTDQy?=
 =?utf-8?B?bEpSeFo1Vk0wODM2Wk0vbE9makY5TUVqU1ZicDBjSzVPUnRCTFJRMG1aVWs2?=
 =?utf-8?B?cVJibzV4UE1ldmduS1dQYTJYLzMzZjh3YkdROVA1SjY3d0VKeDFFWnpWMEVp?=
 =?utf-8?B?SDF0MkNqVlVjNWxna1c3YlBPYjdsZXhUM1F1V1g1WnI1eHQvRXBaV09mcXNS?=
 =?utf-8?B?MUh4KzZKbUo3ZHVudWQ5QlNSeWNzaEprbVdjTlgwZzdxMkowczRXeThNV1pX?=
 =?utf-8?B?VG1jb2tQZmV3SXU3NW5mQlJVK2JtbXFqZmZ4U1BxeWtmdFI3ZjBBUXBwTVhT?=
 =?utf-8?B?VmFJWkZzbHd4VVVGYlFNc29xNDE1ZzZqVFZhY0hRZzdsM3g2b2dNVDluQTNa?=
 =?utf-8?B?WjY1U3Y2MDdUcVZjMUIxbWpxTXI2cDhmbW9BQTVZNm9JYnY0TUtJZ3c3VURP?=
 =?utf-8?B?SWgzeXN1VzNhOXR0Z1p2TUpEbUUxVXRRemNrWEdPUlM4Uis4TTBCMUluT29J?=
 =?utf-8?B?QUk0WUhqK2ZxS25QaE4wY1JIb05mQURvVVhQTjNNejQ5YkxjTTRhSnQyZE45?=
 =?utf-8?B?RS9hY3lIcjlZQkkveEZEOGJycmxiQko0aDVoRzU3R25sSlR0STdZNXpmSHlG?=
 =?utf-8?B?WTEzMEtyOFR5czhtYjVMNDZxQlhQSVY3b2IzTXNQSXl1YnpIa3lBeE1rOTBH?=
 =?utf-8?B?cis3SU5VbkhSUndjZWxxWlBsV2Y3bk1tcENBMENOdlVza0tmVkUxclBrZWRl?=
 =?utf-8?B?WkgwRm1aMjNqb1kxdU1uOSt5MnF2bm5pTlZMMm9QTEU1N1d3Q0ZkRUhvVk4r?=
 =?utf-8?B?Nm9SdmhFVUMrZXVYYTNYbVVudkdUcTR3dmc5MnFINkZwVHU4TjRsWGgzTHdJ?=
 =?utf-8?B?MlUvcHBBTFVOQW50WE5UNjlnOHZwWmpkSlBFWStNVVUwTFRhcWk2KzJSL0VB?=
 =?utf-8?Q?37a3TtA8u8pg9us+FlJiyQnag?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d4188c-2e63-40fa-b8a0-08db08d668bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 06:41:58.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7BpkYiKcdrgG2X4ESBWxw9vxAV7EpI5U8k2xhSTlgURgbB6IAaFNGV66SynNdB9T6QccKypF6N2klXiC+Xjaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2023 11:44 PM, Raghavendra K T wrote:
> On 2/3/2023 4:45 PM, Peter Zijlstra wrote:
>> On Wed, Feb 01, 2023 at 01:32:21PM +0530, Raghavendra K T wrote:
[...]
> 
>>> +        if (!vma_is_accessed(vma))
>>> +            continue;
>>> +
>>>           do {
>>>               start = max(start, vma->vm_start);
>>>               end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
>>
>>
>> This feels wrong, specifically we track numa_scan_offset per mm, now, if
>> we divide the threads into two dis-joint groups each only using their
>> own set of vmas (in fact quite common for workloads with proper data
>> partitioning) it is possible to consistently sample one set of threads
>> and thus not scan the other set of vmas.
>>
>> It seems somewhat unlikely, but not impossible to create significant
>> unfairness.
>>
> 
> Agree, But that is the reason why we want to allow first few
> unconditional scans Or am I missing something?
> 

Thinking further, may be we can summarize the different aspects of 
thread/ two disjoint set case itself into:

1) Unfairness because of way in which threads gets opportunity
to scan.

2) Disjoint set of vmas in the partition set could be of different sizes

3) Disjoint set of vmas could be associated with different number of
threads

Each of above can potentially help or make some thread do heavy lifting

but (2), and (3). is what I think we are trying to be Okay with by
making sure tasks mostly do not scan others' vmas

(1) could be a real issue (though I know that there are many places we
  have corrected the issue by introducing offset in p->numa_next_scan)
but how the distribution looks now practically, I take it as a TODO and
post.
