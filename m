Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20DD6B4001
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCJNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCJNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:15:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0121E6804
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:15:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H27cTKKKurl2KPRXExDShSNdEUxOuwEq5WbUi5n5UN9eU3GMKjylPF2M1kjEbLCb+rwv7NI/BIp3VouFuJToUcTYobuNW82mo8plbMbJCbuBUA61WcE/7dZ/IrjAlcC7J90A/rhVNLqaOdICS7N9qHkR+5Y++9KR+ylcwMr6fIsrd4ZIOtlOJ8CKoSs1Rt71KmfU5kFVy3esH5YJz93R4c2yOu39ZxyL8T5HT6EM85UBwaVB6YQ+838OExktJ3386pDQXraOy13Bz6Hl7mhhK5Kg0eIuAaYspnTeOBtsI1p5UCQSBD2+xpk8MDbI3rOErOenPROlaJwmNX/820qBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSRQKXXG5MHm57sI3lZtuA+HhUxVIwCY6RaNhYj1+9I=;
 b=gjGnUiwjhEZROOaRDieiCl7nIc6K9SPvfY7cm6My8jACLtCCa4bAkUymoLj2pCR4dzEZdP+a8h00J3ajT6mvE+SEtggwYsVcth+3Uj5qgKjBTRUminKC4OPMUjZTfzyJ952ZUoL7/Hkw38BPb9Gfk0xeeZzvfviuE22Wy1LwQlLmjgmJQkvAT2NaJUISROMiYfYF9JPwy0FxogH54ZlOD+l5uqGKje6xzgJAwVPINHCSibkVs6G79K3kcC7nTNr9GZCmGpf7w2PkVkEqvktRf9Jojh5Y30ptSEovGmDUbj8CQNulZTEpcjr/ShCFtstAA5DekMzqjeQBnEc+wmEYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSRQKXXG5MHm57sI3lZtuA+HhUxVIwCY6RaNhYj1+9I=;
 b=BH8xEl+Zx9+ec3dU4KgfA8QiZGgXCyETPEuLWQvYGX9mb3tf6rFgiMEpbVHxEx/i6zTrtni78qS26Zol573zYayKcHgqJJNMh8UM6t3A1peIR/KMJivu14QxARdJMhliQX+tY5J4iUnAO4nWtsQqAhVVFex9kEiVyrOpjIQSx1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 13:15:33 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::b64d:8d0e:8e08:d979]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::b64d:8d0e:8e08:d979%3]) with mapi id 15.20.6156.029; Fri, 10 Mar 2023
 13:15:33 +0000
Message-ID: <ce410155-1052-cd0a-60bf-2807e6376ddd@amd.com>
Date:   Fri, 10 Mar 2023 18:43:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] [RFC] drm/drm_buddy fails to initialize on 32-bit
 architectures
To:     =?UTF-8?Q?Lu=c3=ads_Mendes?= <luis.p.mendes@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     akpm@linux-foundation.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAEzXK1oghXAB_KpKpm=-CviDQbNaH0qfgYTSSjZgvvyj4U78AA@mail.gmail.com>
 <5e192700-c54a-04cf-a223-281af7af0457@amd.com>
 <CAEzXK1qPjYxDiRVTy8McXbagC8JKgtu+C0E+-VP3NHZvtYdZ+g@mail.gmail.com>
Content-Language: en-US
From:   Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CAEzXK1qPjYxDiRVTy8McXbagC8JKgtu+C0E+-VP3NHZvtYdZ+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::28) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 6303c638-b190-493d-c4ca-08db21698721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/q6xhxlngzyQ/21N+fUDCPaFCVtGxijsr+6Q8Xeuli84IEYTKhm/rdrfAm7nj1A7YCv3d7j87NqnWhjQKGCUD8FOdg+ndhjj08lYegluZwYp1R3KuJVrFN7uevta4Ue16L166sqbS3htsdGrJatoZmEhOLv+QII40UpU9S4fc+1JVciyzVxwFQevNs+qC2QaOMAJJW7xXwv3P5jCvIOsKsuKtqxag2TIoRzb+YLVlA2R5Zdl+SDVM+igbUWnS+WtC6wqCqsRTtnc/cmDcrEzbMV5tD28dSBuuLWpIbpNRLgwc6HddcpoofwMB+YE2uUiDzyAUoAfqEiH1QdhvLJqkOU7cfm3j7RiswQM4LumniPZeqch4Wsi48esbFNlkfr1D9Nbq+6iOMulVzIUEJRr1weQDaTreDBDzlczDI1Zvn0k81NSv1i7wCnpxgVB2HXMRWm9k8Isw59tcgTFasd6lyezT3p5qwbye2F+EQt6DPJx/Ey7j9EnYCaYkKXzBSNVOT9kb9YqQP0+F8ou0fQusNs78kyn1Mc2PWshlJgWEj6PNz1p/6lTa6Rz+Ya4EW0PgBUXhgpkfiVDc0ealZMOzJsEKan8tVUalt0DbnjZE3UWK4BdcKeqpAC+SlAxsfL/wMekMZy9XFN2aF1B1AU6zakw3c/ZRnMGG9VJdR5SZNab1wyqM0WPl7+Z6GVCev0g2pR4TvzPXIE5Q40mYu8ePkQzlGqjDkemFYqzIdxWts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4342.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(31686004)(83380400001)(6666004)(66574015)(26005)(36756003)(53546011)(54906003)(316002)(110136005)(38100700002)(6636002)(186003)(6512007)(2616005)(6486002)(6506007)(5660300002)(478600001)(41300700001)(8676002)(4326008)(8936002)(66476007)(4001150100001)(66556008)(2906002)(66946007)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTh2TU9IakM4ZE9pRmk0bXE1SDZaNnQrMjdMMlVCV3U2Rm94eG1sNGxCQ3lR?=
 =?utf-8?B?K3RyUThkMmQ2OUlDcGZZS1dKR2NKZnpPKzlyZ1J0WjVmeHJTTU90L1FEQm82?=
 =?utf-8?B?Umk2T3RSRTgwK1pWYmd6MVJ6SGRQUmRCdHVNMzVPK0h4R3BTQkgwYWhyL1Jl?=
 =?utf-8?B?MFIzTklGNEgzcnJhUGlkVEZ2NVFsTU9tREFMTGJRSkZ2T2lWczVxRlJoaDNo?=
 =?utf-8?B?RUdUa2dEai82blQyd0VOcWVLQzN6TWtvT3lsMTlZVmRvMkxWVEp2SEpnQWJw?=
 =?utf-8?B?dUp6ZUZaUEpLWEFRc1dJM3h5T2Nubm0wRGRzajJIRFVYVmcyWEZWY2hpcnZy?=
 =?utf-8?B?VkZWczkvODEwS2pheG5CRmF5UnJuVWwzd0xEd0hNQ1A0eVl2RVc4eDVoS3RM?=
 =?utf-8?B?WTRxRHM1T3dGOVB1WmVmWURGdXNFMnl6MjZKUml0bFVRamhveHNvN0I3cU1O?=
 =?utf-8?B?WFhIb3JURUhRVTFmY3lhQ0pjNjlDTS9lRk9ZUno5clptRnV6d2I4YTVwUkhq?=
 =?utf-8?B?QVdLUUljcHJxSDlxMUtBSGZjZ0UxdzlhYkR0cU5hRnZVZ0Vpa3B0M2txZmVm?=
 =?utf-8?B?YVRDY2U0K2ZZays3Ympzd29NMmh0dHc5QWhRV1BXbTg4ZkIrcGUrV3BiMnYw?=
 =?utf-8?B?VGhLazc5RURCM0xibzZCZ0ZjdFhSVmlUTnRNYjNQTFNkZzNLWDBGR25DcGZU?=
 =?utf-8?B?OVc3VlhwZ281ZEI2WE50c3BoaFdZS2NCL1JzMnhVeExlSnlYd1paYVVHZDlQ?=
 =?utf-8?B?anZUZVFOK3NlU0dTa0dWUE43MUg1TERiamVFdk9VUGlmOFk2ZVRGTUhtN2hU?=
 =?utf-8?B?eHU1OHBRNk1aRUZrS3pDR2Z5L0MwZ0VaMTZ6VWlxWlI5NjhuKzVLcGdyU3pL?=
 =?utf-8?B?dkpnQ0s1K2gzdTBqM25EUmdCQmpKNkkzcEtQYm1uYnFkcU1iaFcwVDd4bVVz?=
 =?utf-8?B?V1hsVUxQdmI5b2JRMFgrTkRqZmt1RWsyZ3pZMndiZmNDMi9ET0w1NE5RTXox?=
 =?utf-8?B?VTNQMHdVa2FsK2U1eElMN0VjSGloVDlpSUJNVEJGbGdjOFlLWVRCcDA2aC93?=
 =?utf-8?B?NlQwcU5qMHgwRnpNaW9oVUM1Q0JqeXFtKzMxU0FJOVhPNTUzSzNTVndzRm1B?=
 =?utf-8?B?N1ZsWnZuSzRNaTlwL2thdWVFOCtQdDV6YlU0QVFmelUwYjZNcEc2VWNHZnZp?=
 =?utf-8?B?VXF2ZEZ5TVo2Y1JYejZHZkNreFVHOSt6b255cHVMaUNDVzlhQmE3NG1TUk9P?=
 =?utf-8?B?Q0RTY0s1RzdWdkl2ZjkvMTdvMGsxQlMzN2kxTDBkeVNPZkJ4elN5aEJidnJY?=
 =?utf-8?B?Y04rS2V6OVpxYTEzbko5eEZqdUY5dzdxRCtOMTl5S002a2tCdm5aVDJMaDRn?=
 =?utf-8?B?c3gzSGZhdjVLNEpVcUVjWDV3QlVpKzlERGNsOVFLbTB0V0dsMGlWSFVieStF?=
 =?utf-8?B?YlhPc3lhZFpJMFRGblJ6K2pLODNOQXIwbytlYXcrcWR4cWVrSkRaSHZ5Y2Nl?=
 =?utf-8?B?YzNRQWlsSFBKMDFKN0lHcjQrZzVWV1JneU1pamJnYXNNZDRWYWRRRlpCK0Jp?=
 =?utf-8?B?a2VMUCtDQTV2di9JQnRkRlIyMThMSUVaZWVQUzVsbHd3RzJoQTVJR3lROFFt?=
 =?utf-8?B?MHlnYUFmOG82Q1NpMCtEc0lUSnVMSHVUQ0hrcjlBSmpFZWdVaU5ydHRNM2xE?=
 =?utf-8?B?eE9LZ3JYTEV6dGZMN1M4M1lDSER4VUFlMktsNG9DazJWdnZPM0N0Mk81cmJl?=
 =?utf-8?B?SVVHSUlsOThha0I5TWljQ3JNWllUWVB1RlVwSXExV3pOMHFJUVVYVHJNOFZX?=
 =?utf-8?B?cGZOdlE2em9IM1NGUjlnV1BHN3FmWnNMSUZIWFdWREVKdXdqRWtOWVcwbEw5?=
 =?utf-8?B?WFc5QWhJUUVMYTdTVFZjUi8xTnhjd3B1QkNWWFRndVA0SWtPU0tpcS9jN0xs?=
 =?utf-8?B?V3NPOEJpNTNZLzUralFxM3dPaEIwekUwdUFDV1c4aURRVm9ob2FPeHUwSWFa?=
 =?utf-8?B?c015TWpWUzU4UXNkSCt3TUxHY0lXM1pVZWdUNjA0Ynl4dC9sem9HOTI3UjJJ?=
 =?utf-8?B?NjFnNXBpTm1XU0hYTDNYTWZRZnFZSFA1Rm5YQlBZT29IaGVmYXgvTlNQbkhZ?=
 =?utf-8?Q?NEClSrEKT0e7E8IB+9WBdVjjj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6303c638-b190-493d-c4ca-08db21698721
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 13:15:33.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNHnsnBmmhK8XZcofAhwje3oTmfqf2KOWZBrrkBU8pmYXMy2AGYTpwdh0GJNzfJsvHi99CoMWMQdP943k7Mf7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2023 3:42 PM, Luís Mendes wrote:
> Hi,
>
> Ping? This is actually a regression.
> If there is no one available to work this, maybe I can have a look in
> my spare time, in accordance with your suggestion.
>
> Regards,
> Luís
>
> On Tue, Jan 3, 2023 at 8:44 AM Christian König <christian.koenig@amd.com> wrote:
>> Am 25.12.22 um 20:39 schrieb Luís Mendes:
>>> Re-sending with the correct  linux-kernel mailing list email address.
>>> Sorry for the inconvenience.
>>>
>>> The proposed patch fixes the issue and allows amdgpu to work again on
>>> armhf with a AMD RX 550 card, however it may not be the best solution
>>> for the issue, as detailed below.
>>>
>>> include/log2.h defined macros rounddown_pow_of_two(...) and
>>> roundup_pow_of_two(...) do not handle 64-bit values on 32-bit
>>> architectures (tested on armv9 armhf machine) causing
>>> drm_buddy_init(...) to fail on BUG_ON with an underflow on the order
>>> value, thus impeding amdgpu to load properly (no GUI).
>>>
>>> One option is to modify rounddown_pow_of_two(...) to detect if the
>>> variable takes 32 bits or less and call __rounddown_pow_of_two_u32(u32
>>> n) or if the variable takes more space than 32 bits, then call
>>> __rounddown_pow_of_two_u64(u64 n). This would imply renaming
>>> __rounddown_pow_of_two(unsigne
>>> d long n) to
>>> __rounddown_pow_of_two_u32(u32 n) and add a new function
>>> __rounddown_pow_of_two_u64(u64 n). This would be the most transparent
>>> solution, however there a few complications, and they are:
>>> - that the mm subsystem will fail to link on armhf with an undefined
>>> reference on __aeabi_uldivmod
>>> - there a few drivers that directly call __rounddown_pow_of_two(...)
>>> - that other drivers and subsystems generate warnings
>>>
>>> So this alternate solution was devised which avoids touching existing
>>> code paths, and just updates drm_buddy which seems to be the only
>>> driver that is failing, however I am not sure if this is the proper
>>> way to go. So I would like to get a second opinion on this, by those
>>> who know.
>>>
>>> /include/linux/log2.h
>>> /drivers/gpu/drm/drm_buddy.c
>>>
>>> Signed-off-by: Luís Mendes <luis.p.mendes@gmail.com>
>>>> 8------------------------------------------------------8<
>>> diff -uprN linux-next/drivers/gpu/drm/drm_buddy.c
>>> linux-nextLM/drivers/gpu/drm/drm_buddy.c
>>> --- linux-next/drivers/gpu/drm/drm_buddy.c    2022-12-25
>>> 16:29:26.000000000 +0000
>>> +++ linux-nextLM/drivers/gpu/drm/drm_buddy.c    2022-12-25
>>> 17:04:32.136007116 +0000
>>> @@ -128,7 +128,7 @@ int drm_buddy_init(struct drm_buddy *mm,
>>>            unsigned int order;
>>>            u64 root_size;
>>>
>>> -        root_size = rounddown_pow_of_two(size);
>>> +        root_size = rounddown_pow_of_two_u64(size);
>>>            order = ilog2(root_size) - ilog2(chunk_size);
>> I think this can be handled much easier if keep around the root_order
>> instead of the root_size in the first place.
>>
>> Cause ilog2() does the right thing even for non power of two values and
>> so we just need the order for the offset subtraction below.
Could you try with ilog2() and see if you are getting the right value 
for size as suggested
by Christian.

Thanks,
Arun
>>
>> Arun can you take a closer look at this?
>>
>> Regards,
>> Christian.
>>
>>>            root = drm_block_alloc(mm, NULL, order, offset);
>>> diff -uprN linux-next/include/linux/log2.h linux-nextLM/include/linux/log2.h
>>> --- linux-next/include/linux/log2.h    2022-12-25 16:29:29.000000000 +0000
>>> +++ linux-nextLM/include/linux/log2.h    2022-12-25 17:00:34.319901492 +0000
>>> @@ -58,6 +58,18 @@ unsigned long __roundup_pow_of_two(unsig
>>>    }
>>>
>>>    /**
>>> + * __roundup_pow_of_two_u64() - round up to nearest power of two
>>> + * (unsgined 64-bits precision version)
>>> + * @n: value to round up
>>> + */
>>> +static inline __attribute__((const))
>>> +u64 __roundup_pow_of_two_u64(u64 n)
>>> +{
>>> +    return 1ULL << fls64(n - 1);
>>> +}
>>> +
>>> +
>>> +/**
>>>     * __rounddown_pow_of_two() - round down to nearest power of two
>>>     * @n: value to round down
>>>     */
>>> @@ -68,6 +80,17 @@ unsigned long __rounddown_pow_of_two(uns
>>>    }
>>>
>>>    /**
>>> + * __rounddown_pow_of_two_u64() - round down to nearest power of two
>>> + * (unsgined 64-bits precision version)
>>> + * @n: value to round down
>>> + */
>>> +static inline __attribute__((const))
>>> +u64 __rounddown_pow_of_two_u64(u64 n)
>>> +{
>>> +    return 1ULL << (fls64(n) - 1);
>>> +}
>>> +
>>> +/**
>>>     * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigned value
>>>     * @n: parameter
>>>     *
>>> @@ -163,6 +186,7 @@ unsigned long __rounddown_pow_of_two(uns
>>>        __ilog2_u64(n)            \
>>>     )
>>>
>>> +
>>>    /**
>>>     * roundup_pow_of_two - round the given value up to nearest power of two
>>>     * @n: parameter
>>> @@ -181,6 +205,25 @@ unsigned long __rounddown_pow_of_two(uns
>>>     )
>>>
>>>    /**
>>> + * roundup_pow_of_two_u64 - round the given value up to nearest power of two
>>> + * (unsgined 64-bits precision version)
>>> + * @n: parameter
>>> + *
>>> + * round the given value up to the nearest power of two
>>> + * - the result is undefined when n == 0
>>> + * - this can be used to initialise global variables from constant data
>>> + */
>>> +#define roundup_pow_of_two_u64(n)            \
>>> +(                        \
>>> +    __builtin_constant_p(n) ? (        \
>>> +        ((n) == 1) ? 1 :        \
>>> +        (1ULL << (ilog2((n) - 1) + 1))    \
>>> +                   ) :        \
>>> +    __roundup_pow_of_two_u64(n)            \
>>> + )
>>> +
>>> +
>>> +/**
>>>     * rounddown_pow_of_two - round the given value down to nearest power of two
>>>     * @n: parameter
>>>     *
>>> @@ -195,6 +238,22 @@ unsigned long __rounddown_pow_of_two(uns
>>>        __rounddown_pow_of_two(n)        \
>>>     )
>>>
>>> +/**
>>> + * rounddown_pow_of_two_u64 - round the given value down to nearest
>>> power of two
>>> + * (unsgined 64-bits precision version)
>>> + * @n: parameter
>>> + *
>>> + * round the given value down to the nearest power of two
>>> + * - the result is undefined when n == 0
>>> + * - this can be used to initialise global variables from constant data
>>> + */
>>> +#define rounddown_pow_of_two_u64(n)            \
>>> +(                        \
>>> +    __builtin_constant_p(n) ? (        \
>>> +        (1ULL << ilog2(n))) :        \
>>> +    __rounddown_pow_of_two_u64(n)        \
>>> + )
>>> +
>>>    static inline __attribute_const__
>>>    int __order_base_2(unsigned long n)
>>>    {

