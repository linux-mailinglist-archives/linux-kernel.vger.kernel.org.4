Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7076A60D3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiJYSp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiJYSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4334E612;
        Tue, 25 Oct 2022 11:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn+mRlelQVanpToQdMGZIU6aRBMDV8CzYAfxZW/0+R/bJv/U5Eo4f4ZgDrudkdSU93kbfz8/shNJbGGJ1NtVjFNccsJfZqb2+lNWrWPALO6MybdF0YTn+ORi6s0+miN7+r8OHccjIVTZqPQd2P0+WuQKSqdSCGYVbKpVt09HJnOdJgTMad/qKhJIPIDkSJLjo1+7gRe0gnKBI40OvPWox5XpNFxPE3YFlsyBWfs+yDsH0RbZd6NFU01rcCkpO2Leqko6laKifWDnydLvEIajeh7oN7Kv+wJ0Yk5HB62t3wddI4eW1V6xmiDJgEnyQWICTE84unRgmBVL2gLO9utwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+LTqji0WLBskwU6w2Wp7sJCoT/Rwr7MdgFdiHC6kZU=;
 b=SwKxtq1MgcjdZULsZhCew/ZUz0EF6ZVJOU9xpRktF0SG9DR32gCj1Pi7PAlOqbMI/jaqGUYAISNlM65YM/xPlyXhLbJMUF/RvcWi/329aQhAzytJRHlulp/2inCqt2tqN0wZ+h1+4UGLNjJfWQ3N0FFQQVAO6dpoy15fOdVdOF9sm9ILce0MqM5sEcphwzGMlrnx+vpHj9T0jaN98cKDlwP4tMUJta8CG2S1fXGEyq+1c4EVyHg1eSZdQwufFe699OtBF79Qf4xT9UOPa3gQHTxfuBniKRNfa3jpYQW9T9WO/tekmXU4sY5oxKQYDxEXnFDImRLPa7wgjS4i5YsB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+LTqji0WLBskwU6w2Wp7sJCoT/Rwr7MdgFdiHC6kZU=;
 b=P0zWCYpk0QW1rYBduxG9wdSkhqaEX2jHlVq04DxfKx6u5mk3mDfo+rtFkn58+mV96F9mAr3p7pgCmCHqLd8xpzLEydYJb/J9Yt36a95D04zRJzs2v1AmpthQ31z2X3EqMbyN2sw4KWdr1JpgnOh+4pfOuYIJ/drZoAfzssKzWWMYK8qIk6+nJnDjXySyIQYHYbfCpobPin/4/9/bq8bJVhV1h/ME1y02dvNPfx7v1XOPvi3bZEi+k2DDjxSeRdkgH2LwyhYa5h2DK31K1yGhDgH+Gh7106P+KrZJMh07GBAzHBNbzyxkytbOtKGB90kEXhOBavnyEzu6rhVIPPEgMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 18:45:31 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%6]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 18:45:30 +0000
Message-ID: <ae12e902-a130-0978-37fd-727564325bc0@nvidia.com>
Date:   Tue, 25 Oct 2022 19:45:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: tegra: Add ECAM aperture info for all the PCIe
 controllers
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        mperttunen@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20221025182704.13029-1-vidyas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221025182704.13029-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::35) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2019ed-5606-4256-b4df-08dab6b91781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oO3Q9WIXDOIOP1eCeo9eoxiG68w893hRCalb40VBOIW33TTMUfRht6PnRksgjCZOeqG5/o0Tk+1WlTZGN/5Zd4GiLRz2l3knEqYloGylvWMXOYfjh/XESqJxqc5xGLpyI/tDzYAkUiAJLg/siJp59JZpr2spFia01gAsBl3oelnEU/sDA0pZBJKqvex920w60SWD5qYyTRIdhQqmBrjlc3geon1NEmdVe0hVssnmzQZL2NkfQEVckigwDgSb8238fJjxN/7nz0LfV/9YN1RH2U7gLK7XmcX89JqWf0WGijWo2EpoT1zi7E/PPfrqmAnbOUa6VDQp7w8ygHjPHbtJvcBk/wYHRHbdNEVXN/D2LxLOecc64py0WPmdzMJfZ4XDgZX5OFt3wF4ktXlaABI0a8zsm4fbpRC5qu3sWf7kPrjG+nR/mQ2/x7S7B9j6Uw5EBHbv2h7PDG4N05tbbJZZC4aPZW/Hma9WmIPHOVCyXBKMZ7QJ2uSfdrSRyy8mCiHHfrJRg2URmgN2q/AaQNVf3K9xp0yt8NOTfkJigwDKujc9wZIssKfofag9B1jj50Qw+wGPvOcvPIjuhpjcHib0h6cikOe6DihPV66bMW86yN9bGD6msoxsVGeKA+9oDnuDreITKItFxBl5/DSj3PeZYUz8VwHrfzsdQsBdBVa6KhdIpFiVeu1ZHF2Ih8bVD9+zPi08ICDvArtLFrCefTwBUPTaWQ7pl3bhzEbISTbcHk1ATYlZjjPbkUG2qP6k/FfU2pMeg7ySrDYkRkPtC5rrV6/TtbA7VejGnxCTBMgSK8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(8676002)(186003)(2616005)(83380400001)(38100700002)(4326008)(5660300002)(66946007)(41300700001)(66556008)(8936002)(66476007)(86362001)(6636002)(316002)(31696002)(6666004)(478600001)(2906002)(6506007)(26005)(6512007)(6486002)(55236004)(36756003)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFF5Vk9pRWlJSG5tRkJvTHFGY1FHd0RETndvU044MldhSVJReGxic3doK21v?=
 =?utf-8?B?MmhqNllkUWlnWS9jVDdNTUpNM2hQaVRLNEo2b29PWTcwRmNqVzNoVWRJc2NB?=
 =?utf-8?B?dWVCNHVXSE43dTJJdHlVNkdtT1ZZVXJqbFVNdXhJTlFWc3JZNm1RQzVkUnU0?=
 =?utf-8?B?VUZqa3ZSQjQ2TklyMXlUakozQWJsTGZMZzZOL1pTZFpiNmE2OHJ6ZTFWcWlY?=
 =?utf-8?B?YkVLbGFwSTNhRW16bTdJbnZnenhIcCsvMnhqODhVYi9RRldFSmRNbXBIVkxG?=
 =?utf-8?B?QWpZYTNJaDBRTlVGUkRIMkJBeDhZZHc1dC91NWlzcjJ1bWx4UWJ4U0JPZmc5?=
 =?utf-8?B?YVR4ZkNxUjJ4RFdYeFQra3pDMHNuVjZUOVpkWW9WL1Z3d2tFcld5TDdGQkhL?=
 =?utf-8?B?bVRZRUhWZ1BsWFRKUUpmSHowc2RtbXR5eUVCOWpjZ0piTEx2ZDRBRldnTzhL?=
 =?utf-8?B?SkRCeDBNSDEzTFpOV04ydUJvQlUwUllyQ0lvVWN4NXEzZVdabTVZc1M1ZVBK?=
 =?utf-8?B?MHBEUnJOOCtKOHpqWlpORmE2SGw3WUVmbG5RV1hWa0lRMm1lK3duUk1HUTNU?=
 =?utf-8?B?WnJqazQ3a0RtSHZnRDlQalpWVWsvQmxsQVVDWDVFMzAyWFlYNGxQK1diM1E4?=
 =?utf-8?B?TXhLZDVKNEpSeWRISzhnbkFIRVZxbTIzN1J5YTRsQW1GOEtwKzFpY1V6bld4?=
 =?utf-8?B?a0NZVzVtNVd4M2tTSmZoQWdLT0ZNZHpNZkswb0dyNzRCYk5HcTMyUUYxMjNI?=
 =?utf-8?B?MGw5MVJscUhpc0N5NHM3d3U5TDh4R0tZUnQrNmhCV1g3QzBETHprQXUxeHpE?=
 =?utf-8?B?WmExQ2lXcnRKLzc1dVFVcE1jWS9vSGN0Z3ZVR0JHYVlnWmZINksyL2owVitU?=
 =?utf-8?B?VjBUNy9oQm9QbmRYZ3UxRjRBVHZXZ2w4cy9rWmtjRkZGMzN2bTdFRExyd1E5?=
 =?utf-8?B?aEtpUmtUMFRpRU81K2wrdXBrVU9WR05iazlCZ3VWVlFzNDdSUHRVVFFTZFBi?=
 =?utf-8?B?Tll6K2M1Wlh4amI1TmxZSmtaVHU3Z21uSHI2OU1Ya1F6bUljVU5UTzU5S0Jt?=
 =?utf-8?B?VXhaN0J3K0dYSVNCQ2FEY0cyNU41ZGFtem1VckVrc0xzRzdlSkNaNlR1TFpa?=
 =?utf-8?B?cEszd2dkTWVSMS96dDhxSGFxdGo4SlQvS1N3WXlFSzdlZklVUi81UkFZL29n?=
 =?utf-8?B?NTI0cUJhOGlYZGs4NkZ5M1Rid3dOQVZ4OGtJZEt2U1BxV3U5Q0xrWHFPSCtL?=
 =?utf-8?B?QW5rK3hzSWJTNDc2L1hsY3NmSnV5MnF6cGZnd2lqVlVJeGlCcjZoOWZsYjc5?=
 =?utf-8?B?cnlnM1ZodHp5aExCV3RDNmZIRGpURWxxV2l3ZmFRUVNiZTh4VSs1WEpmUFU3?=
 =?utf-8?B?ZWtTZmhYZHoyRUxhbHpjYmNwbVpkdU5TcklvMFJ2MTJBVTVZWDE0OXE2UERT?=
 =?utf-8?B?K0dnamJFNmhMSGVFekRUZHhQbWJmZGJpVHpmSEwwdTlIaFprU00rZEdubW11?=
 =?utf-8?B?T09qYmpyMTZBVXBhN3ErME5nb01ReGJpVWVkMmlJanRzSGRJL29TczRkZXla?=
 =?utf-8?B?WXlEV0M4TEYyR0x2YUtRWHFsNTQ4UjJjSDNqTjJrODZMNVRMa3Nvdktsd2RQ?=
 =?utf-8?B?VlB6Z0F5N2kyd3JwekVVck1iVDd3OUtOenYzNURGNGVBZmVkc2tVS0J4YlA3?=
 =?utf-8?B?QzVFYnBDU1ZYdkxKckhrbXdYS0w4c1VUbEJNNG1vL0NSd1J0dVpxYzZFaVZE?=
 =?utf-8?B?ZVlRUi9NQVhaR1N4U25tSWxJUlJidzR4VWdDTTJCSmRZcmsxd1JhdU16bjhW?=
 =?utf-8?B?aWJuamtmTk4vcENqL1FFa1UxMEFUQThkcndHV2pnd0dUbXhkdHlLUnAzSElz?=
 =?utf-8?B?Q09EVTQ2NFN0NUtQcGR3eURpZ2d1RDV0dnFmZDJZVWYzQUk2MzdYSFZpRFpD?=
 =?utf-8?B?OGd2RTl0Ny9SQnYzM083MlpUN0NZTTFOOUVRM1hRcmdyTS9MS1RWWWJZaThR?=
 =?utf-8?B?QXBBclJna2VsMUE0Z0hBbGxmTlVOVWNSZVdHOWpScmdTRlRUc3NGakQ4T25s?=
 =?utf-8?B?cWY5K1pCY2t5UC93R2Q5UlgzeVpjWkgrejQyOTlSb2Vwa0MwREpvbExVMkdP?=
 =?utf-8?Q?pybYhx7LLDTXcgUAvve7vkPZH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2019ed-5606-4256-b4df-08dab6b91781
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:45:30.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMfFuWR/SdtkMYig+c113ClY1DJB0uO4H6YXyyvTI4nBmysJa0Sc9fbBct63HYg93YBrYvqjmnraob8c/OHO8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/10/2022 19:27, Vidya Sagar wrote:
> Add the ECAM aperture information for all the PCIe controllers of
> Tegra234.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 55 ++++++++++++++----------
>   1 file changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index 85b0dea33117..f5d20f7253b0 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -2044,8 +2044,9 @@
>   		reg = <0x00 0x140a0000 0x0 0x00020000>, /* appl registers (128K)      */
>   		      <0x00 0x2a000000 0x0 0x00040000>, /* configuration space (256K) */
>   		      <0x00 0x2a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
> -		      <0x00 0x2a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
> -		reg-names = "appl", "config", "atu_dma", "dbi";
> +		      <0x00 0x2a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
> +		      <0x35 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
> +		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";

This generates warnings ...

arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb: pcie@140a0000: reg: [[0, 336199680, 0, 131072], [0, 704643072, 0, 262144], [0, 704905216, 0, 262144], [0, 705167360, 0, 262144], [53, 805306368, 0, 268435456]] is too long
	From schema: /home/jonathanh/workdir/tegra/korg-linux-next.git/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb: pcie@140a0000: reg-names: ['appl', 'config', 'atu_dma', 'dbi', 'ecam'] is too long
	From schema: /home/jonathanh/workdir/tegra/korg-linux-next.git/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb: pcie@140a0000: reg-names:4: 'ecam' is not one of ['dbi', 'dbi2', 'config', 'atu', 'atu_dma', 'app', 'appl', 'elbi', 'mgmt', 'ctrl', 'parf', 'cfg', 'link', 'ulreg', 'smu', 'mpu', 'apb', 'phy']
	From schema: /home/jonathanh/workdir/tegra/korg-linux-next.git/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb: pcie@140a0000: Unevaluated properties are not allowed ('reg', 'reg-names', '#address-cells', '#size-cells', 'device_type', 'num-lanes', 'num-viewport', 'linux,pci-domain', '#interrupt-cells', 'interrupt-map-mask', 'interrupt-map', 'bus-range', 'ranges', 'iommu-map', 'iommu-map-mask' were unexpected)

We need to ensure that the new range is documented in Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml. Make sure you run ...

make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml

Jon

-- 
nvpublic
