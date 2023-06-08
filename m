Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0457727500
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjFHCa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFHCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:30:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CD11BF0;
        Wed,  7 Jun 2023 19:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OykUKo7Ir4k88jg7N+zVFq4IP2o7hkS/xDzrGcf9+8Cfd1N7xDYKblJ5Ja7gmfdpzLm9O09pFeHB0MYNj76glPaT2AuAZmFmabdXaszEQieIUqiweXv1F4eK4nhMJ8+ilZ3+6YLrgrnH+x32XpJp2POl5drwZTAAxm+cM6G4bE9d9Jiw+i5d/gK81dvcN/j94rCTgjKw6i+Ksk2JCK4DBtgtjGtUglz+2MLg811zhrrXcBwwH/c3xqFsZxq7bvrAHp1A/CERHR9fmkoB/WbRVr1Gz8ujO7WH3slbjnNf3V97JvBKN2fq86mtJu5/BZMJ89KcBwi8eF5C7ut0B+Pn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Amgi3moF3EGvV7wwHEH9Gii10v99GQJJW2tlMGV3QM=;
 b=kcqbH4HfG7K/o7WxvblX3lM/JPOlvcmPpBr0pJDCCK6vXo/C8vMuBKw0TcJnro/aKkWSErmsqMO2KzKwqbjy0EES0zuk0dUoNgAsLW5us3KFnaIy4TInrlECaDj/u8pUnyYASKRqrj+yGYiTCYZRWqI707ux6guC68ol1cBuaq75FcppS674Xjjopq8t5I/UEjA5j5OKax4vqo55mKfPgFtshWj8jmstKquofouykbsdoSrr0xKLDS57RoydaNG2fzNSOfu6yTaynXTb/0tzmpPqH2RRk5EN+FVpyf6JC0MvOIAEQ4wJDkjGRWBeNNMNnrhxo0zcxH53SdnFW+kjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Amgi3moF3EGvV7wwHEH9Gii10v99GQJJW2tlMGV3QM=;
 b=GmY3LqVu6iyud2C3iOkvQMzo6obel8kdcPy/R8u9xDrc9mIT58VHRgmaCzzaLxn8r3bkl6T1oohoJ00DaXGbfRFNQxuThzctmmhtU1VG7S8kSX2rNfNsxCUJ5oC2OUq3BoPpiJl1DQCuBz47nioThFWVjpbEAlfLYAEWkyMU1x+U8PAtXKIUINv9PYldQjrXYyDHT4g1FCeadJWYbqy4PLYIcA3PGhkITEaYd080ShA9HXafHDz1xgQP11QGDm/L3/1uUcbLgTIt8wx4toyGSmHrkOrZfFsZlxGJhpjNLpMaS/PeXTVRox87tI+DmFac0bAs+/VlCUJxVsAGdp7wZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 TY0PR03MB6257.apcprd03.prod.outlook.com (2603:1096:400:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 02:29:33 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 02:29:32 +0000
Message-ID: <3a3f91d7-312d-9347-aa65-022e0f31d5dd@amlogic.com>
Date:   Thu, 8 Jun 2023 10:29:02 +0800
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
 <1j1qio4pzq.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1j1qio4pzq.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|TY0PR03MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: d256ef87-5bd5-4d4f-0c9a-08db67c830ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TbKnNpkNT4zlvsgTFCjGpnAIO0ZKehjev+kA5eA0WLCEMj61JrWFKyyvlUMhepkiZ1Um9uLzGWRg0UmNQYp01JuWJI24UIRomD1eJjEwB51Ebupp42nC9+HrbW9j7YQ8K0ZPvJ+SKMbGG7u15pQKGIq3se+hw8L7dA75TuFo+ECJVuzHiV6NS+2nvtxUWFXTBYekQHMaqM1a++tP7R97bZ82DBCP0o2Vj5cp5AoL0mGHh9kERvKWlMLR40WKaNK1Bbd8ErugaKuQqIpSIjeuuVwE1a0dscTmbRYv7kRt1B9Yjp4hQSRIdjg5x0oYp/Vrfp44CLJya8wOdz4NBxy/m2w4bwhT3KdkYcNRzJzzyzim4XzOIafp95nxu7RGqaxS54ONfTwDFk15cM41FBVkwR9eQo6qg0Z67PtF1F3QU1+DNjEcCRAnfgSQvXq7+ineDo3hkUiUcVNneA/mUzt2XsjZnLzo93wTSdhbaNDx+0x3yGl+XrTxQtFy7sRDcXux8azd2ROO7SUi9XPg4n6Eseb1UfNKZ6woHVyvlq/a6mLYiJc8dgx65GYgonQvAWoNSCnHMxSnZTFx+w39typozXntysHaIIURVGSXYkBvvJALCBuIkl0XFJ9UGa2Z5TjxmZU6YACDUV6IIdw5c1i5p4m1os46dA+pee380zWL7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39850400004)(346002)(451199021)(107886003)(26005)(6506007)(6512007)(53546011)(2616005)(83380400001)(186003)(31686004)(6666004)(30864003)(921005)(2906002)(66946007)(66556008)(66476007)(6486002)(38100700002)(7416002)(8936002)(86362001)(8676002)(44832011)(5660300002)(36756003)(110136005)(478600001)(31696002)(41300700001)(316002)(4326008)(45980500001)(43740500002)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3F3aEdOVGxzNU5VU0R3Z2tRTUZnMmk2M29NNjk5aUZuckxRc1NlcXR1U0tU?=
 =?utf-8?B?M1RQbU9VWVNZb1pEdUxudjRZd05wTmtSbVFIZnJaQzhkc1lzcmxmRUY0OXEy?=
 =?utf-8?B?N1VibVJqUUU3QnVIZkgwMlB4a0Rtck9WblF6Y1l3T2loeDlibkwrQTNBUGhG?=
 =?utf-8?B?MHUwVVVMWVF6TURFUWovbHJVS3ZoZXVVTzJ2WVpSU3FxVG15TkIrZWFrcks0?=
 =?utf-8?B?T0l1bDBWQUcwdkJ1Njd2NllGNi9DS2FxaEVxdjlBK2ZacnIxUGxqR2Mramc1?=
 =?utf-8?B?cEk3cWlrWit1K0llWTErK0Y1bjk3WWZsd25YTVUvdHJwd25hWkJWb2pCNzFh?=
 =?utf-8?B?KzdqRk1FSi9WNFM3TmVPSWZ3SU5Mam52cEtsMnpINkU4ODlNOURrVHhyK2tL?=
 =?utf-8?B?QWpML2hvUW11MlJwVlZ6WXRTQk9mREFkOXBqRmw1bGJBU0lRbGx0NWkzWkhE?=
 =?utf-8?B?QXVUUVpXMEFJZ05lS0Jpb01zNUFCcS9wMjdWTTFrVWRDVmNQQkRqZnlGbHBS?=
 =?utf-8?B?bVpaWi9wSS95Vm43NEh4S2xtOG5xOHV1UVlaVkFRckhJUjQySytpU2xqYUcr?=
 =?utf-8?B?NGtHSkI0akIxS29oM004UmJoYXZHMVNwaGh5QklYTllFUzZlT2V1N1BqWS8y?=
 =?utf-8?B?a2RyWXRJaGVKVnNkd2xkWFBIWFZiZHNYZGVJVGxiS0lTekxSejRqWkJzdjlC?=
 =?utf-8?B?YW5MSjZTYUI2NWg3bVpSWXpvUnNZblhwenRnY05Jckp6KzdWc1V5c1lDSmRC?=
 =?utf-8?B?RlFGWksyMUxhV3d3ajBWMXhPKy9scXRzR1BKejZoYWlUa1lseE1VZ3VYNC9j?=
 =?utf-8?B?Wi84REVGdzlzZ1JkWEk4MzlTVDA1TjcyWXRPWm8xNWc5ZDhzU3VKR1M2a0gz?=
 =?utf-8?B?YzAzMCtQNkxqY09XK29mQ01Ib3g2aEZ0QjVyTjROYUFwVXdNWkxlbGoySENN?=
 =?utf-8?B?SjNuSkI3MkEwVW9KVGdRcWVCbWRaU0FDMGNPcFllU2tENHQyRDlsWnViTThG?=
 =?utf-8?B?azd5blZZVmVVeURaVFRtbHc3SXNFTW5UMEg1eWhPaVRiRStZdC9WNXc0dHBj?=
 =?utf-8?B?am01eS9vb3RTdEczUUFhTUZRQk9DTy94SG51ZHFjZXJMR1lLVldqcSsreDVn?=
 =?utf-8?B?dXZJbUh6Vms0c091TmtNYUtjWUcybXRtQ2dCZ1lxUGZ1R3hsMVZ2MGJzVUMz?=
 =?utf-8?B?N2lVaDh5QytqUThNNGxQZUREeTJscFNFNkNYelR3SkZXZ3MzRVFNZGJtTnd3?=
 =?utf-8?B?UkZpdkxzVC80bG8yTy85Qm54bjZiSlhMdFZmRHM4dldiRWxHQm14Yms3VWtn?=
 =?utf-8?B?Zk1YVXhnaU5yOHZmTzJkcUFEeklMUytKQWpoNWs3WE1VY2hqQ0xFejRpSzI5?=
 =?utf-8?B?bjhnb3l2NnZXVThKNi9XOXFWN3pidWllam9weU1zb1Jnd3BiVkVkc293bjJ1?=
 =?utf-8?B?amxVRUtPVHB3UFppSkdEWHkyanhrbldiSjFpQVN3YWlYanE2bHZhbTluS1B4?=
 =?utf-8?B?WHI5SHhYaWdSMUdJRWxNTGNDZUIzN3Y5cm1QOUx2bVVlWUhXcnV6blcwRXdn?=
 =?utf-8?B?NFA4R0hZbVFmWDBTcVdmUUV6R3EvVmxWRWFsUytMUTkwckFqUEJNTCtpQm1F?=
 =?utf-8?B?NUxpN0pqLzdEL1ZvNzhwNjNoU2tDdEN6U3V2dFo5dnRwYlJTdUlWc3Z3WTBh?=
 =?utf-8?B?Yy9nUnFpV3B1V1dINFpoSkpOTHN2UUlmekpXbUZLaEQrU3Fva0dnMUlOcFV4?=
 =?utf-8?B?bmhCTlJXN1IwQWRVbmxUY0Z2WFZXY2tZbjJqdDRKQ2U0Rk1VSWw1NWpIdFho?=
 =?utf-8?B?cTZKdzV4NGVVU0pNeEdwL0FUSEpoeEttb2lzajYxZk02WWgzZ29jeDJ3a2dP?=
 =?utf-8?B?bi84ekh3cUFBbGRDdTAzNFloZzJhRkJTR0NSaUJIRE9WSnFweWF4QmF1RXov?=
 =?utf-8?B?TTg0YmZMZkh1TXl5eGV6alFKT2VBcDlaV0tXdWMwRURXWUlrODlSVFZSUzZM?=
 =?utf-8?B?bDlmV0gvSysvV3hhSXBFU2tmamRWa3pFRUFLUVNhOVYxcm9ZQ0tZdEErNGxm?=
 =?utf-8?B?NE03aE1rWXp2aStsQ3lQOXNiV3VreS9QbmxncmUyMFF3cEFIclhTdm9ZMGRk?=
 =?utf-8?Q?Ua7eb7B0cYRUCbb+xMdr/AWUb?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d256ef87-5bd5-4d4f-0c9a-08db67c830ed
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 02:29:32.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uwaJbbghTxxkrB27DJlS/RzjexueXkSxkamJ6CgjdZyQkI+wo2jftGpHNxDz4C9t82EQF229m9p8mdq1+z3EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6257
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/6 22:34, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 17 May 2023 at 15:02, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Add the S4 PLL clock controller driver in the s4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig  |  13 +
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/s4-pll.c | 907 +++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/s4-pll.h |  87 ++++
>>   4 files changed, 1008 insertions(+)
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
> 
> I'm confused, what are the AQ222 and AQ229 ? are those SoC or boards
> like your reference designs ?
> 
> If those are boards, it should not be mentionned here

Okay. I will reomove those boards name in next version.

> 
> Also, what about the S905X4 ? is it another SoC family ?

Yes. You're right.

> 
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
>> index 000000000000..c70a33586bcd
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-pll.c
>> @@ -0,0 +1,907 @@
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
>> +              * For more information, please refer to s4_fixed_pll_dco.
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
>> +              * For more information, please refer to s4_fixed_pll_dco.
>> +              */
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
>> +             /*
>> +              * For more information, please refer to s4_fixed_pll_dco.
>> +              */
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
>> +             /*
>> +              * For more information, please refer to s4_fixed_pll_dco.
>> +              */
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
>> +             /*
>> +              * For more information, please refer to s4_fixed_pll_dco.
>> +              */
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
>> +             /*
>> +              * For more information, please refer to s4_fixed_pll_dco.
>> +              */
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
>> +             /*
>> +              * For more information, please refer to s4_fixed_pll_dco.
>> +              */
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
>> +static struct clk_regmap s4_hdmi_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data){
>> +             .en = {
>> +                     .reg_off = ANACTRL_HDMIPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_HDMIPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_HDMIPLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_HDMIPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 17,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_HDMIPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_HDMIPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &s4_gp0_pll_mult_range,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_pll_od = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_HDMIPLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 4,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_pll_od",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdmi_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_pll = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_HDMIPLL_CTRL0,
>> +             .shift = 20,
>> +             .width = 2,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdmi_pll_od.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_mpll_50m_div = {
>> +     .mult = 1,
>> +     .div = 80,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll_50m_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fixed_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mpll_50m = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL3,
>> +             .mask = 0x1,
>> +             .shift = 5,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll_50m",
>> +             .ops = &clk_regmap_mux_ro_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", },
>> +                     { .hw = &s4_mpll_50m_div.hw },
>> +             },
>> +             .num_parents = 2,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_mpll_prediv = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll_prediv",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_fixed_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence s4_mpll0_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL2, .def = 0x40000033 }
>> +};
>> +
>> +static struct clk_regmap s4_mpll0_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .lock = &meson_clk_lock,
>> +             .init_regs = s4_mpll0_init_regs,
>> +             .init_count = ARRAY_SIZE(s4_mpll0_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll0_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mpll0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL1,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_mpll0_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence s4_mpll1_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL4,    .def = 0x40000033 }
>> +};
>> +
>> +static struct clk_regmap s4_mpll1_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .lock = &meson_clk_lock,
>> +             .init_regs = s4_mpll1_init_regs,
>> +             .init_count = ARRAY_SIZE(s4_mpll1_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll1_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mpll1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL3,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_mpll1_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence s4_mpll2_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL6, .def = 0x40000033 }
>> +};
>> +
>> +static struct clk_regmap s4_mpll2_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .lock = &meson_clk_lock,
>> +             .init_regs = s4_mpll2_init_regs,
>> +             .init_count = ARRAY_SIZE(s4_mpll2_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll2_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mpll2 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL5,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll2",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_mpll2_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence s4_mpll3_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL8, .def = 0x40000033 }
>> +};
>> +
>> +static struct clk_regmap s4_mpll3_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .lock = &meson_clk_lock,
>> +             .init_regs = s4_mpll3_init_regs,
>> +             .init_count = ARRAY_SIZE(s4_mpll3_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll3_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mpll3 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL7,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll3",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_mpll3_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* Array of all clocks provided by this provider */
>> +static struct clk_hw_onecell_data s4_pll_hw_onecell_data = {
>> +     .hws = {
>> +             [CLKID_FIXED_PLL_DCO]           = &s4_fixed_pll_dco.hw,
>> +             [CLKID_FIXED_PLL]               = &s4_fixed_pll.hw,
>> +             [CLKID_FCLK_DIV2_DIV]           = &s4_fclk_div2_div.hw,
>> +             [CLKID_FCLK_DIV2]               = &s4_fclk_div2.hw,
>> +             [CLKID_FCLK_DIV3_DIV]           = &s4_fclk_div3_div.hw,
>> +             [CLKID_FCLK_DIV3]               = &s4_fclk_div3.hw,
>> +             [CLKID_FCLK_DIV4_DIV]           = &s4_fclk_div4_div.hw,
>> +             [CLKID_FCLK_DIV4]               = &s4_fclk_div4.hw,
>> +             [CLKID_FCLK_DIV5_DIV]           = &s4_fclk_div5_div.hw,
>> +             [CLKID_FCLK_DIV5]               = &s4_fclk_div5.hw,
>> +             [CLKID_FCLK_DIV7_DIV]           = &s4_fclk_div7_div.hw,
>> +             [CLKID_FCLK_DIV7]               = &s4_fclk_div7.hw,
>> +             [CLKID_FCLK_DIV2P5_DIV]         = &s4_fclk_div2p5_div.hw,
>> +             [CLKID_FCLK_DIV2P5]             = &s4_fclk_div2p5.hw,
>> +             [CLKID_GP0_PLL_DCO]             = &s4_gp0_pll_dco.hw,
>> +             [CLKID_GP0_PLL]                 = &s4_gp0_pll.hw,
>> +             [CLKID_HIFI_PLL_DCO]            = &s4_hifi_pll_dco.hw,
>> +             [CLKID_HIFI_PLL]                = &s4_hifi_pll.hw,
>> +             [CLKID_HDMI_PLL_DCO]            = &s4_hdmi_pll_dco.hw,
>> +             [CLKID_HDMI_PLL_OD]             = &s4_hdmi_pll_od.hw,
>> +             [CLKID_HDMI_PLL]                = &s4_hdmi_pll.hw,
>> +             [CLKID_MPLL_50M_DIV]            = &s4_mpll_50m_div.hw,
>> +             [CLKID_MPLL_50M]                = &s4_mpll_50m.hw,
>> +             [CLKID_MPLL_PREDIV]             = &s4_mpll_prediv.hw,
>> +             [CLKID_MPLL0_DIV]               = &s4_mpll0_div.hw,
>> +             [CLKID_MPLL0]                   = &s4_mpll0.hw,
>> +             [CLKID_MPLL1_DIV]               = &s4_mpll1_div.hw,
>> +             [CLKID_MPLL1]                   = &s4_mpll1.hw,
>> +             [CLKID_MPLL2_DIV]               = &s4_mpll2_div.hw,
>> +             [CLKID_MPLL2]                   = &s4_mpll2.hw,
>> +             [CLKID_MPLL3_DIV]               = &s4_mpll3_div.hw,
>> +             [CLKID_MPLL3]                   = &s4_mpll3.hw,
>> +             [NR_PLL_CLKS]                   = NULL
>> +     },
>> +     .num = NR_PLL_CLKS,
>> +};
>> +
>> +static struct clk_regmap *const s4_pll_clk_regmaps[] = {
>> +     &s4_fixed_pll_dco,
>> +     &s4_fixed_pll,
>> +     &s4_fclk_div2,
>> +     &s4_fclk_div3,
>> +     &s4_fclk_div4,
>> +     &s4_fclk_div5,
>> +     &s4_fclk_div7,
>> +     &s4_fclk_div2p5,
>> +     &s4_gp0_pll_dco,
>> +     &s4_gp0_pll,
>> +     &s4_hifi_pll_dco,
>> +     &s4_hifi_pll,
>> +     &s4_hdmi_pll_dco,
>> +     &s4_hdmi_pll_od,
>> +     &s4_hdmi_pll,
>> +     &s4_mpll_50m,
>> +     &s4_mpll0_div,
>> +     &s4_mpll0,
>> +     &s4_mpll1_div,
>> +     &s4_mpll1,
>> +     &s4_mpll2_div,
>> +     &s4_mpll2,
>> +     &s4_mpll3_div,
>> +     &s4_mpll3,
>> +};
>> +
>> +static const struct reg_sequence s4_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x00000543 },
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +};
>> +
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
>> index 000000000000..021d9f8b2b30
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
>> + * include/dt-bindings/clock/amlogic,s4-pll-clkc.h. Only the clocks ids we don't
>> + * want to expose, such as the internal muxes and dividers of composite clocks,
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
> 
