Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8E623F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKJKFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKJKFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:05:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C706B384;
        Thu, 10 Nov 2022 02:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILqP0AqNYKq+jEze70/om+wScVJaiSYUCvfZ9QzBFsqdqlWZKekgVUrb/CiPXwGh4SE0WQgvvbxcYtIpdVn3wzoqr/hFLy2Lp1rDyWLuTxtPliOJ9hNfhfGGZgFuLITP8j1ltWm+Fwoig7T1F/MHagD6a7U1t11vCsaAdcB52edzAM5dJZLE16MtpcZ/5mZmtts2mJOATFkB1vpAMZ5FJ8bjGfRXe2ZCk1Xu9aFugCgynTAdvM2RlEPh15TsaDevYDjTnUenVUSB52mM523fmTD4aKqxx0PlAOjHhgkv8nWsdL1eMQrh/QOAaKBAsSmP48kQky5L4HOYjsBPjC3Mlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj3KpYmQjUGVvW8WvS4s9Rm544aQPuXMByV5yzxKTPE=;
 b=Z/QvqQ+JWBimjNvrSIgx8eB5KpxbLj3cKg+IcBf1SeLKtLV2ygzdRR4Y1Zst4gAPyBTDZhF9nDuzal06d0o2a/h7uwOelR1kNxd70yURjcvpp32HIa68M7rjbHa4OnZbSo4aUqfVTD2V3mAg8KxrMpyxdsknLBTuR8riruDIjpBspUfRNtOjsZyurntSwuAorM6+a+mS4FfZ0IjXZR/Z9aCDdeYf7l09X4fm+qBxK7utuDEnRa9YzsuEPZtfyB/Gu1Ww+Qu9wpUAgo9rdwywQswb/Ax7c8CtGG6B7irg3mQ7CfsRzfLsDiyeYewjY06d+NSgJ8E9Iw3kKXgc0ua1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj3KpYmQjUGVvW8WvS4s9Rm544aQPuXMByV5yzxKTPE=;
 b=HOFESz4PQc8ssXZjxxwv4KVh24FSgP5j6C6re+e14NXNPqJigJD97t6jxe5+XXSAiqC/32frM3GjuGkK81a0MJrEzu/m9/37jAKodff2rdtWCCsSvpawW3xLrLt+eT1iFiA306EfLtRLL7yHkyDJ3nu7s9p2Gw+dAoLD/9hg2C0WhsBsziSYO/Wj4IuIJpg/oga18N2e+bMt2L2pgUlCw5C29P/jiv9iTYEwYf+CvAQYIEW/Wk8oNR4c8s9dE8+lIZkBMUpdfGCTJYViaz7zDPRoY1S87vrO5y3e3l7pXgPrre/L1nUBhxwewsAmRHVQClrlaBt61zWGN4jUTyTqJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 10:05:03 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960%5]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 10:05:03 +0000
Message-ID: <7a42b737-8c0d-99f5-54c2-63b87e061075@nvidia.com>
Date:   Thu, 10 Nov 2022 10:04:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] soc/tegra: fuse: use platform info with soc revision
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, thierry.reding@gmail.com,
        digetx@gmail.com, ndesaulniers@google.com, ulf.hansson@linaro.org,
        arnd@arndb.de, skamble@nvidia.com, windhl@126.com,
        sumitg@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1668003622-13706-1-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1668003622-13706-1-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 697988d5-c408-4bc9-6562-08dac3030934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAJA4rXFmlsHdFN+qSZ4ELQBaZdr/kiKbaweL/wbdArt3mMEhEcblbPIO+F2gInF5Xxq9RODi4FJ8IQ1yYdCBmhLSMtBmhAQCPfRzxdUS3gfTTScp7BveUOkVGibc9d2KMh4g7Uf+7g0Z2EHnykz17a1GCVc4GWACuFZjx1PF+e0y3XJpf2Sda8jZ6QXkewvoe71vBHcAzLZWBf3DTrXrgnG35RDjyFjvJDsjz0H/Imp9ot7lNZB8HMLGedygapwZB8glmckpfDJiRmJvWVROJjQLHUTFQiZQYPtTvMVrS+SzF8j7z7poVHruKcQ09WdBwpDHGXd+uGeDHfpoWe60Bmi5IOF8/T5ISSA0RI6awu5Tu/En4cEU5T3tv/sxwqoixeT4FMPEMcq2hw/xOaYGWpIImsgpsv+FR8Kp52bAJRltx6V2sCGfzM6+GdB1Q8iH0PJBb7eBlYPzHblmxVNU3ZBRTw1ov8qIu8toa/OCZwm+DB3yVs4cL2kzo3Zl+G6sInJHmi5YtLsl0rUyo4KYTD5TUwwQyRIISjjzYZfgfjzgkg2UMQ9aFseOiz+xqLQLOhMFGyAxYXrhN89uMvvObO0BgQHS0Oz5VYspEJfqr3hkVkMa3ZX+tvocFniCGSRwGb/RFCTkT9WHZFjOpqsfv011YCP8uwMIrc8r1O7yQvM8PmaPEOab7P3hyMAz+hk5BmE1uqnnu8ElD0+sMKC2W6oHTKG/EScFLddavN32ry9hgBrQTsOCL89H9Au834/iZeXXvCrArlE9ZIW/VcVGSinTXMTAR3Yc4S+Lod9jA3eIh9FRY414utX1rahn7MP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199015)(478600001)(38100700002)(2906002)(6486002)(921005)(2616005)(186003)(6666004)(83380400001)(55236004)(36756003)(6512007)(53546011)(6506007)(66476007)(66556008)(316002)(31686004)(8676002)(26005)(66946007)(86362001)(31696002)(8936002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVUUTdsc1p2d2NuQ0NrM0ZpRnNIZzF2aDdPSmRpcHNVVHQ1REk2Yk5McFBV?=
 =?utf-8?B?ZG5pWTNXek5MaTVrOFJCbjVGOHVTK2o0Z0dtNXI0N282UGpMS0Vob0pLcFZT?=
 =?utf-8?B?VTRZUmVqUU5ERXVGamRYU255bTY4UGZOZlV3UjhQOW0xcUc0aSs4VSs5TXZW?=
 =?utf-8?B?VE12bjFRR2dkUzIzZzFXaGxnaWs4OWt4MGhJeXB6MmFoMjhXaVZDN2YwK1c1?=
 =?utf-8?B?THBJajdwejVwWFFMZnBqcElOZlZvM2o2ZkJ6cXJwSkNpRzFqamJ4L21KSE11?=
 =?utf-8?B?dVJEeVhQSlFNOU5TU05ldWUwRHBtSFNyanduNkxkUnVvV0JwSlh0QnR2YXox?=
 =?utf-8?B?SlVGKzZNUUxtei9FZ1pISFhseDJwcmFwMVpwdVUrZ3VEY25tZG9naGtiL1B4?=
 =?utf-8?B?bGZTVi82TlFDNDJsSnJONkVxd1FWY0lIdlNJdTY2cVFtM2FYZmJuazJtY3lj?=
 =?utf-8?B?ckNLWVNRSG1GRkRPNHBwenVQZzd4NWwxZmhPemNIekE3RUlWVWtBcnkzZXJB?=
 =?utf-8?B?NUtzeHF4Y0xhdk1lRmN0VGUzYVZJZUF0RFdEVEVMaE04WnFMTjg5U1ovVDZo?=
 =?utf-8?B?L1ErejRVdFo2UXF4S0dQTjNaL0J3UVZkTVlianZhNkRWSHpTMGlZai9tVFhT?=
 =?utf-8?B?YjdZT0JuTDFrcDBsVjZScFlOMUNjN0tqZWUwck14byt5SGlUTllGelN0U2ti?=
 =?utf-8?B?ZU9xZG0velVGUHBiUWl2eWgxQzJmN3BHdkVZNnE1eks1WWJhbDBJUmVGWHkz?=
 =?utf-8?B?cUZRU1kzZWRtYzlxY0I3UVJZc0l2Y0R6cGlGVU1HNkgwT0lLdmxZQmJmcVZU?=
 =?utf-8?B?Y1N5bytXVGRpUFVJK1ZlZkdnSGR5VHR6TWNLYmxWcXZuQTRVbC8zK2tISXRa?=
 =?utf-8?B?SzA1U056Q3dlWWNpZkV3WXlUNWRJaDk3aHdORkttWmNtQ0lWY0owNEh3T0Rk?=
 =?utf-8?B?MzBXRHhWR3M0bE44OVA2WnRxeU1XQXpEYnM5ak9zdmtER1lWN3k2cmdhWm5M?=
 =?utf-8?B?d01wVXptVFdVUzdTTm1vVVFTajJzK2pyQzAvWG01K3RBV25Tang4Qzh6R2xu?=
 =?utf-8?B?WmRqcTY5M3lCK1pLQjhVY3NkQVpVOEQ5QUxCaWpIeDRQUHZ2SGFXOGRVUi9B?=
 =?utf-8?B?bEZscXhFY3NSRVBXR0h1UG1VOWlBU2ppUlN3WUJFTzhqOEJzK0djOHdmRkZP?=
 =?utf-8?B?YVN6RFJqYm1rUTB4TnZWdDdkZVl2emFhdFdsUDBvcGo3UHJBdGRsWmhFVmlT?=
 =?utf-8?B?VStzT095MWh5ZXdpRnd0OVJOZHcvdDBKREdXV1BEU0R6THZOY1JjSk5VVEpK?=
 =?utf-8?B?WUN6ZXI1UEo2NUZObDBwTUpYNE5XdHhkOUduZDlIdCt3UTBXWFVxdExna0xM?=
 =?utf-8?B?TzZWQW1meDF3cXhCQUVrWkNaTng4V2NKVTVaN29LTzAzSjdTN2ZDTXVmUGJk?=
 =?utf-8?B?ZFp6VHU3MDVkdllzNDFySVNQVG9CcVBIYzJIUjZ3R2xnNHhRdWlmaHMrODhv?=
 =?utf-8?B?b2Y2cVFJSnVmRHZXUzM2ODNvcFdXeGFJejhTdU9pZm10WllmR2R3M0dxaVM5?=
 =?utf-8?B?YXlKVDNDWVR1anlRZnRIa0w3UXNXTkJSZTR1K2Zna0FUQWZrRFBYbER1a093?=
 =?utf-8?B?aEJHdmRNSlE5SDhTT2dtdzIrVVora3BDbVV5dEtBV2VjQ0I4MlFiVFNCeUZm?=
 =?utf-8?B?V1JESXlEeHVNYVBLbnAzTC9tMG5FRndMcmovM2ZFY3Z4WEtzM1JzUkJHK0Fq?=
 =?utf-8?B?aERNdjhOWVovZDQydk9Fc1lEWFRFSnRoY2NPWExBM2RUcEdLNlAzdEJFQ21l?=
 =?utf-8?B?dkV5YTN2ampvbXYzS3FoQlI0YTBIWEVKQmVmSG9QNVVqeENDaWZ6ZFlEQVJ1?=
 =?utf-8?B?dHk4VW4xTmh4K1ZuRDJEYTZvNUlzOG1OcThJekdtK3RzSU1PekxWSk5OZXQ3?=
 =?utf-8?B?UXlsMnVkMUsyUGhORm1qaG0vcUtuUStuZUlWOUFDSGpmQ1dXRUhSVmMyQTdM?=
 =?utf-8?B?QUlpck01aTJZeWJKMm9OMlBUZmoycVE2Ykg3SDJVTVIrV00rS2RPck9pSytJ?=
 =?utf-8?B?eXhxQVRWS1R0dEQva1JraDd1VXJIRVFXblZ1eTRUL3N1VmEwSVJJbW9UbmxL?=
 =?utf-8?B?WTdkQVdqNVN2MHpQdVZHb3B3Zi9VL3RrSmtlZVU5TE1rQVE5b0NuK0YzS1RS?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697988d5-c408-4bc9-6562-08dac3030934
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 10:05:03.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDnCcWlTi8+6eDfwxpNKk9svwMlEvXD69+Gm9CnUkWfDwX2aodpbMtmh80LctUMZgl7z/FviA9xP1DX+LKDsIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/11/2022 14:20, Kartik wrote:
> Tegra pre-silicon platforms do not have chip revisions. This makes the
> revision soc attribute meaningless on these platforms.
> 
> Instead, populate the revision soc attribute with
> "platform name + chip revision" for Silicon. For pre-silicon platforms
> populate it with "platform name" instead.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
> v2->v3
>   * Cosmetic Changes.
> v1->v2
>   * Updated commit message.
> 
>   drivers/soc/tegra/fuse/fuse-tegra.c    | 22 ++++++++++++++++++++--
>   drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
>   include/soc/tegra/fuse.h               | 15 +++++++++++++++
>   3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
> index ea25a1dcafc2..f02953f793e9 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -35,6 +35,19 @@ static const char *tegra_revision_name[TEGRA_REVISION_MAX] = {
>   	[TEGRA_REVISION_A04]     = "A04",
>   };
>   
> +static const char *tegra_platform_name[TEGRA_PLATFORM_MAX] = {
> +	[TEGRA_PLATFORM_SILICON]			= "Silicon",
> +	[TEGRA_PLATFORM_QT]				= "QT",
> +	[TEGRA_PLATFORM_SYSTEM_FPGA]			= "System FPGA",
> +	[TEGRA_PLATFORM_UNIT_FPGA]			= "Unit FPGA",
> +	[TEGRA_PLATFORM_ASIM_QT]			= "Asim QT",
> +	[TEGRA_PLATFORM_ASIM_LINSIM]			= "Asim Linsim",
> +	[TEGRA_PLATFORM_DSIM_ASIM_LINSIM]		= "Dsim Asim Linsim",
> +	[TEGRA_PLATFORM_VERIFICATION_SIMULATION]	= "Verification Simulation",
> +	[TEGRA_PLATFORM_VDK]				= "VDK",
> +	[TEGRA_PLATFORM_VSP]				= "VSP",
> +};
> +
>   static const struct of_device_id car_match[] __initconst = {
>   	{ .compatible = "nvidia,tegra20-car", },
>   	{ .compatible = "nvidia,tegra30-car", },
> @@ -370,8 +383,13 @@ struct device * __init tegra_soc_device_register(void)
>   		return NULL;
>   
>   	attr->family = kasprintf(GFP_KERNEL, "Tegra");
> -	attr->revision = kasprintf(GFP_KERNEL, "%s",
> -		tegra_revision_name[tegra_sku_info.revision]);
> +	if (tegra_is_silicon())
> +		attr->revision = kasprintf(GFP_KERNEL, "%s %s",
> +					   tegra_platform_name[tegra_sku_info.platform],
> +					   tegra_revision_name[tegra_sku_info.revision]);
> +	else
> +		attr->revision = kasprintf(GFP_KERNEL, "%s",
> +					   tegra_platform_name[tegra_sku_info.platform]);
>   	attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
>   	attr->custom_attr_group = fuse->soc->soc_attr_group;
>   
> diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> index 3351bd872ab2..4591c5bcb690 100644
> --- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
> +++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> @@ -156,6 +156,7 @@ void __init tegra_init_revision(void)
>   	}
>   
>   	tegra_sku_info.sku_id = tegra_fuse_read_early(FUSE_SKU_INFO);
> +	tegra_sku_info.platform = tegra_get_platform();
>   }
>   
>   void __init tegra_init_apbmisc(void)
> diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
> index 977c334136e9..a63de5da8124 100644
> --- a/include/soc/tegra/fuse.h
> +++ b/include/soc/tegra/fuse.h
> @@ -34,6 +34,20 @@ enum tegra_revision {
>   	TEGRA_REVISION_MAX,
>   };
>   
> +enum tegra_platform {
> +	TEGRA_PLATFORM_SILICON = 0,
> +	TEGRA_PLATFORM_QT,
> +	TEGRA_PLATFORM_SYSTEM_FPGA,
> +	TEGRA_PLATFORM_UNIT_FPGA,
> +	TEGRA_PLATFORM_ASIM_QT,
> +	TEGRA_PLATFORM_ASIM_LINSIM,
> +	TEGRA_PLATFORM_DSIM_ASIM_LINSIM,
> +	TEGRA_PLATFORM_VERIFICATION_SIMULATION,
> +	TEGRA_PLATFORM_VDK,
> +	TEGRA_PLATFORM_VSP,
> +	TEGRA_PLATFORM_MAX,
> +};
> +
>   struct tegra_sku_info {
>   	int sku_id;
>   	int cpu_process_id;
> @@ -47,6 +61,7 @@ struct tegra_sku_info {
>   	int gpu_speedo_id;
>   	int gpu_speedo_value;
>   	enum tegra_revision revision;
> +	enum tegra_platform platform;
>   };
>   
>   #ifdef CONFIG_ARCH_TEGRA

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
