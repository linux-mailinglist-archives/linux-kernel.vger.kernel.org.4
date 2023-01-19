Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C880A672F34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjASCqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjASCqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:46:10 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1574AB47E;
        Wed, 18 Jan 2023 18:46:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyuWW7BP0O3O9+JT7GY7OGE7JXznBynqnoFkYuA8ZFxwawr7WyCAl5LOSoKwteaIaXrsuySS29WygGsvvZHBJil3STUGIp0QZGTvI+3z7i5v7qnGco9Nzb9CYz5MPjwED8Ru9GCcxR/Q7AvEW2umGT7dP/fgLYqAS4xFUxkHYj7/o9LwMBaw80tIPzlprB4Ixllgoy4HhBH8mIhI0idBz9C2qAiHaf3G9or2r41fFXYAaX/HvUu/JNJdqKb83+NLEiAYoi2ZRxw4JGQN9WVB32OQ/TO2+V+K4Ubn0TomMQCfDO7q4g8d+R8R6+Pllm4F9Jc41a05ud9v8XhHmFrZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jczZk4tzUxVEC/N57EYtdckb2GBReVxCm/PE3LauQ1U=;
 b=YSP1CIrsQYBwQWgpUFPVcGO2iXiKZ0MPZApIiR7kTYPm/3s4DSeZtQKOamuuSf2Bjl+lUDD84r8xX4r0p1F+okQfQty/c07GO6/rf87cRPwBiTaYdYZjq2/lSgpcErJtXyc3s+x6Ret/VKpNAtJK4qqPT88NbPS/ZrLLoN1K+X3B2YkYFL7ubFfZqNeyctPd2I0i54EWamHuM+ugvAQ8a0vu8MHM9Xfw0FzHuour8Q75c+6+8Kvi2GojfVoXfZiNY8Z3eHekOpZYOStwWkuNvIbmzlk1dEK08bSEysZQV3/LLeGWqo3PO3AP0xgWfOZ67NbFk5oMMAPComO41s/Scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jczZk4tzUxVEC/N57EYtdckb2GBReVxCm/PE3LauQ1U=;
 b=41bY0RyAEnliwVfVcBpaS7jSdMKlEC74wLWOUAqwBuWf9WryjT78LpTh3pyC5oG5nOOTmwKJQa6XkDAC/nnYIvsQaJWY7JNQMt3oybj5eVnRz4D76Vs84FqAdkCPBfO+OfXUbiKURF+H3w0JYIvbyeMHqdZDpFJV3MFSRemWsHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 02:46:03 +0000
Received: from MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::444e:a4dc:f113:7751]) by MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::444e:a4dc:f113:7751%7]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 02:46:03 +0000
Date:   Thu, 19 Jan 2023 10:45:40 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 04/11] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Message-ID: <Y8iu1AkMFM8TUQFX@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-5-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118075210.447418-5-perry.yuan@amd.com>
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2506:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e6ac7c-1502-4f71-3f59-08daf9c74dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpr+StwhKCb0lR+tqkjTwq2auL1LA0wwUczthFNfV/aWffzjEtga3tbvK4ffBCoBGEZ2HEySd75ZTUBhcV0TupL5dMv7rvPEhruKR0Q5OSkB4AIp1/fmKJoZaQHcAyqnrkSiETZVwmpGQwQDhnlMx6pPtGaKyRLyV0Mqko4KXQweDS1dS0vRsddndRkKUJe/FWjDLXqaTF92FxKWG+FBECJ/iQA8iX+erMXtwMwe+4EcYto8r1KgC9dJF1XyFiwUDMmfKg0mMQNua19TYFEtLC/nmkWSxCaJ5qsJ1uhG0/HrCkMKU8bLXxnPIa13T9pGwlcNXKfN7smnLr9iVny8Sa0vn1w+jOWgP7DXg0jmWTY3l4PsFzgbzdPtttps7dqQBtQzdDPGpewVCoCpQMsurJ8PoHxf/H5H/PTyHTqbX2Rm71LeKKyLfJ++Yi6nHmmFvAzixV3NO3SlGFcZy5jA/quhaftrKFIbmC3Hxd5FrQLTXcGgXBGeErh/0qaXzFSS/+lPkAOzQdkqbSNvFUgBJvcuaz9JCvTE0vCJP8t+K1bT2x3BS5B4Mm6/XPse1y0Cvk8TpCjIkq8WEs5axUGX75tZCp+V/U4m8N6/fsebzrQ9LnbgmQ2lEEHJqZHTn8UdDkIJx9bOTaOKLuvtbEkpjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36756003)(8936002)(2616005)(6862004)(83380400001)(41300700001)(4326008)(316002)(37006003)(54906003)(6636002)(66946007)(8676002)(66556008)(66476007)(38100700002)(86362001)(2906002)(5660300002)(30864003)(66899015)(186003)(6512007)(26005)(478600001)(6486002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+8ForLh5iQEDglUnyMw8D93gu3fkXiPJaFUtxhAO4w1eu9yd9afSvwly7QeP?=
 =?us-ascii?Q?AUt/aEf7efIcHCK1jGPM1zHWxAoUsInebITKKpkFoEIeTxHnmY86y017XlJc?=
 =?us-ascii?Q?G4Hei7xcercgvcsIOy2K3OI0BBxKG94siywjyoQhoZ8VrcX1slQ4YwBnlQ8J?=
 =?us-ascii?Q?1PSUmRNNlP7IM0C1Ckg27SsnPTac4NJQrq841HzWKAJ9/499ix3Ow8/VlDJ4?=
 =?us-ascii?Q?aVIAj8+oQW2Cpu8Jgwo7QmZUcRzhxlVoKBc71MkdXPEw9z1qaWUOEaYheb/9?=
 =?us-ascii?Q?pLpNxPHUnz7jA3YTB8fM8C/AAzNfee9a7VqVqUFNNDkBKF2VFEzgr54bQ8F4?=
 =?us-ascii?Q?ofmbfzRwOehxWD4q9+yHVLUcR4jJZUlQCw2INfltVWoJ8gdMtUna6VLRXj+a?=
 =?us-ascii?Q?64ad9ObqV0dBgWCL+9ka0BjnAFjjE6yAg9FEJmTFCbSWH4CuRzvlKHDgu4Gh?=
 =?us-ascii?Q?5OTubI+nsAWQHPXy1ebPymsBtQAPfPRmkzcxGJV7cYIQE22ess1gTihtTFUc?=
 =?us-ascii?Q?uJCb6MZlITHbJnZxIW0XqD82iSCorDKb2Nlzv3Lt0v2ZS1mCxSvsL7pKprvx?=
 =?us-ascii?Q?It4s6+JNjTkfpU2mJWUCNpH7ZfxxDo5qCKQqimVTQ5nL6zFU44woW+5zEbvG?=
 =?us-ascii?Q?sfNiKPRrRP4uJ95W+hD7Zj/+TRejvEeUxzkEBwcHrIsSrdArQgAv8ujjxN+a?=
 =?us-ascii?Q?u4NJBmUdRkFEV4SwA/RkXJIC/dP5RXkPWT1pYZTOZ7BrtrX9f7894hGAulei?=
 =?us-ascii?Q?gOUR8bE6fOZxYmlEuk5Htfu2hRCle3jM0gksjx/GvA1Pb9QQtfQuDIP+aOzQ?=
 =?us-ascii?Q?NhHjt8LvaCuUFD3lzYwZAZrdAmOW3n6aUW/LjkHccfI0ExRhvWPsXeW253tD?=
 =?us-ascii?Q?+TrThhJKDhWmPhOfmE9gINnY5/BQWcv89EXwONj19Up/z53qHQc0CykAf1wY?=
 =?us-ascii?Q?bK3itDforKb9pJt+ANRMRiXhcT8GkfjfqIB/YAu7jdpbATq1Xaq0p2T3aE2s?=
 =?us-ascii?Q?euG5iuj6TVxOSLr+/Ye0iblxcAufKghV3KvEmvZ1ekPJvIZvqcfWc/Vv4MFh?=
 =?us-ascii?Q?BF8pNvLXFB14bnJ7o9Gla/QQx8GEDvBVNw1P1NwgQZvCflQ3JPpYVM7flS8y?=
 =?us-ascii?Q?v4TDWreNXiNV2y0eSowCCuavA3BXFA36Gxba3C/YOGmj8GvSEGtSIE/M52FT?=
 =?us-ascii?Q?XjkgyG7u10amdC7gefja9ZjGFZThvPUiQ6Iv3HhLA9/9QJHouwM++4qG+PDg?=
 =?us-ascii?Q?KlHNkXMyXWVoGiZzedFALrQOPYify7mN/4sKdifKh/o4D8Cxwov8mRL75Iz/?=
 =?us-ascii?Q?sSpE6OisuCUUdY+Tj2jZapbpKF+SZooPpnMQHjKOBB7EBm2IbS7j9v9JRrmH?=
 =?us-ascii?Q?U0Y6Xd7oBYgapOEHevp9MJkBNUycmjKOsEE4Gf0Am0Ry5WVj4O8iwmCn2yFO?=
 =?us-ascii?Q?uMqhITwZCwT+JkMJY49IIfxrjHoxMh3wa2X6EVwgCKBfg6MDB2tSafFvwTLo?=
 =?us-ascii?Q?0cY7XnyukK7zRZsnBvir2dLiN4HYOLvwvb00mbWUeOwZ/Qm2VV0nqoYAJMib?=
 =?us-ascii?Q?L2U4EpOG9UoxMYBwCIrP4mjgjkObL5vdjsRLmPDw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e6ac7c-1502-4f71-3f59-08daf9c74dc1
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 02:46:03.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufflv2lGR9a1hA8CtWDz2xv6NHiegPvxtd/hl6ES1eNzxe9oWLnyWKGJFHCeCNPWBSuQEaw4CANULE8yfTIUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:52:03PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add EPP driver support for AMD SoCs which support a dedicated MSR for
> CPPC.  EPP is used by the DPM controller to configure the frequency that
> a core operates at during short periods of activity.
> 
> The SoC EPP targets are configured on a scale from 0 to 255 where 0
> represents maximum performance and 255 represents maximum efficiency.
> 
> The amd-pstate driver exports profile string names to userspace that are
> tied to specific EPP values.
> 
> The balance_performance string (0x80) provides the best balance for
> efficiency versus power on most systems, but users can choose other
> strings to meet their needs as well.
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
> balance_performance
> 
> To enable the driver,it needs to add `amd_pstate=active` to kernel
> command line and kernel will load the active mode epp driver
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 379 ++++++++++++++++++++++++++++++++++-
>  include/linux/amd-pstate.h   |  55 +++++
>  2 files changed, 428 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1a8b31277620..2109ad3fdd42 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,7 +59,9 @@
>   * we disable it by default to go acpi-cpufreq on these processors and add a
>   * module parameter to be able to enable it manually for debugging.
>   */
> +static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_DISABLE;
>  
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
> @@ -73,6 +75,114 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  	return -EINVAL;
>  }
>  
> +static DEFINE_MUTEX(amd_pstate_limits_lock);
> +static DEFINE_MUTEX(amd_pstate_driver_lock);
> +
> +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +{
> +	u64 epp;
> +	int ret;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		if (!cppc_req_cached) {
> +			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +					&cppc_req_cached);
> +			if (epp)
> +				return epp;
> +		}
> +		epp = (cppc_req_cached >> 24) & 0xFF;
> +	} else {
> +		ret = cppc_get_epp_perf(cpudata->cpu, &epp);
> +		if (ret < 0) {
> +			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> +			return -EIO;
> +		}
> +	}
> +
> +	return (s16)(epp & 0xff);
> +}
> +
> +static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
> +{
> +	s16 epp;
> +	int index = -EINVAL;
> +
> +	epp = amd_pstate_get_epp(cpudata, 0);
> +	if (epp < 0)
> +		return epp;
> +
> +	switch (epp) {
> +	case AMD_CPPC_EPP_PERFORMANCE:
> +		index = EPP_INDEX_PERFORMANCE;
> +		break;
> +	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
> +		index = EPP_INDEX_BALANCE_PERFORMANCE;
> +		break;
> +	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
> +		index = EPP_INDEX_BALANCE_POWERSAVE;
> +		break;
> +	case AMD_CPPC_EPP_POWERSAVE:
> +		index = EPP_INDEX_POWERSAVE;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return index;
> +}
> +
> +static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +{
> +	int ret;
> +	struct cppc_perf_ctrls perf_ctrls;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +		if (!ret)
> +			cpudata->epp_cached = epp;
> +	} else {
> +		perf_ctrls.energy_perf = epp;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +		cpudata->epp_cached = epp;
> +	}
> +
> +	return ret;
> +}
> +
> +static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
> +		int pref_index)
> +{
> +	int epp = -EINVAL;
> +	int ret;
> +
> +	if (!pref_index) {
> +		pr_debug("EPP pref_index is invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (epp == -EINVAL)
> +		epp = epp_values[pref_index];
> +
> +	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		pr_debug("EPP cannot be set under performance policy\n");
> +		return -EBUSY;
> +	}
> +
> +	ret = amd_pstate_set_epp(cpudata, epp);
> +
> +	return ret;
> +}
> +
>  static inline int pstate_enable(bool enable)
>  {
>  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> @@ -81,11 +191,21 @@ static inline int pstate_enable(bool enable)
>  static int cppc_enable(bool enable)
>  {
>  	int cpu, ret = 0;
> +	struct cppc_perf_ctrls perf_ctrls;
>  
>  	for_each_present_cpu(cpu) {
>  		ret = cppc_set_enable(cpu, enable);
>  		if (ret)
>  			return ret;
> +
> +		/* Enable autonomous mode for EPP */
> +		if (cppc_state == AMD_PSTATE_ACTIVE) {
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	return ret;
> @@ -428,7 +548,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  		return;
>  
>  	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	current_pstate_driver->boost_enabled = true;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -602,10 +722,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  	return sprintf(&buf[0], "%u\n", perf);
>  }
>  
> +static ssize_t show_energy_performance_available_preferences(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	int i = 0;
> +	int offset = 0;
> +
> +	while (energy_perf_strings[i] != NULL)
> +		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
> +
> +	sysfs_emit_at(buf, offset, "\n");
> +
> +	return offset;
> +}
> +
> +static ssize_t store_energy_performance_preference(
> +		struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	char str_preference[21];
> +	ssize_t ret;
> +
> +	ret = sscanf(buf, "%20s", str_preference);
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	ret = match_string(energy_perf_strings, -1, str_preference);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&amd_pstate_limits_lock);
> +	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
> +	mutex_unlock(&amd_pstate_limits_lock);
> +
> +	return ret ?: count;
> +}
> +
> +static ssize_t show_energy_performance_preference(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int preference;
> +
> +	preference = amd_pstate_get_energy_pref_index(cpudata);
> +	if (preference < 0)
> +		return preference;
> +
> +	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_rw(energy_performance_preference);
> +cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -614,6 +785,186 @@ static struct freq_attr *amd_pstate_attr[] = {
>  	NULL,
>  };
>  
> +static struct freq_attr *amd_pstate_epp_attr[] = {
> +	&amd_pstate_max_freq,
> +	&amd_pstate_lowest_nonlinear_freq,
> +	&amd_pstate_highest_perf,
> +	&energy_performance_preference,
> +	&energy_performance_available_preferences,
> +	NULL,
> +};
> +
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> +	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int rc;
> +	u64 value;
> +
> +	/*
> +	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
> +	 * which is ideal for initialization process.
> +	 */
> +	amd_perf_ctl_reset(policy->cpu);
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		goto free_cpudata1;
> +
> +	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> +	if (!cpudata)
> +		return -ENOMEM;
> +
> +	cpudata->cpu = policy->cpu;
> +	cpudata->epp_policy = 0;
> +
> +	rc = amd_pstate_init_perf(cpudata);
> +	if (rc)
> +		goto free_cpudata1;
> +
> +	min_freq = amd_get_min_freq(cpudata);
> +	max_freq = amd_get_max_freq(cpudata);
> +	nominal_freq = amd_get_nominal_freq(cpudata);
> +	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> +				min_freq, max_freq);
> +		ret = -EINVAL;
> +		goto free_cpudata1;
> +	}
> +
> +	policy->cpuinfo.min_freq = min_freq;
> +	policy->cpuinfo.max_freq = max_freq;
> +	/* It will be updated by governor */
> +	policy->cur = policy->cpuinfo.min_freq;
> +
> +	/* Initial processor data capability frequencies */
> +	cpudata->max_freq = max_freq;
> +	cpudata->min_freq = min_freq;
> +	cpudata->nominal_freq = nominal_freq;
> +	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> +
> +	policy->driver_data = cpudata;
> +
> +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
> +
> +	policy->min = policy->cpuinfo.min_freq;
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	/*
> +	 * Set the policy to powersave to provide a valid fallback value in case
> +	 * the default cpufreq governor is neither powersave nor performance.
> +	 */
> +	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		policy->fast_switch_possible = true;
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
> +	}
> +	amd_pstate_boost_init(cpudata);
> +
> +	return 0;
> +
> +free_cpudata1:
> +	kfree(cpudata);
> +	return ret;
> +}
> +
> +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	pr_debug("CPU %d exiting\n", policy->cpu);
> +	policy->fast_switch_possible = false;
> +	return 0;
> +}
> +
> +static void amd_pstate_epp_init(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u32 max_perf, min_perf;
> +	u64 value;
> +	s16 epp;
> +
> +	max_perf = READ_ONCE(cpudata->highest_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
> +
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +		min_perf = max_perf;
> +
> +	/* Initial min/max values for CPPC Performance Controls Register */
> +	value &= ~AMD_CPPC_MIN_PERF(~0L);
> +	value |= AMD_CPPC_MIN_PERF(min_perf);
> +
> +	value &= ~AMD_CPPC_MAX_PERF(~0L);
> +	value |= AMD_CPPC_MAX_PERF(max_perf);
> +
> +	/* CPPC EPP feature require to set zero to the desire perf bit */
> +	value &= ~AMD_CPPC_DES_PERF(~0L);
> +	value |= AMD_CPPC_DES_PERF(0);
> +
> +	if (cpudata->epp_policy == cpudata->policy)
> +		goto skip_epp;
> +
> +	cpudata->epp_policy = cpudata->policy;
> +
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		if (epp < 0)
> +			goto skip_epp;
> +		/* force the epp value to be zero for performance policy */
> +		epp = 0;
> +	} else {
> +		/* Get BIOS pre-defined epp value */
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		if (epp)
> +			goto skip_epp;
> +	}
> +	/* Set initial EPP value */
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +	}
> +
> +skip_epp:
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	amd_pstate_set_epp(cpudata, epp);
> +	cpufreq_cpu_put(policy);
> +}
> +
> +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (!policy->cpuinfo.max_freq)
> +		return -ENODEV;
> +
> +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> +				policy->cpuinfo.max_freq, policy->max);
> +
> +	cpudata->policy = policy->policy;
> +
> +	amd_pstate_epp_init(policy->cpu);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> +{
> +	cpufreq_verify_within_cpu_limits(policy);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> +	return 0;
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -627,6 +978,16 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.attr		= amd_pstate_attr,
>  };
>  
> +static struct cpufreq_driver amd_pstate_epp_driver = {
> +	.flags		= CPUFREQ_CONST_LOOPS,
> +	.verify		= amd_pstate_epp_verify_policy,
> +	.setpolicy	= amd_pstate_epp_set_policy,
> +	.init		= amd_pstate_epp_cpu_init,
> +	.exit		= amd_pstate_epp_cpu_exit,
> +	.name		= "amd_pstate_epp",
> +	.attr		= amd_pstate_epp_attr,
> +};
> +
>  static int __init amd_pstate_init(void)
>  {
>  	int ret;
> @@ -655,7 +1016,8 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -666,14 +1028,13 @@ static int __init amd_pstate_init(void)
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> -		pr_err("failed to enable amd-pstate with return %d\n", ret);
> +		pr_err("failed to enable with return %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(current_pstate_driver);
>  	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register with return %d\n", ret);
>  
>  	return ret;
>  }
> @@ -695,6 +1056,12 @@ static int __init amd_pstate_param(char *str)
>  		if (cppc_state == AMD_PSTATE_DISABLE)
>  			pr_info("driver is explicitly disabled\n");
>  
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			current_pstate_driver = &amd_pstate_epp_driver;
> +
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			current_pstate_driver = &amd_pstate_driver;
> +
>  		return 0;
>  	}
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index dae2ce0f6735..9bfdabd9d930 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -47,6 +47,10 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +76,12 @@ struct amd_cpudata {
>  
>  	u64	freq;
>  	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u64	cppc_cap1_cached;
>  };
>  
>  /*
> @@ -91,4 +101,49 @@ static const char * const amd_pstate_mode_string[] = {
>  	NULL,
>  };
>  
> +#define AMD_CPPC_EPP_PERFORMANCE		0x00
> +#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> +#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
> +#define AMD_CPPC_EPP_POWERSAVE			0xFF
> +
> +/*
> + * AMD Energy Preference Performance (EPP)
> + * The EPP is used in the CCLK DPM controller to drive
> + * the frequency that a core is going to operate during
> + * short periods of activity. EPP values will be utilized for
> + * different OS profiles (balanced, performance, power savings)
> + * display strings corresponding to EPP index in the
> + * energy_perf_strings[]
> + *	index		String
> + *-------------------------------------
> + *	0		default
> + *	1		performance
> + *	2		balance_performance
> + *	3		balance_power
> + *	4		power
> + */
> +enum energy_perf_value_index {
> +	EPP_INDEX_DEFAULT = 0,
> +	EPP_INDEX_PERFORMANCE,
> +	EPP_INDEX_BALANCE_PERFORMANCE,
> +	EPP_INDEX_BALANCE_POWERSAVE,
> +	EPP_INDEX_POWERSAVE,
> +};
> +
> +static const char * const energy_perf_strings[] = {
> +	[EPP_INDEX_DEFAULT] = "default",
> +	[EPP_INDEX_PERFORMANCE] = "performance",
> +	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> +	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
> +	[EPP_INDEX_POWERSAVE] = "power",
> +	NULL
> +};
> +
> +static unsigned int epp_values[] = {
> +	[EPP_INDEX_DEFAULT] = 0,
> +	[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_PERFORMANCE,
> +	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
> +	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
> +	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
> + };

These definitions should be moved to amd-pstate.c, because they are only
called at that module as the warning by 0 days.

Thanks,
Ray

>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 
