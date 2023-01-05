Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9C65EF2D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjAEOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjAEOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:47:57 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD6F1093
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUb/E3FpZOXnY+d24CrijlHAXaLSKkOOoqVg0QMgSsxQsdw95RLGIscygBUyzFKAVpw2ybmomkl3SZgsyFDAflvde9PVDjvllEUVpjupWlDkHR7K98szduCw3vba1v8EkPy14IKIRVuDDlkWDOuHrBw1OHzqexHp55GvWOLI6tyvXt0vqs5KGyL5I1fBmCP8D4jGG5erEwEgATlC7c1s9EfQDIMN0IDq+u5qCrCbor+dgUNmV+8LzntVSordLyOU7uKKYaj6ahlsSm5HF87Ph91g1HzmlMJRMQsLlWmDnh4mjiT48JHmnCNkx6Hl/sGG7Ii1RQSggSOEpJETLsgG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFmCEfY4FkDCnTO+HrIWCDVcfdPe8PhylFCPvOOjNYc=;
 b=k9/J2qru6xcfr0+j/zVcpNjcNcXGasQkkI0PuRGuT4hVawocj8DJaAzsDgVo1EIp+U6RjR09cbOzsMsyQyg/MgMShtnTI7hth13iZi+vaDIjvz0swkD07ehSPwIDg5QGDoBL0ce39v9/fdPu1IdQYEPjZmrOk4pGKtJ8YtCZvbgPS3NZrYHiLo7Qi+uz54+7cja5QYnEDqdjNJX7BCI6cL4WambGZs8Ns68EfQ/nPvex9sdP/MS+gzun8BU4hoW1BUuUddm10bzymUpYVY+UYPmllUWi+sQ4RY4XnE0JjFgL1REgldkyb1ivT2UJ7Q4MECxkPeFPK3svCqX1hS/2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFmCEfY4FkDCnTO+HrIWCDVcfdPe8PhylFCPvOOjNYc=;
 b=WhX8Dt53z/u1wYM4ZPUYtEagUKZ3LY348hDRthFbj35NL+Gh4AU7a4AdFAyhnIAwM0L6hGMsvutWZGVrxBvQkoTbovojtZZN9y6vMOPphfS6i+dsrHSoLVr8fdEt/TOQc2AWtpJGtP1ZtAZ7X8OYfClYIXEFe0YtBDmjK/ScdwyvV9ZIqWPUdl1kzFhivyGgnFgRWeoNlD+iP2Y8ux/NjdqrH689WykbfjerNnNOprHmOUSNsnOOFFFK2koAz2Jxj6jckm9LYb3Gpxf/TWlNo8ITsyHDSU1w3Ctl0b5okKkbRxauItoGoI5/Cce5kRsd7eVeXWVmZde3eY/3+mUaPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:47:53 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:47:53 +0000
Message-ID: <4cc4114d-7fa5-1c23-3504-0ca4dbdd0f62@nvidia.com>
Date:   Thu, 5 Jan 2023 08:47:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] arm64: gic: increase the number of IRQ descriptors
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104023738.1258925-1-sdonthineni@nvidia.com>
 <86sfgq7jb3.wl-maz@kernel.org>
 <2a0116a8-fbd0-d866-ada0-ed50f0523f1d@nvidia.com>
 <86k0216ydh.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <86k0216ydh.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:806:22::34) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6b6e2a-2be0-48ac-4ffa-08daef2bd300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVlyUaovb0Pc63UrYPjAtVKxUPpTYmhqZmHaoPz7rsLxQJkxwZF69SGzC+SKnQ1wRqQKaO7kGH8OrOtqxSPK3xGhYY3slnlz5iAmU59ALOrMaW6WN5xoGpg1gSqXzDnYvBwAoEWvL5UF/TmqzWfpOMMY+lepVc3g5KGVnbeiKyRuJW26YGdiF/P7HMIUAtuLchJDrTNf66ND9vAH74MM2UJnq58CjDjtJBKgkkV28T1vJEWjULTXy3BU2BP7cUHwfVQIC8rWkort6lJncWjc0EIritsPvEDZLeQVax9OnmNdiGzx+1rAJgDbbIi6wPuKpy4u8Eew3G0K+ZVLlSyISRCPdGOcPnIaOvt7JaiE8Xv4s3TUcFNnmh+8eQTqCkXms1v0fByWNef1FHFniQal5f6jngAeIfi6GT7nrW7OjhLEMtziQGoNB83Ii0xx1Hs3bbPyg9jCpo1lxrRijyjw8038MxTtgu56z2Igmsj6mWh4XZt6vWVbqFa3gurg9qa0gsO0gCg6UEKOGjPSByLMTchwBiE9EFHdQbsQZh0qRPK8GhJw70n7GeyH7wjDYdPbgtegCBN+XFUNmALszHb8CuyafIkauyiag7DJDOMpnjJIecnBB7Z/JxjMV1u8nPhVbq9avUsRfpcoyz6Vj5s1DDqrfiTCvjTBYGEeEMBfzoSLhxiBqvR9BlFNiPcyapWlsBDY1LAu7c/iAFct5s7qMfsrOeJ13hoSQQAwBuu9FIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(83380400001)(6512007)(26005)(6666004)(6506007)(86362001)(36756003)(31696002)(2616005)(53546011)(38100700002)(186003)(316002)(4326008)(478600001)(41300700001)(8676002)(2906002)(5660300002)(8936002)(6486002)(31686004)(66476007)(54906003)(66556008)(66946007)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0E4YWh2WUNHdUhNUmN0anU1T1pGQmdkL1NleFlpTWdDM0NuZnNIdHgyTTZE?=
 =?utf-8?B?YVZSVkNCb04yRU1DNlVMa0wxV3drb2tkaUJaY05zWXpzbmExT3JhVFJiNERD?=
 =?utf-8?B?bFJPUjVnOGVKSzFCejVaaTlvQTNZd0xoRFlTc1B0VHNTN2ZZL2pIYWRKWkZv?=
 =?utf-8?B?SHhTUmF0SzlXYTRMdzl6bkdIMklMeUprRkRvc1BuZzZQczlRVUlhRUhOYVlu?=
 =?utf-8?B?djhiRmlyV0Y0YlRHSDZZbGRIQ3JVSU5UMm9IZGZyN3BzeFVjNk4xSkpiZFZV?=
 =?utf-8?B?bkFiOHdBcmZTZ3hZSS9vZE41VExPU3o4UDJ6cU03d2ljRTRsWDRyNG5TRTFG?=
 =?utf-8?B?em01SEIwNWtHY21OZGJzYnFSRldpVFhtbUU5VVhORFRrRE00dFEwbERFSWNu?=
 =?utf-8?B?TWU3WGNLVE1DOVVjdUczby9FTmEra3Ftd1V6bXRnSWR6elVIVThtODA5Tyt6?=
 =?utf-8?B?U1NJU016Z3IxN1ExVXllZ29kNm40U2tTUkZtdG9zUWViOTF3dGV1QjRHWFdQ?=
 =?utf-8?B?b21jSGN0b2tBdmg5Y1p2NTg3S2lFQ3pESTlUU1FVdEhFSWM2R0M2dklYL3pO?=
 =?utf-8?B?OHNURnVKSC9pdFJVSW5hUVliV3JKWUtiZzZYRlRMcWRNK2RHb2RmVWhQY3pY?=
 =?utf-8?B?RzZkM2lTVmcvdGViUmFwdUY5MmlPb2dQQWp3TlRhTHNaOWtyV2xLSE1NTldu?=
 =?utf-8?B?SHlybTNCZzlEOXc3bFNDN0NDUnllMHNYaW84c1RlSFgxNWtaZ2EybkgvNlNj?=
 =?utf-8?B?cHlIOTRVSFdsRWt2RjNTZVUxdVd3ZXNnemNPSENvRE9ocE5ER0VCVWZ2WTYy?=
 =?utf-8?B?STZDQmtVUmRXMFZUak5rNUg1T1NPbkI0S0dVNk1SbW81eFVUdFdkRVVGQzd0?=
 =?utf-8?B?REdyazFVMjJoOHdlOGFTOUxJSjNLM2VsamQ5bmd2ODRXTThLYWFmakNpbVNC?=
 =?utf-8?B?aXZKcGU0VUVTY1dkRzZqVk5INFd2Umc3aWR1eGVxMnM3ZjArNjNSQlU4NldI?=
 =?utf-8?B?Qm5uM0w3c0kwaFFDbWdtd3NsWUE2ZFNCcytCNTZEdEhOUXZtUWRESUo2Vm1k?=
 =?utf-8?B?VzdLZ3ZqRUd4d0tEYmg0cTZITTRJSUFvdVVXUXNuZU1GUzZrZkhaWG52a1pj?=
 =?utf-8?B?TGtkbjJZSC81MFhIZ0xKd1c0dG9ObjVwWG5vNzRCaElpTXd1K2VKZi9yRXcw?=
 =?utf-8?B?S2R4Zm9mRktaeStEcDBiRFE5OVVTQ1BNMFVlZ3orSS8yRno4UHBLVlp3UGx5?=
 =?utf-8?B?OGd5WHdYeHI1NXFkODIxcVA2OHNMRys4NEI4MENQSHVUZjY4N1NHRldVbUtW?=
 =?utf-8?B?V1ZzNnY3QW5Kb1hrTVMrWUJITmNRWG05eXkxYkVrditoZ2tYMmRON1d4aU1m?=
 =?utf-8?B?RzhlY210UFJEVnVFbFJPYmhXMEx1RzZuWkdTRXRlb3J4VG4yN2lvV0RxZkhn?=
 =?utf-8?B?RmR2V3lhM09uNUZnZkFzR1ZYVTQ4LzZwNE1WTlIzalROTkt4RzErdGVWYmQz?=
 =?utf-8?B?UkcwaFhkSVFaaWowNVA4WFZUYVNGa3VjcTdXcFN0Q3plRmYzdUJUajZWVE9E?=
 =?utf-8?B?VkNNS1pLNGhtMDRLaXpTUWxFeFRJbjIvWlA1WnFCUlpBVGF3bWpNQ2FQSk9m?=
 =?utf-8?B?eURYMHZwekVLZXVia0NqWC9FZVpEV2VPRG5IMVVGc1diaHlRYjBsMGtQNk9D?=
 =?utf-8?B?UENTSnB1MG9IR0ZIVFNra2lZNWRrT0V5WmJaZzdIbEo1SVk5RVp4eHc3TE9F?=
 =?utf-8?B?V09vMzRtTXh1bEtqZ2JVZCt4bHpVNTdrVVhHMnhmcmVoTk5qSVRwdGFvZFdk?=
 =?utf-8?B?Y3UxRHBndytVd1dlOE1VYU5yMzhadkJ4UlRLcWgrTWt2WS9RWnJZa2ZIM0dW?=
 =?utf-8?B?WGZRRmxCdjlGckdkTzNWcy90TU92VTNkZm5FMklYd2tJMVQzWEY0dVk2QjVE?=
 =?utf-8?B?LzVpRSsxTmFRNXdEWmJwV0FwM3NLMHBNS1ZQUGdmMExBaC9xOXpsK2l0Nmtw?=
 =?utf-8?B?Yng0am1HRWdlNVJLVjg5cG5kUG02UW1WT3R4dTB0N1BaVUduRVJPaTNxNUJH?=
 =?utf-8?B?WWRvUUhCdkhOVG5OMFdiQUd4ZU0wZHRxcXlJc1hkUnQwTURWWm9wUkNPcTFN?=
 =?utf-8?B?Y3IreHJ1REZ0MEJTSERxQUV1ZmtwcjFWa1FuMjFFZ2h4NWh1R3g2aGc3L2ZW?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6b6e2a-2be0-48ac-4ffa-08daef2bd300
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 14:47:53.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poNWJu4EwYAkRYl3zFB2Ax5XjMH/mTP3VNkTIyQcfid7A+1+RRy5K/Spb57KdEjHIMUF5Qg2FtFppUDxDMKbyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 04:59, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, 04 Jan 2023 13:47:03 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> Hi Marc,
>>
>> On 1/4/23 03:14, Marc Zyngier wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, 04 Jan 2023 02:37:38 +0000,
>>> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>>>
>>>> The default value of NR_IRQS is not sufficient to support GICv4.1
>>>> features and ~56K LPIs. This parameter would be too small for certain
>>>> server platforms where it has many IO devices and is capable of
>>>> direct injection of vSGI and vLPI features.
>>>>
>>>> Currently, maximum of 64 + 8192 (IRQ_BITMAP_BITS) IRQ descriptors
>>>> are allowed. The vCPU creation fails after reaching count ~400 with
>>>> kvm-arm.vgic_v4_enable=1.
>>>>
>>>> This patch increases NR_IRQS to 1^19 to cover 56K LPIs and 262144
>>>> vSGIs (16K vPEs x 16).
>>>>
>>>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>>>> ---
>>>> Changes since v1:
>>>>    -create from v6.2-rc1 and edit commit text
>>>>
>>>>    arch/arm64/include/asm/irq.h | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>>>> index fac08e18bcd5..3fffc0b8b704 100644
>>>> --- a/arch/arm64/include/asm/irq.h
>>>> +++ b/arch/arm64/include/asm/irq.h
>>>> @@ -4,6 +4,10 @@
>>>>
>>>>    #ifndef __ASSEMBLER__
>>>>
>>>> +#if defined(CONFIG_ARM_GIC_V3_ITS)
>>>> +#define  NR_IRQS  (1 << 19)
>>>> +#endif
>>>> +
>>>>    #include <asm-generic/irq.h>
>>>>
>>>>    struct pt_regs;
>>>
>>> Sorry, but I don't think this is an acceptable change. This is a large
>>> overhead that affects *everyone*, and that will eventually be too
>>> small anyway with larger systems and larger interrupt spaces.
>>>
>>> A better way to address this would be to move to a more dynamic
>>> allocation, converting the irqdesc rb-tree into an xarray, getting rid
>>> of the bitmaps (the allocation bitmap and the resend one), and track
>>> everything in the xarray.
>>
>> The actual memory allocation for IRQ descriptors is still dynamic for ARM64.
>> This change increases static memory for variable 'allocated_irqs' by 64KB,
>> feel not a noticeable overhead.
> 
> 64kB for each bitmap, so that's already 128kB (you missed the
> irqs_resend bitmap). And that's for a number of IRQs that is still way
> below what the GIC architecture supports today.
> 
> The architecture supports 32bit INTIDs, and that's 1GB worth of
> bitmaps, only for the physical side. Add the virtual stuff for which
> we create host-side descriptors, and we can go way beyond that.
> 
> So what happens next, once you exceed the arbitrary limit that only
> satisfies your own use case? We will bump it up again, and again,
> bloating the kernel with useless static data that *nobody* needs.
> Specially not the VMs that you plan to run.
> 
> So I'm putting my foot down right now, and saying that it needs to be
> fixed once and for all. The current scheme was OK for small interrupt
> spaces, but it isn't fit for purpose anymore, certainly not with
> things like the GICv4 architecture.
> 
> I'm happy to help with it, but I'm certainly not willing to accept any
> sort of new compile-time limit.

Thanks for helping with a scalable solution instead of static allocation.
Please include me whenever patches posted to LKML. I'm happy to verify
on NVIDIA server platforms and provide test feedback.
