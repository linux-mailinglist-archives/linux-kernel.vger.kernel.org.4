Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA787275AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjFHDZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjFHDYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:24:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DAA26A6;
        Wed,  7 Jun 2023 20:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/Vkk/5BSAzHe/dfqXB7cHSPjmxccWceSj7kEEGgGJzQvqK4B5xY50RBuOG6XkE6BO9lK+3t9DOQdKUyA6+iA/jo3dpZF2lBaI2RhfPA+3lC9NogwCp4ca3h1MtzCWLlRWstFJPXjNemfhNKR+LBBX5VjlEVC9/YpfKivdTqpLfNxY0dsz/7ATo8/EY2e2GDHxavbGzkGRsXgKQJ3g3LBNXAfQB4j82euJTmMa3uU/nFQXSilkXuPYr65ZHcZlYW8LGtTpfQUb2xQxST66WLCDFLDAHqo/3ggR0w+mKd45ZHLUNxaOrnpuES8LuAuFaHSP86iEdbGicdzZAKL6ZHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHE27LxXq0liWW02wi12bkVPlsB3QjKf/j7H/igsTdA=;
 b=JOMWc7PW/hBdUzEEkkG5W/s8Vp3Jq9+2+u0i54HoI2MPWMq43TcPPVVU1/yiv4/rXT2Edoh8uYwqZhevVQMGuxGuuRz96jrOQ76EPUzPN2I139ZEXMtHA30pipuzm3i7lGG5ksRTmWQsA0R7vI1SIl1o0rjsNDDnzvc6m5WItk/nrBJrAQvqzyCp9fNnxedpmJFpRX3BnG8xgxRGitse659dDSebgYkh4MYzNLnae8rT/+ZdrMyOoX7tfz7GkXImTeO/huG48ADJmXCuQxfBd3/zjEzzr0Ky9PcJGD4f70rM/HZZtPGUjiR5NNrEWfp4jIVzBSz9cRwLEAOUyNO3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHE27LxXq0liWW02wi12bkVPlsB3QjKf/j7H/igsTdA=;
 b=DRwR/oFn6AefhiTFTlu3ZJ5huIAfFc0+hEorxAlCpbhbhoTyGQi4K1nOH5YnfBbmNFg4SfA1vROshFY5m93rVolnGNyr4qxBI3vlLXH9mmeh3ehkQhL89tcHg7HFC3S+mp3fJpOmahCW4LzfOUnq79q1cn2ChA0WCIrGapmupfag1pTGuz3wyIgI+f9Cvt41ptxSzap5MK+rF8/yTEOebKYnR83UNO5euEe4zKcAtGEMcD9MSrVubVowtxW1i5/NUY6Ru2Hwq7UKIgSYADytDkq1QUA1Xq0zoe/Q6D05Cvp72AT1M3LMWg7YvuQrKTeIjX8ZKhokCjBV/QwTKSiVIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 KL1PR03MB7671.apcprd03.prod.outlook.com (2603:1096:820:e3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Thu, 8 Jun 2023 03:24:37 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 03:24:37 +0000
Message-ID: <ef5f11a1-3821-0a2f-4bc4-1f4e748cd2e4@amlogic.com>
Date:   Thu, 8 Jun 2023 11:24:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V9 4/4] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Content-Language: en-US
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
 <20230517070215.28463-5-yu.tu@amlogic.com>
 <1jwn0g39t2.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jwn0g39t2.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::31) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|KL1PR03MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: db8b57d3-2163-411d-0272-08db67cfe287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee13Gm/J29adDx1cRpxls3R/fc8+WrLD6klOmHYUFsbsbUHw+xraFYbLlVlRfjwQT/kUUtiALwcOEyZ69YGCw0n3oXPjoWIzfB/JEfM8eF4gWda/BSWla+M2kk99sWKFuSf9ALSTmogJuZ3zoHmJT2wHO5HkW07X6nLk1u8ScI6uDO7+/BZPScComG7mCwbY3ryoaskuhcW0rUJgvhQbUbc4HAZPt6FCBWNo7RAAkrzH4nUiPGwDAwWf0C5oMf8rkZ+l4nJUGnr/2eqzp96DjKWea+7tEsn+YnBNGbN6boiWh5mk06CdLB/1Z8EP8rQ1nnrFsLpF84Ei+uolE3SdPSQdc8DqDM+f4C1W8DVcp58984TgpUv3p6AZBoGRThYR+sk4xaxjXZx+nLrBypzVMUwYft1VvfsgkZMRMWwP1RqVMI8Ul+ZJ7SSmKm6uBsClq+MVR2gHeooIwnI9OdWtV3pbTIxVVSOJTG2vr7jCEuRmgyiKPgyXNHjGD8jv0U/xpmsSIDqe1TwFcKJD3NLIHql3K2Tv7Rtg1TBtiu2dlct1c+tobm5SChUU0ONLC94kvrAKBGAwvDuh/7fK8h6DK4Wx1xKg2n7hUfC3OcJ4Y64tB8PAbYdfzhwERE8gOszjj9C+EpgSESsEs8gz7RZCdKCWjjCdtnLT2/PLKdE32qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(110136005)(478600001)(8676002)(44832011)(7416002)(86362001)(31696002)(36756003)(30864003)(2906002)(66946007)(8936002)(921005)(66556008)(66476007)(316002)(4326008)(5660300002)(38100700002)(6666004)(31686004)(41300700001)(83380400001)(6506007)(6512007)(2616005)(26005)(53546011)(107886003)(186003)(6486002)(45980500001)(43740500002)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0NPR1pudEFtOWFHK016RzVEYlM3UWtwQnBhMnFHak5zS3pTYkJ5eXRNazZC?=
 =?utf-8?B?NGlhUVJERWQ2Z0FsOGFNRThSMzMySi9tTVVkZUo3dU10Ly9naUhHN0hNd1Jt?=
 =?utf-8?B?WGh2ek1hSWNJZVM0S2ZKYk40MWFZYXZTcWVpcTd6TkI4c25SRW50OHZXb2F3?=
 =?utf-8?B?bFBKQjdRUDBsMDVwcVJwbWxiTDdSSFU2WXVuVzRHSk1nWkJqS09aeThicUZY?=
 =?utf-8?B?cVVDTEEzZTQwQnB6NXVtblVuYndIR2VhOS9MZHplNFp5Y3JDU3NpMFpNc21h?=
 =?utf-8?B?OU9JVHVwRnNrZjRoVHl6eDR4cTdHVjZ2VHNrQStMM3hSRUpOcHRxZUdpR2gy?=
 =?utf-8?B?WFY0VnpmeDJUWUZ0cERhTDludDVYMlAwRGdHVkdoeXFZRityUmo5REwwak9p?=
 =?utf-8?B?WjBSZTNTc3VoNzZhWUJSMm12T2hqOE5YNGZNMU1ldDZYcm5wemxJOS94VlpU?=
 =?utf-8?B?ZURFSGloVjRRdUt4dDNvSjhhWThmRlZML01sejdrOXJNb09POGVhbkVQTXQ2?=
 =?utf-8?B?VHdEWkhYTkxld29ybE9wVjZicjZnVWNHTlRDdVNuRjNYelpqamk4Wm14TjRG?=
 =?utf-8?B?S0RGYzQzd3RwZGpSaWllZGtPRHhUTTl3bWhoOXViSnZOS2RhaHRtdlNXQkdS?=
 =?utf-8?B?NnQ1ZGVyRVMxREtJdkVGRXFDSVM0TjhMbWdKNm5mZjYrd2JlL3QyWUJKT0F2?=
 =?utf-8?B?Nmc5NGtLdFFvZythNm5yVnlkU003aXVjM2tHT24wUS9HcE1ReEVIRURmb05B?=
 =?utf-8?B?UlZ6WW54MG1wblkzM2x3Y21jQXNpY2ZaR0p2UnY4NmNDbkxrUTRDWWlCUGpM?=
 =?utf-8?B?eUJ5dVdGT2JDQ3BKL2dNNXBURlZLY05DVHZvelU3c09IajVsWmVxOEN6TFdi?=
 =?utf-8?B?YkhCNWZNSjJ3c1ZrS05YSDZNSmFBb0dmZkltMndxdmdmRVV3TWFEcm1uWk9F?=
 =?utf-8?B?d01IWWUzK1g1WHZpczRuQWJ5QnRBeTBBbUhZWFQ5RWlZbVFYNmkxcExBcFNx?=
 =?utf-8?B?YUN6SkFCNlkzRThLdXpIaEhZRmVzZU0wK0h6QW5oYnBuRGpNVlFLY29sU0w4?=
 =?utf-8?B?bThDY0Z5QnUvdktEdmRNMnJGWlVYNG13K0xkMXBHZ2FDNzE1WXdlayt2TUpl?=
 =?utf-8?B?TXpoUVNRNm10QWNyWWlTeHFRQVN1TmRuWGE3NXV4TWU2Y2xzTVNtVFNacjYx?=
 =?utf-8?B?TzRWRDdFanZrYlJyTFRZaWVLUW5GRHJOOTRleHhmTW16Tkh2U3g5Q0pZSWxs?=
 =?utf-8?B?TnlwVW9DcUtFRW9KYWNVNUg1Z2VhU0hWKy9MelJ6ZmRTaDdCSVQ4MkFMNmls?=
 =?utf-8?B?MzdIdGxETTI2ZFBDRmM4b2d1YUdwMEVPWWVVRFpDWjFwdFBhaXNRR2FHTWpn?=
 =?utf-8?B?RkJlNzl4Yk4wVklkSyt6cStYVGl5RnJwTEpiN1ljdHRFbjdjWWFhZGxkUGVp?=
 =?utf-8?B?VndlellYNEU5QStGbUpqTVpMazFlVnRPTmJ4UVgyV2xjS0gvTFhLcWNQenNH?=
 =?utf-8?B?WUhINGpOZDV2dFkrS3l0dDZzcWtZeC91akYxMzJKSGVNNm9ycXk0OVlEWFp5?=
 =?utf-8?B?Q2FvSXMwR3RYWStadE01Ymp1VE5tTGlFVnpLeXBkdHJBNm9ZY1Y1ZDBoL3dC?=
 =?utf-8?B?QmZaNVBvSndyWEVlNXdRRkpnUEdyN3ZxQ0tsUnhPNjc3TlAzeGlicFNHazlv?=
 =?utf-8?B?aVhNV3hJYUlVNnVVemdJZlhVV0dIUGpsdUhHZllGT1lUbGtBTWxvZEJRQ0tO?=
 =?utf-8?B?ZE8vNmV2T0ZpVVZScjM0dzhNdGlFejZ5R2JyQVNNNWVMa1dJQm9VNS9pYjFn?=
 =?utf-8?B?d1NqclFZcnJJOEZDQlc5Q0xwUlkwUDNwSEVpblZLRlZuWjNKamJSa0pRa3l1?=
 =?utf-8?B?aktoTW5nc3pDd1BIbXZUM0c0djBnZElWRWx2a1pORFNpanYzQk9jNS9Bb1VR?=
 =?utf-8?B?eDZqVnk5MFo2SG1XWmNuRWx5MldxMDNvK01HWUFSMmVUQ2llVDJNVno2Yy9T?=
 =?utf-8?B?THh3V05XZFlvT1puTXJLR2JTVEFzZXAzbjVIMnJBRmYxL2pIL1NZMXlRSWIw?=
 =?utf-8?B?WXhvYjJCS2s0T3gxUUJqVUlvYUNCTEc4TXdnUUd3VEVSMUJscTNyUzBSVEtE?=
 =?utf-8?Q?aheH9vA14zaAMnb0QycNb7G+2?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8b57d3-2163-411d-0272-08db67cfe287
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 03:24:36.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDFQmPnEwnN/WV9ToGTamubHxx3/o7+Oh9We8f1qnnvLTnwi7wRgcuL8M7P+Xm8TiU/k9BVTuLUXlnIXnzrCWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7671
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/6 22:38, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 17 May 2023 at 15:02, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Add the peripherals clock controller driver in the s4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig          |   12 +
>>   drivers/clk/meson/Makefile         |    1 +
>>   drivers/clk/meson/s4-peripherals.c | 3830 ++++++++++++++++++++++++++++
>>   drivers/clk/meson/s4-peripherals.h |  217 ++
>>   4 files changed, 4060 insertions(+)
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
>> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
>> new file mode 100644
>> index 000000000000..fed094a4c2cc
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-peripherals.c
>> @@ -0,0 +1,3830 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Amlogic Meson-S4 Peripherals Clock Controller Driver
>> + *
>> + * Copyright (c) 2021 Amlogic, inc.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-regmap.h"
>> +#include "vid-pll-div.h"
>> +#include "clk-dualdiv.h"
>> +#include "s4-peripherals.h"
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_clkin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_by_oscin_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct meson_clk_dualdiv_param s4_32k_div_table[] = {
>> +     {
>> +             .dual   = 1,
>> +             .n1     = 733,
>> +             .m1     = 8,
>> +             .n2     = 732,
>> +             .m2     = 11,
>> +     },
>> +     {}
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = s4_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_by_oscin_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_rtc_32k_by_oscin_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_by_oscin_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_rtc_32k_by_oscin_div.hw,
>> +                     &s4_rtc_32k_by_oscin_clkin.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_by_oscin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_rtc_32k_by_oscin_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * This RTC clock can be supplied by an external 32KHz crystal oscillator.
>> + * If it is used, it should be documented in using fw_name and documented in the
>> + * Bindings. Not currently in use on this board.
>> + */
> 
> This is confusing and not really helpful
> What you describe here is simply the purpose of fw_name ... so it does
> not warrant a specific comment

Okay. I will delete this comment.

> 
>> +static const struct clk_parent_data rtc_clk_sel_parent_data[] = {
>> +     { .hw = &s4_rtc_32k_by_oscin.hw },
>> +     { .hw = &s4_rtc_32k_by_oscin_div.hw },
>> +     { .fw_name = "ext_32k",  }
>> +};
>> +
>> +/*
>> + * All clocks that can be inherited from a more accurate RTC clock are marked
>> + * with the CLK_SET_RATE_NO_REPARENT flag. This is because in certain
>> + * situations, we may need to freeze their parent. The parent setup of these
>> + * clocks should be located on the device tree side.
>> + */
> 
> It looks like the consensus is that CLK_SET_RATE_NO_REPARENT is not
> required. Please have at look at the discussion between Dmitry and
> Martin for the a1 controller

Okay.

> 
>> +static struct clk_regmap s4_rtc_clk = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_RTC_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 0,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_clk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = rtc_clk_sel_parent_data,
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* The index 5 is AXI_CLK, which is dedicated to AXI. So skip it. */
>> +static u32 mux_table_sys_ab_clk_sel[] = { 0, 1, 2, 3, 4, 6, 7 };
>> +static const struct clk_parent_data sys_ab_clk_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div2" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "fclk_div7" },
>> +     { .hw = &s4_rtc_clk.hw }
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 26,
>> +             .table = mux_table_sys_ab_clk_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sysclk_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = sys_ab_clk_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
>> +             /* For more information, please refer to rtc clock */
>> +             .flags = CLK_SET_RATE_NO_REPARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_b_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .shift = 16,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sysclk_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_b = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .bit_idx = 29,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sysclk_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 10,
>> +             .table = mux_table_sys_ab_clk_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sysclk_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = sys_ab_clk_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
>> +             /* For more information, please refer to rtc clock */
> 
> Copy/pasted comments like that just add verbosity
> Please make a global comment explaining your intent and the scope it
> 
> Using flag like this one only trigger question is reason for using it is
> unclear

okay.

> 
>> +             .flags = CLK_SET_RATE_NO_REPARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sysclk_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .bit_idx = 13,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sysclk_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sys_clk = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sys_clk",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_a.hw,
>> +                     &s4_sysclk_b.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
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
>> +             /* For more information, please refer to rtc clock */
>> +             .flags = CLK_SET_RATE_NO_REPARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_clkout = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CECA_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_clkout",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ceca_32k_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_clkin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CECB_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "cecb_32k_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = s4_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cecb_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cecb_32k_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_sel_pre = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_CECB_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cecb_32k_sel_pre",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cecb_32k_div.hw,
>> +                     &s4_cecb_32k_clkin.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_CECB_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cecb_32k_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cecb_32k_sel_pre.hw,
>> +                     &s4_rtc_clk.hw
>> +             },
>> +             .num_parents = 2,
>> +             /* For more information, please refer to rtc clock */
>> +             .flags = CLK_SET_RATE_NO_REPARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_clkout = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CECB_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cecb_32k_clkout",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cecb_32k_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_sc_parent_data[] = {
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "xtal", }
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SC_CLK_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sc_clk_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_sc_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_sc_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sc_clk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sc_clk_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sc_clk_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sc_clk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_12_24M_clk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "12_24m_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_12M_clk_div = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "12M",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_12_24M_clk_gate.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_12_24M_clk = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "12_24m",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_12_24M_clk_gate.hw,
>> +                     &s4_12M_clk_div.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* Video Clocks */
>> +static struct clk_regmap s4_vid_pll_div = {
>> +     .data = &(struct meson_vid_pll_div_data){
>> +             .val = {
>> +                     .reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>> +                     .shift   = 0,
>> +                     .width   = 15,
>> +             },
>> +             .sel = {
>> +                     .reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>> +                     .shift   = 16,
>> +                     .width   = 2,
>> +             },
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vid_pll_div",
>> +             /*
>> +              * TODO meson_vid_pll_div_ro_ops to meson_vid_pll_div_ops
>> +              */
>> +             .ops = &meson_vid_pll_div_ro_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "hdmi_pll", }
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vid_pll_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VID_PLL_CLK_DIV,
>> +             .mask = 0x1,
>> +             .shift = 18,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vid_pll_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .hw = &s4_vid_pll_div.hw },
>> +                     { .fw_name = "hdmi_pll", }
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vid_pll = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_PLL_CLK_DIV,
>> +             .bit_idx = 19,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vid_pll",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vid_pll_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_vclk_parent_data[] = {
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "mpll1", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 16,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 16,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_input = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_DIV,
>> +             .bit_idx = 16,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_input",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_input = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_DIV,
>> +             .bit_idx = 16,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_input",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VID_CLK_DIV,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_input.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VIID_CLK_DIV,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_input.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 19,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 19,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div2_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div2_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div4_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 2,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div4_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div6_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 3,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div6_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div12_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div12_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div2_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div2_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div4_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 2,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div4_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div6_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 3,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div6_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div12_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div12_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div2 = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div2",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_div2_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div4 = {
>> +     .mult = 1,
>> +     .div = 4,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div4",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_div4_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div6 = {
>> +     .mult = 1,
>> +     .div = 6,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div6",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_div6_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div12 = {
>> +     .mult = 1,
>> +     .div = 12,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div12",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_div12_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div2 = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div2",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_div2_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div4 = {
>> +     .mult = 1,
>> +     .div = 4,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div4",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_div4_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div6 = {
>> +     .mult = 1,
>> +     .div = 6,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div6",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_div6_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div12 = {
>> +     .mult = 1,
>> +     .div = 12,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div12",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_div12_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* The 5,6,7 indexes corresponds to no real clock, so there are not used. */
>> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +static const struct clk_hw *s4_cts_parent_hws[] = {
>> +     &s4_vclk_div1.hw,
>> +     &s4_vclk_div2.hw,
>> +     &s4_vclk_div4.hw,
>> +     &s4_vclk_div6.hw,
>> +     &s4_vclk_div12.hw,
>> +     &s4_vclk2_div1.hw,
>> +     &s4_vclk2_div2.hw,
>> +     &s4_vclk2_div4.hw,
>> +     &s4_vclk2_div6.hw,
>> +     &s4_vclk2_div12.hw
>> +};
>> +
>> +static struct clk_regmap s4_cts_enci_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VID_CLK_DIV,
>> +             .mask = 0xf,
>> +             .shift = 28,
>> +             .table = mux_table_cts_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cts_enci_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_cts_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_encp_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VID_CLK_DIV,
>> +             .mask = 0xf,
>> +             .shift = 20,
>> +             .table = mux_table_cts_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cts_encp_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_cts_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_vdac_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VIID_CLK_DIV,
>> +             .mask = 0xf,
>> +             .shift = 28,
>> +             .table = mux_table_cts_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cts_vdac_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_cts_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* The 5,6,7 indexes corresponds to no real clock, so there are not used. */
>> +static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +static const struct clk_hw *s4_cts_hdmi_tx_parent_hws[] = {
>> +     &s4_vclk_div1.hw,
>> +     &s4_vclk_div2.hw,
>> +     &s4_vclk_div4.hw,
>> +     &s4_vclk_div6.hw,
>> +     &s4_vclk_div12.hw,
>> +     &s4_vclk2_div1.hw,
>> +     &s4_vclk2_div2.hw,
>> +     &s4_vclk2_div4.hw,
>> +     &s4_vclk2_div6.hw,
>> +     &s4_vclk2_div12.hw
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_tx_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_HDMI_CLK_CTRL,
>> +             .mask = 0xf,
>> +             .shift = 16,
>> +             .table = mux_table_hdmi_tx_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_tx_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_cts_hdmi_tx_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_cts_hdmi_tx_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_enci = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL2,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "cts_enci",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cts_enci_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_encp = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL2,
>> +             .bit_idx = 2,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "cts_encp",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cts_encp_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_vdac = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL2,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "cts_vdac",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cts_vdac_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_tx = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL2,
>> +             .bit_idx = 5,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdmi_tx",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdmi_tx_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* HDMI Clocks */
>> +static const struct clk_parent_data s4_hdmi_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", }
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_HDMI_CLK_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_hdmi_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_hdmi_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_HDMI_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_hdmi_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdmi = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_HDMI_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdmi",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_hdmi_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ts_clk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_TS_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ts_clk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal",
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ts_clk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_TS_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ts_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ts_clk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
>> + * muxed by a glitch-free switch. The CCF can manage this glitch-free
>> + * mux because it does top-to-bottom updates the each clock tree and
>> + * switches to the "inactive" one when CLK_SET_RATE_GATE is set.
>> + */
>> +static const struct clk_parent_data s4_mali_0_1_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "fclk_div2p5", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", }
>> +};
>> +
>> +static struct clk_regmap s4_mali_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_mali_0_1_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
>> +             /*
>> +              * Don't request the parent to change the rate because
>> +              * all GPU frequencies can be derived from the fclk_*
>> +              * clocks and one special GP0_PLL setting. This is
>> +              * important because we need the MPLL clocks for audio.
>> +              */
> 
> So if I undertand correctly, you want to make sure the GP0 keep the rate
> you chose. That's valid reason but maybe you need to be consistent about
> this ?

Yes. GP0 was originally designed for use with Gpus. Unless we run into 
some chip design flaw cause, we need to do workround. It is possible for 
other modules to share GP0.

> 
> There are other possible consummers of GP0 which do have
> CLK_SET_RATE_PARENT. VDEC clocks is an example of this.
> 
> This is likely to break what you are trying to acheive here

So I should remove GP0 from another clock source, right?

> 
>> +             .flags = 0,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mali_0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mali_0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_mali_0_1_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
>> +             .flags = 0,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mali_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mali_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_hw *s4_mali_parent_hws[] = {
>> +     &s4_mali_0.hw,
>> +     &s4_mali_1.hw
>> +};
>> +
>> +static struct clk_regmap s4_mali_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .mask = 1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_mali_parent_hws,
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* VDEC clocks */
>> +static const struct clk_parent_data s4_dec_parent_data[] = {
>> +     { .fw_name = "fclk_div2p5", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "gp0_pll", },
> 
>   ...  here for example

OKay.

> 
>> +     { .fw_name = "xtal", }
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_p0_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_dec_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDEC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +             .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_p0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdec_p0_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDEC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vdec_p0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdec_p0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_p1_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_dec_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +             .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_p1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdec_p1_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vdec_p1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdec_p1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_hw *s4_vdec_mux_parent_hws[] = {
>> +     &s4_vdec_p0.hw,
>> +     &s4_vdec_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_vdec_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_vdec_mux_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_vdec_mux_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf_p0_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_dec_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +             .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf_p0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hevcf_p0_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hevcf_p0_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hevcf_p0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf_p1_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_dec_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +             .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf_p1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hevcf_p1_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hevcf_p1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hevcf_p1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_hw *s4_hevcf_mux_parent_hws[] = {
>> +     &s4_hevcf_p0.hw,
>> +     &s4_hevcf_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_hevcf_mux_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_hevcf_mux_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* VPU Clock */
>> +static const struct clk_parent_data s4_vpu_parent_data[] = {
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll1", },
> 
> This is likely to play against you since you said you wanted to
> preserve MPLL for audio
> 
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "gp0_pll", },
> 
> ... and again here

Okay.

> 
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vpu_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vpu_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .mask = 1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_0.hw,
>> +                     &s4_vpu_1.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data vpu_clkb_tmp_parent_data[] = {
>> +     { .hw = &s4_vpu.hw },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", }
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 20,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkb_tmp_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vpu_clkb_tmp_parent_data,
>> +             .num_parents = ARRAY_SIZE(vpu_clkb_tmp_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .shift = 16,
>> +             .width = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkb_tmp_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkb_tmp_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_clkb_tmp",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkb_tmp_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkb_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkb_tmp.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_clkb",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkb_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_vpu_clkc_parent_data[] = {
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll1", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "gp0_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0_mux  = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_p0_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vpu_clkc_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_p0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkc_p0_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_clkc_p0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkc_p0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_p1_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vpu_clkc_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_p1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkc_p1_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_clkc_p1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkc_p1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_hw *s4_vpu_mux_parent_hws[] = {
>> +     &s4_vpu_clkc_p0.hw,
>> +     &s4_vpu_clkc_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_vpu_mux_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_mux_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* VAPB Clock */
>> +static const struct clk_parent_data s4_vapb_parent_data[] = {
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll1", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "fclk_div2p5", },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vapb_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vapb_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vapb_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vapb_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vapb_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vapb_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .mask = 1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_0.hw,
>> +                     &s4_vapb_1.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ge2d_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ge2d_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vapb.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_esmclk_parent_data[] = {
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdcp22_esmclk_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_esmclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_esmclk_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdcp22_esmclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdcp22_esmclk_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdcp22_esmclk_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdcp22_esmclk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_skpclk_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdcp22_skpclk_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_skpclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_skpclk_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdcp22_skpclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdcp22_skpclk_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdcp22_skpclk_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdcp22_skpclk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_vdin_parent_data[]  = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .hw = &s4_vid_pll.hw }
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdin_meas_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vdin_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vdin_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdin_meas_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdin_meas_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vdin_meas_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdin_meas_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* EMMC/NAND clock */
>> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div2", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "fclk_div2p5", },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "mpll3", },
>> +     { .fw_name = "gp0_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c_clk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_sd_emmc_clk0_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c_clk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_c_clk0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_c_clk0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_c_clk0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a_clk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_sd_emmc_clk0_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a_clk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_a_clk0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_a_clk0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_a_clk0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_b_clk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_sd_emmc_clk0_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_b_clk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_b_clk0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_b_clk0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_b_clk0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* SPICC Clock */
>> +static const struct clk_parent_data s4_spicc_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .hw = &s4_sys_clk.hw },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div2", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc0_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_spicc_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_spicc_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_spicc0_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .bit_idx = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "spicc0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_spicc0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* PWM Clock */
>> +static const struct clk_parent_data s4_pwm_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_a_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_a_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_a_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_b_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_b_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_b_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_c_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_c_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_c_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_c_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_c_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_d_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_d_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_d_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_d_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_d_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_e_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_e_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_e_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_e_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_e_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_f_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_f_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_f_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_f_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_f_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_g_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_g_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_g_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_g_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_g_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_h_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_h_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_h_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_h_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_h_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_i_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_i_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_i_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_i_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_i_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_j_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_j_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_h_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_j_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_j_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_saradc_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "saradc_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", },
>> +                     { .hw = &s4_sys_clk.hw },
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_saradc_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "saradc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_saradc_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_saradc_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "saradc_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_saradc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
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
>> +             /*
>> +              *  Because the GEN clock can be connected to an external pad
>> +              *  and may be set up directly from the device tree. Don't
>> +              *  really want to automatically reparent.
>> +              */
>> +             .flags = CLK_SET_RATE_NO_REPARENT,
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
>> +static const struct clk_parent_data s4_adc_extclk_in_parent_data[]  = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "hifi_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "adc_extclk_in_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_adc_extclk_in_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_adc_extclk_in_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "adc_extclk_in_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_adc_extclk_in_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "adc_extclk_in",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_adc_extclk_in_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "demod_core_clk_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", },
>> +                     { .fw_name = "fclk_div7", },
>> +                     { .fw_name = "fclk_div4", },
>> +                     { .hw = &s4_adc_extclk_in_gate.hw }
>> +             },
>> +             .num_parents = 4,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "demod_core_clk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_demod_core_clk_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "demod_core_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_demod_core_clk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +#define MESON_GATE(_name, _reg, _bit) \
>> +     MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw)
>> +
>> +static MESON_GATE(s4_ddr,            CLKCTRL_SYS_CLK_EN0_REG0, 0);
>> +static MESON_GATE(s4_dos,            CLKCTRL_SYS_CLK_EN0_REG0, 1);
>> +static MESON_GATE(s4_ethphy,         CLKCTRL_SYS_CLK_EN0_REG0, 4);
>> +static MESON_GATE(s4_mali,           CLKCTRL_SYS_CLK_EN0_REG0, 6);
>> +static MESON_GATE(s4_aocpu,          CLKCTRL_SYS_CLK_EN0_REG0, 13);
>> +static MESON_GATE(s4_aucpu,          CLKCTRL_SYS_CLK_EN0_REG0, 14);
>> +static MESON_GATE(s4_cec,            CLKCTRL_SYS_CLK_EN0_REG0, 16);
>> +static MESON_GATE(s4_sdemmca,                CLKCTRL_SYS_CLK_EN0_REG0, 24);
>> +static MESON_GATE(s4_sdemmcb,                CLKCTRL_SYS_CLK_EN0_REG0, 25);
>> +static MESON_GATE(s4_nand,           CLKCTRL_SYS_CLK_EN0_REG0, 26);
>> +static MESON_GATE(s4_smartcard,              CLKCTRL_SYS_CLK_EN0_REG0, 27);
>> +static MESON_GATE(s4_acodec,         CLKCTRL_SYS_CLK_EN0_REG0, 28);
>> +static MESON_GATE(s4_spifc,          CLKCTRL_SYS_CLK_EN0_REG0, 29);
>> +static MESON_GATE(s4_msr_clk,                CLKCTRL_SYS_CLK_EN0_REG0, 30);
>> +static MESON_GATE(s4_ir_ctrl,                CLKCTRL_SYS_CLK_EN0_REG0, 31);
>> +static MESON_GATE(s4_audio,          CLKCTRL_SYS_CLK_EN0_REG1, 0);
>> +static MESON_GATE(s4_eth,            CLKCTRL_SYS_CLK_EN0_REG1, 3);
>> +static MESON_GATE(s4_uart_a,         CLKCTRL_SYS_CLK_EN0_REG1, 5);
>> +static MESON_GATE(s4_uart_b,         CLKCTRL_SYS_CLK_EN0_REG1, 6);
>> +static MESON_GATE(s4_uart_c,         CLKCTRL_SYS_CLK_EN0_REG1, 7);
>> +static MESON_GATE(s4_uart_d,         CLKCTRL_SYS_CLK_EN0_REG1, 8);
>> +static MESON_GATE(s4_uart_e,         CLKCTRL_SYS_CLK_EN0_REG1, 9);
>> +static MESON_GATE(s4_aififo,         CLKCTRL_SYS_CLK_EN0_REG1, 11);
>> +static MESON_GATE(s4_ts_ddr,         CLKCTRL_SYS_CLK_EN0_REG1, 15);
>> +static MESON_GATE(s4_ts_pll,         CLKCTRL_SYS_CLK_EN0_REG1, 16);
>> +static MESON_GATE(s4_g2d,            CLKCTRL_SYS_CLK_EN0_REG1, 20);
>> +static MESON_GATE(s4_spicc0,         CLKCTRL_SYS_CLK_EN0_REG1, 21);
>> +static MESON_GATE(s4_usb,            CLKCTRL_SYS_CLK_EN0_REG1, 26);
>> +static MESON_GATE(s4_i2c_m_a,                CLKCTRL_SYS_CLK_EN0_REG1, 30);
>> +static MESON_GATE(s4_i2c_m_b,                CLKCTRL_SYS_CLK_EN0_REG1, 31);
>> +static MESON_GATE(s4_i2c_m_c,                CLKCTRL_SYS_CLK_EN0_REG2, 0);
>> +static MESON_GATE(s4_i2c_m_d,                CLKCTRL_SYS_CLK_EN0_REG2, 1);
>> +static MESON_GATE(s4_i2c_m_e,                CLKCTRL_SYS_CLK_EN0_REG2, 2);
>> +static MESON_GATE(s4_hdmitx_apb,     CLKCTRL_SYS_CLK_EN0_REG2, 4);
>> +static MESON_GATE(s4_i2c_s_a,                CLKCTRL_SYS_CLK_EN0_REG2, 5);
>> +static MESON_GATE(s4_usb1_to_ddr,    CLKCTRL_SYS_CLK_EN0_REG2, 8);
>> +static MESON_GATE(s4_hdcp22,         CLKCTRL_SYS_CLK_EN0_REG2, 10);
>> +static MESON_GATE(s4_mmc_apb,                CLKCTRL_SYS_CLK_EN0_REG2, 11);
>> +static MESON_GATE(s4_rsa,            CLKCTRL_SYS_CLK_EN0_REG2, 18);
>> +static MESON_GATE(s4_cpu_debug,              CLKCTRL_SYS_CLK_EN0_REG2, 19);
>> +static MESON_GATE(s4_vpu_intr,               CLKCTRL_SYS_CLK_EN0_REG2, 25);
>> +static MESON_GATE(s4_demod,          CLKCTRL_SYS_CLK_EN0_REG2, 27);
>> +static MESON_GATE(s4_sar_adc,                CLKCTRL_SYS_CLK_EN0_REG2, 28);
>> +static MESON_GATE(s4_gic,            CLKCTRL_SYS_CLK_EN0_REG2, 30);
>> +static MESON_GATE(s4_pwm_ab,         CLKCTRL_SYS_CLK_EN0_REG3, 7);
>> +static MESON_GATE(s4_pwm_cd,         CLKCTRL_SYS_CLK_EN0_REG3, 8);
>> +static MESON_GATE(s4_pwm_ef,         CLKCTRL_SYS_CLK_EN0_REG3, 9);
>> +static MESON_GATE(s4_pwm_gh,         CLKCTRL_SYS_CLK_EN0_REG3, 10);
>> +static MESON_GATE(s4_pwm_ij,         CLKCTRL_SYS_CLK_EN0_REG3, 11);
>> +
>> +/* Array of all clocks provided by this provider */
>> +static struct clk_hw_onecell_data s4_periphs_hw_onecell_data = {
>> +     .hws = {
>> +             [CLKID_RTC_32K_CLKIN]           = &s4_rtc_32k_by_oscin_clkin.hw,
>> +             [CLKID_RTC_32K_DIV]             = &s4_rtc_32k_by_oscin_div.hw,
>> +             [CLKID_RTC_32K_SEL]             = &s4_rtc_32k_by_oscin_sel.hw,
>> +             [CLKID_RTC_32K_XATL]            = &s4_rtc_32k_by_oscin.hw,
>> +             [CLKID_RTC]                     = &s4_rtc_clk.hw,
>> +             [CLKID_SYS_CLK_B_SEL]           = &s4_sysclk_b_sel.hw,
>> +             [CLKID_SYS_CLK_B_DIV]           = &s4_sysclk_b_div.hw,
>> +             [CLKID_SYS_CLK_B]               = &s4_sysclk_b.hw,
>> +             [CLKID_SYS_CLK_A_SEL]           = &s4_sysclk_a_sel.hw,
>> +             [CLKID_SYS_CLK_A_DIV]           = &s4_sysclk_a_div.hw,
>> +             [CLKID_SYS_CLK_A]               = &s4_sysclk_a.hw,
>> +             [CLKID_SYS]                     = &s4_sys_clk.hw,
>> +             [CLKID_CECA_32K_CLKIN]          = &s4_ceca_32k_clkin.hw,
>> +             [CLKID_CECA_32K_DIV]            = &s4_ceca_32k_div.hw,
>> +             [CLKID_CECA_32K_SEL_PRE]        = &s4_ceca_32k_sel_pre.hw,
>> +             [CLKID_CECA_32K_SEL]            = &s4_ceca_32k_sel.hw,
>> +             [CLKID_CECA_32K_CLKOUT]         = &s4_ceca_32k_clkout.hw,
>> +             [CLKID_CECB_32K_CLKIN]          = &s4_cecb_32k_clkin.hw,
>> +             [CLKID_CECB_32K_DIV]            = &s4_cecb_32k_div.hw,
>> +             [CLKID_CECB_32K_SEL_PRE]        = &s4_cecb_32k_sel_pre.hw,
>> +             [CLKID_CECB_32K_SEL]            = &s4_cecb_32k_sel.hw,
>> +             [CLKID_CECB_32K_CLKOUT]         = &s4_cecb_32k_clkout.hw,
>> +             [CLKID_SC_CLK_SEL]              = &s4_sc_clk_mux.hw,
>> +             [CLKID_SC_CLK_DIV]              = &s4_sc_clk_div.hw,
>> +             [CLKID_SC]                      = &s4_sc_clk_gate.hw,
>> +             [CLKID_12_24M]                  = &s4_12_24M_clk_gate.hw,
>> +             [CLKID_12M_CLK_DIV]             = &s4_12M_clk_div.hw,
>> +             [CLKID_12_24M_CLK_SEL]          = &s4_12_24M_clk.hw,
>> +             [CLKID_VID_PLL_DIV]             = &s4_vid_pll_div.hw,
>> +             [CLKID_VID_PLL_SEL]             = &s4_vid_pll_sel.hw,
>> +             [CLKID_VID_PLL]                 = &s4_vid_pll.hw,
>> +             [CLKID_VCLK_SEL]                = &s4_vclk_sel.hw,
>> +             [CLKID_VCLK2_SEL]               = &s4_vclk2_sel.hw,
>> +             [CLKID_VCLK_INPUT]              = &s4_vclk_input.hw,
>> +             [CLKID_VCLK2_INPUT]             = &s4_vclk2_input.hw,
>> +             [CLKID_VCLK_DIV]                = &s4_vclk_div.hw,
>> +             [CLKID_VCLK2_DIV]               = &s4_vclk2_div.hw,
>> +             [CLKID_VCLK]                    = &s4_vclk.hw,
>> +             [CLKID_VCLK2]                   = &s4_vclk2.hw,
>> +             [CLKID_VCLK_DIV1]               = &s4_vclk_div1.hw,
>> +             [CLKID_VCLK_DIV2_EN]            = &s4_vclk_div2_en.hw,
>> +             [CLKID_VCLK_DIV4_EN]            = &s4_vclk_div4_en.hw,
>> +             [CLKID_VCLK_DIV6_EN]            = &s4_vclk_div6_en.hw,
>> +             [CLKID_VCLK_DIV12_EN]           = &s4_vclk_div12_en.hw,
>> +             [CLKID_VCLK2_DIV1]              = &s4_vclk2_div1.hw,
>> +             [CLKID_VCLK2_DIV2_EN]           = &s4_vclk2_div2_en.hw,
>> +             [CLKID_VCLK2_DIV4_EN]           = &s4_vclk2_div4_en.hw,
>> +             [CLKID_VCLK2_DIV6_EN]           = &s4_vclk2_div6_en.hw,
>> +             [CLKID_VCLK2_DIV12_EN]          = &s4_vclk2_div12_en.hw,
>> +             [CLKID_VCLK_DIV2]               = &s4_vclk_div2.hw,
>> +             [CLKID_VCLK_DIV4]               = &s4_vclk_div4.hw,
>> +             [CLKID_VCLK_DIV6]               = &s4_vclk_div6.hw,
>> +             [CLKID_VCLK_DIV12]              = &s4_vclk_div12.hw,
>> +             [CLKID_VCLK2_DIV2]              = &s4_vclk2_div2.hw,
>> +             [CLKID_VCLK2_DIV4]              = &s4_vclk2_div4.hw,
>> +             [CLKID_VCLK2_DIV6]              = &s4_vclk2_div6.hw,
>> +             [CLKID_VCLK2_DIV12]             = &s4_vclk2_div12.hw,
>> +             [CLKID_CTS_ENCI_SEL]            = &s4_cts_enci_sel.hw,
>> +             [CLKID_CTS_ENCP_SEL]            = &s4_cts_encp_sel.hw,
>> +             [CLKID_CTS_VDAC_SEL]            = &s4_cts_vdac_sel.hw,
>> +             [CLKID_HDMI_TX_SEL]             = &s4_hdmi_tx_sel.hw,
>> +             [CLKID_CTS_ENCI]                = &s4_cts_enci.hw,
>> +             [CLKID_CTS_ENCP]                = &s4_cts_encp.hw,
>> +             [CLKID_CTS_VDAC]                = &s4_cts_vdac.hw,
>> +             [CLKID_HDMI_TX]                 = &s4_hdmi_tx.hw,
>> +             [CLKID_HDMI_SEL]                = &s4_hdmi_sel.hw,
>> +             [CLKID_HDMI_DIV]                = &s4_hdmi_div.hw,
>> +             [CLKID_HDMI]                    = &s4_hdmi.hw,
>> +             [CLKID_TS_CLK_DIV]              = &s4_ts_clk_div.hw,
>> +             [CLKID_TS]                      = &s4_ts_clk_gate.hw,
>> +             [CLKID_MALI_0_SEL]              = &s4_mali_0_sel.hw,
>> +             [CLKID_MALI_0_DIV]              = &s4_mali_0_div.hw,
>> +             [CLKID_MALI_0]                  = &s4_mali_0.hw,
>> +             [CLKID_MALI_1_SEL]              = &s4_mali_1_sel.hw,
>> +             [CLKID_MALI_1_DIV]              = &s4_mali_1_div.hw,
>> +             [CLKID_MALI_1]                  = &s4_mali_1.hw,
>> +             [CLKID_MALI_SEL]                = &s4_mali_mux.hw,
>> +             [CLKID_VDEC_P0_SEL]             = &s4_vdec_p0_mux.hw,
>> +             [CLKID_VDEC_P0_DIV]             = &s4_vdec_p0_div.hw,
>> +             [CLKID_VDEC_P0]                 = &s4_vdec_p0.hw,
>> +             [CLKID_VDEC_P1_SEL]             = &s4_vdec_p1_mux.hw,
>> +             [CLKID_VDEC_P1_DIV]             = &s4_vdec_p1_div.hw,
>> +             [CLKID_VDEC_P1]                 = &s4_vdec_p1.hw,
>> +             [CLKID_VDEC_SEL]                = &s4_vdec_mux.hw,
>> +             [CLKID_HEVCF_P0_SEL]            = &s4_hevcf_p0_mux.hw,
>> +             [CLKID_HEVCF_P0_DIV]            = &s4_hevcf_p0_div.hw,
>> +             [CLKID_HEVCF_P0]                = &s4_hevcf_p0.hw,
>> +             [CLKID_HEVCF_P1_SEL]            = &s4_hevcf_p1_mux.hw,
>> +             [CLKID_HEVCF_P1_DIV]            = &s4_hevcf_p1_div.hw,
>> +             [CLKID_HEVCF_P1]                = &s4_hevcf_p1.hw,
>> +             [CLKID_HEVCF_SEL]               = &s4_hevcf_mux.hw,
>> +             [CLKID_VPU_0_SEL]               = &s4_vpu_0_sel.hw,
>> +             [CLKID_VPU_0_DIV]               = &s4_vpu_0_div.hw,
>> +             [CLKID_VPU_0]                   = &s4_vpu_0.hw,
>> +             [CLKID_VPU_1_SEL]               = &s4_vpu_1_sel.hw,
>> +             [CLKID_VPU_1_DIV]               = &s4_vpu_1_div.hw,
>> +             [CLKID_VPU_1]                   = &s4_vpu_1.hw,
>> +             [CLKID_VPU]                     = &s4_vpu.hw,
>> +             [CLKID_VPU_CLKB_TMP_SEL]        = &s4_vpu_clkb_tmp_mux.hw,
>> +             [CLKID_VPU_CLKB_TMP_DIV]        = &s4_vpu_clkb_tmp_div.hw,
>> +             [CLKID_VPU_CLKB_TMP]            = &s4_vpu_clkb_tmp.hw,
>> +             [CLKID_VPU_CLKB_DIV]            = &s4_vpu_clkb_div.hw,
>> +             [CLKID_VPU_CLKB]                = &s4_vpu_clkb.hw,
>> +             [CLKID_VPU_CLKC_P0_SEL]         = &s4_vpu_clkc_p0_mux.hw,
>> +             [CLKID_VPU_CLKC_P0_DIV]         = &s4_vpu_clkc_p0_div.hw,
>> +             [CLKID_VPU_CLKC_P0]             = &s4_vpu_clkc_p0.hw,
>> +             [CLKID_VPU_CLKC_P1_SEL]         = &s4_vpu_clkc_p1_mux.hw,
>> +             [CLKID_VPU_CLKC_P1_DIV]         = &s4_vpu_clkc_p1_div.hw,
>> +             [CLKID_VPU_CLKC_P1]             = &s4_vpu_clkc_p1.hw,
>> +             [CLKID_VPU_CLKC_SEL]            = &s4_vpu_clkc_mux.hw,
>> +             [CLKID_VAPB_0_SEL]              = &s4_vapb_0_sel.hw,
>> +             [CLKID_VAPB_0_DIV]              = &s4_vapb_0_div.hw,
>> +             [CLKID_VAPB_0]                  = &s4_vapb_0.hw,
>> +             [CLKID_VAPB_1_SEL]              = &s4_vapb_1_sel.hw,
>> +             [CLKID_VAPB_1_DIV]              = &s4_vapb_1_div.hw,
>> +             [CLKID_VAPB_1]                  = &s4_vapb_1.hw,
>> +             [CLKID_VAPB]                    = &s4_vapb.hw,
>> +             [CLKID_GE2D]                    = &s4_ge2d_gate.hw,
>> +             [CLKID_VDIN_MEAS_SEL]           = &s4_vdin_meas_mux.hw,
>> +             [CLKID_VDIN_MEAS_DIV]           = &s4_vdin_meas_div.hw,
>> +             [CLKID_VDIN_MEAS]               = &s4_vdin_meas_gate.hw,
>> +             [CLKID_SD_EMMC_C_CLK_SEL]       = &s4_sd_emmc_c_clk0_sel.hw,
>> +             [CLKID_SD_EMMC_C_CLK_DIV]       = &s4_sd_emmc_c_clk0_div.hw,
>> +             [CLKID_SD_EMMC_C]               = &s4_sd_emmc_c_clk0.hw,
>> +             [CLKID_SD_EMMC_A_CLK_SEL]       = &s4_sd_emmc_a_clk0_sel.hw,
>> +             [CLKID_SD_EMMC_A_CLK_DIV]       = &s4_sd_emmc_a_clk0_div.hw,
>> +             [CLKID_SD_EMMC_A]               = &s4_sd_emmc_a_clk0.hw,
>> +             [CLKID_SD_EMMC_B_CLK_SEL]       = &s4_sd_emmc_b_clk0_sel.hw,
>> +             [CLKID_SD_EMMC_B_CLK_DIV]       = &s4_sd_emmc_b_clk0_div.hw,
>> +             [CLKID_SD_EMMC_B]               = &s4_sd_emmc_b_clk0.hw,
>> +             [CLKID_SPICC0_SEL]              = &s4_spicc0_mux.hw,
>> +             [CLKID_SPICC0_DIV]              = &s4_spicc0_div.hw,
>> +             [CLKID_SPICC0_EN]               = &s4_spicc0_gate.hw,
>> +             [CLKID_PWM_A_SEL]               = &s4_pwm_a_mux.hw,
>> +             [CLKID_PWM_A_DIV]               = &s4_pwm_a_div.hw,
>> +             [CLKID_PWM_A]                   = &s4_pwm_a_gate.hw,
>> +             [CLKID_PWM_B_SEL]               = &s4_pwm_b_mux.hw,
>> +             [CLKID_PWM_B_DIV]               = &s4_pwm_b_div.hw,
>> +             [CLKID_PWM_B]                   = &s4_pwm_b_gate.hw,
>> +             [CLKID_PWM_C_SEL]               = &s4_pwm_c_mux.hw,
>> +             [CLKID_PWM_C_DIV]               = &s4_pwm_c_div.hw,
>> +             [CLKID_PWM_C]                   = &s4_pwm_c_gate.hw,
>> +             [CLKID_PWM_D_SEL]               = &s4_pwm_d_mux.hw,
>> +             [CLKID_PWM_D_DIV]               = &s4_pwm_d_div.hw,
>> +             [CLKID_PWM_D]                   = &s4_pwm_d_gate.hw,
>> +             [CLKID_PWM_E_SEL]               = &s4_pwm_e_mux.hw,
>> +             [CLKID_PWM_E_DIV]               = &s4_pwm_e_div.hw,
>> +             [CLKID_PWM_E]                   = &s4_pwm_e_gate.hw,
>> +             [CLKID_PWM_F_SEL]               = &s4_pwm_f_mux.hw,
>> +             [CLKID_PWM_F_DIV]               = &s4_pwm_f_div.hw,
>> +             [CLKID_PWM_F]                   = &s4_pwm_f_gate.hw,
>> +             [CLKID_PWM_G_SEL]               = &s4_pwm_g_mux.hw,
>> +             [CLKID_PWM_G_DIV]               = &s4_pwm_g_div.hw,
>> +             [CLKID_PWM_G]                   = &s4_pwm_g_gate.hw,
>> +             [CLKID_PWM_H_SEL]               = &s4_pwm_h_mux.hw,
>> +             [CLKID_PWM_H_DIV]               = &s4_pwm_h_div.hw,
>> +             [CLKID_PWM_H]                   = &s4_pwm_h_gate.hw,
>> +             [CLKID_PWM_I_SEL]               = &s4_pwm_i_mux.hw,
>> +             [CLKID_PWM_I_DIV]               = &s4_pwm_i_div.hw,
>> +             [CLKID_PWM_I]                   = &s4_pwm_i_gate.hw,
>> +             [CLKID_PWM_J_SEL]               = &s4_pwm_j_mux.hw,
>> +             [CLKID_PWM_J_DIV]               = &s4_pwm_j_div.hw,
>> +             [CLKID_PWM_J]                   = &s4_pwm_j_gate.hw,
>> +             [CLKID_SARADC_SEL]              = &s4_saradc_mux.hw,
>> +             [CLKID_SARADC_DIV]              = &s4_saradc_div.hw,
>> +             [CLKID_SARADC]                  = &s4_saradc_gate.hw,
>> +             [CLKID_GEN_SEL]                 = &s4_gen_clk_sel.hw,
>> +             [CLKID_GEN_DIV]                 = &s4_gen_clk_div.hw,
>> +             [CLKID_GEN]                     = &s4_gen_clk.hw,
>> +             [CLKID_DDR]                     = &s4_ddr.hw,
>> +             [CLKID_DOS]                     = &s4_dos.hw,
>> +             [CLKID_ETHPHY]                  = &s4_ethphy.hw,
>> +             [CLKID_MALI]                    = &s4_mali.hw,
>> +             [CLKID_AOCPU]                   = &s4_aocpu.hw,
>> +             [CLKID_AUCPU]                   = &s4_aucpu.hw,
>> +             [CLKID_CEC]                     = &s4_cec.hw,
>> +             [CLKID_SDEMMC_A]                = &s4_sdemmca.hw,
>> +             [CLKID_SDEMMC_B]                = &s4_sdemmcb.hw,
>> +             [CLKID_NAND]                    = &s4_nand.hw,
>> +             [CLKID_SMARTCARD]               = &s4_smartcard.hw,
>> +             [CLKID_ACODEC]                  = &s4_acodec.hw,
>> +             [CLKID_SPIFC]                   = &s4_spifc.hw,
>> +             [CLKID_MSR]                     = &s4_msr_clk.hw,
>> +             [CLKID_IR_CTRL]                 = &s4_ir_ctrl.hw,
>> +             [CLKID_AUDIO]                   = &s4_audio.hw,
>> +             [CLKID_ETH]                     = &s4_eth.hw,
>> +             [CLKID_UART_A]                  = &s4_uart_a.hw,
>> +             [CLKID_UART_B]                  = &s4_uart_b.hw,
>> +             [CLKID_UART_C]                  = &s4_uart_c.hw,
>> +             [CLKID_UART_D]                  = &s4_uart_d.hw,
>> +             [CLKID_UART_E]                  = &s4_uart_e.hw,
>> +             [CLKID_AIFIFO]                  = &s4_aififo.hw,
>> +             [CLKID_TS_DDR]                  = &s4_ts_ddr.hw,
>> +             [CLKID_TS_PLL]                  = &s4_ts_pll.hw,
>> +             [CLKID_G2D]                     = &s4_g2d.hw,
>> +             [CLKID_SPICC0]                  = &s4_spicc0.hw,
>> +             [CLKID_USB]                     = &s4_usb.hw,
>> +             [CLKID_I2C_M_A]                 = &s4_i2c_m_a.hw,
>> +             [CLKID_I2C_M_B]                 = &s4_i2c_m_b.hw,
>> +             [CLKID_I2C_M_C]                 = &s4_i2c_m_c.hw,
>> +             [CLKID_I2C_M_D]                 = &s4_i2c_m_d.hw,
>> +             [CLKID_I2C_M_E]                 = &s4_i2c_m_e.hw,
>> +             [CLKID_HDMITX_APB]              = &s4_hdmitx_apb.hw,
>> +             [CLKID_I2C_S_A]                 = &s4_i2c_s_a.hw,
>> +             [CLKID_USB1_TO_DDR]             = &s4_usb1_to_ddr.hw,
>> +             [CLKID_HDCP22]                  = &s4_hdcp22.hw,
>> +             [CLKID_MMC_APB]                 = &s4_mmc_apb.hw,
>> +             [CLKID_RSA]                     = &s4_rsa.hw,
>> +             [CLKID_CPU_DEBUG]               = &s4_cpu_debug.hw,
>> +             [CLKID_VPU_INTR]                = &s4_vpu_intr.hw,
>> +             [CLKID_DEMOD]                   = &s4_demod.hw,
>> +             [CLKID_SAR_ADC]                 = &s4_sar_adc.hw,
>> +             [CLKID_GIC]                     = &s4_gic.hw,
>> +             [CLKID_PWM_AB]                  = &s4_pwm_ab.hw,
>> +             [CLKID_PWM_CD]                  = &s4_pwm_cd.hw,
>> +             [CLKID_PWM_EF]                  = &s4_pwm_ef.hw,
>> +             [CLKID_PWM_GH]                  = &s4_pwm_gh.hw,
>> +             [CLKID_PWM_IJ]                  = &s4_pwm_ij.hw,
>> +             [CLKID_HDCP22_ESMCLK_SEL]       = &s4_hdcp22_esmclk_mux.hw,
>> +             [CLKID_HDCP22_ESMCLK_DIV]       = &s4_hdcp22_esmclk_div.hw,
>> +             [CLKID_HDCP22_ESMCLK]           = &s4_hdcp22_esmclk_gate.hw,
>> +             [CLKID_HDCP22_SKPCLK_SEL]       = &s4_hdcp22_skpclk_mux.hw,
>> +             [CLKID_HDCP22_SKPCLK_DIV]       = &s4_hdcp22_skpclk_div.hw,
>> +             [CLKID_HDCP22_SKPCLK]   = &s4_hdcp22_skpclk_gate.hw,
>> +             [NR_CLKS]                       = NULL
>> +     },
>> +     .num = NR_CLKS,
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const s4_periphs_clk_regmaps[] = {
>> +     &s4_rtc_32k_by_oscin_clkin,
>> +     &s4_rtc_32k_by_oscin_div,
>> +     &s4_rtc_32k_by_oscin_sel,
>> +     &s4_rtc_32k_by_oscin,
>> +     &s4_rtc_clk,
>> +     &s4_sysclk_b_sel,
>> +     &s4_sysclk_b_div,
>> +     &s4_sysclk_b,
>> +     &s4_sysclk_a_sel,
>> +     &s4_sysclk_a_div,
>> +     &s4_sysclk_a,
>> +     &s4_sys_clk,
>> +     &s4_ceca_32k_clkin,
>> +     &s4_ceca_32k_div,
>> +     &s4_ceca_32k_sel_pre,
>> +     &s4_ceca_32k_sel,
>> +     &s4_ceca_32k_clkout,
>> +     &s4_cecb_32k_clkin,
>> +     &s4_cecb_32k_div,
>> +     &s4_cecb_32k_sel_pre,
>> +     &s4_cecb_32k_sel,
>> +     &s4_cecb_32k_clkout,
>> +     &s4_sc_clk_mux,
>> +     &s4_sc_clk_div,
>> +     &s4_sc_clk_gate,
>> +     &s4_12_24M_clk_gate,
>> +     &s4_12_24M_clk,
>> +     &s4_vid_pll_div,
>> +     &s4_vid_pll_sel,
>> +     &s4_vid_pll,
>> +     &s4_vclk_sel,
>> +     &s4_vclk2_sel,
>> +     &s4_vclk_input,
>> +     &s4_vclk2_input,
>> +     &s4_vclk_div,
>> +     &s4_vclk2_div,
>> +     &s4_vclk,
>> +     &s4_vclk2,
>> +     &s4_vclk_div1,
>> +     &s4_vclk_div2_en,
>> +     &s4_vclk_div4_en,
>> +     &s4_vclk_div6_en,
>> +     &s4_vclk_div12_en,
>> +     &s4_vclk2_div1,
>> +     &s4_vclk2_div2_en,
>> +     &s4_vclk2_div4_en,
>> +     &s4_vclk2_div6_en,
>> +     &s4_vclk2_div12_en,
>> +     &s4_cts_enci_sel,
>> +     &s4_cts_encp_sel,
>> +     &s4_cts_vdac_sel,
>> +     &s4_hdmi_tx_sel,
>> +     &s4_cts_enci,
>> +     &s4_cts_encp,
>> +     &s4_cts_vdac,
>> +     &s4_hdmi_tx,
>> +     &s4_hdmi_sel,
>> +     &s4_hdmi_div,
>> +     &s4_hdmi,
>> +     &s4_ts_clk_div,
>> +     &s4_ts_clk_gate,
>> +     &s4_mali_0_sel,
>> +     &s4_mali_0_div,
>> +     &s4_mali_0,
>> +     &s4_mali_1_sel,
>> +     &s4_mali_1_div,
>> +     &s4_mali_1,
>> +     &s4_mali_mux,
>> +     &s4_vdec_p0_mux,
>> +     &s4_vdec_p0_div,
>> +     &s4_vdec_p0,
>> +     &s4_vdec_p1_mux,
>> +     &s4_vdec_p1_div,
>> +     &s4_vdec_p1,
>> +     &s4_vdec_mux,
>> +     &s4_hevcf_p0_mux,
>> +     &s4_hevcf_p0_div,
>> +     &s4_hevcf_p0,
>> +     &s4_hevcf_p1_mux,
>> +     &s4_hevcf_p1_div,
>> +     &s4_hevcf_p1,
>> +     &s4_hevcf_mux,
>> +     &s4_vpu_0_sel,
>> +     &s4_vpu_0_div,
>> +     &s4_vpu_0,
>> +     &s4_vpu_1_sel,
>> +     &s4_vpu_1_div,
>> +     &s4_vpu_1,
>> +     &s4_vpu,
>> +     &s4_vpu_clkb_tmp_mux,
>> +     &s4_vpu_clkb_tmp_div,
>> +     &s4_vpu_clkb_tmp,
>> +     &s4_vpu_clkb_div,
>> +     &s4_vpu_clkb,
>> +     &s4_vpu_clkc_p0_mux,
>> +     &s4_vpu_clkc_p0_div,
>> +     &s4_vpu_clkc_p0,
>> +     &s4_vpu_clkc_p1_mux,
>> +     &s4_vpu_clkc_p1_div,
>> +     &s4_vpu_clkc_p1,
>> +     &s4_vpu_clkc_mux,
>> +     &s4_vapb_0_sel,
>> +     &s4_vapb_0_div,
>> +     &s4_vapb_0,
>> +     &s4_vapb_1_sel,
>> +     &s4_vapb_1_div,
>> +     &s4_vapb_1,
>> +     &s4_vapb,
>> +     &s4_ge2d_gate,
>> +     &s4_hdcp22_esmclk_mux,
>> +     &s4_hdcp22_esmclk_div,
>> +     &s4_hdcp22_esmclk_gate,
>> +     &s4_hdcp22_skpclk_mux,
>> +     &s4_hdcp22_skpclk_div,
>> +     &s4_hdcp22_skpclk_gate,
>> +     &s4_vdin_meas_mux,
>> +     &s4_vdin_meas_div,
>> +     &s4_vdin_meas_gate,
>> +     &s4_sd_emmc_c_clk0_sel,
>> +     &s4_sd_emmc_c_clk0_div,
>> +     &s4_sd_emmc_c_clk0,
>> +     &s4_sd_emmc_a_clk0_sel,
>> +     &s4_sd_emmc_a_clk0_div,
>> +     &s4_sd_emmc_a_clk0,
>> +     &s4_sd_emmc_b_clk0_sel,
>> +     &s4_sd_emmc_b_clk0_div,
>> +     &s4_sd_emmc_b_clk0,
>> +     &s4_spicc0_mux,
>> +     &s4_spicc0_div,
>> +     &s4_spicc0_gate,
>> +     &s4_pwm_a_mux,
>> +     &s4_pwm_a_div,
>> +     &s4_pwm_a_gate,
>> +     &s4_pwm_b_mux,
>> +     &s4_pwm_b_div,
>> +     &s4_pwm_b_gate,
>> +     &s4_pwm_c_mux,
>> +     &s4_pwm_c_div,
>> +     &s4_pwm_c_gate,
>> +     &s4_pwm_d_mux,
>> +     &s4_pwm_d_div,
>> +     &s4_pwm_d_gate,
>> +     &s4_pwm_e_mux,
>> +     &s4_pwm_e_div,
>> +     &s4_pwm_e_gate,
>> +     &s4_pwm_f_mux,
>> +     &s4_pwm_f_div,
>> +     &s4_pwm_f_gate,
>> +     &s4_pwm_g_mux,
>> +     &s4_pwm_g_div,
>> +     &s4_pwm_g_gate,
>> +     &s4_pwm_h_mux,
>> +     &s4_pwm_h_div,
>> +     &s4_pwm_h_gate,
>> +     &s4_pwm_i_mux,
>> +     &s4_pwm_i_div,
>> +     &s4_pwm_i_gate,
>> +     &s4_pwm_j_mux,
>> +     &s4_pwm_j_div,
>> +     &s4_pwm_j_gate,
>> +     &s4_saradc_mux,
>> +     &s4_saradc_div,
>> +     &s4_saradc_gate,
>> +     &s4_gen_clk_sel,
>> +     &s4_gen_clk_div,
>> +     &s4_gen_clk,
>> +     &s4_ddr,
>> +     &s4_dos,
>> +     &s4_ethphy,
>> +     &s4_mali,
>> +     &s4_aocpu,
>> +     &s4_aucpu,
>> +     &s4_cec,
>> +     &s4_sdemmca,
>> +     &s4_sdemmcb,
>> +     &s4_nand,
>> +     &s4_smartcard,
>> +     &s4_acodec,
>> +     &s4_spifc,
>> +     &s4_msr_clk,
>> +     &s4_ir_ctrl,
>> +     &s4_audio,
>> +     &s4_eth,
>> +     &s4_uart_a,
>> +     &s4_uart_b,
>> +     &s4_uart_c,
>> +     &s4_uart_d,
>> +     &s4_uart_e,
>> +     &s4_aififo,
>> +     &s4_ts_ddr,
>> +     &s4_ts_pll,
>> +     &s4_g2d,
>> +     &s4_spicc0,
>> +     &s4_usb,
>> +     &s4_i2c_m_a,
>> +     &s4_i2c_m_b,
>> +     &s4_i2c_m_c,
>> +     &s4_i2c_m_d,
>> +     &s4_i2c_m_e,
>> +     &s4_hdmitx_apb,
>> +     &s4_i2c_s_a,
>> +     &s4_usb1_to_ddr,
>> +     &s4_hdcp22,
>> +     &s4_mmc_apb,
>> +     &s4_rsa,
>> +     &s4_cpu_debug,
>> +     &s4_vpu_intr,
>> +     &s4_demod,
>> +     &s4_sar_adc,
>> +     &s4_gic,
>> +     &s4_pwm_ab,
>> +     &s4_pwm_cd,
>> +     &s4_pwm_ef,
>> +     &s4_pwm_gh,
>> +     &s4_pwm_ij,
>> +     &s4_demod_core_clk_mux,
>> +     &s4_demod_core_clk_div,
>> +     &s4_demod_core_clk_gate,
>> +     &s4_adc_extclk_in_mux,
>> +     &s4_adc_extclk_in_div,
>> +     &s4_adc_extclk_in_gate,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +};
>> +
>> +static int meson_s4_periphs_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct regmap *regmap;
>> +     void __iomem *base;
>> +     int ret, i;
>> +
>> +     base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     /* Populate regmap for the regmap backed clocks */
>> +     for (i = 0; i < ARRAY_SIZE(s4_periphs_clk_regmaps); i++)
>> +             s4_periphs_clk_regmaps[i]->map = regmap;
>> +
>> +     for (i = 0; i < s4_periphs_hw_onecell_data.num; i++) {
>> +             /* array might be sparse */
>> +             if (!s4_periphs_hw_onecell_data.hws[i])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, s4_periphs_hw_onecell_data.hws[i]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +                                        &s4_periphs_hw_onecell_data);
>> +}
>> +
>> +static const struct of_device_id clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,s4-peripherals-clkc",
>> +     },
>> +     {}
>> +};
>> +
>> +static struct platform_driver s4_driver = {
>> +     .probe          = meson_s4_periphs_probe,
>> +     .driver         = {
>> +             .name   = "s4-periphs-clkc",
>> +             .of_match_table = clkc_match_table,
>> +     },
>> +};
>> +
>> +module_platform_driver(s4_driver);
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/clk/meson/s4-peripherals.h b/drivers/clk/meson/s4-peripherals.h
>> new file mode 100644
>> index 000000000000..6c719303926b
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-peripherals.h
>> @@ -0,0 +1,217 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2021 Amlogic, inc.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef __MESON_S4_PERIPHERALS_H__
>> +#define __MESON_S4_PERIPHERALS_H__
>> +
>> +/*
>> + * Clock controller register offsets
>> + */
>> +#define CLKCTRL_OSCIN_CTRL                         0x004
>> +#define CLKCTRL_RTC_BY_OSCIN_CTRL0                 0x008
>> +#define CLKCTRL_RTC_BY_OSCIN_CTRL1                 0x00c
>> +#define CLKCTRL_RTC_CTRL                           0x010
>> +#define CLKCTRL_CHECK_CLK_RESULT                   0x014
>> +#define CLKCTRL_MBIST_ATSPEED_CTRL                 0x018
>> +#define CLKCTRL_LOCK_BIT_REG0                      0x020
>> +#define CLKCTRL_LOCK_BIT_REG1                      0x024
>> +#define CLKCTRL_LOCK_BIT_REG2                      0x028
>> +#define CLKCTRL_LOCK_BIT_REG3                      0x02c
>> +#define CLKCTRL_PROT_BIT_REG0                      0x030
>> +#define CLKCTRL_PROT_BIT_REG1                      0x034
>> +#define CLKCTRL_PROT_BIT_REG2                      0x038
>> +#define CLKCTRL_PROT_BIT_REG3                      0x03c
>> +#define CLKCTRL_SYS_CLK_CTRL0                      0x040
>> +#define CLKCTRL_SYS_CLK_EN0_REG0                   0x044
>> +#define CLKCTRL_SYS_CLK_EN0_REG1                   0x048
>> +#define CLKCTRL_SYS_CLK_EN0_REG2                   0x04c
>> +#define CLKCTRL_SYS_CLK_EN0_REG3                   0x050
>> +#define CLKCTRL_SYS_CLK_EN1_REG0                   0x054
>> +#define CLKCTRL_SYS_CLK_EN1_REG1                   0x058
>> +#define CLKCTRL_SYS_CLK_EN1_REG2                   0x05c
>> +#define CLKCTRL_SYS_CLK_EN1_REG3                   0x060
>> +#define CLKCTRL_SYS_CLK_VPU_EN0                    0x064
>> +#define CLKCTRL_SYS_CLK_VPU_EN1                    0x068
>> +#define CLKCTRL_AXI_CLK_CTRL0                      0x06c
>> +#define CLKCTRL_TST_CTRL0                          0x080
>> +#define CLKCTRL_TST_CTRL1                          0x084
>> +#define CLKCTRL_CECA_CTRL0                         0x088
>> +#define CLKCTRL_CECA_CTRL1                         0x08c
>> +#define CLKCTRL_CECB_CTRL0                         0x090
>> +#define CLKCTRL_CECB_CTRL1                         0x094
>> +#define CLKCTRL_SC_CLK_CTRL                        0x098
>> +#define CLKCTRL_RAMA_CLK_CTRL0                     0x0a4
>> +#define CLKCTRL_CLK12_24_CTRL                      0x0a8
>> +#define CLKCTRL_VID_CLK_CTRL                       0x0c0
>> +#define CLKCTRL_VID_CLK_CTRL2                      0x0c4
>> +#define CLKCTRL_VID_CLK_DIV                        0x0c8
>> +#define CLKCTRL_VIID_CLK_DIV                       0x0cc
>> +#define CLKCTRL_VIID_CLK_CTRL                      0x0d0
>> +#define CLKCTRL_HDMI_CLK_CTRL                      0x0e0
>> +#define CLKCTRL_VID_PLL_CLK_DIV                    0x0e4
>> +#define CLKCTRL_VPU_CLK_CTRL                       0x0e8
>> +#define CLKCTRL_VPU_CLKB_CTRL                      0x0ec
>> +#define CLKCTRL_VPU_CLKC_CTRL                      0x0f0
>> +#define CLKCTRL_VID_LOCK_CLK_CTRL                  0x0f4
>> +#define CLKCTRL_VDIN_MEAS_CLK_CTRL                 0x0f8
>> +#define CLKCTRL_VAPBCLK_CTRL                       0x0fc
>> +#define CLKCTRL_HDCP22_CTRL                        0x100
>> +#define CLKCTRL_CDAC_CLK_CTRL                      0x108
>> +#define CLKCTRL_VDEC_CLK_CTRL                      0x140
>> +#define CLKCTRL_VDEC2_CLK_CTRL                     0x144
>> +#define CLKCTRL_VDEC3_CLK_CTRL                     0x148
>> +#define CLKCTRL_VDEC4_CLK_CTRL                     0x14c
>> +#define CLKCTRL_TS_CLK_CTRL                        0x158
>> +#define CLKCTRL_MALI_CLK_CTRL                      0x15c
>> +#define CLKCTRL_ETH_CLK_CTRL                       0x164
>> +#define CLKCTRL_NAND_CLK_CTRL                      0x168
>> +#define CLKCTRL_SD_EMMC_CLK_CTRL                   0x16c
>> +#define CLKCTRL_SPICC_CLK_CTRL                     0x174
>> +#define CLKCTRL_GEN_CLK_CTRL                       0x178
>> +#define CLKCTRL_SAR_CLK_CTRL                       0x17c
>> +#define CLKCTRL_PWM_CLK_AB_CTRL                    0x180
>> +#define CLKCTRL_PWM_CLK_CD_CTRL                    0x184
>> +#define CLKCTRL_PWM_CLK_EF_CTRL                    0x188
>> +#define CLKCTRL_PWM_CLK_GH_CTRL                    0x18c
>> +#define CLKCTRL_PWM_CLK_IJ_CTRL                    0x190
>> +#define CLKCTRL_DEMOD_CLK_CTRL                     0x200
>> +#define CLKCTRL_TIMESTAMP_CTRL                     0x400
>> +#define CLKCTRL_TIMESTAMP_CTRL1                    0x404
>> +#define CLKCTRL_TIMESTAMP_CTRL2                    0x40c
>> +#define CLKCTRL_TIMESTAMP_RD0                      0x410
>> +#define CLKCTRL_TIMESTAMP_RD1                      0x414
>> +#define CLKCTRL_TIMEBASE_CTRL0                     0x418
>> +#define CLKCTRL_TIMEBASE_CTRL1                     0x41c
>> +#define CLKCTRL_EFUSE_CPU_CFG01                    0x480
>> +#define CLKCTRL_EFUSE_CPU_CFG2                     0x484
>> +#define CLKCTRL_EFUSE_ENCP_CFG0                    0x488
>> +#define CLKCTRL_EFUSE_MALI_CFG01                   0x48c
>> +#define CLKCTRL_EFUSE_LOCK                         0x498
>> +
>> +/*
>> + * CLKID index values
>> + *
>> + * These indices are entirely contrived and do not map onto the hardware.
>> + * It has now been decided to expose everything by default in the DT header:
>> + * include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h. Only the clocks ids
>> + * we don't want to expose, such as the internal muxes and dividers of composite
>> + * clocks, will remain defined here.
>> + */
>> +#define CLKID_RTC_32K_CLKIN          0
>> +#define CLKID_RTC_32K_DIV            1
>> +#define CLKID_RTC_32K_SEL            2
>> +#define CLKID_RTC_32K_XATL           3
>> +#define CLKID_SYS_CLK_B_SEL          5
>> +#define CLKID_SYS_CLK_B_DIV          6
>> +#define CLKID_SYS_CLK_A_SEL          8
>> +#define CLKID_SYS_CLK_A_DIV          9
>> +#define CLKID_CECA_32K_CLKIN         12
>> +#define CLKID_CECA_32K_DIV           13
>> +#define CLKID_CECA_32K_SEL_PRE               14
>> +#define CLKID_CECA_32K_SEL           15
>> +#define CLKID_CECB_32K_CLKIN         17
>> +#define CLKID_CECB_32K_DIV           18
>> +#define CLKID_CECB_32K_SEL_PRE               19
>> +#define CLKID_CECB_32K_SEL           20
>> +#define CLKID_SC_CLK_SEL             22
>> +#define CLKID_SC_CLK_DIV             23
>> +#define CLKID_12_24M                 25
>> +#define CLKID_12M_CLK_DIV            26
>> +#define CLKID_VID_PLL_DIV            28
>> +#define CLKID_VID_PLL_SEL            29
>> +#define CLKID_VCLK_SEL                       31
>> +#define CLKID_VCLK2_SEL                      32
>> +#define CLKID_VCLK_INPUT             33
>> +#define CLKID_VCLK2_INPUT            34
>> +#define CLKID_VCLK_DIV                       35
>> +#define CLKID_VCLK2_DIV                      36
>> +#define CLKID_VCLK_DIV2_EN           40
>> +#define CLKID_VCLK_DIV4_EN           41
>> +#define CLKID_VCLK_DIV6_EN           42
>> +#define CLKID_VCLK_DIV12_EN          43
>> +#define CLKID_VCLK2_DIV2_EN          45
>> +#define CLKID_VCLK2_DIV4_EN          46
>> +#define CLKID_VCLK2_DIV6_EN          47
>> +#define CLKID_VCLK2_DIV12_EN         48
>> +#define CLKID_CTS_ENCI_SEL           57
>> +#define CLKID_CTS_ENCP_SEL           58
>> +#define CLKID_CTS_VDAC_SEL           59
>> +#define CLKID_HDMI_TX_SEL            60
>> +#define CLKID_HDMI_TX                        64
>> +#define CLKID_HDMI_SEL                       65
>> +#define CLKID_HDMI_DIV                       66
>> +#define CLKID_TS_CLK_DIV             68
>> +#define CLKID_MALI_0_SEL             70
>> +#define CLKID_MALI_0_DIV             71
>> +#define CLKID_MALI_1_SEL             73
>> +#define CLKID_MALI_1_DIV             74
>> +#define CLKID_VDEC_P0_SEL            77
>> +#define CLKID_VDEC_P0_DIV            78
>> +#define CLKID_VDEC_P1_SEL            80
>> +#define CLKID_VDEC_P1_DIV            81
>> +#define CLKID_HEVCF_P0_SEL           84
>> +#define CLKID_HEVCF_P0_DIV           85
>> +#define CLKID_HEVCF_P1_SEL           87
>> +#define CLKID_HEVCF_P1_DIV           88
>> +#define CLKID_VPU_0_SEL                      91
>> +#define CLKID_VPU_0_DIV                      92
>> +#define CLKID_VPU_1_SEL                      94
>> +#define CLKID_VPU_1_DIV                      95
>> +#define CLKID_VPU_CLKB_TMP_SEL               98
>> +#define CLKID_VPU_CLKB_TMP_DIV               99
>> +#define CLKID_VPU_CLKB_DIV           101
>> +#define CLKID_VPU_CLKC_P0_SEL                103
>> +#define CLKID_VPU_CLKC_P0_DIV                104
>> +#define CLKID_VPU_CLKC_P1_SEL                106
>> +#define CLKID_VPU_CLKC_P1_DIV                107
>> +#define CLKID_VAPB_0_SEL             110
>> +#define CLKID_VAPB_0_DIV             111
>> +#define CLKID_VAPB_1_SEL             113
>> +#define CLKID_VAPB_1_DIV             114
>> +#define CLKID_VDIN_MEAS_SEL          118
>> +#define CLKID_VDIN_MEAS_DIV          119
>> +#define CLKID_SD_EMMC_C_CLK_SEL              121
>> +#define CLKID_SD_EMMC_C_CLK_DIV              122
>> +#define CLKID_SD_EMMC_A_CLK_SEL              124
>> +#define CLKID_SD_EMMC_A_CLK_DIV              125
>> +#define CLKID_SD_EMMC_B_CLK_SEL              127
>> +#define CLKID_SD_EMMC_B_CLK_DIV              128
>> +#define CLKID_SPICC0_SEL             130
>> +#define CLKID_SPICC0_DIV             131
>> +#define CLKID_PWM_A_SEL                      133
>> +#define CLKID_PWM_A_DIV                      134
>> +#define CLKID_PWM_B_SEL                      136
>> +#define CLKID_PWM_B_DIV                      137
>> +#define CLKID_PWM_C_SEL                      139
>> +#define CLKID_PWM_C_DIV                      140
>> +#define CLKID_PWM_D_SEL                      142
>> +#define CLKID_PWM_D_DIV                      143
>> +#define CLKID_PWM_E_SEL                      145
>> +#define CLKID_PWM_E_DIV                      146
>> +#define CLKID_PWM_F_SEL                      148
>> +#define CLKID_PWM_F_DIV                      149
>> +#define CLKID_PWM_G_SEL                      151
>> +#define CLKID_PWM_G_DIV                      152
>> +#define CLKID_PWM_H_SEL                      154
>> +#define CLKID_PWM_H_DIV                      155
>> +#define CLKID_PWM_I_SEL                      157
>> +#define CLKID_PWM_I_DIV                      158
>> +#define CLKID_PWM_J_SEL                      160
>> +#define CLKID_PWM_J_DIV                      161
>> +#define CLKID_SARADC_SEL             163
>> +#define CLKID_SARADC_DIV             164
>> +#define CLKID_GEN_SEL                        166
>> +#define CLKID_GEN_DIV                        167
>> +#define CLKID_HDCP22_ESMCLK_SEL              219
>> +#define CLKID_HDCP22_ESMCLK_DIV              220
>> +#define CLKID_HDCP22_SKPCLK_SEL              222
>> +#define CLKID_HDCP22_SKPCLK_DIV              223
>> +
>> +#define NR_CLKS                              225
>> +/* include the CLKIDs that have been made part of the DT binding */
>> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>> +
>> +#endif /* __MESON_S4_PERIPHERALS_H__ */
> 
