Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009A0736FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjFTPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjFTPDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:03:45 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA02114;
        Tue, 20 Jun 2023 08:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdnSwJr482dg69QDl90Xw6qfm79oDZs+4xOkpkO+DpS+zgxguazDeLs4jWHDOa37VwD3Jjlm+uAbC8m63GQa0vOzdtV4E7mFdbdAauIhhlae7DOWOodtuZW+h9uxT8GqISpjDEky2KIk/CzsN4IUKcoOsgg5X3oNSs3HyTkSluM1EiNF3Tt6Mi10xPglses6tyUvRd1y3sb8Hkho0S18PzOWfkRnrbXerOCn5Bsw2Nd3Msiht8YaiviJkub7WMIfQt/+nkKuvI78hprXjUEGyValfFPPYLlcBUk+nE/DvFWe3aqlTta+3/3Bvu5ZzfNyeosjC9N7dhMC2sa3zkKUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgxgF1XOPQXKA0f/X6EiLhAyyuPE+fg4nq8zUN4j6UI=;
 b=Q4IivHblSwAR2lrzvG7eCW5riNZXhILQxEH8V4zCohCwvkM+eZ89/XC0gWBjfXb5bisHsH+A0ubcIPH1At9p49ecCUoJgqlbakmWXniIuS4ZCyt+8b1GwGO+uQu1qbtMZR3DiV38CoxcQpu64fLNS2XlTr4wqato5dOUXAOOPE/mWh5qONYAAvydL4QDtlE7rRt4gObIBexWLJ2Y+t96NCXQh1SbEvVIDk/2E6N56sXYj6JxGF0TrkPv4FcpD7qh9D4c9KMR9G4J/a4wqdz7zOwJGAvgZqm1m+huzv77GRRZol9U80vn6usWDP4/YQHrvVZcq9ofMinTmEiK1NRg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgxgF1XOPQXKA0f/X6EiLhAyyuPE+fg4nq8zUN4j6UI=;
 b=i0BXkSUBSHpGQqEHP1VoNRzGDDDR6kwzsT3PY4sjJXFnxehFiyabxSSh8IkqMqQZn6iP63G5mqXIN89wQxyucXj1Gx0tKyuqovU6cZn8WojtBYdD/sLT07nLwn2E/L2s8mcRYxGDgfjkjS/wIk2hxZ3X7vHggILV4HWSojW8fjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Tue, 20 Jun 2023 15:02:44 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 15:02:44 +0000
Date:   Tue, 20 Jun 2023 23:02:20 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cpufreq: amd-pstate: Add a kernel config option
 to set default mode
Message-ID: <ZJG/fGLWmRlyXz4a@amd.com>
References: <20230615063300.4030172-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615063300.4030172-1-perry.yuan@amd.com>
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aae2305-c1e4-4af2-a735-08db719f671e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmPzRTkKk/J/LHg7ZlZ9O2urtP4+i9cBRysrs/wVkoe9pMchyKaKlf/qFipyLJnQ5mnm20iGGWFVsQOdYX2P0BFsoQYwCepKRp3KWMT5jKQnv6bpHWD8I88ViBs2+cxrBsSnjVtqsXohReYrd91MXaOC6OUH8yRurDAQmJy788J+1mooKk9pCZ3qp6Q1bhFbzvQxrXhBcNEjBAKiMx2w9SsUhB6lsEhoTlEprO3TuCLw5Sj8xUgyxhnP98EXH2kS0a3CGfWpAqaVFv8MiLLQ8PSf7mx3x7gh2lLSHDKEY1nGIb4LMgIC/RmPNfrcdlSp040TP9Aj07ZXydbv10GC8NaMicAMDo/26I7azZDZVaqalj5l6R+DHllT95aruTMFvaREzvb4X/o2f8ch2x2xPdBQCpIwpVUwX7jrzzmLxa3NeEqNfBoS8NkKUQjdiNSz6R5jRQqjB7DERun9wy/p6umXWbMeTsz0/RlGsuv4ZwId3o0lA1paLfsrSwnihsG/33U5Lul1yzbqD5TztDVrW9BXOUS16tfZXiHodbS+yUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(5660300002)(8936002)(8676002)(6862004)(6636002)(4326008)(66946007)(66476007)(66556008)(316002)(2906002)(54906003)(41300700001)(37006003)(6486002)(6666004)(966005)(478600001)(26005)(6512007)(186003)(36756003)(83380400001)(2616005)(38100700002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7aN4XPA4KYCA+m2+eU2SRsjK+8n8ld5UX997dOc0msohT0Fnsma3QaAQ17V?=
 =?us-ascii?Q?s4L/jPzddH6bsZ9lOY+Bi7vr8Pn6utuXk6q+A/BT+qX1xMOAj24JItwhV/fw?=
 =?us-ascii?Q?0BSxy3NmIHncuNtYu/ekQZqGPeLYaUWLL91D9wFNDNavizK+Xm9AGcrm8nw9?=
 =?us-ascii?Q?ME77mTFjQFieZhO9YTUatW/2RE4MgDvLAL/2ZHwqoxpR+jrs4sfFLtxEK96e?=
 =?us-ascii?Q?rsPWSAku38efy5hNDmF6TOYRU2gCD+VG/vRurk/DrWG2yoSSu7Njcg5NCaY8?=
 =?us-ascii?Q?3vEkPkNm1OpxnwEY8pKTmLMTZaiiU+OPFlTbcdiIwRMJ3iUMeqFZvQFI4MM+?=
 =?us-ascii?Q?iwYISH8CAJPuegbRzA+L+Gd3+4fIRlEuQPDMTeSU0Tq58dj9qk+PVbZNZ78m?=
 =?us-ascii?Q?ajdxeLSHfML0bR3kebyERT3riIeLJftJGMisEXWNie9Pj31uF7bKS3NZSwhF?=
 =?us-ascii?Q?8RVqUNC/Zjnqh+Wq5NURPpXSN4uHsWuL4P5UJO2EeaCOJiP3BYThAFsJnm+i?=
 =?us-ascii?Q?8pNRjDCyvl3K+RB+PvikRZHxsqcLtF4wPEuniD7sRdixkgqK6Um0NuHabQkv?=
 =?us-ascii?Q?e8uTPMWoNnUtw20uaP4L573YUOEEz4oYNGJ9InLIEbOtIwzK8QsANiNBEY63?=
 =?us-ascii?Q?FUOLUOoyBAsX86zoRCMECNNwmghRrWKBFooRJo9iXfxo0t4tZtqZ+6eND+Zz?=
 =?us-ascii?Q?e+3g8oMMm6Ge0DT2/gvs9ProjQdJSdHGUT6pjOAFxlipmhXClLPTs2YoI8EO?=
 =?us-ascii?Q?y7OPSK8p14sNfBp9SPSj1hkPar9YtZgFYa3ldrCc0dA9Z5ug2akFd+BQ73qi?=
 =?us-ascii?Q?hwmFJPkYkCwrq/A8xrxIYz7eaVKihNTBR0Eb8J0H2+PeufbebEbJWF7NzwGJ?=
 =?us-ascii?Q?rHtcIBLpJmYC640C6195m6A9YDH5Bpp1bqkCiarIxX6j9I0P0JYFFTp+rKXR?=
 =?us-ascii?Q?QdIeS8rmVMOHwVjWvBhadNPL1sv57er0Sc5GCA4uvwlzSgbAMJ0RG1LXvefm?=
 =?us-ascii?Q?urbmfa0T1v1Ks0YpEAE4LhG/on5PwWla/5OhHnkCZYCHE1L0RaF98bQtIddG?=
 =?us-ascii?Q?QePe1g9EvPKZi6QwEIPQ54sEpv8/1pIZOg9RE+2dV6LexRCqwxCsJUgxFIRM?=
 =?us-ascii?Q?Su1gnCGawaZATPvl3RdPSd8FcBqXDtMq2CHK3cLMM72ooqMzF8yQcyb7scDe?=
 =?us-ascii?Q?YZvWC0Z+VOPzGZD8kPd4qHoA72K6de+nog7dP1KlsC93aUpzUTMslYR1Rn0B?=
 =?us-ascii?Q?plRhQlc1Pg8C2H/rty8OTQU55Q74Qq8Orhp+GtR/8LUgDWxLLE5661H871tr?=
 =?us-ascii?Q?LMLNMuuhOeEJROpiDTyI4GZs1KntZthEhkOzqdLHu/pt9qQ9qDK3awUjsGOn?=
 =?us-ascii?Q?cCL+tYafmzN9Nc2aitYhQN49yjUoy6fzOWB/XHE96qIYv/J0/jgsbp4srDQR?=
 =?us-ascii?Q?O3emzXOwHYBuFRs7wpgggwK1nm3zH3Qwpbm9+egDFsTij5B7Hw0rQeNZvznW?=
 =?us-ascii?Q?YBoIZqnOXWV8IQGxw5bSw4gdtNmgj0/hK7kv61kxqXXJmGaqJEhTDmuX4inJ?=
 =?us-ascii?Q?PdlQgUDpH6JEQ7d7kVCejGbCtlpMfcnanYmt5yDc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aae2305-c1e4-4af2-a735-08db719f671e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:02:44.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBYSSzSvxFoDEQmTViS+AhjLnGN9c8u+JiREgNrZDNaOuEWYRt6J67vQpo7jNwwFmTA39+yR6qyLS+ikb7thmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:33:00PM +0800, Yuan, Perry wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Users are having more success with amd-pstate since the introduction
> of EPP and Guided modes.  To expose the driver to more users by default
> introduce a kernel configuration option for setting the default mode.
> 
> Users can use an integer to map out which default mode they want to use
> in lieu of a kernel command line option.
> 
> This will default to EPP, but only if:
> 1) The CPU supports an MSR.
> 2) The system profile is identified
> 3) The system profile is identified as a non-server by the FADT.
> 
> Link: https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/121
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Co-developed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/Kconfig.x86  | 17 +++++++++
>  drivers/cpufreq/amd-pstate.c | 73 ++++++++++++++++++++++++------------
>  include/linux/amd-pstate.h   |  4 +-
>  3 files changed, 68 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 00476e94db90..438c9e75a04d 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -51,6 +51,23 @@ config X86_AMD_PSTATE
>  
>  	  If in doubt, say N.
>  
> +config X86_AMD_PSTATE_DEFAULT_MODE
> +	int "AMD Processor P-State default mode"
> +	depends on X86_AMD_PSTATE
> +	default 3 if X86_AMD_PSTATE
> +	range 1 4
> +	help
> +	  Select the default mode the amd-pstate driver will use on
> +	  supported hardware.
> +	  The value set has the following meanings:
> +		1 -> Disabled
> +		2 -> Passive
> +		3 -> Active (EPP)
> +		4 -> Guided
> +
> +	  For details, take a look at:
> +	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
> +
>  config X86_AMD_PSTATE_UT
>  	tristate "selftest for AMD Processor P-State driver"
>  	depends on X86 && ACPI_PROCESSOR
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c9d296ebf81e..b400d1ee8e64 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -62,7 +62,7 @@
>  static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
> -static int cppc_state = AMD_PSTATE_DISABLE;
> +static int cppc_state = AMD_PSTATE_UNDEFINED;
>  
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -1363,6 +1363,25 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.attr		= amd_pstate_epp_attr,
>  };
>  
> +static int __init amd_pstate_set_driver(int mode_idx)
> +{
> +	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
> +		cppc_state = mode_idx;
> +		if (cppc_state == AMD_PSTATE_DISABLE)
> +			pr_info("driver is explicitly disabled\n");
> +
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			current_pstate_driver = &amd_pstate_epp_driver;
> +
> +		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
> +			current_pstate_driver = &amd_pstate_driver;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int __init amd_pstate_init(void)
>  {
>  	struct device *dev_root;
> @@ -1370,15 +1389,6 @@ static int __init amd_pstate_init(void)
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return -ENODEV;
> -	/*
> -	 * by default the pstate driver is disabled to load
> -	 * enable the amd_pstate passive mode driver explicitly
> -	 * with amd_pstate=passive or other modes in kernel command line
> -	 */
> -	if (cppc_state == AMD_PSTATE_DISABLE) {
> -		pr_info("driver load is disabled, boot with specific mode to enable this\n");
> -		return -ENODEV;
> -	}
>  
>  	if (!acpi_cpc_valid()) {
>  		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
> @@ -1389,6 +1399,33 @@ static int __init amd_pstate_init(void)
>  	if (cpufreq_get_current_driver())
>  		return -EEXIST;
>  
> +	switch (cppc_state) {
> +	case AMD_PSTATE_UNDEFINED:
> +		/* Disable on the following configs by default:
> +		 * 1. Undefined platforms
> +		 * 2. Server platforms
> +		 * 3. Shared memory designs
> +		 */
> +		if (acpi_pm_profile_undefined() ||
> +		    acpi_pm_profile_server() ||
> +		    !boot_cpu_has(X86_FEATURE_CPPC)) {
> +			pr_info("driver load is disabled, boot with specific mode to enable this\n");
> +			return -ENODEV;
> +		}
> +		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
> +		if (ret)
> +			return ret;
> +		break;
> +	case AMD_PSTATE_DISABLE:
> +		return -ENODEV;
> +	case AMD_PSTATE_PASSIVE:
> +	case AMD_PSTATE_ACTIVE:
> +	case AMD_PSTATE_GUIDED:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> @@ -1441,21 +1478,7 @@ static int __init amd_pstate_param(char *str)
>  	size = strlen(str);
>  	mode_idx = get_mode_idx_from_str(str, size);
>  
> -	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
> -		cppc_state = mode_idx;
> -		if (cppc_state == AMD_PSTATE_DISABLE)
> -			pr_info("driver is explicitly disabled\n");
> -
> -		if (cppc_state == AMD_PSTATE_ACTIVE)
> -			current_pstate_driver = &amd_pstate_epp_driver;
> -
> -		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
> -			current_pstate_driver = &amd_pstate_driver;
> -
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> +	return amd_pstate_set_driver(mode_idx);
>  }
>  early_param("amd_pstate", amd_pstate_param);
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index c10ebf8c42e6..446394f84606 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -94,7 +94,8 @@ struct amd_cpudata {
>   * enum amd_pstate_mode - driver working mode of amd pstate
>   */
>  enum amd_pstate_mode {
> -	AMD_PSTATE_DISABLE = 0,
> +	AMD_PSTATE_UNDEFINED = 0,
> +	AMD_PSTATE_DISABLE,
>  	AMD_PSTATE_PASSIVE,
>  	AMD_PSTATE_ACTIVE,
>  	AMD_PSTATE_GUIDED,
> @@ -102,6 +103,7 @@ enum amd_pstate_mode {
>  };
>  
>  static const char * const amd_pstate_mode_string[] = {
> +	[AMD_PSTATE_UNDEFINED]   = "undefined",
>  	[AMD_PSTATE_DISABLE]     = "disable",
>  	[AMD_PSTATE_PASSIVE]     = "passive",
>  	[AMD_PSTATE_ACTIVE]      = "active",
> -- 
> 2.34.1
> 
