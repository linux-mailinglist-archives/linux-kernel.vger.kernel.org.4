Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8113773D5ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFZCjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFZCjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:39:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE6410C2;
        Sun, 25 Jun 2023 19:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW5ZwldPF9oDKfw67jRmfXraXSB3ZdyECmyrIYuToME//+2xCOTHuAFFcyx2XLcH+u+heQWN3rf1WdsjLYwPnl1+l5vgZ/HIVt/FlVLm1y9ehHheib4kICxuDEXgPfD7sLzgozy9/3fbVfxFr+NMihO4b+nkENkyxXwL+9yfQ3wGBYtrW4MPvEIVLWPOYw2KF2oVaDI3DvsL/5cJA0Nvh1K28Ujr0KiygyZm791/8xAbUU471dD41YxM8bRW/M0EUz/7UH7QDnQx1u6lUT1DlzA6GzG3t0+Qcu4rQ/wNxEveW9PXzSjUk8xAKhV7h0BmK2EAgCgz+1pqgeSnfGkGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP4aj4mMr7bc1x6PvXz0/Pu0Ou5ytTZA8Wn3xpJT9Hk=;
 b=fCxucRyHREjEZpxaOcsJ6TDiU0X6WAzVM8f5XymKvqJdbPKwepgXqrsW9QHu3BxEKkvhwiBn6+e4EeIL2Focwr9VG3S2GeaWIX0kIyos/pqG1AGeKv7IQgdHABWQ9ROxryMyHQ5FJ4u0qXy3uVd/JfAbTfugIgle+IRbJpi/X3clzXqIjW5gdfDM+i5wYsEZJ93NSvpiITAByxlNf75NPwvLacpGdGgcHhO3quBMRd2omiM8QFaqWBULdA+6qzuQzvhTCiW1KQTtw7/a7Ao2vCn0uKaztRsFcQ9Hom3+F1HqIB6B4Ldu0LVOMvMEj1N2EF0iZLvVkoqiifdTynLZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP4aj4mMr7bc1x6PvXz0/Pu0Ou5ytTZA8Wn3xpJT9Hk=;
 b=HWUiB3Bv9MqLrarUoJPaZhPYTLDFAkTjhAyppkJPvih99uyu049x0J8xptR/tYMtkah+ycFAehRgkh1MBS2yk+fuC2I40M+WTLd6UPFaUFuXwLEifD89OG8iJeHsApBjJHwVLB7KGdeWvy0Gf5FzuW2zja5WJitlqOKmZ2eirrraprKmU+AMnppxHXOCuFV1w00EJzi0FxCCPAFvWPbnMGa/B0uvMssYKkNTWmX0hPhLyRtFcXXYjnHeevxlWd9WHHaCW+pCRKsnLEc0jhM7oaHuc90nF+EkJRsZJu5BOAGuJbLb9Y9kPPhq+cnezwSMO3Q+lnpni0/aiRXVfwsI5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by TYZPR03MB5550.apcprd03.prod.outlook.com (2603:1096:400:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:36:59 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::8c09:1fbb:8f34:685c]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::8c09:1fbb:8f34:685c%4]) with mapi id 15.20.6500.036; Mon, 26 Jun 2023
 02:36:59 +0000
Message-ID: <f7a2e5ae-8201-2c07-6d8f-d709871e24dd@amlogic.com>
Date:   Mon, 26 Jun 2023 10:36:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 4/4] arm64: dts: meson-t7-a311d2-khadas-vim4: add
 initial device-tree
Content-Language: en-US
To:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230623081242.109131-1-tanure@linux.com>
 <20230623081242.109131-5-tanure@linux.com>
From:   Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <20230623081242.109131-5-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|TYZPR03MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: 684ffafe-4f9b-463a-fcd7-08db75ee374a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAplEd8hwTcbB9jwUVwUflShoP1L/iuTUiUIL015fVXtJQAdNoR/6K6jSTBbohz2z6NT4KR95JcMPCGwMcOZpBGyWnFEjXjxT+Hz6twcI1BTkQeEQZq24kYgN64Zen2gqoxYAy37Q20Q6lC8pM2RIRW2UJCQXAHkJWUMBghQLMij2m+xzch/cADAMKDHOeg4OP/pBTuJGTu3FX4MVm9Q+whU7aMXqkVw+gBWnY9/GOgQOCrITEbidwErSmJ+A5LQfmpsBG+FhcZhi0UmmS84BuqgZDjX2jR6xHOPYkl0WjOrW3CuUpwD8UfhWhxO9NZaE86gm28rDgbf5SvNZo0RX815m4l8zv6bMGvgXGT2ESR8R9YCNier1NjpEOn/z41WEzat4rhtjRN+gS5NACWjMkrLurOo+uxGMLpYMWWdQcqPN7nULAxSiE685wQM3i5sgUJs3bV0WphILjTa32jkPymmDe/eu2xAmr7yiYcw63yE0AAJKnyFGH7S3Vj5PwsUsr99PN0BNga5DhBDGhtxr1jycBmvS8Yx8vty+dU1KDahwOZu5POCBEdFXmeHSj45bv0b0P08XxhDfEvB51Ar7pvu/Jl4TYulpaTIuHzjE59zhOGT44uRmgMBhSIYOGyK3wjHzAXcH6bEGicGWTxSGvYxrEchNwbd+Zr6+mKKYCoYw9xR4vp4Ah37R1WqJbWT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(451199021)(7416002)(44832011)(31686004)(5660300002)(66556008)(4326008)(66476007)(66946007)(478600001)(36756003)(316002)(8676002)(8936002)(6506007)(2906002)(966005)(110136005)(54906003)(31696002)(86362001)(41300700001)(6486002)(186003)(6512007)(26005)(38100700002)(6666004)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJ4d0hoV2tkZkVaandPL2c4YURQZGxuOXAwNWcvVGl5RXRIQ0VRRXF6bHVZ?=
 =?utf-8?B?VEVRdTJkMzNEZUNzRkpTajRHS0tCZmU0a0p3UWUwZzdydHdObmFVVURSNng4?=
 =?utf-8?B?bUlXYmlwbzQ5L2FDWUI4YmJxTkU1UXExSEg3bkRxeS9QQ0RHeHlpSnVFUDlM?=
 =?utf-8?B?QUlYVndRL0Y2OUk1Wm10ZUcwbUo0THRwZks5Z0d4UHFpQ3VxenRXTUR0eUdP?=
 =?utf-8?B?eHUzbzJ5MnBVbEliMm1hT1hHamgwbXcrQjI2eXB5ZEozZTdTYXFhOFoxOHdC?=
 =?utf-8?B?anRzT0RiSTlMQnp3cGRPaFVZc0EvRDk5aUQxYnVwRlhtM0tNdzgzdlRXM0VR?=
 =?utf-8?B?TGRIRG9EOUxCQUtsK0U4RjBtTVV0TWc5U1VJWHlCTU5EV2JlRlV3Q04xc3Bl?=
 =?utf-8?B?NXE4bVJSMnZOaDgvNTJpbzRicWFLOXJRNXprejdHRCsrc2J4YVByRGluZ3RU?=
 =?utf-8?B?YkRJM3BuZjhQQ2FyaWNPZlYrUVdpcHBzK2RERUtKSkdSSFpXSUJXTHVrdkhC?=
 =?utf-8?B?ZU10eGhjMGRhMWRsSWV4a0dNVGpVV0xXSnRKUnB3VyswUEhwdlp2TUVOckdL?=
 =?utf-8?B?UUt3a1Z2VVl2aFQvMFFwVzh0VEJyaHkzZG5sNmVGTEZ0T01DSG1kbStDN1hj?=
 =?utf-8?B?SHFmbEJMbHVIZW9pWldxaWp3YVc3RzFLY3JaOExSeFpQME9ORFNPdngrUnd3?=
 =?utf-8?B?dDFWMXdpNzJWajVXSUZMRW9tS3FjZnArTDdnZDVrR0JRZHZnTlpuazVYL3RG?=
 =?utf-8?B?MkdsclJEblBFd0JXTE9RMnlYZTVRZ1d6SUR1WEZaRlUrRndLWVhZQTBjNyt2?=
 =?utf-8?B?c3BTcWQyWFZ4VXdibzhNOTZWMlQ5T1RqR0lYWGtVRXRCcTBNN0JncUZvaDJT?=
 =?utf-8?B?cy9xUXVXWFZpOWxaNUhGUUh6b0JDTkpvdjFkdG52eHN3eEMrZzFUcVZrT3V2?=
 =?utf-8?B?OWpZb3A2UnJBWjArNldqZ3h1cklBZDR6bUFYNmdBKzg1WkRSYTFpcjNQRzc3?=
 =?utf-8?B?VlVUSTZacklhblVkUTM0ZTlaWWJkVm9GbStVVmZFUmM0d3ZwTVNUK0J4K0lx?=
 =?utf-8?B?aGtBK2NRMEd1c1hEQjdRc0lCSWZQVjRZUG1iL2hDdmJEUU0wT1VETTJtUm5W?=
 =?utf-8?B?WjBEclNYSE9YSWNzK0Vmd1ZoeTdBVmpqOHJQUzk2RUxvRHEvNlpKbWxYbHkw?=
 =?utf-8?B?bC9WdVpuK0htU05nMlgvd05lTzFsZGFWVXRUWDlPNjdISFdIS2JWSDh0a0xI?=
 =?utf-8?B?eEhzaFhzL1ljUXhBaEZwdmtiQ0VpMnhUMTNMcnhGd0N6bTIwVTFTOHM0ZWV1?=
 =?utf-8?B?YlRuVTV2QThMNXlkOXlrajFaN01kaFV6TzRNSmhmUHJXZVFzb01tMlM2YS83?=
 =?utf-8?B?QndiZkVVZkpPN0wwUkVGc1VKTXdjUk55Z21JWVliaS9aMjZXeW91T0RKbk5W?=
 =?utf-8?B?Ny9ocjhnZGhJaW5EWDNtdUUwc29pTGxGbXZXU056NnpZcmtTYVVGRFlDSlZH?=
 =?utf-8?B?VzdaRFlDWWhKL0tYYW0zdjBqVVBsanhIMWxuaXJHcktINjV3dmpEUEh3NWR6?=
 =?utf-8?B?ZEl4RzlLTmNvam51bnQ5Y3d3YnpabzdpYjN5aG5IMnFyRks2UE94eXV2SzBO?=
 =?utf-8?B?ZE83dHNZZEdTb2NtMWk5dTdtSk5vamFGSGJLWEhXYUpjT2ExbUJBdmJXY25a?=
 =?utf-8?B?cTlPY1JOc3VBTThmTVZGbE85YnpNeUlUL2NXd3RPK3k2TW10TGNoOEVGOS9N?=
 =?utf-8?B?YlRtdUZ1RGdVZ25aVFl4Vk9aaW9Gc0NCdVNaa0N5TWNldlZNRTlqdXlyeFhB?=
 =?utf-8?B?aEZYSDhrQitjWXloSjlFQlBNT0hnWXFPa1h0TktINUlHWUhaWEtiSWdhVm9W?=
 =?utf-8?B?WXZmNkp2ckNPeVRod3doaUY5bW9razd2WXBnOHVkSVhNUUViZ1ZwZVhjV1do?=
 =?utf-8?B?cjZOQWdBVW0rQzhjRFRqR2dsaDBwODBHWldCNVJzUTFQYit2ZGlnLzdBUU5p?=
 =?utf-8?B?cTQ2dUJpZ2wyZTI1VFBaZFFkRVFzaXBKUC84azUxWjR2Q01wUDBwRDduRjRT?=
 =?utf-8?B?YWlqTkdVb1hlaTB3ei9FYVNzZjhnUXkveWgxNnNEZURuTmprWE1CbEtwZDBu?=
 =?utf-8?B?OWsxNk1OK21Oci9IRTR2Y1ZBRzRjMDJFQXYvYWZ4UmJrTW1VbGdYZHBhbEZl?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684ffafe-4f9b-463a-fcd7-08db75ee374a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:36:59.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q25eT2Fnnq9nCnsgc9BXyob5bpeUKrYG+8ysntCi6nxnvQIkDP13NUFAoU3zOx9+23oj+hdpIlI9cs7qcm0oCyqzGCTQP7v86yG2XQ/wt5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5550
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>   .../amlogic/meson-t7-a311d2-khadas-vim4.dts   |  52 ++++++

Please rename "meson-t7-a311d2-khadas-vim4.dts" to 
"amlogic-t7-a311d2-khadas-vim4.dts".

>   arch/arm64/boot/dts/amlogic/meson-t7.dtsi     | 158 ++++++++++++++++++

Please rename "meson-t7.dtsi" to "amlogic-t7.dtsi".

>   3 files changed, 211 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index cd1c5b04890a..1c5846bd1ca0 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-t7-a311d2-khadas-vim4.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
> new file mode 100644
> index 000000000000..04cc8b0dfd8c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Wesion, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-t7.dtsi"
> +
> +/ {
> +       model = "Khadas vim4";
> +       compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
> +
> +       aliases {
> +               serial0 = &uart_A;
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
> +
> +};
> +
> +&uart_A {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-t7.dtsi b/arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> new file mode 100644
> index 000000000000..9b8c33708ecd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> @@ -0,0 +1,158 @@
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
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
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
> +                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +               };
> +
> +               apb4: bus@fe000000 {
> +                       compatible = "simple-bus";
> +                       reg = <0x0 0xfe000000 0x0 0x480000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> +
> +                       uart_A: serial@78000 {
> +                               compatible = "amlogic,meson-t7-uart",
> +                                            "amlogic,meson-s4-uart";
> +                               reg = <0x0 0x78000 0x0 0x18>;
> +                               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +                               status = "disabled";
> +                               clocks = <&xtal>, <&xtal>, <&xtal>;
> +                               clock-names = "xtal", "pclk", "baud";
> +                       };
> +               };
> +
> +       };
> +};
> --
> 2.41.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
