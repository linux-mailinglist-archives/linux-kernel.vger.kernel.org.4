Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E39A6F02B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbjD0Ijd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbjD0Ijb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:39:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417C74EDF;
        Thu, 27 Apr 2023 01:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7JWcH7WmRjMtQNeTM7CCZrLyHknU/h/hye/8lWaYLwgVFurHFchC9Hs5nBNGuAL0DMtEJCeRLVww6Ol/7b08kdf2tiqN6A8nQVM4x6tfetjTopJn2y5VfVmwUZrVpQ5H9ukB4Drptmnq01otNk3XHRm5bcRGviWKfeO4vnMCSoLZhbGVK/VhfzCLhWvGfYxFQeAIU2byG+ZRXbNFEcdjvPWwZNqP0UpRe0Ijiuc9mm+PUzeNv6Ue/8qLj8T01OednvP7iVG4aYD9/Hq/J1K50DF1JadEDa2z9EOtq5OeYNYyQn4VTrOGPrKvdRu4xCYN3a0GJ3m1vQEAqekoeIGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5eiKD/PrdQcGp9Jv2wnWRIPVUOBsUPNdJhaEDz2Zk0=;
 b=bjG40u+geXrjUG7IencBuVGCnvFd9Z1Rq4RvSaqOkMrFvX4+7p5tqpspLnq3lMbMFrU+pnhV2Z7uFVzBlXM+A4dm5x8Jvj3NTZ8BZGbePUe+G0JF8/bVNFga74R1Umliwa1SgCEzoD8rmMlR5jpNikCB491JE5twGrPE9PaUODQ0xBvKKjE4fUV5zTJzzBuWo9dsXIW7kxH73LH+q6oOH4c2Kc8hg36g6PYW8LvkaKMBI7AEWjcjoDcSfIyG9vMfkLRDPXEjDon5XxKBOlURlOQynQb3J/ibjXKgBJKXd6RiPTz6x7EAgtmmnfwhrAKyC56NfVm5LWVRHrCTPW80NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5eiKD/PrdQcGp9Jv2wnWRIPVUOBsUPNdJhaEDz2Zk0=;
 b=bRGJITu+nYiBzPVHK4zsFHlmBMZmVEVcQMC7YfGZ9RZwqSO5Ftbg04WMoE3m5B4+6KBqD6bMPA6evWuCW0dT9LdRl9M77KJskaHz/KhRSJXcIFLtv5NCgBp1gcSjaTLQQCqTkgyw+sLtx7ahknY4xGWopT8OthuEQdhAYiIiEVkZ2cX/nccVxXSvPAKmftqj6b97aM/P0+jTNg2/rhj02/G4Vb7bSkROrYFKf2+k5tvKGk6A87bzdtPSUQqu2Jdy/hQtNg4epdtzGLbvaFH0G1AIAdTULU0es6YDygbMPQ3f5b0i1BL9gvnPCNBg823BLi+pA+5aTajZhsLnOibk6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEZPR03MB6644.apcprd03.prod.outlook.com (2603:1096:101:7c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Thu, 27 Apr 2023 08:38:36 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6319.033; Thu, 27 Apr 2023
 08:38:36 +0000
Message-ID: <3be758e3-aa41-0003-fd1a-324b8dd4267a@amlogic.com>
Date:   Thu, 27 Apr 2023 16:38:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V7 3/4] clk: meson: S4: add support for Amlogic S4 SoC PLL
 clock driver
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
 <20230417065005.24967-4-yu.tu@amlogic.com>
 <20230426111358.xh3gbhlvxj46ggi5@CAB-WSD-L081021>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20230426111358.xh3gbhlvxj46ggi5@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SEZPR03MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d84446-5f80-49c1-7912-08db46faca0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPO2NTg/2q3dffASnPKfZ6D5kQztoIRcuo3fscu6hS0IHPkEV+XH/EFckBfeDkVoofe1hU27zoR9lrrepf+Hp0NvOMOo9rpRZpBoKLrG1oNXHbRzl8/eF3SmJ8FEALTJWz/MGqvfQdYOAOkOLJrq8NZMEa4Iu6qO+uAjVU/GOHbK3P+EIU0mnXJPWPdXijBnCMwUloKhlADYHUME9x8LXLax/r5znh44e18WuRgXFXDqcleEGv4UYK9fpKywh5KtXgvUwx3Bt8ZBhPMiOOFcuEMhuUvzezX3Uuiqtcp/ipT3mgT438szRrk3oj6zPvN3R+NL9MAfJuj2NtR38LPuDGAtkCbnpXbkaVd2xzlC+8HTiPYNlp1QlxdR7JoOu167MKulXdh6tNICU2YWo+jMG/LgvL0mZnxveHnZXdKSM8Dh7ktB/ahXWAYPRJFRDgj5m5OB2+GwZbRdg3gglXFQEGJTkWZ5On6a+SlxvE+AkE3NXdJwVS33xo6bbAEVh+yoHYmLzzroB3Q9pkz9H+COHo5M6HtqWRr46sTLXkTDvBzdFFt0+ThZ1eo+bFjXaMhevFMV+Ckx9x0ql2I2D22+b2UqH8QDsgktgNeqdH2QzX1XDFtKbFZG7KwzYjNWa/I6zGLmBOZYcT/70j7bEaC42A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(376002)(346002)(136003)(396003)(451199021)(66556008)(66476007)(6916009)(4326008)(478600001)(54906003)(41300700001)(8676002)(8936002)(7416002)(5660300002)(316002)(66946007)(38100700002)(2616005)(186003)(83380400001)(6666004)(53546011)(6486002)(966005)(107886003)(6512007)(6506007)(26005)(31696002)(86362001)(44832011)(2906002)(30864003)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVhJcGxJSlRjSzV5ZlY4OUhJaE0rQVA3YlYya3k2bUsvS1BKN3dwS0Fzcmg5?=
 =?utf-8?B?WnpiUkZvSy95K0NxdGQwdTVVajBFbnhDMkh6VXo0SkNITnBRME1nT2REY1RZ?=
 =?utf-8?B?UFQ2TFM0U1VxZW0yU2xpOWNRY094NmhmekJzSW9PcUQvQXNZenNRcUd0SldQ?=
 =?utf-8?B?Y1BVRGk1WVc0MU5DK1I4ZTkxaXBWNUQ4aFYrbEM2K2FhcS81QjlmRURKcldL?=
 =?utf-8?B?Nm5uVUE4QW02aktUdnlqM3RzeHJQMzlnd1JSSFBFT3hWOFNMamJrdnptR2Zs?=
 =?utf-8?B?RlgwSURtcjdTVmNRRU0rMlRObzZQUVB0Vy9oRXFVTXhxcFVMdjlzUlJTS0Zl?=
 =?utf-8?B?NjdjNVFYZXRmeWZyOURhaWcraGxGamhaQXF0RlRQczBlMGkyVnIxNFFxSkdB?=
 =?utf-8?B?R0hYdlFqNkd4aFhldHVIVVplV2ZWMkhQREN3RXpreENDeW4zQjJyeFEwTXI4?=
 =?utf-8?B?QTJBMzlTV2lndEV1aEs0bFlnZitIUG1VeS9IVmp6RW5BTU53dE1tdzg3bE1x?=
 =?utf-8?B?dnBDaXdwaG1XSjBQV0U3eXNNY3pCWTBhLzdxMXAveFd6NGRjOWpKa2RWdC9r?=
 =?utf-8?B?WnFSczFuUFI1akYzUXROYmJlRTRMaVRJOVhMcWhuZU1BUkl2VUZGczFDSnVH?=
 =?utf-8?B?SXpsYzlRSWRPNDd6NVdsNFd5NDM2S3dhVERpaVVzMUxic0N4Mk9kWmtMMXcx?=
 =?utf-8?B?UjZnREdWRVR2Z2VXSEk3Y2dFNFFTRjlDNGNaL3BoR01FekJtZXNqUFZvVzVq?=
 =?utf-8?B?WUwzT3JXSFRBWjRrY1A4Uk9wL05LazBNWktxbllHUkE4SDdjYk5CM0JMTkNR?=
 =?utf-8?B?TlYzdkpLV2laeENYaGtjZWw3b0pPSlR4WXZuUWhadUVwaU1hZkxHalMrR3Az?=
 =?utf-8?B?S0c3dVZUZHBqK2ZGT1hscHVQRXZjOUQrSXlmZGdNSGV5YlozVFQ0SXFoZ3Fp?=
 =?utf-8?B?MzU4Q2xiQTkzK1V6cm10cjNDcGk2VGg3SWhNL3RPYkdvSDlQSExWZDU0NURI?=
 =?utf-8?B?NmNoZWNmV2luZUF3WEx6aUlIVVd0bkpoaGlpY2dtQUZNcUM3aW9kUWh3NzQ0?=
 =?utf-8?B?Y096dFVuY1h5TjF1TzlrUlpzdFNpSWN0NFhuSHlNUHFORmZCbHAzK2NhVmR1?=
 =?utf-8?B?QklHWHJjelNVaTh6NTR3UWJ2TU9PdXlSYUdqVmxwbzB2eUNPYVhtWllqbVhZ?=
 =?utf-8?B?T3JteXRVL3dILzJMWmtmS2NCdjRWRzEvNHpWb1BrL2JwQTNZdGhOajdXQSsr?=
 =?utf-8?B?YVorSndRditDb3ROUVZqbmhxekd6RXltQjg1dUpGWStVUDdoV000VDVYOUgx?=
 =?utf-8?B?bnRqcHZsVUhkS2NkUDZOMjM1MlJZKzBMTkJWOURCUzJMa0cxTUV2bEp1eHh1?=
 =?utf-8?B?eE1nZE5HMUJtNmJ5aERXU2hWTitiUnpTZE9oWm0zdnkyOE5sZmpEQkZlRGNu?=
 =?utf-8?B?eEM5bnN2ZzF3cU9WMlIyb2xwVk5sRzlNOUxnZlJ4V1JpUkhEUEFLNGJ0NnB3?=
 =?utf-8?B?OXlDK1lsbXZzWWhoOSs2Y0RSK1UzVVVNTE5WZ1ZOaU1EaUkwek0reVVSVXdQ?=
 =?utf-8?B?bldTMldobjNMOWJQUTA0TzkydmpUZkxBRkRNOHliaDRnS2pyL0NVdllDZ2x5?=
 =?utf-8?B?N1d4TjhGMTA4dFNoUVcvMFNVc0hVeW4vdzZtSDVETjFldllMclAxTERtTVli?=
 =?utf-8?B?TlFzUzdaRG1lUFFJU3ZPSWl3Nm12bnBzZGNVNkc0QnR1bVV4Ym1tbTdpTTVw?=
 =?utf-8?B?amxILzAzcXQ3bWlFcVlzU3ZoM0FvWUNlcmg5N0RSUlFFaStaZG5jNlhScVVD?=
 =?utf-8?B?SUQ3YUpaR3d0TWdFWUJCdHNRMWRBdkIzNnRJM2prY2RGR2dFRFRjV0NITXli?=
 =?utf-8?B?b2I0dVlHV3pOc1JGamt3RzdvYXlQNjc0eVdVUkxmOEpWcE1wRUY0TENheDhY?=
 =?utf-8?B?TjBmakZXcUpaSWwyV2ZrYjgwRkJQR1pJaElPT0t0REZOcm9EbGpvUU9KMGJx?=
 =?utf-8?B?cC9haGluWERMU2NjVWJXb3l1V1VtaHlpUDB1Z0d2MUVBd1ZhcnhCQVlmK0Vq?=
 =?utf-8?B?allrUlJJU3dlcDBwaWh3bk4zay83elVMY2hxTi90a0pBUlpGTW5La2pQYWJE?=
 =?utf-8?Q?1oVz2H9/9HH9F4IVY2TaDKl8Z?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d84446-5f80-49c1-7912-08db46faca0a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:38:35.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVWI2pWRLFmQMl6/hvehJurmJrojzevbOudlTfxOiUE7/2z2gNH9+eGDm+o5lPDNrfilBIyjCyK8VXAM3ewRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6644
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/26 19:13, Dmitry Rokosov wrote:
> [Some people who received this message don't often get email from ddrokosov@sberdevices.ru. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> On Mon, Apr 17, 2023 at 02:50:04PM +0800, Yu Tu wrote:
>> Add the S4 PLL clock controller driver in the s4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig  |  13 +
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/s4-pll.c | 902 +++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/s4-pll.h |  87 ++++
>>   4 files changed, 1003 insertions(+)
>>   create mode 100644 drivers/clk/meson/s4-pll.c
>>   create mode 100644 drivers/clk/meson/s4-pll.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index fc002c155bc3..a663c90a3f3b 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -115,4 +115,17 @@ config COMMON_CLK_G12A
>>        help
>>          Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>>          devices, aka g12a. Say Y if you want peripherals to work.
>> +
>> +config COMMON_CLK_S4_PLL
>> +     tristate "S4 SoC PLL clock controllers support"
>> +     depends on ARM64
>> +     default y
>> +     select COMMON_CLK_MESON_MPLL
>> +     select COMMON_CLK_MESON_PLL
>> +     select COMMON_CLK_MESON_REGMAP
>> +     help
>> +       Support for the pll clock controller on Amlogic S805X2 and S905Y4 devices,
>> +       aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>> +       Say Y if you want the board to work, because plls are the parent of most
>> +       peripherals.
>>   endmenu
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 6eca2a406ee3..376f49cc13f1 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>> +obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
>> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
>> new file mode 100644
>> index 000000000000..5a34d304adf7
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-pll.c
>> @@ -0,0 +1,902 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Amlogic Meson-S4 PLL Clock Controller Driver
>> + *
>> + * Copyright (c) 2021 Amlogic, inc.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-mpll.h"
>> +#include "clk-pll.h"
>> +#include "clk-regmap.h"
>> +#include "s4-pll.h"
>> +
>> +static DEFINE_SPINLOCK(meson_clk_lock);
>> +
>> +static struct clk_regmap s4_fixed_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data){
>> +             .en = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 17,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fixed_pll_dco",
>> +             /*
>> +              * This clock is a fixed value (4GHz) that is initialized by ROMcode.
>> +              * This clock won't ever change at runtime.
>> +              * The chip design determines that this clock cannot be changed after
>> +              * initialization. To prevent system crash caused by changing
>> +              * fixed related register in kernel phase. This register is not
>> +              * writable in the kernel phase.
>> +              * So we use ro_ops.
>> +              */
>> +             .ops = &meson_clk_pll_ro_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_fixed_pll = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 2,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fixed_pll",
>> +             /*
>> +              * This clock is a fixed value (2GHz) that is initialized by ROMcode.
>> +              * This clock won't ever change at runtime.
>> +              * The chip design determines that this clock cannot be changed after
>> +              * initialization. To prevent system crash caused by changing
>> +              * fixed related register in kernel phase. This register is not
>> +              * writable in the kernel phase.
>> +              * So we use ro_ops.
>> +              */
>> +             .ops = &clk_regmap_divider_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fixed_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             /*
>> +              * This clock won't ever change at runtime so
>> +              * CLK_SET_RATE_PARENT is not required
>> +              */
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_fclk_div2_div = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div2_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_fclk_div2 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div2",
>> +             /*
>> +              * This clock is a fixed value (1GHz) that is initialized by ROMcode.
>> +              * This clock won't ever ungate at runtime.
>> +              * The chip design determines that this clock cannot be changed after
>> +              * initialization. To prevent system crash caused by changing
>> +              * fixed related register in kernel phase. This register is not
>> +              * writable in the kernel phase.
>> +              * So we use ro_ops.
>> +              */
> 
> The above comment has been copied and pasted many times.
> Please collapse it and refer to it from specific locations.

Just three times. The goal is to make it clear to the viewer.

> 
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fclk_div2_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_fclk_div3_div = {
>> +     .mult = 1,
>> +     .div = 3,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div3_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_fclk_div3 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>> +             .bit_idx = 20,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div3",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fclk_div3_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_fclk_div4_div = {
>> +     .mult = 1,
>> +     .div = 4,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div4_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_fclk_div4 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>> +             .bit_idx = 21,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div4",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fclk_div4_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_fclk_div5_div = {
>> +     .mult = 1,
>> +     .div = 5,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div5_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_fclk_div5 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>> +             .bit_idx = 22,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div5",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fclk_div5_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_fclk_div7_div = {
>> +     .mult = 1,
>> +     .div = 7,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div7_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_fclk_div7 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>> +             .bit_idx = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div7",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fclk_div7_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_fclk_div2p5_div = {
>> +     .mult = 2,
>> +     .div = 5,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div2p5_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_fclk_div2p5 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>> +             .bit_idx = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div2p5",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fclk_div2p5_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct pll_mult_range s4_gp0_pll_mult_range = {
>> +     .min = 125,
>> +     .max = 250,
>> +};
>> +
>> +/*
>> + * Internal gp0 pll emulation configuration parameters
>> + */
>> +static const struct reg_sequence s4_gp0_init_regs[] = {
>> +     { .reg = ANACTRL_GP0PLL_CTRL1,  .def = 0x00000000 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL2,  .def = 0x00000000 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL3,  .def = 0x48681c00 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x39272000 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL6,  .def = 0x56540000 }
> 
> Please ensure that the initialization sequence values do not overlap
> with the below pll_data bits that are managed during runtime.
> 

That's right. There is a timing requirement for PLL initialization.

>> +};
>> +
>> +static struct clk_regmap s4_gp0_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data){
>> +             .en = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 17,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &s4_gp0_pll_mult_range,
>> +             .init_regs = s4_gp0_init_regs,
>> +             .init_count = ARRAY_SIZE(s4_gp0_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gp0_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_gp0_pll = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 3,
>> +             .flags = (CLK_DIVIDER_POWER_OF_TWO |
>> +                       CLK_DIVIDER_ROUND_CLOSEST),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gp0_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_gp0_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * Internal hifi pll emulation configuration parameters
>> + */
>> +static const struct reg_sequence s4_hifi_init_regs[] = {
>> +     { .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x00010e56 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a285c00 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x39272000 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x56540000 }
>> +};
> 
> Please ensure that the initialization sequence values do not overlap
> with the below pll_data bits that are managed during runtime.

[...]

> 
>> +
>> +static struct clk_regmap s4_hifi_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data){
>> +             .en = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 17,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &s4_gp0_pll_mult_range,
>> +             .init_regs = s4_hifi_init_regs,
>> +             .init_count = ARRAY_SIZE(s4_hifi_init_regs),
>> +             .flags = CLK_MESON_PLL_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hifi_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hifi_pll = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 2,
>> +             .flags = (CLK_DIVIDER_POWER_OF_TWO |
>> +                       CLK_DIVIDER_ROUND_CLOSEST),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hifi_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hifi_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
> 
> [...]
> 
>> +static int meson_s4_pll_probe(struct platform_device *pdev)
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
>> +     ret = regmap_multi_reg_write(regmap, s4_init_regs, ARRAY_SIZE(s4_init_regs));
>> +     if (ret) {
>> +             dev_err(dev, "Failed to init registers\n");
> 
> dev_err_probe()

Clock drivers are the foundation on which other drivers run. There is no 
need to EPROBE_DEFER. Also use EPROBE_DEFER as long as it is better to 
use when getting the resource.

> 
>> +             return ret;
>> +     }
>> +
>> +     /* Populate regmap for the regmap backed clocks */
>> +     for (i = 0; i < ARRAY_SIZE(s4_pll_clk_regmaps); i++)
>> +             s4_pll_clk_regmaps[i]->map = regmap;
>> +
>> +     for (i = 0; i < s4_pll_hw_onecell_data.num; i++) {
>> +             /* array might be sparse */
>> +             if (!s4_pll_hw_onecell_data.hws[i])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, s4_pll_hw_onecell_data.hws[i]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
> 
> dev_err_probe()

[...]

> 
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +                                        &s4_pll_hw_onecell_data);
>> +}
>> +
>> +static const struct of_device_id clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,s4-pll-clkc",
>> +     },
>> +     {}
>> +};
>> +
>> +static struct platform_driver s4_driver = {
>> +     .probe          = meson_s4_pll_probe,
>> +     .driver         = {
>> +             .name   = "s4-pll-clkc",
>> +             .of_match_table = clkc_match_table,
>> +     },
>> +};
>> +
>> +module_platform_driver(s4_driver);
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/clk/meson/s4-pll.h b/drivers/clk/meson/s4-pll.h
>> new file mode 100644
>> index 000000000000..1fb5bececf5f
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-pll.h
>> @@ -0,0 +1,87 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2021 Amlogic, inc.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef __MESON_S4_PLL_H__
>> +#define __MESON_S4_PLL_H__
>> +
>> +/* ANA_CTRL - Registers */
>> +
>> +#define ANACTRL_FIXPLL_CTRL0                       0x040
>> +#define ANACTRL_FIXPLL_CTRL1                       0x044
>> +#define ANACTRL_FIXPLL_CTRL2                       0x048
>> +#define ANACTRL_FIXPLL_CTRL3                       0x04c
>> +#define ANACTRL_FIXPLL_CTRL4                       0x050
>> +#define ANACTRL_FIXPLL_CTRL5                       0x054
>> +#define ANACTRL_FIXPLL_CTRL6                       0x058
>> +#define ANACTRL_FIXPLL_STS                         0x05c
>> +#define ANACTRL_GP0PLL_CTRL0                       0x080
>> +#define ANACTRL_GP0PLL_CTRL1                       0x084
>> +#define ANACTRL_GP0PLL_CTRL2                       0x088
>> +#define ANACTRL_GP0PLL_CTRL3                       0x08c
>> +#define ANACTRL_GP0PLL_CTRL4                       0x090
>> +#define ANACTRL_GP0PLL_CTRL5                       0x094
>> +#define ANACTRL_GP0PLL_CTRL6                       0x098
>> +#define ANACTRL_GP0PLL_STS                         0x09c
>> +#define ANACTRL_HIFIPLL_CTRL0                      0x100
>> +#define ANACTRL_HIFIPLL_CTRL1                      0x104
>> +#define ANACTRL_HIFIPLL_CTRL2                      0x108
>> +#define ANACTRL_HIFIPLL_CTRL3                      0x10c
>> +#define ANACTRL_HIFIPLL_CTRL4                      0x110
>> +#define ANACTRL_HIFIPLL_CTRL5                      0x114
>> +#define ANACTRL_HIFIPLL_CTRL6                      0x118
>> +#define ANACTRL_HIFIPLL_STS                        0x11c
>> +#define ANACTRL_MPLL_CTRL0                         0x180
>> +#define ANACTRL_MPLL_CTRL1                         0x184
>> +#define ANACTRL_MPLL_CTRL2                         0x188
>> +#define ANACTRL_MPLL_CTRL3                         0x18c
>> +#define ANACTRL_MPLL_CTRL4                         0x190
>> +#define ANACTRL_MPLL_CTRL5                         0x194
>> +#define ANACTRL_MPLL_CTRL6                         0x198
>> +#define ANACTRL_MPLL_CTRL7                         0x19c
>> +#define ANACTRL_MPLL_CTRL8                         0x1a0
>> +#define ANACTRL_MPLL_STS                           0x1a4
>> +#define ANACTRL_HDMIPLL_CTRL0                      0x1c0
>> +#define ANACTRL_HDMIPLL_CTRL1                      0x1c4
>> +#define ANACTRL_HDMIPLL_CTRL2                      0x1c8
>> +#define ANACTRL_HDMIPLL_CTRL3                      0x1cc
>> +#define ANACTRL_HDMIPLL_CTRL4                      0x1d0
>> +#define ANACTRL_HDMIPLL_CTRL5                      0x1d4
>> +#define ANACTRL_HDMIPLL_CTRL6                      0x1d8
>> +#define ANACTRL_HDMIPLL_STS                        0x1dc
>> +#define ANACTRL_HDMIPLL_VLOCK                      0x1e4
>> +
>> +/*
>> + * CLKID index values
>> + *
>> + * These indices are entirely contrived and do not map onto the hardware.
>> + * It has now been decided to expose everything by default in the DT header:
>> + * include/dt-bindings/clock/axg-clkc.h. Only the clocks ids we don't want
> 
> axg-clkc.h?

I will correct.

> 
>> + * to expose, such as the internal muxes and dividers of composite clocks,
>> + * will remain defined here.
>> + */
>> +#define CLKID_FIXED_PLL_DCO          0
>> +#define CLKID_FCLK_DIV2_DIV          2
>> +#define CLKID_FCLK_DIV3_DIV          4
>> +#define CLKID_FCLK_DIV4_DIV          6
>> +#define CLKID_FCLK_DIV5_DIV          8
>> +#define CLKID_FCLK_DIV7_DIV          10
>> +#define CLKID_FCLK_DIV2P5_DIV                12
>> +#define CLKID_GP0_PLL_DCO            14
>> +#define CLKID_HIFI_PLL_DCO           16
>> +#define CLKID_HDMI_PLL_DCO           18
>> +#define CLKID_HDMI_PLL_OD            19
>> +#define CLKID_MPLL_50M_DIV           21
>> +#define CLKID_MPLL_PREDIV            23
>> +#define CLKID_MPLL0_DIV                      24
>> +#define CLKID_MPLL1_DIV                      26
>> +#define CLKID_MPLL2_DIV                      28
>> +#define CLKID_MPLL3_DIV                      30
>> +
>> +#define NR_PLL_CLKS                  32
>> +/* include the CLKIDs that have been made part of the DT binding */
>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>> +
>> +#endif /* __MESON_S4_PLL_H__ */
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
