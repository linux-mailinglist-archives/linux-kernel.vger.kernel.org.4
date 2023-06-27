Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D473F8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjF0JWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjF0JWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:22:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4937AE1;
        Tue, 27 Jun 2023 02:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QelDNuzvriVyAHh6JFKpJEs+osHRNrwqzIvtA1YZVdmt8H0szxs/DxsLZLbWKB/t7RpELpCMA4qKgsnNrHd7cSGVBA02SyFyLmSLrpv0/Y7u+Lr/QTxXm5DoU4tzT/5DSN1eQm+clPh7eAx4liPD4J21ef16aIXsp5mSsQvscux4X22fqNty+Z6tLWrKoaFSxPKuWLRDo5BlBJcNRTc9JoPmq/DnRZkNnmbpgo7UAilCWXy5q//oPzcQTXlbfDmMRwvKzBzsmyIfiO+SXF1thgo4/sq1gv3GBmZxCUTya6BMJCbCzoac0XmFicwcjzZslHLfUr/G11HvF1e4VZwqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOzNVyrJp47V5yXay7PoidGe6JDMUIXgwD68ThBH1Kg=;
 b=hEOKXfhIAp8uTnxiuu8XbiNhIwK5Rcak5ox7Ju2UnWmOSl3YjPsEKuTCyUTNQtgRx3HlgFtCm6rLqmONdUeEW0tt9pHdSyJe43UOIa0ASH4i92OS5BHl9bIhjiuXFPLQEnyYtvDvkjMbl5owImWq9aXk+6udmHCXRlH423fHX1728X3Itq9mfgsFlWVLTwjYxLFsLDovdRFaDvzUfA9KKO34++T4pSLLAmURz56yyC7uyfTPkZC5AOALaAcsq6TUHmJq9BmOsHcQ+wDj0JfcJC9IOrBjzX3zbY0aLJ1NNiHxHW98UgJWEhTQOzoTxfGLd/zpjbVVJX10/TOTYphT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOzNVyrJp47V5yXay7PoidGe6JDMUIXgwD68ThBH1Kg=;
 b=kfFGZwjdCPsYcHygfCLxfau2pvRp+k4tEdgFuNtNcu+doBHge5g43q7OKLuwn9lEticaVJPICLiqu8CJwq+2Ezsuh0VQBg56hABggykdwO69PUX+ks/aZecZwOVzB/o4mMvYtrGO1ixB4+lMNp4LT/4A9eNWDzjUAqRBPiGRIlFmRMYEJ08TZy4mDH0XQEt1c5ZpDUx24f9dG447RtOy23dSrhT/UA5Jpv8d5BzHxwRvIWe5L1gfMUSvglWoNbyvylUTky9V+jcfE2yE9PNv7UFg1nm2pHcWrzD4sdnkC3RuqRzpl8QtAUxLH8RUV/Hu0Rmq4ecVQoPJx/XjeLfAeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI2PR03MB5689.apcprd03.prod.outlook.com (2603:1096:4:159::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 09:21:48 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:21:48 +0000
Message-ID: <fd7e60d1-b99a-a425-42c9-db85236ba71e@amlogic.com>
Date:   Tue, 27 Jun 2023 17:21:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 4/4] arm64: dts: amlogic-t7-a311d2-khadas-vim4: add
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
References: <20230627091007.190958-1-tanure@linux.com>
 <20230627091007.190958-5-tanure@linux.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20230627091007.190958-5-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:404:14::25) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI2PR03MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: 4065b97e-800a-4700-e24d-08db76efeed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+BTkiyz8CCFQsJnIz/IKqlYAG6iXuptKnlBgGy5XZQ6ujE8wB0BbOFhM0rspyOT7zpq8ZnmQy9cuqPhocCk1v1vRDOw7zQ7pnxT8Kwh9WAEENRUZc9gstdRn1uphs48jtlX6ePxnFg8lSwDkOiTj2De4zsdlMQAxt9o1pB/h+LKXzZLncc8V7wRF+noX+98M2NeFfN4+ro23HFwbWAO5uVTLjZc1HvWG5qtNO0/Ppf7NqR6ZUCCGg+oDNPKNCubNuYYS9PkLZ0cC3+RElTHeU12c1vQJWzoAA7FMtf3e5SN+se4ns/fYQwyZPcdkBHqBoHJfQH7lSNJtNNbc44uLiTInPgmNdWUDTj0q4RRXelFCIQ72wjXoHTDX0gr+VfLuGxA+mGYXTcQ44DbzZxYktJ4TlFsGe82Rtl7ps78SbYw2/mJYzTRLbO1f7/z9rhme0H/aYIreKcPr6Hgz2rhRU9nKN1ZaPrgBI+CMzN5Lf4YZ01UzJMK69LBlB/I/lzgw/mnYZ0JKob6IdErqyKMUTwegQls2P+CRrUCn+NrDLOfhh3XM/cRKOpOtHr2TdUw/kbM8gibaNFj/mRZY8KNIQ+aT6gvwLPSN9d3TdSrfL8c6yLhV9JajNLca9Zr3xk76inlCMTZz7FA1+Q73B1YxY49RIF/sJpFnWGjp7amRIwn8i7JXRrkwPFpZ6EIFCFEPMTo3q8xwaUuvlfTXbrhLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39850400004)(366004)(376002)(451199021)(26005)(36756003)(6486002)(54906003)(478600001)(2906002)(110136005)(83380400001)(6666004)(2616005)(6512007)(53546011)(186003)(6506007)(5660300002)(44832011)(7416002)(316002)(31696002)(38100700002)(8676002)(41300700001)(8936002)(66556008)(66946007)(4326008)(66476007)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCt6aFRlVVFUWFV0UTg3NU9kRzVBM0hjdHhHMko4aXh0UlZmWndPNUg5eHNZ?=
 =?utf-8?B?VThSL2VoUk5UYVpKeU4rMVJ6OUdBVFJENUkzekpIK3VLanJvamY2Njk2aCtu?=
 =?utf-8?B?YzVHSWJSNEJORG1QUDdPNmllV3g0Z1JPSW5ScDdmQjBuYVNyTW5FL1huNktD?=
 =?utf-8?B?Z21hdEhiSVNuL0wycVp2RHhDMUhDWXRwSC9RQkhvLy83NUl6bGFja3k5MmpQ?=
 =?utf-8?B?NnN4ZzkzU25aUVZINnpFZUJVMWtBVlppRCtkV05YVHYrNXgrNGlFSURyQnlU?=
 =?utf-8?B?SDNzUHQ2SW4vL3ZtV0RwbVZxbEVjOW9LdVdETjdBQUxWekYzbnhQSExKV1dT?=
 =?utf-8?B?dlVLb3FFNjJzWWpxK0hkWlg2cnc3bUNyM253b2IzMjJ1anlJK2NGYTJKcXFK?=
 =?utf-8?B?aVZPbWplaStRY1JHTzZiYkhqZzBvOTlRelo4M254d0hFdC9CTVM0TUdqMHhG?=
 =?utf-8?B?TzNnaG1FcWUyeERXejVZWXhVVG1YaEFuSmZBdUp3eEhIVG94bkJ4Y2pDd29N?=
 =?utf-8?B?aDF5Y2RVN3dTbVVGVExPeWFSQ2w2LzdnQmVFeEFzNGZwdEgzcW9DUUV3SURG?=
 =?utf-8?B?VVRlL0RHbmFOY0FvZmpYUFVNKzl6MTMzdUFmTzZwcE5zNjVFbEQ0NVhJbXpv?=
 =?utf-8?B?T09qZTNCQ0RwNEpzWkJjcXFTNTRUL0dKZDNMbVNwSVJJZjlqb1dIWTlKZzZs?=
 =?utf-8?B?RnRvT1FkdnhDSGRMcG0vTVIzNG9NN3UwT3BjbGlVN1pyNnA1MHplakRWbTF4?=
 =?utf-8?B?d1h1bkllUGc2aFlCeUZLOFRtQWtQenl3Um5xVHNCYTZHRVU4azlrSXpXb3M5?=
 =?utf-8?B?bEF1NklhRTloU1lSY2xZdEZwQlB5cGtZWlJQQ2cvdkx0UXJqMlBjMHkwcGNj?=
 =?utf-8?B?TWNpSU9CMTdhbyt3eVNodGVLOEliK0lJelpEUDU3Ris1WEtISlZXWnlwOHlu?=
 =?utf-8?B?VTFYbS9FQnhOWGxGNXlncG01bVR1WmpsUmZiVWNSdHpjQ2tpWGNCSG9DMjMz?=
 =?utf-8?B?bFdrc3JQcVNVMXJUNU81M0x1NHRtU3psQ3htdFNMYm1HZkhPMEMyWno0bVht?=
 =?utf-8?B?OVdTbWJReVFFK09naE1mT2wvM0xmcW9Dc3pJSDR2SzRQWkQ0aWxVbGJNNVpZ?=
 =?utf-8?B?NTZxOVlqcnVkYWdNM3pOL2dqR3lDSVEzRXZmczNqM3QvUWVNZmFXejBrcmln?=
 =?utf-8?B?QTJhTm9aRkMyM2tuY1VMeGN4b0JESXlIMWZ0RS82cFBEaXBqNFpBYkZYQUwr?=
 =?utf-8?B?ZWZ4Z2lqWFlYRFJiaWpZYjBQMEwwQ3J4SmQvUk8vT05EMnc2cVNRSVlackNK?=
 =?utf-8?B?Y2JQZmFOT01OZkdzcGZPbk11U3cyNU1zNjc3aVdIb0FNeGV3Q3MxYU96anBj?=
 =?utf-8?B?cGxEYlFNNHNBSllsOEhJODJlNjErM3RwZk9SZUxIWTVCalRCMXFMMTU3ZnN6?=
 =?utf-8?B?Sm4zV3cvMmZHaTlhVmdPMHVGaUZZYkEva05mK25hSjNKT29oSVZBNHFKMVJj?=
 =?utf-8?B?WDRjOSt1cnlvWXFRWUY0M0czQWFCbG5wY0N1OE5ZWUZlSHh1aXR4cVRnYTgw?=
 =?utf-8?B?S3JsMjlYZVVrY2RoUWxMaXF3bUN2c2l1Y0dqaGRPSEswMHFUNWg0MW9hKy9M?=
 =?utf-8?B?eUtPZzBJbUxZNUhHRGVjbDJ4WlplRzZ4Nmh5aU9mUE5aSk5oam9MV1hQcC9q?=
 =?utf-8?B?NTh0RHhLK29scmZMbXIwMW5IQnlWZlRWekRhMmJUdi9yTE5nVm1zaFpHaXJF?=
 =?utf-8?B?c2hCQ0o2NVVoTmM2R042eWNvRE5JS1RXS2Z5Sm5nQzhic3Y5NFgrVnBWL0hT?=
 =?utf-8?B?aUgwUXRmQUdHekR3MXBqTnZLQVF4V1A4TlBtekp1aDAxNUtHWUlMTlBpV3JQ?=
 =?utf-8?B?ekpKRmlRM0hUdmxkNU1wMVdVUXM0V3lmVU9WU2UzZElpVHN5akg4aWswS290?=
 =?utf-8?B?NTI2VEhxK2JiTHM1Ulo3QmNaYktCMmFKVHNsNGkxMk1td1JndXpTQ3hDa0U3?=
 =?utf-8?B?d3NoTjdqeTd1aU15cXpEZTRWZnFkTDN6ZHhPa2E1TUVVelE5bkFzbDIwWDBx?=
 =?utf-8?B?ZFRBQ2llNHBzK0E0RE5XMXFzWWNnZDlITkoxRlJLWXZ0L2IyajhEbDJLZEdR?=
 =?utf-8?B?TEZmNys1M3BWYzlONEd3dTM3clVvQ0lTMUx5cWhIVFkrQzJldHV2ejFlTm04?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4065b97e-800a-4700-e24d-08db76efeed2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:21:48.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l634KHeURISSYlClM0IDsMxKqh/sUl6Ql4TTg5KE3e2k9CLP9ttVqZlVg6hIksHlg0xItiR/k2GpNmq6gi4tG6erT1yjLaDLLDtKANAvOhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5689
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/27 17:10, Lucas Tanure wrote:
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
>   .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  52 ++++++
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 158 ++++++++++++++++++
>   3 files changed, 211 insertions(+)
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
> index 000000000000..5d7fb86a9738
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> @@ -0,0 +1,52 @@
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
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> new file mode 100644
> index 000000000000..6f3971b4df99
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
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
cpu number is 8, not 4, need use GIC_CPU_MASK_SIMPLE(8)
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
cpu number is 8, not 4, need use GIC_CPU_MASK_SIMPLE(8)
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
use lowercase, "uart_a"
> +                               compatible = "amlogic,t7-uart",
> +                                            "amlogic,meson-s4-uart";
> +                               reg = <0x0 0x78000 0x0 0x18>;
> +                               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +                               status = "disabled";
> +                               clocks = <&xtal>, <&xtal>, <&xtal>
"xtal" why defined in  amlogic-t7-a311d2-khadas-vim4.dts files
> +                               clock-names = "xtal", "pclk", "baud";
> +                       };
> +               };
> +
> +       };
> +};
> --
> 2.41.0
> 
