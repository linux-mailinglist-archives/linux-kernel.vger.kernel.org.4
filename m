Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A346B2D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCISuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCISuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:50:07 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C80FA0B1;
        Thu,  9 Mar 2023 10:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiuyeQXQhi6H8obkfSgTOMfZEfnSYNjyMOrodeIWyGHCnRCZP1RY0k/UdWGQrr9AiOPvk0hWtcKEXJG6+XU2x7Vw88xmVmAWZXR0XMeVVx3eujkCXZge6ClpioHGzrrJEZqqJCB5YlFrYVLiVUKxpZ7imLj6kP0d5qZvDXDy7i/0NAZ2avHpoFFdndPg3F3breisqoVHbhXHslY/fz/gjRrpMU4qB/EglbSmZJobyUNgnBoALH/zV5oRejqaD6Rm/t595yiv1Ayu3XsvwMR/I1Cryvqzx6g88mR3HpvKwoKbH31Th82wP+08hWwUPgEIIUQ7aV/R086qkdgTr1lWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tql0zFJsuG/BMQt+SeII2U4eWMRJfkiDvrLJvQR/8T8=;
 b=IiqAumAvq8gz79VTxIw+aMTqMmdiV65XMSUl7Z+4BsPIOlLk3P5VvDZiJoWw6DgBbt4jEgydmwC65rF8j2L/CcXo4ofoK45NTurM43kjm52iGMzOU6E/QACwQ8SqMFaGikukv4vJ9kNSUixKwIA1899Z1mc18Io4NqGIc3m9sByItop6IyPGxHuZJ3NhB/YyvB8BgKWWE9YizdVrZh/mSo/UpWoRpBO7wdqa9fu+6ebmLy+wGyqx1SKX5UiLn5ApUCSlErH9uQfI5Lx3rMe7+yhFcB1AM2qQMuJ3H8knCLY4s8bn/yknwjHVNCc8MLEEH8AO8oruz7zmL4OjXuVX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tql0zFJsuG/BMQt+SeII2U4eWMRJfkiDvrLJvQR/8T8=;
 b=ZwJ6cGFFLAxsxXiFmA19pbqAcfDaLIowjoQpI2FHefW4vvPGWbhjQdnfLNT9o0QEDJZRhYosFq43A++I9YTlxT9hiOWs8v8nRAlyqTlfihYRtEx/IwU8KDlSmVkJkteHY6g+cQcn7THxiOY4VVKZlnw4ipvm6xZVjE0aQ6FTcNqgXxUQ4X6s7WbBQjKoxIRMy7Q62Uc5fat+OxDZIcM5/0S73lOJA1f2iQLbtVOiWRKzNWwyG1s+OjHBbTw/rQtNjlearifg9YvEHAgudooEhrN9XspglbVkabLIWNatKb/7ivjW6Nya0ezINL2DAIlEcb7JSycuoxR2NXLpXZR1Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 18:50:01 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%4]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 18:50:01 +0000
Message-ID: <c1a78a59-c8ae-81e5-b641-a7cb75062ab3@nvidia.com>
Date:   Thu, 9 Mar 2023 10:49:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
Content-Language: en-US
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
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <ab9f7730-d399-0786-67e5-aad57716809e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::47) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CH0PR12MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f26c445-68f1-4588-0541-08db20cf1658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udrZgRZf8uyCAylx59K4qC0ql/QA58CeCIxVvwWc26AUGDkb3u0ToL78mxPwPAK5JiGeYaFN6HjexMPlqjJgACbVij24zR9+NtdRGoaWZhRS0asiK6lHOAjY/xWOl1hqpTZLM2duCpreEVrsyhtukSggdGzcbAX7WWogngVmHY0wQy7OJoyJaKNYtG0fNYaZCIe0MCFYSsqDmj0b9FCByQj5g0EO0zZP3eLu469eGnmoqFO6YY2Gj6gixVa9dWj/7xSGtIqryGIQpne32GHIPj9tUdz+OUdQWbE7bIzrX8TWBs0495mZ4c0CJgSlQDww3sTpXoLsyycCBJ3wgbadwcay2HF21fQiYZKnESe6n3723k6NNWlKVqZ15qHdnBhFWkjzjqtoNNYhtf/ES7dFRJgQkXe1B4wtNuuVW8F2epg1j7nyFSU55f19AjpIIvaDU7fwe+xfI4uZN1D7UfLBJdtQYVI5lyJtRPqN5+v9w9nO0NgmWn0Vow10W6sY/FJNAuHMJ850b8ESmrLb3nk007mt/D3A7yOe4207IErcKlPJRUbC9u0Pu7suAOG82ZAcEy8rvMkKzjvZ0jjG7fVHacfenVzrt1hC5w9+PNO4aCwXt3JMaOvbqbrjUfmtutcnGFFEihspt4mLe34xm4hszLtgdn56OAhJUr4mn0GhrV5Emi9nMQoySv4mfhQpjn/0/bzMxTsuixuVnkhm5CfYEf78vp3BafcsSCmKUHwpbzbAKKmIaJ6Z6mLFHHI/n+05dqJYFXoqMEz6ULA1tzlIaajt96V5wCqhBBViAkhKykox1y0pjOiE8XW+/vfK2sXXVDUorKiGopFXE2DFPvlZUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199018)(31696002)(31686004)(2616005)(186003)(921005)(38100700002)(36756003)(86362001)(26005)(6506007)(53546011)(6512007)(83380400001)(6666004)(6486002)(41300700001)(7416002)(478600001)(316002)(966005)(66946007)(8936002)(5660300002)(66476007)(2906002)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZKVGR3Mm1iM1BzMHZubDlrZXFQNnVkNndUUjl2Vk1IMW1DU3ZRMlJ6OEN1?=
 =?utf-8?B?QjdXOUVHNnFSMFZ4cG82K3BWUGR5ZXJ6amRQd1UzN2xqbXg4QXcxOXBYLzAv?=
 =?utf-8?B?b0dxbndOZ00ySmZkUkxKSkpPU3hrK3pUdmRLdFhrSVJ5MWJmVXd0bHd1SEZ4?=
 =?utf-8?B?REE0bWhsbjBUSUFOcExpelN0TndCQlJOOWNhYm9TRDhxeEZKMFdMMSt5dEp3?=
 =?utf-8?B?d2l1b2Z3L3dDTFhNc0Jma3ZFY2F6dTUrWStEcjFoR2lTSmFadG5VengzMjFS?=
 =?utf-8?B?UkNGYlFNcUEwWE5WSHZRZEZQbUVpdTB6cWdNMWVnc3ROZFN4N3U1UXkrMnZl?=
 =?utf-8?B?YUlsMmsvamVsMTZ1V2ZZMWxpeHVuYW9qL1JWNkdnbkhzRW9paitvckZPamRE?=
 =?utf-8?B?N0xBTkNva0tTMUNkRktXeFA1WSt5bjByN013NUlzOE9uNGRKS0xWZHN2S0w1?=
 =?utf-8?B?UThZT3ZRK1NoTUM4dkd1ZTNEMFk1cklNeG84UWVTUlNsME13WWNOMzJ2UjBa?=
 =?utf-8?B?d1FuOU5pTXc5RWx3Z0hmb3dVZE1nQVhybjhmOENRbG50UmZ6YkIwRnhVQzVP?=
 =?utf-8?B?ZzNNcU9JZHBaeHh3WUxveTg2Qm9oZGFDV29VRVF4MU9wT1d2MjZyWXJzb3RI?=
 =?utf-8?B?Q1pXQUVveHNUU2s3NFpINjg1TjNMdXY0UWJ3M0tKTC81WTJCay8zeEpYa0JN?=
 =?utf-8?B?NTJCRmZIak9YMVFjZDA3YVFuSDJTckQwS3BLajlkcFdHYVJCN2o0eTVSb2NG?=
 =?utf-8?B?eTBmaVJPbmQ2MzYxa291TzNWeUFLTlg5R3hOSjhOcXFlV2sxMXdCU2UvY0tN?=
 =?utf-8?B?dGxoOGU4YnhLdDNIMFlLSmMxV1NwTXZOdnM3WFRvKy8zZjhuQlphdDczZHVB?=
 =?utf-8?B?Y3YxWW5mdXlzUS9KRnIzNHRQSUJVQldvbHFDY2E5dFBFWU5PSTl0eHdRSnlw?=
 =?utf-8?B?RjQ5Q0VqWXNEb0h6VStaVGR1T2NQdURnTWtuUG5qdnpoTW5mZ01zVFh5RnBp?=
 =?utf-8?B?RXlMMHpUa0ljSmdFZWZkTVFsZWhySTlpNllBa3BUdW1jWVV5S0tKTG5uM1RT?=
 =?utf-8?B?akYvYVozZXdHSGhNOExYNkkraFo0RDR3MEN6UUNnbE43bDlRREtLR2JMNHNM?=
 =?utf-8?B?eVdkdFM4em5QcWRnWWsyNjg2Ykp1QUs5aVlkdkY3cjdmMzZ1OXA0RnM4cXdq?=
 =?utf-8?B?bFZSY3d6U29IRXFXNWY4MWppWXBFcFpaZ0NCQUw3ZWhLQWlkNlZ2ZXBidDds?=
 =?utf-8?B?eUxqRHo5OFdBaWxDVC82Nkx0UFpRQVVKWk5KdWtjTXBJL0w4Um1zRnRiYkxH?=
 =?utf-8?B?TDhNb0RrbStNbG9CblB5bWJ6dm13UjVTZlNpcEZpeXRMdU9yOEpGTWtBajNS?=
 =?utf-8?B?ckV1Vk9leXVTQzFzQ2VqWlVTUWRLR296dFJRNmNJSk5Sa2o5azVTUEIwcTlo?=
 =?utf-8?B?Z09GQXRKeUJFVmJGcXdJNEhwUzNoeGhuTGwvRS8wWnBWd1R1aWMzSmNsNUk3?=
 =?utf-8?B?Q0NxK2RhcUtNWDBmQSswQXRJUmoreXlaWEYxYXA2Zkd3dXdMbkpyU3duN3M3?=
 =?utf-8?B?TWdnWHc5T2FlODh0ZVlnM1ZWWHM1RFA5ajJHZnVpZHo2K29xa3BreWZMRzcy?=
 =?utf-8?B?OGNMemtnelZSNW96NVVJK2pzYVdyWGRvOVhWWExEdDhjZUMxeDNGbWtJekxM?=
 =?utf-8?B?cjFHcFlTOXROWGVlM2Vnd2FZaXhtUW9TOW5wVDg1d2VkWkN3anUraCt4d1Jv?=
 =?utf-8?B?VGIxQjFpbDRlaVlhNkhkL2JIUXY1ZnVOalNUVXR4MWZ5NXIrOWNNRUl1cEF0?=
 =?utf-8?B?U1dXbUsrS0NxQlV0dWFsU3NnZ2xpdmVjZWZxNmYrMTBIWnN5bHFYbHl0TTZL?=
 =?utf-8?B?dnhnbXl2TXZydjdDS1ZnMGY1YnBmT2xOY2tTTFJQOU9jQS9NbEc4Ti82V2lR?=
 =?utf-8?B?TzVMVnhmeXhVRnp2UGI3K0U4dkNHdGNlZ2FzcklNMEhiYmhoL0t6TkZHNjcr?=
 =?utf-8?B?dGJ1WFZSQ0huWnFHU2FyMEZWN1ZGZ0J0bkNEZUo0MnlFdW8xSStBQ0lReVUw?=
 =?utf-8?B?eVdWSUJabGE2My9uWktReXFjZExRRUR2Q0JsMGQ2dXpzS3h6UEtzRXF0b2pR?=
 =?utf-8?Q?YAOXRA2jw/QKzmNq2t+cKh16d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f26c445-68f1-4588-0541-08db20cf1658
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 18:50:01.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUPdx02WsFfQ+nLTU50zjGBpur7L2nm6HAhaPsx5S7pO5o0Yb4Y6lnOO/S1RuMDwPSreXe9GanlzfFT+XE/d2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 10:16 PM, Krzysztof Kozlowski wrote:
> On 08/03/2023 21:09, Dipen Patel wrote:
>> On 3/8/23 11:05 AM, Krzysztof Kozlowski wrote:
>>> On 08/03/2023 19:45, Dipen Patel wrote:
>>>> On 2/16/23 6:17 AM, Krzysztof Kozlowski wrote:
>>>>> On 14/02/2023 12:55, Dipen Patel wrote:
>>>>>> Added timestamp provider support for the Tegra234 in devicetree
>>>>>> bindings.
>>>>>
>>>>> 1. Your commit does much more. You need to explain it why you drop some
>>>>> property.
>>>> ACK, will address it next patch
>>>>>
>>>>> 2. Bindings go before its usage (in the patchset).
>>>> Ack...
>>>>>
>>>>> 3. Please use scripts/get_maintainers.pl to get a list of necessary
>>>>> people and lists to CC.  It might happen, that command when run on an
>>>>> older kernel, gives you outdated entries.  Therefore please be sure you
>>>>> base your patches on recent Linux kernel.
>>>> It is based on recent linux at the time patch series was sent...
>>>
>>> That's good but then why you do not use scripts/get_maintainers.pl? The
>>> hint about recent kernel was just a hint... Just do not invent addresses
>>> by yourself and use the tool to get them right.
>>>
>> I will take a note for the next patch series to add any missing people. The current
>> list of people/group is what historically helped review this new timestamp/hte subsystem.
>>
>>> (...)
>>>
>>>>>> +  properties:
>>>>>> +    compatible:
>>>>>> +      contains:
>>>>>> +        enum:
>>>>>> +          - nvidia,tegra194-gte-aon
>>>>>
>>>>> This is an ABI break. Does your driver handle it?
>>>> yes, handling patch is part of this patch series.
>>>
>>> Can you point me to the code which does it? I see "return -ENODEV;", so
>>> I think you do not handle ABI break. I could miss something but since
>>> you disagree with me, please at least bring some arguments...
>> Refer to patch https://patchwork.kernel.org/project/timestamp/patch/20230214115553.10416-3-dipenp@nvidia.com/
>> which has compatible properties added and also code changes to reflect addition/deletion of some
>> properties.
> 
> I referred to the code which breaks the ABI.
> 
>>
>> I am not sure I have understood about ABI break comment. How else one should handle if
>> there is no related gpio controller property found?
> 
> In a way it does not break existing users? There are many ways to handle
> it, but I don't know your code to point you.

It is new subsystem and has only one driver which uses it so far. This was a decision taken
after review comments (By Thierry, also in the mailing list) to add this property (nvidia,gpio-controller)
and necessary changes have been made to existing user. From now on, it has to follow this change.

> 
>> I am assuming you are referring to the
>> below code from the patch 2 (link above) when you said "return -ENODEV".
> 
> 
> Your bindings patch points to ABI break without any
> explanation/justification. Then your code #2 patch actually breaks it,
> also without any justification.
I am going to add explanation/justification in the commit message in the next patch series. But to give
you context, discussion happened here https://patchwork.ozlabs.org/project/linux-gpio/patch/20221103174523.29592-3-dipenp@nvidia.com/

> 
> Best regards,
> Krzysztof
> 

