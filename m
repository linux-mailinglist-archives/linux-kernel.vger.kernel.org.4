Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED56B4E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCJRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:19:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D08F539;
        Fri, 10 Mar 2023 09:19:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnLyngpBmhZMr/ZL9lZH9+Ka+XqpPJ5F5m+th3aaNz2gWfq3j7RNvWjKW82j4HKV3fdnBchZvINXgVPNZ1uig+/XZw+9hgG+ZcZwFa8yo3MAUiueNyTpUcdsbf34cSUIGVgtBX6dNqeAtjtZZPt5ITgQGGJ7wsbbOq6pTna2LkcCyflTt1PpNETMtttjTQyxuxnQD6Hr9XywGJgmITDFDkHUzTd3Fj5qHSwsexCyaY6x37MtvqfeXJz9v4UrSoYQouvHvrgTZJfhUs90dB3VWnwkoaHHaXiMpZ8hrBQrqyDMtD3ywhQrHRE7yASkD4Uh3ImrjgrQp6i6cSzgfmFEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxmw4vzCywWNhNAI/Ux6ko/DUPYLZCeyotWHI8xzczo=;
 b=lKxeGAqE5BR+L6d+S86VqVG/wH4FwCJOihn3Efr5V6OruSEjFTZAZ0Wpe1ETiW2CKabvSjZ1Taysm55CGFqmiIIFniH/OSIifUUxjxXBu0UnRnVNQOftH033pLWwdPtt3Q3AeLcKIgNSCjbetLz23BCgVRKXnYNO8NXJJ9w1xsNr9SN+Ih1/3/pItPXqfitB5aJH3xzaLbE2HWjLxLkvgksSF/9qcFnGdmN1STNGHD5bm6vjl9W8/5zku2oBrnKDcIuA3boFEOPlKObgJTXZkG7gDvoRndbpNQcGMy41o82prdGV3/XBiOlGlwt7T6W5DNbtf9OlCUvr2VH9+5VWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxmw4vzCywWNhNAI/Ux6ko/DUPYLZCeyotWHI8xzczo=;
 b=RTap02BqlrWwyCVZxAutJ/VDFpIvZ5qSWTbfFr3UEh3DVlSFnimSwaDNQB4ohFHcc6zNS3BDxOtt9YIYIVU4Rvl2OidDuzpunjFcTyFEcV10F7thxNtvLyJSR0HSLBEX+J7lgeDCprhvcAdfq6ND9u1IAxKNXB7FQpgw73hc75MCpgBNEB6Xu4iQsBEtx1r/s+wyMGk0hBvnZ2K4b3GTiJzVwmZdNbqplZKtH7sRd75uwutxFFxcj2D5YOjqIHNYdqM6zxwnlvU4UR1FFWcvGAfF6SOgWitrH+buxfDsiSi09UzSPi4N7/M40j0ggf/J/ADBKzOyj/rYXpeQ7xwO6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:19:18 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%4]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 17:19:18 +0000
Message-ID: <6733c921-3cca-cd7b-3846-0ab6ce172c14@nvidia.com>
Date:   Fri, 10 Mar 2023 09:19:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
To:     Krzysztof Kozlowski <krzk@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20230214115553.10416-1-dipenp@nvidia.com>
 <20230214115553.10416-5-dipenp@nvidia.com>
 <3c0ad963-ce69-bd5b-20cd-888e5fbdecaf@kernel.org>
 <7a8027c9-dc73-3684-c5f2-3071f315b3cd@nvidia.com>
 <a5e897e5-4cb9-d50f-47a8-ffb8bd8774cb@kernel.org>
 <18f9a6ca-a61b-4cbb-b729-1fdb6d48651a@nvidia.com>
 <ab9f7730-d399-0786-67e5-aad57716809e@kernel.org>
 <c1a78a59-c8ae-81e5-b641-a7cb75062ab3@nvidia.com>
 <f661f27f-f367-2948-1435-5b5fa43a3b46@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <f661f27f-f367-2948-1435-5b5fa43a3b46@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::27) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba7e050-1f96-43cf-f501-08db218b94c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hF2lecW3v/clw/6FAkdUVjxA/H3642txB2mdtc8gfe3rD1cjdPVRku3rvGYAsUI3N5AfImYIky2W5VEBMcwIrGF/8IbegQO0oEG62gfbjf25Nk6moZMaWsvDrqVKc5qvLK3kZoBPXOWwfvjcoEZYgaTGsk8UnPNg17LfSWjGOJd8SonF1squZemVXRdICNb2bPCIqa5su+Memyo0qzMeBzkixED0nba1MF5VhHLAHHst8QzW2zUOA+iLGSrVKOa7KuXdV8G//z8/3Kn5/mEDdM2ZEAYuyJsgrOetx8o7ksVOI8qOYHH/nMF6Hghw95TC6bPxD/qP7o0MkKI4HP9vU9TQLOg9NcbWhYhQM2X03QoOFQAxp+2HJYJoP6kwuCkPydMIK7oTSeXSzLVp73bTLaFV3r4osWiyRaW1h0ByHNxQqhfctxeSJmqj1N4GNSLe+BVeTzy7cI6iBoOAyFo0BCBgqLC2pIFpuM+neiPE2i0kWmdMtPrZeyu6999oWTT8zXd8L31yhgFOZL7DtaGLJsqvNap6i6Wlzo0r3lPxoyc6dC6potD7lljNrRzZpHXjqKp/AyuNq0JmRvQa5K5orOzPtA9RhtArUcl8YxGqgpyUSEFZg9IlHg8XDXh52oWOUuP9epZFFbM2A12YY+NJQd3ifEAKW8iRZeMF22zvUmi6epOcCq8BiJJrZGPU1KGIe0EoGYqAgJxz9b1utXhOSE6SFpwuxN7/tR/WWT+205fXnmVhAejG238qxUNO6n4eJXLY6VBvcDfGfLrabGxnM1dbZMqVrVQlLLrLp50mHrivhG+EQaGgnVjxN+ca45eeEfawX5UU95ETyuTNyI7rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(36756003)(478600001)(966005)(6486002)(316002)(7416002)(5660300002)(921005)(66476007)(66946007)(66556008)(8676002)(41300700001)(2906002)(53546011)(31696002)(86362001)(26005)(38100700002)(2616005)(6506007)(186003)(6666004)(6512007)(83380400001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjVwckd4VHVwRXBoWVVNcTUyME9uWU5BSytZNU1jN3lHWmUwY3pmTGZ5Uk5o?=
 =?utf-8?B?SzJtNm5xTENyTi9yNDB5bFlCUTBDbUlhZ3hrTWp0SmV3OUpIUVVYSERXWUt3?=
 =?utf-8?B?dENJczd2NGNlU0I4SUtKL3BTdlNzWjFrU3pxUFVzbkFJVEQxb3RMRWNXM2pz?=
 =?utf-8?B?ZGM0RmhOeEI3ZEw3dWI2WU1jZVdjUjJPNHVPZXRRUXpySUxhTTlJSjdZWmVK?=
 =?utf-8?B?MmVJV0Q4WjFWNnJUUFo0WE1GZGwyQ1dhMy9uNy95VXl3eW1ZM05jVWZnckp5?=
 =?utf-8?B?RUduTmN0Y2FySnJpa1YvWHJCVUlEOXNrTVZ0ZVVZVmF3WEUra2JFM0h3WXJ3?=
 =?utf-8?B?RzBnN3pSUE14d3lsQVp6R2tMRzl4cno4VXlUR2trdXlGTkFVK2VweGY4MGcv?=
 =?utf-8?B?ZVJWQkZyUVFRdjRoUjkvWHBObUIyS3lwUWJkS0t6Tms3SkhvTGFkT3lQd3Bt?=
 =?utf-8?B?RkpBdnNUb2tBSnNjOURoYjIxMEwyMHkrdjl4M3hHZjVCQWpmMkZST2dPVExM?=
 =?utf-8?B?UndYQk5XODZTdGxmV0dnWU9zS04ycStBVnluNk1GeXVYVlY1RCtpZk5sTjdk?=
 =?utf-8?B?VHp1YzFBbDFrZ01YWUQvUVdsclg5RG02Zm5tZ0hjUDQ3QnJaVW9GVDNDczJI?=
 =?utf-8?B?RXBFczY5VUJSRFloSGw3aFBWd0w5djFySjNEdEhEREtIQjlCRGdlOGw0VVFm?=
 =?utf-8?B?b1FzR1R1THBxLzJQZ0hoSloyVWY4RmpMcVB2aDRPUmZDVG9MMGc5Q21nS0M2?=
 =?utf-8?B?RUJROGVKZlFNeEVlUE5HTGxDT0hEaU10UnFGZkQ3dWw5MmwxT21tQ1dWRnBa?=
 =?utf-8?B?K1lBMm1qZnloMmNnclFNK2cvOWhLeFBzbjB1V3dyNVAzc0xhZzVuMFpIbjdj?=
 =?utf-8?B?K3NMVW12bi91TEJUb1QvdGhaYWlSdFo3TU9uT2cwOFFiK2d3ckxtcG84bnUr?=
 =?utf-8?B?em83SWkwY1F3em9sMFR6UHN4S1RnN1JiRnpKQUdTZmp1NkcvaUJwNU8xZVp3?=
 =?utf-8?B?UHo3STFnejZHdkw2R2dVeVgxajlsNmRuK1VVdG1UcDZVdWNrbGtHTFo5YjV4?=
 =?utf-8?B?YkFJb1VoWE5OYlZRK0V0eitVdzgvWTNCUHo4MCtldkt4T1BYL3lFU2NOL1pV?=
 =?utf-8?B?bkZNbWsrbzJCTk5uOXp4K3NCeFZIaVhxSWxyWUI2ZGhlNUlobVR2VktRaDlC?=
 =?utf-8?B?ZHpJZGw1b3lXTlJLYXFpTUl4aVRhVW5PSEF3TnBsZ0hUZGlQMlJ2eW5rNmph?=
 =?utf-8?B?UndocmFldzc4ZDR3d1VvY0xwV213SnE5ZGUwbFppTW9sRzh0c2t5emlzRlho?=
 =?utf-8?B?TU5JaWNjOXJvOVk5MTc2cUR6ZUdaOFc1NW1XN3B0aGlZNkRlanNJT05DK1RV?=
 =?utf-8?B?b3Jnd1poKzZsM3B5cEUxbTlWank0Z3NTcUFDeGVyOHRLUEdXUHkydFl3dEJG?=
 =?utf-8?B?MFBIZytQQVNSeDg1anBDbGNGUzhCT2srRWZ1bi90OE4rWGNZVlA4d1NZWitX?=
 =?utf-8?B?WHZ1RGEwTXdRVFd0VWtZWEZ4bVlCMHkrMDB6V2FwWitiZi9aU3hIV0xWbjB4?=
 =?utf-8?B?VUxaemtSZkpmNDZOU2djNlppK0ZHc2FkK0ZzRldPSnc3UkRTREdTSTN3Unhj?=
 =?utf-8?B?S2d5YnBWYzg4ZlpvYzFMYk1Gb2JWYWdmeS9VN2RiMFdhUS91V3JOZHRwOFls?=
 =?utf-8?B?VnVBb29GdTZidVNVTU1SNUg0NWJGajZ5Z2lOWWZuQzFlMXFLc3Q4VW14TEky?=
 =?utf-8?B?S243aW1oZHFGMEFCVlk1N0FjTmhYTGRRL2FEZEdiZmozT0NYeklCTTF6ZGZz?=
 =?utf-8?B?dlJMZXlkM0d6M0RzSkgraGlhaUFuSFRJUFdtZkdwTDU4d3ZNT1l5TVcrVEx3?=
 =?utf-8?B?aFV1K3JtNGJxWGFtTWtRU1p6bUcwbmcweDAxYTd2RVBhMEMyRWpzSXEwRGRy?=
 =?utf-8?B?RjRPVStISkZwbGZ6TVN2Vmxma1U3WkNXdmlzenJ6RVRTcWJ5R3o0N3lnQk5x?=
 =?utf-8?B?bDh3QVJVcm9jQWYyV2FscE9Hc3M1NWtzSjJEeHFNUUlQM2t3cDRWYWtVTk0y?=
 =?utf-8?B?dzJEc3p0WDJhMy9wbHd6UzB1UXlJL1l5NXVoZ3RrZHJidFRKWmpuNyt4QWpq?=
 =?utf-8?Q?9yIcnnorHSmSzX3647s48UFNV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba7e050-1f96-43cf-f501-08db218b94c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:19:18.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MktYrI+QAUqrAKUJfyMBEJrWp7b2jz+V6lSQbE+czBHQrgg+67e1J4hMT2VvbcfCErBnV2lPEEb24SMpTXlM3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 12:45 AM, Krzysztof Kozlowski wrote:
> On 09/03/2023 19:49, Dipen Patel wrote:
>> On 3/8/23 10:16 PM, Krzysztof Kozlowski wrote:
>>> On 08/03/2023 21:09, Dipen Patel wrote:
>>>> On 3/8/23 11:05 AM, Krzysztof Kozlowski wrote:
>>>>> On 08/03/2023 19:45, Dipen Patel wrote:
>>>>>> On 2/16/23 6:17 AM, Krzysztof Kozlowski wrote:
>>>>>>> On 14/02/2023 12:55, Dipen Patel wrote:
>>>>>>>> Added timestamp provider support for the Tegra234 in devicetree
>>>>>>>> bindings.
>>>>>>>
>>>>>>> 1. Your commit does much more. You need to explain it why you drop some
>>>>>>> property.
>>>>>> ACK, will address it next patch
>>>>>>>
>>>>>>> 2. Bindings go before its usage (in the patchset).
>>>>>> Ack...
>>>>>>>
>>>>>>> 3. Please use scripts/get_maintainers.pl to get a list of necessary
>>>>>>> people and lists to CC.  It might happen, that command when run on an
>>>>>>> older kernel, gives you outdated entries.  Therefore please be sure you
>>>>>>> base your patches on recent Linux kernel.
>>>>>> It is based on recent linux at the time patch series was sent...
>>>>>
>>>>> That's good but then why you do not use scripts/get_maintainers.pl? The
>>>>> hint about recent kernel was just a hint... Just do not invent addresses
>>>>> by yourself and use the tool to get them right.
>>>>>
>>>> I will take a note for the next patch series to add any missing people. The current
>>>> list of people/group is what historically helped review this new timestamp/hte subsystem.
>>>>
>>>>> (...)
>>>>>
>>>>>>>> +  properties:
>>>>>>>> +    compatible:
>>>>>>>> +      contains:
>>>>>>>> +        enum:
>>>>>>>> +          - nvidia,tegra194-gte-aon
>>>>>>>
>>>>>>> This is an ABI break. Does your driver handle it?
>>>>>> yes, handling patch is part of this patch series.
>>>>>
>>>>> Can you point me to the code which does it? I see "return -ENODEV;", so
>>>>> I think you do not handle ABI break. I could miss something but since
>>>>> you disagree with me, please at least bring some arguments...
>>>> Refer to patch https://patchwork.kernel.org/project/timestamp/patch/20230214115553.10416-3-dipenp@nvidia.com/
>>>> which has compatible properties added and also code changes to reflect addition/deletion of some
>>>> properties.
>>>
>>> I referred to the code which breaks the ABI.
>>>
>>>>
>>>> I am not sure I have understood about ABI break comment. How else one should handle if
>>>> there is no related gpio controller property found?
>>>
>>> In a way it does not break existing users? There are many ways to handle
>>> it, but I don't know your code to point you.
>>
>> It is new subsystem and has only one driver which uses it so far. 
> 
> We do not talk about subsystem, but Tegra SoC, which is not new. Unless
> you meant this is new SoC/DTS?
> 
>> This was a decision taken
>> after review comments (By Thierry, also in the mailing list) to add this property (nvidia,gpio-controller)
>> and necessary changes have been made to existing user. From now on, it has to follow this change.
> 
> What is "it" which has to follow? There are rules for stable ABI and
> commit msg does not explain why they should not be followed.

"It" here means hte-tegra194.c HTE provider which is the only one and not being used by any entity
yet.

> 
>>
>>>
>>>> I am assuming you are referring to the
>>>> below code from the patch 2 (link above) when you said "return -ENODEV".
>>>
>>>
>>> Your bindings patch points to ABI break without any
>>> explanation/justification. Then your code #2 patch actually breaks it,
>>> also without any justification.
>> I am going to add explanation/justification in the commit message in the next patch series. But to give
>> you context, discussion happened here https://patchwork.ozlabs.org/project/linux-gpio/patch/20221103174523.29592-3-dipenp@nvidia.com/
> 
> Either too many messages (and I missed something) or I could not find
> why ABI break is accepted and justified.

https://patchwork.ozlabs.org/project/linux-gpio/patch/20221103174523.29592-5-dipenp@nvidia.com/#3000908 and
affected code/comment at https://patchwork.ozlabs.org/project/linux-gpio/patch/20221103174523.29592-5-dipenp@nvidia.com/#3000908.

Will it help if I send new patch series with detailed commit message?
> 
> 
> Best regards,
> Krzysztof
> 

