Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C736070268B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbjEOH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbjEOH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:58:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4667F1735;
        Mon, 15 May 2023 00:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+gWho9tVWV1XFaDQDkHmCJ5C8NRYyxWhjeCgzH2OWQaUsV94s34JwPx1g7f0OQKW+tk/c9a/bFmlcsjHXAXetK7axh/B5Vp9wJ0NgByJi0HmFuKVChiPfFdX+sziIfFk/XSDOIVEUu89PVI905AHG6pJp3+gTfCcTE7EK8qG2EhdR60HZ5+fg9bAlfoLOq1g4LWHluG45vq06hqCQlnEglZZVYHOC42BGyXjFpEZhFK1Zyi87+xRnhgU5bIhQy9pnSsmyKTgcuMlLp/ckStoZ3esv7U79WO9uTYEaNn3Y9otX6hOtK5JeAw8l6w0LbQpfZzlPCGXWkOt5d8RSl7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8fXjhgqM6L0HAKjUwrAyfy7ZuTSadPp4PAc4iUvn8g=;
 b=dzfELt3EfnnshJFZDgc/DdMSO6Fr0Rs7ahGLDhtZPsuVv2olLG9l4vyxE1QWASWFoavQUg08IN8cM4cqWKt0MfjRZ6hD9wokNnQ+oOA3q12De9RBTVjUK2ydJ0OSXKwadeNLQJGgC9Ne7AAeDuHF1c5c7OYZ+QvjHqrAi2hQPBCV9Yh629QwzDAh8ZOskQi7CUXqICezXByM0gpC230p/pYO/7Cg2O1GihE4lOU7DtXk8qQRtMlOT8yNMKJ7p0JKxCmxokoNmOHXBJCOi6NbxuQNjxUZx7HYRtRQpyg2DQr2QfVxUWH9dcCK6intAyBkvxAe20dhJBYw2Q83vrqHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8fXjhgqM6L0HAKjUwrAyfy7ZuTSadPp4PAc4iUvn8g=;
 b=zTkk5+WD8AjjG1OTk2iIn1BbgH/GN8FdR9YTWVN7GfeLV6i3/lGrwkxwpCmK+s6rlDlckGi61YWTwd54anOkqc8jv/Q7hQOCNgG5Wef8sI5be5LA3rUzRT4SFlXtu7Ixuc6qGMVFKtPWN7rQVCYrQFo0ZtqyvTMUGn2aHSzGF8hRnWEt4BTUkSGwVcHRo28pyWFMd6uB5iDLvBZ9eHbiy1vD8hH/CVRs10fWZ6eGPwgCEEjnllYkKbi1IdC5GD8MrD2WmjgIGiBLJd6lpZpanR8vuX5QeNQoVyDleEAR+wIHo72Uu+L/Gi5azZAfyNSKwB3VNpDUyTq9gsp1qcKO/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEYPR03MB6901.apcprd03.prod.outlook.com (2603:1096:101:b4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 07:58:04 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6387.023; Mon, 15 May 2023
 07:58:04 +0000
Message-ID: <33f5ff59-db7b-7576-64cb-972c0dfb0f7b@amlogic.com>
Date:   Mon, 15 May 2023 15:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V8 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL
 clock controller
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230515031557.31143-1-yu.tu@amlogic.com>
 <20230515031557.31143-2-yu.tu@amlogic.com>
 <590560c9-4da6-bbd4-6aac-de57ab5403ba@linaro.org>
 <8c6ad0a9-7820-c7a2-bd3b-1eee87d96728@amlogic.com>
In-Reply-To: <8c6ad0a9-7820-c7a2-bd3b-1eee87d96728@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SEYPR03MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 7523bf29-dce9-4638-f41e-08db551a1c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAuvxfKPDZqnH/YqZS1KugmKM4bQOsI0vhnN7QJ5Bi/NeyOBgt6NHTvpJ2OV5trE2Fp3C89pp9XSVyFYtt3dkdJ/PC9VjDAhDi6oCWgprEAUgE0Kq5oDJX6u3w0UMEAsCze05hl1RZBXEV3LOOOwmXFu7hiWjzGTcarLHhREy46OtChFm5UpQ6JxCBdb+pJuIF+89++USwLUYTLwkhjYltjwUtZ2vS5W9WvpMW/tSgKSdnGRl3TvYabgoH8LKESOjYr+FiIXf2HCNtqUQXODqE2ZkI6dr7Ya0maPA1UvL48EPyDryHVWhJdxAX2Fj/Cga9i2wrz6bUvzIdWx8kZFY3J7ZKp3/dGOcmlkTcVvGEtYEDpqqpZrfF6l0ldRrqpAou0PwDmjvdUI3MIePriXJDikD3EmsBPM8CKsDMCeeMK57lpFpKHviFPYK8fDnw4hus8NKrlY31YNVslTuxNhoH6ZLbOKat0oprUgxl5SrTBDB/sUjFmuKbsa8wAXjGSva64JHuDBYMMG3feAQDjjxl44mOYqSn5POIEEG0dLhYRVTTIJkuBfU4o6gaGwSbyrckE2crJU3c3i9xxJ99BJwaO5ln7dsVsd5D18RiUzWAHA6FbNftZPpShRlASuYEfS532e+kyh9C9KuxcXDS4lUpFlPYjXljlnmh8iCXEzsd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(451199021)(316002)(4326008)(66946007)(2906002)(31686004)(5660300002)(44832011)(8936002)(8676002)(7416002)(66556008)(66476007)(41300700001)(86362001)(2616005)(110136005)(478600001)(966005)(36756003)(6666004)(6486002)(6512007)(26005)(186003)(6506007)(53546011)(31696002)(83380400001)(107886003)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amZCSWN0QUsvTVlVT3JMUDBlNHVKMVJUNmRkc1gzdkpwVFAyQno0WllXZjlO?=
 =?utf-8?B?azRFSVVYVkR6NWtSUGRMdWpmSVNXMUpoZE9vSXJzRklNVTBwUmlZb0xLZlBh?=
 =?utf-8?B?RnF2SHJXVHQvcDNvTzVwc0xDRnZJdkdPUys0cXRNVGtERVF1YXdRUG90ajRR?=
 =?utf-8?B?NXN1RG8zMGVEeE1sYmNSVmNaNGFJZ2ozMVp6dHhnSXZrb0JHVVRyQjdXMnYv?=
 =?utf-8?B?OE5oNmxQemlYLy9ranoydi9ZS3VPZWorRjduMXBDdXJrellWMi82MjlNcmVD?=
 =?utf-8?B?bHJ0dDVsWGNSazR6Z25GK3RrMVJMNUlzQlVEeUsza084TUJmOXp5VFA5Umwr?=
 =?utf-8?B?d21lVHVVUXlQTXRDSS9VOTMrUmpUWjBhanBoUGNKNkNxbVk4bHVReldwcHkv?=
 =?utf-8?B?cExkTjZoRnNMd0h3ZWc5Q3FOdkdSdDVhQlhGcWRidGppajFqMUVxcHpOejBL?=
 =?utf-8?B?UitOT1YwSVZkSGloTWE2RmxMRi80YmJrbXN6c1F4Zm1RN2o1UVV5RWdKaEx2?=
 =?utf-8?B?QUtDUzA4MkJxNTVHQmlwTHY1U2NNamc1dDFpRHBUZlAzMEtKS0MxdTh1d29J?=
 =?utf-8?B?bjVWOE5ZMGpSWVNIYWh4NkRwTkdvZEFmU05NZWRvTU5EcHF4ZUk2dXBsQi9D?=
 =?utf-8?B?bGYvYW9TNW5JZk43SjlnTlN1QzgzcEx2UG1Qb2dTNHRxd3ZxM0RHcEd2M1R4?=
 =?utf-8?B?Zm1uWS80L3A2Y25oUjl0T3BKM2w5UFZSTUNiZGhSVEhiZ1lENEZVUUZZcFZS?=
 =?utf-8?B?OSs2NUhwTkc1WnVCdm8wMmZpQ0hzS0U1QVh4UDBSRFpid29EMGRwcURvWkZI?=
 =?utf-8?B?S3NxeS8wQ1lCd29qUDFjbVhGQm1oSWF3ZzFKU1l4UTJwZ3A2ZmpFZ3hwa29q?=
 =?utf-8?B?emFJMVc5REdvcEI0MDcyOXFmOHdhZjRzaW44U25pV2tPSThJRzUvRnhOQ3ly?=
 =?utf-8?B?OE9iZlhOcW5QSm5WKzNFMXBrUS9KTHJMN2hINlBZMDQxc0hSa1JuelhpTlp0?=
 =?utf-8?B?aEVYUzQwNm1oMHdCUjdzaXJiT0dGT21NaDFKYmxZM2s2STVEVWxXSGxXZFBi?=
 =?utf-8?B?Ui82UWdnUUNLYTZybFlDRWlMU3JQMTZobVhyUzJSY1g0aXlzam5MelBBaFNx?=
 =?utf-8?B?RGl2SmpqWTJIUms5dkpPRmx3NHcrZ0ZlL2tweHR5MStYSW9MSVQ0SWtPYXRn?=
 =?utf-8?B?Yk1vU1ZTWFdPcVdQb21LTXJ3ajNNbjhPQnZBQ3pVcURWZ0pQWHdCdDRQNlYx?=
 =?utf-8?B?dWZZb2JnRjh6Witlam5IT2g5K2loRjhzRkErSnA0cCtZV1FocENtTFpjMWNC?=
 =?utf-8?B?NjhiT1kraEozQjFZWkxaYUdtQjJPb3RkRTNRRVQ2b2hRams2a0lVaGF6dDQ2?=
 =?utf-8?B?clloV1NRVFQ3ZXdMbFFHVHowWmo0clpXcUpSMDhYTnQ0ZHlCV1B0bGo4RUlG?=
 =?utf-8?B?NnFHRisrWis1R3B3NVJkU3I2YldMUDE0T2x6L095YW9VZm1IaGNKbGFsMURh?=
 =?utf-8?B?SlBEckNodk1CY1JVTkpBR3h6dVJ3c1k4ZlgxdloxcXREc0hpU2RzY1l5QURi?=
 =?utf-8?B?aUJxYlRIQStTRXdrN2t2d1lQcnRYa3JJTk1xUFlkSnYxd0UvU0x0WUFVcUJi?=
 =?utf-8?B?dDNkczBqaC9aR2JqdFBMc1ZhOEZPcmlJZHBIcjBDYnJ5ZHVXd21KeEwrNkE4?=
 =?utf-8?B?ZE1qWTRvVDRuY1Vlb0lVeG1jZWtZcHhqTTU1cUhjZTRRaFN4dzVzYVJzcERa?=
 =?utf-8?B?YlB5WUh0bGVESXR1T2ZPT0FvTFFsek95bXlqT2hvWCtYUWNpQUtKWDlOSWJN?=
 =?utf-8?B?Q0d3Z1llQ2puVVRiRnJBTzNsc3dFOS9rNUxNRUJnd0tnMmRzNjluQnhsOHkw?=
 =?utf-8?B?bXNnL2FsQVVXazhydUlhRmZzdlNJQmYySjBYcXZvaWFCTXI3cmpDYlIxZjMw?=
 =?utf-8?B?Q012K1BmNUZVYWpmOUhwKzdOMWtGTmFnT0R2TktPVjJXU0VId0xnTGp5RGVW?=
 =?utf-8?B?Q3ZqTEhiaThpcU03ZW9DMlRxV2xGZ0REUElqb0tXb0xVUjFrZ25QRkNBcWNm?=
 =?utf-8?B?dFJrV0hOQlpJM29lOU5rUkJ2R01mU2d0RHZZYTl6ekdyanFMd04vSVNLOE1l?=
 =?utf-8?Q?essIyqUQ1Eq2sw9sqIWGCPpKI?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7523bf29-dce9-4638-f41e-08db551a1c50
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 07:58:03.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoVJKoHl+fXuZ0nW33MhsszKOHoeDjRDGl2W6xKefwxtXGRBLKqATxlBh3VwV7wJLXJX0qQgCY81Z1br9A6vKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6901
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/15 15:35, Yu Tu wrote:
> Hi Krzysztof,
>      Thank you for your prompt reply.
> 
> On 2023/5/15 14:32, Krzysztof Kozlowski wrote:
>> On 15/05/2023 05:15, Yu Tu wrote:
>>> Add the S4 PLL clock controller dt-bindings in the s4 SoC family.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions. However, there's no need to repost patches *only* to add the
>> tags. The upstream maintainer will do that for acks received on the
>> version they apply.
>>
>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>
>> If a tag was not added on purpose, please state why and what changed.
> 
> Yes. I don't know the process. So I need to add Reviewed-by: Rob Herring 
> <robh@kernel.org>. And resend V8?
> 

I would like to ask you again by the way. I'm not sure if I can just add 
the TAG. Because I actually changed the V8.

https://lore.kernel.org/all/4f73fde6-bc67-ac31-08d2-3e84b0646e73@linaro.org/

>>
>> Best regards,
>> Krzysztof
>>
