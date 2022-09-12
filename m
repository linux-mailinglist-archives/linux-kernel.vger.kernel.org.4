Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDAA5B5CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiILOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiILOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:49:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DC25E80;
        Mon, 12 Sep 2022 07:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI+3tebZFZwR/72t9Lxa4hOpsz51q4k0pBn04Ry6EzwwtrVxZoG4uJ0/m9FfKzXW5NjsjmwmZnPlWil2cTjnNrNTbNgEh9gPF7Wx5tAGOzJYTxrP5IoEy9t0GKnIcvYUekDzJ/WfIpY4aEGz5lkyjCegzFJTdSYbMnooM+n5prAbxHyoXgLATHWVv9HF3Ujday8OORFDVOMlxBpyo1SY2B6oWtupZA6Gk/LcwkkQgd7Z9PsLl+Pu9saIycDBSKMAe8VWWGZmo6rKJLXvb/LjHJb9PxsOjmHIxG/+fla+RrjO2t7W1LVrTv3WQPhlsCbDVHgEa9W05f3gkDuC9y8GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKFiL3qBhYhEAvYrmZO2hgRiGHtOhimxp0DlBGwRroQ=;
 b=O1R0gl9h06xK7qzqK1OSSf2bSTBkBrf4DM7jO8kqgnRzqTSpxwlMWbpj05hMWklMUgacsP+/hFhHXynJmoPbEAGpAYC7b6TEp9LqHC3A4w6yBQRtXGgSqZ5YABIJayi16ThftbJKjMRwF4qz8YA+pUBAXWocVkiUJLKaULQva7yPaz0dJoDPM2kniK/xjz6vodOC7KohZ2fYW0XauOePprE/aIphwHtTHgSHM0NfoDGgNhNLWE8TQuPTe0eYJQlwTodXvqqSXjJ5F8nzMwQugDmkuabIdVoyMJWa2cKl3xdHXsTLyLYIp/oChwI5BQpRHPf2hNckIoGp+FafiewkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKFiL3qBhYhEAvYrmZO2hgRiGHtOhimxp0DlBGwRroQ=;
 b=Lj3+z0HiHE/KZ/VqaCE/ixz6IL60CHWsgInhh06o0WSXxXf3u0kC9XKmsCbsDgnOXHzy6UvrJXjgru9By6UFcYKQzHl7un6LHOkuCgO1qIR9D8syxoRlktfrjgRloRq9H/7N+PAjZQu6jPCuatCb6oybZdII7fEFQsktdcNkNpWffSDgCjCLM2q2S13QhQ98qc3GqGGU2Xhs4f+GihjrVnG1fIXP/9pvrqPz8tcCgiKPga7nynQO0dFei0S864dJyYtc7D2mG+ZF+1zL+9Zbmvlqm7IKM0XQhv+aCk4frSdlP15kZ8itK8Zw8A3jtA6mVivMP/vUxtv8dW27nriTDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Mon, 12 Sep 2022 14:49:16 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f%7]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:49:16 +0000
Message-ID: <7c260dac-b29f-80a5-84da-cd2fd9cb63b3@nvidia.com>
Date:   Mon, 12 Sep 2022 15:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] mmc: sdhci-tegra: Separate T19x and T23x SoC data
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com
References: <20220912132337.18159-1-pshete@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220912132337.18159-1-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: e827141e-6ee4-4b3c-d311-08da94cdf74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IpIQpo7XDhTv3CygEXRgQWXf+e//ups4bgcR/lfd8Dj4uVwylEc3K2vT9q7Aw/izu6+5KkXwzB46bTqwEZikOOnTxTaY+NSu4NRqK96CrHKuE1KLOiWv2T9O+vhKEISlAkCYLlVIoLoBk/5Ql2Kun4aHSpAo1PgdzEge7orODrDlHrNyIrvq0/MzPljJeQ+0GjTC/6Zc5ATmzQMA0sPZf0rpRO0Y6qmXHKFFOOOB6LHfEaZK5/zLaZPxlDWypDnrXGQF0vQsd7TndiTVcFkNv4KVUizUnKhQZuusixv7t0SMo0rYGoaVo7wILZ0Hb+n8X0SvKthZcO32ayrJVZooFaZrO/fbEwCmfuj8PLM/yrClaa/QIkQiRXWKylv4mHAh4k375tY+SjYvvZPMJ1IwFSjhEJhfccUF031LKS2ca5THqUBYKTom0kct7KDvfxusXqyWvqDlouHsLN97/4yJmszHtKPX2t5i4BGZP+RtzU+53pwzH2ctInkjGmVUw7pbSzC1bATCXMwm85srDrtbNfSVZpzjQ8ILSBw1mFK0K704gEirAEGIxRAqFYqQ5d+ioizrf8Y7HtjAPwZOslltX2hRHlSm2ODoQZsWrBZGsqDyxzSB3Zbz9v2fQjNZ0ImGe6CJlLu4/r7MucjE0ojYRKb72CfHY5uGGF2J8NUDLpn5RuPYqjRZl9RrZKYIGikDRtcfaY1x4OLh2ODV/82riVGEy3A8lFpYnpsqXWniBWLWcFe//mzP1JAuvh7XmVcVRoROUFAajYeP5UaYk8Xt1LQaKmTPIjIdyB50VkL3+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(6506007)(53546011)(6512007)(6486002)(478600001)(41300700001)(107886003)(6666004)(2616005)(186003)(83380400001)(38100700002)(66946007)(66556008)(66476007)(316002)(8676002)(4326008)(36756003)(31686004)(2906002)(5660300002)(86362001)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NWNTVQcHRCcEk0dnVJRG5PNTlJN1QrNGpyWmtlYjlacklnUEk4L2xOc2Zi?=
 =?utf-8?B?aE9ET0xjNmg3R01XZFBIM0RTZ1ZLUE5qdVNhZW9TdUUzUy9iYUd5SzFJbERU?=
 =?utf-8?B?T0lFU21YMFJXbnRpZW9na25HeFNFZXFlWGNiTVl2UGRLZUd0Mlc1MC9oUG9X?=
 =?utf-8?B?T0FtVUE4bVdaK2dQM2NYY0FwR1NJL3JVVDJydGthRC82dUx4WERobTdHbUJ3?=
 =?utf-8?B?T0JsRHZJak50VTZjNDFxcWpLZVYvME9iNm16dndMT29FN1dmc1UyWjdOQnNa?=
 =?utf-8?B?enlPcTlLeTJCOFFVT0laL0d4bnBvRnB4SmpZcHBrRGdCM2JSNFJlSXZDVWMy?=
 =?utf-8?B?d1diTUlyOW1PVGdhZXZkUDA5QXErTG1uREdXaStDbGtMMVUwdXA3OTBQK2gx?=
 =?utf-8?B?VE0vdFRvK1NGdzJ6VE9yWkJBaUlMMlp3Mkd4Y2tRbXB1N1lzNWxKTzFCMGdJ?=
 =?utf-8?B?UmhQVGtMS0tuTU1vdGEwRGtBN0lqdEhpZ0xNMTNiWkVLcGpQb1JzdDhqZnZx?=
 =?utf-8?B?M0Y3c2ZzektXcWNkcGc4TjN3WUIrV3grcmF1MTRkSmw5aWFGT1U2ZlJramJm?=
 =?utf-8?B?VCtLRDRuOXk4VG5pbWVpTnhNM1lpcUxEU3pWc0hjK3N2WXNhN3dnZkVvNDBj?=
 =?utf-8?B?amlrUDQzWUFGc2hHOS9JYTZaL0FzUHJDMFVUcmxkQlRUdUJnZU91SGVJaFpU?=
 =?utf-8?B?dmJseEFnQXpBZUUxN3I2cWNxK0ZVU3FKMHArNzMwN21EdlQxUWZ2aXBxSTdO?=
 =?utf-8?B?UTFmcWdwaDhtV3EvU1Q3aklGUFpQOExhUGQzL2JlSG11WnhyeElIZzRlMzVW?=
 =?utf-8?B?UVRmRGZPcG95dGFpQlEwVmhqeUFrT0VPVkJWbjBkYjlMZ3pTYytwYWM4bmFR?=
 =?utf-8?B?ZFduYzRNdW52UjR3UzRHMXVKa01xem92VzhtN2s5cGw4ajF0RkNTaWM2UVJj?=
 =?utf-8?B?VjZwczdWRllEbVFDUzNzdHJkRTFDMzhPRlFma3BVZ0hxSW5mSkZJbW9WT2xu?=
 =?utf-8?B?WEdLVnlEK005SStyeU1ET1U0QzE4anFkMG9xbmtPWktPZjdnSzhVWnNhSXpR?=
 =?utf-8?B?U2xabDZkR0c4bzNRaVBsZGxDUjdvSFo4bGtEdUVOdzh2MDB3ZXl4b0hKZmwv?=
 =?utf-8?B?WmFZaGFxeVdpSzdsckVCeElHSW1aMit2dmRyNUdGT2d4TmliMzlubkpXRHov?=
 =?utf-8?B?aVhxWXZhWFZncTdCOU9wNkl6THlLRXFtZmlaYk1Zdk9QYUhscU9URmdCaGg0?=
 =?utf-8?B?aEtHZFpCWDZSWXpOUWpaeTEvbENja3VYR3ZkY3NwT3NlUVd5aVlKWUdoVWFo?=
 =?utf-8?B?RkRvUzV2WmZoVWFmMmI4UTNLK05ZcXRGekhMRWtBektLbUd5R01jWURIZzBj?=
 =?utf-8?B?M0lUUHY1R0FqbGcxd1poOGxDbllReVJidkljcGxGalpzbG1Bc05za3hhTzFM?=
 =?utf-8?B?WDlUTlo1TCtPY1l1Q1VpVGpqUDJ6SlRWOWljNzBnSXNVNUtBN1c3U284SzVE?=
 =?utf-8?B?UUcrNnR4dE1lVXlvdFNWR1ZwWTlyaVpWcGVFZmRvZUFCS2RlUFF0MGpRZ0dm?=
 =?utf-8?B?blpjT0JOc08vOWcvODNyZDd6bVo1bVd1ODVleS9DU2g4SGdHbTJyT3dmQkRu?=
 =?utf-8?B?NloxTUhkcUlNdFVxUUkrUndsU3RvK3hCcmVHMkxXbE15bEpjUlNsN1lhOGRZ?=
 =?utf-8?B?eXEyTE5kaTd2RzExZVN3YzVlZlBweEVSREFFNzFaeWVPZjNqazhFSEltaVZR?=
 =?utf-8?B?RXJkOFYxaGJ0d2VGa1ZObklmVERVbWgrc0tJaXNsbDZBd0NrWVBNdEwzbWtI?=
 =?utf-8?B?UmxwUVhjT0d5UkxobVc1QVExU1N6N05oSUdPYzc3d2lnVlRHRDVRd0tSWmwy?=
 =?utf-8?B?VmtxUTFtbWZsWm9IQXFMTGx2SkVKVUNIaHJnZlhKeW1pTkcvaCtJVE9OZUR3?=
 =?utf-8?B?QzgxUG9oQkQ1RW9JaXlvV2xLdWJ4SElRUklkY3pEVEc2cDlBYlVBOFc2a1U5?=
 =?utf-8?B?MGg1ZUM4Tnh0VENtZkFpeFd4QWFhTlRyd0YrYk52c0M1WXVEdXUxMmRINlZJ?=
 =?utf-8?B?ZVU4emIyOGhjampkZmxOZVk3dWV0TzVpNjdiQnFBVlRGR1VwOWY0UDYrbWVt?=
 =?utf-8?B?N3kxWFUvRkwxTmtNMkg4Q3Z2YUxiSFdmeVo4L0VqbmxVdk9HV1FTcjBacmtw?=
 =?utf-8?B?K0RJSll2amtoRmUrQUI1Y29ReDh5ekJsUWJwRldMMUJ3MXFBR0FSSzlBb0RH?=
 =?utf-8?B?MDVnTmE1R25iZUJFZDhFL2xJcC9BPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e827141e-6ee4-4b3c-d311-08da94cdf74b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:49:16.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nClG8n4IoK9lfUhfgx0RdX1x7PXHw4Nf4h9m2LLHeP1gHQ6FuSQUviUSBRIirwNIGcBJvgJaBZF1Q1lA2ULvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/09/2022 14:23, Prathamesh Shete wrote:
> Create new SoC data structure for T23x platforms.

Always helpful to say why we need to add new SoC data. Ie. what is 
different?

> Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 2d2d8260c681..136c045d8f01 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1525,7 +1525,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>   		  SDHCI_QUIRK_NO_HISPD_BIT |
>   		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>   		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
>   	.ops  = &tegra186_sdhci_ops,
>   };
>   
> @@ -1556,7 +1557,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
>   	.max_tap_delay = 139,
>   };
>   
> +static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
> +	.pdata = &sdhci_tegra186_pdata,
> +	.dma_mask = DMA_BIT_MASK(39),
> +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
> +		    NVQUIRK_HAS_PADCALIB |
> +		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> +		    NVQUIRK_ENABLE_SDR50 |
> +		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_HAS_TMCLK,
> +	.min_tap_delay = 95,
> +	.max_tap_delay = 111,
> +};
> +
>   static const struct of_device_id sdhci_tegra_dt_match[] = {
> +	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
>   	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
>   	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
>   	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },

-- 
nvpublic
