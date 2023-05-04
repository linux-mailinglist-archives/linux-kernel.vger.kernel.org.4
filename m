Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556AC6F6830
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjEDJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEDJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:20:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1552E4686;
        Thu,  4 May 2023 02:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCuZ6vy0pn3gi3/+gRTpuNXy0otigKl/Ufu5sOIuXkD57s2CNVNDS85O1/Yrbk0m1Beh3BRlBg/RoX9uRcgghPAKumCRVP4z6TvsBdOXHzo9ssbFsha6KTvhFI9hX/vT0qHsCqBho8LjDEVaGOmlFKAe4EQWIm4QUE7sBOzxxEN4veNUP9L/UqK3+qQMwP5MPEmeCq489u97lm9D3UFhIOwRatvMl+Od0PnaerFuVWV6imFIM6VZLSf5cA1o8OuFd5u3fvR5dTj2s6Q3TfV+aebH4N7ODIEwLnt/fQDGp0AfgAykLIWq8YsLo2nH4f1joMwBzF5RGNlQJiHUqbwMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfYisgNODNJoHRXclsZV3ENBfvKVHAOYuKdoGbmPhNE=;
 b=nYMizQst9g+cfxRqUXp7OC0N0XS0InKxnvLOYGj5s3ar3BzRJbyiJyUbcIUGsneUFNNteOUd4M8tnKV4Zzt42uBZk5aO0wqiHuqnpvfl7Amm1hImx6xI6ay87jbRFnbjUVgIFKAUEXZ/e7MzMUgQR4EE7eCcDqBPbs9GDXrTX6IO3IYpelIs94Y4jVx28yo4wCXLFEkes2CyP32cHAt7SFz5c6QXKj2SqJcwnZwngNNp5EoRdFxfgbwuFI1Dq7G6UAY985zTkUPrkNyO0R0vkq6KgfjXamraxIyN4YSBs2AahV3OOwucsEjytG4IuEXJ8iE1SE6KLxCPfS6/HuJpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfYisgNODNJoHRXclsZV3ENBfvKVHAOYuKdoGbmPhNE=;
 b=ov8rEbBp8syEL+4/zDpau50THlew8vAIvw+EkjFMbEQ5Lpev78jv1/Ws3mMI2RPzsLZJ5FF2lDfE28f2HK5VlPK0MfACsL0KEoYbZT9w54IR4V2JonOczlAbALBoyImOhepEI2A19ucyRJJET0G7x5VFv1nBPKgbpfQB/IdTKgsG9XDn1mNlHlil3re+vH6o8GEwMSRc4A9++FG9+YC4efDOIVHBl71htxNTNLG0DXI+pJH7LprkP0gPQ4TwHg2CHzO3k7EdHKbSVEqjSRlToJb3408lCrLehEZsOE8Ut5X/d3oxwMPJxTzBeWhk27etxH2wsXt8Vq4l/D3A5EqBNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEZPR03MB6959.apcprd03.prod.outlook.com (2603:1096:101:9e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.36; Thu, 4 May 2023 09:19:57 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 09:19:57 +0000
Message-ID: <e8a42623-b0e1-728d-58a0-35f6a89eb179@amlogic.com>
Date:   Thu, 4 May 2023 17:19:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
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
 <3be758e3-aa41-0003-fd1a-324b8dd4267a@amlogic.com>
 <20230427091141.q3fky7ywnu4lsddk@CAB-WSD-L081021>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20230427091141.q3fky7ywnu4lsddk@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SEZPR03MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: de291d32-c2ae-4f0d-ec3c-08db4c80b9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjdTXtNtukLGOXbC0IQMWx7IRNm7pk4d88SapbwczNTWlMsLtSjT7bPPLc8c7rTkJR+cojaQwv3u8O+MYuOhKCZGv6zQgVTjXFl62dwyReNKPQo8BTDS/VzuIQHb0iDrBXJqsiPQMMRU1vkcZRj8Q6BWNdRglHzAuSwdmWGNtnXSUZcCDIh+QBhjk9i6aijgwUlswpGXYWu56nBFPCW95iQpWvjZDuvF14N0tE9TMRjfWvhgiaLEuVOjvG7omNS05VopnipFe7bfk99RsXc5kd8C5NR7fWH8OE0xz8UJApiL/Ts2xjmdv0pH1rTbSGGLr73QdcbXtBbn/nGhxfK3QyV+aH0j328rDXx3TvDkWWIUut0mvK16uSChOBwuqjMhi88DvIGjSUuDgfgS5Zfnmwb3kkH3M+widevQ6mmjH2mUPPmk57W/NpFk8tO67s4O8wzh6N7cUiR/Ro8e9wT1DDuK+bIX+8IRsw0+GNs1Uaqv3ikATvdI+peLMDa2bh+ZJZsIcYMdgUEdKXBES6Qh7JNHs8X22+Dwynlv8zSEZooB9rDCNl9LvpxTELCyYWGNfkvpLKAkTEC6ihtbZy7EAshIwbJX3vhrnlpd69G7iYrbWZudD01Oea6jaRQ5D4Ozjbhfhj2fFlLbiHSjsCjfeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39850400004)(396003)(366004)(346002)(451199021)(7416002)(66946007)(6666004)(4326008)(478600001)(66476007)(66556008)(6916009)(5660300002)(966005)(44832011)(8936002)(8676002)(30864003)(6506007)(6512007)(26005)(2906002)(53546011)(31686004)(316002)(6486002)(41300700001)(107886003)(54906003)(2616005)(83380400001)(186003)(86362001)(31696002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEVEK1ltZFpKeGVMZnhlQW5aYlRFdTZYWjVtdHVHc0JQVzAvNjBCU1FmamtM?=
 =?utf-8?B?dWlwc2tKcW5tY1kxcC9UaUwxeVEzUEd4UTRLTFNHeE9QNTdYeGlLV01CSUNE?=
 =?utf-8?B?TUdhK2lPdTJXSUxsSnYvQlZtcE5qbHFvR3ZNdDdsSm5peXZQbkpFTWxuUnpj?=
 =?utf-8?B?aDZJblBEd2NiL1o5WlRGdGw0WjJYNUF6V2NVeW9UMkF2STF0cDFmd1lBdlVa?=
 =?utf-8?B?OThXZjJEUmdQZ0ZNRCtNd3ZXYmJlSE5XTTlpeGhUNXRHclNrQ2lMQU13ZXZC?=
 =?utf-8?B?M3B1bFZVQWRiU1JWRG0xNmV1akFRZUJ6dU9IdEtQNmdLa3lDbHM5N3pkVTZo?=
 =?utf-8?B?MUszNEcrYlNER09TaUErTkQweEIrMERVOFRvdEJQQ1hZZHlKZHdwSWhjYXFG?=
 =?utf-8?B?V1hVWk5SeEs3TnM2aFhSTkVtWnJLMWsveUdFUWZ1ZlpwWjVqUTltRFJzbStD?=
 =?utf-8?B?bml6NkZvUE0rMFZ1eGZEQ0YzQncvT2g1WUYvZC9ORnB2Uk5GSDZYa21jUXFT?=
 =?utf-8?B?RFU2bXRBSkFENDhxWTVkdUFxMCtpRWZtdGExbDVFejQzanNxUStLdmNraHJ4?=
 =?utf-8?B?ZWl1U3ZZcjNDd3I2amZvOFVPT0FDOTZCMWhEdmdVaUpONFdUTmpjYW9NWDNC?=
 =?utf-8?B?V3ZPbXJSR3grTm1ZVVExNDZYYkQ3b0ZoRFBqMnQzSEJ4azZZRE55QVhBM3pa?=
 =?utf-8?B?LytLWVBlWnFRTTlIYWp3d0Uxck9NZWx0WW8vd2tTc1IzN3NIL1AxalZLU0gy?=
 =?utf-8?B?OGluQ2Y0OUxOVHFlQ09ubFN0NEpFNkJMU2w5SFk5alZMWGR0ZHlPZmxHR0JY?=
 =?utf-8?B?WW81SG9aVHMyMlFkSEZ5aUR2TkV0QU8wMDdlWlYyMFhlQkp4MVZEWWRlYVJD?=
 =?utf-8?B?M0ZqREVqMjRZT0tUL3dFcks2cXNZelJnWTZqa3dKc1lySFUzRGVRVTJTTWlh?=
 =?utf-8?B?SE12cDlkQlFTR0JacDFBMDJFNUVrOHlnUlExUjZzcGNPenBNKzd3bzFmNlhn?=
 =?utf-8?B?eXhFNU0zaWxpYmR6RHQzNWkxQVdTdXJ4VElrUklTVk5LWU52V1E2YlB3NFkr?=
 =?utf-8?B?UGd3S2s3dDkxZGVLNjkxeTlzTG9zWjI3Q01lU0JLb2YybWlJODhwOVpQbG5q?=
 =?utf-8?B?VjhRS0pGNTlQZXJzUEgvWlRaV2xXZEZCNXZ0QVgzbVlBTk1WWG4wb3lFZUhV?=
 =?utf-8?B?V1Q1Tnhlamh5T08vQjVCMFNoTEhiV2l3VUtWaEh4QTl2NjgySjFSTTQ4K1Nm?=
 =?utf-8?B?eDk4VWRvMHlHOXovR2xUek1xU0JjbXpRQVZ1MnZtMG01dTJ6cCtGVTQwTnFt?=
 =?utf-8?B?TUFwS0tybjlMVTZneHBPaFp3M2NaQVArRldSMVlPNWtqaDY3M3VFL1d6YU9k?=
 =?utf-8?B?ZHJ6VFAxc3Azb1huZDhMWFF3dHJvNFlSTkRPMS9XbFF2ME8xVytEelh0eEg5?=
 =?utf-8?B?SGo5dTR4NFVrWHVRMkUwT2lsWjRwU0JXbHRpSmhqSHd2cWM4TXFPcnZXWnZ2?=
 =?utf-8?B?MnoyZG5OUFVKVjA5NUhKL1hBMldlMkxRMDkxWm5xK3dacENiSmw5Z2xVQU9H?=
 =?utf-8?B?d29kOThqVmRLMDNtZ1VWZGI4ZXpaUlhKTWtYTXhKOHVveDIxTnJ0UHlnL0M4?=
 =?utf-8?B?OE4wenptMUZUS2JEd1kxN3ZncXhEdGkrNkpqTW9mUjZNTityaDJYamZOYU9B?=
 =?utf-8?B?VHVpN1JvTFAwSFd4bW41ZnBlQ2pNcmNXZ1diME5HWWtLZFNjVzhxTklkR0Vy?=
 =?utf-8?B?aVpnbTVMK2VCWmE1T29IOGFDLzJxc1IvZnJvZkNiU29NSVhXUUFLUkRUSU4y?=
 =?utf-8?B?WS9Sb1I1Ky92bzQwdk1PaktSQ1B2bmp6ODRlQUtPcHhmSVE1b1M2Q3JZbEcw?=
 =?utf-8?B?OUJISDk4ak5haW5nUU9naTRVcVJoQkZXOXdOY0lrbzJZNTVEYktUdHhUQlRP?=
 =?utf-8?B?TEV0QjA3ZmIzaWhVNFV4THBvczRYUVFydnovWTIvVVg0cHhkaGJMRkR6Nmkv?=
 =?utf-8?B?dk9MYWYxbXF1ZHVkU2o3QkVQaXMxUTZma28wbXBnbWk5dkZpNDBaNkNxdFZL?=
 =?utf-8?B?cDFQWmZMMVhSVlRXNEJnTDZ5emhJbWNUKzgrRUhMSmF5SzY4WVZGeFdkRXVJ?=
 =?utf-8?Q?oPFosfrlxSXyuSq+K0B8hUJ33?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de291d32-c2ae-4f0d-ec3c-08db4c80b9c5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 09:19:56.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoCYkgngZOqSIUgw183sDdTvABAZUJueS/0F7gAZj97alshVWZE9pMbIS/Rjo9b2wP0GZG1ESvOse8a5nP2Rug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6959
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/27 17:11, Dmitry Rokosov wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, Apr 27, 2023 at 04:38:20PM +0800, Yu Tu wrote:
>>
>>
>> On 2023/4/26 19:13, Dmitry Rokosov wrote:
>>> [Some people who received this message don't often get email from ddrokosov@sberdevices.ru. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Mon, Apr 17, 2023 at 02:50:04PM +0800, Yu Tu wrote:
>>>> Add the S4 PLL clock controller driver in the s4 SoC family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    drivers/clk/meson/Kconfig  |  13 +
>>>>    drivers/clk/meson/Makefile |   1 +
>>>>    drivers/clk/meson/s4-pll.c | 902 +++++++++++++++++++++++++++++++++++++
>>>>    drivers/clk/meson/s4-pll.h |  87 ++++
>>>>    4 files changed, 1003 insertions(+)
>>>>    create mode 100644 drivers/clk/meson/s4-pll.c
>>>>    create mode 100644 drivers/clk/meson/s4-pll.h
>>>>
>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>> index fc002c155bc3..a663c90a3f3b 100644
>>>> --- a/drivers/clk/meson/Kconfig
>>>> +++ b/drivers/clk/meson/Kconfig
>>>> @@ -115,4 +115,17 @@ config COMMON_CLK_G12A
>>>>         help
>>>>           Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>>>>           devices, aka g12a. Say Y if you want peripherals to work.
>>>> +
>>>> +config COMMON_CLK_S4_PLL
>>>> +     tristate "S4 SoC PLL clock controllers support"
>>>> +     depends on ARM64
>>>> +     default y
>>>> +     select COMMON_CLK_MESON_MPLL
>>>> +     select COMMON_CLK_MESON_PLL
>>>> +     select COMMON_CLK_MESON_REGMAP
>>>> +     help
>>>> +       Support for the pll clock controller on Amlogic S805X2 and S905Y4 devices,
>>>> +       aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>>> +       Say Y if you want the board to work, because plls are the parent of most
>>>> +       peripherals.
>>>>    endmenu
>>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>>> index 6eca2a406ee3..376f49cc13f1 100644
>>>> --- a/drivers/clk/meson/Makefile
>>>> +++ b/drivers/clk/meson/Makefile
>>>> @@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>>>    obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>>>    obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>>>    obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>>> +obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
>>>> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
>>>> new file mode 100644
>>>> index 000000000000..5a34d304adf7
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/s4-pll.c
>>>> @@ -0,0 +1,902 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Amlogic Meson-S4 PLL Clock Controller Driver
>>>> + *
>>>> + * Copyright (c) 2021 Amlogic, inc.
>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>> + */
>>>> +
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +#include "clk-mpll.h"
>>>> +#include "clk-pll.h"
>>>> +#include "clk-regmap.h"
>>>> +#include "s4-pll.h"
>>>> +
>>>> +static DEFINE_SPINLOCK(meson_clk_lock);
>>>> +
>>>> +static struct clk_regmap s4_fixed_pll_dco = {
>>>> +     .data = &(struct meson_clk_pll_data){
>>>> +             .en = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .m = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 8,
>>>> +             },
>>>> +             .n = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 10,
>>>> +                     .width   = 5,
>>>> +             },
>>>> +             .frac = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL1,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 17,
>>>> +             },
>>>> +             .l = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 31,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .rst = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 29,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fixed_pll_dco",
>>>> +             /*
>>>> +              * This clock is a fixed value (4GHz) that is initialized by ROMcode.
>>>> +              * This clock won't ever change at runtime.
>>>> +              * The chip design determines that this clock cannot be changed after
>>>> +              * initialization. To prevent system crash caused by changing
>>>> +              * fixed related register in kernel phase. This register is not
>>>> +              * writable in the kernel phase.
>>>> +              * So we use ro_ops.
>>>> +              */
>>>> +             .ops = &meson_clk_pll_ro_ops,
>>>> +             .parent_data = (const struct clk_parent_data []) {
>>>> +                     { .fw_name = "xtal", }
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_fixed_pll = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL0,
>>>> +             .shift = 16,
>>>> +             .width = 2,
>>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fixed_pll",
>>>> +             /*
>>>> +              * This clock is a fixed value (2GHz) that is initialized by ROMcode.
>>>> +              * This clock won't ever change at runtime.
>>>> +              * The chip design determines that this clock cannot be changed after
>>>> +              * initialization. To prevent system crash caused by changing
>>>> +              * fixed related register in kernel phase. This register is not
>>>> +              * writable in the kernel phase.
>>>> +              * So we use ro_ops.
>>>> +              */
>>>> +             .ops = &clk_regmap_divider_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fixed_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             /*
>>>> +              * This clock won't ever change at runtime so
>>>> +              * CLK_SET_RATE_PARENT is not required
>>>> +              */
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor s4_fclk_div2_div = {
>>>> +     .mult = 1,
>>>> +     .div = 2,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div2_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_fclk_div2 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>>>> +             .bit_idx = 24,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div2",
>>>> +             /*
>>>> +              * This clock is a fixed value (1GHz) that is initialized by ROMcode.
>>>> +              * This clock won't ever ungate at runtime.
>>>> +              * The chip design determines that this clock cannot be changed after
>>>> +              * initialization. To prevent system crash caused by changing
>>>> +              * fixed related register in kernel phase. This register is not
>>>> +              * writable in the kernel phase.
>>>> +              * So we use ro_ops.
>>>> +              */
>>>
>>> The above comment has been copied and pasted many times.
>>> Please collapse it and refer to it from specific locations.
>>
>> Just three times. The goal is to make it clear to the viewer.
>>
> 
> I think, reference to one time mentioned comment is clear for viewer too.
> Also Jerome has pointed to this problem for the A1 driver as well:
> 
> https://lore.kernel.org/all/1jtty6o5so.fsf@starbuckisacylon.baylibre.com/

I will refer to your way in A1.

> 
>>>
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fclk_div2_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor s4_fclk_div3_div = {
>>>> +     .mult = 1,
>>>> +     .div = 3,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div3_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_fclk_div3 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>>>> +             .bit_idx = 20,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div3",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fclk_div3_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor s4_fclk_div4_div = {
>>>> +     .mult = 1,
>>>> +     .div = 4,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div4_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_fclk_div4 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>>>> +             .bit_idx = 21,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div4",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fclk_div4_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor s4_fclk_div5_div = {
>>>> +     .mult = 1,
>>>> +     .div = 5,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div5_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_fclk_div5 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>>>> +             .bit_idx = 22,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div5",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fclk_div5_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor s4_fclk_div7_div = {
>>>> +     .mult = 1,
>>>> +     .div = 7,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div7_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_fclk_div7 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>>>> +             .bit_idx = 23,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div7",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fclk_div7_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor s4_fclk_div2p5_div = {
>>>> +     .mult = 2,
>>>> +     .div = 5,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div2p5_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fixed_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_fclk_div2p5 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL1,
>>>> +             .bit_idx = 25,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div2p5",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_fclk_div2p5_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static const struct pll_mult_range s4_gp0_pll_mult_range = {
>>>> +     .min = 125,
>>>> +     .max = 250,
>>>> +};
>>>> +
>>>> +/*
>>>> + * Internal gp0 pll emulation configuration parameters
>>>> + */
>>>> +static const struct reg_sequence s4_gp0_init_regs[] = {
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL1,  .def = 0x00000000 },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL2,  .def = 0x00000000 },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL3,  .def = 0x48681c00 },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x39272000 },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL6,  .def = 0x56540000 }
>>>
>>> Please ensure that the initialization sequence values do not overlap
>>> with the below pll_data bits that are managed during runtime.
>>>
>>
>> That's right. There is a timing requirement for PLL initialization.
>>
> 
> Okay, we have already discussed this in another patch series for A1 clock
> drivers, and some overlaps were found.
> I just want to help you find potential problems.
> 
> You can find the discussion here:
> 
> https://lore.kernel.org/linux-amlogic/1jr0u2azfi.fsf@starbuckisacylon.baylibre.com/ >
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_gp0_pll_dco = {
>>>> +     .data = &(struct meson_clk_pll_data){
>>>> +             .en = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .m = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 8,
>>>> +             },
>>>> +             .n = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 10,
>>>> +                     .width   = 5,
>>>> +             },
>>>> +             .frac = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL1,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 17,
>>>> +             },
>>>> +             .l = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 31,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .rst = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 29,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .range = &s4_gp0_pll_mult_range,
>>>> +             .init_regs = s4_gp0_init_regs,
>>>> +             .init_count = ARRAY_SIZE(s4_gp0_init_regs),
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "gp0_pll_dco",
>>>> +             .ops = &meson_clk_pll_ops,
>>>> +             .parent_data = (const struct clk_parent_data []) {
>>>> +                     { .fw_name = "xtal", }
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_gp0_pll = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>>>> +             .shift = 16,
>>>> +             .width = 3,
>>>> +             .flags = (CLK_DIVIDER_POWER_OF_TWO |
>>>> +                       CLK_DIVIDER_ROUND_CLOSEST),
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "gp0_pll",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_gp0_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +/*
>>>> + * Internal hifi pll emulation configuration parameters
>>>> + */
>>>> +static const struct reg_sequence s4_hifi_init_regs[] = {
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x00010e56 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a285c00 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x39272000 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x56540000 }
>>>> +};
>>>
>>> Please ensure that the initialization sequence values do not overlap
>>> with the below pll_data bits that are managed during runtime.
>>
>> [...]
>>
>>>
>>>> +
>>>> +static struct clk_regmap s4_hifi_pll_dco = {
>>>> +     .data = &(struct meson_clk_pll_data){
>>>> +             .en = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .m = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 8,
>>>> +             },
>>>> +             .n = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 10,
>>>> +                     .width   = 5,
>>>> +             },
>>>> +             .frac = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL1,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 17,
>>>> +             },
>>>> +             .l = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 31,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .rst = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 29,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .range = &s4_gp0_pll_mult_range,
>>>> +             .init_regs = s4_hifi_init_regs,
>>>> +             .init_count = ARRAY_SIZE(s4_hifi_init_regs),
>>>> +             .flags = CLK_MESON_PLL_ROUND_CLOSEST,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "hifi_pll_dco",
>>>> +             .ops = &meson_clk_pll_ops,
>>>> +             .parent_data = (const struct clk_parent_data []) {
>>>> +                     { .fw_name = "xtal", }
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_hifi_pll = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>>>> +             .shift = 16,
>>>> +             .width = 2,
>>>> +             .flags = (CLK_DIVIDER_POWER_OF_TWO |
>>>> +                       CLK_DIVIDER_ROUND_CLOSEST),
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "hifi_pll",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &s4_hifi_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>
>>> [...]
>>>
>>>> +static int meson_s4_pll_probe(struct platform_device *pdev)
>>>> +{
>>>> +     struct device *dev = &pdev->dev;
>>>> +     struct regmap *regmap;
>>>> +     void __iomem *base;
>>>> +     int ret, i;
>>>> +
>>>> +     base = devm_platform_ioremap_resource(pdev, 0);
>>>> +     if (IS_ERR(base))
>>>> +             return PTR_ERR(base);
>>>> +
>>>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>>>> +     if (IS_ERR(regmap))
>>>> +             return PTR_ERR(regmap);
>>>> +
>>>> +     ret = regmap_multi_reg_write(regmap, s4_init_regs, ARRAY_SIZE(s4_init_regs));
>>>> +     if (ret) {
>>>> +             dev_err(dev, "Failed to init registers\n");
>>>
>>> dev_err_probe()
>>
>> Clock drivers are the foundation on which other drivers run. There is no
>> need to EPROBE_DEFER. Also use EPROBE_DEFER as long as it is better to use
>> when getting the resource.
>>
> 
> At least you are requesting the ioremap resource, right? :-)
> And clock driver has tristate config, so can be built as module.

I took a look at where you suggested using dev_err_probe. Neither 
regmap_multi_reg_write nor devm_clk_hw_register will return 
-EPROBE_DEFER. So is it unreasonable for you to use this in A1.

> 
>>>
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     /* Populate regmap for the regmap backed clocks */
>>>> +     for (i = 0; i < ARRAY_SIZE(s4_pll_clk_regmaps); i++)
>>>> +             s4_pll_clk_regmaps[i]->map = regmap;
>>>> +
>>>> +     for (i = 0; i < s4_pll_hw_onecell_data.num; i++) {
>>>> +             /* array might be sparse */
>>>> +             if (!s4_pll_hw_onecell_data.hws[i])
>>>> +                     continue;
>>>> +
>>>> +             ret = devm_clk_hw_register(dev, s4_pll_hw_onecell_data.hws[i]);
>>>> +             if (ret) {
>>>> +                     dev_err(dev, "Clock registration failed\n");
>>>
>>> dev_err_probe()
>>
>> [...]
>>
>>>
>>>> +                     return ret;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>>>> +                                        &s4_pll_hw_onecell_data);
>>>> +}
>>>> +
>>>> +static const struct of_device_id clkc_match_table[] = {
>>>> +     {
>>>> +             .compatible = "amlogic,s4-pll-clkc",
>>>> +     },
>>>> +     {}
>>>> +};
>>>> +
>>>> +static struct platform_driver s4_driver = {
>>>> +     .probe          = meson_s4_pll_probe,
>>>> +     .driver         = {
>>>> +             .name   = "s4-pll-clkc",
>>>> +             .of_match_table = clkc_match_table,
>>>> +     },
>>>> +};
>>>> +
>>>> +module_platform_driver(s4_driver);
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/drivers/clk/meson/s4-pll.h b/drivers/clk/meson/s4-pll.h
>>>> new file mode 100644
>>>> index 000000000000..1fb5bececf5f
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/s4-pll.h
>>>> @@ -0,0 +1,87 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2021 Amlogic, inc.
>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>> + */
>>>> +
>>>> +#ifndef __MESON_S4_PLL_H__
>>>> +#define __MESON_S4_PLL_H__
>>>> +
>>>> +/* ANA_CTRL - Registers */
>>>> +
>>>> +#define ANACTRL_FIXPLL_CTRL0                       0x040
>>>> +#define ANACTRL_FIXPLL_CTRL1                       0x044
>>>> +#define ANACTRL_FIXPLL_CTRL2                       0x048
>>>> +#define ANACTRL_FIXPLL_CTRL3                       0x04c
>>>> +#define ANACTRL_FIXPLL_CTRL4                       0x050
>>>> +#define ANACTRL_FIXPLL_CTRL5                       0x054
>>>> +#define ANACTRL_FIXPLL_CTRL6                       0x058
>>>> +#define ANACTRL_FIXPLL_STS                         0x05c
>>>> +#define ANACTRL_GP0PLL_CTRL0                       0x080
>>>> +#define ANACTRL_GP0PLL_CTRL1                       0x084
>>>> +#define ANACTRL_GP0PLL_CTRL2                       0x088
>>>> +#define ANACTRL_GP0PLL_CTRL3                       0x08c
>>>> +#define ANACTRL_GP0PLL_CTRL4                       0x090
>>>> +#define ANACTRL_GP0PLL_CTRL5                       0x094
>>>> +#define ANACTRL_GP0PLL_CTRL6                       0x098
>>>> +#define ANACTRL_GP0PLL_STS                         0x09c
>>>> +#define ANACTRL_HIFIPLL_CTRL0                      0x100
>>>> +#define ANACTRL_HIFIPLL_CTRL1                      0x104
>>>> +#define ANACTRL_HIFIPLL_CTRL2                      0x108
>>>> +#define ANACTRL_HIFIPLL_CTRL3                      0x10c
>>>> +#define ANACTRL_HIFIPLL_CTRL4                      0x110
>>>> +#define ANACTRL_HIFIPLL_CTRL5                      0x114
>>>> +#define ANACTRL_HIFIPLL_CTRL6                      0x118
>>>> +#define ANACTRL_HIFIPLL_STS                        0x11c
>>>> +#define ANACTRL_MPLL_CTRL0                         0x180
>>>> +#define ANACTRL_MPLL_CTRL1                         0x184
>>>> +#define ANACTRL_MPLL_CTRL2                         0x188
>>>> +#define ANACTRL_MPLL_CTRL3                         0x18c
>>>> +#define ANACTRL_MPLL_CTRL4                         0x190
>>>> +#define ANACTRL_MPLL_CTRL5                         0x194
>>>> +#define ANACTRL_MPLL_CTRL6                         0x198
>>>> +#define ANACTRL_MPLL_CTRL7                         0x19c
>>>> +#define ANACTRL_MPLL_CTRL8                         0x1a0
>>>> +#define ANACTRL_MPLL_STS                           0x1a4
>>>> +#define ANACTRL_HDMIPLL_CTRL0                      0x1c0
>>>> +#define ANACTRL_HDMIPLL_CTRL1                      0x1c4
>>>> +#define ANACTRL_HDMIPLL_CTRL2                      0x1c8
>>>> +#define ANACTRL_HDMIPLL_CTRL3                      0x1cc
>>>> +#define ANACTRL_HDMIPLL_CTRL4                      0x1d0
>>>> +#define ANACTRL_HDMIPLL_CTRL5                      0x1d4
>>>> +#define ANACTRL_HDMIPLL_CTRL6                      0x1d8
>>>> +#define ANACTRL_HDMIPLL_STS                        0x1dc
>>>> +#define ANACTRL_HDMIPLL_VLOCK                      0x1e4
>>>> +
>>>> +/*
>>>> + * CLKID index values
>>>> + *
>>>> + * These indices are entirely contrived and do not map onto the hardware.
>>>> + * It has now been decided to expose everything by default in the DT header:
>>>> + * include/dt-bindings/clock/axg-clkc.h. Only the clocks ids we don't want
>>>
>>> axg-clkc.h?
>>
>> I will correct.
>>
>>>
>>>> + * to expose, such as the internal muxes and dividers of composite clocks,
>>>> + * will remain defined here.
>>>> + */
>>>> +#define CLKID_FIXED_PLL_DCO          0
>>>> +#define CLKID_FCLK_DIV2_DIV          2
>>>> +#define CLKID_FCLK_DIV3_DIV          4
>>>> +#define CLKID_FCLK_DIV4_DIV          6
>>>> +#define CLKID_FCLK_DIV5_DIV          8
>>>> +#define CLKID_FCLK_DIV7_DIV          10
>>>> +#define CLKID_FCLK_DIV2P5_DIV                12
>>>> +#define CLKID_GP0_PLL_DCO            14
>>>> +#define CLKID_HIFI_PLL_DCO           16
>>>> +#define CLKID_HDMI_PLL_DCO           18
>>>> +#define CLKID_HDMI_PLL_OD            19
>>>> +#define CLKID_MPLL_50M_DIV           21
>>>> +#define CLKID_MPLL_PREDIV            23
>>>> +#define CLKID_MPLL0_DIV                      24
>>>> +#define CLKID_MPLL1_DIV                      26
>>>> +#define CLKID_MPLL2_DIV                      28
>>>> +#define CLKID_MPLL3_DIV                      30
>>>> +
>>>> +#define NR_PLL_CLKS                  32
>>>> +/* include the CLKIDs that have been made part of the DT binding */
>>>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>>>> +
>>>> +#endif /* __MESON_S4_PLL_H__ */
>>>> --
>>>> 2.33.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-amlogic mailing list
>>>> linux-amlogic@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>>
>>> --
>>> Thank you,
>>> Dmitry
> 
> --
> Thank you,
> Dmitry
