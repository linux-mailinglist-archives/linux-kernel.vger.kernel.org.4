Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190346CF161
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjC2RsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjC2RsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:48:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE743C34;
        Wed, 29 Mar 2023 10:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4JE/y60disf5pyHX56MIroNz1K6+udjwLWwfDLN/33/AiIL0J0fkH++DVBPPKjKsCCZJ5U/Gfl6Xum+ojMPsMAcHy8HH/o7yyBQZKZkyRn0I8Tg63r1rYkSar6MP9r9G5kBrqXft1D6T1j4ZYUvkd8dtItRDjCCaRx3+AgVfrvquXwP4mupfT1D1bEmaQPaPXJNwhLENfZpCSLRojhJ9A7+BfIpF7o4NujZiXIfeTx1ySe+y5qeIGtR83k2jFnwoDOJXaKD55xM0HRfonBndAaC8FbyiGP/1X3slhCEwKc9h6jTQBW0BMHs7XyyQSA6DGRawFGGnRbjd9nBrv5WDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St15u8TZqznzPzGRGjfaRQyANmEI7q4/Hz3r68LP0BA=;
 b=kMvMVlH4bnzMYjo7S4yQs1SQX+tAGf1v6Pr92vixpLz2p0Q6kQ4OlUspXoLQlrBjvVwnUyuWtR7wijT73C1fssPMrhlmSDic7ubJ8+UJHKslN+1L7PQLFn2AWnKwH9xBwlQgHeTrRR9KYH0LDwunPm3uJl1LMN1cAX5WBchDtVPms7rjd0dSRv35Ons4qudZhs/qU5GM6ONLHfFnPkDYDJmlMU+zAAjDKSYjuu97fuhYuWIowyCldTLug9UO6cbXP/65KwBYem5VWxdMmL+XteAk0qTWkKXBRVaHAp9WFIQAs+MtLaf6gGpYIHVLuGBaoQnAZmoa3nYBo2dPoD1/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St15u8TZqznzPzGRGjfaRQyANmEI7q4/Hz3r68LP0BA=;
 b=VAobZ68Q3kznwuVi/KxfRigcdHg6ccZjoT0YDFfIwhn7tSeKqh7Q8iHai8+1/AWqmNK6tz7KLbcOAsoMRf3ygEmFCweQSlNok+P9Lq/qRRg9qN8Y5K1Q6vhIPeE0/NroRRCv45ZKCM+BDXTd0GNziXIYpncvuGaofgS0wIef4nJlz+UjTGoiBSoV7U1ZMJ9dC3TgpJMvHlkPJE/rG2HWbwHWeECPen7fP0arI8WoZevmFp1Dx6m1FMza9AWFf36zWg51CP2v1zVhDDzqefWPlY6zpRgGafY2Uo9j9FLB8TBIb8kdi5Bvcnq6910gImmIEFjl3VVDu0tJL2zuEQkUGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Wed, 29 Mar
 2023 17:47:56 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6178.038; Wed, 29 Mar 2023
 17:47:56 +0000
Message-ID: <9846a44d-8d5f-f164-098f-e5f2b1ab99e1@nvidia.com>
Date:   Wed, 29 Mar 2023 12:47:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: mm: Increase MODULES_VSIZE to 512MB
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230326170756.3021936-1-sdonthineni@nvidia.com>
 <CAMj1kXF4MUGbuiW1bcupMs1VdxxE_74WWDt1YdUTg0o9ft+=JQ@mail.gmail.com>
 <159ceeab-09af-3174-5058-445bc8dcf85b@nvidia.com>
 <CAMj1kXGGUzzyN9BS7OeQcn3tvfmsH8Y_CJu5xQx-y7V7hEgXFA@mail.gmail.com>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <CAMj1kXGGUzzyN9BS7OeQcn3tvfmsH8Y_CJu5xQx-y7V7hEgXFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:806:24::35) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b80aa9-c1e8-4aaf-a11a-08db307dbac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbPzmWyOHgaFbSMHGjfFBzT74OAEunc9oPzEKARKmfaix28K+/e/LgNNzOa5HLD5HzOf4SX3l0jkWzLO1VnLp4auXUitxwfAm5gzVNRCvyApcjPtxHi0KYoBUIljicg/EGD1y/27jb92yxPqVPYMihiMfIYUs7hwpKYPIoJ+ZZYyPGIUu6sgrHUw6y91A53ENSKAnqANy9YWL8JeSTWbJFX55mrWKJjxm0sg4I1oQ0A3cTWgcu3sBnyVhs9slmvlBLSbZjaNMqL46TZ1CSNaH/0gsEmVyf4uHuj+sHb5HKj8u7vClS4HoeO6YrgyLaddtbYE8fyIaCoawvG1EvG6Ix/heDS7nw7wva1IJ1aPE5AcGYiseqUmiBknHL+Gkwj++vp6AiiHZs9XwEymAV3IlJAxT8EaRlueyjOOx7izrSqMLvBr8i/rV4ogtNvP3DYg2yhZhgV19RCQs1c29QSx+1Zc5XSN+ChmRK8XuWY+qGQoQz7FUPbcIOL0ni11sMULMDn79O0imB6YzMyD61GJxjJxM6DOtQREIrh4HppF/o49vy9AEVpTaAroHpnRs9occcZV7AD4m/AQqySq2r2aNJX+MuxdCo7438H30kSXtqztIfS1+460KwP/J8hvlQX3Ekp+WHEsnHSd0ZYZE0eGcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(66946007)(66476007)(8936002)(6916009)(316002)(41300700001)(5660300002)(83380400001)(6506007)(26005)(186003)(7416002)(54906003)(2616005)(6486002)(66556008)(478600001)(8676002)(6666004)(6512007)(107886003)(38100700002)(53546011)(4326008)(86362001)(31686004)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFp2NUdKSTZvU3JPOTE4Skd5bXhHTnFuOUExdVF0TVlrL2NQem81Zy9HNGd0?=
 =?utf-8?B?WDg0MEJFTG01NGZCQ3U5dFgzd29handTc2M0cmM5U0pZU1ZCeFhqVk02Q0dw?=
 =?utf-8?B?K2UyazYvejFVR1N5Z2dYdkQrU2pQcXBOQk9Rb0xkMzRWY2tMMUg3T1dyOFJL?=
 =?utf-8?B?bVZ2RHd3eVQwWFJZamJSa1dwa0RjbnloaGQ0WXcwbVE5bjhISDUvN25jQ0RW?=
 =?utf-8?B?c2s1V0lnWTgyYzV0NVNWY0hqS0lrMVYxVVY2VXpvMkFJeUpqU0xGYno2OTRV?=
 =?utf-8?B?T3FTZnJKVEhFK0cyRUFuUWJwT0IybFRXK0t6SzFHWjYvRndyQzNRK0lQek1K?=
 =?utf-8?B?NHRTcmVwZEQySFV1eHYzaHpxYXBkeExETFNZUVVIYjZidi9nRzVOUkdoZmdP?=
 =?utf-8?B?NVdCNnFtaFpxWVRBbU94dXRCQW02L1VnK3JsejNibU95RUlZeFhNMVFSdDBk?=
 =?utf-8?B?YlZDdkczUzFMOWVnK2xvejR3TkwxWWtQS2xBMjg0UHhCL1NWMlFKVGNIM3Rk?=
 =?utf-8?B?ZFRGOW1neWtYbnZydGpBYjVRdDBoZURJRUtUZ2JCaGVjWWRkTGNNdFV6NkZq?=
 =?utf-8?B?QjExSHZnVFF3dDVoYkNsT0xKWWc1dDNMaDJVckJEcDhCTjFLNzhVTVpTQUkw?=
 =?utf-8?B?emdTRVZRNzlLWklBdFFISjBXNit1cVR4MkZRMnRCQ2JnMU5LampTTTlEeS9k?=
 =?utf-8?B?MDZlR3VqWVlyWDR6dEREWStLcXBtdlNwYkRtYjZORVlUOFdITzdSOFBSaVFS?=
 =?utf-8?B?VE9OdnpSVnZBTVV6MmlScStzWXk1a2Z0SC9VemVqTkFhSlQ2dnJRSVlGdVRR?=
 =?utf-8?B?bmpZWnJMZmM0S042NTRtcHBsVFVMMzlPeGJGSzdCVk5xcmxlemVvRWRyOHNt?=
 =?utf-8?B?djg2SXhZN2kvM3U3eDI0UHZJSExOQlRvZHNGZzQydHpEQ3ZtK0xnZWFVK3Iw?=
 =?utf-8?B?S28rdkRXc1gyNERoUUdrNmJJWGgvenBweDNWWm9yL2VzYTNuZUJLSm9EUmtk?=
 =?utf-8?B?aEFPc0pjTjkyYXgyZ3dWM3Z5cWNMZHU2VlpPdHRVQVlsNjlydGVyOHNicDRW?=
 =?utf-8?B?UzRqQ0hnYkhBb2t6Tk5VMlcyMkphVDhTeGZQY3VDQWlzQnJFNHJ5QUpqcE53?=
 =?utf-8?B?c0xiRnZhbmEwYlY1eTVaN2wyVWxsNk5aV1pvSTRPYUZvQ0R2MURVNytoRlM3?=
 =?utf-8?B?RndlN0NiNjF0SmpWaFJ3MzNzeXRPZmZhaXQrMEJwVTBzN1pFSlpKdXRzeVBu?=
 =?utf-8?B?US95dEROQ2x4VVYzNnBLa3BVY2trS25EVXExamVEZ2ZaM3RXRy8zOXVRbmJO?=
 =?utf-8?B?Snl0dEpKZmNOd0tSdmZEMzVsWVVjdEpJRXltNTR0RjVBaEczeFMyb3JKRTNi?=
 =?utf-8?B?eFZmV05KV2owc0gvVVNZTmJCUXFNT3RLQkNlTVhHNnhXSW1RZ1BYeFBlL2pj?=
 =?utf-8?B?Y0F2OEFBRTkzZmtkclE4bHRIZmhtV2lqc3pBTm5mZm80ZFBXaEI3S1VlQmZ0?=
 =?utf-8?B?NGNjVGhoMFlPV3hWZEdzVlRuenZoME50enlnV3JvUFBaS1lhbG91dGVVSUtS?=
 =?utf-8?B?SUhaUHpOVTBwOWhqRUxuYVBlTE8xQ2dnZ2dSNWNBUVgxVmVjQ1JwanhBYSt5?=
 =?utf-8?B?NDVtb0g2d3dnNEZmUnlGNEZIV3Q1c2xSMjBPY085UkdUZTUzaWt2RzcwNTU4?=
 =?utf-8?B?R2FiREFYNEgyVVpOeHM2YUtQS0ZRNnI0a0pWWUF3cStYOS9UZU1OK2VaNzBM?=
 =?utf-8?B?S1hzY0lGQ0VvK09kSC9UbzNjVmJWSnFHODVTeU0zL1BuVzh0QXR6b3JwSVVY?=
 =?utf-8?B?MU90Nnozek9KY0d6aTVNS1lQVGwrZFJTdHk0YXhLZVU4THBMNEZqTGVtdVJU?=
 =?utf-8?B?N1dGbmV4U3hEOHpWODFLRlZJeDJYTXhaYXdCUENsbWtkU2RLRVFKci9JS0dx?=
 =?utf-8?B?OWJObk5NL293Tk9OeTdHbzBISUladHl3bnRPeHFMbXp3OGUrdmF6VmRjbXFG?=
 =?utf-8?B?VW1RSHFBWitvL1VLcmZ6VWswcWFLNXk1Z09vQ3pKTG1qZjV1TDZtR1ZlQW54?=
 =?utf-8?B?dEVtNS9oeis2VTZxK2lQMUMrWTRsbXJvUjhNQi9kMHMxL2NNcTBIVTZ4RUVV?=
 =?utf-8?Q?eG3qCASDiAqDDDzYaLlWRLuxm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b80aa9-c1e8-4aaf-a11a-08db307dbac8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:47:56.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvsMJlOrmyeSWRl3LsVMc9yns1aAExdjKBqsbW7WLBD9JKpTyxF9+qpFrF+KiW3KUKWFYDwGtmpDiVaWMimXyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/23 11:07, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, 26 Mar 2023 at 20:59, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> Thanks Ard for a quick feedback.
>>
>> On 3/26/23 12:35, Ard Biesheuvel wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Sun, 26 Mar 2023 at 19:08, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>>>
>>>> The allocation of modules occurs in two regions: the first region
>>>> MODULES_VSIZE (128MB) is shared with the core kernel, while the
>>>> the second region (2GB) is shared with other vmalloc callers.
>>>> Depending on the size of the core kernel, the 128MB region may
>>>> quickly fill up after loading a few modules, causing the system
>>>> to switch to the 2GB region.
>>>
>>> How much module space are you actually using? This 128 MiB region is
>>> not shared with vmalloc() so it should be dedicated to modules
>>> entirely.
>>>
>> Is it correct to say that if the KASLR feature is disabled, 128MB is
>> being shared between the kernel and modules? Approximately 110MB used
>> by the NVIDIA GPU driver, resulting in the usage of more than 128MB.
>>
>> root@localhost:~# cat /proc/kallsyms | grep -wE '_etext|_stext|_end'
>> ffff8000081d0000 T _stext
>> ffff800009390000 D _etext
>> ffff80000b4d0000 B _end
>>
>> root@localhost:~# cat /proc/vmallocinfo | more
>> 0xffff800001390000-0xffff800001450000  786432 move_module+0x2c/0x190 pages=11 vmalloc N0=11
>> 0xffff800001450000-0xffff8000014b0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
>> 0xffff8000014f0000-0xffff800001550000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
>> 0xffff800001590000-0xffff8000015f0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
>> 0xffff800001630000-0xffff800001690000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
>> 0xffff8000016d0000-0xffff800001740000  458752 move_module+0x2c/0x190 pages=6 vmalloc N0=6
>> 0xffff800001780000-0xffff8000017e0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
>> 0xffff800001820000-0xffff800001880000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
>> ...
>>
>> The first modules loaded at the address 0xffff800001390000.
>>
>> Less than 128MB is available for modules if KASLR is disabled.
>>
>>> If you are doing EFI boot, you may need to following patch to ensure
>>> that the 128 MiB region is actually the one being used.
>>>
>>> commit 010338d729c1090036eb40d2a60b7b7bce2445b8
>>> Author: Ard Biesheuvel <ardb@kernel.org>
>>> Date:   Thu Feb 23 21:41:01 2023 +0100
>>>
>>>       arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN
>>>
>>>
>> I have included your patch to prevent the incorrect detection of the
>> KASLR feature. Otherwise, experiencing the different error
>> "overflow in relocation type 261", R_AARCH64_PREL32. Seems this is
>> due to the incorrect initialization of module_alloc_base.
>>
> 
> Hmm, not sure - there was a report about this a while ago but I forgot
> the details.
> 
> In any case, could we perhaps try something like the below? That way,
> we still prefer allocating from the 128 MiB region that is within
> direct branching range from the core kernel.
> 
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -46,7 +46,7 @@
>   #define KIMAGE_VADDR           (MODULES_END)
>   #define MODULES_END            (MODULES_VADDR + MODULES_VSIZE)
>   #define MODULES_VADDR          (_PAGE_END(VA_BITS_MIN))
> -#define MODULES_VSIZE          (SZ_128M)
> +#define MODULES_VSIZE          (SZ_2G)
>   #define VMEMMAP_START          (-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
>   #define VMEMMAP_END            (VMEMMAP_START + VMEMMAP_SIZE)
>   #define PCI_IO_END             (VMEMMAP_START - SZ_8M)
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 5af4975caeb58ff7..b4affe775f23e84f 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -37,7 +37,7 @@ void *module_alloc(unsigned long size)
>                  /* don't exceed the static module region - see below */
>                  module_alloc_end = MODULES_END;
> 
> -       p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> +       p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_end - SZ_128M,
>                                  module_alloc_end, gfp_mask,
> PAGE_KERNEL, VM_DEFER_KMEMLEAK,
>                                  NUMA_NO_NODE, __builtin_return_address(0));

Thanks Ard, I'll include your suggested changes in v2 patch.
