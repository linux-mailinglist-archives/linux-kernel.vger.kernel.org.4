Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453047453E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 04:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGCCk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 22:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGCCk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 22:40:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01471E4F;
        Sun,  2 Jul 2023 19:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtZovj7kwTn1PF6YtgJSjCVtnjO5BZA5khG/s5nsojpz+ZyBf9shJxyUILknQStwXnOzyLSLQ9EXG2fBBaeTxzqaFzILkG4Nh1XuDZKugC5ZIydnTFG6aFNn1a4Z9MS1zZbuT43UJsi0rztKcmFVahUJjikmKtcp6+9jPJEtJKq25jHlnoQIp31YRWEExrzG745m8yaTADDkktxdolJaG5p1ILn2MBhBqppKMmpI1MK/lDkRGZQ8K7rmuL9Ekq19qlqP0erIG/APmgyaBhi+NY35JXWPsYsLQbcerSM1wq7oyPkTJK2hYVyPsSiNZA7lb03+zsYRTXz4UVsUmcZV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMUm5xAJ8HsQBLRBpp+z0oedH6yZCkxmY8Mx2idU8Yo=;
 b=Jql3xnoGVrY+bmJDBKcMyBOEDPjDb7K9yRjch63jPoXy+DgZ/0gSYiDdkmKUEcZrYBHp4q1Eb7f5k26INur54j5rnQbsavcgDQo6/sbIKU1veoqb/BV4ArQXvKVQQW+auRlTBnccySsO1xkbLFzbISE2PM1kk58GUXjzJ+hEijZHm5mKp12yV6x3SQpr0VAUx/a2eL/bOC5ddK/02e6GNrc7CjgQhAHfF+CBNb9RQC7WVyEoA+u893UOd9ciUBppywUdfiFNG1YUuOr1W6fQ62tHAGC81lAbn5QuPit3FkxBE4k2fdoXnmgcf9r1gWELimqe6lNeRuTNtl0S6ffNsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMUm5xAJ8HsQBLRBpp+z0oedH6yZCkxmY8Mx2idU8Yo=;
 b=pGGKNQaQE6vy0KnZZxsKokDIhgR4M5JKkJlVQB+UAPFC2dVGgYWxRnTKI8BtSso9Sm7V5C7aEeWTznRdZnE0aF4PWDiXsPoP0ou2Q4NUlL/X1fke7IGtPED0HpmHgkPFa9mRFL6EbUlI31cL6yDGGjYl6cxTJ0Hhwv8NSJU9B6o9sjYFO9mN5LG648r0IWghNiEX4MotBuYBc7ZRGNGoZy2UVRWAUrbvG7v18hHynnc8Sv9BQ1cvxT197ZPsI/mbbfl7gCYBy62BnJJ5H2thLpaGRaMH5z+bJTUqAIMLleTrI15yst+D4WENRZGmha3hzyvxcqkFYdTQmSnbLvbU+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY0PR03MB6451.apcprd03.prod.outlook.com (2603:1096:400:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 02:40:08 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 02:40:07 +0000
Message-ID: <b7aea1f3-1850-4e09-6e76-5e8c8c2851bf@amlogic.com>
Date:   Mon, 3 Jul 2023 10:39:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 4/4] arm64: dts: amlogic-t7-a311d2-khadas-vim4: add
 initial device-tree
To:     Lucas Tanure <tanure@linux.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230629073419.207886-1-tanure@linux.com>
 <20230629073419.207886-5-tanure@linux.com>
Content-Language: en-US
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20230629073419.207886-5-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY0PR03MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: b40e7521-8637-4139-f98a-08db7b6ecfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3P+nJFYZb2VcZBVOih65jMnRq0DrqtmxAkjXSeSCi7d7wJv/twkMnk5YvAYUAa6bjWFyjHG1kJGDmJ1g6z3Sg/A/Hq/T/Jh9cADKc4GcIRjUTlFpax9qURQEEWaBWQ8zgsyiqIQgBi8dTUOzRLlsMZUKwfQOVnXfUj5XIuermYTqkv0X5NHQQpwDZEJHRLr8nHG9hzm7RPiJeoWw5D4mGzIEVk++1nwUJuQHlLckVW31N1ApQf4rnIz5/OZs1KvhBOdDWNXQwNzPCYqvvnfS8IMN+dt9x+H3TsetJ9XyQgtSu1qbT3KGb1icPNXGDhN/sYwa5MtE/WnLtGsk2MwjdWvSv2HQIvn+fHBnl+wE88DC/TO0A1Qt+urP5ucAbBA4GreO6q4unJu481AXcH6GHMEFiy9Bc2Sivh55oFFKyVFEPl9MqXHBgD58O4pFkiZjNBmp876toaV3C6c8Om12PI9P9/oZ0aK6uChK3cSMW5rOS+iYD7L77NDzbDLaPfwy4B69hCAYKGLVZMyuMn2ndJaIOkzAsDIUuEuOOWxoV5F2lgRVAh4F4RiH2rg29U7DMXo/HuPvbejbw5P0LhXM8Zve+W1PuDlTjUN/OQWFQsemdCO197PXkDUnMJi30jqy2oaUJgifeStrp5fjI83ZkhMX1Rzm3DiQEKXb8F7tqFeklWqPry7ulVtNrZ31ajOl19OIFXfbSYuUvmUwjWdeow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(7416002)(36756003)(86362001)(31696002)(186003)(2616005)(31686004)(478600001)(26005)(6512007)(6506007)(6666004)(53546011)(6486002)(316002)(4326008)(66476007)(6916009)(66556008)(66946007)(38100700002)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlmMGJpOGo4emFYTnNYQXJ3bnF6MDN4eHFRWUluZzg2ZjJ5R1ZtRWdGUDB5?=
 =?utf-8?B?aXNZbkF0K252cnhMeDBiaXkycjRidWRVbzNNbE1EZ2JFb3AyZWphZUhRL0hG?=
 =?utf-8?B?YWRaQmFZTlZ5elVWemJ3TzdIVEZZcktBeGZtZ3ZQK3FTRzdLeSt2VExvUWlp?=
 =?utf-8?B?OWR2WmpXVnRSeVp5UHN1blFBM2pnNlZ4cnIzSW9EV1R2THo4TGxJZmQ2dGc2?=
 =?utf-8?B?UU1VMFE0TDhvczNHNFdOV1dTUllUdm5ZN003Y2xyUkNESlEwcVJUcUJOR0JJ?=
 =?utf-8?B?L2RiZHU5OUNwd2VJdWQ1R1BxajExc3VXdmNGZVRUZDhjUDlKdkozcmFnSnFK?=
 =?utf-8?B?UjVNVzlmemNHdGYwekQ3cHlOTU1BTlFNdHNxRmRhTnNkYi91WGx2ZVpqdFlV?=
 =?utf-8?B?c1dOK2lwS25yOHZKVUhobEFiMHBwWVk1YUhvWHAxWnBNbjZvL3RDcVVJR0NU?=
 =?utf-8?B?cTZXYTl6T1pQVXFFUzd2citBOFJTbDB0RjlMUXFpdnRmYUFQbkh5bWhjVGdB?=
 =?utf-8?B?bCtGeTg5bFc1MHQ1ZFlGZnhzL3VNVWhPUzZiNlRWK3FMRDNsUTdTdGxIeW1T?=
 =?utf-8?B?U2MrRXNoTkNIOUtrMzhZOEhsMXhlaHlXTzZESmI0OWU0TkQ4bSsxV3FYQ2ta?=
 =?utf-8?B?YWZ3N2NLb1BHTlNOUFJBMURBYWU0OWVqVDdQUzlqcGFvaXhLRyt4ZWpuN3Qw?=
 =?utf-8?B?WVJ6OWcxMDNvTUg0R2dYT3dzSTB3aE55bEhOWGk0UEtSaGtSUkwxREMrcFBW?=
 =?utf-8?B?VmFwOWRlbVBTemNlMFhxSmRHRGI2WEV0cHFWTDZrbWFvWUpITUJGdkxReUFJ?=
 =?utf-8?B?dXA4anJ4MnB3Vm9vTWMzK1haZDQxbG1OSkRMLzNjdGcvSG1pYk1VVFlac1Qy?=
 =?utf-8?B?ME1VbCsrMlVPV2twTFpTTUtFb0dITU1ubndVODFhU1BxSG5kT240a0k2NUN1?=
 =?utf-8?B?QU5UT0VVOGNlcGlFMi9hT0NlWjViQi90ZFpCUWUrMjRMb1NvOW1hWldlRC9i?=
 =?utf-8?B?VGRQYS91REExRVcwTGMwMkpKOFk0OFF1NDR1WTh5TnY1Y05URmdySHdtcjNE?=
 =?utf-8?B?VUViMEpTejg0Y3VEejJpSWZERXhndjVEZmwvb0R0VTFaR2tzM3lGOThKOW5i?=
 =?utf-8?B?OGZtQ05McmtzQWFXMklTQ2tjck1pSkpjQ2NkWmxEVTh2NmE5dG4xOU5IR0FB?=
 =?utf-8?B?ajlSK1Z5TmMreDY4OGtjaTE3bmdZVEtjY2s1WUZnU2x1Tm96Q092RVkzNWxY?=
 =?utf-8?B?WkE3QlVLTHMxSS9QcHJEdzdvbm5VUTRSck8vcG16a0pqZlNTOTJUeVpSM1lM?=
 =?utf-8?B?L0pOT1YzQzRiQmx4OHZ6TnNhdmdVREFlT2J4L3VnNWtUOUV6bUl3Lzc3LzlK?=
 =?utf-8?B?TEEyd2lXRlZlZndSU2c4b0xyaXpETlkyZkgxbEhrRzdkd2lVQmxlRVN1L1g0?=
 =?utf-8?B?eGlLQnBJeGhCTElhdUd2K2RtR1ZTM0JYV1E0Q3phQk9lM05FRjFpVDB1dlRV?=
 =?utf-8?B?amF3NE1idFh3Y3ZOa3JyWjM4bzNLS0daeGZhRURlMnlQM1Q1SFYvMHRCdity?=
 =?utf-8?B?YTlLMmlLeTJtSnhkVXJVM2YxelI4ekkxaTc1bnk0WGlobVJpUTYyUDdWYmNt?=
 =?utf-8?B?bkF2clNsaEQvUkEwOUpjZjI1RmVzeUVES093T0R3RzdBdG0yUGgzV2o5ZU1D?=
 =?utf-8?B?Nm9GR24zR0hOREtCanFpMjVQOGt4Ky8rMVdrc2dDd0o4MHJsemp6Y2NZNnEx?=
 =?utf-8?B?T0MwMVF0YTNDSm16UzlNUVVEbXJWQXNIYVdmaDdjdk1kb3JtVGlLZlNZU3VV?=
 =?utf-8?B?NUZkRTkyeHFTWWREK1VwL1VnaENTejRxbUxPWWtSYkRTVTB6MlJab0I1KzJQ?=
 =?utf-8?B?S1lUdEtneXdPYmxRdk5qeDNFbWxCb2hFY2VVS3pIZlExQmZRTFk0RjkxM1RS?=
 =?utf-8?B?cm41ZjZXTFFEZnlGMWFkeGNEWW5TYW9vQ2xkcnlydzdGcmMrbldsZ0tZSE5P?=
 =?utf-8?B?SkxnQndWL2VYTEgwWEcrWTlSYUg3UjhPSDJkc0R6bzhGdnlwZDBtNytIc2lZ?=
 =?utf-8?B?SHVCQVM3RnNlYmNneHJoeEVzR2VFd09qN1dIL0tBeDZyMDhQSGtNckJtYUgw?=
 =?utf-8?B?WU1JNzBXUVhzRllFZHZ2STVVNGNiMnNKSW9jMnh1R3Y4azN0MUc5U3FKb0tW?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40e7521-8637-4139-f98a-08db7b6ecfd2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 02:40:07.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLjhWYvG+dOl3ckvpNs6AGIGvo/J7j8+uVEBRmQDSGVT3h4qnnxaEcIjThHKQGJ3GXgBpasMcjszNaIBpldN1PrmEcGZMpxNgXA8Csf+F1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6451
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/29 15:34, Lucas Tanure wrote:
> [ EXTERNAL EMAIL ]
> 
> The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 SoC
> family, on a board with the same form factor as the VIM3 models.
> 
> - 8GB LPDDR4X 2016MHz
> - 32GB eMMC 5.1 storage
> - 32MB SPI flash
> - 10/100/1000 Base-T Ethernet
> - AP6275S Wireless (802.11 a/b/g/n/ac/ax, BT5.1)
> - HDMI 2.1 video
> - HDMI Input
> - 1x USB 2.0 + 1x USB 3.0 ports
> - 1x USB-C (power) with USB 2.0 OTG
> - 3x LED's (1x red, 1x blue, 1x white)
> - 3x buttons (power, function, reset)
> - M2 socket with PCIe, USB, ADC & I2C
> - 40pin GPIO Header
> - 1x micro SD card slot
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>   .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  54 ++++++
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 155 ++++++++++++++++++
>   3 files changed, 210 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index cd1c5b04890a..166fec1e4229 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> new file mode 100644
> index 000000000000..fffdab96b12e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Wesion, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-t7.dtsi"
> +
> +/ {
> +       model = "Khadas vim4";
> +       compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
> +
> +       aliases {
> +               serial0 = &uart_a;
> +       };
> +
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x2 0x0>; /* 8 GB */
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
> +               secmon_reserved: secmon@5000000 {
> +                       reg = <0x0 0x05000000 0x0 0x300000>;
> +                       no-map;
> +               };
> +
> +               /* 32 MiB reserved for ARM Trusted Firmware (BL32) */
> +               secmon_reserved_bl32: secmon@5300000 {
> +                       reg = <0x0 0x05300000 0x0 0x2000000>;
> +                       no-map;
> +               };
> +       };
> +
> +       xtal: xtal-clk {
> +               compatible = "fixed-clock";
> +               clock-frequency = <24000000>;
> +               clock-output-names = "xtal";
> +               #clock-cells = <0>;
> +       };
Place xal in DTSI files is beterr,  the same as other Amlogic SoCs 
family. If frequency is different, reset value in here.

> +
> +};
> +
> +&uart_a {
> +       status = "okay";
> +       clocks = <&xtal>, <&xtal>, <&xtal>;
> +       clock-names = "xtal", "pclk", "baud";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> new file mode 100644
> index 000000000000..1423d4a79156
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <0x2>;
> +               #size-cells = <0x0>;
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&cpu100>;
> +                               };
> +                               core1 {
> +                                       cpu = <&cpu101>;
> +                               };
> +                               core2 {
> +                                       cpu = <&cpu102>;
> +                               };
> +                               core3 {
> +                                       cpu = <&cpu103>;
> +                               };
> +                       };
> +
> +                       cluster1 {
> +                               core0 {
> +                                       cpu = <&cpu0>;
> +                               };
> +                               core1 {
> +                                       cpu = <&cpu1>;
> +                               };
> +                               core2 {
> +                                       cpu = <&cpu2>;
> +                               };
> +                               core3 {
> +                                       cpu = <&cpu3>;
> +                               };
> +                       };
> +               };
> +
> +               cpu100: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x0 0x100>;
> +                       enable-method = "psci";
> +               };
> +
> +               cpu101: cpu@101{
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x0 0x101>;
> +                       enable-method = "psci";
> +               };
> +
> +               cpu102: cpu@102 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x0 0x102>;
> +                       enable-method = "psci";
> +               };
> +
> +               cpu103: cpu@103 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x0 0x103>;
> +                       enable-method = "psci";
> +               };
> +
> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a73";
> +                       reg = <0x0 0x0>;
> +                       enable-method = "psci";
> +               };
> +
> +               cpu1: cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a73";
> +                       reg = <0x0 0x1>;
> +                       enable-method = "psci";
> +               };
> +
> +               cpu2: cpu@2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a73";
> +                       reg = <0x0 0x2>;
> +                       enable-method = "psci";
> +               };
> +
> +               cpu3: cpu@3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a73";
> +                       reg = <0x0 0x3>;
> +                       enable-method = "psci";
> +               };
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +
> +       sm: secure-monitor {
> +               compatible = "amlogic,meson-gxbb-sm";
> +       };
> +
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               gic: interrupt-controller@fff01000 {
> +                       compatible = "arm,gic-400";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +                       reg = <0x0 0xfff01000 0 0x1000>,
> +                             <0x0 0xfff02000 0 0x0100>;
> +                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> +               };
> +
> +               apb4: bus@fe000000 {
> +                       compatible = "simple-bus";
> +                       reg = <0x0 0xfe000000 0x0 0x480000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> +
> +                       uart_a: serial@78000 {
> +                               compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
> +                               reg = <0x0 0x78000 0x0 0x18>;
> +                               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +       };
> +};
> --
> 2.41.0
> 
