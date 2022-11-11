Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B21625D63
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiKKOom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiKKOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:43:41 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC007342A;
        Fri, 11 Nov 2022 06:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO8XjHKU360W3U5tbXNdEu+9yrfGaNISPlFwAXJbeM3gAwN56Rmkd26ufyAqdWbZzRHDXtSrGge7VJbfSH/1BA3ionTb8zxkfpSSY6iCJrv1ASOZGHl2t6aB9Abo7D/gYDecFwXf/eOSFGVBRnyX91WBaCtu3U4PM3inlEe8gkhdXtTgwHOoxfahgwShp3rQOeiKTt+1A6r7r2bStBwbeApgbqBj5VQKl2avTsbvxtEp9e/nL1atppbWOs1cZadzlkTYf4XvB8H35/vJ7hE+Zaimt/I9HzNm8yonfkdduc96MtlUIUWbEwiM9cdvtTmdKdYmxfQpK+IocCPiGXbs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHGFRp6GaFUnBSJY2arCBCwGL735JaK2xRv/+/PoCAE=;
 b=GIbdAOsnyfXus3a8Yma7/OBYD9M76MRIyB4Jny6yzFSHOzFmRJYBeLaUXH5OkB1AIVDhA6Ev80+RjM01lHsnODS1UY2xdUamW58fy3FMShbkBLEPIzp9Ti1np8pbXHLAubinccKHw6Jzc+gA46zPlyCkgY+bDdAeLGTskrIv4HfL9CTkCR4ZxNlIDMkjpFSFi5Gz0RtFqZWQKddXapkDVPqH/KK+DqaH7b0yUz5M7rnlJIbVcbdmCjI6whkfEb0Zz/dsSJ8oWrvo3x1FNqjeA99eYQDZ02FpIl93go4ceVSNBH8acV0qLZz/qDJQcKuzo8dXv7Iv4RKXwgUc+QzXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHGFRp6GaFUnBSJY2arCBCwGL735JaK2xRv/+/PoCAE=;
 b=Gb9qrUbgt3VjvwvIhKUSs0bSuTbcR1Cs2G92uf9jb6eGBoVONyQPAWYDQuCzxbRfpaHl4htpkQTxrdIeR/wifjaGyxKclwFfwJumXCqcX20fB7nzILya5DeJfTheRMZDBtNQM14omIO3uTJMpBcJEPl7DvItp9mzqSctRhEl6fPVrwDh+vO8IBaSoKJAOEqa89YJlDjxNJY73nVvzbFginL3w6yhP3zAR1WYqtASvqMwKXueW6TCYrHYLzeR0p+kJoDg8uSgefRsJUIlFVpYmD1s02FzB7nb8tKuwVGSvPiuGkw34ooiCP/O42vm0UJF7WEvRk9svcZORBtAAWiu/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Fri, 11 Nov 2022 14:42:34 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960%4]) with mapi id 15.20.5791.030; Fri, 11 Nov 2022
 14:42:34 +0000
Message-ID: <82c2f6e7-f22a-ad3c-93a7-e8b483f685e1@nvidia.com>
Date:   Fri, 11 Nov 2022 14:42:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 3/3] xhci: tegra: USB2 pad power controls
Content-Language: en-US
To:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        gregkh@linuxfoundation.org
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Petlozu Pravareshwar <petlozup@nvidia.com>
References: <20221111101813.32482-1-jilin@nvidia.com>
 <20221111101813.32482-4-jilin@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221111101813.32482-4-jilin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0111.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH0PR12MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: fed2a5ec-a567-4ace-0248-08dac3f2f86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsdyiqjOUT4oyZuM/lHl3PyCB48gn1U/8GqbhDnEbXifqvlAOdF9ko3y0SHtFHvl8kU7HkE12o7Fgo4i+1KelMJxo/7EO62v5mdA8+76AoPY7TyGmXAXhCMkgH2BjoGXfX8XaurcOFPNd7cEgqjNqgMQc4vWzqt0YLdjdd1Hk1+ztdUiDtS8p4DuFRZtKmYs8XLK8fJEn/2Dnc/r5r2VfYyEXaBRq0VVyugtS6BJMIdSjknPaJWTmImARmBcYO4bR4FgPqmNBrZakE7BqG6xRXa3b6To4LiWsqFz3pTGEV3mBnieSxhgN0SRBbHHv0NPXwPCt3rkiXRezhf+4Og1LykL0zDhPRMKBlPvmE389hqGkOhsY2DngTVUkiuAWk0qdafoDlfLqU3ehkW7NBTYCz3cT8PcyYN8Nc9i8GvqYZqjJ2WG+8SmrxKCKDOGSoc9LObfzrJAel7CjScY49JluTKW3DaVFCujt1mNTKJr2n3dasxn5UdK12BckGRCTUMa275OfGefwryZ8C1SsankM5ZSUxPbcBOmZG3bBM08tOGqVp4mASMfZthACAhLLSXpLb0xCthX6jomJ+EjN3gTL3wdsKjpYTq9sJ3tSPe/TjjRq4QsaxY/Z+tuPLxSUeQ03EEymRxaJVC0hkWbeUnX3LMNQKJ+3fRWYSWaWFnS8ctEkK6/hCuVQBzaTH3AiGflFXed+eGy7yTDMQQUKSx9Lce5b0sAI2BlCadql+jOVMzsEDmIDiw+Ycu+0RJ8Gc27vm09iv551xGntPVw1JLpJKedksN/7VLxRRVcb42Zu90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(107886003)(66946007)(36756003)(66556008)(66476007)(5660300002)(4326008)(316002)(2906002)(8676002)(186003)(2616005)(31696002)(38100700002)(41300700001)(8936002)(86362001)(83380400001)(6486002)(478600001)(31686004)(53546011)(6512007)(6506007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhOUHBsQnFEY3llckN2ZzBDaDE4bU8rOGNNa05icDJPQ0E4N3hOQ0VkNTho?=
 =?utf-8?B?MHNiR3FWTDUzMnNwUVRjV3cwbTl2NTBWNExSZW1WWThQYkxYUm50ZXlXdDJF?=
 =?utf-8?B?T3hOTXpVZVZXeHAwZG1IT0xXUm9hckpxRzVBTUFRdHpvREpNTmVMdXdCaXRt?=
 =?utf-8?B?cmNVejcyTjYxOWxRTTQvYlBpMnJBRisrVDZzZmxSTTlsMzFENllqTG1uTFFI?=
 =?utf-8?B?UUgrbGt0WXE0bzJEb0p0ZUFxcys3UTBGdklqUk9PcWFHd2QzV3g1aWlmS2t6?=
 =?utf-8?B?NDZ3OTJTV2NicjhLQkE1aVVJMFhRVURIakpTZWcwbHF1Y0puY09jcXFoOHEw?=
 =?utf-8?B?MUxsUUNuOVN4OWJIUXE5RzRNM3J2cVk2Y0hOMXFES2dYZGI0a3ZycFFGV0x3?=
 =?utf-8?B?NDZCY3YySjByTlJMdzgvSysvb0NuTUZ0VnU2OWhobDduUGxsc3V3bGcyQVgw?=
 =?utf-8?B?RytUakU0VTNZNlp4SHZBQUZZYlpMZ3lhYXA1bWNiS28xY3BFOGV2VlBCeU12?=
 =?utf-8?B?WHVsTUhtbUVCbDk3ODlrY2M4Vmg0dWo5VDlBRnVQZS9JOTlFZ0RaNElSckM3?=
 =?utf-8?B?S2JJb1FBQXI0Y0E2ajdxZW05b2cwMW96TFBEUVBUM1JKT2pMYzdyWFE1UmJS?=
 =?utf-8?B?U3VUUEk5TDNwbmlTZEczY2JuRC9rcU91SytKMEEyVyt5WWhXNm9kMmowc3Rs?=
 =?utf-8?B?ZHdaQkZ5MS81OStQOEN0VEVsRjhmRE92ZElzWEgyLzlOMUdyME9QSjZ4eUVT?=
 =?utf-8?B?UXZZMjVIZG5XbjRuQW9SUkY4RjlZZUZ6VnVTeEtMTmVSSjBKa1J4N2I1WGtT?=
 =?utf-8?B?VGl1c01qcmpnTVJTWXBTRWxvUUQ2UlNVWXBLQ3dTaUMrNUZOL1NTTG9LOVcx?=
 =?utf-8?B?U3JLdTZXVDZadmVqU3FiUnF4ejZSNXk0RDczUVE1Q3Z2WkJqNXpRS2pWb1Jt?=
 =?utf-8?B?M2tWVjRiTXN4czRNTUplQUhDNkZ3bEgxR1NHVnljS3lNekRMTFJvOEszYXFD?=
 =?utf-8?B?K0p3RmVLTWxjKzNUM2FaemV1cXdDRjZTRVc1aGdCdDZ5M0lXUW0xaU1uL0NV?=
 =?utf-8?B?bTBaRGphT1dpQkVrK01GamJPUGdlSEtkT0g4QVdkckdtZVhBNmF0c3BoTVFT?=
 =?utf-8?B?b2paN2dPY09RS1JHTDhLVjRWOW5kcUFVeVZiWFQ3bFZIN09yTVFJQnJkTHFm?=
 =?utf-8?B?RnQ1cU9CM0U1cEhHYy9uS21zMnJtQ3FNNnNtc0RYS1YwSUV1UmxVNlBZWnd3?=
 =?utf-8?B?QVdVM21naDBEVmxjZTVYc0s1QzhJdHVVS0Vrd3dNYkQ5STRXZXYzMUVZV2l1?=
 =?utf-8?B?aFlVUGdSL0d5a0hiUXZTbVprbVlNSmsrNFh6RTB0SFdNOEtCaXZieFBRWjB6?=
 =?utf-8?B?ZWpmeFJ4dFU4cmY5UVpBcnB1WUZUdWZDdGdRSm41c1RHbEg5N0hDaFozYm9Q?=
 =?utf-8?B?L3QvbW93NXROZ1pZKzhrVndlWkhPZi8rSitFVDV1VGkxTDRlTGdCRzJGYi84?=
 =?utf-8?B?cVhtOStaQUdTcnZmRXE2aWozUHAyWnV6cDE4YkhmMnh1RkVxMmdYYmlmbFpK?=
 =?utf-8?B?ZzBFeUYrQi9NYmgxNGFHWmhFMngwNmNYZDNud2hwbk9JMWk1RHg2RUZwZ3dN?=
 =?utf-8?B?VEhJaGRrNStFOHFNY3NZMy9jWGtVSXpacE5vNFhha3dXblVLMDRHVmZZTFlO?=
 =?utf-8?B?Zmc3N1l4Zk5TcGVTZ0FWdWNscnhLaElWYU40c1VGOVJ1NW5GUnB3ZGJwS2dW?=
 =?utf-8?B?ZGZzTmRaYkJWc1l5VmZSUkVJamE5SGJOQ0hId0R4c2tLdVAwcERrcmlabDhv?=
 =?utf-8?B?N1dqeTY5d1o3TnVzUjg3ZVFGU3dxVGF5M0VGZ1dMZms1Tm9vaGgwOVdxTmxm?=
 =?utf-8?B?OXJVSUxRSi92K1lQRko0NngwaWhZa0xqbW1SUlNwRHJJV1RyYk44Z3M0TVA0?=
 =?utf-8?B?a3c0cDkvY01LQzBxTFZUN1U4ZXNSYUlOc25aS015NmI0cjVFcGdtdlJ6TXJn?=
 =?utf-8?B?WXludm52M3NyVGcwUFBTQm93WlFRbkI5cnVyN0NzdXJqcnptVGZkdHkyeGRR?=
 =?utf-8?B?QjdER01jUWZSWEJDRnpFUmsvK2VJOUJnbHZKZXNXdG5nN0ZFWm9oRkJOcWta?=
 =?utf-8?B?aE42OVdhTVZuWktTOUpLWjhzQTFUbG8xZWpTaHZPTnQrc1BIWkpIQTg0Y1FX?=
 =?utf-8?B?bzcxQjhaUlJXcnlpdHBtYjZvMzdBeVRXSTdHb3pKQ004eWZvbHd6dHBwK0h3?=
 =?utf-8?B?NFJLdDQycnM3Z251R2ErKzBFb1NBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed2a5ec-a567-4ace-0248-08dac3f2f86a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 14:42:34.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1VY/FWkD/YEXEs2DxEyN3NIRn8YgQhcmJjBT4JGnlzl8dABSQMLa2AHVJTBEf8DAlsnCUYXwHMVoPSbpYgPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/2022 10:18, Jim Lin wrote:
> From: Petlozu Pravareshwar <petlozup@nvidia.com>
> 
> Program USB2 pad PD controls during port connect/disconnect, port
> suspend/resume, and test mode, to reduce power consumption on
> disconnect or suspend.
> 
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> Co-developed-by: Jim Lin <jilin@nvidia.com>
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> 
> ---
> v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
> v3: No change on copyright
> v4: Remove hcd_to_tegra_xusb() function which is used only once.
> v5: Update .hub_control in tegra_xhci_overrides (xhci-tegra.c)
>      Invoke xhci_hub_control() directly (xhci-tegra.c)
> v6: Change author to Petlozu
>      Changed from u32 to u8 for variable enable_utmi_pad_after_lp0_exit
>      Modified tegra_xhci_disable_phy_wake(), tegra_xhci_program_utmi_power_lp0_exit(),
>      tegra_xhci_hub_control()
> v7: no change
> 
>   drivers/usb/host/xhci-tegra.c | 125 ++++++++++++++++++++++++++++++++++
>   1 file changed, 125 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index c8af2cd2216d..b5ed06ddbbac 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -274,6 +274,7 @@ struct tegra_xusb {
>   
>   	bool suspended;
>   	struct tegra_xusb_context context;
> +	u8 lp0_utmi_pad_mask;
>   };
>   
>   static struct hc_driver __read_mostly tegra_xhci_hc_driver;
> @@ -1951,10 +1952,24 @@ static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
>   	struct tegra_xusb_padctl *padctl = tegra->padctl;
>   	unsigned int i;
>   
> +	for (i = 0; i < tegra->num_usb_phys; i++) {
> +		struct phy *phy = tegra_xusb_get_phy(tegra, "usb2", i);
> +
> +		if (!phy)
> +			continue;
> +
> +		if (tegra_xusb_padctl_remote_wake_detected(padctl, phy))
> +			tegra_phy_xusb_utmi_pad_power_on(phy);
> +	}
> +
>   	for (i = 0; i < tegra->num_phys; i++) {
>   		if (!tegra->phys[i])
>   			continue;
>   
> +		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i]))
> +			dev_dbg(tegra->dev, "%pOF remote wake detected\n",
> +				tegra->phys[i]->dev.of_node);
> +
>   		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
>   	}
>   }
> @@ -1972,6 +1987,28 @@ static void tegra_xhci_disable_phy_sleepwalk(struct tegra_xusb *tegra)
>   	}
>   }
>   
> +static void tegra_xhci_program_utmi_power_lp0_exit(struct tegra_xusb *tegra)
> +{
> +	unsigned int i, index_to_usb2;
> +	struct phy *phy;
> +
> +	for (i = 0; i < tegra->soc->num_types; i++) {
> +		if (strcmp(tegra->soc->phy_types[i].name, "usb2") == 0)
> +			index_to_usb2 = i;
> +	}
> +
> +	for (i = 0; i < tegra->num_usb_phys; i++) {
> +		if (!is_host_mode_phy(tegra, index_to_usb2, i))
> +			continue;
> +
> +		phy = tegra_xusb_get_phy(tegra, "usb2", i);
> +		if (tegra->lp0_utmi_pad_mask & BIT(i))
> +			tegra_phy_xusb_utmi_pad_power_on(phy);
> +		else
> +			tegra_phy_xusb_utmi_pad_power_down(phy);
> +	}
> +}
> +
>   static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
>   {
>   	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
> @@ -1980,6 +2017,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
>   	unsigned int i;
>   	int err;
>   	u32 usbcmd;
> +	u32 portsc;
>   
>   	dev_dbg(dev, "entering ELPG\n");
>   
> @@ -1993,6 +2031,15 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
>   		goto out;
>   	}
>   
> +	for (i = 0; i < tegra->num_usb_phys; i++) {
> +		if (!xhci->usb2_rhub.ports[i])
> +			continue;
> +		portsc = readl(xhci->usb2_rhub.ports[i]->addr);
> +		tegra->lp0_utmi_pad_mask &= ~BIT(i);
> +		if (((portsc & PORT_PLS_MASK) == XDEV_U3) || ((portsc & DEV_SPEED_MASK) == XDEV_FS))
> +			tegra->lp0_utmi_pad_mask |= BIT(i);
> +	}
> +
>   	err = xhci_suspend(xhci, wakeup);
>   	if (err < 0) {
>   		dev_err(tegra->dev, "failed to suspend XHCI: %d\n", err);
> @@ -2066,6 +2113,8 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime)
>   
>   		phy_power_on(tegra->phys[i]);
>   	}
> +	if (tegra->suspended)
> +		tegra_xhci_program_utmi_power_lp0_exit(tegra);
>   
>   	tegra_xusb_config(tegra);
>   	tegra_xusb_restore_context(tegra);
> @@ -2437,8 +2486,84 @@ static int tegra_xhci_setup(struct usb_hcd *hcd)
>   	return xhci_gen_setup(hcd, tegra_xhci_quirks);
>   }
>   
> +static int tegra_xhci_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
> +				  char *buf, u16 length)
> +{
> +	struct tegra_xusb *tegra = dev_get_drvdata(hcd->self.controller);
> +	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> +	struct xhci_hub *rhub;
> +	struct xhci_bus_state *bus_state;
> +	int port = (index & 0xff) - 1;
> +	unsigned int i;
> +	struct xhci_port **ports;
> +	u32 portsc;
> +	int ret;
> +	struct phy *phy;
> +
> +	rhub = &xhci->usb2_rhub;
> +	bus_state = &rhub->bus_state;
> +	if (bus_state->resuming_ports && hcd->speed == HCD_USB2) {
> +		ports = rhub->ports;
> +		i = rhub->num_ports;
> +		while (i--) {
> +			if (!test_bit(i, &bus_state->resuming_ports))
> +				continue;
> +			portsc = readl(ports[i]->addr);
> +			if ((portsc & PORT_PLS_MASK) == XDEV_RESUME)
> +				tegra_phy_xusb_utmi_pad_power_on(
> +					tegra_xusb_get_phy(tegra, "usb2", (int) i));
> +		}
> +	}
> +
> +	if (hcd->speed == HCD_USB2) {
> +		phy = tegra_xusb_get_phy(tegra, "usb2", port);
> +		if ((type_req == ClearPortFeature) && (value == USB_PORT_FEAT_SUSPEND)) {
> +			if (!index || index > rhub->num_ports)
> +				return -EPIPE;
> +			tegra_phy_xusb_utmi_pad_power_on(phy);
> +		}
> +		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_RESET)) {
> +			if (!index || index > rhub->num_ports)
> +				return -EPIPE;
> +			ports = rhub->ports;
> +			portsc = readl(ports[port]->addr);
> +			if (portsc & PORT_CONNECT)
> +				tegra_phy_xusb_utmi_pad_power_on(phy);
> +		}
> +	}
> +
> +	ret = xhci_hub_control(hcd, type_req, value, index, buf, length);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (hcd->speed == HCD_USB2) {
> +		/* Use phy where we set previously */
> +		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_SUSPEND))
> +			/* We don't suspend the PAD while HNP role swap happens on the OTG port */
> +			if (!((hcd->self.otg_port == (port + 1)) && hcd->self.b_hnp_enable))
> +				tegra_phy_xusb_utmi_pad_power_down(phy);
> +
> +		if ((type_req == ClearPortFeature) && (value == USB_PORT_FEAT_C_CONNECTION)) {
> +			ports = rhub->ports;
> +			portsc = readl(ports[port]->addr);
> +			if (!(portsc & PORT_CONNECT)) {
> +				/* We don't suspend the PAD while HNP role swap happens on the OTG
> +				 * port
> +				 */
> +				if (!((hcd->self.otg_port == (port + 1)) && hcd->self.b_hnp_enable))
> +					tegra_phy_xusb_utmi_pad_power_down(phy);
> +			}
> +		}
> +		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_TEST))
> +			tegra_phy_xusb_utmi_pad_power_on(phy);
> +	}
> +
> +	return ret;
> +}
> +
>   static const struct xhci_driver_overrides tegra_xhci_overrides __initconst = {
>   	.reset = tegra_xhci_setup,
> +	.hub_control = tegra_xhci_hub_control,
>   };
>   
>   static int __init tegra_xusb_init(void)

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
