Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC17740E23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjF1KGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:06:39 -0400
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:36577
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234857AbjF1J7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:59:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzOEvDTchwmeFQQAF1hfYvSDAve7fV22NTSda3H5bHnT+E69dB4b3t9qJ1f2ejgJ2qVuV7R57P8mgX0hz2OeXhweLcV+rRj8E2yMfZTFXrMvk1Hdal3H/ePclt6eq5Ny6wHZpZCNQAEtzdi9hzm2YmZTITCCLJIQfSAuoWLN+n75Ckr26Q6b1/0mhwOiZcBMBXZm2aTkwUCiKDhAFCywcB8XisqLVLUoarSDZVxWVQ5/wW1RrArENhMauCLK0rD/BbHPEDHWSRp7+i2Bh39rahf0w6+lSTic9xqzN6CPS7QHdaLFrMuNRjAIfJPAnrTtOCfY/aFeMMPh3mbw2XX8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpVVWNsEh5jnwYk3FYTsw/+lrq2oBQe3pWYIee6Vht4=;
 b=CawNZiSSOA2uju8WhFcKqMpys170XWAgNCbRLWtXQzURPqjJCqeLJ0LgOZIcHabo4FwxmedokOO0IDMfeJ8Nf3PCH0AoMKM52g8sNUvyYpPrOQ/25RyDT02uPkAqSxoxL4a/3qtPi1RKmgCunHkl+Kp7DNyXqJeJ2hTW3kCnRZy0UXiJO2bFkMFW2hlWuV4QA3YtJ/HS11loebJYMUpix3RP+jPEoors+s8eefhlefx1urN+v3Rnqal2zoh6ce5JZN9WU226cKxE4c2PIlOifodjgxAZ92D2euoxOHm9cqDj5ENFMUlqreSAAEWcbE7u+DL2P227XFYBqxFq2V7FaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpVVWNsEh5jnwYk3FYTsw/+lrq2oBQe3pWYIee6Vht4=;
 b=tZ3WwtmrN0MFi4G6PKy9guFLMJdB49qcOllg09SnJqOct7P2tGGrnWUHLqFl4dYM9N4wXZ5x7qfuEoa6VmngbUkAvd+UucnN7142cdqsPOxv7tLvX2KQd9fEuPfPVOVeMIpeWLxS7x6/Fwf3/zaZO3129cM6hs8sagwlX7XZXjLH+nxyo5upcO2iXAW1N1c9y4KVV9/B+7aNSfpP/3LYgFu55DMwkEr7ay6kSL8ZT+1izN8JeSFfU4ZS3yrM3Ugjdp7Z7mom1WmoZWoTDCr5GEf0zbiqFN0n4OdAIxzRy/G166Fz2bDhOwYqHtCRfyJpr5o1Pbb2OXomZJdO8y3bEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 09:58:59 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 09:58:58 +0000
Message-ID: <55cece9b-b4b8-854c-f948-2e30895f36b0@nvidia.com>
Date:   Wed, 28 Jun 2023 10:58:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: tegra: drop serial clock-names and
 reset-names
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0503.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c38960c-4646-4db0-b7b4-08db77be4a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAJTjD+qCPfGpYkdV2c6NQqB0yqvIqubOTr0P1gTuEkg6RbUkRDRBS7N/pZ+3YcC0+qFr4EHnHzlA3H/i30BgasEgL4sPsxTe0GGR/fzeLe8D2maLbdC3T9NVJ+dXN3363qurfY6GXysFVpsRZEMvyPDhEZimYM9COKU1BIKh0OA9FnHM7x+YvLQ7PSwqT7EN+7u+nxap6/GyzOwlfDS36SPHH6AaXktIwQc6hrWB4IqtHwxfB3yRkVyTcRmlaCOqs78/Uds75LDHqZMxft2K9NDP2nKBuGllMZGrcQO4TGrpW5/2EbWxRYjUGEx5WrTexm1b/tD/g+nk4QZYQ+9lXoXth2UTTQEdMfkD/LtSIrFtiqsYc0I7Wzi+kKs5HlPEDw0vIq+Pih4do27Ci8yGQqDyPEslP3ElR+5C3Fti+30a+4TCzODlGidg5x0UNVNFNMqvx2XvpVcIaCEL5dZKz/+AuB4QgSy3eodgSSw978awQgn9KKc/Ks9DoeVWBmqJB3kg8vSjc5PqDhTyka6u0IChKS9+Ugl52zDqUAqKmB4X8ZwxMnrrISV6zLbh7t485tJV6SVvlCX41t575MWlkVL6npyE3xyhZzpKr4MMvTyVbDPlDET02VvrToZfoRENdFcHlMIRAnYRYxHgoLW1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(38100700002)(36756003)(83380400001)(31696002)(86362001)(31686004)(2616005)(8936002)(110136005)(6486002)(6666004)(41300700001)(66556008)(66946007)(66476007)(8676002)(316002)(53546011)(6512007)(186003)(6506007)(478600001)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1dSRzIwckI0clRGczRVYlNmUXZvMUNxdkF2c0NwMUV4UG1UUVE2ME1BT3dR?=
 =?utf-8?B?K0dOdk9tTUVUbFR0MTZrQ1lnbWFiM1pOWjhyaTd5cUdNejdaK09oZXpqTTBm?=
 =?utf-8?B?a1dpVnptb1gzbENOS3h3eFVLeGhBMXNFenBwOVpWaU13ZHBtUDRmRkZFU2xk?=
 =?utf-8?B?Z1dadEROUnJ1L3dtZEd4Wk9aUmxMblZtUkltWlM2U3hGOHBuNDlJNnQ1aHk2?=
 =?utf-8?B?N0crZ1g2aDY5eEU1WkxUY2c2b2lNdXhEejB2TzdKZGlzbHV3Vk5DSmo5aDU3?=
 =?utf-8?B?UG5JclY2ay9jaE94bkFEL1BrMTFabFg2SXhkSlVOcEZWS25QbCtGTWNURHkz?=
 =?utf-8?B?VkFyZ3B3NHllRnVMeVZOdjMvQ1RDb2s5NktieGRXTGVzRW80N1d0d0lXbFUz?=
 =?utf-8?B?VFgySWNxNU1NVytyNnE2eFBsT2NSK1RVQk1ZQzlLZVR3am5POCt4eDFJZkpp?=
 =?utf-8?B?YldhK21BUFhJdDJlaENwQ01yY3ZjSFpsNU1MQlpYT2tUdUlON1IvOHFlaFZN?=
 =?utf-8?B?dEg4M2x2aU1vcXRTdjIxSURtZXdKb0FnVXhrNkJ6SDMzcUNNT0pkcVJMSVY1?=
 =?utf-8?B?ek1oZ09RV2d1b0ZwMEh4M3RQR292T21OZ0FRQWdncko2Q0laTXVZcCt4ditu?=
 =?utf-8?B?QWhpVzd4TjVoZ240K1lUaDJ3enREU1R3QjYycVdGaS9HUjhLVk5MMXR1SVVB?=
 =?utf-8?B?Y0l4cXFmbnRIYnhQU2crVENkQzY1T3luRUZwY1Bqb2tlTU5tQXU3OXBzbmsr?=
 =?utf-8?B?NG5sM2g5TlB3b2tXUzNFeUFTRnI1b2hzd3BPQzFRdGdaOHptVEErWmVjY1Za?=
 =?utf-8?B?T25MTldCUVNCd3ZJVjg5S1ZxRnczeEtoM2hrQjFaVWJRSnVSbFJnTFFJRG5l?=
 =?utf-8?B?ZTh3RWhGYjEvZWRuS0wwaUZwVHU4aSt6YTdjeWlWSHNURmw5bUxOa1RET0tG?=
 =?utf-8?B?ZDNJQytKOVlpTy9UaUtPMjdaKzVtYVlqUjRYNnYxYW9kV0t2WjNFdU1laXIy?=
 =?utf-8?B?MlJLbkNtc0habnRUK3ltZU5jc00zaEJWTkR3UEE4MGZIemtsSmJYbTB1Q2pF?=
 =?utf-8?B?cVdibDFJdk1nSmgwcmRBaThSMmUvaHRIMHNQS0p2QjJnZURvK1h2RytsQm0z?=
 =?utf-8?B?NjlTWDNjTjFyOEh6Y0JFblNTUEFNVll6ZTJlbisxL0w1RHZxR3N1MmRuek4x?=
 =?utf-8?B?MWtacjJlUUJ1QWpSbXBqMWgxSzZyb3V2OHNwS3JEZ0IxTEpNZ3IwRkJ2cDEr?=
 =?utf-8?B?U1lpUnZ5VlBRcEdRNXFqSkpXM1ltOFhpYTNnVnpPeE5xenp1UXBNR2hXM0JR?=
 =?utf-8?B?ZndBRXlBaWtjeGRWcTV1TWJOS3ZkbVFXdmN0Vnc0UVF3NVdJR0tmOVZHb3l2?=
 =?utf-8?B?Y0FjSG1rQnVNVFRjVGR4dHNoK1FhaUlnR0dXRlpNZTMyMHFVQ0gwU1RiTC9H?=
 =?utf-8?B?SXpXZFJiYUNBUlFBS1VpeWRWdENvcXF0REY0aHVuajFrclRTdkFUMjJyWjZj?=
 =?utf-8?B?bWhzM011OU9lU1kxM1BXYmhab1ZpVkRtMzZxd05hdURGRVBxdUZ0L3RRM0pQ?=
 =?utf-8?B?K3FsOGlmNzZPNVhiWG1BVHovVzBjVW5nZVIxQ0NjZko5cmlZMzlBL0dJWXJT?=
 =?utf-8?B?Y2Z6QmUxcXZWNHE0Mm1nSnNpRVpMSUlFVDdUd000NFFuSjFvYzlXdkZrdkU2?=
 =?utf-8?B?T2NHNkNKY0xYY0JoR2dDNFJwVURyOGNMU0k0T3pMeUkxMzRKSFI0bjZ4SlBV?=
 =?utf-8?B?Q21EdWJxRjlnMG02Sjl2d1ZFUk1yaXo3Q2hlcU5aM3M1REdOZGw0bEw1OEZV?=
 =?utf-8?B?YVVpZGU2WlZKTFR6TkZuNWxlVGN5OXV6S1VaQlpka3p4dUEyMFQrRnFEYWpl?=
 =?utf-8?B?TXNjL0FVdjg5YnR2aWVQVGw5MFFBSkpIVWNCbEttRDlaa1F4L2U2enZ4TjBh?=
 =?utf-8?B?ZUtuMjRLY3hSTjR1NFVTVnA1dXNnSkpkVk5YaW5Sc0g1ZnZmTFZYTEkxNFJs?=
 =?utf-8?B?eDhsMjQybzRNTmJ1QlNUNkVIVTlRdGZmZU9taUVPNm5OazJkaTBUT0NmYzNo?=
 =?utf-8?B?LzQ0Nk9oSzlTZkViU1ZKanB6b2l1b3FEa3F3dG4rK2ljSk4xUGE3ZlJ2ZmRQ?=
 =?utf-8?B?ZVE0QlRxV3diTlVvUS91emhhcklHNHB5MXAzMmxucWJKQnJwMlQybjAyZVYv?=
 =?utf-8?B?ZzAxSW5HRTVhejdVWDlsbUczNnNpRXBXVWZhWnFGRVlZQVRudkFSRnFTRjRH?=
 =?utf-8?B?bTlYU2dMS2U2Qkh6MWZrZ0FTRkFnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c38960c-4646-4db0-b7b4-08db77be4a8e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:58:58.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27Rkai4LAw/Mj3iEXjP/hKnvsDWWZbb7H6NKXbn708KEQvuZg419BRhpDC9hSdaXEbOAMMSBwJbsVm+9hTPxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/01/2023 15:15, Krzysztof Kozlowski wrote:
> The serial node does not use clock-names and reset-names:
> 
>    tegra234-sim-vdk.dtb: serial@3100000: Unevaluated properties are not allowed ('clock-names', 'reset-names' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/nvidia/tegra132.dtsi | 8 --------
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 --
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ----
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 --------
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 --
>   5 files changed, 24 deletions(-)

...

> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index b54353f31df5..372be226a7f4 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -676,9 +676,7 @@ uarta: serial@3100000 {
>   			reg = <0x0 0x03100000 0x0 0x10000>;
>   			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&bpmp TEGRA234_CLK_UARTA>;
> -			clock-names = "serial";
>   			resets = <&bpmp TEGRA234_RESET_UARTA>;
> -			reset-names = "serial";
>   			status = "disabled";
>   		};
>   


Thierry, do you have a patch to convert the Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt to yaml? I have noticed that the above change now cause the hsuart to fail on Tegra234 ...

[    5.109961] serial-tegra 3100000.serial: Couldn't get the reset
[    5.116302] serial-tegra: probe of 3100000.serial failed with error -2

The drivers/tty/serial/serial-tegra.c driver is making the following call ...

  tup->rst = devm_reset_control_get_exclusive(&pdev->dev, "serial");

May be the correct fix for this would be to populate the reset-names in ...

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index cd13cf2381dd..513cc2cd0b66 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2010,6 +2010,7 @@ interrupt-controller@2a40000 {
  
                 serial@3100000 {
                         compatible = "nvidia,tegra194-hsuart";
+                       reset-names = "serial";
                         status = "okay";
                 };

I can send a patch.

Jon

-- 
nvpublic
