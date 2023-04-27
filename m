Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625896F0245
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbjD0IEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbjD0IEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:04:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C8A2D65;
        Thu, 27 Apr 2023 01:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyjnr54RAlwJh58uPlNkQwiq4ObUflhPFfDUIoy8XF3wabM0flWTb6swQWV0HejKmA3vj/t16wdJLe71ZuJyZ0KKw6BXe7QBuHWqddsn5ShwCxr8TN6nZMdVr+vOldRFfHQAfBPQrOYHLy6zhVFxuJcKFzqX9uXArmA1q8jkKi5COkoeLnsn2SBc9WDQGmUleRrL/MKBg1wPTXE6yz5G8L35zRj8S2+H5Q2rjAehA4UYR1DeUpw49WZXiOGcrzaBwm5cjrMyvkkNoiKHBexbrF162wYvxecPFJ6Tf20LTBc1cXHVdaN5iIQqWaxMoYzZma1ZbCktfyVKddFaBsei1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SG3ccK5DmNnoarwpGhIWBa3ygaIgRCnU1XMuSZAZjn0=;
 b=DwrvL6c4wH/bGo8MtMzjTwZGALKclgjz+1MrFeBZ9yCVIWNBRRBmw/fHxAOBST1ke8qLVvPExtGHjVsTYDL2fKKjjEeZ72AYoP3l0ruuIg//MAiSrc8PokjGJfOWUjfpFx1hQScDSqd5KnD6SFl+1HFqT1hYYMW9YdJI2QZgT2s3m1HQywPsqM+JWeLpw26jHUDQ2vjztgFtW5diAZSy8Zh9ji2AxUGbFcnaDPJCQJ4/WRQX0ONHTBgNZb2b8M5MYEpl0pkiNOnYAvWhxCtTrunrp1j8XYyAkYUdwV/q849dYfRYR6POtksWZ8zHoXOscPYVJeKhWioOv3ZHy1+mow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG3ccK5DmNnoarwpGhIWBa3ygaIgRCnU1XMuSZAZjn0=;
 b=b9zHz5CkIqSGNUExCJ81ZWoZaWcjCnKkdXd5xFNYF9PXdNqM5zbgnQdLyxpCjqKhmwcPSs6onsgqVRjkmBVlZ6xYnLsNqhwCg2QLg6pmglimFEiJh5x2cK/N1CtIMZ6G39AnkLzoq5ou/1M1h8EN/bJCXL0g/pSiGeirBClZrDgj+50lRs+m9piE0mdnDj7r+QfpIieF8D7bf0GPbyfDA1yvhS5Ll+tAgvnelilc96Fp8xnUWRE9bf87pJzHHuO+nH242ONoBohx2x/kV+Zgic8IGaDoF9aWU2gLeaI3p5WnzWk0IuxAu9MVKcd4o3+Rp15kRvFfIfIBfV7/R6UiCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 TYUPR03MB7231.apcprd03.prod.outlook.com (2603:1096:400:357::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Thu, 27 Apr 2023 08:03:57 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6319.033; Thu, 27 Apr 2023
 08:03:57 +0000
Message-ID: <98fdedba-2715-23e7-1d2b-2d9334f0c674@amlogic.com>
Date:   Thu, 27 Apr 2023 16:03:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V7 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
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
 <20230417065005.24967-3-yu.tu@amlogic.com>
 <20230426104946.xiwsdjxris2faf7x@CAB-WSD-L081021>
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20230426104946.xiwsdjxris2faf7x@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|TYUPR03MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d1ea60-e876-4d2f-9734-08db46f5f2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmG4WdiAZp6zWJLK48Nhc5nZMmopaVerStHGIEE445tr2aCAKJVKhGzThdgRHlK7v7+QCP9sXX/DCdjmBFkaR53lvsHDxfI3ziafW2xwUG/HkBiJgoAYAHf/fIIU5nCj/7TAoJ/BwvWIt5OfKiX9Oj2nodCZyg8atCxzKt4erTcHppC+NSF755JjWj26zZjgzgEv7S7y7WDk+HlJNRiz3xzFhZ/EhIBztLV3GNRJV5J+eS0AcTdW8jfN2GleI7MpgQxhiH4KIYc65cHbvmqXLNU6KmBG3s0wnL+rHxjsKfHsuV5pix8UKvejZOWzexO1SrDRUkVjzPEht0u0pVE00I2Lz6K4+nQp7RPnHh8lPeyqFHXG0tahD5mfYcYdEHwBQQw06bSwNwS6ia6c674kFkovOAmAeZe2IPXy4hmrO9cE1B/zMLYqAI9u9IHXFmChMkV19M6E0qdqbwWQy8C/bJeodWlpncLGxlhz3h6mxhFmTjJFgSa9aUKsnDo0rBI9qVjFMiOE1sgXjOkif/JR9dpZO1Fbfyn3imFyLVuHQKMkgkTvuO/pL/l4srT6IWiqCmgmF+vygvEnaK1JM32mIOK4xDAZFLELwtwDw1WpaCZnbdvwSDiOQk8/B6jg7UEx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(396003)(136003)(346002)(366004)(451199021)(66556008)(66946007)(31686004)(2906002)(7416002)(44832011)(86362001)(31696002)(2616005)(66476007)(5660300002)(8676002)(8936002)(36756003)(316002)(6486002)(6916009)(41300700001)(4326008)(54906003)(478600001)(6666004)(966005)(186003)(26005)(83380400001)(6506007)(6512007)(53546011)(107886003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVjaXlBcWxQd2FXK3hoMGhodkEwUlNEQWxNUXI4NDcxcGJIemxpOVE5UGRV?=
 =?utf-8?B?QlFMYkl3VmxYdHB0RkhTL2FLKzlLMEZBUTNTZGIyMlBDdnNTVTZHcFJZTTZZ?=
 =?utf-8?B?S0RJa0dwTCsvck1LTUJmR1BEcWhrOEJTY2FHNDh2aUw5b0p3N2FHT1lvNFFT?=
 =?utf-8?B?STYwM1dhMmFVUDZXVE81VHlhQmVzVkl6SkZQRVlvZlVWRVpaU0hNeUhUTnlX?=
 =?utf-8?B?dUNVWDNSSVVZMG8wdE1rWmwxMU03RW1VZnBqYk9CL1YzWnl2dDlUOGhNZkMz?=
 =?utf-8?B?VGE3VmZjWTBVSVl6MnpZNHE5N1EzaEt5Ui9hTUNabE5XS3ZydWZ3cXJlcFFU?=
 =?utf-8?B?Z2xmTFV0YlhJMk1nVStQanhOUWFJMjZQOGxWMTlTeERPSmJWU3VsUXpZOCsy?=
 =?utf-8?B?T1lzSUpUaHF1WU5IL0p6eVBUM3lZU2JFUzYzcytSK2NCOWlOT1AzZ2RoME9C?=
 =?utf-8?B?dTgyK0I1TzFNMDB2d1M3Nk9UZnltYU0yZ3dRWCs1cVlmYTBUQThESE5Gc2NT?=
 =?utf-8?B?NUEvUGdFSzgrTm1MOGNPdS81bDFTYnRlcENYekZ1VEd1TzdpRGx4VDd1SFc2?=
 =?utf-8?B?M0h5c2hpb1E3WUsrdTYrckRZSDlHV1FrazRiL1NqSVRuVkE0MGxRdVB0b0tm?=
 =?utf-8?B?QXduT2NBcGZrWk1LYXo1R3BmSkpta0ZiNytBUzdCdWVkR1A1MHZkR1NMKzlD?=
 =?utf-8?B?MkpVUlQwRXM5YXBha1VkMm55MUVyTTlqQnU2VzViOWppSXoxSjlTQjI5Qksr?=
 =?utf-8?B?SXFiVXUwcGZPY25xT0gxN3BnZjZFcDhpTlBmOG9FVWZmZWV0UWZYS05GRENL?=
 =?utf-8?B?QW1zT3lLaGs0NE42cGJzMGlLRXBTU3VNd25qSTFCVGIxVTIvckhta3Vidlgw?=
 =?utf-8?B?ZzRCaUt4N1RmT2ZZNFhZOXV6K2lGdCszeTdhRGpMdzdueklLcXpUUmFCRHlH?=
 =?utf-8?B?WnliQTdBbmd2RkpyajRMQndnU2o2ZjJlZE03TUtUbjAwK2tsMjZianl2SkF0?=
 =?utf-8?B?M0hqejFrTnJwU3NKcWRYMGtNenl6MWJNVnJxZzh1WXJjZjMwNmo4MUx1ZWpm?=
 =?utf-8?B?RkN0NjZ4V2lPdjBuVjVYbEt0VGw3SStPM0FtTFNST1MrTnVaSVRGSmloU203?=
 =?utf-8?B?Nm5iTjJPd0RvSk1LK2ZHSmlyMzIwUjdTNnZ1TmdhcnJPVS8wR1p3MDdGV091?=
 =?utf-8?B?d2N6YklQeE96bUY3N20zK2NBaDNRaUxDcktGOGJjcjNrSzlwMSs0bitTa0d0?=
 =?utf-8?B?QzdpWWorU0szUGo3L2RLYXZQMXJ1QjQ5a1EvUjJDUEpKa2RHYW5VbEd2cEtV?=
 =?utf-8?B?eFRtN3JXRE0vU29iVFdWQ2dMNTc5VWsybzhkbE1kSGRQMyswUDdsSk1NaFNy?=
 =?utf-8?B?K2NibkpNNGgzVmtjellJd3c3aHZzUFpBWGpUSjBONjFQcHNaQWlqVHJGSXFi?=
 =?utf-8?B?TXp3UHNaT0hCbVRaT2JkRGVMdTdrRjhPS3JIWkJYYlV1QldvSkQwQ1VwWE5q?=
 =?utf-8?B?bWtzK1R0RkJhdkpTTU00eGVweHNYaFN2Uyt4UzRXU2JibTdTZEUxZlVlRHNS?=
 =?utf-8?B?c1E0MWRFcnlDOWhVMzU0b09YbkNldlN2Rk54QkRYMUdIbUp1WXA2WkxvOGZV?=
 =?utf-8?B?d3hySnNpektNaHNhNDZlSTRaRTFwK3dUZVk2TDBGQUwzc1ZZY2NrK05oeFZz?=
 =?utf-8?B?U3kwZ0JPd0FTRHhaMzErZmZ0cjVVeVhodTBJMkNpQTgveTVvLzZ4ZDh2NktB?=
 =?utf-8?B?cEh2SGowa0xodFFEQ3R3ZzBtd1FCOWhUUmdJN0NCc1ZCZGtkVTU1NnU4Ym9E?=
 =?utf-8?B?OEo5RkUxTERSbVdVUVk3Yjg5enA5eElnZFBOaFFUTXBlL1B3TGcvck10aWpF?=
 =?utf-8?B?UTdkVU5MZm5SUzZQUDlXdTVkNCtJZkFBdWZ3aWRjdEk0dXZuSzNtNGNKUmNu?=
 =?utf-8?B?cHM0c0ViVTgyVzZmMUwxZlRmMTNIMkpVYkR1Y2ZyaVJMUDlRa0NqOE1UdFY4?=
 =?utf-8?B?cm9xbzA1TVlFNE93aUJtdmdIcWlxWnBSS3IxeGp5cXZGbFdQZWpUdVJ0dmFY?=
 =?utf-8?B?VGFOVTRxalJ1cFFjWVpsTnlpNXBTTEpKUUxrT0gxOHhUQWNOa0hxQVRwSThs?=
 =?utf-8?Q?JEvJ4aEN4Pr0dBiEzCwz3bi8E?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d1ea60-e876-4d2f-9734-08db46f5f2ee
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:03:56.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFaKjPVfwg3GMwcz9gg/xEteqWELnESD8GsuyTvXHCxd/TPxze9PfhJIhDaod2MgNQ5Q15vetm+KH54Z4kC2vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7231
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/26 18:49, Dmitry Rokosov wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello Yu,
> 
> Thank you for the patch series! Please find my comments below.
> 

Hi Dmitry，
	Thank you for your review.

> On Mon, Apr 17, 2023 at 02:50:03PM +0800, Yu Tu wrote:
>> Add the S4 peripherals clock controller dt-bindings in the s4 SoC
>> family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   .../clock/amlogic,s4-peripherals-clkc.yaml    |  97 +++++++++++++
>>   .../clock/amlogic,s4-peripherals-clkc.h       | 131 ++++++++++++++++++
>>   2 files changed, 228 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>> new file mode 100644
>> index 000000000000..46b969a16a7c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>> @@ -0,0 +1,97 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Meson S serials Peripherals Clock Controller
> 
> As per my understanding, Meson is no longer applicable.
> As Neil and Martin suggested in other reviews, the term 'Amlogic' should
> be used instead or 'Meson' should be removed altogether.
> 

No. This was all agreed upon a long time ago. Corporate drivers and dtsi 
are named after this.

>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Yu Tu <yu.tu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,s4-peripherals-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: input fixed pll div2
>> +      - description: input fixed pll div2p5
>> +      - description: input fixed pll div3
>> +      - description: input fixed pll div4
>> +      - description: input fixed pll div5
>> +      - description: input fixed pll div7
>> +      - description: input hifi pll
>> +      - description: input gp0 pll
>> +      - description: input mpll0
>> +      - description: input mpll1
>> +      - description: input mpll2
>> +      - description: input mpll3
>> +      - description: input hdmi pll
>> +      - description: input oscillator (usually at 24MHz)
>> +      - description: input external 32kHz reference (optional)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fclk_div2
>> +      - const: fclk_div2p5
>> +      - const: fclk_div3
>> +      - const: fclk_div4
>> +      - const: fclk_div5
>> +      - const: fclk_div7
>> +      - const: hifi_pll
>> +      - const: gp0_pll
>> +      - const: mpll0
>> +      - const: mpll1
>> +      - const: mpll2
>> +      - const: mpll3
>> +      - const: hdmi_pll
>> +      - const: xtal
>> +      - const: ext_32k
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>> +
>> +    clkc_periphs: clock-controller@fe000000 {
>> +      compatible = "amlogic,s4-peripherals-clkc";
>> +      reg = <0xfe000000 0x49c>;
> 
> I was under the impression that reg as MMIO address should have four
> cells on ARM64 architecture. Are you sure it only needs two cells?

Yes. Maybe you can check out the clock file for other yaml.The two cells 
and four cells all are ok.

It's not a problem even in real DTS. How many cells are needed to look 
at the parent address-cells and size-cells definitions.

> 
>> +      clocks = <&clkc_pll 3>,
>> +              <&clkc_pll 13>,
>> +              <&clkc_pll 5>,
>> +              <&clkc_pll 7>,
>> +              <&clkc_pll 9>,
>> +              <&clkc_pll 11>,
>> +              <&clkc_pll 17>,
>> +              <&clkc_pll 15>,
>> +              <&clkc_pll 25>,
>> +              <&clkc_pll 27>,
>> +              <&clkc_pll 29>,
>> +              <&clkc_pll 31>,
>> +              <&clkc_pll 20>,
>> +              <&xtal>,
>> +              <&ext_32k>;
>> +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
>> +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
>> +                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
>> +                    "ext_32k";
>> +      #clock-cells = <1>;
>> +    };
>> +...
>> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>> new file mode 100644
>> index 000000000000..073396a76957
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>> @@ -0,0 +1,131 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>> +
>> +/*
>> + * CLKID index values
>> + */
>> +
>> +#define CLKID_RTC_CLK                        4
> 
> I believe that the CLK suffix is unnecessary since it is already clear
> that the object in question is a clock. Additionally, it is redundant
> to use the GATE suffix.

No. These prefixes and suffixes are very friendly to the people who 
write and read the code.

> 
>> +#define CLKID_SYS_CLK_B_GATE         7
>> +#define CLKID_SYS_CLK_A_GATE         10
>> +#define CLKID_SYS_CLK                        11
>> +#define CLKID_CECA_32K_CLKOUT                16
>> +#define CLKID_CECB_32K_CLKOUT                21
>> +#define CLKID_SC_CLK_GATE            24
>> +#define CLKID_12_24M_CLK_SEL         27
>> +#define CLKID_VID_PLL                        30
>> +#define CLKID_VCLK                   37
>> +#define CLKID_VCLK2                  38
>> +#define CLKID_VCLK_DIV1                      39
>> +#define CLKID_VCLK2_DIV1             44
>> +#define CLKID_VCLK_DIV2                      49
>> +#define CLKID_VCLK_DIV4                      50
>> +#define CLKID_VCLK_DIV6                      51
>> +#define CLKID_VCLK_DIV12             52
>> +#define CLKID_VCLK2_DIV2             53
>> +#define CLKID_VCLK2_DIV4             54
>> +#define CLKID_VCLK2_DIV6             55
>> +#define CLKID_VCLK2_DIV12            56
>> +#define CLKID_CTS_ENCI                       61
>> +#define CLKID_CTS_ENCP                       62
>> +#define CLKID_CTS_VDAC                       63
>> +#define CLKID_HDMI                   67
>> +#define CLKID_TS_CLK_GATE            69
>> +#define CLKID_MALI_0                 72
>> +#define CLKID_MALI_1                 75
>> +#define CLKID_MALI                   76
>> +#define CLKID_VDEC_P0                        79
>> +#define CLKID_VDEC_P1                        82
>> +#define CLKID_VDEC_SEL                       83
>> +#define CLKID_HEVCF_P0                       86
>> +#define CLKID_HEVCF_P1                       89
>> +#define CLKID_HEVCF_SEL                      90
>> +#define CLKID_VPU_0                  93
>> +#define CLKID_VPU_1                  96
>> +#define CLKID_VPU                    97
>> +#define CLKID_VPU_CLKB_TMP           100
>> +#define CLKID_VPU_CLKB                       102
>> +#define CLKID_VPU_CLKC_P0            105
>> +#define CLKID_VPU_CLKC_P1            108
>> +#define CLKID_VPU_CLKC_SEL           109
>> +#define CLKID_VAPB_0                 112
>> +#define CLKID_VAPB_1                 115
>> +#define CLKID_VAPB                   116
>> +#define CLKID_GE2D                   117
>> +#define CLKID_VDIN_MEAS_GATE         120
>> +#define CLKID_SD_EMMC_C_CLK          123
>> +#define CLKID_SD_EMMC_A_CLK          126
>> +#define CLKID_SD_EMMC_B_CLK          129
>> +#define CLKID_SPICC0_GATE            132
>> +#define CLKID_PWM_A_GATE             135
>> +#define CLKID_PWM_B_GATE             138
>> +#define CLKID_PWM_C_GATE             141
>> +#define CLKID_PWM_D_GATE             144
>> +#define CLKID_PWM_E_GATE             147
>> +#define CLKID_PWM_F_GATE             150
>> +#define CLKID_PWM_G_GATE             153
>> +#define CLKID_PWM_H_GATE             156
>> +#define CLKID_PWM_I_GATE             159
>> +#define CLKID_PWM_J_GATE             162
>> +#define CLKID_SARADC_GATE            165
>> +#define CLKID_GEN_GATE                       168
>> +#define CLKID_DDR                    169
>> +#define CLKID_DOS                    170
>> +#define CLKID_ETHPHY                 171
>> +#define CLKID_MALI_GATE                      172
>> +#define CLKID_AOCPU                  173
>> +#define CLKID_AUCPU                  174
>> +#define CLKID_CEC                    175
>> +#define CLKID_SD_EMMC_A                      176
>> +#define CLKID_SD_EMMC_B                      177
>> +#define CLKID_NAND                   178
>> +#define CLKID_SMARTCARD                      179
>> +#define CLKID_ACODEC                 180
>> +#define CLKID_SPIFC                  181
>> +#define CLKID_MSR_CLK                        182
>> +#define CLKID_IR_CTRL                        183
>> +#define CLKID_AUDIO                  184
>> +#define CLKID_ETH                    185
>> +#define CLKID_UART_A                 186
>> +#define CLKID_UART_B                 187
>> +#define CLKID_UART_C                 188
>> +#define CLKID_UART_D                 189
>> +#define CLKID_UART_E                 190
>> +#define CLKID_AIFIFO                 191
>> +#define CLKID_TS_DDR                 192
>> +#define CLKID_TS_PLL                 193
>> +#define CLKID_G2D                    194
>> +#define CLKID_SPICC0                 195
>> +#define CLKID_SPICC1                 196
>> +#define CLKID_USB                    197
>> +#define CLKID_I2C_M_A                        198
>> +#define CLKID_I2C_M_B                        199
>> +#define CLKID_I2C_M_C                        200
>> +#define CLKID_I2C_M_D                        201
>> +#define CLKID_I2C_M_E                        202
>> +#define CLKID_HDMITX_APB             203
>> +#define CLKID_I2C_S_A                        204
>> +#define CLKID_USB1_TO_DDR            205
>> +#define CLKID_HDCP22                 206
>> +#define CLKID_MMC_APB                        207
>> +#define CLKID_RSA                    208
>> +#define CLKID_CPU_DEBUG                      209
>> +#define CLKID_VPU_INTR                       210
>> +#define CLKID_DEMOD                  211
>> +#define CLKID_SAR_ADC                        212
>> +#define CLKID_GIC                    213
>> +#define CLKID_PWM_AB                 214
>> +#define CLKID_PWM_CD                 215
>> +#define CLKID_PWM_EF                 216
>> +#define CLKID_PWM_GH                 217
>> +#define CLKID_PWM_IJ                 218
>> +#define CLKID_HDCP22_ESMCLK_GATE     221
>> +#define CLKID_HDCP22_SKPCLK_GATE     224
>> +
>> +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
>> --
>> 2.33.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> --
> Thank you,
> Dmitry
