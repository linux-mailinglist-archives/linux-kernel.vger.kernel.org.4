Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1A727B72
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbjFHJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjFHJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:31:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::71e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782062D68;
        Thu,  8 Jun 2023 02:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzBz3LAwLH+APF4se4952xSb+d7bEWgc1Rz4nFl2Cbufvuii2Kvwk3NSw0zv20bBmkHSqQm+WDJO6HmvqACbdjK9pFnlafc3WxUXTK7gbG5SsQbuCrXA+N1JhStQYW5NC9uEspTVmMdyWU+zxWh5+r8paeIw55glfpeHGxY2jS2H4B62D5+pEIEurpiRRjilkp5sIBwazd3GqASg/RICb1I+gIFERZ6JYX6kAksn7Imo33jQxMICNQCnbjGikaparwqSUQ1jYFaiMNi7A51hBvIFcoM1hia5dM7HAHgPaPCNjc4AE3+4EDyDbOLQjJwrMh1hQfI2XieY3tXj2O/+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3f7PMcmU4egCfdUm8xDjLBc2nfaTRd6vEY6hFoyZtV8=;
 b=P1ZG7hcpj8T8PTzRl/4GW/VH6jTyWH7IfWPiuqBYq1ajbFviC7YI7dUvool3MSnzg73AFP4mAnypamHukM1HzTFfZ8csfhGTvlW0KT0SkObjKnoi7rnw+rbC0rkgvGyqL8dhQstQxS/mOk+BNtjzle9N14aZ+v+5TAFUNrz/Xd6hDnwYkhuWBxTnQIByeNrmMmU4pt3Dd8XsRToCi7gqzFImeVFnTDQ2iMA8r5KbZPnUH3MfFVPwJvLHL4qnymeAHTvHIl6FVQMPkQXMAi69c2jqjBMVSR05rehibAdCYumzRpulU8l8TFqm3VqHy75yVQbHLCD6v5WQre+KH7m2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3f7PMcmU4egCfdUm8xDjLBc2nfaTRd6vEY6hFoyZtV8=;
 b=kxortoT5eIHf4HJN7DUiQp3VtabqhiEB8nHVHbrUasSC5IZd6I2XJA8W8pdkpjclU0I1Jv8ehHhZV3fRDADHqLI1j4ppEzRoUHaJqa3obt1EFfR7lVII4DkzF7bFycZMcAwR2cnjtwbQuYb9iwutFrxXXsNxzrwrgWGf1HfcGseuc36o5nzKvUeJlB1KhuwtJsJ6e9cCNLwPuzzYB3TMJHJ7Vpospk3MbfH50+2nnAOuAMLu8cEIP9lHkW+j6HLQJkpg7mQQyRGnseLzyuhQztVzyq1d/QN6zggJ5hmraQhH2xfRunx0VDrq5tvokc69bJZA4G9QcdhOnTNKhsULfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 KL1PR03MB7551.apcprd03.prod.outlook.com (2603:1096:820:e6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Thu, 8 Jun 2023 09:31:22 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 09:31:22 +0000
Message-ID: <b502cbf7-40a1-6041-f535-54651cfd9874@amlogic.com>
Date:   Thu, 8 Jun 2023 17:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V9 3/4] clk: meson: S4: add support for Amlogic S4 SoC PLL
 clock driver
To:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230517070215.28463-1-yu.tu@amlogic.com>
 <20230517070215.28463-4-yu.tu@amlogic.com>
 <1j5y804q7u.fsf@starbuckisacylon.baylibre.com>
 <73acf297-3f60-1ce1-2f05-af048aa37199@amlogic.com>
 <1jttvi9vnq.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jttvi9vnq.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|KL1PR03MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: ad52614a-bdf9-43f1-d196-08db68031e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLJEoybm199ue24LbFdLdFNG8G+eylXH4AE1Z4qCHUGwWEX829M5FVg/IgmHE8ikm6Yj7YgLdiIJSeg6yDYzRM64mNBji8+m/WuXUP1LTI7fjJmdTaWr6y1/NIpV/69HPW879P1/z3IGCmlGBixNLmfXIOtaKwllM7O4Xd5sGoxhjU4kGdC8AOcg0CfU1edrbaYx0aho0rPDFaTYi2nK4a3xJQbAzKeYmqOoCeczfhnfsBzrxzAg08DZe19KXjJTV/w8qP6FCtUSDv2UraudDCQwxc50W1+V7K+idjr3w5Jl7Y6N1QKCJrMw0kXhZIHlvlQi/Ug5uoikMBZ5dwqd7yN+twovy0v+KzvVNEHxDCxdEBIEJ1AlboLgmbS/0Df2I4qLqkUBUEIHXXdk2PxRn0i+M7X9jlSMfOApOEGDoCAV6yKmCrcOOb9FXA+8rtTOblLlayypW677XCqgky+KCqIh+IE9FxSY+P1dzux/Os058eoKdiuhxNmLeXjV8GiM0ZI8u63PSX+ZLiZSoXKOkOM0e7aQaA1VrgB3kHWvP3axj81LG3jGSgyQlTCcjeLZLsaP4qxQHpvhWoCEH+b2SeKqDUKYOHYIS+afpz/8VywJhfCWJmCGXy+FCW0ASA0uaD/5dLB0QwNnmeUbQEI5NqbVPtSMAJxk212zuCE8iWSuov4N3Er/yRRbRi3teDXTC3yiATAuXmvd+larHDi2AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39850400004)(396003)(451199021)(8676002)(66476007)(6666004)(7416002)(478600001)(8936002)(83380400001)(2616005)(6486002)(41300700001)(66946007)(66556008)(4326008)(86362001)(31696002)(110136005)(186003)(5660300002)(316002)(31686004)(53546011)(107886003)(6506007)(26005)(6512007)(36756003)(2906002)(44832011)(38100700002)(921005)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9NY3pwL2hIQ3UwRjRqYWh5ZDZEZFRVOXloUnY5MzB3ZkZ3cUV2bnBkMlIy?=
 =?utf-8?B?TjNZbkhvRExUcUI0Zi81YzZZWVFKdHdjOEF2eHkyUmhyeHRsM3lxT1YvNnN5?=
 =?utf-8?B?U3Fld0k1ZVR0MTF2V0dUbklFc0t0WTRQNGRDV2hOLzl6WXNVSDB2R3Z5M2xQ?=
 =?utf-8?B?VmFnNzlBVkJ3c0pMVFAzeW9yUklsU3dKKzhKM3o5WHFCS0dPaXpYZ2U1THVK?=
 =?utf-8?B?V3NBeWdqZjFVV0kwS0xsc21Fa2h6RFRwaFFNRFpvOWt3Q1YxMnpaelZQVDUz?=
 =?utf-8?B?NFgza3ROc3lseHE4VjNpcWFhLzRXWTJJVGFNU0RQa2J5dkpMZk5OZ3UwaDl6?=
 =?utf-8?B?UzJydy82emUrUnQzcnBabStQeWh2Y3ZHU2l4QXI2VG8xeVZmWWxCNGl1VTJW?=
 =?utf-8?B?NnFocmYwalYvTXB2OUJUZGpqdDJHKzlqSlltdDJPM3IzT0E2UU1Wd2xJZTQv?=
 =?utf-8?B?T1hKck5vMWtoTXBxZ0gvUERrTlRoQWpSejNiM2JYK0RwUVUxbXkwZTBOY0cy?=
 =?utf-8?B?dlp0bFVTdGNaQ01QM1NCeCt5bTFZWlZHU250T2FGR1F2RU8rTVJ2RGJLTWRC?=
 =?utf-8?B?Uzh6b3AzT1VPYS9oejV0UVBjYkRSbU9xdm5Gd1pOOHVia09NNEZrQXQzOWU1?=
 =?utf-8?B?NFhXMVBrUTFmWXFqRWx5Wi90eExURklFdmJPdEJGQnRyYU11bk9PVnVkMU9u?=
 =?utf-8?B?YXE1TGU4OWxhSzkyRXdxc1NmcUNOYmdDajV2Uk4waWZMU3JIZmlESjd0cXZH?=
 =?utf-8?B?VzZaSXVaeUo0ekYva0tYYlhVaFpLc3FoOFhXMW9LdkJPbUl0bGpTNWtmNmJ0?=
 =?utf-8?B?b05tMzRXTHpqWnZheTI5TmJXWU1rMmYrbEhSaitadENxOHRsL1pPcXVSYXNp?=
 =?utf-8?B?NTNUM1RHSmJKSGoxZ1dqaFZ6RDlhV1RQaE5WWXEvYTN1ZEdhWDB5WVVRVTZ4?=
 =?utf-8?B?SUdFaUtRVHpLNitzclh0c2ZHTTgyZEJ5WGZpMjI1SXJ5WVNrTi9RRXBNSkp2?=
 =?utf-8?B?Ukh3VXNQMGVWeTZ0WFVqTDRoRzBKR243OVpoQmtBeHhyRFNvNnIvZ1h1Mkdy?=
 =?utf-8?B?eE15alpicGtQNTFJSERzS2J0OUhnTXduMDhWZzVkUnE4WnNkZmIxSncrKzF0?=
 =?utf-8?B?MTFIQVFzeHVDckxlYW9ua1o5blpkMDBRNk9yZ0g1aEVlOXhyUzRKT2ZLTmlX?=
 =?utf-8?B?YjFwaXBIc1dvL21qZ0w2cU5WWU15WjdsVDJ1Rjh2L2IyTlF1OGZvT0IwLzVZ?=
 =?utf-8?B?ME1meWhWUmx2U0JMTWhTS2NQWmtrcmoyM0pRTUtEVktnbDVKbVdDWVJmTUVz?=
 =?utf-8?B?UUticTVSTDVPcUxlakJNL1RUWFNwcVhsUFZvZkZxNmZNc1FVSjRjU2NvTFZ4?=
 =?utf-8?B?RHRzcVJHL0QwcUtXNE9SVkdiYjlwMzZLeU1sNGRiUW00OXRtSGcxNVZoUTFZ?=
 =?utf-8?B?RXZXYUkyTmg1UGJuVko4YjBHbWdldXZRQkp4VDh4bWQ1N042dDBxNE9paXRr?=
 =?utf-8?B?ME5wWjFUbWxCOCtmSTNhZVdocW9KVms0eC9DQTlEZVBxL085NHdJZVdKNjkv?=
 =?utf-8?B?M3lPMWpqRjE1c1Q0bEJZZ1Yrbk1oY05zaFlScjVtaE5jbC9PaDJ0aEJVOTB3?=
 =?utf-8?B?WkQvQnh4dlBHNjRaVE9oYlNzV1h4dTZCbnROamJqckJLMlRvYkUxUVJNbWlP?=
 =?utf-8?B?andmTi9TZjlBUUVaaHFBN216ZExNalRERVo5QkpnbzI4WWI0WWpHT3BCUG5r?=
 =?utf-8?B?bHJtYmdhVHVwQXA5SUd3cDB6Z0ZMN052VjhTeThLQSt6UE1mWEF5NXJoU2FD?=
 =?utf-8?B?Zmg5MnE5UDk0OE1sSDM2Z1c0QTQ0Z2J3NEpGQ2Jhdmd4aG45UnhBRVZuWDYr?=
 =?utf-8?B?anllR2FPeWp2cEJlK0VDMng2N0NZWXdNcUFFZkYzV0tFWmNXV09IT3AyR3pY?=
 =?utf-8?B?Sk1jZVNKemlJT1drRFY1cDJKRWhpZXZLTklGeUpvay9NVWJxR0pndVpTK0xs?=
 =?utf-8?B?MDEvTGczeXZaOG0xU25ZSDlWUHM3anVVVUFydWx5MHovdWZiQUttV2NXVzc5?=
 =?utf-8?B?cTZtNkcwbTUzMUxvc3BtL2dhcGlVdEdhSnpld0x5OGN4Rm1UYXpNdVVoMXkx?=
 =?utf-8?Q?2E/uD0uf2bmG2i/JWqctmWYUx?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad52614a-bdf9-43f1-d196-08db68031e95
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 09:31:21.4632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9isXNVfhVovU80tiK1+7ndAP9oedltBSr0FmxcDxAQRZZuTOZjtZiBoBeXO7RxogA3nn5elBT18p+lq5TVAadg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7551
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/8 16:53, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
>>>> +
>>>> +static struct clk_regmap s4_fclk_div4 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>>>> +             .bit_idx = 21,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div4",
>>>> +             /*
>>>> +              * For more information, please refer to s4_fixed_pll_dco.
>>>> +              */
>>> While div2 and div3 got an explanation from previous SoCs, they others -
>>> like div4/div7/etc ... - have been able to cope with rw ops so far.
>>> Why is the S4 different for all these clocks ?
>>
>> The chip was changed fixed pll for security reasons.
>>
>> Fixed PLL registers are not writable in the kernel phase. Write of fixed
>> PLL-related register will cause the system to crash.
>>
> 
> That is definitely worth mentionning

Can I understand that you agree with the use of "ro_ops" for FIXed PLL 
related clocks later?

> 
>>> Requiring RO ops (or fishy clock flags) is usually a sign that a clock
>>> is used without an appropriate driver.
>>>
> 
> Neil is currently dealing with the dt-bindings, please
> * Adjust your patchset accordingly
> * Wait for his v2 to land, you'll need it.

OKay.

> 
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fclk_div4_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
