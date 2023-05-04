Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF676F67AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjEDIo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjEDIoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:44:23 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6CD2D5E;
        Thu,  4 May 2023 01:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVeTLrw5mV4ZDz++QopAtqrHvqxRVY0HY5SfDhtTp4INBW1TtS1QVuZPljP2Sn7qD5ZkRE1KyH9AUQjdqIdNQY4sNHwDccAYOWyZViCWRPMEBMac+Q2Elq3lmw2bMNToz7nlaKn1CB2y0iQwBbtvqRgNpxV2N1d0zOs7rCO6GiAMOFnr5UyGIxMxIeLyd9FXvedY2r0WdQx7le4atEr7j1iPQqTli00L1PARe+OtOXE8tLScQDGxiPnrLzEE5RCHsHdHjCJBdXUbsSEa03eu3w0Ta+9WI6zgnNmdIsuVBRERx4wOzwpp7Z0iW9YEOhkcyI0jPpphAKRGlzLa1BnNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHIRIKFZRIXFMPkN87Ibjvc8id0fWN8QEO8kBD3aKJ0=;
 b=Pt7kHi/AXhFHdIIdHdI81Gs2yozeHsuHYXwrozYSL+GAZjbJwQ3UXId2p25kqtk0w08II6wx2H4tSyUxMMgaCWBn7Cox1Y8NBEb7b7K0ZVxFv4X8S1PDL7hOKpewtius5sJVP1H+MC3U1dshU402WcgOnmnNJhzVMABebSTlzdGV/FsMys8X9ST6CRhfhsB83yLvKXZznPxdD/us+Z958VBWKTa03Lusu08qtJ+EdzxaQJQAGihLwnWaxilIWe7swfDiegJPj+0B+sUH2hOHXHhr9282Xd8bHfwXSO+TSnexB6qCcV3yysa3K4M1HNWvES43sQqkxACLUzu86u98mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHIRIKFZRIXFMPkN87Ibjvc8id0fWN8QEO8kBD3aKJ0=;
 b=KDmSk4TPMUWVNIFVOgCulUHj2230+b2cZVjhi9hCIQOCPMI5Hdkunn2ONEYjOREWU7j0fdlCHYkFWVQP+hkCc2zdKWLReYl2SLJY/KLnCjVKH4os9Zt7zprs6kVnQ6kibHERXEWHwjcnd2p6NY25gO2dizy+jEo/kyyvtnUhyp+1yk7PJZddJcEb+eu7E1ru4lBKb6aKUsOokdqYlkgseJ45+JpUhBMD8F1fMkLALfAZlqcwIAYDn5BByCorZEpPBLxiz/u5ezYaN9YmanzutC6oU64Hkmj/lDWpP6WenCNPUR+1Ri6PoEQeXWILVR+im5zpRo63i0m2ciy9i94IGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 TY0PR03MB6475.apcprd03.prod.outlook.com (2603:1096:400:1bd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.32; Thu, 4 May 2023 08:44:17 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 08:44:17 +0000
Message-ID: <82159a29-3d34-4d02-00c5-2d25e8a8a118@amlogic.com>
Date:   Thu, 4 May 2023 16:43:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V7 4/4] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-5-yu.tu@amlogic.com>
 <20230426110538.y2d4qhv2qffc62vj@CAB-WSD-L081021>
 <6cc4c3f2-4df5-6456-fe65-71aa4a13c866@amlogic.com>
 <1jpm7kuev7.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jpm7kuev7.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0185.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::20) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|TY0PR03MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: de5ae536-3f29-4e71-fbd7-08db4c7bbebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqnr3oV9V+MikvLBYeDVSf0PNI3TH6uZy+wvcp1s+uNcCVvqSX42/56Oxfj3w06IGOuSI5Rs117J7OFa5MS5ScZiHVmrm+N3UIzxUj0+MlNzSjdYkI7gG6VhXgQcV7rvmHyapgsgzIzqhNxLInxXbXIrz/l2nd2g8F7yPiq5fJMSpariRMMIKlFMoAFv39gWI+PQOdn2yaFL1+JQq7MKX3Sh0EKh0WzlaEaucRWVZOjdr8vpn/knVu5m+nDA5ccaXN26D1ueUm726LZz40YR5gJ9J9/c5oRdy1BzuWYNnQxlAf62FmcpNN61GFLgfsgc4+4Sz3Mz0XnJjeupwPSo9FUlNH9C4aIsTo55euHWuxxmk+2QMGjtVmevcp179f1SoDTsR+5vUYpRrKZkJ9S+rdMMCF44Aa+FaK6NmkTit98eNE7FtA2B2Vqq4uD3P/yBibp6TJWQU9r3CKZic8CTnilqOgYbG97S4kS9+tsFZNmlE2e2lYp+rUS46yl3SfpAhw4CBxyja+zyeSKxelL9lNscL2ZqfVxTnSXhyI6ZdVKcylOniSDT05GXMlINxJ7WZDmsu4KZNa2hH56pUgP8J5SPemGk09kjxvMG1ZKjEI/f4jwB76F3CrOYUqALhglb5gBxWrgxkRGmyzxqwLghYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39850400004)(136003)(396003)(346002)(451199021)(7416002)(44832011)(5660300002)(8676002)(86362001)(2616005)(31696002)(83380400001)(107886003)(26005)(6506007)(6512007)(186003)(53546011)(6486002)(38100700002)(966005)(41300700001)(316002)(478600001)(8936002)(54906003)(110136005)(36756003)(6666004)(4326008)(31686004)(66476007)(66946007)(2906002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENVdHRPOWIzVnhDemowbGhjMnNVOFI4UDRoUHBoRitXMDhGUHZBaG9DZWZU?=
 =?utf-8?B?WWM1RTVLMVpFZW9ITFVzbmRRZHBFTm5lVCtFbkk1aDgwMGtCOVdzM3Bocmxu?=
 =?utf-8?B?VnZiSzdVV2VFclJWbm5oUmJYNDYvM3BqM0g5Sk5LSVpic0U2Rm1qbEdKQUdG?=
 =?utf-8?B?WjFMaWtMUk5sWC9uZUZwcmhzb0FyN25Ga1lYRitoWEppdGNhZXJJK3UyUlk4?=
 =?utf-8?B?WVdKWE40SU1iek5TcGRjQjdOazZaeXdCdS96VVZveS8yK1FFNm9CZVBuMWs0?=
 =?utf-8?B?UGR1eXFwczJhTFRZUzVxUzZ0YzJzK3FFRHdpbGwrVGxhRERZbXZSL0pEZjUy?=
 =?utf-8?B?M3VwUUtEUG1tS3JGZFJ1eHBGVExHTGN0Um5IL1pzbVFHdVdqODFlWDBPZzY1?=
 =?utf-8?B?TG9EaXlxRG5NdXA4azZKcnpvZkIvMGJBb3dGMTFxTkI0UHpSSlhtUHYvZTQz?=
 =?utf-8?B?SUljNG9Cei9JYTQyd2VncjBWRnA0Z0p1Uy85NzlsZHR4R3VYMEhIZmJ6c0lu?=
 =?utf-8?B?Yk9NdlBDVkNTd1VIOHExNlRwS3Y3OHJWVzdUK2xkMlRXbEJrYzIzMy9XcEZI?=
 =?utf-8?B?Qjk1M05LZzFzRXpsU2dqTzRLeGNBNUpKRnFzcytTaFBPcFltWTMxcFFTTGpY?=
 =?utf-8?B?RS9uTUVRRHRORFpDczVXOENJaWJCbVVYZS8vNUtPQmFpR3FVQjc2LzBaTm9r?=
 =?utf-8?B?YVhsZzdFNG1obSsxcXpGYzdmVUhqa0N5VmROTzMrTjBDVS9IeDZmSTNzcmhG?=
 =?utf-8?B?bVZ2NmJxbjYrb25wQWhBQzNKaC9kNFZObEc3RmRWeW02ZmVwYm5yMGY4aVVV?=
 =?utf-8?B?dTBaUldkRjFWMXpzTkpWalRwQlBzQXNBVncyL0RtNlhuT09jaG96SDUyVDJx?=
 =?utf-8?B?TThjTktESmVhOFJKaDUvb1krZmtWQmhiNFhxeG1SSU55NSs5TXZENEVPb1pQ?=
 =?utf-8?B?VjRiaGs0WlZxMlNvY3lFUGpRNjE4ZkRRQ21LRHNOMlczMW95VlVSUmNzbXdI?=
 =?utf-8?B?NEMvY2ppUVJpYXNheWx0dEdkajhhTHB5WkZkS2RUSktiZ1FBd0Ivb2g2Yk83?=
 =?utf-8?B?bkZrbXlob1JtdTJmTFBXamxGVFBJUEkwVFJVQVhZQi9oR3ZGRVhyTVVzWU9w?=
 =?utf-8?B?aGNLZEo2S0RvdzNLSWNEd1B2WDVKdEFPOEpFTDVBbHRqLzkzRjloY0lXdXUy?=
 =?utf-8?B?a3dsMTgzeEtMcExZbmJ0bGJ0R2xkdjQvVDNKMkRSTDlNUmdPaTN1VmF1bXIr?=
 =?utf-8?B?WldwNit2ZkZTdEx6S2RXMmt4TFRWWWlZa01OK0hYc016d0RwUGt5dmF2L2lu?=
 =?utf-8?B?emFqUG42V0FEdEg0QVZuWm1VVlpxMTRnSVBLUXVzQi92M0tYSFNEYUN3WUVT?=
 =?utf-8?B?azVuRjNoZDNPODVoaHpBK2hielJEVU1Lb202TDBnZWMwd1RLVGJxUmRDRG9w?=
 =?utf-8?B?K0J3ODF3NGtOaEcrUWdJY2pXU0dkcUVUcElZRkZSSGVMV1VhNjF0M1ZvSTQr?=
 =?utf-8?B?dzBvYzFBQXlVc2E5WU1jTXpJbi9jNHRWNTNqQ0JtcGxsanN0TXFsVVo4bkN1?=
 =?utf-8?B?UGVnMTFHaTJKSUV5L2NzZTc5UGg1ZnlTNHpxanF5QTFFamN0S2tLeWxEM0c5?=
 =?utf-8?B?emM1WnR0dnlvOGp0V3AvbHd2dXZFRFcyOENGQnBIWVFRQTk2MWlzQ2ZXWWFq?=
 =?utf-8?B?NDMxYkgxc250MWlQSitSTkRNTUxHNmFWdnZoQ1R3cldCRGNOWlZVQmU2Umxj?=
 =?utf-8?B?NmhLdnRyajAxSVNjVnhxY3o5eFVET1lSaE5RQ3hmcmVNZS9PaUZXYWNhZk1K?=
 =?utf-8?B?aktBR1FpRlpHV1dHU01OcG14V09sU3NGZURhbDdVazV6SkJ5Z2RRdVBkYVgx?=
 =?utf-8?B?TjVheCtnOFg2ZVkrT2xJRXdKcVBjZ0ZFOWN2VVhCMWwyQzRjc1FVZ0JpTGxK?=
 =?utf-8?B?RWRHVVR3d2NWbVZ3SlBwaUt0WUJvaDRRTmtwRVZrU1Zqc3NKbVV1UVdmVkt0?=
 =?utf-8?B?b2dlZEloT2h6a3VmMTZVRU9CM2tlV3kwcnZSR1Y0eTU2aWFRcnRBZkpVZG5n?=
 =?utf-8?B?dHluejBiaUdKTUNzcFFZbTlTOEdIem9SVEZITW5Sdmp2Q0xjdHI3ZVY0cUZB?=
 =?utf-8?Q?EEXz/69s20wDFPOkmWx5Pw6g/?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5ae536-3f29-4e71-fbd7-08db4c7bbebf
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:44:17.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb7ztMWRKVbA8tWEuXTJNf0qLtHtL5tI5XlBUwsMWDzHeDPwsMCKzxcDirZ3JLWO3ZYmvwQWjCq9Tw5U1WlbMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6475
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/2 1:37, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu 27 Apr 2023 at 16:15, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> On 2023/4/26 19:05, Dmitry Rokosov wrote:
>>> [Some people who received this message don't often get email from
>>> ddrokosov@sberdevices.ru. Learn why this is important at
>>> https://aka.ms/LearnAboutSenderIdentification ]
>>> [ EXTERNAL EMAIL ]
>>> On Mon, Apr 17, 2023 at 02:50:05PM +0800, Yu Tu wrote:
>>>> Add the peripherals clock controller driver in the s4 SoC family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    drivers/clk/meson/Kconfig          |   12 +
>>>>    drivers/clk/meson/Makefile         |    1 +
>>>>    drivers/clk/meson/s4-peripherals.c | 3814 ++++++++++++++++++++++++++++
>>>>    drivers/clk/meson/s4-peripherals.h |  217 ++
>>>>    4 files changed, 4044 insertions(+)
>>>>    create mode 100644 drivers/clk/meson/s4-peripherals.c
>>>>    create mode 100644 drivers/clk/meson/s4-peripherals.h
>>>>
>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>> index a663c90a3f3b..a6eb9fa15c74 100644
>>>> --- a/drivers/clk/meson/Kconfig
>>>> +++ b/drivers/clk/meson/Kconfig
>>>> @@ -128,4 +128,16 @@ config COMMON_CLK_S4_PLL
>>>>           aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>>>           Say Y if you want the board to work, because plls are the parent of most
>>>>           peripherals.
>>>> +
>>>> +config COMMON_CLK_S4
>>>> +     tristate "S4 SoC Peripherals clock controllers support"
>>>> +     depends on ARM64
>>>> +     default y
>>>> +     select COMMON_CLK_MESON_REGMAP
>>>> +     select COMMON_CLK_MESON_DUALDIV
>>>> +     select COMMON_CLK_MESON_VID_PLL_DIV
>>>> +     help
>>>> +       Support for the Peripherals clock controller on Amlogic S805X2 and S905Y4
>>>> +       devices, aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>>> +       Say Y if you want peripherals to work.
>>>>    endmenu
>>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>>> index 376f49cc13f1..c9130afccb48 100644
>>>> --- a/drivers/clk/meson/Makefile
>>>> +++ b/drivers/clk/meson/Makefile
>>>> @@ -20,3 +20,4 @@ obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>>>    obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>>>    obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>>>    obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
>>>> +obj-$(CONFIG_COMMON_CLK_S4) += s4-peripherals.o
>>> [...]
>>
>> ?
>>
>>>
>>>> +static struct clk_regmap s4_ceca_32k_clkin = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = CLKCTRL_CECA_CTRL0,
>>>> +             .bit_idx = 31,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "ceca_32k_clkin",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_data = (const struct clk_parent_data []) {
>>>> +                     { .fw_name = "xtal", }
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_ceca_32k_div = {
>>>> +     .data = &(struct meson_clk_dualdiv_data){
>>>> +             .n1 = {
>>>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 12,
>>>> +             },
>>>> +             .n2 = {
>>>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>>>> +                     .shift   = 12,
>>>> +                     .width   = 12,
>>>> +             },
>>>> +             .m1 = {
>>>> +                     .reg_off = CLKCTRL_CECA_CTRL1,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 12,
>>>> +             },
>>>> +             .m2 = {
>>>> +                     .reg_off = CLKCTRL_CECA_CTRL1,
>>>> +                     .shift   = 12,
>>>> +                     .width   = 12,
>>>> +             },
>>>> +             .dual = {
>>>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .table = s4_32k_div_table,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "ceca_32k_div",
>>>> +             .ops = &meson_clk_dualdiv_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_ceca_32k_clkin.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_ceca_32k_sel_pre = {
>>>> +     .data = &(struct clk_regmap_mux_data) {
>>>> +             .offset = CLKCTRL_CECA_CTRL1,
>>>> +             .mask = 0x1,
>>>> +             .shift = 24,
>>>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "ceca_32k_sel_pre",
>>>> +             .ops = &clk_regmap_mux_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_ceca_32k_div.hw,
>>>> +                     &s4_ceca_32k_clkin.hw
>>>> +             },
>>>> +             .num_parents = 2,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_ceca_32k_sel = {
>>>> +     .data = &(struct clk_regmap_mux_data) {
>>>> +             .offset = CLKCTRL_CECA_CTRL1,
>>>> +             .mask = 0x1,
>>>> +             .shift = 31,
>>>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "ceca_32k_sel",
>>>> +             .ops = &clk_regmap_mux_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_ceca_32k_sel_pre.hw,
>>>> +                     &s4_rtc_clk.hw
>>>> +             },
>>>> +             .num_parents = 2,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>> In my opinion, all clocks that can inherit from a more accurate RTC clock
>>> should be marked with the CLK_SET_RATE_NO_REPARENT flag.
>>> This is necessary because in certain situations, it may be required to
>>> freeze their parent. The setup of these clocks' parent should be located
>>> on the device tree's side.
>>
>> We don't need to freeze parent,in a real project.
> 
> "a real project" to whom ?

Yes. We're using native code. Not upstream code. It's been a few years. 
We did it upstream after we were stable on the actual project.

> 
> Dmitry remark makes sense to me.

I will add the flag as you and Dmitry suggested.

> 
>>
>>> [...]
>>>
>>>> +
>>>> +/*
>>>> + * gen clk is designed for debug/monitor some internal clock quality. Some of the
>>>> + * corresponding clock sources are not described in the clock tree and internal clock
>>>> + * for debug, so they are skipped.
>>>> + */
>>>> +static u32 s4_gen_clk_mux_table[] = { 0, 4, 5, 7, 19, 21, 22,
>>>> +                                   23, 24, 25, 26, 27, 28 };
>>>> +static const struct clk_parent_data s4_gen_clk_parent_data[] = {
>>>> +     { .fw_name = "xtal", },
>>>> +     { .hw = &s4_vid_pll.hw },
>>>> +     { .fw_name = "gp0_pll", },
>>>> +     { .fw_name = "hifi_pll", },
>>>> +     { .fw_name = "fclk_div2", },
>>>> +     { .fw_name = "fclk_div3", },
>>>> +     { .fw_name = "fclk_div4", },
>>>> +     { .fw_name = "fclk_div5", },
>>>> +     { .fw_name = "fclk_div7", },
>>>> +     { .fw_name = "mpll0", },
>>>> +     { .fw_name = "mpll1", },
>>>> +     { .fw_name = "mpll2", },
>>>> +     { .fw_name = "mpll3", },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_gen_clk_sel = {
>>>> +     .data = &(struct clk_regmap_mux_data){
>>>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>>>> +             .mask = 0x1f,
>>>> +             .shift = 12,
>>>> +             .table = s4_gen_clk_mux_table,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "gen_clk_sel",
>>>> +             .ops = &clk_regmap_mux_ops,
>>>> +             .parent_data = s4_gen_clk_parent_data,
>>>> +             .num_parents = ARRAY_SIZE(s4_gen_clk_parent_data),
>>> I think, the gen_clk selector should be marked with the
>>> CLK_SET_RATE_NO_REPARENT flag. This is because the GEN clock can be
>>> connected to an external pad and may be set up directly from the
>>> device tree.
>>
>> This is used by the debug table clock and is not connected externally.
>>
> 
> Again, Dmitry remark is very interresting.
> This debug clock is typacally one you don't really want to automatically reparent
> 

I will add the flag as you and Dmitry suggested.
>>>
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_gen_clk_div = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>>>> +             .shift = 0,
>>>> +             .width = 11,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "gen_clk_div",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_gen_clk_sel.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_gen_clk = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>>>> +             .bit_idx = 11,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "gen_clk",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_gen_clk_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>>>> +     },
>>>> +};
>>>> +
>>> [...]
>>> --
>>> Thank you,
>>> Dmitry
> 
