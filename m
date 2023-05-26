Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6371255C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbjEZLT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjEZLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:19:48 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B6F7;
        Fri, 26 May 2023 04:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d82DftBHH0MqO/Cmx4pqMPUjnimBBCAIrp9kWn38vsi7XV+G6QT1yfxNh+lLGUKxzzk+bTJjN4S+0FKXwqg49QrcBl0JzqJb0Dc6qtlHWhoEK3jch5vX+ABUin6Ugwl3RlDLHHB8hP3a7KuKtPq7IL9KOVORc+9xh3alfhq4f4XzAjR9dBGJJhP9T+iCrs5vAGMsrC/Vacmwa8Z4lf4WhRqGw1sYvEdJOUcpWA2tAGTFzLkEn0qXt7Trx+Ll5Udl6CUcf5lZoVBocGGBWhX0EX+/fsVn1xY6kMioHNIQVfnWCC51ZRLflsdsOVz4SWx1CPeK5VHPkdqNBrEzaH8IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRPYT/v0djK+BFOAINzMPUUcaYvGGJzffUbeHGetqGI=;
 b=ci7kfKnCuX2OS4OoK+yg3AUWidSP+i6tvnTDqZPnd/IZYoHlt6+EEl5Oj1WV212jHR5gYnI4OsNpYEUtARBpLZuDiIOssW8+cYifbDI2Lf6NY8uOxGhHV2wTyWbchTL2B+3PXM5JH446Bg4Djb8RH55yZtEBroBCOxW97SPbp0LYlPg4JbegWd6BhV6KcpVHue/8top5TWjuEZdp1pk613MQ3P+kzOvpr7HccYRDDAQ/Rh46Q/iKwJcoGZkKNmNlH75WNDQXM2WCW7bxmVh5TKIWKxtYYVdsezTHHE/g+Tp8KazoYiBfUrqT0plxFT1sAf0qzwPFc2y7EBMyGqyppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRPYT/v0djK+BFOAINzMPUUcaYvGGJzffUbeHGetqGI=;
 b=PoHvtpnPYPh5wOk6YNvfKwTgzfy0xG87cgb9j0CF3eTdKckyh+gCX94/6Rafwu7dZmMr4B1fO9HD0psxTntcGyZ0BOufSoEtVzClervZe+ogvM3UVicy73ZISpCJTVp0jxD0/29tX9MYb1Kg4wp1vlaQHfvp7VnyDX2rQOFLWnSQ9gK165Z8EG/0XalW9Bxmu52vRc4ps/y62WpKUMISlRE/hT+a9yHNhOBxFRqcmlRplQZ8vBzZ0W5gPtqhsMC6wENikd6qMu2jJnBe9FTgTc8iGOlEJRL8nJgQQRMjYYbHnfnxGJGAQK1nyfUKKmTPpz3Lx+vH5+vIhAbfTuPdXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.17; Fri, 26 May 2023 11:19:44 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 11:19:44 +0000
Message-ID: <6dd9edcb-40cf-9873-b8aa-993bb18a3584@nvidia.com>
Date:   Fri, 26 May 2023 12:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: tegra: Fix PCIe regulator for Orin Jetson AGX
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230526111727.26058-1-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230526111727.26058-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0589.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcdadca-7a89-414b-8ef8-08db5ddb1b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2EMn8KfRZ877ulBBxTjx6ZI6tWrOAOlIYbGQB46FZZYCH6gXgUJbxwx75/24gF+1vbHXdv2T51dfp7RjXMmMFTdTDQPg7BvJlfu+JMhCm6SrqCUy+j8tKBRXBi4SplUTFS/eQIlAt+mduKOilaCilSsoqxUO+NbQNKRAnAJx5Fs49PwiNDiabp3oKcQr/RVo11fqt7Jm3i7A05Hgs0wagNxxP9X3q1MFdOzU0xl/VeY5xXZK2vpj2/jBjC9/1JopsM15D+Rluo7qFsOQHfstmGFOCiVGneE+4PTbT2Q9JD066tZVD1jyDWDirjQ7EM4HQbqCZNzkOuBgEgbKjFJW+gz9qQ+vJjhqwyp4ihRTB+gDZa24bdgPNGxve57QEnc+qXAjo/Sce8M2lD03EM/KPQbEjMrxAOPm2UHusyVXeSUlP1VxHAS/4jSdP44yBkQD167UWizVAuchoYt/rhSxaNxne2bVGD44OLpQKufKnmo56j1dF4dWOrFrknTBsC3Y0LluUxRLGOEJCfcHms6lHUBG8SIpzNZlGSjhkW9ekILAhy81IChoEwJMDAqgRPB701Bnlql3CZewdo3/3atJs8jk//Fr6A6N0b+1dCCVoU6kAsfP6VPGVyXAMFwXLP5AitNmlkW4HYksStd+H7Ozg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(38100700002)(53546011)(2616005)(6512007)(6506007)(83380400001)(186003)(478600001)(6666004)(2906002)(86362001)(31696002)(6486002)(110136005)(4326008)(36756003)(66476007)(66556008)(66946007)(41300700001)(316002)(31686004)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JKZ2t3YjkrVGI0RTd6bk5JZEZ6aFdHbzBvSVFnaUd2cXozTkUyY2p5VTAz?=
 =?utf-8?B?ZzlOazRjcUM4R0c5clV6ZlpRNy9kVm1lV09YNzB6ellsNThIT1VmbEhVdC81?=
 =?utf-8?B?OFFTejJFclovcitxUEgvZkNQYUxuVUlsQ2R2c01FYkd6OW1ubW9wcHhBcnJB?=
 =?utf-8?B?VlUyWlFvS2hXTmVZSU9idVhsU1doMi9reElFNUxMVTVDbXNmYVIvQWhZVHQr?=
 =?utf-8?B?OWhjTmtQV1VCbG5ZYkVRMWxIQlNTVnBGeVhIR05aczRoWUM5QWFFZXZTM3Iw?=
 =?utf-8?B?aGZKclNCTnp2UTVmU25UZkIyZmt5cUkzT3dwaWYwTE02UGw4aXhTK1JuRlIy?=
 =?utf-8?B?T2F2cVVyRWY1cmZIeTduMmhPQmhIYXlMRmRVbmJiU2JLNzhFdDN0WTdYdloz?=
 =?utf-8?B?K0w5T3hSMlVkaHFUQ2ErUXZPNFZqVFlZb2dOeE5nVUwxdFpmbGJvOE9uR3ZH?=
 =?utf-8?B?Y29uanB5L2dZZUg3RHZEZER5UHFCanJ5VWs2MzJha1NZWUM1b0NvWUJHVkFh?=
 =?utf-8?B?TUtFeUxrSDNpOGFCSzAzMlVyWjRMSHFYZDByT25ucE41ajlSSDlVTkZBUUkv?=
 =?utf-8?B?ZUdzcTIrTHQwdnZKTndxK2RIOHdaODlBUG9POUVpMy9Zb0NqL3pIZzRUS2w1?=
 =?utf-8?B?MXpFUmtIWWgrd1ZOTEFSTmdnR0NNclR2S1BoOWpHZDg3L1RUMXI1VTZXNlEx?=
 =?utf-8?B?eTROc0JVcXRoMEtBVzJaVkpvVmlXVU1POVVGU0REVFhhTS9aaC95THFBYk04?=
 =?utf-8?B?SWhuUjFTYm5iT1NyR2VqN042dHpWL1J1OWx4QSt5alREWUlRam9Oajh2aU9I?=
 =?utf-8?B?enRrMVhqbWdHQ0tOUWRnYStCckNSeE54OVluV3FDbDRCdHhLZmhJQ3prc3oz?=
 =?utf-8?B?c0xpN1d3dGQ4MXVuWUVoQUtQOG9zUWlFZDIyUC9sT1dOTTdEK0tsMm1hTFAz?=
 =?utf-8?B?ekgrMElncDNtWU91MmZMZ2xUdFN5ZjN5TjB2ek1JTTZ6ZEI4MFg2U2ExQUtp?=
 =?utf-8?B?ZTNaMWg4NmpMbURIUXBhbTlpSWZib2lZWXNESXFwU0FNWE55M2I0bFVQRmdr?=
 =?utf-8?B?M1NSWi9MSTkzZUw1QUZuRmFLSmkvVFRjeU83U3dwRndDdmU2aU5peVdYRHhI?=
 =?utf-8?B?eURLUDZmOHcvcTR0bk8wWFN0MkpVNlFpQTAxSHQyY3JJb0FHM1RTNWQ3VFV0?=
 =?utf-8?B?SnBUcEdwOGVHUHZMRFoyeGpHbC96ZmQzUDdIRGxtaVl5eERJYkNrTW9mRVI1?=
 =?utf-8?B?TFMweThyMUFLS1dQSlU5ci8rTWM4NUZEYUljM1V4TjBkTXFkeVo4Yk1ydFpP?=
 =?utf-8?B?UytxbVArMVphck1pbC9ML2lkTHZQT3h1Um83b0g4SW1sMUFpUTNodUhlcUhL?=
 =?utf-8?B?N3oxUy9ZVGZZZ0RSb1U2cGVmNVMrUCt1aFpJZ2xDTHFuTHVScitnV052N1Va?=
 =?utf-8?B?N0doa2ZSQVRmaHYxelNid1A2K0VwY2ZBQ1JhazY0NHdqOW0yRE1GSVBiVjd4?=
 =?utf-8?B?UlBWUlJBTVlCSmtQMnk5MkUwdmxoLzVsT0MyaFpNVFA4OWpKcE5pV2lGbC9T?=
 =?utf-8?B?S1dUSEl3eXNIR0JFSG9uSWV4SW8yVFZsWE83bWxxdWNXdVE2SXh4bjJrcTFC?=
 =?utf-8?B?RmJhS0FwRGZMUkRWNVBnbzlTY2g0TDVYSXI4R01kM2hyczFCeTZrRmJPeW96?=
 =?utf-8?B?MXI1RVo1NmVDQWVMaGcyNUNBaEFydUFtUmhHT1UvaGZUUE5zK1hRdWVhQVpk?=
 =?utf-8?B?NGxDQnNaWHZ6TFVRSGIzamRrc21ZVzg5OVVQNzRpUEVwcy90MStkZmYxRVp3?=
 =?utf-8?B?K2NqMkJwVnZVanhUUmlVd05ZQkRPMWFpMCtSRjNLT3FDenRqaEpnWDNxT2k5?=
 =?utf-8?B?dVo2WW04SXBSWTFXWXFqOGpCRUFsNUpkMndzbTJMV0l6SE4zaDRWVlVEanZy?=
 =?utf-8?B?T0FTbUdVdGFEejJ5dEVKYnYrckViTWJNaEkyNFhiTVJFWStWdmx5TEkwZXc0?=
 =?utf-8?B?REpDNjJXNHVBWkE3RVVtVld3Z1l0dDg2YmZqcU12cWtWblZ1ZUVNNThBOHUz?=
 =?utf-8?B?ckFta2dvV09kWW1VTVZSQjkxWVBBc01YZm01c21wS3M1VDZJbzkya1Q1aWxU?=
 =?utf-8?B?R296WEZwYVF6N0hPUWVZQ0dHTlZkLzZIVUg3ZTI1Z1ZsYVVYYmNzMzNZcm45?=
 =?utf-8?B?bVNNQjZCcUF3aFRDYkp4WUx1OVRXOFBCOHphbE1ZdVZRYnlGOTVEMnhvclIx?=
 =?utf-8?B?bnUrbURsb1pKMTFYWmN2S2dXeG5BPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcdadca-7a89-414b-8ef8-08db5ddb1b85
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 11:19:44.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAuW24gOpJZ5kPZxFXoT74433d/NWK3B7rNyoKQPMk+2q1tVmHTeHE0DefJzzkE62O1rpblS+0CGMsVy6Ogbgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding linux-tegra ...

On 26/05/2023 12:17, Jon Hunter wrote:
> The PCIe slot on the Jetson Orin AGX is not working and PCIe cards
> are not detected. The regulator for the 3.3V regulator for the PCIe is
> using the wrong GPIO for turning on the regulator. Fix this by updating
> the 3.3V regulator to use the correct GPIO.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> index e161618cfca8..4dce2e214002 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> @@ -142,7 +142,7 @@ vdd_3v3_pcie: regulator-vdd-3v3-pcie {
>   		regulator-name = "VDD_3V3_PCIE";
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
> -		gpio = <&gpio TEGRA234_MAIN_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
> +		gpio = <&gpio TEGRA234_MAIN_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
>   		regulator-boot-on;
>   		enable-active-high;
>   	};

-- 
nvpublic
