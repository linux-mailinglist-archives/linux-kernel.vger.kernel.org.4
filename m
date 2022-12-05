Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EEE642857
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiLEMWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiLEMWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:22:45 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C40CE9;
        Mon,  5 Dec 2022 04:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS38g4mrU6MOaJGU+VWdLqT1PF+j3bc99+e8+lpRKvbZAfBNLK75AYGqR5QJ96qpuifbRfzAOq2hYjognb8gPSXpP7ry5AQzPZrMZVD02iNFyjWx6sVgPwQjDoYtITj63TbiHltaUdYDVn3yXO2Wmr4iExlR/oiWAdghA0c7xCqjF9eJnwSjh5lJgH8T5YLMQSrYDyjQaMbERLwB0syN80dlQKTC4IeHyR6YO2BEmERfo0TxFZjVvcfvoHd+Lixu8rQQ9+e/X5Of4Yglkg1+xwi6iwT3WcrZKZ32p7KjUMlwRDGSiLJ5KY/sRP9uLlmPDCk/3gZFH5TLL0sjqT8Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoTZGpjvr4o7BL8Zx1R1LUGj/OaNaATl5Xbr+7+Hkg4=;
 b=ZQLNAUFzS7bn3RPmTMWlQt7xDlhNkOoVa+X+ovA5dnKMmhHj/o5eLQrTLhWiu6pbO8XMc86bjZDzv7jtW2XkwWdosRicajvkzjb3tyrZnkCHj8W5u5B4U7RmFGP9/8GcCoZWSAzLFfZhObCvf6YAPpmx97tapjlVq/cjgZLPI0qoYy6am5eUmBv4lhDzmTbxDRJqNu33D1anjulCqu1AaaW/kEuxp/9eYUOc1tUuFAWfGwn3obHnOr8qxJNoKSDmUyLdl0VedTpEK2KtlHMUkh6wldkGdeh/L+hFY5rfcDVtDDx0Vt/OxiXTr2GWfUvJx49eV6ZaOaLofUFHEwO4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoTZGpjvr4o7BL8Zx1R1LUGj/OaNaATl5Xbr+7+Hkg4=;
 b=nGW+kTRFqbSTXEAxPLlzISIyUy9ua6inFvPqSVvLO49AbVu2efG2q8Y8B6MmRc3mFcBgy0WF/8jNKaZct6jBEzbI4zpdOzKZX9yNL8tFIII6GWOrk+gbpwXnm3YM69l/UuNGysjMscim0Qysfm+RdwhL8ZaBh8Z4GFZ3QnMVd1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Mon, 5 Dec 2022 12:22:39 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 5 Dec 2022
 12:22:39 +0000
Date:   Mon, 5 Dec 2022 20:22:15 +0800
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
Subject: Re: [PATCH v6 04/11] cpufreq: amd_pstate: implement Pstate EPP
 support for the AMD processors
Message-ID: <Y43id6YwevJiQssa@amd.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-5-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202074719.623673-5-perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: cdae9667-9603-4a97-e454-08dad6bb665b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCNMLQvK8KdgnnHCyyAsKy5ish0ig4s4eMK3tMSfKh6XX3MiDKCKmrtdnY9pwI781ybwV1jc8Kk8X1urKjCMK9b4lhxgWg9d7rfnKp52XJqlrpTlQKbW5uh7QQZnkdiYBrn5T5tZM3gGvmsRiTYwmfcxEBYyox9Jwy/eL60xltZyH1vr4fSbcpJDbM854YjF/az6EwTSvl+/ZP9SBCQuHyWuqCHwOYY6B9dzRAfivpY+uztGD1ohNiARTEaJ3Z/v8sj+n6TU6Zgp7DeCxhiIPy5LOTysBb5hZldwABYSISSXvLAYsGA1yeGYsfHsQ48u9YSs1i8na/ATRWv09hCrCk4VMxC0jcPEG0W4x3qTPOeQhMYpbrOxlyA1cy91F7aHp3q0DtH+gwPTKgUU0lGSa/b543S+cPaaIcY79MfSfTXRCaagq1qlynpaTEFz4NNp4KSQ4GR8TCKe74HFP0tDjB3nyXr1PEnMYsBGH9WTrtOL5JF0+dNzJZ6WXJoE0x5X1jabJ8famH+zvXNZcmqcr8iTJiEPiEE8juvx+22QXferHfOeLEcNsl2xrv0h7gobw1jg0WMsOgtnLH5nqoXyPZxX5o4Zoi/xr4cN2l2cDM+7lJi0WnwnLDd92nt0iDaVq6EmrG80ix8MwDfmdaYf3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(4326008)(8936002)(8676002)(2906002)(86362001)(6636002)(66556008)(5660300002)(41300700001)(6666004)(186003)(6512007)(66476007)(2616005)(37006003)(38100700002)(66946007)(54906003)(26005)(83380400001)(316002)(6506007)(30864003)(6862004)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3fBYxMlEpfKz0o2O+9VH3zOQd9qzOETgKl5xN3Of2eICj+98tYn/KdfRg+jI?=
 =?us-ascii?Q?pY7F05i+CcNHN8i5jqom8fFGcuPDiHVc6abrAHLBSAADozpzTEAvVf4oT6uC?=
 =?us-ascii?Q?aLxgPtewxcvgVq33i7JCUgLtZGtYuFVW+VgUfngr/aw3MdogYvg6jKpKlUcL?=
 =?us-ascii?Q?JzUKC47U5/c3thPBnSoHGMOh4akfhURc2QDjrgIAATmPF6gh+0YtMvwf+r2R?=
 =?us-ascii?Q?YDX1pXAyBAsASccW4ST0CuN41vRNGtpF1ET0Bi73jRt6phJw+D/Re+1uTVpz?=
 =?us-ascii?Q?DvBvbtS1yE3ZQ4dXcnpaKLB92GJd/DMVqsje51Fp7Pdl/TO7eWeSlM7kY4JK?=
 =?us-ascii?Q?fNDsokv08HzFacML4Hv6uoj+OOVJTh4Bg8eqFBlhUjhG+Y4XUCz3l8qhP/MT?=
 =?us-ascii?Q?6i6RcpOTgf7SQNwl7fW0Xd9sQO95rEs3ua0+DNlcw5hnEBO6VsIK0Mr0UUG7?=
 =?us-ascii?Q?AQ3hvXU53m5sUpqn51aSiyZxaaSThmSMA7p4Umbl3UAERKzJnZymDo03Y0p+?=
 =?us-ascii?Q?X7qjbttqvDZg9TbKIOmSxKCQrh3Kg/kfI6B7MQcul2RSXAsRHyYYbkwVE2I2?=
 =?us-ascii?Q?PmKmHrPkbZefjcIlhp2yX7BoSZfOcPft9VysLj+ec+kzL0ECrbbCt0ai5fHL?=
 =?us-ascii?Q?MvoQQRs1hIYOJbuzjHxnqBA2u2vkGFup+cewjKVOsV4S69d0LyrzJIxUvkv2?=
 =?us-ascii?Q?SAM6AZIylhrdjCCAB9MTUlgf164hH4+ZpMXLHB8nCTRGo6bHqDCk4OkPNndn?=
 =?us-ascii?Q?x7fWpLRAutBj/e5AFLlru4AnixQyPIGxcL8fNSfL9XlgZQsxyl7cowxhUY6p?=
 =?us-ascii?Q?x9EgQHRbw5jgrHsvStG1539jTe7MiO/6dcilgu0Gv53vslOnx/qMN48WMIl9?=
 =?us-ascii?Q?gVunEk8KWIieYMRpAgSTcrjdLpTnH4+9Tc72U8/KtV6oGtiYR1vl1EM0o23S?=
 =?us-ascii?Q?kmnU0klmhlQ9XknsHt02UCDkt53BShmCB/zUKUv09GvJ5F6ozShYB7115g4l?=
 =?us-ascii?Q?QwAdNyoJz0oek67p+NBZJqNRckuJ6nWb49xE0/VUzKMS3iPHSHh+Jz8zkHIQ?=
 =?us-ascii?Q?lytapt9O+xpRyVujzKb/2n5s7PzRtEoIHUK7VRwb8TtztWvfL6Nd/kcOL307?=
 =?us-ascii?Q?/H/UaNibVrauY7IOM1rPhOAcnddbt9siF5Cu/m/WYGVXyIH8eOLiDNDdORw6?=
 =?us-ascii?Q?o3eYZ+o1gahsU4Ai5uJK78cxVsN37Lfgxksmz2GWs4F+vATxWgiHv4Xo4+V+?=
 =?us-ascii?Q?2VufDvXMIfhvKzujwZDhcsr2N7iyUG85PkbCruKlLlZIfH5y0WvWIYP9vn1J?=
 =?us-ascii?Q?eXubQoNse/eWJ9hqR3Xyn9+mJIVWXQ8UG0Gwps8JRBaEkzcXaY+9zMpqvB7j?=
 =?us-ascii?Q?C4Rfy2eWJeeaLsmhDgC9YZaJLZj3rve3bqtsLQubC8TiJtG/4gywUPH3KRkY?=
 =?us-ascii?Q?0MZDbOeraoS+kSIADaoOJKsu6BziD2Qj7ayCOZBlcAZYJix9XJfoG5Lna/om?=
 =?us-ascii?Q?vUeWFgbwnYsxNXk75cfH52ekAV4K5o/I/qMzmEcgEB8a7dgLD99UJaYe57P6?=
 =?us-ascii?Q?Y2dYARm2p+UpsQWrgmatSOFlrb/DDjowV1ZbUpPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdae9667-9603-4a97-e454-08dad6bb665b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 12:22:39.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 047b1O30Tky+nUqO5V8uqQ+6EzYc/cqZQ8UIPy/ySxy0mvstWWmLGe+wZXCq4/OgVDaG9FSfkDFKTu+sSnpF+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 03:47:12PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 

> cpufreq: amd_pstate: implement Pstate EPP support for the AMD processors

I suggest that we align the format like "cpufreq: amd-pstate:" as the
prefix of the subject like previous patches. Because it's there anywhere
even in the documentation file. I think it's not worth to change such as
minor update like amd-pstate to amd_pstate for all the files and comments.
So let's align the previous way.

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
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 643 ++++++++++++++++++++++++++++++++++-
>  include/linux/amd-pstate.h   |  35 ++
>  2 files changed, 672 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..5989d4d25d0f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -37,9 +37,12 @@
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  #include <linux/amd-pstate.h>
> +#include <linux/cpufreq_common.h>
>  
> +#ifdef CONFIG_ACPI
>  #include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
> +#endif

The amd-pstate module depends on ACPI in the kconfig, so we won't need add
CONFIG_ACPI here.

>  
>  #include <asm/msr.h>
>  #include <asm/processor.h>
> @@ -59,9 +62,130 @@
>   * we disable it by default to go acpi-cpufreq on these processors and add a
>   * module parameter to be able to enable it manually for debugging.
>   */
> -static struct cpufreq_driver amd_pstate_driver;
> +static bool cppc_active;
>  static int cppc_load __initdata;
>  
> +static struct cpufreq_driver *default_pstate_driver;
> +static struct amd_cpudata **all_cpu_data;
> +static struct amd_pstate_params global_params;
> +
> +static DEFINE_MUTEX(amd_pstate_limits_lock);
> +static DEFINE_MUTEX(amd_pstate_driver_lock);
> +
> +static bool cppc_boost __read_mostly;
> +struct kobject *amd_pstate_kobj;

Where is it using amd_pstate_kobj?

> +
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +{
> +	s16 epp;
> +	struct cppc_perf_caps perf_caps;
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
> +		ret = cppc_get_epp_caps(cpudata->cpu, &perf_caps);
> +		if (ret < 0) {
> +			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> +			return -EIO;
> +		}
> +		epp = (s16) perf_caps.energy_perf;
> +	}
> +
> +	return epp;
> +}
> +#endif
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
> +	case HWP_EPP_PERFORMANCE:
> +		index = EPP_INDEX_PERFORMANCE;
> +		break;
> +	case HWP_EPP_BALANCE_PERFORMANCE:
> +		index = EPP_INDEX_BALANCE_PERFORMANCE;
> +		break;
> +	case HWP_EPP_BALANCE_POWERSAVE:
> +		index = EPP_INDEX_BALANCE_POWERSAVE;
> +		break;
> +	case HWP_EPP_POWERSAVE:
> +		index = EPP_INDEX_POWERSAVE;
> +		break;
> +	default:
> +			break;
> +	}
> +
> +	return index;
> +}
> +
> +#ifdef CONFIG_ACPI_CPPC_LIB
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
> +#endif
> +
>  static inline int pstate_enable(bool enable)
>  {
>  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> @@ -70,11 +194,21 @@ static inline int pstate_enable(bool enable)
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
> +		if (!cppc_active) {
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	return ret;
> @@ -417,7 +551,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  		return;
>  
>  	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -591,10 +725,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  	return sprintf(&buf[0], "%u\n", perf);
>  }
>  
> +static ssize_t show_energy_performance_available_preferences(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	int i = 0;
> +	int ret = 0;
> +
> +	while (energy_perf_strings[i] != NULL)
> +		ret += sysfs_emit(buf, "%s", energy_perf_strings[i++]);
> +
> +	ret += sysfs_emit(buf, "\n");
> +
> +	return ret;
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
> +	return  sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
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
> @@ -603,6 +788,429 @@ static struct freq_attr *amd_pstate_attr[] = {
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
> +static inline void update_boost_state(void)
> +{
> +	u64 misc_en;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = all_cpu_data[0];
> +	rdmsrl(MSR_K7_HWCR, misc_en);
> +	global_params.cppc_boost_disabled = misc_en & BIT_ULL(25);
> +}
> +
> +static bool amd_pstate_acpi_pm_profile_server(void)
> +{
> +	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
> +	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int amd_pstate_init_cpu(unsigned int cpunum)
> +{
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = all_cpu_data[cpunum];
> +	if (!cpudata) {
> +		cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> +		if (!cpudata)
> +			return -ENOMEM;
> +		WRITE_ONCE(all_cpu_data[cpunum], cpudata);
> +
> +		cpudata->cpu = cpunum;
> +
> +		if (cppc_active) {
> +			if (amd_pstate_acpi_pm_profile_server())
> +				cppc_boost = true;
> +		}
> +
> +	}
> +	cpudata->epp_powersave = -EINVAL;
> +	cpudata->epp_policy = 0;
> +	pr_debug("controlling: cpu %d\n", cpunum);
> +	return 0;
> +}
> +
> +static int __amd_pstate_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> +	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int rc;
> +	u64 value;
> +
> +	rc = amd_pstate_init_cpu(policy->cpu);
> +	if (rc)
> +		return rc;
> +
> +	cpudata = all_cpu_data[policy->cpu];
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		goto free_cpudata1;
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
> +	policy->min = min_freq;
> +	policy->max = max_freq;
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
> +	update_boost_state();
> +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
> +
> +	policy->min = policy->cpuinfo.min_freq;
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC))
> +		policy->fast_switch_possible = true;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
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
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	ret = __amd_pstate_cpu_init(policy);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Set the policy to powersave to provide a valid fallback value in case
> +	 * the default cpufreq governor is neither powersave nor performance.
> +	 */
> +	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	pr_debug("CPU %d exiting\n", policy->cpu);
> +	policy->fast_switch_possible = false;
> +	return 0;
> +}
> +
> +static void amd_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = policy = cpufreq_cpu_get(cpu);
> +
> +	if (!policy)
> +		return;
> +
> +	refresh_frequency_limits(policy);
> +	cpufreq_cpu_put(policy);
> +}
> +
> +static void amd_pstate_epp_update_limits(unsigned int cpu)
> +{
> +	mutex_lock(&amd_pstate_driver_lock);
> +	update_boost_state();
> +	if (global_params.cppc_boost_disabled) {
> +		for_each_possible_cpu(cpu)
> +			amd_pstate_update_max_freq(cpu);
> +	} else {
> +		cpufreq_update_policy(cpu);
> +	}
> +	mutex_unlock(&amd_pstate_driver_lock);
> +}
> +
> +static int cppc_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
> +
> +static inline void amd_pstate_boost_up(struct amd_cpudata *cpudata)
> +{
> +	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
> +	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
> +	u32 max_limit = (hwp_req & 0xff);
> +	u32 min_limit = (hwp_req & 0xff00) >> 8;
> +	u32 boost_level1;
> +
> +	/* If max and min are equal or already at max, nothing to boost */
> +	if (max_limit == min_limit)
> +		return;
> +
> +	/* Set boost max and min to initial value */
> +	if (!cpudata->cppc_boost_min)
> +		cpudata->cppc_boost_min = min_limit;
> +
> +	boost_level1 = ((AMD_CPPC_NOMINAL_PERF(hwp_cap) + min_limit) >> 1);
> +
> +	if (cpudata->cppc_boost_min < boost_level1)
> +		cpudata->cppc_boost_min = boost_level1;
> +	else if (cpudata->cppc_boost_min < AMD_CPPC_NOMINAL_PERF(hwp_cap))
> +		cpudata->cppc_boost_min = AMD_CPPC_NOMINAL_PERF(hwp_cap);
> +	else if (cpudata->cppc_boost_min == AMD_CPPC_NOMINAL_PERF(hwp_cap))
> +		cpudata->cppc_boost_min = max_limit;
> +	else
> +		return;
> +
> +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> +	hwp_req |= AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
> +	wrmsrl(MSR_AMD_CPPC_REQ, hwp_req);
> +	cpudata->last_update = cpudata->sample.time;
> +}
> +
> +static inline void amd_pstate_boost_down(struct amd_cpudata *cpudata)
> +{
> +	bool expired;
> +
> +	if (cpudata->cppc_boost_min) {
> +		expired = time_after64(cpudata->sample.time, cpudata->last_update +
> +					cppc_boost_hold_time_ns);
> +
> +		if (expired) {
> +			wrmsrl(MSR_AMD_CPPC_REQ, cpudata->cppc_req_cached);
> +			cpudata->cppc_boost_min = 0;
> +		}
> +	}
> +
> +	cpudata->last_update = cpudata->sample.time;
> +}
> +
> +static inline void amd_pstate_boost_update_util(struct amd_cpudata *cpudata,
> +						      u64 time)
> +{
> +	cpudata->sample.time = time;
> +	if (smp_processor_id() != cpudata->cpu)
> +		return;
> +
> +	if (cpudata->sched_flags & SCHED_CPUFREQ_IOWAIT) {
> +		bool do_io = false;
> +
> +		cpudata->sched_flags = 0;
> +		/*
> +		 * Set iowait_boost flag and update time. Since IO WAIT flag
> +		 * is set all the time, we can't just conclude that there is
> +		 * some IO bound activity is scheduled on this CPU with just
> +		 * one occurrence. If we receive at least two in two
> +		 * consecutive ticks, then we treat as boost candidate.
> +		 * This is leveraged from Intel Pstate driver.
> +		 */
> +		if (time_before64(time, cpudata->last_io_update + 2 * TICK_NSEC))
> +			do_io = true;
> +
> +		cpudata->last_io_update = time;
> +
> +		if (do_io)
> +			amd_pstate_boost_up(cpudata);
> +
> +	} else {
> +		amd_pstate_boost_down(cpudata);
> +	}
> +}
> +
> +static inline void amd_pstate_cppc_update_hook(struct update_util_data *data,
> +						u64 time, unsigned int flags)
> +{
> +	struct amd_cpudata *cpudata = container_of(data,
> +				struct amd_cpudata, update_util);
> +
> +	cpudata->sched_flags |= flags;
> +
> +	if (smp_processor_id() == cpudata->cpu)
> +		amd_pstate_boost_update_util(cpudata, time);
> +}
> +
> +static void amd_pstate_clear_update_util_hook(unsigned int cpu)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> +
> +	if (!cpudata->update_util_set)
> +		return;
> +
> +	cpufreq_remove_update_util_hook(cpu);
> +	cpudata->update_util_set = false;
> +	synchronize_rcu();
> +}
> +
> +static void amd_pstate_set_update_util_hook(unsigned int cpu_num)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu_num];
> +
> +	if (!cppc_boost) {
> +		if (cpudata->update_util_set)
> +			amd_pstate_clear_update_util_hook(cpudata->cpu);
> +		return;
> +	}
> +
> +	if (cpudata->update_util_set)
> +		return;
> +
> +	cpudata->sample.time = 0;
> +	cpufreq_add_update_util_hook(cpu_num, &cpudata->update_util,
> +						amd_pstate_cppc_update_hook);
> +	cpudata->update_util_set = true;
> +}
> +
> +static void amd_pstate_epp_init(unsigned int cpu)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> +	u32 max_perf, min_perf;
> +	u64 value;
> +	s16 epp;
> +	int ret;
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
> +		cpudata->epp_powersave = epp;
> +		if (epp < 0)
> +			goto skip_epp;
> +		/* force the epp value to be zero for performance policy */
> +		epp = 0;
> +	} else {
> +		if (cpudata->epp_powersave < 0)
> +			goto skip_epp;
> +		/* Get BIOS pre-defined epp value */
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		if (epp)
> +			goto skip_epp;
> +		epp = cpudata->epp_powersave;
> +	}
> +	/* Set initial EPP value */
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +	}
> +
> +skip_epp:
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	if (!ret)
> +		cpudata->epp_cached = epp;
> +}
> +
> +static void amd_pstate_set_max_limits(struct amd_cpudata *cpudata)
> +{
> +	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
> +	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
> +	u32 max_limit = (hwp_cap >> 24) & 0xff;
> +
> +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> +	hwp_req |= AMD_CPPC_MIN_PERF(max_limit);
> +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req);
> +}
> +
> +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata;
> +
> +	if (!policy->cpuinfo.max_freq)
> +		return -ENODEV;
> +
> +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> +				policy->cpuinfo.max_freq, policy->max);
> +
> +	cpudata = all_cpu_data[policy->cpu];
> +	cpudata->policy = policy->policy;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {

X86_FEATURE_CPPC indicated the MSR support, but I believe the share memory
CPU also has the EPP, right?

> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +			amd_pstate_clear_update_util_hook(policy->cpu);
> +			amd_pstate_set_max_limits(cpudata);
> +		} else {
> +			amd_pstate_set_update_util_hook(policy->cpu);

May I know why amd processors also needs to set and update util hook?

> +		}
> +
> +		if (boot_cpu_has(X86_FEATURE_CPPC))

I am confused why if (boot_cpu_has(X86_FEATURE_CPPC) is still inside of a
if (boot_cpu_has(X86_FEATURE_CPPC)).

> +			amd_pstate_epp_init(policy->cpu);
> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
> +					   struct cpufreq_policy_data *policy)
> +{
> +	update_boost_state();
> +	cpufreq_verify_within_cpu_limits(policy);
> +}
> +
> +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> +{
> +	amd_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> +	return 0;
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -616,8 +1224,20 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.attr		= amd_pstate_attr,
>  };
>  
> +static struct cpufreq_driver amd_pstate_epp_driver = {
> +	.flags		= CPUFREQ_CONST_LOOPS,
> +	.verify		= amd_pstate_epp_verify_policy,
> +	.setpolicy	= amd_pstate_epp_set_policy,
> +	.init		= amd_pstate_epp_cpu_init,
> +	.exit		= amd_pstate_epp_cpu_exit,
> +	.update_limits	= amd_pstate_epp_update_limits,
> +	.name		= "amd_pstate_epp",
> +	.attr		= amd_pstate_epp_attr,
> +};
> +
>  static int __init amd_pstate_init(void)
>  {
> +	static struct amd_cpudata **cpudata;
>  	int ret;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> @@ -644,7 +1264,8 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (!cppc_active)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -652,6 +1273,10 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>  	}
>  
> +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +	if (!cpudata)
> +		return -ENOMEM;
> +	WRITE_ONCE(all_cpu_data, cpudata);
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> @@ -659,9 +1284,9 @@ static int __init amd_pstate_init(void)
>  		return ret;
>  	}
>  
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
>  	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> +		pr_err("failed to register amd pstate driver with return %d\n",
>  		       ret);
>  
>  	return ret;
> @@ -676,8 +1301,14 @@ static int __init amd_pstate_param(char *str)
>  	if (!strcmp(str, "disable")) {
>  		cppc_load = 0;
>  		pr_info("driver is explicitly disabled\n");
> -	} else if (!strcmp(str, "passive"))
> +	} else if (!strcmp(str, "passive")) {
>  		cppc_load = 1;
> +		default_pstate_driver = &amd_pstate_driver;
> +	} else if (!strcmp(str, "active")) {
> +		cppc_active = 1;
> +		cppc_load = 1;
> +		default_pstate_driver = &amd_pstate_epp_driver;
> +	}
>  
>  	return 0;
>  }
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 1c4b8659f171..888af62040f1 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -25,6 +25,7 @@ struct amd_aperf_mperf {
>  	u64 aperf;
>  	u64 mperf;
>  	u64 tsc;
> +	u64 time;
>  };
>  
>  /**
> @@ -47,6 +48,18 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_powersave: Last saved CPPC energy performance preference
> +				when policy switched to performance
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @sched_flags: Store scheduler flags for possible cross CPU update
> + * @update_util_set: CPUFreq utility callback is set
> + * @last_update: Time stamp of the last performance state update
> + * @cppc_boost_min: Last CPPC boosted min performance state
> + * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
> + * @update_util: Cpufreq utility callback information
> + * @sample: the stored performance sample
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +85,28 @@ struct amd_cpudata {
>  
>  	u64	freq;
>  	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_powersave;
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u32	sched_flags;
> +	bool	update_util_set;
> +	u64	last_update;
> +	u64	last_io_update;
> +	u32	cppc_boost_min;
> +	u64	cppc_cap1_cached;
> +	struct	update_util_data update_util;
> +	struct	amd_aperf_mperf sample;
> +};
> +
> +/**
> + * struct amd_pstate_params - global parameters for the performance control
> + * @ cppc_boost_disabled wheher the core performance boost disabled
> + */
> +struct amd_pstate_params {
> +	bool cppc_boost_disabled;
>  };
>  
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 
