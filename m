Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D940704724
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjEPH4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjEPH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:56:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8F4ED0;
        Tue, 16 May 2023 00:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXHc7hZ1O/xr8m7e530/ABsT+v77miIAiwxwsPerLeUsAxHM2y9wwgppHTxcBdJ2syixfdHIdOdZX8QN298DqZrjyUaEv09BPKzPEgM7l7S7FEphEV56fM43Q5jve3K6K2yKVTi3LG4acMeLu3jOoEKlcsaRLWuEOGxjNP8mVWGFXC0QuwZ3uOmpn54JqhPOiMwfTgggmnqnzyP3BOioXMbPwMy7zZZUIg85LEhqekTEitlMbrZOgPVr3sJsGitEu6uC/SwInWR1wJNqbwz4BmdPcM7DO4fzFppyAa9sfnQrRvlqMYsNjaxvwHxrIEulg2eVNv+V8JKvmvQarKVK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZF0fdZn3ntYovBlVtWts/39AHu1aYl2s2j2zmbc8q0=;
 b=GgLJ+pqiu0VS+KKUA30LtBSiqaO1bjBUFrjnr49j2tyTzdq/1ny7lYMUue0CGZgD7rqnG4dmYO0WHA/l3besycWdhpG/NtJzqBokQ03vwa0K60PHSSkHkvh5pxaYAf4I+pfUNv2VU8dYEQQT0m7rhuyZKGBcFPFw6APHUP5f5Ecd30ii18yR8kGSIkgdLt4M0JvOfNiUBs7cXJfayox+MwuCarYUuRu4F5brttyFEybm89LO2QERXAwnX8jPcgOzj4WTIXUspyy70coaHARhH4j41MoWookm4aw6TQw/hJ1ovIARGGgrtwKVWvGcRsnYgQ8JIi5kEkUANK7mok4wng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZF0fdZn3ntYovBlVtWts/39AHu1aYl2s2j2zmbc8q0=;
 b=eXdwL8UkbgOEar8Z3SNg2idthtTiyUO+0qtz87QMEZmKKHyAmLBcWGdrwqJ+10G500IZtW2Nfj1ZoJswhoXRMtse6n6RiMOW5qDa/TW1Po8N+qQeV6VDPDY9t8J9y4YdqdKcCQfkVz4gs9konK2x788wY58JSMAXxGShS03idz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 07:55:22 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 07:55:22 +0000
Message-ID: <e4227418-151d-7222-b439-4ce53bf0fb81@amd.com>
Date:   Tue, 16 May 2023 09:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
References: <20230515181606.65953-1-blarson@amd.com>
 <20230515181606.65953-7-blarson@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v14 6/8] arm64: dts: Add AMD Pensando Elba SoC support
In-Reply-To: <20230515181606.65953-7-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0602CA0005.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a32d08-a3c8-444e-4243-08db55e2e664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Xn4xXT1ma0EuIebHWjks12tjRMfg7rCiEuXtiD+isMjOtcK0G+A1SKncjHAiqQnEABjxZTbgkL8ccjQhw8fsgEhdxyt7594z6jQXRCRzoepU6EZSFpx+2Vr0E1NiK36k3nXPx/1qQxIdLgqa7NSfHEyAOGNF0nFe6/0pzDMOxxHZJDQhLY5IlSmVUj3NYhmNzzrvZD8C0Bckvy4ko1vBkWBn6uucN0DkFz6MB+hRdiSwoDjzIRy+oOMdW7+VsDr5JLGhTqg5WiouFjiZhQ/TObK58zJXbU3udEd1Pjwc4yzPLaocTrv5Xqmn+ThFrTrgM5ZYaZexb6/S8kq6Jvhm9KFrqfhZrrn7cYR95crFXHXSn2EEVxQr8MNzrS3cWAOTNlEc/VK+kTvcBjZmHVw2D/6LrooLwhsEWhZ9t/72o10sGiaFqtEQMxL8sTryAo8BUfDYBaKjdstfB8pVuXsvM5lM4ZeuiGAe5HeSjAS3VNtlc5kI7vrvOER8r40T2YSxXiqRJtvhokMSCRjqrVv0X8UXtUYS4u79KkX5NQIe1Q03PmvbnZBH55BPnS0j5P9VYbWHdxUwMoCrAhx/Jb+GcSHbPqmwU2d09y+jIFNZlEntVK0ZCXYnKWn3+xVlOlN23a/NK61SKc5CuaIWsxWoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(478600001)(44832011)(7406005)(8676002)(7416002)(86362001)(8936002)(5660300002)(30864003)(36756003)(2906002)(31696002)(66556008)(4326008)(66476007)(66946007)(316002)(41300700001)(38100700002)(186003)(2616005)(53546011)(26005)(6512007)(83380400001)(6506007)(6486002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3dOWm1nR0RMMjdwMHhkbjhMSGJBRStMYmlidWJkbm84Y1lINXRzN1NPQnY1?=
 =?utf-8?B?OWI3YW1JdmdsUWdRWnl1YjgzaTBUa2RzVXNZWmxJVS9XWTc5NEpJU1NkMHFB?=
 =?utf-8?B?N0U1MkVCWFdScWhMOE9TQks3VmxveWRhYWVkUEtFWmxiMk9Wc3pONmxZY0to?=
 =?utf-8?B?OXBSeW9pclg5Q2VoanEvZXNMNXloOHlSajhHQ3o0UFBObTZwMHNJUVRRajF4?=
 =?utf-8?B?Q3NrSmtqbzlMT25LdEdpTUFvRTlEYTJseEVQRHpncXVNeVdFMk5QVWsxcjEx?=
 =?utf-8?B?K1o5a1I5aVpkend6TkN1QXlyNWxTZTUwdWFMZ3VzRUs3TW9jRXR2SFFYVWZy?=
 =?utf-8?B?SVkrblVjd0dJTFpzSWpmUG5iTGkzNWQ5NGJJcW5CbXhGc0Q2NDk4L0pBczhp?=
 =?utf-8?B?cUgzUXBtMGpqZGlVUWNoZlQ2dTh0SElPZG9ldzA1ajIwMm0zTlh5NDVmcWpY?=
 =?utf-8?B?WlRQVWNBS2VaMTFtbWpRb1BDN1VPNmlIUzJNUHNMRXNsM2FzZUNrS1QvL3o2?=
 =?utf-8?B?RnhwaE9kejk5VFZ6SEh4anBKdXdSMzcwUXJleWRLQkUxL2ZOMmp6QXVKelFD?=
 =?utf-8?B?N1ZGMnBFdWw4SFFJRHZhTzErTHhrZVlmbEc1eWlxYnZhV2FYbTNsT0NSVEZX?=
 =?utf-8?B?Z24zcGFJVUhxUGFBdkNiNThOdkhHY1JKTU5JbkFTTjI5RldUWi9uWmI0WFJ5?=
 =?utf-8?B?d3JiSEd6T05OczAxa1pXYzJIKzFwU3JLOTdTdWN0UGJrL01sSTVJdEEvWW56?=
 =?utf-8?B?bTBhOXhKRnNDcFpidnp4MlhLVHNYK2QvQzVFMm1EZUdoelRmdFY4MVVUMmZs?=
 =?utf-8?B?dkJWa2NWZzhubHhyZEZ2SHRubWlMb3JuZ28vWVYybVpCeFYxbDFjQlZjandJ?=
 =?utf-8?B?dXhHVUk1WlJCWWN6YnRJRVF1amkvM2lVbm05RHF0VUU2WXVRa2xiV3E3d2xh?=
 =?utf-8?B?VkFSSzJBQ1FudThWdE02VEZDcWVvWkVNMGVCNEVDTWtiU0RvS3hnVGxjQW1h?=
 =?utf-8?B?UHlWUWNOUlZCY05sU1lqK1FldDZORXkxMUo3N1pZKzlhWmNJSU5CY1hXcFZm?=
 =?utf-8?B?cmRHQ05rZTgxVk9HTXkzVXBZR1VuZ0kzTHJYcGRyZGVmbUJaMEpQQVNSdzJJ?=
 =?utf-8?B?RVNaV0V6N0M2Yi9ZSDhOS2RubGtNMy9qUEVVKzRDUFhLcmZPTUdvMkRQU3oz?=
 =?utf-8?B?NXRrRHorZ3JFSXM2L2IyRlNvaE8wS2VuUmRsbUU2Y0M3MXRjYXJjNUdHWk14?=
 =?utf-8?B?Ujc3SEVNQjdpMVJET3NoSkdyUWJSU3QxT1IvY2Fra3JJNWo3Q3loOVUvOFFj?=
 =?utf-8?B?eHN2TVFSc1hXUzljd0tYS0FrNzhSRTZLRGxmNjB2Ymp2UVZWemM1aXp6VzdJ?=
 =?utf-8?B?aUMyejJqSXNjVDhTV3cxN3lGbFJ3K3llL0E4Sm1DdDEvY0lQaThTOEx2bUtj?=
 =?utf-8?B?N3YwUGhvemF0MzU1NE04dFNrNmhFc2tGd2N5RWNWeWFkbkpPSkRhc1BPbjRz?=
 =?utf-8?B?OFAvZjhFZzkyRnBmNHhhcExub3dEbkNjVDBFUDB5RUdDREF0YWdvNDkvT01S?=
 =?utf-8?B?djljdzFuTUhCV1EvT0VVSVdJVjJsYm16UldxWFJNc255am1wQ2J3R1R6Q2ta?=
 =?utf-8?B?amVXMDlFN1pKcnRPc2hDajdhN20ra1g5YkpDd0gxUnlzOU94V0ZFUDUzVEdx?=
 =?utf-8?B?cHlwRkp0Q0RnRU11SlZrdGNXN0pQQ1MwcU9yS1FkNStwVGhPYkdDcVB4Qitk?=
 =?utf-8?B?ZHZBZ1MwRTdMUWM1WDJ3aEdTMkRNdStzSVFMZ0ZUZlhFMFZHb1JEZFZMVjZO?=
 =?utf-8?B?M3FqeU41V21sU3kwRzU5KzVKa0lUUzdmRlRRRUJFVXU2SVZPUEpuZldDRXQx?=
 =?utf-8?B?TXZReWxIdHNFUEEwb0NMbURoZVFtTnN6RHFIclEzcEdNZS9mMTNKT0RFUmlX?=
 =?utf-8?B?RjQrdlQ0MUZ3UlBLTXcydTUzZjcwRjRQSUtNYWs4ODJCak5RMGdTNmVFalI5?=
 =?utf-8?B?OGhoRVkva09oQzRKWjA3YktLQVF1d2xMOEF3OFQ0YVNHakhBVk9FOU1kc1JW?=
 =?utf-8?B?a2dDTXVTNTU4Szh5UnJIdFJqOGtkb056NjAwV2hQemhOZkxQTWR3dGc0S0Ny?=
 =?utf-8?Q?3QapoOLs6/HqZaD3KU3IT9aGi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a32d08-a3c8-444e-4243-08db55e2e664
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 07:55:22.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9bPPQ86op6wIauA7LK66GNlK3Oj6kKnKJhXWlcH3g3JS79z+Zg/nmH9sy9ZQAli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/23 20:16, Brad Larson wrote:
> Add AMD Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v14 changes:
> - Fix dtbs_check l2-cache* property issue by adding required
>    cache-level and cache-unified properties
> - Observed the issue after updating dtschema from 2023.1 to 2023.4
>    and yamllint from 1.26.3 to 1.30.0
> 
> v11 changes:
> - Delete reset-names
> - Fix spi0 compatible to be specific 'amd,pensando-elba-ctrl'
> 
> v9 changes:
> - Single node for spi0 system-controller and squash
>    the reset-controller child into parent
> 
> ---
>   arch/arm64/boot/dts/amd/Makefile              |   1 +
>   arch/arm64/boot/dts/amd/elba-16core.dtsi      | 197 ++++++++++++++++++
>   arch/arm64/boot/dts/amd/elba-asic-common.dtsi |  80 +++++++
>   arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +++
>   arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 ++++++++++
>   arch/arm64/boot/dts/amd/elba.dtsi             | 191 +++++++++++++++++
>   6 files changed, 603 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
>   create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
>   create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
>   create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
>   create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
> index 68103a8b0ef5..8502cc2afbc5 100644
> --- a/arch/arm64/boot/dts/amd/Makefile
> +++ b/arch/arm64/boot/dts/amd/Makefile
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_PENSANDO) += elba-asic.dtb
>   dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
> diff --git a/arch/arm64/boot/dts/amd/elba-16core.dtsi b/arch/arm64/boot/dts/amd/elba-16core.dtsi
> new file mode 100644
> index 000000000000..f9f9f5fd5f69
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-16core.dtsi
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Copyright 2020-2022 Advanced Micro Devices, Inc.

2023 and the same below.

> + */
> +
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 { cpu = <&cpu0>; };
> +				core1 { cpu = <&cpu1>; };
> +				core2 { cpu = <&cpu2>; };
> +				core3 { cpu = <&cpu3>; };
> +			};
> +
> +			cluster1 {
> +				core0 { cpu = <&cpu4>; };
> +				core1 { cpu = <&cpu5>; };
> +				core2 { cpu = <&cpu6>; };
> +				core3 { cpu = <&cpu7>; };
> +			};
> +
> +			cluster2 {
> +				core0 { cpu = <&cpu8>; };
> +				core1 { cpu = <&cpu9>; };
> +				core2 { cpu = <&cpu10>; };
> +				core3 { cpu = <&cpu11>; };
> +			};
> +
> +			cluster3 {
> +				core0 { cpu = <&cpu12>; };
> +				core1 { cpu = <&cpu13>; };
> +				core2 { cpu = <&cpu14>; };
> +				core3 { cpu = <&cpu15>; };
> +			};
> +		};
> +
> +		/* CLUSTER 0 */
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x0>;

Do you really need 2/0 split here. The first cell is 0 anyway.


> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x1>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x2>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x3>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		/* CLUSTER 1 */
> +		cpu4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x100>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x101>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x102>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x103>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		/* CLUSTER 2 */
> +		cpu8: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x200>;
> +			next-level-cache = <&l2_2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu9: cpu@201 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x201>;
> +			next-level-cache = <&l2_2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu10: cpu@202 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x202>;
> +			next-level-cache = <&l2_2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu11: cpu@203 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x203>;
> +			next-level-cache = <&l2_2>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_2: l2-cache2 {
> +			compatible = "cache";
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		/* CLUSTER 3 */
> +		cpu12: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x300>;
> +			next-level-cache = <&l2_3>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu13: cpu@301 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x301>;
> +			next-level-cache = <&l2_3>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu14: cpu@302 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x302>;
> +			next-level-cache = <&l2_3>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu15: cpu@303 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x303>;
> +			next-level-cache = <&l2_3>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_3: l2-cache3 {
> +			compatible = "cache";
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amd/elba-asic-common.dtsi b/arch/arm64/boot/dts/amd/elba-asic-common.dtsi
> new file mode 100644
> index 000000000000..1a615788f54e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-asic-common.dtsi
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> + */
> +
> +&ahb_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&emmc_clk {
> +	clock-frequency = <200000000>;
> +};
> +
> +&flash_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&ref_clk {
> +	clock-frequency = <156250000>;
> +};
> +
> +&qspi {
> +	status = "okay";
> +
> +	flash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +		spi-rx-bus-width = <2>;
> +		m25p,fast-read;
> +		cdns,read-delay = <0>;
> +		cdns,tshsl-ns = <0>;
> +		cdns,tsd2d-ns = <0>;
> +		cdns,tchsh-ns = <0>;
> +		cdns,tslch-ns = <0>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-hw-reset;
> +	resets = <&rstc 0>;
> +	status = "okay";
> +};
> +
> +&wdt0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf85263";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&spi0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	num-cs = <4>;
> +	cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
> +		   <&porta 7 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	rstc: system-controller@0 {
> +		compatible = "amd,pensando-elba-ctrl";
> +		reg = <0>;
> +		spi-max-frequency = <12000000>;
> +		interrupt-parent = <&porta>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +		#reset-cells = <1>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amd/elba-asic.dts b/arch/arm64/boot/dts/amd/elba-asic.dts
> new file mode 100644
> index 000000000000..c3f4da2f7449
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-asic.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Device Tree file for AMD Pensando Elba Board.
> + *
> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include "elba.dtsi"
> +#include "elba-16core.dtsi"
> +#include "elba-asic-common.dtsi"
> +#include "elba-flash-parts.dtsi"
> +
> +/ {
> +	model = "AMD Pensando Elba Board";
> +	compatible = "amd,pensando-elba-ortano", "amd,pensando-elba";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		spi0 = &spi0;
> +		spi1 = &qspi;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
> new file mode 100644
> index 000000000000..734893fef2c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> + */
> +
> +&flash0 {
> +	partitions {
> +		compatible = "fixed-partitions";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		partition@0 {
> +			label = "flash";
> +			reg = <0x10000 0xfff0000>;

This doesn't fit with partition@0 above.
Also size is weird.


> +		};
> +
> +		partition@f0000 {
> +			label = "golduenv";
> +			reg = <0xf0000 0x10000>;
> +		};
> +
> +		partition@100000 {
> +			label = "boot0";
> +			reg = <0x100000 0x80000>;
> +		};
> +
> +		partition@180000 {
> +			label = "golduboot";
> +			reg = <0x180000 0x200000>;
> +		};
> +
> +		partition@380000 {
> +			label = "brdcfg0";
> +			reg = <0x380000 0x10000>;
> +		};
> +
> +		partition@390000 {
> +			label = "brdcfg1";
> +			reg = <0x390000 0x10000>;
> +		};
> +
> +		partition@400000 {
> +			label = "goldfw";
> +			reg = <0x400000 0x3c00000>;

This size looks weird.

> +		};
> +
> +		partition@4010000 {
> +			label = "fwmap";
> +			reg = <0x4010000 0x20000>;
> +		};
> +
> +		partition@4030000 {
> +			label = "fwsel";
> +			reg = <0x4030000 0x20000>;
> +		};
> +
> +		partition@4090000 {
> +			label = "bootlog";
> +			reg = <0x4090000 0x20000>;
> +		};
> +
> +		partition@40b0000 {
> +			label = "panicbuf";
> +			reg = <0x40b0000 0x20000>;
> +		};
> +
> +		partition@40d0000 {
> +			label = "uservars";
> +			reg = <0x40d0000 0x20000>;
> +		};
> +
> +		partition@4200000 {
> +			label = "uboota";
> +			reg = <0x4200000 0x400000>;
> +		};
> +
> +		partition@4600000 {
> +			label = "ubootb";
> +			reg = <0x4600000 0x400000>;
> +		};
> +
> +		partition@4a00000 {
> +			label = "mainfwa";
> +			reg = <0x4a00000 0x1000000>;
> +		};
> +
> +		partition@5a00000 {
> +			label = "mainfwb";
> +			reg = <0x5a00000 0x1000000>;
> +		};
> +
> +		partition@6a00000 {
> +			label = "diaguboot";
> +			reg = <0x6a00000 0x400000>;
> +		};
> +

here is gap

> +		partition@8000000 {
> +			label = "diagfw";
> +			reg = <0x8000000 0x7fe0000>;
> +		};
> +
> +		partition@ffe0000 {
> +			label = "ubootenv";
> +			reg = <0xffe0000 0x10000>;
> +		};

And this is missing space description.

Thanks,
Michal
