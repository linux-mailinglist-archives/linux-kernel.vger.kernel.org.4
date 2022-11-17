Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140DC62D226
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiKQEKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiKQEKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:10:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B723E09C;
        Wed, 16 Nov 2022 20:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkkIUCcWVOXlxxax637TPklhvbpEiQXIpyL/Emv08Faz9a2ZuQxqOqcm+zMwaoWGJx1zPGq55tWeKNMtPaAOlX1xxmw5WefMhra65gNSUcg3MqwXmQDCees/iYhVoS7G+/w6BAQqc3mf/kCf/TSf8IvyRjPmm9R6cMaZ5zGXF0ItckBEgJX9md4PqmoPs1/SEryuJW8ExsyYOyxbZ1xSBt/MQi/u9TFwA5KttwwTPl3OIpS8ctvbzeCeraA77g5hNyYAWtsJdqXZ4D8EzxmS7h4g4TpzNUnHJ78/ihNOnjq8mbhHU6sapyHz6ZC9AziQbsSurMewI9dRtkmGB7gdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vZzKQyMjGB5vcJSzcDh2XO1YiDuuIwJSYE1L9aEgSQ=;
 b=HpYun8fj1xbyWsMU29YyMZg93GYDTSMdQAFtlzGxOr2Yjdf8BUNxNhPrJxu1ZWAU2IdKSug6YfkjavNUmY9CC1H9goV0W0irOyZRWeBQrdsWn1/09TBaizQJsRUFBoxOO966Yz2jFfBCzlqGSl5my71AKHa6SRc1YYdstl2aH4eXaIaL9EPvwgo7k+4PUe10AWh83rA65rIyPWjuQep/4MqhZ2YO5vZ+ZTXJB5PX1+YfKDOQeN3c3+2ErzX9nsE1dOqSLALgcU2n0jIvlNa4H4K3raYdH3gG79KdZzJO5nUjdZDuL9jlOlQs+/qOJyx7aN1QvXDBGfwILpVnmTf2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vZzKQyMjGB5vcJSzcDh2XO1YiDuuIwJSYE1L9aEgSQ=;
 b=5G8SIFnzWM3jx3s/AEAtW7Kiir1dX2ZKS05NvIb3+dxYKoTWhp1THZlUn+WT6/4YmGf1xmDU31y85KcTG1nPkPAm/L14QUgMSIbEDR37i6P8fk0Q/ScZ1L/0to5XGZAnAphScGZjddKr3Mwr/YrvlvTz+BlrASEQtcr5y0KZA2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Thu, 17 Nov 2022 04:10:03 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::b1df:1303:4c2:b96b]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::b1df:1303:4c2:b96b%2]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 04:10:03 +0000
Date:   Thu, 17 Nov 2022 09:39:51 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, wyes.karny@amd.com, ananth.narayan@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cpufreq: amd-pstate: change amd-pstate driver to be
 built-in type
Message-ID: <Y3W0D/5wSF0ynY77@BLR-5CG11610CF.amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-3-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117024955.3319484-3-Perry.Yuan@amd.com>
X-ClientProxiedBy: PN2PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::6) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e25cf08-46e5-4270-bbf6-08dac8519a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du5hkJmd7vJQN3tOCeIqI20rC04DYoNMTYaIyxbdtDNJzdntWfPAa01fnUkxf9Q5HoqmVACWajfSfSRteJP8hAK+l3mjI+7V1EXn2CnnPA4/S2Qqlx3rxOv5ojvyc23SQIqEUrI+DiGqsa3M8oCFVP+wuwv6GAqLWfMSuL+y1UvlKAO8yyzFVT0hMlv1S93gaFWY7kozA2bBUsFv0KRwgMzw1XHt0APX4unZoa9ldMGnAAIS84TxpzUs17vFBFnI5CHLE2KXNgIrxHUovWS2Gkslbl6DPlFB8sFWSFHRpg33OgnmpQ6RATfcXkwJOK+mbNluBegHWNA2FlvpCg0+IlibtAw8h8UMUVbV5FpSjaxw+nfbIAfKvzW120LX2COZdOG1ZaTNy99M5nGno4oV1Y67MqT/+rY2hSPtmJiswOvczqG9QZDDlQFygskHQ7ydqIpYqQ3DQ/0sAmMOxOAj14uWqOYvUpzyopkVnSX34UFicTUUtQiKh8HCuZCTpr8dP5RvVC9sfxRf1+RimURAxzfkZslJVtj4381R+cV00nMFrpz4f9w2EyoBog9SiIqkzZTXi5/+m8QZRgpnMTWeIyWnykfo/kfDkoNVV4gWDWAB+KD3r7kmWLU0v/16pv0XbJZM8bKgd8lFlHfHqQf9Th6pp2m0a5junBlX73uiCJJ8I+fM6s5/a+s1JSVM/lUhVDSAqdfeTr7/7EVx/5SGWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(86362001)(38100700002)(6666004)(6512007)(66946007)(26005)(6636002)(6506007)(316002)(66476007)(478600001)(2906002)(66556008)(83380400001)(6486002)(41300700001)(4326008)(8676002)(186003)(6862004)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJvuTszVy/A6cVFRVdAo1A0/6Dh8lKEhvyBQhjlqcGcGi3rCcV9KpIi4mUAX?=
 =?us-ascii?Q?hrSexFrBXelzXZld4GaMmMonV4+maKOVVh0RxOJ3NIZTAHN3mhF8HYi16nl8?=
 =?us-ascii?Q?uIygCJe4W6DB7VkPzV8UmQTlX80C1h18ddETMAlTiQ3W/ZMYc/JT6iT3cn0+?=
 =?us-ascii?Q?ZPDtibJsP1b9zqefgr3SkR4MwDsvs1GNwceCBLWnGaMBBrCr9wzfQQXbJFEH?=
 =?us-ascii?Q?yS8ZmHf2koWxamKrM5ytz65GSLupEFsxfd7e/in4HM8t6s8/9smJykDOAlXy?=
 =?us-ascii?Q?M8/taLjfZar1v3r2ivY73FZOE0vCPNfOemsjoR7jRyGJpd1bRtS4vaJpH6oK?=
 =?us-ascii?Q?2880DXXTn2xffKU6d2qe1dLZKeU/gByY1NUY43G5VjSitUsnfYQuySpGiaiD?=
 =?us-ascii?Q?sbt4eXW0LYVNbn83A5hIt0AUhDplhJriAsaR56Cw/AiTvWGbpOgcDpoANuEz?=
 =?us-ascii?Q?A6LJM3NIeswQg3NVpzyVsD7SrRHmcsFtj6Iz+AoH6P49OpMmvNLLjfl83gg+?=
 =?us-ascii?Q?has+B9UILbd4AE8+4gLf/jbGRbHZNpJyFpsCDdeVAaPVR5YqPBCKGuhlEOGf?=
 =?us-ascii?Q?f7NPIDpB8dRJfS6wz/AlN66H5OxiLBzk76c7jWwmWvDBqiwVZl6/FU1OzR08?=
 =?us-ascii?Q?g6ZNypEmXwslxbb5p+wkBNTukECSJAmHzNY5wKi/lcC7d4pTYM8PkmmmDLWH?=
 =?us-ascii?Q?+dr0iT1oz9N0yaxme2HqtymYr4JbGuS2EY53rmI3RNvDBTLm0EaTuoV1znoO?=
 =?us-ascii?Q?HQ0C+hTl2Jss4g3F/ckTZLz7H37w9xaFWyXehLNwReFw3pkZR7mlCdpyin7F?=
 =?us-ascii?Q?ul0/44MqN1+tWgphA8UeBqDDsqtgI2zxupWmTbUKZSAISOROKwMosUGff5Jc?=
 =?us-ascii?Q?J0KFNWQUznU7IXOylK66EqBFTWC8tc/k94jzGwUu32gVcX1lrvM9K8jKNPWa?=
 =?us-ascii?Q?NCRjA6iNi0XIDcpl5nUVIGTiVUb0jhHDACj2eu3/xQUDPCnTdl0NF0CZ1LnP?=
 =?us-ascii?Q?Z0cK8kfQYPRsiL0kKTpX0RU0xtg4P+bH3uqxu1L4hxshr69oGrpfye/vhYOA?=
 =?us-ascii?Q?yXht8TgJUbw8x/8VB7Q0ykz3tcUCIAO77hcYZRMwQ70FU0uTwJT8FS3Upa9l?=
 =?us-ascii?Q?iA72UbVp2npxrzfyRYorxiY9QlCN2Ix/R/F8lAQ2fuWeu7e0XV0uA9YvaaZ7?=
 =?us-ascii?Q?AUufXeRbJHDlYmOgK1mLhFp+71tpnMvXjTF9YXsH7PsrUyeG1ogIrZDYm7PI?=
 =?us-ascii?Q?gW+BoS1QB/4tnVXzJu9Q5iUtpSG7IJu/qJ+JtMEiDsrlkGgZiZ9WkqtaMvJz?=
 =?us-ascii?Q?oFIHhPlsBP7ryD/a7UWceYWk8qfk8nBgB/q9JJCA0+otKNY9DggaOiGMC0Pl?=
 =?us-ascii?Q?ak6FNXPktEY/NOep4XctBLFzvosGMh/VMJhcKkPIu9M6Y+Bo7x++XupQxvPj?=
 =?us-ascii?Q?DTHACVUF0ED9ZrfwvCJiZ9ESTveH/SaILBHxaJfLN7V/1FjeoznYGwvZsMqX?=
 =?us-ascii?Q?hcUAqA6/x1hhyJanv2at6z659rmZBMm6FqYTDdOtkAqASAPM35QRQUEDJfIj?=
 =?us-ascii?Q?ixbTocBapsclAc6rV9w3koXlUuTOCJV5HimBKPlC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e25cf08-46e5-4270-bbf6-08dac8519a3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 04:10:03.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYXwNWWWsloeFG41MltIaqypQT0sM1hxhbD5E+mtfv7VKMkWhJEOrWHy/9v2XH2SnFuruJGOqxVLrp1396u8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:49:52AM +0800, Perry Yuan wrote:
> Currently when the amd-pstate and acpi_cpufreq are both built into
> kernel as module driver, amd-pstate will not be loaded by default
> in this case.
> 
> Change amd-pstate driver as built-in type, it will resolve the loading
> sequence problem to allow user to make amd-pstate driver as the default
> cpufreq scaling driver.
> 
> Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/Kconfig.x86  |  2 +-
>  drivers/cpufreq/amd-pstate.c | 11 +----------
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 310779b07daf..00476e94db90 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -35,7 +35,7 @@ config X86_PCC_CPUFREQ
>  	  If in doubt, say N.
>  
>  config X86_AMD_PSTATE
> -	tristate "AMD Processor P-State driver"
> +	bool "AMD Processor P-State driver"
>  	depends on X86 && ACPI
>  	select ACPI_PROCESSOR
>  	select ACPI_CPPC_LIB if X86_64
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d844c6f97caf..701f49d6d240 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -663,16 +663,7 @@ static int __init amd_pstate_init(void)
>  
>  	return ret;
>  }
> -
> -static void __exit amd_pstate_exit(void)
> -{
> -	cpufreq_unregister_driver(&amd_pstate_driver);
> -
> -	amd_pstate_enable(false);
> -}
> -
> -module_init(amd_pstate_init);
> -module_exit(amd_pstate_exit);
> +device_initcall(amd_pstate_init);
>  
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> -- 
> 2.25.1
> 
