Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A337666DE63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjAQNJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbjAQNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:09:20 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772832E69
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:09:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk1qH+udY7CGoOw5pTRUorM3OS4JJeaG+Zgb6hXnj2TH7aPiF5buekI8IPOxXsvVEWuO5/8SxizDQ4s9TjYGRGf7UejokImWUXQr27MeP2btoeDEGqqHmcf2yhFhIApjQp1zKg/xas+P2rrV2PrKztdsn8piS+SA8oLhwSEi11W4DNG4clzAQEThnivr7hcCkjdTgXMV4ysc/veBay+r1PUrWMBYlrM/R7raud849ueIiSNOJnVB6Dg40yk8WGyacf82ZmWWvyKtooD43PU8unWqhyo+sDUuKphHlWWxO8axsS4hSdoUuwqU+FUuqOW6WvM6jK1o7KdYFZ/LTZoCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZuspnIUaXA2rWqvAsmX3VX7oOtEFd1onPkm/U4w6sw=;
 b=S9HfMhNFBVkGx+JFlOVLhWgFvsDbJ95m7YK/5PbGFXM7ErGv4H9txs4AH+x661KA4W8oPgbcju3CmZyyOSoZEFCxI7QauRftBZ94Xk9p3llI6pwkSpSB7OypVlkTi9A86H9NPmrFZGM8u1E/SggkANfk7nZ8+u48kd98hRijb5ulHVawYhhKHn3sWWFzrpu8Atjs3DHsWO7u6E1NHwZSsGTHbKnWDcMVupBfF3ilLYRnWj1MYpCIRYWam2VmKSn12gLhhtKk1T9PJZ0gD77eZHxHupBUPkTYqjmz47MX9vrHdtxGt0FXhxZxk5Wc6iOUA4/5lP3DZ7Xf7j8gVOdVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZuspnIUaXA2rWqvAsmX3VX7oOtEFd1onPkm/U4w6sw=;
 b=MUhHB1fQK4U0exFV93qi8HHcm3UgYs+JKYJFkkzEXfP2dgKi1lFs2f79SHTFNTzFmv6Hr0WKb32Zzb9qGXpM5Zch8LbIyNwbTaiUB68O3/qtd6lz+KQAM5CEKuujP72s1M5QxbUSmRgjY0ay+O8jZ2jLj2muxXvmgvPft/2Vle4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 13:09:16 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 13:09:16 +0000
Message-ID: <06cb753b-f64f-3679-b365-fbf346cbf828@amd.com>
Date:   Tue, 17 Jan 2023 18:39:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, xu xin <cgel.zte@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Colin Cross <ccross@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
 <4ac11b6a-284c-c763-f3c6-45a53c272f47@redhat.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <4ac11b6a-284c-c763-f3c6-45a53c272f47@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::29) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b76618-8005-4983-e7ae-08daf88c08f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FG/I1yxHcavWBd//gnIYeNqH+YGW+8vnNWO/kjwBV7yTRT2fzLhlSISx+qdKPpfoFcTAylYIwiZ+076qKS8fE4ZImae2cG+ipTMr4MiSVxtfZRnX1/eRbiUvmQGb92zxBK2+Z8025nui3KqmDDgkNFI8XqKztv4oAuhR33m4il6xJIoVscfHQYMIXAVLlC8KgT/QbN3Rnr2R30jNb2FqGgwEVKHGb5Kx8aUkzQ+c64tdQJYGht5m/pl1Vk2n2/NaUK9mEp2Ce/OWUe8MCN5IfzhHCINM5IYic28REwDvd5rUhON5oLChEmRO8oFgQXjY7DN3CpkPIXt/0zlN8k2apEoPrnPAwLmqs+kyYhj0GqK7yhHLVf9D1vYgPW+1D19K3pZ/YKFjnXB+1booGN730+2ErAKia04kWbsONkIO9nY+FshOuOuyx3O2QNY820ZlkkSzl+rydKifWYpWxYr6hCt/7KAM7MkOvWXsfdSzFTJ6zriNfSbxRtklmRC7vWZUiFc8WhlW0KjjqQaWjWUhDh7anWKwvqLnHG25ja+7bab3fBw0fMEaPuX9TTFaILYrirYy/wrQWhsHwP0CQQzvsH0Bbn1GoCmOChnRe9hZikeVTI625MSjYh5SOeVuGoeA+WxHTf+tM9I99wcMNpAauVM+lPpDOrTbq2NOcxEGueoa1+NK7S7ZQqq9QKu1XoeemQ6ZfWCL+yF0oS/Cq4yaSa+ZhFWCsX9/bGlJTdov194=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(38100700002)(31696002)(83380400001)(7416002)(2906002)(5660300002)(66476007)(8676002)(8936002)(4326008)(66946007)(66556008)(186003)(53546011)(6512007)(6666004)(26005)(6506007)(2616005)(316002)(54906003)(6486002)(478600001)(41300700001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QitJYlNMeWRvWkVYN0E1azgwaURwZHhudm1ncGRVNXlDVERPa1hZSjhrM3k4?=
 =?utf-8?B?UnA4SWlDenRDaU16T3lCM0I2UTJuYy9WT3dyV2JMKzNkS3dFM21JVEEvWWhQ?=
 =?utf-8?B?cCs0cGsyQmxsM2RaM1Bud1lmSUJubkRLeU1NajcvbEdBU0xJWGo4YWxzeDUw?=
 =?utf-8?B?emUyVFhJVzhJQTFsbFB0UE13em4zd2N5aVlVOXNlSlM5USt6NHV2ejRQdWlX?=
 =?utf-8?B?OVM3SysxcWkxdFRwT25ibjNmUEZvYzk1cVNvbG1VOVNWZUV4TE9KN2RWMDlw?=
 =?utf-8?B?ekxRSDNXc05PYkVxNEJ4MHJMd2JTSm91bHBKUUNVSkhTZFhNeEdwUFFmbnQ2?=
 =?utf-8?B?SUpjMlNsekVYandOb0hFVUgzdStNNjY1ZE5IdXNFMWNXODlvY3ZkQXJUQmlj?=
 =?utf-8?B?VWExUTFXV3dYM1R4Y0J2UXNSUmViOWJlS0pIR0lxeUlHL01UOVRDeE8yQUJC?=
 =?utf-8?B?blZaSEpvbSs4bG5jN2tJOVNqZk9QTHNXVk5QVktaVzlIbmhDa2ZhZTdyMmwr?=
 =?utf-8?B?TTh6RlVlSnZPOWlsSlgrYUlJdHp5RDZPZS9OTW9yNW5xU3czemdiODJZTlBo?=
 =?utf-8?B?TGw5c2NaS1dsWVZ5blAxZHZqMnphKytqRnVsZEowNTB3M1JNckloZ0ZKTEUx?=
 =?utf-8?B?bnNsZGdwU3NCbldHN2VPYmdiYmFxVDhHMmNWNDFSQ200MC9sWTBwVy8yQVM1?=
 =?utf-8?B?SHB1T2x6b1lIQWx6WkFvYmpHNkUwVjF2NW1nT3p3bzNleXN4c05oeStHUW5y?=
 =?utf-8?B?THAvZWIyQjBqdWJhbDhsNFM0OGlJMXhNb29jRVZ4dlBZMjYyRWUxalV5ODhk?=
 =?utf-8?B?ZFFQancyZWtEaFRnODZIQmMyTjVCKzVLZnJ1QWs1Vzl1YjRzSWZ3UkRMcW14?=
 =?utf-8?B?Qzl0elJYdXpPaXd6elhYQ2NrOVJDcEVGYlZUamxWcjYwKzRlL3crMGFrY2dD?=
 =?utf-8?B?SjJsNHdhMDUwZGtkUGxOK0FzL2tTZzBra1VVUEh1aVVBTzk5WjN0dGFkemJv?=
 =?utf-8?B?UDFtZ3E0azJSKzBEVTY2M3luWXN1bm9tUE95bG04NkdMTEE1VHZPWDFzcnpZ?=
 =?utf-8?B?SGNQYzA3RGdiVjRKVnZZeTBKeVIrMjc3MlQ2THFjQ3NQVktVOGdKbW9ZYVJt?=
 =?utf-8?B?cHN5WnpDY3dwQUgyS2g4TzZRR2RFcTR0cXljdXp4dzJQT0xDVTFIQUpjYWxY?=
 =?utf-8?B?RWxWVHgwWGh5Z2sycERtbmtkN0tXSXhGektyTExXZVVIRzdJNnhUY2NyTytp?=
 =?utf-8?B?YXJabXJlRWFKMkdXNHF4RWdpLytWZ29EWW5VYjBiY3I0Y1NCK1J1Vzg5SGZF?=
 =?utf-8?B?V0NpaUJqelJVNXlhS0RKRFZiUmFtTTVWYXAxOG90TXBrdlVrckNnL3g4aWZr?=
 =?utf-8?B?Y1dGNmhraUFHME50b212YU4rRWZnNW5CZHBTMTJGT0IySk1KSld0cFNqMTZs?=
 =?utf-8?B?Z3lHaFFLMFcrc0ROWTBqQldmWHZUZy9QT1FtbkVFQ0tQdWFaaTVoOTVUTFVN?=
 =?utf-8?B?OHlncjlQcDIxTHNnc1psaUN0Z1Vxc21Rd3hMeEp4WnRIb2t3dVhienpmRitr?=
 =?utf-8?B?QU5BYUhvSHB3TjZEa0UrRzI3TU1tOEJtQzF0Y2wrQ293ZUh6UUpyc01yKzIz?=
 =?utf-8?B?bzd6czh2QUdhV25EUDErV0lZRWo4eUdXTVhBZitkUWFybXdTSExNaDN0eGk4?=
 =?utf-8?B?UGRaMS9MMU5ESjBZU3pUSUpUNDdZREFjbEtTamRxY3UwMlprSDR2a1ZNQW54?=
 =?utf-8?B?V1gvVDRNSVNZOTd1WnhaZElaUnE3OFRlRW9qT1VMRU1hVCt6amFQMWJCbm92?=
 =?utf-8?B?bDZaQ0dJelVmTzlQb052KzVyakRERFNHRWdYcTNOeGJ3SysrcGFlY2tpRjYx?=
 =?utf-8?B?VHZ2Q2hPZFN2VjlCSTlmbTZNNU1YbWcvdTJnYTh1QVdObGhreXhvSWxseWtH?=
 =?utf-8?B?UHBYZWgvRGFnNHdVUHMydDU1cnlTZU5tQ2VmVDVKRlpadVNjRnRrajlJWE5G?=
 =?utf-8?B?WCtpY0ZtWkR6dUJCWEVBNytGSXd6YlVMSXgwVlNwQjVIUVpGOGpkWGd0WW5v?=
 =?utf-8?B?S29jYmFObG5id1VBdHEzc0w4bUpjdG00WFRhZVRTTjVoU1h3bmNOK1VyWWJk?=
 =?utf-8?Q?FPN0fBq8X/4NQiv1tXg8+Ua+x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b76618-8005-4983-e7ae-08daf88c08f4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:09:16.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQyAYvcfumzLCNROdXWk3m6+nsT1xAajsg6Cl9Qc1v9HJqNKkxupN0i0uXtEqwxB6tRKT07NhR4gPLfeHkhQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2023 4:44 PM, David Hildenbrand wrote:
> On 16.01.23 03:25, Raghavendra K T wrote:
>>   During the Numa scanning make sure only relevant vmas of the
>> tasks are scanned.
>>
>> Logic:
>> 1) For the first two time allow unconditional scanning of vmas
>> 2) Store recent 4 unique tasks (last 8bits of PIDs) accessed the vma.
>>    False negetives in case of collison should be fine here.
>> 3) If more than 4 pids exist assume task indeed accessed vma to
>>   to avoid false negetives
>>
>> Co-developed-by: Bharata B Rao <bharata@amd.com>
>> (initial patch to store pid information)
>>
>> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>> ---
>>   include/linux/mm_types.h |  2 ++
>>   kernel/sched/fair.c      | 32 ++++++++++++++++++++++++++++++++
>>   mm/memory.c              | 21 +++++++++++++++++++++
>>   3 files changed, 55 insertions(+)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 500e536796ca..07feae37b8e6 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -506,6 +506,8 @@ struct vm_area_struct {
>>       struct mempolicy *vm_policy;    /* NUMA policy for the VMA */
>>   #endif
>>       struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>> +    unsigned int accessing_pids;
>> +    int next_pid_slot;
>>   } __randomize_layout;
> 
> What immediately jumps at me is the unconditional grow of a VMA by 8 
> bytes. A process with 64k mappings consumes 512 KiB more of memory, 
> possibly completely unnecessarily.
> 
> This at least needs to be fenced by CONFIG_NUMA_BALANCING.
> 

Thanks for the review David. Good point..  I do agree. I see I will have
to fence further in memory.c only since fair.c is already taken care.
