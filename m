Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC536B6E37
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCMDuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCMDti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:49:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C123115;
        Sun, 12 Mar 2023 20:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIe9LzeUHiZyWgm7dyN4tzjQt+fa40PHTInm2X3SF2KCQoc14KAvDURgSh1AVVClb+7NSPeXkwPwQrSNGvfy1mDAllYmrv4NpSpb5p3LlVdK6kERpf0t76IAOuhnglLMHzd6SNmqLd7GvmRZNUHzN/vC/YCXT62SJCWQ0i/xF/RSTC31BsebZYehYKPp1IepalBi7DgaZVssoQjZAs0u3+VJsCASSTHZs3WX8HC3dB44lLIRrK045BD1CQOOE8/skW6IpfYj6VcS8VOM8aUBXYA7IiiuP1KR2LDV5Thj2krI8TlFTmDqqFe8NWFvoY2Lf0+aD2TkbCRSh767MxXlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGZjyoYMczXed3lZZcUNFhJA5Ts8eYplNPmD+oKYgv4=;
 b=h4Ov2xYVr68olYsvXvwOtCaTQtdBu3ffyGAGYdMgwm/33szxjCpr2I7GHRT2w4jCdWoUXAfcwtUnSFBcqu68m+k06Yf+ocJgO9pRTqdumMGc1l9JskqNRjqgjMSkSFlDUf2FrH+73kLLlefvt0UbsHyC4KviWnec2Mmuw+ETLkWC7wHkqxrI0iQVL6ntCB0VDg230MuMh7B5XGX7gN1bBfV8NoYB8v247AxF1MubZv8D524Q7yL+Z4Y5yLvs0mSkeEJS116nX4lPbmxNKTPoClp9Mv4pGnUNgBDdfbJGRQQl/FQ2qg/WmKzLKTs5cdrrNVEjFLc2BIThFcJHEG3oLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGZjyoYMczXed3lZZcUNFhJA5Ts8eYplNPmD+oKYgv4=;
 b=DIrkvTSERi10Wa8GToN22mkMLXFM9GbZJI2PnsEc/qppKhsFXwd4PkigJJ+Nr0LydTNLs5TCi8ZgpniVoxdrqnQfSrKeGDQlZVdEuf58HysPruBb2quf40Ks09OmkPREeSqU7atTEnT0ZelA9vHgyQ0yIF9bAWuzFBLV5GKRhAZUZ4mFf331mTAeAdhK5W0WCMeye1y1e/+aYMTg6ebeAxptyS3kALwq4rC31eor49b2vjF+ofJ9lshZPAHKRj+og2n2dmXjq6aMzmWOc26r1Sh1pGPvrILLLkrlrm0gnXRQxxKMgdTgk96PDsFGy/UhJQFguFhS3y3qNClQb6qGgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 03:48:02 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 03:48:01 +0000
Message-ID: <287307f9-8c0f-b911-6e2f-5e3add5ec06e@nvidia.com>
Date:   Sun, 12 Mar 2023 22:47:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230306013148.3483335-1-sdonthineni@nvidia.com>
 <87ilfdgdx9.wl-maz@kernel.org>
 <ff5306c3-c72e-87a3-f21f-13cdf11e1df5@nvidia.com>
 <871qlu5bmi.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <871qlu5bmi.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::23) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4c651a-67b4-4805-d907-08db2375be6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lu8uR1LEiAjU0p+R0KJBnrmUA22dHMpm3FZ6OTVzBLam5YZPCwfubFF6AAyKN27eTTby3U7YflGlOzpC01W0FwsmpILV5DoXtTsk7c3mwxTnf3LUBKbUvsuhwp6XhfDvJ8L1oygfqtCCGYkCIExAlMoIufBEqQiSyc0Kgi38kJMA7tdwRP+Z1Ssqukx5RTGePq/lMr+dSH/SvbKYog2i3Ule1Oaqa+AnWoX7odeCSqdjvhvznShzGDh6QetKfLlsAU5d+JQ2Xa/jtiNBrZDKh0+wynmARbxvAtfDk3ikbeVopsF6g4xzap68yhhtTGN30P7aGj0STvH8JHKE1iYKYrlo4nHbZK4sS7ZgmXVoer5v9qnO0a05SXb6jCjTQ2K+wcdvRvjhb7f4uRd1HF1z4ASlqKr0sSGl7AUk5q1aAzm51zQzKKytWf96EBp4dHe0mb48W99Xh06Y6WqS9AdQuBq8L9rt1DnxCNOF7IsyQR9qD43V1ThhLgtq38S8qJYV73YgitPJpRD2WZYobemA73GOyNkfL2YbjzP2xYv+LZ/jOMHcQ+F3kLIxKVu5Bs0FVACe8ni7tjdpXbrHWvXn/6R+G5cLgFhhevpwXvz+vuW73Hn3aDK9UP/4aMrC+9+9v5bliAdOTN4xdQoCigxdu0AfZtdYo0+hjNrjcKyjDVmWwF/tIMyoKjjVPonfzNWE6m1NB/fUJskVFil8GEGoIaewjrnHeCww1CgiHEqKZREEKuOql2AFvvqGgmXr1GIrE5SM0gHcYz70iNfrXGXtQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199018)(2616005)(186003)(31686004)(53546011)(6512007)(6506007)(26005)(8936002)(83380400001)(66899018)(107886003)(6666004)(38100700002)(5660300002)(30864003)(6486002)(966005)(8676002)(66476007)(66556008)(4326008)(2906002)(66946007)(41300700001)(316002)(478600001)(54906003)(31696002)(86362001)(6916009)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlFaGFPVG5UWXlQT3Azd2lHVGtFYWdRT1ZFVG9kQWErVWJWWjVCckNMUWl3?=
 =?utf-8?B?bFdCZUJhNDFxdnF0ZndYaVlpSm5GS0c0REwyK0JmRFNoQWZrUkV4MmE3dFJQ?=
 =?utf-8?B?RDNjcFVtcjY0TEJVbDVoVytoOXRHeVp0Zzh2RTFMVGRHOXJ5NkJRKzJEN1Bl?=
 =?utf-8?B?RXA3YUk1bXl6R2ptQTEweExIWlhVN1lhZ1BTbzlrdnF6bVBvZFVKd2g4VWJJ?=
 =?utf-8?B?OGorcGxPRTVuZ1FUQ05abThYN0JCWTZMdkRrOG0wMGdZdEdvVjJIQmtSTTd2?=
 =?utf-8?B?aUZldENtanpJdTRMQUhrUmc2TWQrSy9DeDdYcjkyQTJ4K3U5dHRqMmUyejdU?=
 =?utf-8?B?d1hsQU5QazA2eEc5bERlNFlkays4NEhhOTh6Ly85b0F6NlZQbmF1bnFDMEcy?=
 =?utf-8?B?K3RudkFRVG45UXNEb1h2TlM2a3VVZWtENFNwekMxbEozYVRCaWxUYmJTYTNI?=
 =?utf-8?B?cGdPdkNYekZSSEMvSXdoNy8vcG5LYnlnT1NyMFlrMzhVb2l4Zm9FNkNLNG1h?=
 =?utf-8?B?WjJrUkozVjFVcmpiWkJOdFRyNW41dGhrbWxVZWNleFZnK3RIbVhLTnZ1eWls?=
 =?utf-8?B?MkUxbmJjaGloTjdLVVE5Z0pwTXVqcG1kQnR4aTRpTUhRQmY3U05zZUFwbkZ5?=
 =?utf-8?B?NXpRNHBwNnZ0VDducklTSVJOcHhjd3lCUTAzNjh1OElFREsrT0x5VS9UWnlL?=
 =?utf-8?B?RWdabDhTbko3L2VWSi9SbzZNd0NFRjlZSlpEQnp1MGp0bnBHTHhsN05jR0w5?=
 =?utf-8?B?YjVmSnZKY2dOMDVMSUpXWjd4YjY2TXZoaTk2K2pHYm1rbXFkdURLK2FIbVhz?=
 =?utf-8?B?aysxdWFrT1V4NlFPeWlGMWg1TFRzS1dEWHJnR3ZBQ1BOcXRmd2ZFRWNzMUpu?=
 =?utf-8?B?bzV6Uk9vc2h0L21OY25leEhKNFJ3U0hiUGU5ZVZtVFMzS1I1cGJ1SDJLR000?=
 =?utf-8?B?L3RmeDZtWU83YmhkZG1PVUQ0Ui96emQvVXlVbk9Nd21NUkFzZGY2MVVWbWJy?=
 =?utf-8?B?c2J3bVBLYWdGVWZXMm54WGNmYWtRRHFCRFBlL2dzWXpuak9CVGJWSXlXdTY0?=
 =?utf-8?B?RkFQVXN4S21qQ3pwWHlKZklmYmh1WVp3bGg3NWsvc1loeE81dkxqa2thK1hG?=
 =?utf-8?B?WC90elNyN2xrSU5MaTNEL1orQzRpR2xlR043eWdJVlcyN2d4ZW8wMkNQK25L?=
 =?utf-8?B?L1ZqRTUwR0tFMGEzM25KTnhWQjJhYStwMXlJbExsT0hmMkpWRmJXS2lPSEdH?=
 =?utf-8?B?TVE5TkZZSUxWdzFRdEFNMVMrdy9pTzhGQ203cHlnUU5iNThpVFFWTW1YZWQ1?=
 =?utf-8?B?SU0weDF2MVMzNFlzcStqOThMeTU2eXUrK0ZsbEZtc2R5Vjk1ci91eVVoQ2I0?=
 =?utf-8?B?NWNaekdUdU9QZGR4eituMjhUV2xEK0dOTnlsS0xYTEpHTG1nV2p6dTFDWHox?=
 =?utf-8?B?WlNMeFJkZVhFRFVsOW5WQ1lQWHpYVDZPM0c3T3JUSUxJVnFhcERsdDBlaUJF?=
 =?utf-8?B?VjFpYjA3ZUhLQ2ZFUldqb3Z4MU0zeGNUNTc3a0hIYjVIL25MRmdlbkUzb0lI?=
 =?utf-8?B?SnAzS3BIdU8vTXJpQUtydnMyWmIxWk5hSzY5eTlncC8rV29FaWpPTk1kaS9Z?=
 =?utf-8?B?K3VsYTRRMFZvVW9teFI2cTM5eXpMZkdFL1VaUUovVytXdVNTMi8wQkQ4R05l?=
 =?utf-8?B?Q2ExUjVJNnF6MnBQRzFOaHNqOXJtNVhHdmZoaktkUHJoTlpXUHg3ZHN2QnM4?=
 =?utf-8?B?NjV1UnhjcmRHVjVvcnFtdi9wU3FCcHEycndKbVpJMlJFZkw4bGdMNm81RnFS?=
 =?utf-8?B?eDVRcys4R0dCZEwxdzlYZHFjUUxSRjlvRVNWNm90UUw1R2JOY2orZy81amI5?=
 =?utf-8?B?N0h6eGlZTEZCWk5CdjhQN3dLajRaODdtNktOMHE1c3RGMUR3NGFvc2FnYXAw?=
 =?utf-8?B?RU9HSktrVlNKQWZXd3BjSDliV3JQQVdtWUkzMkEzM0h3RzJXNDVBWDVUTXRK?=
 =?utf-8?B?SUNSQ3pYRVUvMDd1eUh2VEsrcG5SM0pmSkQ5YlVKUWZvVU0wMHQrTWFwa3BG?=
 =?utf-8?B?MlRkQ0ZtRGl5SWEvditJTk10SkxjUGpZM0xDVGVCcmU1SjJVaFVtaVlpa3VR?=
 =?utf-8?B?R1hIVjVpVlArYzZ4eHF5bFloQk0zT2d6TGxCOWY0UVFXUjhZK0ZMVE5ZWksx?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4c651a-67b4-4805-d907-08db2375be6e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 03:48:01.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKXNt4vpudFWCWv7mRSA7GAVXkSF40zhFW10SyxnyMrcmJTjh0hVRh/SIaBa6Qst72YRnoemftjPJocc54zQWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Marc for a quick and valuable feedback.

On 3/12/23 08:43, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, 10 Mar 2023 14:16:34 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> Hi Marc,
>>
>> On 3/7/23 02:32, Marc Zyngier wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, 06 Mar 2023 01:31:48 +0000,
>>> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>>>
>>>> The purpose of this patch is to address the T241 erratum T241-FABRIC-4,
>>>> which causes unexpected behavior in the GIC when multiple transactions
>>>
>>> nit: "The purpose of this patch" is superfluous. Instead, write
>>> something like:
>>>
>>> "The T241 platform suffers from the T241-FABRIC-4 erratum which
>>> causes..."
>>>
>> I'll fix in v2 patch.
>>
>>>> are received simultaneously from different sources. This hardware issue
>>>> impacts NVIDIA server platforms that use more than two T241 chips
>>>> interconnected. Each chip has support for 320 {E}SPIs.
>>>>
>>>> This issue occurs when multiple packets from different GICs are
>>>> incorrectly interleaved at the target chip. The erratum text below
>>>> specifies exactly what can cause multiple transfer packets susceptible
>>>> to interleaving and GIC state corruption. GIC state corruption can
>>>> lead to a range of problems, including kernel panics, and unexpected
>>>> behavior.
>>>>
>>>>   From the erratum text:
>>>>     "In some cases, inter-socket AXI4 Stream packets with multiple
>>>>     transfers, may be interleaved by the fabric when presented to ARM
>>>>     Generic Interrupt Controller. GIC expects all transfers of a packet
>>>>     to be delivered without any interleaving.
>>>>
>>>>     The following GICv3 commands may result in multiple transfer packets
>>>>     over inter-socket AXI4 Stream interface:
>>>>      - Register reads from GICD_I* and GICD_N*
>>>>      - Register writes to 64-bit GICD registers other than GICD_IROUTERn*
>>>>      - ITS command MOVALL
>>>
>>> Does is also affect cross-chip traffic such as SPI deactivation?
>>>
>> No, it is not impacted.
>>
>>>>
>>>>     Multiple commands in GICv4+ utilize multiple transfer packets,
>>>>     including VMOVP, VMOVI and VMAPP.
>>>>
>>>>     This issue impacts system configurations with more than 2 sockets,
>>>>     that require multi-transfer packets to be sent over inter-socket
>>>>     AXI4 Stream interface between GIC instances on different sockets.
>>>>     GICv4 cannot be supported. GICv3 SW model can only be supported
>>>>     with the workaround. Single and Dual socket configurations are not
>>>>     impacted by this issue and support GICv3 and GICv4."
>>>
>>> Do you have a public link to this erratum? This is really something
>>> that we should be go back to when changing things in the GIC code
>>> (should we ever use MOVALL, for example).
>>>
>> https://developer.nvidia.com/docs/t241-fabric-4/nvidia-t241-fabric-4-errata.pdf
> 
> Great. Please add this to the commit message and a comment next to the
> workaround code.
> 
I'll do it.


> [...]
> 
>>>> +static inline void __iomem *gic_dist_base_read_alias(irq_hw_number_t intid)
>>>> +{
>>>> +     struct dist_base_alias *base_alias;
>>>> +     int i;
>>>> +
>>>> +     if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
>>>> +             base_alias = gic_data.base_read_aliases;
>>>> +             for (i = 0; i < gic_data.nr_dist_base_aliases; i++) {
>>>> +                     if (base_alias->base &&
>>>> +                        (intid >= base_alias->intid_start) &&
>>>> +                        (intid <= base_alias->intid_end)) {
>>>> +                             return base_alias->base;
>>>> +                     }
>>>> +                     base_alias++;
>>>> +             }
>>>> +     }
>>>
>>> Each distributor has the exact same number of SPIs. So why isn't this
>>> just a division that gives you a distributor number?
>>>
>>
>> I considered creating a generic function that could potentially be
>> utilized in the future for other Workarounds (WARs).
>>
>> I'll change to this in v2.
>>
>> static inline void __iomem *gic_dist_base_alias(irq_hw_number_t intid)
>> {
>>          u32 chip;
>>
>>          if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
>>                  /**
>>                   *  {E}SPI mappings for all 4 chips
>>                   *    Chip0 = 32-351
>>                   *    Chip1 = 52-671
> 
> s/52/352/, right?
Thanks, typo, fix in v2.

> 
>>                   *    Chip2 = 672-991
>>                   *    Chip3 = 4096-4415
>>                   */
>>                  switch (__get_intid_range(intid)) {
>>                  case SPI_RANGE:
>>                          chip = (intid - 32) / 320;
>>                          break;
>>                  case ESPI_RANGE:
>>                          chip = 3;
>>                          break;
>>                  default:
>>                          unreachable();
>>                  }
>>                  BUG_ON(!t241_dist_base_alias[chip]);
> 
> You can drop this BUG_ON(), and replace it with on at probe time.
> 
>>                  return t241_dist_base_alias[chip];
>>          }
>>
>>          return gic_data.dist_base;
>> }
> 
> Yup, that's much better.
> 
>>
>>>> +
>>>> +     return gic_data.dist_base;
>>>> +}
>>>> +
>>>>    static inline void __iomem *gic_dist_base(struct irq_data *d)
>>>>    {
>>>>         switch (get_intid_range(d)) {
>>>> @@ -346,7 +377,7 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
>>>>         if (gic_irq_in_rdist(d))
>>>>                 base = gic_data_rdist_sgi_base();
>>>>         else
>>>> -             base = gic_data.dist_base;
>>>> +             base = gic_dist_base_read_alias(irqd_to_hwirq(d));
>>>>
>>>>         return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
>>>>    }
>>>> @@ -580,6 +611,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>>>>         enum gic_intid_range range;
>>>>         unsigned int irq = gic_irq(d);
>>>>         void __iomem *base;
>>>> +     void __iomem *base_read_alias;
>>>>         u32 offset, index;
>>>>         int ret;
>>>>
>>>> @@ -594,14 +626,17 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>>>>             type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
>>>>                 return -EINVAL;
>>>>
>>>> -     if (gic_irq_in_rdist(d))
>>>> +     if (gic_irq_in_rdist(d)) {
>>>>                 base = gic_data_rdist_sgi_base();
>>>> -     else
>>>> +             base_read_alias = base;
>>>> +     } else {
>>>>                 base = gic_data.dist_base;
>>>> +             base_read_alias = gic_dist_base_read_alias(irqd_to_hwirq(d));
>>>> +     }
>>>>
>>>>         offset = convert_offset_index(d, GICD_ICFGR, &index);
>>>> -
>>>> -     ret = gic_configure_irq(index, type, base + offset, NULL);
>>>> +     ret = gic_configure_irq(index, type, base + offset, NULL,
>>>> +                             base_read_alias + offset);
>>>>         if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
>>>>                 /* Misconfigured PPIs are usually not fatal */
>>>>                 pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
>>>> @@ -1719,6 +1754,70 @@ static bool gic_enable_quirk_hip06_07(void *data)
>>>>         return false;
>>>>    }
>>>>
>>>> +static bool gic_enable_quirk_nvidia_t241(void *data)
>>>> +{
>>>> +#ifdef CONFIG_ACPI
>>>> +     struct dist_base_alias *base_alias;
>>>> +     struct acpi_table_header *madt;
>>>> +     int i, intid, nchips = 0;
>>>> +     acpi_status status;
>>>> +     phys_addr_t phys;
>>>> +
>>>> +     status = acpi_get_table(ACPI_SIG_MADT, 0, &madt);
>>>> +     if (ACPI_FAILURE(status))
>>>> +             return false;
>>>> +
>>>> +     /* Check NVIDIA OEM ID */
>>>> +     if (memcmp(madt->oem_id, "NVIDIA", 6)) {
>>>
>>> What guarantees do we have that this string will always be present?
>>> "oem_id" is usually updated to reflect the integrator, not the
>>> silicon vendor.
>>>
>>
>> Our company provides UEFI firmware porting guidelines to OEMs that
>> ensure the MADT table generation, along with the ACPI header, remains
>> unaltered. Thanks to your input, we are now looking into alternative
>> approaches for identifying platform types and removing our dependence
>> on ACPI. Specifically, we are interested in utilizing the SMCCC API
>> to detect the CHIP. Determine whether the individual chips are present
>> by referring to the GICR regions described in MADT.
> 
> Seems like a reasonable alternative.
> 
>>
>>
>>>> +             acpi_put_table(madt);
>>>> +             return false;
>>>> +     }
>>>> +
>>>> +     /* Find the number of chips based on OEM_TABLE_ID */
>>>> +     if ((!memcmp(madt->oem_table_id, "T241x3", 6)) ||
>>>> +         (!memcmp(madt->oem_table_id, "T241c3", 6))) {
>>>> +             nchips = 3;
>>>> +     } else if ((!memcmp(madt->oem_table_id, "T241x4", 6)) ||
>>>> +                (!memcmp(madt->oem_table_id, "T241c4", 6))) {
>>>> +             nchips = 4;
>>>> +     }
>>>
>>> Same question for these. This seems pretty fragile.
>>>
>> This can be avoid for the SMCCC based platform detection.
>>
>>>> +
>>>> +     acpi_put_table(madt);
>>>> +     if (nchips < 3)
>>>> +             return false;
>>>> +
>>>> +     base_alias = kmalloc_array(nchips, sizeof(*base_alias),
>>>> +                                GFP_KERNEL | __GFP_ZERO);
>>>
>>> You are fully initialising the structures, right? So why the
>>> __GFP_ZERO?
>> Yes, not needed. will use the staic array since size is small after
>> removing INTID_start/end feilds.
>>
>>>
>>>> +     if (!base_alias)
>>>> +             return false;
>>>> +
>>>> +     gic_data.base_read_aliases = base_alias;
>>>> +     gic_data.nr_dist_base_aliases = nchips;
>>>> +
>>>> +     /**
>>>> +      * Setup GICD alias and {E}SPIs range for each chip
>>>> +      * {E}SPI blocks mappings:
>>>> +      *    Chip0 = 00-09
>>>> +      *    Chip1 = 10-19
>>>> +      *    Chip2 = 20-29
>>>> +      *    Chip3 = 30-39
>>>
>>> What are these ranges? From the code below, I can (sort of) guess that
>>> each chip has 10 registers in the SPI/ESPI range, with chips 0-1
>>> dealing with SPIs, and chips 2-3 dealing with ESPIs.
>>>
>>> It would be a lot clearer if you indicated the actual INTID ranges.
>> Agree.
>>
>>>
>>>> +      */
>>>> +     for (i = 0; i < nchips; i++, base_alias++) {
>>>> +             phys = ((1ULL << 44) * i) | 0x23580000;
>>>
>>> Where is this address coming from? Can it be inferred from the MADT?
>>> It would also be a lot more readable if written as:
>>>
>>> #define CHIP_MASK       GENMASK_ULL(45, 44)
>>> #define CHIP_ALIAS_BASE 0x23580000
>>>
>> I'll define macros for constants. Use the offset, global GICD-PHYS,
>> and CHIP number to get the alias addressses.
>>
>> #define T241_CHIPN_MASK                 GENMASK_ULL(45, 44)
>> #define T241_CHIP_GICDA_OFFSET          0x1580000
>>
>>       phys = gic_data.dist_phys_base + T241_CHIP_GICDA_OFFSET;
>>       phys |= FIELD_PREP(T241_CHIPN_MASK, i);
>>
>>
>>>                   phys = CHIP_ALIAS_BASE;
>>>                   phys |= FIELD_PREP(CHIP_MASK, i);
>>>
>>>> +             base_alias->base = ioremap(phys, SZ_64K);
>>>> +             WARN_ON(!base_alias->base);
>>>> +
>>>> +             intid = i < 3 ? 32 + i * 10 * 32 : ESPI_BASE_INTID;
>>>> +             base_alias->intid_start = intid;
>>>> +             base_alias->intid_end = intid + 10 * 32 - 1;
>>>
>>> This really is obfuscated. And it also shows that we really don't need
>>> the INTID ranges in the data structure. You can easily get to the chip
>>> number with something like:
>> ACK
>>
>>>
>>>           switch (__get_intid_range(intid)) {
>>>           case SPI_RANGE:
>>>                   chip = (intid - 32) / 320;
>>>                   break;
>>>           case ESPI_RANGE:
>>>                   chip = (intid - ESPI_BASE_INTID) / 320;
>>>                   break;
>>>           }
>>>
>>>           alias = base_alias[chip];
>>>
>>> Bonus point if you add a #define for the magic numbers.
>>>
>> ACK
>>
>>>> +     }
>>>> +     static_branch_enable(&gic_nvidia_t241_erratum);
>>>> +     return true;
>>>> +#else
>>>> +     return false;
>>>> +#endif
>>>> +}
>>>
>>> How about moving the whole function under #ifdef CONFIG_ACPI?
>>>
>>
>> If you're not satisfied with SMCCC-based platform detection, I'll
>> make the necessary changes. We value your input and would appreciate
>> your opinion on whether we should use SMCCC or ACPI-OEM-ID based
>> platform detection. Our preference is to go with SMC if that's
>> agreeable to you.
> 
> If you can guarantee that this FW-based discovery will always be
> available, then this is a more robust way of doing it.
> 
We can assure you that the FW-based discovery will be available on
T241 platform. Thank you for acknowledging the alternative mechanism.

>>
>>
>> #define SMCCC_JEP106_BANK_ID(v)         FIELD_GET(GENMASK(30, 24), (v))
>> #define SMCCC_JEP106_ID_CODE(v)         FIELD_GET(GENMASK(22, 16), (v))
>> #define SMCCC_JEP106_SOC_ID(v)          FIELD_GET(GENMASK(15, 0), (v))
>>
>> #define JEP106_NVIDIA_BANK_ID           0x3
>> #define JEP106_NVIDIA_ID_CODE           0x6b
>> #define T241_CHIPN_MASK                 GENMASK_ULL(45, 44)
>> #define T241_CHIP_GICDA_OFFSET          0x1580000
>> #define T241_CHIP_ID                    0x241
>>
>> static bool gic_enable_quirk_nvidia_t241(void *data)
>> {
>>          unsigned long chip_bmask = 0;
>>          struct arm_smccc_res res;
>>          phys_addr_t phys;
>>          u32 i;
>>
>>          if ((arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2) ||
>>              (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)) {
>>                  return false;
>>          }
>>
>>          arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>>                               ARM_SMCCC_ARCH_SOC_ID, &res);
>>          if ((s32)res.a0 < 0)
>>                  return false;
>>
>>          arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
>>          if ((s32)res.a0 < 0)
>>                  return false;
> 
> Most of this should probably directly come from the soc_id
> infrastructure.  It would need to probe early and expose the low-level
> data.
> 
Agree, I will move the above code to drivers/firmware/smccc with a new patch.

--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -17,9 +17,14 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;

  bool __ro_after_init smccc_trng_available = false;
  u64 __ro_after_init smccc_has_sve_hint = false;
+bool __ro_after_init smccc_has_soc_id;
+s32 __ro_after_init smccc_soc_id_version;
+s32 __ro_after_init smccc_soc_id_revision;

  void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
  {
+       struct arm_smccc_res res;
+
         smccc_version = version;
         smccc_conduit = conduit;

@@ -27,6 +32,21 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
         if (IS_ENABLED(CONFIG_ARM64_SVE) &&
             smccc_version >= ARM_SMCCC_VERSION_1_3)
                 smccc_has_sve_hint = true;
+
+       if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
+           (smccc_conduit != SMCCC_CONDUIT_NONE)) {
+               arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+                                    ARM_SMCCC_ARCH_SOC_ID, &res);
+               if ((s32)res.a0 >= 0) {
+                       smccc_has_soc_id = true;
+                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
+                       smccc_soc_id_version = (s32)res.a0;
+                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
+                       smccc_soc_id_revision = (s32)res.a0;
+               } else if ((s32)res.a0 != SMCCC_RET_NOT_SUPPORTED) {
+                       pr_err("ARCH_SOC_ID returned error: %lx\n", res.a0);
+               }
+       }
  }

GICv3:

#define T241_CHIPN_MASK         GENMASK_ULL(45, 44)
#define T241_CHIP_GICDA_OFFSET  0x1580000
#define SMCCC_SOC_ID_MASK       0x7f7fffff
#define SMCCC_SOC_ID_T241       0x036b0241

static bool gic_enable_quirk_nvidia_t241(void *data)
{
         unsigned long chip_bmask = 0;
         phys_addr_t phys;
         u32 i;

         /* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
         if (!smccc_has_soc_id || (smccc_soc_id_version < 0) ||
             ((smccc_soc_id_version & SMCCC_SOC_ID_MASK) != SMCCC_SOC_ID_T241)) {
                 return false;
         }
