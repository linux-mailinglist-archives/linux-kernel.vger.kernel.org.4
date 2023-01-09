Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85C6662BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjAIQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbjAIQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:57:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F63B920
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:57:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0IDuwnP6SPlUlSHv0TcXEvpSFk0XDgKyKvHgbd5UB1GfQYdRyu+aDtC6T6uGrHZ5EDNHTk5u5DM8/JfHnitLJzvo+i2fKM3O946pkt0FptPIT6oxvn9HNBw9b+jfL8+6RgBd0JumfPZyvjcla4uRNsm97b58jnYWeWL5f6a12QzVlqsF5LQADyBeYnFlxs2iyfmq/bDOkHzHx9YIKd2oF1rOKP0tJnhvcvZc4OdwqjSXK3P2KHaUAnVElU+RDGl3Sbm4jdCtrSyaj1yK8OxuXC0n9f0vQwuyHOmEJUkTGPf9osvi6e3+f/FD1jqAv96bTlengYjkEww7iziwOie0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaShufGBbzxZIY1cRcUZJhDaHTq+vT/9++hrep5dFlU=;
 b=QeCYb6dsDIckGe7V0sQWeWMl2jWFD4P6gyIcuyjCBJ7gJZFvVMzg/hQIDAM0RWxOf8HAiHiIbccNJVv4/t9ukRpNWWAN5ob/rVMFqWg6+sBAZXHWwwSnRx+Kvozd2czgCXeJV6xIUhR2r5Rufy1LrTJFkXeppHZzsb/xcY3+yafHN3Rp9CBBW2Mk+EaBc1z9IPim+clS2m7TMJPEN4AXW4edTuQHoolZbfoSSZCU1Qgx2ix2Dif4L5fFSQbObw52dcGnEk/dJWWowOyP/+D/0a5SyQeDfCCAlMj+2iwmOg8AvvP8DwNd7OrOIazFY1nmOQ6U/bw7PMeVM9Rv2rY4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaShufGBbzxZIY1cRcUZJhDaHTq+vT/9++hrep5dFlU=;
 b=CBQg/wEcjhPQi1+CflIFreMboVGbcnKdWaigpUQAEfSsWCNDTUUwL/f8vxycBdJ5ThmEwp//U+Bsq9dyRc3XnFmZxlJki1KKYTVJmiCx0pzbf9M98cfK2kYitQpJ/Tr6cb1D6QKTIOucqlyR2bjdPzP+52hFoIaeo8kxS3bCvoJyc3DylwNJd/p650fzry8jCJRVyGLrPsyO0VPiwmO+CH0gM7i1T8e4otKi6hacvztviq84mxnoVlYryV9zW+SincG+WH10XbApddxUiWeRilKz0jmUuIzEyJaQxEFC7lLE3NQg8vDnQVLTdYMScGCwb9fuWExD3S0Etp4t9gdDKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:57:37 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 16:57:37 +0000
Message-ID: <42b22d8c-0428-a73a-53ec-34efc4dafeb7@nvidia.com>
Date:   Mon, 9 Jan 2023 10:57:24 -0600
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
X-ClientProxiedBy: DM6PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:5:bc::46) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|BL1PR12MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a954be-1a48-4b7c-624e-08daf2629c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HW60fHeob4EAvRKx9SgoGaf1Xb+T/RTg7yGWrfMex8r5m+xXbIiCrPBIBC0YDsvbn9q9b0p3D5dDOUeqqAJe4pm+VnFQDDvFKp4CUn6k2h5o7nVpK7Jd5K1hQoek7yOtPOhi2St9HlMabmJma2UvZFdwZvo183+Jli0e1YdNV2ysy/J7Sak1MAJ5deZxrjLB0q92QTQW9W7/A0vKLH0J9HE3zhfyYGbmY1qnwv52pkyDgeb3+otwVCPVrJ1WjvaU3wecL+Zx9XcL/e0vN9YAKeISaBM+eE5qcmXxKJ1d97Px8RqDTGGmqqCUgSiVhI4LVZCk0Ipg1iOdpa3ycZcEnOkto9wOnYJ2C3Rq4AkPTNfCykhT1cCIMRnDW1KHA0ON9JX+mZj0jgN0dXR/37mPI1r/6+kHIdTzsUEm8qZZAG4rwdqFlOPNa+FhWv7MKdabJdHkgzQpCb0VJ0bksUklRoUXZDvNHHlvSmv8jLJvvafunsBpHDqdBBAuffnuRM7cPxcYm5qU/E4fyj3cQHrKjfP4Y8pfOYS0XHOId36Qer3l0ioOKuSltoQGwn13GERTiyPDvJfQez8zwNik1VRN8fcX4vbKcs0XLfeD0gSyzzDUa4Ll1FBGLHrsH3m5bE3nlAo4YC5zvDnbxSg9Yz/mW+li9eq88h+H+MxqrbDRrHfEZqfxvTUAU13cOkNEGexn1Bfvl1LIfD/oPj2ckhWYpYvOsloc6FAOuoYkzS68lXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(2906002)(83380400001)(66899015)(54906003)(2616005)(66476007)(66556008)(5660300002)(66946007)(6666004)(26005)(53546011)(186003)(36756003)(8936002)(6506007)(6512007)(478600001)(38100700002)(8676002)(41300700001)(6486002)(31686004)(86362001)(4326008)(6916009)(316002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXAxNndkczFyY0FPSGhWMDZaczUycXpYTjdteXY0UkhyeFNrYlJUSDAyYzVG?=
 =?utf-8?B?SEFEamFsL21tL1NvaWFGdUl3WkhQTVJqNFlwMVg2c3RiQXdYZllwSUl2bWI1?=
 =?utf-8?B?OXNnUVdKTHRsa09hNUNadWVNeUdpZ29weUE1VkpiRXVkN3dlTDhBRGNraEhC?=
 =?utf-8?B?UFJQQzVzZld5em5ieGlSR3dBYjhJZjl4bnU0YWYvMXBWQ3d3Ym80WTl4ajV3?=
 =?utf-8?B?Z2srNDBSeCsvZnJFZHBXTCsxMjRPNy9peHcvRTZaYk9TNEdOaCtpaStFRzF2?=
 =?utf-8?B?QVovRktEZ2wrNXpReW04U3JSUVhDNDBndW5QWFovQ0VKV0tTZWRGZGNhaVVF?=
 =?utf-8?B?WEdhaUZOYXM0UmtvbTBXTW43dzVmNHYvKzJPR2RQSGUwQWtjcU5OeUFFdHM2?=
 =?utf-8?B?RHRqY29aNno0dElqSUhkN28yUUNQK1FGd0xIWHh6cDZaMHNnWlNCVDJYSld0?=
 =?utf-8?B?RU45RU1JMmF5V3d4ZFhZbGlYMXNmb2QyYys0QkVGQnlrQURuWlZhbmxtV3JD?=
 =?utf-8?B?dXJSZXFlVXJpU3JHakRaVkpuZVAxUHAyWDNYelUwRW1SbVp0ZEZNckxTbUdo?=
 =?utf-8?B?azFpM2NBeWE5alp4Nnd3RFRhU0ZJVEFHdWN2NHQzT0FQbVhBWHNsL0NxL3dr?=
 =?utf-8?B?M3FaeW1ic3ZXMGJNempWMTljcXg0MEUrcXk1MVFRQ2RGeEpYblpSMUpOZ2RP?=
 =?utf-8?B?SFFUbHRadVhPUnNxWENWb0FrVU1FS0dqaWxDR1JYWTI0YkovN2tldXBTNExO?=
 =?utf-8?B?U2E3K2pvcTNmRlJxN3dScHBhU0hRcmdsZFNVMnZ5b2o1VEVwYnhxYjE0Rlda?=
 =?utf-8?B?Q0pFOS9hWnVNNzNQN0U1Wnl6NDllWWMvaUUwdGliTkorbFlBSHNydHdUUlNt?=
 =?utf-8?B?aVJxdTZrd3NBS3pSdVdwZnIvdW9BRnVTcDFIUFRnYmNPelAvd0pwRnFRVlpV?=
 =?utf-8?B?anhrUG5ZZzhkVHMrMkdZVDFKcllJeCswUnZDbUVJb3k5SEphQ1M3akNSRTdv?=
 =?utf-8?B?bDdPOTdRaEpBQ2VIL0RTSVhVOXgxMFJVWEc4RG52NmQwQk1pZmxFS25iYVJn?=
 =?utf-8?B?SitVZW9vRDgwWWtXUjR6UEpnWmJ3aHRWZ2htK0UwWnBCVlhyWTRZcytwblpY?=
 =?utf-8?B?VG1iSExkUnhLMmUyOGZWc3pzR1BSeDdqNGxtL2h5YjRWaG90RVFrbTVzOWxS?=
 =?utf-8?B?RTQ5RzA3eDRhbTJKMGh5RDd2cGxZa25ZRitTRFA4TDkvZkg3dGxhdzRXOG15?=
 =?utf-8?B?NjlGQnhJUElxazVua1B1bkxxNlRTMFBEeFhsMFdiTElyR2kzMlR2a0ZtYnho?=
 =?utf-8?B?Nm5RM3dLY2E4ckpXNG1wK2V3eCtjSllJNXlqc3liY3pnMlUxblloVmdpOTlu?=
 =?utf-8?B?djV3MGMxQkZrSGlBUXNGM0RJRDg4NlVTSUJOb3BBK2FJNWQrUUNXYk92ekFV?=
 =?utf-8?B?enNvZEM2aXRRb0I3UHpVTytKVytPd3d4MURqVkdWUFI0a3JKazZ0VXUrNTZ0?=
 =?utf-8?B?MWc5RTJXRTE1UG1GcXhVdlZmZU9GZGtEa0RlZG9TUkVLNjBDdCtaZi91OWNp?=
 =?utf-8?B?ajVOZ0luZXR6QVhONU5POW9HTzZVMXRudmRxWG5EZEtKNVY4NHdoLzd5dERo?=
 =?utf-8?B?YmMyUXBTNEd4Y2lvQlRPdHVsUE45eEg5L1VhTkJNaE5oWEhGb01XeUh0VVdM?=
 =?utf-8?B?eUFvRlhoTTgweHFjd1kwWHVRcUx2WEZlaTM5UE82YzJJTzI5N0RRZG5ldFV5?=
 =?utf-8?B?bTkweDBVUGhFWWExUmJYcit3MDc4YTF2S3JZa1hpWnQveG9lNlpTRUJqcks1?=
 =?utf-8?B?N1VaUlBoZnZ2dWVtclo0RGJuQzdTcHhPcWFTOE1DaEVtVDREcDMwQVRzbUJN?=
 =?utf-8?B?WnZXVzRVYXVPTm5vRER4dndyVXBLVmdnMnNRWHZUSHlBcVFCajFwanNKb01S?=
 =?utf-8?B?R1NycHNHQm5qMURzWURuZlR5TzgzNXF1YnI5aE16d1hkSGh4MVhaYzRxQys0?=
 =?utf-8?B?ZkYxeU9qSUNDTVZWTXkxdm9VYlRGZnN5N1NKbkRRRG1oQVowVFZ5VnZPb3R3?=
 =?utf-8?B?UjkxejRMSjdnaytuTU1xYkExZjFHb2s3bWpzSmJmcmcrWGFQU0VyQXFPWFBV?=
 =?utf-8?Q?2vdrvIiaNbh20h9a2govn1Hn4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a954be-1a48-4b7c-624e-08daf2629c37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:57:37.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zdw8NT+Zc9sJwn18IoHhwXgHGq8n4cFSBsgxldeAX61wS/mYcbIFLJG4dzeUred7ppxCu41921p65UU6VUlOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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

