Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2E6D6AAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjDDRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjDDRdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:33:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B376A4497;
        Tue,  4 Apr 2023 10:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi8oWehrw3DPiOJy0KvCxetbHd+PiGBvm4tBYZmviV3vcusHtS6/oAmo1PTHQmxnd9VFCLffiNFr1iGnOi0e3EnWNFoYr1WfdL6DgOU+jyoB+FB6NxYbARvlEQq+ji1otgVBhEnwSyMWvRr/67DRspsUh6t+u/5pm6dTxbhvMwz0qmPvuViSDTwC18nsetOnnbVwOddwmQf+23YOoA/kkEyvsJXKt/IzqJfuL+gPjKpAOnZigPD6Pb8D82K9qFopUQoO2ZDgJ/nfieBTxARNdAh65dSwUM4ENeuePucVdUrVNFxf0RMfBNm5FGbIVudcZoTg38g2fmqUPjWzSgExmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA5QEMcmnBAQnhZvuT7+bXvwL9BxnkqJA1mN9p/Gwog=;
 b=ldBATIX1lJjrZxLbeq/Eni9d88gGh7TgQDJEbYQo68h7BzuC35603flgiE0ah/uAYNkZdawlVSo9aKLwi9qYEOQg8ZwnvcUckFFBJrOTuzDW3eoOpwFl+UsLif0ninmxzZZFQUwzT9Td1fX0PZEu8xk0YpjK2ozFqW2ttOoCA4U1b1Tn2l5X+lRoRUUHUATWPWfB7QfcNEiWHKI/x6GGDIaDgOn6+CqfaBEZn71Rhmmxz/YXuAigLdzhjIVBYm9r2Cog6PJYjWRrsLmId9JSC/UB7nhzk6Ffm+TVd01bgc9MpZhLrxAcDW3JSuS+opVe+w2Le6QOYZqL3QjiwudF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA5QEMcmnBAQnhZvuT7+bXvwL9BxnkqJA1mN9p/Gwog=;
 b=oEC3Nir8ou+QScqnLxO44yBO2PG3cQV6ZviV5hSqDJnOBZiF6dRLj5tAka7EBfCM2b1M9TZh9jp/98kRWmK2fWfbYS1+PyRvHyddZJM3ViczP64+Q6zdvBqzxzEpfCL0qzhh0xA0/oLVoGE3qJiszaxmynXIMJ9Lkl9D3BdUTj2/ZK1AsRjlG/BIu4NbSZZRuVbjkBbivJiC/KLTFqtyKTt+Xq/215vPbR8H0dsRuzPGONIB4DoGlzb4cuE9gvMy7ohBWQkXnkpmui7XHCoWP5BvyEUt+Swb+PItsTPtdjLCCqeivAdtM8edtBSaSkUaill/8IDVbIe9HfZGxPPs4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Tue, 4 Apr
 2023 17:31:59 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 17:31:59 +0000
Message-ID: <023cf280-459a-20af-b6e6-e76f54e2b682@nvidia.com>
Date:   Tue, 4 Apr 2023 10:31:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <20230324171329.GA2062332-robh@kernel.org>
 <7f2dc5cf-78b5-81c6-0012-26b1adce1c86@nvidia.com>
 <19b71fef-614a-d678-2e73-95db8f226e61@linaro.org>
 <df00404e-96a8-bf33-cbc7-25dbb09c89c7@nvidia.com>
 <9c49e4a9-0792-bcae-506f-77b5874d4d19@linaro.org>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <9c49e4a9-0792-bcae-506f-77b5874d4d19@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 238ee5ee-e08e-48fb-7fef-08db35327e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53T3FETHtaYMgGXGmlJyO1DBOye4cnrwuTaqdUYiWqPpZSstSrCYtnfNoSM/mRANoO6jTleQ8/TS+moETrIR7RPawGyxJorcvaa8VjFrwofdzaITPQKrJ4FrJJrm7r5Igo8Az93I7pXuex4PC6TEjdvmMkpXSswJ4msgstsyfdzFyO9sVb/sYKdYxCPN1aC6o7PZhtaewWsIlRpuLfdB1DonCxYiETSkl1HpuwlUvNY4cdQNSELDxQvtQOKVCUn5GXd6fX/iSYbxHSOmuLydQFxuUZLBWi3XWfnspy8tlsUyJyO4ZzotYzLckhOPkzMA10fs6LNlYpfV0Bd6riAJKJsoLB54a8FlxYdhIRqoD/kXdMmvqtAGzbeuJmRqBpyxVKtWTX8BkULYKqt3Hz+/nf8XE5guSoHTQ1FD/HyIsUr82RguyLlvViFIO0i0NoyFdX2Wtyl2QoF+Dq2kPTQ290KpwG+rcciGul4lD13G3jyGj69VOlqG8r6Zi5gOa/YtcOHljgzQWs60IMaclCc0TrRaAPoZNuh2KaNMDREKCmxNAsatW8HSDXLzU1XABrj+19+tYlhF1pRZtgXZkzqVdVYe4r4eyRyXPjbXCZ2LtQogbCO+g6XYNQHOejYRbnzHzmsz3hK+CoPOcnlOTtusDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(6666004)(86362001)(5660300002)(66556008)(2906002)(6486002)(66946007)(8676002)(8936002)(26005)(6506007)(7416002)(4326008)(41300700001)(478600001)(110136005)(316002)(31696002)(2616005)(36756003)(186003)(31686004)(6512007)(53546011)(66476007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1JBL1ByL0pIWEFlNkFFRDRjdHRpdDJyU3REcXRmeDFnT0FhaWk0emxoMDVH?=
 =?utf-8?B?Z3B6U1VKa0wrb0hOazE1NGVpekdVWmptb2drR2twZjcwZHFjTVNueExmREh2?=
 =?utf-8?B?Wm5pS285OGp6SFhCcTh5TjdKaGo0aVkxTXJ0Z3M1cjczYkwwNWMyRXRzT25h?=
 =?utf-8?B?SmVHWjFicmxKbkNJMWkvRlFTNmtoRDF6OE1CeXZJZkl5d2gwSVBhQ0lDSzZj?=
 =?utf-8?B?Y1JuYjlYMnFNNjdoNWFKZ0M5UjUwMWxrdkl0ZVpIbFFjWGljdnM2WStXRmlJ?=
 =?utf-8?B?NnhTekEwa2ViRCtFU1NqR3Y4S0FtbmZOUjJEaFBucEw0c2J3U091Z2sxR0VY?=
 =?utf-8?B?eFVTT045a2R5aWNBYjAvRWRmTGEvUVRPc0NUaU53R1NJNUJEdVdNOVpDam9C?=
 =?utf-8?B?dFBKbnYzNUdzUFcycEFpbUdUOXZSb0tVT1pZQ01xOG5NKzlLSHJmclNZTndU?=
 =?utf-8?B?c3htYnBSem5vcmMvVnE4SUFCTEVaTFRFZ28xYUIrell5V3p1c1BQR2JRM01T?=
 =?utf-8?B?U0UrMkpTWGxhK1YrT2Jyb085QnlVSzNjaVJ6YVZRVzJsQWY0UUY3UkJJOVhF?=
 =?utf-8?B?WEk1d004NjNvQSszb2dIQjdrcWtyTnBualc4U2paT0xRUUh6eHhxb1NJQzlI?=
 =?utf-8?B?aE1xOHBvd05FOHdPYWVveGNzeEZiVmE4c2pUV05HZ3lteDd2MTgzUzRUZlNw?=
 =?utf-8?B?aC84VUFGSTNNRTFZclF4c2RRdnhRRTl3UFBqaG1xYWNpZUdJMDRUTmhobU14?=
 =?utf-8?B?aUV0WVNuZ1hhQ0JUUW5QTm9aMFBmWllxWHJTZXNDV0IwU3JqMWNLVnlSZ1d0?=
 =?utf-8?B?cnNUUGdaSS9zT1ZOZkx2RTlBcGlOSVplRmpObkowMWNwc0ZvWVNwV1pFSmFk?=
 =?utf-8?B?dW1WK1lEeWR5cGN4ZVM1RkQzTDI1dExxd3JVMUtudWhLVUg1TGNteWhpMGU5?=
 =?utf-8?B?VFBHWE1LUzZvQmFZeks0M0UxQ2Q4NWR0QnhRVVZycU9oNWlDeGJJZjJKVkUv?=
 =?utf-8?B?NU04dTExc0JOd08zQlF2USt4c3A3ejRpcHRTdzFoeFlPZE9OVnRCc3pGL1Zj?=
 =?utf-8?B?U2lHV25kTXpTeU9xeTl6bGQ3WG1lbVdveXFGenZaTHJydmhabUlHd0h6M1c5?=
 =?utf-8?B?VklMUUticU5LYkJKOWNqK1c0NU9CWi9nZkY5dUhWcjJHZm5NczhUU3g2aitL?=
 =?utf-8?B?MVRuZG1kdjQzZ20yVVk0Z0lFSHFscHRma0l4YmkzM2ZHei96c3VUTUFlcTNU?=
 =?utf-8?B?MmtoYmRXcjJtK0JJSmJNeGp5eWNzZEUvd0pZdVN0MTBJQzlMeWQyVHlYTmZi?=
 =?utf-8?B?Mzg0ZWQwQytLc3JUMVdmOEVjVmRvMDZLc0J2dVYxQ3NGd1B5NjNocnkvNFNj?=
 =?utf-8?B?anZRakpiS0I2RVJOSkdhVklpVjlGTHJHRm0wUVBHQXdoL0VTWWE5a1B4NTdH?=
 =?utf-8?B?M3AvWkpoR2czQ2lmWDMzODREc29QNzJ1UFAvdWU2VWVFcEtIZjhxNGkxUnZM?=
 =?utf-8?B?dmh3UnJCWHBVSHBaT2pZV3NuS1hIczhrSHNvWEkranNxRHJjc3k2ZWdFR2Ro?=
 =?utf-8?B?NDlJSWl1TVpESTBXK0hYZGxKZWJjZ1hxbXVQN0VPQ0JiY2tWMGdUTTVDd29H?=
 =?utf-8?B?dFNoSG9OZDZkVDM1Z2R5Unk4YVRBcEM2REZqaktybWttY0drMWh5S2FVQldz?=
 =?utf-8?B?UFd0VU9UWFZ2R3JYbWk2NmJWOEgvcmwvbXVjVytZL2NnTkhjcFFSNUNSSFlr?=
 =?utf-8?B?Ly93MmtKVXpOWEJXNzFNQkcveHFYU0JGSm1mSWs3am5JRjNQMThmUTBUWXpM?=
 =?utf-8?B?QSszSWpsZ3hlazhrK05XZEI2TThHSks4Qlh0MDFnTGRFMFFWWm41L3drVnNC?=
 =?utf-8?B?UW1xenRaWnBOUXJHSXlZRWhZZFlkMlRvWWxudGNpYmpJR3JJOEFRUFZKTFhJ?=
 =?utf-8?B?L3luUStNeDJtTG5HeFV2cjhNY2E3eTBVcXhIK2oyTU1IR2tJaDBEKzdlVjA0?=
 =?utf-8?B?VEhnMWJOZzBRa3dOMEppa2tYRTdGLzNvUzBTMXMwNXZiS1J3YzhQdVZ3c1dF?=
 =?utf-8?B?MDhLSXpiWDVSSVhMUXBMTUx2NHZpQW5oaHEyQU05dTNLMWRpQnJ3U1N0eFZO?=
 =?utf-8?Q?Uhj5w8SZEsb/rgMX3iqRfT3PL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238ee5ee-e08e-48fb-7fef-08db35327e9a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:31:59.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Md9h5eh2Lpk93l63mGInFVvNd4VqMcCkCB6KchruheWf3cnGNAuqfLClG/QmzfBcfbMY1tBt36ckRIwR842lzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 10:33 PM, Krzysztof Kozlowski wrote:
> On 04/04/2023 06:24, Dipen Patel wrote:
>> On 3/25/23 4:09 AM, Krzysztof Kozlowski wrote:
>>> On 24/03/2023 19:51, Dipen Patel wrote:
>>>> On 3/24/23 10:13 AM, Rob Herring wrote:
>>>>> On Wed, Mar 22, 2023 at 06:29:23PM -0700, Dipen Patel wrote:
>>>>>> Introducing nvidia,gpio-controller property from Tegra234 SoCs onwards.
>>>>>> This is done to help below case.
>>>>>>
>>>>>> Without this property code would look like:
>>>>>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>>>>>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>>>>> 				   tegra_get_gpiochip_from_name);
>>>>>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>>>>>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>>>>>> 				   tegra_get_gpiochip_from_name);
>>>>>> else
>>>>>> 	return -ENODEV;
>>>>>
>>>>> Or you just put the name in match data.
>>>>
>>>> Not sure I have understood this comment, but "name" the first argument is
>>>> already there to supply to callback to match data. Also, this if else is
>>>> needed to know which "name" to provide.
>>>
>>> The point is that of_device_is_compatible() do not really scale and make
>>> code more difficult to read. Your variant-customization should in
>>> general entirely come from match/driver data.
>>
>> Perhaps I should not have mentioned driver related details here about how
>> this property will help, that detail will go in driver patch. In the next
>> patch series I will remove this commit and just focus on what this property
>> is.
> 
> Regardless of this commit, driver match data is the way to go, not
> of_device_is_compatible().

I agree...

> 
> 
> 
> Best regards,
> Krzysztof
> 

