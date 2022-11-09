Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1F622912
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiKIKwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKIKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:51:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F7E51;
        Wed,  9 Nov 2022 02:51:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFmn6xZiXn4VcSsYTway5GY3Ea52r5ppgGV0ILZ8VonM132EZyAv964ZGr+sIGcWrV1N8aI8RwjcteofHNvkml9DCzVda4HhFZmyY/eK8neT6Fath8p2VzJOWlR/5JNES4aW69esjE9vfShS65Dq/42GBK4lmDzGNwZywhjCOZNDwYVAINf61N7dHbQ0g9HwwMRAZYTBeUE8UuJwzLlY/YNDcBPsZBzraUk4cpHl/+vVyppsqGBFDCarp63cJ9+dtr2wVt4w3ktMKpaPyIxaUCVB0dHHwFEOxlfx6M9vDRnzfy9ombX601OFObNHUCof0E6TkXT5v4zlZLRg6vmD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VusasGkpp8A4XsAHVL6QJ1WPApCAx15lhKcEyqyTJ6M=;
 b=IjCC+iiXm9r+bwWXlU34E+0lqju0EOQs7sEPucZsmJH23kmSpBFyfk6IP46215FbSVM06TcvjGOdjvelDWUn3Rq0MHWCrevVq16RmFjAzQ6K6VWBFGVm8jyR4Vi6exAoZ7G+Zt73SPdYLV7m9uGY0hCBXPU4XrYiG8jog5zMbHvlk9m/kt6PTFBQxteIXtMDt/xOdLzjf9rirWINTZwDyG8KBgsVu9mnflYrJDbsTCAXn1IiqGeIjraJAMMMhWVcpGWdYzf0OV6ENATO6CBD+gjXv/2E2kH3y1GMoYzyGrAeO1aIja0Cz1YkytomLOjK3xuRk7ZVed4QqjwHbuZjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VusasGkpp8A4XsAHVL6QJ1WPApCAx15lhKcEyqyTJ6M=;
 b=YLaRDuuLCa/d9AddlTcnRp4D/ojfBoBC0TFPS3bJbHrDCx7Dzhqs1Fs7rzzL0kNQzFOu6rSHIGskI1wW7Ov/pvRDLnAh/m64iE7tBoFF3QI8noVVqQxTKsybyB8xAxRkezTfV0pEUMaIkyd2/koXI36IR3E+h3QU2dH827mpCzAnTkR61TV5XlGA8Yf4ZBaTU1XH9xsItvxdjlRmzQ/mtkE/6iiOCoKcGzul/mVrOdowqOmwbTxvaUDfNkIRb8odSfKbFhIgJHJ3nD+LO1wnG5745Z1Gv6qNohCM6T5g7Y8vNXHwIsqaZCc4CKwB2nc9IxiqPupr9umRMfxMLJPsHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 10:51:45 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960%5]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 10:51:45 +0000
Message-ID: <62cc53ae-a615-e138-e22c-fe3a4018efde@nvidia.com>
Date:   Wed, 9 Nov 2022 10:51:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] soc/tegra: fuse: use platform info with soc revision
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, thierry.reding@gmail.com,
        digetx@gmail.com, ndesaulniers@google.com, ulf.hansson@linaro.org,
        arnd@arndb.de, skamble@nvidia.com, windhl@126.com,
        sumitg@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1667975179-11136-1-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1667975179-11136-1-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::32) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ad4ddc-9eaa-4ecd-c194-08dac240650c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFPiHVN1SfTijTb/5REUDkRUq/PkrgCf6RSI2Q02GEkVtzbRmSWAnfAE3JscrhaZ4plqX8lliOlDlCxMOsPY6kJFuIoQSURM9BowG4Ez3IaIocpIBBwIajxnv6gMwYx38fxPebbEqPjqFfK6wpdDUw4DdUm/CIKk2EJWdcOoGdwd+hJ2byfLpD8PecjlNavv7c28X0qzC5w2OJQQT4UsBqAZUAnkkHP6c8MsseEZCDrXAw5LSU21xdZ8r1CfRzJOr82bQxpBgifphDeeVd45IlrR2DORp+PVcAxuCFM85zIWQ+olpi0BZS4ZpicVrwvpYN56IiTkStLlnu4zJVfPNeaWcLDGTMotj6Jfe1Z3drIH1j1jzyFMzOhzTFkRu0rFWQECH7iWiIcK5WpRm6IYHGmeisj/iaLTbeTeYBrB4VKRhtyVUkYJ3CLOnOfXIQ05JNLz8R++Wwj1ym5T/J6bf+oihmP1oaNHD4+ObDP1GHnReC9b38sUVXub7ofxOT223xPJ6uPskCUs4xEYxT2MAuJodfKOptKxC+yeQA8//kzN0m1CyJXyBcsXTGp6XdUHVCyPNolvmFGMtdCXoKNMhbTt3ZKlGPaK5ExHUS9YS9fpDv1JzLEKOWOAy6Kt7yLGOhfEiUaDgYGZ2q9Yq2Vb14TzidOvSqv8mboTBhwKzG6pFZ+vBHuqC1Vts7Zl18Mn7yOYTC5YUq2E/FWpmd8ehPdDmNgQ1oIoUy6w/2axHZa1Zb1ZLPlkJS0NdBLBV9h8ulhYS4kz8yPq0/JimHzIUrt54lN/YFgt2+YxVrwLn32h9wPi0zTuHFMEF1UIlokz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(6486002)(478600001)(31686004)(6666004)(921005)(83380400001)(2906002)(53546011)(5660300002)(316002)(6506007)(186003)(31696002)(38100700002)(8676002)(2616005)(8936002)(66946007)(66476007)(66556008)(36756003)(86362001)(6512007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU93MEQxL2hDb0pCazRQL09OcHhUUmFoU0FIUGxIajZNVUpOcUFKdGpQY1BI?=
 =?utf-8?B?QTdNYXBlZjB6TjRRTnpkODFRSXdWMnVqVWxNNWFHVSs3ZHFhZkNEUHlYaUxr?=
 =?utf-8?B?VXh6UE9SN2xlWjdmc3Qyak1RQkxDNGxrK3pGZkhrWE5OUWRtMnRlSlEwODF0?=
 =?utf-8?B?TERmNmJHMFNDNEdoaGVKVittQmUxaTc1UE5ZS053Y0ZVNFZwdk9uMEI3aStv?=
 =?utf-8?B?UnBEY2RKTXR1QmxFNlBoeC9RTE1wNkhoMlpVWmF1VHlFS0d5aFN2VllZcUJq?=
 =?utf-8?B?d2V2MlQ3VzNrS2hvc0s4UWZTTHRSWkF2R01NNnJjZGl1dG5lUkhuWHNoWmV3?=
 =?utf-8?B?Qi8vWlNCTlJoYTlZSXd3M2Q5dll5M2VSVFZRb2xMK000R1ByZkxlN0tkTk53?=
 =?utf-8?B?emVRbTlCTHMyVERHKzMvRU1nN2FJbzNSakhNS3JHWTV3Zm94TzFuSExsZnY5?=
 =?utf-8?B?aExJeWx1M1NQTFR4VDdmY2kwdEE3MXp2cFY1WXhIWEFqQ21nWGx0V2F1bFo2?=
 =?utf-8?B?RXNCejlvbzVveE1qK1dobW1uYXYrS2Iwa0Rlb2s1UXgzTHRWSDRFR3JSdW5X?=
 =?utf-8?B?dE1HcExLOE5GVG9rVTl1YTl4SWpZcmp1c1hHbTl4RmdHU0NBelJXeE9OSlB6?=
 =?utf-8?B?cGh1TjcxbW1qeGRyRTMzTkhpVlNBeDhsWmJVeC9GVVVEMkcreFcrcGM2di9I?=
 =?utf-8?B?a25zWkxpQThHVGJPalZZc1FNYXF0cFNTTC8yWXNYNCtRWWxRcm1nU2p4ZzN6?=
 =?utf-8?B?NHNUZ0ZqVDdoblJxVnJTUEFEY3p4UGJ0RytOWDV0SDhNRkRUTEtoYzc4YVVW?=
 =?utf-8?B?RTEzeXJ0QktCcUZ6R0U3dFlSWlZUbGVKV0ZKVVhuK3NUT3B3SmcvbWlaR1dq?=
 =?utf-8?B?MktwUGhsa0d6UzJ1NW9udkZKKzdMRmR4V21jUVM1OHlQeWFiZ09SbW9hNzBX?=
 =?utf-8?B?eGl2ai9hVXhSMW51aXFWSndGRUE0UEQwM1dKem5EK2dZa01IUm9XWDVWTzJS?=
 =?utf-8?B?Sk5GcjFmaFpQTTJ4L20rbnB6ZlM3ZVBFanF6d3ZlMFdHZUF1NHllTmlZTDF2?=
 =?utf-8?B?eUlreTg1VmVBV1psaXU1RzJXTVBqNWdMU2NCU01PeDZ1WVJUaC9ld0JmZWJL?=
 =?utf-8?B?b041Z3JYcnJKVGxnQTV1enhGTXVhK1NRNGVWaXVEUWgweUM4YVgvc3JycEUx?=
 =?utf-8?B?MUpzTlZBWktXWmVDelljNWU2ZURTT3lGdVMwaWprQUlXcytpZDVseHpETzFa?=
 =?utf-8?B?ZndrdXlKM0FwWkxYQlhneWRuRTY1MlRDYmsxdDhBcDh5NUVjVUpQZUl1Qk50?=
 =?utf-8?B?REJ4QnRFTWlPSXhBZW5EenVYbnk5eDM1S2c3MVhXa0NBbEZ4SWptdjhqUjlO?=
 =?utf-8?B?WUo5ellxQ2RSc0tsb1dqUXcxS0R3QkRQZDBQbjg2M0FFREppaU9LbTNWcmpR?=
 =?utf-8?B?UEp4ZzQzU05URVJzWTY4cHpLeGpYcUNFNDF4Rk5ZL3dJZ3VxemxnMkJNTkRV?=
 =?utf-8?B?bWZQWG5MRys1VlhDbjFOa2RORWQ0N3Njd0xMK1RkWmNGMW9XazRoOTFOV3c2?=
 =?utf-8?B?SmZ1TWFDOWZqbUxUMFpLQ2MvckM3MFViaGgxVFUyM045ZGJ1MWRkNTQxTTF3?=
 =?utf-8?B?MnRZbXN6aHlZRFdIbkt3cXlKZjVuVE4rUzlrbnlIQTZPMWpBNCtRMlhhTVR6?=
 =?utf-8?B?aWRQcHU0UHpIY2ZnUWx6ajJjSzNNTXczMkpianBsNmpwNEsyd3BQcEtTOE5o?=
 =?utf-8?B?VEIrYzFwWlo4ZUIzSFFoMi9kNVJCdkFBMVh6WWUvekNLalp6aFdVeVB3Z3hQ?=
 =?utf-8?B?NUxRbDFYcGYzWGFXbmpISXFJVkd6cFR4cS9oemFUSDNlcmRmVkNPTXhWVE5Z?=
 =?utf-8?B?bzBERDM4Q3c3b3pmSTVldSt0RWFsWjh5N1c4Z1Z4U1puQzE1WVpVUC9hd211?=
 =?utf-8?B?amF2TlRyL3pxL0RDVE4wNnIzaFBXS2ZhcWJ5OWV0WjUrcGFvL0JtVUNlOUtt?=
 =?utf-8?B?djhQcXN0NmRPSTJ0eEdrcUJEYTI3SHh3c29Ba09EaFE4LzdHZUF5dUs0b1Qv?=
 =?utf-8?B?MlY2NWI5ZSt3bnlpajgreFhQN1Y2S3JLdjdSNnd5QVY3SWk2MmVrcG1RanMz?=
 =?utf-8?B?WUhZL1dFUkh5RlFTaHNUWktlU0dVeCtrM1BIQzNjdnY2N3JNeG9PMUpxYWp2?=
 =?utf-8?B?OWsraHJxL2Ztc3kydXg2M3M2aDNTcmh3VU42dGd4OU5SOGJJbGc3RXo1ejhl?=
 =?utf-8?B?Q0ttZ1pRVFdYNmZaalVuMk1vakhRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ad4ddc-9eaa-4ecd-c194-08dac240650c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:51:45.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cylo4AndTkl8KiFzEan0XXE0oWkqx4+O7bgbGXpXiev5/fBa4vDI+NxUQtfKH73C05ME03L9LH9wE416aqiO4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2022 06:26, Kartik wrote:
> Tegra pre-silicon platforms do not have chip revisions. This makes the
> revision soc attribute meaningless on these platforms.
> 
> Instead, populate the revision soc attribute with
> "platform name + chip revision" for Silicon. For pre-silicon platforms
> populate it with "platform name" instead.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
> v1->v2:
>   * Updated commit message.
> 
>   drivers/soc/tegra/fuse/fuse-tegra.c    | 23 +++++++++++++++++++++--
>   drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
>   include/soc/tegra/fuse.h               | 15 +++++++++++++++
>   3 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
> index ea25a1dcafc2..a20c9e0105dc 100644
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
> @@ -370,8 +383,14 @@ struct device * __init tegra_soc_device_register(void)
>   		return NULL;
>   
>   	attr->family = kasprintf(GFP_KERNEL, "Tegra");
> -	attr->revision = kasprintf(GFP_KERNEL, "%s",
> -		tegra_revision_name[tegra_sku_info.revision]);
> +	if (tegra_is_silicon()) {

curly braces are not needed.

> +		attr->revision = kasprintf(GFP_KERNEL, "%s %s",
> +					   tegra_platform_name[tegra_sku_info.platform],

Do we need to include platform here? Can't we just print the revision?

> +					   tegra_revision_name[tegra_sku_info.revision]);
> +	} else {
> +		attr->revision = kasprintf(GFP_KERNEL, "%s",
> +					   tegra_platform_name[tegra_sku_info.platform]);
> +	}
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

-- 
nvpublic
