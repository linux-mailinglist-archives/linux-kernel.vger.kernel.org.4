Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6968ABCD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjBDSSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:18:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43330290
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KErvDkBoN0LLuXcXK6HQApUVVwUQeKi4n1378/KYpyLcsAPqMkGd2iVjZm7ZaVHX3IzhGM7fWKn1Dwi/Y3DEeaf0Z/vSyBSB+sav7OEp5behY56105W0ZjRt6CexFqhYCL6Cvi6dtCO5C/cplEt3Bjkskx5Vhl8aoSXJdK5b1CsFxKbszHaA73OmQs+c+aN3IjcBs+t4Vpl9AbKcFAjUw+E5RshTQHW4lOazvEp8zIj+YLakbE7FNzMEinNvCi6Lz0Va8SmwZKHmL2ADa540/8JZu7VC/B7MddGWZl3Vtzb9+3x4M1e2P15q+SQtSe7D5vLnil7yKdvIm4fmFkK1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBZnJalvHyzHJRDshibTlSQLRzyAyAcRgSc9ut2Onl0=;
 b=VpH0eSHZhK18SCqXN3HH36kWMzL4T1mlcj3gO2mKrAkXRbsSdChRbUiNSwwsSEHdfbLC3Rvgk3Kv9NVEpmaq2Y7renIQ7Jy3hRQYkjRu3btBI13tNTTmsS9Cwpn/XN1P73t/vZ280P/ZQ8UCtwfNwE/EQkfFT3vW62PfB9jvclcSsmGIv6SIkjwoJ1AC2SSvUeKUfsj28rg34yAceVJmN9J1sMz8SXXLePcJW1ojwIoccClqgk21qWh+zh3Mv4Qf5ZgoF19CQZ/umUs/w+T50I+kPRxWj/GEmPFCgiXyCrQE6ptftXwrlqWVi56tgPxc+2K85NDcEv6LZ3FjZvV2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBZnJalvHyzHJRDshibTlSQLRzyAyAcRgSc9ut2Onl0=;
 b=VXyIw/Bkg0H3+TVFiE/7VRsaWMCBF2O2uKI+SP4KLLl/O0DQt5di2xp5QMx/9BLl6S8qEah5VVgnofYJlj2vkS5ENXotkctWNjTvzN0PGUjOmXKIkscSjhH3YKbtWrYknyFa6negXFFo15g0Xl8Aonvewh498bWXycz3mS2iK78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sat, 4 Feb
 2023 18:18:42 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6043.022; Sat, 4 Feb 2023
 18:18:41 +0000
Message-ID: <8c8f82c3-1296-ca28-0a21-6c5467ac2e3e@amd.com>
Date:   Sat, 4 Feb 2023 23:48:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Content-Language: en-US
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
 <Y9zvm4aB2B412drn@hirez.programming.kicks-ass.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <Y9zvm4aB2B412drn@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0212.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::11) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|BN9PR12MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce77d0e-029f-45bf-4ffb-08db06dc3e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fouyqkSIeB38XdIgjMKuJdrsxezl/tBC6IVY0UEidmNGta7BBoohvLHYCv+/F0G9BfeydPCPsXYTAklZpcGGf1hp05M7nWmWweRjxjwAf3qa3fCoczZKl37cjhjLAanxL/SENQlR4BAuXGwUrRKGInq10QopRCfc2Us18WUdA5cRI1rwosidETGe0azjgT8j0FypPsE2wD+UHg/+BAWVeuGzbF2IsiWTj6V2w9NzGfz1/G9ms7FydKYkc7NbOqVT0FJfPx8mLdNAA987eufSqOuL/BffxcDWzPTnyiEVKOQq+sxqvC4fYU7B9LJpwcXfsrGy7cQDJI+2XfDoe/HpO70wHf8wQ05XkXx158C7YhbUL/s+iLVK4EoZWhRYRua0/hRL12LwTEfSfYRz8vpWsPgDpfBSBIOEax27d7Mc/LT99/0+R+QBX5oPeKgl8LNcvQtX/9vPfjT2Th/5tXLEdIuzR7VBc9JQAlPIPcq5bU5dOhfB4+poz4bVJfCQfhIz+Z37A0TuNOQw/lqcah0mh/L3KwDPN6PXyafHdkIA9POuM7fOCHpeHHEyoipwDKaZe52zOXT+aTSCh5TP0Ta1xsy+KyNFEEEGbpso7H3x3vhgmQvFzYfOWPhQxOvzubNe7qanPp/SuV06h7AXjcscKxZWE6R4IAEAkjV5Yp+JiXF+He7Hqj8F73iWT2H8E44Z2xjx5aPROyT/8SrH4hXKhZbnLCjNKUslUaVLOR7jYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199018)(38100700002)(54906003)(6666004)(83380400001)(6506007)(53546011)(2616005)(26005)(186003)(6512007)(2906002)(31696002)(36756003)(6486002)(478600001)(66946007)(8936002)(31686004)(8676002)(41300700001)(66556008)(66476007)(6916009)(4326008)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStFVVVYOXBYSUNOY3FCQ3VZRmdteVNXOXFjRVRMSm1pU25DcE1uL0tCVEFs?=
 =?utf-8?B?SjZFWFV2NUI1RTJjQzZEeWpTcENiS0Y1ckMwUmg1Sk5nSDAveXgxbG90d2xU?=
 =?utf-8?B?d2xiOXh2YXprTS8xaGhtT0x3Yncvb2twTzRSakVPYncvY25Fek0vQTZORzJU?=
 =?utf-8?B?ZUVSbmJWWHNsYjBPbDl0c1FLVGVOWlpXZVQvUmZOeitmWEIvL2FwT1owcGhp?=
 =?utf-8?B?aFUyVXErQzIreFJuTlRtb3RFNUUwYTV5dlpIUzV0bUpkNU9FZ0dOZjlrU1cr?=
 =?utf-8?B?VnpmSjJabDVxaEhDMEJwZHQzOGJIa0wyUml1YnFmTGJqL2dsRHhrK3ZtbXRM?=
 =?utf-8?B?ay9SQmcxRnlaTytZakkrY2VzaXBFYVFFbVpwREdtbTgwNjN1MWYwa25zSk1t?=
 =?utf-8?B?dGtvVFdMTHA5bEJhN0FCckM0aU93THdoWTJoUUJjYS9aYmpabm9QNFJPdERa?=
 =?utf-8?B?VGdPNHF5L0UyVUZQQXRMNHNablljTVBPNmxNcURhaFVhTUdxeVBiWTl0cm41?=
 =?utf-8?B?akJVUkd2aWpVQXZ6NVduV0tJZHR0YTd4ZEZHRGE2eVhyZUpsd2dTRlJrNERh?=
 =?utf-8?B?c3d1alF1aGs2Z2I3VjhYWnFJeVVsUFI3ejlETC9xWlJ4eUQvdi9nbXRsQk02?=
 =?utf-8?B?c0cxNmcxN0FoK2RWRUsrcGV0MkoyVUI5RXU2TzY2QjdadkVNKzRxdjFiYXVk?=
 =?utf-8?B?dmUrMkdKbFRLOTIyK0VjK3JQc09JRExSbHEzR1NtWE1oSXVZaEpzUS9LSldU?=
 =?utf-8?B?MWYyUWI3YUxHNzZqRVFEUDR0NVFrNmg4Z2ZrUHd3Mnl5UUxTYTlpbG1uRk4y?=
 =?utf-8?B?S25NUFF0dllSN3FOc0ZrYUluSjZ3WlIyUEF6Uldsd0VmZWNxa3BNMkkwUjFi?=
 =?utf-8?B?dUZCZ2R0NDN4cnlMWTlYRU5Ia0VyWGsrbzdLRmhpU0VPdXR3VGZrL3JJdlNO?=
 =?utf-8?B?M1pwSUIzeTl1UzhKb1d0ZnA0ek1IVkMrdlhYUFZpaGw5cGpoYVhYbEx6OHhw?=
 =?utf-8?B?b2MwdVFIZ3pxR1hUTmtmc2hqT3I1ZFJobjh1ZzNpU21yVkcySTh6TE41cG9o?=
 =?utf-8?B?WjhGT2lYWXEyUzRwRno3MlJxTHBOWU43MDdkSGpYd2swZ1FFRms3MHdiQkxZ?=
 =?utf-8?B?dys2OFFQV1YxckI4eTlCT0s2S0wwZEh4ZSt1ZURtOWU2Wk1pRVJNUzBiVlcw?=
 =?utf-8?B?dHR5UDNIaWhrc0tiSDYwelVoblFFNWtMOE1sUHJici9RK2VJTEdwZjRHNEEr?=
 =?utf-8?B?N3pjUDJVWFEzMFM2UXFXTUZoNVBZNndwM1FSOC83L2diSmpEamhQeldFeFJ2?=
 =?utf-8?B?NGVaVXBubGpGa2lyQnR4cXB6SWY0RGMyVXRBakxmc1VNWG5oYk80V09TM0E5?=
 =?utf-8?B?Vmw0cHRENFlRbUVSbTFRWW0wTER5a3piY0tObVFrWVdTK25zSEVQd3dhSmM1?=
 =?utf-8?B?NTNzQy9ydGg5Y0IzZlJMQmVFZXdXRlFJWEE1cWtJNzY2dlhCQi8xM3NlN2ZB?=
 =?utf-8?B?cTF6a1ozbVVxU09rWFJxQ2VpSmJHSlpRM2hTM2tpTjFJUFZLODl6UnFTMW1T?=
 =?utf-8?B?d2RDUWZ5OEkvREtqV0dXRG8ralZNeGFqNi9Jci9SMS83REp0TURzWURwOThy?=
 =?utf-8?B?cFVXSjBuQzVPMHRSMWY3MUV2NnlQOHBjYkJFc1loTlUwMThtclZ4WnFpVkZq?=
 =?utf-8?B?cUx4QWVvVXQ2YldKUjNudVErdExNLzIwSTNQUlAvTndoc2lXWEliUElxeStD?=
 =?utf-8?B?c0RyaTZpUCtlVGdSWExGMndReTJwR2tPdkQ3Tzhnc281VDBOQTcyd1JjUHNN?=
 =?utf-8?B?KzJBVGY3bDRHSHBEck5DZHhhTExzaXIwOEZpSExBMHlWU3ZlTTJYM0ZzUGsy?=
 =?utf-8?B?OGdqMTlNZmE1cmJ1d2UwV3lrRktOa0tjWlptOE4wSXk4TEpTaVAvOHU2OVRp?=
 =?utf-8?B?dkZ2NkhUWnRnNHc0MlZqRWZPMXZyQ0RqZkZJdzByanE2WktuYmFBNU9nSkhW?=
 =?utf-8?B?b3ZEd0FzZ1VFN3d4d1ZkZ1dLc2FvVC9vT3Jxb3J6amwxY0VTKzF2QnR1Rjlh?=
 =?utf-8?B?SVZHb2RZY1BMMkpEZm9lNEdPRk16WHFjaGtiM1hXaHpBMUJSVGc0OEVGMVZz?=
 =?utf-8?Q?C7R6XtlMgqpWqxaPucqw0fK2Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce77d0e-029f-45bf-4ffb-08db06dc3e8b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 18:18:41.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hplapq9OlQfIkken7qfEy722iAHSFX/7S9qwN4M87S4p6Fpz6aAz7UUj/+KexpyWdMvkmhrigd7/siHM7ASFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/2023 4:57 PM, Peter Zijlstra wrote:
> On Fri, Feb 03, 2023 at 12:15:48PM +0100, Peter Zijlstra wrote:
> 
>>> +static inline void vma_set_active_pid_bit(struct vm_area_struct *vma)
>>> +{
>>> +	unsigned int active_pid_bit;
>>> +
>>> +	if (vma->numab) {
>>> +		active_pid_bit = current->pid % BITS_PER_LONG;
>>> +		vma->numab->accessing_pids |= 1UL << active_pid_bit;
>>> +	}
>>> +}
>>
>> Perhaps:
>>
>> 	if (vma->numab)
>> 		__set_bit(current->pid % BITS_PER_LONG, &vma->numab->pids);
>>
>> ?
>>
>> Or maybe even:
>>
>> 	bit = current->pid % BITS_PER_LONG;
>> 	if (vma->numab && !__test_bit(bit, &vma->numab->pids))
>> 		__set_bit(bit, &vma->numab->pids);
>>
> 
> The alternative to just taking the low n bits is to use:
> 
>    hash_32(current->pid, BITS_PER_LONG)
> 
> That mixes things up a bit.

Good idea, when we have workloads that creates lesser number of threads
faster, current solution might have been simpler, but with thread 
creation that happens over period of time hash function mixes and avoids 
collision. will experiment with this option.
