Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370657275BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjFHD2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjFHD2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:28:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DA12703;
        Wed,  7 Jun 2023 20:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuGv6I66V4TdjH6sQb2IkX+twfIz2y+SBFaMghD14vIDUfG/ftbcYNfiV4hqPeV10+GqDjOMRy3nnSHXz5/VL6xaxOP2O0XXRn4yeHqlER3O5E5b5kQWpaYha8EAH5bnGue9m8alP1zrioLrBg1cscqMJYWcddh0m4iFPUVKsMG2gBu9us7aPrRTvwealUCnd0I+szTJXEzPDGNuF0REE1y3lFANtbTpABdyfjj0iLS1AwaQznHUL7L279JVPnt0yyzYb2z3T2zosAMJEScdxCnU2o1DuZqbuM76JCg58b0HXwmo4b73N+Lh8PaOChL/0FVJgsZ4cfMBvYLTE7K7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8VkoZhWUt8O5VP+uIrW+RmABYnoFDf/zpuBIP9wI0A=;
 b=dRKy12Zb6ao0DScrh3WjEv40Yekwsiau5rMG3oQZMmHOHx0fer68QLVfVN/nHxT8oGbE8G5Ozs5HYO0j+aXmcUmGcljSRYDyN3s/dw3oulEc2V6KKU8TAS6fv2pP/kTaDmo9JkMa+hgHRwAPTNp+aaGVIjjSbVaTGLjZ0VoK920L1Xbv7LjerXMUuW3Wt3uKrKPkKapdXJvcIRQRcF82xODc9AENV4g1HsJW88xz0DKz2nHVLw29YtJ75b9WxuPzBjxwbye2r8Qc7+NMNHTeG/9M/w7rA+40bT7JGZNOo+AHC5kByoTgeYkrA+YeY2lBbJj/C1Eb+buA/ehC1QvbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8VkoZhWUt8O5VP+uIrW+RmABYnoFDf/zpuBIP9wI0A=;
 b=LlzhiYeSrObDGiqynUyr1V846rUFa4MN6cA598vo1rEzLONK+YewM5etID/KRfKuD2KZstLj3sfR5IaKzDf6IUdS1qNoTjmhvVOLobjND2QIF3NrGxFXmJikNWdHScZJkcNv4GJeRenV39k9EVPdMlNukJLxWjkE46ngWq3m9DZbxHVXXiYOrVuc86WS6QhWou6yugeWfddiG4O+9DWNB3IoVssnkYxICs30w7QjmCiFLFi4wqnNXW3waWvCwQwcsPOPbIZvaCaDXFuHMceDmbKa5hnwXOspnlQXPyW0cDYdDMBi8Juqw4rlYeh9ZNUf1g86Ne/5UakY2JuWGES1Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 TYZPR03MB7576.apcprd03.prod.outlook.com (2603:1096:400:427::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Thu, 8 Jun
 2023 03:26:52 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 03:26:51 +0000
Message-ID: <02ce6080-2dd2-047b-bd77-e8288d32dd46@amlogic.com>
Date:   Thu, 8 Jun 2023 11:26:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V9 4/4] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230517070215.28463-1-yu.tu@amlogic.com>
 <20230517070215.28463-5-yu.tu@amlogic.com>
 <1jwn0g39t2.fsf@starbuckisacylon.baylibre.com>
 <20230606153841.plf5uh6eyzpzsm2e@CAB-WSD-L081021>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20230606153841.plf5uh6eyzpzsm2e@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::32) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|TYZPR03MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: ace3b27e-fc14-417f-ff23-08db67d0337f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWwL37h+SUvDtF05klF8ZNPUSvgoKR6EwnhdIhz5vxxCVIbgi+IX4tjnMD4XPq3qWPcRlhT9tquDJ5MupS9WagjZPYTwH0dQO5LTjPgvQofa+2ZcAA8QUX/eO/iN8+wCA/ALVD4DcBZgsXawQ1KJj0Lw3qHUC2iudJzBIEGtUQtLlQpJHc4iaTj7BeVM1JmnpqKbLGMXjENVVLCyOhPbuLVxfQDUgSoLpLWGjhI6nQIABlUA5HyHtrqceK9pghqXJy4GimLvs2rip53RbUApkybTR1ZZXblWvMIB0Wyh0wmr1rOj1V5oZaPkvOob7d7BOec2F1Xd28Vh6OX65VkRvCXWlFbwjQyMQXLk6c/bX4a/mNjtFFDmGkrW2sSaFFqIP0zhrYNVUGvPXN6+beJWgPe7BPbWPMjvz9etTt6VULxzBU8tx3LyQNzcu4aZFo72Llc6g/GxgpP/8LzOEqihgd+rbIEs4UaZvDR3QS3vyLLyhJHK+rrSbJdzgdkcXJvyB/RENCVIdM5Sm78UlED9W5KGbGwevcZo9QKIXRld5p3LejsY7oQ+crWuw/Sk8bh9pvfofaZjBOGnfWFiutOyvRbu+1RVVt4os+wDLS9xFHnb+bnPwPlvreVjwyhdh1d82O32ROYYY/goY5aj7OCefdXP8cZM9BUeIvqbi1yVgMJ4rAqCABqKqlZdHALicRdU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39850400004)(346002)(451199021)(2906002)(53546011)(26005)(6512007)(6666004)(2616005)(6506007)(38100700002)(31686004)(41300700001)(83380400001)(6486002)(966005)(186003)(107886003)(478600001)(54906003)(86362001)(66476007)(66556008)(6916009)(316002)(4326008)(7416002)(8936002)(5660300002)(66946007)(8676002)(44832011)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N245TU1WZWNBU014VmV2TUlJN1poVEpROU9JMjdSa2RNTGdEVlJPNmluTmYw?=
 =?utf-8?B?elY4MUNvbFFQZ2NsT2ZDY1Q2eWZIUTJuYk40ZzdKOGlBWUZmTzBzRzZrQTRs?=
 =?utf-8?B?VlUvRmR3VnI4N1NaZWJ4Qi9YN0NyWmpoUnBLbW92SEYwWVJUb0J6VkJqNXJv?=
 =?utf-8?B?Y2FRL1hhS3NEdU52NFZPeEM3eTVYRkJUcFVlM3UrdUdBOVFxTEhYSHFPNUgy?=
 =?utf-8?B?ZG1HUkUvQmlieEpWdWdDMFgzMnNTc3lTZ0V5V0NLNU5ZQVFLZkZJeDdQU0Y5?=
 =?utf-8?B?d0hWd05aeGJBV05sRkYxVmU0V2VzRWRGdityYTJHZlRvMGQwR2ovdEIrV00y?=
 =?utf-8?B?dHo5S2ozS0F3SklTc2RhN2FURVlxMGsrQTR0ODdIbUp1clBSb29jWmVzZjVa?=
 =?utf-8?B?eFVMQTZDSzBURXBGTFBGRCtMSU0rTExYdHpteWdwb1NwYjUvTWFoTEZKT0Jl?=
 =?utf-8?B?VDRvdUNqSGlqeFJDcHlCb1gzWlZRVGFSM2xGWDlYd1QrOFZwRXVISE5kd3Bn?=
 =?utf-8?B?djNyZWZocmtySXlwTTZNcDNjOWtZSWtjUFU0a3UrckZOYUZJbDhMQUl0K2s1?=
 =?utf-8?B?OFlIRG8xbVE5MHROUTh6SWJBUlN2K2NLSm50dG5KYnVrZFJoLzRrNnhGTjZ2?=
 =?utf-8?B?MmIwdHBWZlRmdzFZUGNSRy9VYUZUdWFBV0xYRU9RRXlqT2tkM25XTUxxc1lF?=
 =?utf-8?B?Y2RGK2cralBXZEJmVXlIZlZzQjRnQStvZkY3ZlhqZ0VZQWl0cEgzVlRFbDdG?=
 =?utf-8?B?cGluUDlEUXoyN0ZRVVRLeEdmOG95dFdlZSttR09rVlpXWEh0QUxEcHBTWXIx?=
 =?utf-8?B?TDFiOWg0cGU2aFZ0Q05aWlB1QWNRZXFwL3ZVRjFCb3ZNVDNjK2ZpNWZqSUFE?=
 =?utf-8?B?M0IzWUViaDNqOUJ2OEFralB2UUE0S3FTVUQ4MnZpRWkrcnBmM2ZEU3BIcUZ1?=
 =?utf-8?B?M3ZnTlREaXFLZUNTOFk4R0prRjQ0M252aW9RU0Zub2dUMzZ4Q00ybDMvNUFm?=
 =?utf-8?B?WWt6T1llbTFNQzdJY2tDQnNqaUtBQUV2L2FnTGluU0pVa3VpNTk1cWpoKzhD?=
 =?utf-8?B?SjdxNlhVbVZqK1pJek1NTmxuQlh5UUh3RGFnT3BaTkMyWkNRYmVST21HK1U1?=
 =?utf-8?B?QWlkZWRDRDBpTE1pRXlaZ29Hakh1dkRYT0ZQMDhlblhsR09Fb010NzVxSldw?=
 =?utf-8?B?SmNtd05GQ2ZhcjJTYUlaeHVzbTI1TkFnL21nbU1UdWVxenhTNUlVbXdobVhr?=
 =?utf-8?B?U3NlMkNmU1NxZTJMdjhYQkh3U0U5UzJjM2tsOFhuV09MVEs3ajBaYVBOa00r?=
 =?utf-8?B?UVRjbDVRV3ZadDMxMzJmZHh2VEhTMENMT3lJZU1pMXFabHhSTlA4MkYvTWZP?=
 =?utf-8?B?enJxWHpTRE43VkFVUWFkaHNkRkRpWDNhVms4N3lwbmZBZFBHSlI5U2dWcUlZ?=
 =?utf-8?B?SE5HSUJiclllV1ZoZ0RZaE9ORWtUQy94SEdQaHRDc0dWRVpickN3U2d6cWVq?=
 =?utf-8?B?aXMxTXIzMnZGRFBPN2Q1OFVTNSt2SUtjdDcva3k2em5zOGV5R0lqV0ErSGdv?=
 =?utf-8?B?WW1ZS1VuY0lTQ2czS0hxYUYvTXdQdnUvcVRwck5lckJoYW1OWHlRaXltWUdR?=
 =?utf-8?B?b01ublpCSEE0bGdreFAwQ0ZSN24vV1ZvSytXcHM2VUFhYWdDTHpZVHpnc0xQ?=
 =?utf-8?B?cXU4a1hBa0lmMmlZODhHZ2NGbTRJOGRUZlQyOWxJVWtzeXJldURwdjFydEVX?=
 =?utf-8?B?dDA5RzdUN0x6UDREM1J5VWJ3b2JzY21WTHppNG9hcldpRTRTNlVLS3ZGZ1Js?=
 =?utf-8?B?RWFZNm9RUXpxSnVTMHJYcFZYRUhoQ2FjSXlCblFrTFY3a3NRaU41WGlOZ01Q?=
 =?utf-8?B?U1lGb1V2RVJzMG1OUDZYSjBFdlZaOTZtSEdZT3p0NWRNRmFDcTMrUnhKZ3Ru?=
 =?utf-8?B?UXh0RVpralRobVBpWXBwd1NYTU16LzVEVmwxRG5yaHM5V2FGbjJHOHMyem9L?=
 =?utf-8?B?NFFzRjVMemVCZFBHellhbXdwNk9HdUxRbWErYnNlVnVvRUVZa1dVMHZQc00y?=
 =?utf-8?B?MzlFMzRnRkdZek1ZcWlWL1lBc0FackZyK2JiRzFxMDA5cFM1dDV5VjBkTDlI?=
 =?utf-8?Q?AaM1oPzNI2+emwsIQYFqSULhQ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace3b27e-fc14-417f-ff23-08db67d0337f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 03:26:51.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eL4hjh2IsUINPzQDGaDazyWw1rLsfm4Amq0YBJ3RHQMeIsl7nvbJcJTIT5D57RBpURcVKEuy6a/7zi5I7frBwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7576
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 2023/6/6 23:38, Dmitry Rokosov wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello Yu,
> 
> On Tue, Jun 06, 2023 at 04:38:15PM +0200, Jerome Brunet wrote:
>>
>> On Wed 17 May 2023 at 15:02, Yu Tu <yu.tu@amlogic.com> wrote:
>>
>>> Add the peripherals clock controller driver in the s4 SoC family.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>>>   drivers/clk/meson/Kconfig          |   12 +
>>>   drivers/clk/meson/Makefile         |    1 +
>>>   drivers/clk/meson/s4-peripherals.c | 3830 ++++++++++++++++++++++++++++
>>>   drivers/clk/meson/s4-peripherals.h |  217 ++
>>>   4 files changed, 4060 insertions(+)
>>>   create mode 100644 drivers/clk/meson/s4-peripherals.c
>>>   create mode 100644 drivers/clk/meson/s4-peripherals.h
>>>
>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>> index a663c90a3f3b..a6eb9fa15c74 100644
>>> --- a/drivers/clk/meson/Kconfig
>>> +++ b/drivers/clk/meson/Kconfig
>>> @@ -128,4 +128,16 @@ config COMMON_CLK_S4_PLL
>>>        aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>>        Say Y if you want the board to work, because plls are the parent of most
>>>        peripherals.
>>> +
>>> +config COMMON_CLK_S4
>>> +   tristate "S4 SoC Peripherals clock controllers support"
>>> +   depends on ARM64
>>> +   default y
>>> +   select COMMON_CLK_MESON_REGMAP
>>> +   select COMMON_CLK_MESON_DUALDIV
>>> +   select COMMON_CLK_MESON_VID_PLL_DIV
>>> +   help
>>> +     Support for the Peripherals clock controller on Amlogic S805X2 and S905Y4
>>> +     devices, aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>> +     Say Y if you want peripherals to work.
>>>   endmenu
> 
> [...]
> 
>>> +static struct clk_regmap s4_rtc_32k_by_oscin = {
>>> +   .data = &(struct clk_regmap_gate_data){
>>> +           .offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>>> +           .bit_idx = 30,
>>> +   },
>>> +   .hw.init = &(struct clk_init_data) {
>>> +           .name = "rtc_32k_by_oscin",
>>> +           .ops = &clk_regmap_gate_ops,
>>> +           .parent_hws = (const struct clk_hw *[]) {
>>> +                   &s4_rtc_32k_by_oscin_sel.hw
>>> +           },
>>> +           .num_parents = 1,
>>> +           .flags = CLK_SET_RATE_PARENT,
>>> +   },
>>> +};
>>> +
>>> +/*
>>> + * This RTC clock can be supplied by an external 32KHz crystal oscillator.
>>> + * If it is used, it should be documented in using fw_name and documented in the
>>> + * Bindings. Not currently in use on this board.
>>> + */
>>
>> This is confusing and not really helpful
>> What you describe here is simply the purpose of fw_name ... so it does
>> not warrant a specific comment
>>
>>> +static const struct clk_parent_data rtc_clk_sel_parent_data[] = {
>>> +   { .hw = &s4_rtc_32k_by_oscin.hw },
>>> +   { .hw = &s4_rtc_32k_by_oscin_div.hw },
>>> +   { .fw_name = "ext_32k",  }
>>> +};
>>> +
>>> +/*
>>> + * All clocks that can be inherited from a more accurate RTC clock are marked
>>> + * with the CLK_SET_RATE_NO_REPARENT flag. This is because in certain
>>> + * situations, we may need to freeze their parent. The parent setup of these
>>> + * clocks should be located on the device tree side.
>>> + */
>>
>> It looks like the consensus is that CLK_SET_RATE_NO_REPARENT is not
>> required. Please have at look at the discussion between Dmitry and
>> Martin for the a1 controller
>>
> 
> I hope below links will be helpful for you:
> 
> CLK_SET_RATE_NO_REPARENT IRC discussion:
> https://libera.irclog.whitequark.org/linux-amlogic/2023-05-18
> 
> Clock driver LKML discussion about CLK_SET_RATE_NO_REPARENT:
> https://lore.kernel.org/all/20230530120640.irugyrio3qa7czjy@CAB-WSD-L081021/
> https://lore.kernel.org/all/20230524092750.ldm362chnpkwkcj4@CAB-WSD-L081021/
> 
> PWM discussion about special RTC case:
> https://lore.kernel.org/all/20230522133739.7tc35zr2npsysopd@CAB-WSD-L081021/
> 
> And I apologize for any confusion I may have caused in our previous
> discussion. I want to clarify that I have updated the implementation
> of CLK_SET_RATE_NO_REPARENT after discussing it with Martin...
> 
> [...]

Thank you so much for your comments.

> 
> --
> Thank you,
> Dmitry
