Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67D662C67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjAIROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbjAIRNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:13:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2881A816
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:13:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLD307T8e6PlpijBsVjzOXrRgkVhL5sXeu1QWtp2UFiMLZoFJBMgp1UEmWsrXXUKrixDSGrcF1q/pp0cDoJpvpwsTa0zvVAD7jfQ4wraV5Zzg7YnSDe9GSjDyg2GlQtxfO75JuDY7GHEWapwQ3f9LpU68R/F+ScAQgNENSIA1bxImBQvnEqF0QJDU+wBAUFahxC5u34sAHiBcG9vYiD2hh80XTN6hkqSfCI1CjOr+rFnRAgIwJSPzy2XY/zz4AoBv7UTA8DKTiKcodkBczoWaqFftf8v6w3D0qr3XMmd7ttdhJ9lxzwDlxiM3pRbI8cog9oPOUkk7Pt4OTFV4fQo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHHeCT6xYSb2zfGmudT+W40TRPUn79cIGRtNMJtBk+g=;
 b=Crlhlce4DS72qWTby1ihDCI4BqfUSIfeCNwgiZbWetCQDQN0gpeQf5Lfm+yQIEO8ga0CwTJk0Yr6hpBg84/x1NM6bMEtCnZ/P1n7/YsNpgHEqGy2fDjMraPl2W7kVqCGebPNiJG310IDuw9C+72eBpQOpZNMEWvTD8pCz2pt3xK0wcjngQgYNYWwr3qKX6cw6IGapCsBlOhBy3XZiGSJLABltq7ftTx6sL6mI+RoTdqgz4sJjVT5gty73wccJo2J8DYdW0LLf8YaL+pZOVBgRRq2YVnrIva4nKgFW9+TVlmr6oj8tlhr6X+iMN0xLkvlWgl9X1EObqwKHdv9go70nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHHeCT6xYSb2zfGmudT+W40TRPUn79cIGRtNMJtBk+g=;
 b=mmlHFCeJYKVrRbiQ24v8GttH0NHum712gBa1ywJZ6vVsG5EppZ8c8XSfRu8nGoURiOfNh11J9lpV+E1d+XZi3jOK9fmt1lhQLKp4cTAwDR4ctRckqq5qDLcuEwEDD5fYvGrth+8j0DGwXGe7XjAu7wYf65MPmdvrTE34mKJgS2Vqv57crYxTYrmV8x/P5+GSUrydgRkeYns+2I9qF0aJ0IYk4F5xEG2SyBH4Kwnjm6ENVw4+KGaUPythFlwY4pHNVk/ivS3prKuIU8sDhv1PySR0aX9q3gg5ok9iAE7/M7i1AWWe43GGEdkrCdJWojVm2XavgvVCk3hV6hLLtdEuJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 17:13:35 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 17:13:35 +0000
Message-ID: <ed471259-5d32-e93b-20d6-42a32b8b3d89@nvidia.com>
Date:   Mon, 9 Jan 2023 11:13:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] arm64: gic: increase the number of IRQ descriptors
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104023738.1258925-1-sdonthineni@nvidia.com>
 <86sfgq7jb3.wl-maz@kernel.org>
 <2a0116a8-fbd0-d866-ada0-ed50f0523f1d@nvidia.com>
 <86k0216ydh.wl-maz@kernel.org>
 <4cc4114d-7fa5-1c23-3504-0ca4dbdd0f62@nvidia.com>
 <86fscjoe3i.wl-maz@kernel.org>
Content-Language: en-US
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <86fscjoe3i.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:20::17) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8b50ac-5252-4d54-30e6-08daf264d73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cn5K4ICT334VdCtCMAvTdYNnOXcDb5eylTkhs8TpeRjJ5aIwsfJHhGEw+l/mD0kYm/RgwH8LWgtRT74DKXJEPJQVqT3IoteiS9w3kPZ0rPrNeBd5be+KGyP2TzNGx/HFzLCrqx9bpdrcqx5o0R+QYLV3vjM5UGCXdOlJHt4LvwS7CxfH7AEEx0+Dr1JdAWFUVo0zH3wxP+DVG5zV6IrgraupD03cP9H7n8z+UOVXsxU8JzxmQMi8PNOM9N/tTuKR4UE1RM6EyncMxYTqiQMiFr3R2sDa1fxGoqOKYKoRPwV8SkKgmyRw6IAJTC4P7a92zj3lppS+evRbm+Swm4FSXycf9PBBT3jRIMjUcoCKJ/93W414iPSJPSYBkGP8d00MU1WF3BxtcuUrVzTOmaG3RgQHJaDLHHRqoTuOGiKa8ipNrkf4ItBOSLkiqhbicw/4ihu5KfWEw6RZn8BZFhDN1d26FrB3sA6JfzGPDZQ/RQMBfbjPGyenfLoglMyr5n4MzWtgy80sXy6DqagitDD1J+QykpPlnRBlDBYM+MBpyNSjeD2h6KP+cN8bELfDMVLjkBofcd9e1xH/I/ZSQxKHmM3aZPlf5+1lDxhfnZUibWUpEkMUe+1jzApZPSetESsB/Pm0UNgDoabTI+9rL23u7+EPdj+uoP3X6KluGpqNHxabesyGwtfi3RnHn94n2vbb7IjXIpN20xNmgpD8dSUFutm2xa2QeNBOJbs32gEZBeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(36756003)(31686004)(66899015)(6916009)(86362001)(4326008)(66556008)(2906002)(8936002)(8676002)(66476007)(66946007)(5660300002)(31696002)(83380400001)(38100700002)(478600001)(6486002)(54906003)(316002)(41300700001)(53546011)(2616005)(186003)(6512007)(26005)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFd3QWFGczRzbnRZUVlsUUY5blRCeHFpVnI5ZGtTVFphaUEzSlAyV3NUeXZu?=
 =?utf-8?B?eFZVaHdUdGhrd3cxTEtNWDU5bEdLR0xIVUV5TVpneHUvOHlZUCtVaklTNktQ?=
 =?utf-8?B?YmpBN1oyUXpEYnFuRGVkQjVNcDJHbHNkZUxXVVZJTTZCYm0rZjZkZTdmdW1L?=
 =?utf-8?B?NGRCcnFOTmNJRXJhSU1ZWkhybnIzZFdPUlpVM1BmS2hUdTZHVWhjcXJTd3lP?=
 =?utf-8?B?enNtWXNHR3hUM3dWcEhLM254OVZTMVBObGMvSy9Xai9CU0N1ZkJ5SzNOdGRi?=
 =?utf-8?B?QXBxcGRqQW5OODRqTEpTMmw5cFYzdm9kcXNFTlJBWmZJQWFQR2czcWVSM0RU?=
 =?utf-8?B?WGhWZkx3K2dyWlc5alU4b2ZFdTM3SFN2eldkU1Jsek1xV1JtUXVLczNiNmxD?=
 =?utf-8?B?enljVHAwRzYxZGFIQjNFY05SUU5DckxTd3JJZVB1ZWx4ODFjSzFLTkkyTkVF?=
 =?utf-8?B?M1NKV2hpcFMyMHdnM3dPM1dFNE00SXhnN3FubEhDN1FDdjhOcEhiMlhmUnBE?=
 =?utf-8?B?RGJEdzJ1QzFQdVlwNVBMb3FpbWVnRGxmQW9XYklSYSt3azJWR0lUSGtQVUFG?=
 =?utf-8?B?T2lrampGSzQ4NGdLajhOVzNjUUgrZEVUcE9WTEc3L1F6VXF5b0wrTDh5V3Uy?=
 =?utf-8?B?d1RlZXIvaXM2b3JSSndyeHlsZGtaekdmei9GSXAvNk5HL0ZTb2RYQmIrMyty?=
 =?utf-8?B?UXMvd3FVbDlwQWwzWHNGZlJUbllKSUJxOHI0YUlDeWM4TWJ3NGhmTkdnOEJG?=
 =?utf-8?B?TzdnY0d2dzM4LzFzekJOdVlqYkE4Rm5tUUwrZlJjMCtkc0QvNVcrNElZWFFm?=
 =?utf-8?B?cXM3ZGp0RlFLZVNjNDlCbFFORGlveTdkSy9GaDVXYXpBakllanhWRk1OSEFl?=
 =?utf-8?B?aU0zcjI0Z1ZZM2todTBsWE9XUGFYWDRaMnE5L0xHR0tadnY2SWZVSjAxTE9K?=
 =?utf-8?B?RWNTa3NxNUFrbmNBZk1wa3d2OUkwTWkveHhGQ1RJc3pjOUJoZmt4V3NOR0FO?=
 =?utf-8?B?MTJLQ2lUajRrUzdOOTFXOUFVVnBRSEJ1RkJVN3JObGI1RVhGUWRVYjdLUExK?=
 =?utf-8?B?WG43SlcrR0pBcmZRbm1tbjgzaU14L3ZWZXp3eEx2MkVZd2VzY2owdk1seVdQ?=
 =?utf-8?B?ZU02cm40YUNBS2pXMDhQZVZuMU4wRVZhSExZWHpuTlFDbnFaWlU4alJpQXJy?=
 =?utf-8?B?OXAzTi8xZW9UNXdtNTJ1QjYwWmhYRE03aFBkbmJaaTZncEVzVjV0NUxmRVZN?=
 =?utf-8?B?UVlHd0RRajl4d2E4dWJTdEN6Y3RxREJjVm5VL0F6d3E5OXUreExRQTR2WWtH?=
 =?utf-8?B?aUtlWnVuZDdaakFwTUxBakdUbC8welVrWm15SkFITlNqaDRKUkpwbmtua1Mr?=
 =?utf-8?B?bHJ1cUhqOWQvSmJhZXFkN2JmY2dleUc1QkgzWVdTUnlsbVRRM2s2YlhnZlpk?=
 =?utf-8?B?S0o4d1BFK3N3MXdwZ25hbC9sSlhZbklhU2lUNVkwbVA3NkxxQTBYNUdoZmRS?=
 =?utf-8?B?Vnp6ckUxWDhqK04zYXlPcmVqY2FoR0hXbW1Mbk1QaGc1bVVNb0w3YzdrRXV2?=
 =?utf-8?B?WUpZNXBOWHdZaGhkZGZxeWorZ0h3dWFlZG1iMGR6NnVaNW0zbTEyejJucFF3?=
 =?utf-8?B?RTg3V3FTcXZHaGYySllSU2tESGNvK3RJOUcyQ2FiWCtmKzhMaU9rdXpNRE5o?=
 =?utf-8?B?dnpDMVVwSVNhbFZJNmlXY3cwc1NPKzFkQ2RZaHJMcDU3SUtkeUMxVEVISnRz?=
 =?utf-8?B?d2dNSE1UbHM2aVFxWVQ1YmFoWmxmb3NiU2hya25qOGdHTWN6cTQ2NFRZZW9o?=
 =?utf-8?B?bUVxTTFjZk42Wk43MVhzODdkWElEVjFadHUxT21SUmJvMnFOdk1BdnhGZk5S?=
 =?utf-8?B?TklVSE4wWkgwM05jODFvSVltTVRjb0VFaHRzZzF2UzhwR3BWeU5vSEo3SStS?=
 =?utf-8?B?TXhhTUt3VytJL0V3MzVvYy9TQXVMS0RYZDVkM3R0U1NEaE9vaFh2THJWMXli?=
 =?utf-8?B?TlFJZHpxaUpVKzJIVjliL0JzalhWd0c2M00xeG90NFZoaHRsNlZpc1VRQ1p5?=
 =?utf-8?B?RkpURVBoaFpZZ1BkNHhIK0hBNktMR1o1T2RJc2JzdjJZUmxiK3JmY0RQNTAw?=
 =?utf-8?B?am9RaWpjT0h0NTZ1V1ZKMmtYRE8zYjlaYlk1Z1ZkenZjV1B6Z0VINzVvZXlG?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b50ac-5252-4d54-30e6-08daf264d73c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 17:13:35.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxYNZLyDdHnt7h/GoGYWw+eIgQZq3iy8vrbEpmmNZnJFJj2CQWn8caaloKrpv3jJf505Hv8Y44ZzEUfFZaJ1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/23 10:41, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 05 Jan 2023 14:47:44 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>>
>>
>> On 1/5/23 04:59, Marc Zyngier wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, 04 Jan 2023 13:47:03 +0000,
>>> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>>>
>>>> Hi Marc,
>>>>
>>>> On 1/4/23 03:14, Marc Zyngier wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Wed, 04 Jan 2023 02:37:38 +0000,
>>>>> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>>>>>
>>>>>> The default value of NR_IRQS is not sufficient to support GICv4.1
>>>>>> features and ~56K LPIs. This parameter would be too small for certain
>>>>>> server platforms where it has many IO devices and is capable of
>>>>>> direct injection of vSGI and vLPI features.
>>>>>>
>>>>>> Currently, maximum of 64 + 8192 (IRQ_BITMAP_BITS) IRQ descriptors
>>>>>> are allowed. The vCPU creation fails after reaching count ~400 with
>>>>>> kvm-arm.vgic_v4_enable=1.
>>>>>>
>>>>>> This patch increases NR_IRQS to 1^19 to cover 56K LPIs and 262144
>>>>>> vSGIs (16K vPEs x 16).
>>>>>>
>>>>>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>>>>>> ---
>>>>>> Changes since v1:
>>>>>>     -create from v6.2-rc1 and edit commit text
>>>>>>
>>>>>>     arch/arm64/include/asm/irq.h | 4 ++++
>>>>>>     1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>>>>>> index fac08e18bcd5..3fffc0b8b704 100644
>>>>>> --- a/arch/arm64/include/asm/irq.h
>>>>>> +++ b/arch/arm64/include/asm/irq.h
>>>>>> @@ -4,6 +4,10 @@
>>>>>>
>>>>>>     #ifndef __ASSEMBLER__
>>>>>>
>>>>>> +#if defined(CONFIG_ARM_GIC_V3_ITS)
>>>>>> +#define  NR_IRQS  (1 << 19)
>>>>>> +#endif
>>>>>> +
>>>>>>     #include <asm-generic/irq.h>
>>>>>>
>>>>>>     struct pt_regs;
>>>>>
>>>>> Sorry, but I don't think this is an acceptable change. This is a large
>>>>> overhead that affects *everyone*, and that will eventually be too
>>>>> small anyway with larger systems and larger interrupt spaces.
>>>>>
>>>>> A better way to address this would be to move to a more dynamic
>>>>> allocation, converting the irqdesc rb-tree into an xarray, getting rid
>>>>> of the bitmaps (the allocation bitmap and the resend one), and track
>>>>> everything in the xarray.
>>>>
>>>> The actual memory allocation for IRQ descriptors is still dynamic for ARM64.
>>>> This change increases static memory for variable 'allocated_irqs' by 64KB,
>>>> feel not a noticeable overhead.
>>>
>>> 64kB for each bitmap, so that's already 128kB (you missed the
>>> irqs_resend bitmap). And that's for a number of IRQs that is still way
>>> below what the GIC architecture supports today.
>>>
>>> The architecture supports 32bit INTIDs, and that's 1GB worth of
>>> bitmaps, only for the physical side. Add the virtual stuff for which
>>> we create host-side descriptors, and we can go way beyond that.
>>>
>>> So what happens next, once you exceed the arbitrary limit that only
>>> satisfies your own use case? We will bump it up again, and again,
>>> bloating the kernel with useless static data that *nobody* needs.
>>> Specially not the VMs that you plan to run.
>>>
>>> So I'm putting my foot down right now, and saying that it needs to be
>>> fixed once and for all. The current scheme was OK for small interrupt
>>> spaces, but it isn't fit for purpose anymore, certainly not with
>>> things like the GICv4 architecture.
>>>
>>> I'm happy to help with it, but I'm certainly not willing to accept any
>>> sort of new compile-time limit.
>>
>> Thanks for helping with a scalable solution instead of static
>> allocation.  Please include me whenever patches posted to LKML. I'm
>> happy to verify on NVIDIA server platforms and provide test
>> feedback.
>>
> 
> I offered to help you. I didn't offer to do the work for you! ;-)
> 

I've looked at the IDR/IDA API. There is no suitable function for
allocating contiguous IDs to replace bitmap API.

__irq_alloc_descs():

	mutex_lock(&sparse_irq_lock);

	start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
					   from, cnt, 0);
	ret = -EEXIST;

Is there any existing API that I can use for allocating contiguous IDs?
