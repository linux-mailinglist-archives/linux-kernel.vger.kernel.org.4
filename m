Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143776F0268
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbjD0IQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjD0IQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:16:36 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684162D79;
        Thu, 27 Apr 2023 01:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsYmvCZBJ3ic7k6KAV+hcJ6yx3jioTcgnCLueH6wxNTYtRXh7noi2JM70oDKc6stPgQcywQujbSRcHWbuP4lkHpQ+4C1qdwYv+mYID5iWSwf73tmPjFbrz30OKO9sN/+qyhLysuBsxdFY//AItbRlDBDymqrgPc8wykgGdlBoX+prGXkhQtgSX/qoGQH0FLiBrVlBOrYUkX3fhfHFSauhVQXh1XlHw6NLAs//gtFOj/odEQ/+gS8WUc6GprvfhJspkMqHTf3QN4B5iXwcp6boXFxVVM2W1Ods7oizI+PovgX24lv8V5WU47v8lVvHjmilBN3uKLTVKWs4HeNmTyjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPdVcCpAJxLP8D48Tdq1WVomJKbXNvIsRaIHdcOlHkc=;
 b=BDLgM8HyynuAMcpwskKJScTvdnn+XiL7X5BpYYojnjKlzt9VGfPO1o4SyydXysUEutunWJMIZIeIIVqiXV0aqOMBo3qSfKqyJlrUC4+GwPMK/LH6mToBPoEA23jmF7IVEca+jEEiTzVXAoLVdFyRCGJvdZB+4gwNrq7mAQHeNTMrvy4SlGDsWpaR9w4VZtqLgSA9xd6IJ9lj0+p1PnX5HLVuSgTC3C43Yu4Ojc+DUBlyg+gWKo1AkUwED27jtkfYmZfeSbjIvi9xYv1/HQDRkwW/8HsjKJkzzYEkoqYXwHhisyTHAL2Qkm0qEh3njZikyi6l8wdEzy9ByIOH3erduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPdVcCpAJxLP8D48Tdq1WVomJKbXNvIsRaIHdcOlHkc=;
 b=vvaPaLBsZSu6/nwDVRQ5o4dhFFBUdk5Fr8Rs0aSaNj9TpjJKlL/MoGxCyocMFIfBZ/kf7TdX7rJ3VqkwuvT2HJN5rhbRhtLl+LTBseyrXq9Z5sqwSCV17i26d0sVS695JsNo7zoB7hJqDDclL9XN+WpFFzP321svXMYwg3oT9VNci/x8XtIh/SQn7IPTa8hfew/nQCeoMg5MI705eeTr/T92rxwKQx+wJYuTJDai9U6onvor9cnY3iGMpa5bifJx91vDNccSKKlSANnwL7SkeVHDypwhjrPTlUS2qrifJsR19f/4BQKjl/ERmp5Ld2mNviwxQsypRQbeTwgUcCqUjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 JH0PR03MB7749.apcprd03.prod.outlook.com (2603:1096:990:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Thu, 27 Apr 2023 08:15:44 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6319.033; Thu, 27 Apr 2023
 08:15:44 +0000
Message-ID: <6cc4c3f2-4df5-6456-fe65-71aa4a13c866@amlogic.com>
Date:   Thu, 27 Apr 2023 16:15:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V7 4/4] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-5-yu.tu@amlogic.com>
 <20230426110538.y2d4qhv2qffc62vj@CAB-WSD-L081021>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20230426110538.y2d4qhv2qffc62vj@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|JH0PR03MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9cd6dd-4c7a-43de-4f05-08db46f79922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7760eD4UdWwlH1qeUEaYedcWEa9KQjPe7tTlPEWjjp7F21v9nHi3d2HX3X7exHTowShDop9wPdj/ZETF9qjR9rC8mA2/xh/sId4GAhcvz0Ll0NdQPo7OY7bihTQoDfDKfO3MlxkBRDspOq5Rg5aIVQcxrVtUpAIH35WXrCDTzPLpxntEKuzqi1kA1fcJBsl/c0TtHwCnfXrgW2BaTerhwXRw+1y4RoOlKOGb+pr7XsB1afM16DyyNnW/Z92gYig+ed3/Z/ZFpcEo7VTidB6tvy5F3CjTyeWvBZojcvkA7VnHUg/vNPfotFK4OUwchrgnmqbNy6pnb9Oi3bDNhAecuxzZt7HNLeSrOZzPM7b6h4564OVYLCmY4LHbAG8FxAxzdlY1hPeowgepxjpfUUTd236+hPR1rcBNRfuONo38lWkpbtQvDiTSoT/JFo1u9y+XM86NxH5Qk5aTkEZyDtXJvRY3fd5Syd4oVB5SQKKfnO+Ve1fIIA5QRUQQ/WoL4a/svk6TJmYXAzRGoM4fiOKOYKJAGTxFXtaHaTmdPnqcV4hdYvUlIRseu7B2aAjYmebKAGou7s9J+YJUkd7PYyh69zZeMpn8kFq54bHnzVyJXlAhwySSfdeU9+SvgYWVXGuWXoCkzwlNunvIaj0qOAlj/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39850400004)(366004)(376002)(346002)(451199021)(2906002)(38100700002)(31686004)(4326008)(31696002)(86362001)(316002)(66946007)(66556008)(6916009)(66476007)(36756003)(54906003)(478600001)(8936002)(6666004)(7416002)(6506007)(107886003)(53546011)(41300700001)(83380400001)(966005)(5660300002)(8676002)(44832011)(2616005)(6512007)(6486002)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2o0NnRKVUVUdFNRc2piNmxXN2xmeHNpUVVtcGNmUTBUcDZlNFVrK2FtT1Fy?=
 =?utf-8?B?QUFWSXRXSHhBcSs3SWp0TGlpQk5RcS9ySEkxM1pxK1JwUjkrMi9BYmFzblYv?=
 =?utf-8?B?eFpwQndlYjdKQXA0cnZPZzNiSFdEUHR4UFlJTEFKRGl6YnhmUk5zeURIZnov?=
 =?utf-8?B?UElCS3VDOThJeWNWdzZXQW9PNmZ0WmI2ZEFhbi96V20xclAzL2RxY2phd2k5?=
 =?utf-8?B?cS9kRUlubFFXQ1QyaHc4MmpDUmZrWHpJK3JjeFpTZ0FBcTVnVTNFeThVT2R5?=
 =?utf-8?B?Y1d2a0lHYzVsMGlMdWxyVXZVQ3o5Q1V3YjQ3d3BycnRjb3I5ZUQ5YWgwMFNj?=
 =?utf-8?B?bi85dHUvTHdBODJ3UHppS1BwZFFZMThXQnlSYnhFYzdLMG43TDJxUDYvbnpj?=
 =?utf-8?B?cFdiWmtia3dNY2tiOVdjb0hEYksyanIxZ0wzSW1XMWQzODNsbDlPdERUYlV5?=
 =?utf-8?B?RW12OHVIVXc4SDF3c0plRTZnYzloZmxyQUdhRWJpTXJiNFRtTjVuQmJlRGxV?=
 =?utf-8?B?Z1RvV0FUSnk5VHE1RUt2b25LNFJsQlVEdTFJVU1Bd0JPMy9XUitsTjFBOWpO?=
 =?utf-8?B?c04ya0UwVE5UeFdoZzFOTHBpNXo3Q2Z0T2Myckt5bGFUWmdiKy9oY2c4bUpS?=
 =?utf-8?B?Ty9pKy9ZMk8wMHZoWHZiZ3pjSlZoWEc3TlRRTnVEcWU0VGJTT3JkSnFzNHEr?=
 =?utf-8?B?OTVNOHpIS1JUaVowV0E4ZTY2V0h0OUhsd1pjekM4dytuV08xNXNwNWkvcWUy?=
 =?utf-8?B?TDQrdmlROTRDQUp4akt3Sk0waE52aEtGVzZRTjlZaDU5L21xZlhsbmZyUmc4?=
 =?utf-8?B?Y2FRTkd2eUpvZmFtZ0NYa25OSitCU0l6LzBheUtCWTY5M2tZOXVRNk9tMFl2?=
 =?utf-8?B?Mm1Yc053N2puOFdTWFByMWZEWWNmZXY2WHZYcGFQWkNIUkxSbjQ5SHRYSlh6?=
 =?utf-8?B?M1daSEZ5VTVGcWdmbzVuWDB5QjZhREt3cS9jQ0VQaGl5VURXL21MeGFLdW9h?=
 =?utf-8?B?dVQwWHIyVUhkaWV0S1lOWGd6TEpDUHRzRG5YdmJuL0xoTlpPSVR0TEFxaE1p?=
 =?utf-8?B?aDJvMkw2VzZZLytMN1hUNTRMcW0yOXEzZ2NNSXBNQkV2anFYYncxc3IyOFFW?=
 =?utf-8?B?OGJwWWU1elhqRTRzcjY2Mkx2OE5HTFhGR1BpNEFHY0M5cks0ZDh6ZGF4V1Q5?=
 =?utf-8?B?UFNzTkxaUGVBNXk2Nm9hL0hJZzY1MGZCMVNaRWxWNHh4VWVTNGhvUXh1UEh3?=
 =?utf-8?B?L3hlTWI4cStQUGs4RWt5dElic3JMRXJuWDE0UjZDUjk4K1VSSG1XeWY0V2Fp?=
 =?utf-8?B?OXJvSmNYa0Vja3FEcjducks4K0FGZC9WSkJXUmdKUDV1S2V5SkhTMjAwSGly?=
 =?utf-8?B?ckZQRnMzUyswQ0NvYTRTRmRGOHlXRTRTd09tN01SQlRMMmdIM1l0bHNjQk9K?=
 =?utf-8?B?L2NGbWZYTGg5UHEwTm9iR1ZFWTNxaGNwTzRvMGUvd3BMc0hUL002OGpMVXVz?=
 =?utf-8?B?N2MzYUt5RWZTbkF0UnJHZldrWnhZSmxwendaenBPSG5tbklQQVU3b2NmcGlo?=
 =?utf-8?B?U0JLNEh6UU95TnpTbU9sd3dXcG0zYnB4cnl3VC80dlpoVGlBT2pBdTNDU3Fs?=
 =?utf-8?B?M1JFWDBmVmtXRzk5aCtKelRQSGVYWEVBSXp1MWRIREJaM091cm9FUjFhbUpr?=
 =?utf-8?B?M2ZXUFYxQm03eWZqd3Q3alNMaVFxSnBndTRxV3NNbmVyT1NNWGVXcDg3dzk0?=
 =?utf-8?B?RXJZOVNIREMvQ1JQWW1UZ2ZKVnBGVUpVYkIrQjFTZFZiWFVsMUhiMUVNQmox?=
 =?utf-8?B?enh6aitiRU9PTFU5V1JMcHM4Qno2V1NoRC9CanR0SGNpelJyZ0ZJZTFmcEM0?=
 =?utf-8?B?UkFlalNvMm11aWhrOHluRTZNRVRqcUEvWkFwdXF0TENUOWhWdDloWTQxVEFi?=
 =?utf-8?B?U1JWQzFuR0xkUW1mc2c0M1hUUWtEYnZROHJsYUk5ZzRlSVJCempORVFPSGpK?=
 =?utf-8?B?RVV2SElhUHltdmt3ZUVQV3RzVGRiUnVtekJIZDR0TWR6ZkJwUXRiSFFkNFRY?=
 =?utf-8?B?R3ljWU55M1k0d2tQQlZGaENXOTV2cU5iRVJBWTZXQlJzTUNoV0pZS3R2QmVU?=
 =?utf-8?Q?LuCBnq0Yyi2IzKl2TdYaACfWM?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9cd6dd-4c7a-43de-4f05-08db46f79922
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:15:44.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8VH3iwqaJLjuYr9JU6qsbAz+mEK0o7ydOca3GA22MnMGCmvfhFzW0O0ygrLHDPL9xJDAMgTG4cD9icErwE+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7749
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/26 19:05, Dmitry Rokosov wrote:
> [Some people who received this message don't often get email from ddrokosov@sberdevices.ru. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> On Mon, Apr 17, 2023 at 02:50:05PM +0800, Yu Tu wrote:
>> Add the peripherals clock controller driver in the s4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig          |   12 +
>>   drivers/clk/meson/Makefile         |    1 +
>>   drivers/clk/meson/s4-peripherals.c | 3814 ++++++++++++++++++++++++++++
>>   drivers/clk/meson/s4-peripherals.h |  217 ++
>>   4 files changed, 4044 insertions(+)
>>   create mode 100644 drivers/clk/meson/s4-peripherals.c
>>   create mode 100644 drivers/clk/meson/s4-peripherals.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index a663c90a3f3b..a6eb9fa15c74 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -128,4 +128,16 @@ config COMMON_CLK_S4_PLL
>>          aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>          Say Y if you want the board to work, because plls are the parent of most
>>          peripherals.
>> +
>> +config COMMON_CLK_S4
>> +     tristate "S4 SoC Peripherals clock controllers support"
>> +     depends on ARM64
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_DUALDIV
>> +     select COMMON_CLK_MESON_VID_PLL_DIV
>> +     help
>> +       Support for the Peripherals clock controller on Amlogic S805X2 and S905Y4
>> +       devices, aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>> +       Say Y if you want peripherals to work.
>>   endmenu
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 376f49cc13f1..c9130afccb48 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -20,3 +20,4 @@ obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>   obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
>> +obj-$(CONFIG_COMMON_CLK_S4) += s4-peripherals.o
> 
> [...]

?

> 
>> +static struct clk_regmap s4_ceca_32k_clkin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CECA_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ceca_32k_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = s4_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ceca_32k_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_sel_pre = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_CECA_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_sel_pre",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ceca_32k_div.hw,
>> +                     &s4_ceca_32k_clkin.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_CECA_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ceca_32k_sel_pre.hw,
>> +                     &s4_rtc_clk.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
> 
> In my opinion, all clocks that can inherit from a more accurate RTC clock
> should be marked with the CLK_SET_RATE_NO_REPARENT flag.
> This is necessary because in certain situations, it may be required to
> freeze their parent. The setup of these clocks' parent should be located
> on the device tree's side.

We don't need to freeze parent,in a real project.

> 
> [...]
> 
>> +
>> +/*
>> + * gen clk is designed for debug/monitor some internal clock quality. Some of the
>> + * corresponding clock sources are not described in the clock tree and internal clock
>> + * for debug, so they are skipped.
>> + */
>> +static u32 s4_gen_clk_mux_table[] = { 0, 4, 5, 7, 19, 21, 22,
>> +                                   23, 24, 25, 26, 27, 28 };
>> +static const struct clk_parent_data s4_gen_clk_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "fclk_div2", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll0", },
>> +     { .fw_name = "mpll1", },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "mpll3", },
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .mask = 0x1f,
>> +             .shift = 12,
>> +             .table = s4_gen_clk_mux_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gen_clk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_gen_clk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_gen_clk_parent_data),
> 
> I think, the gen_clk selector should be marked with the
> CLK_SET_RATE_NO_REPARENT flag. This is because the GEN clock can be
> connected to an external pad and may be set up directly from the
> device tree.

This is used by the debug table clock and is not connected externally.

> 
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gen_clk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_gen_clk_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_gen_clk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>> +     },
>> +};
>> +
> 
> [...]
> 
> --
> Thank you,
> Dmitry
