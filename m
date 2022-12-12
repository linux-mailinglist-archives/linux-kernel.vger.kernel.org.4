Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57972649A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiLLIrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLLIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:47:07 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E5CE008;
        Mon, 12 Dec 2022 00:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M528QOCzhzhRfVYBI8MfmYcXLUT8gNRQ2Ih0s7quuf177wlKyDuY/9n/PLW5ExCXX/4hFTt+LbbXkhIVARc0wnn4kwrwGiv5EWaAXxxUMUN4QQGWln/Zzt1ObO3V/je37JLnVE4JgxZxjQBJ38IcCI+8gLyCZGleKEjZ9knZPxUHLDUii+wjFm5fF58jLdVN6LR+V8iNoS+nTYFEZuViP4eaFNveHuwLmuP382rDQ5+Zcbt354s7UiOpNo7BIMirznrCSsh1dpRNb97y+8AWJRcEH/d7hAhcdxhjpuRK5XI1GBojOuLVOw/iVmElqYWLWmIvWsSunqeUpKpywqJy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxtE20wOJWElqfTjmMo7EAGmc83EZtrZdxqWujbRSGY=;
 b=m4/ocOIiufPr5RdZqtG8/VQ2ZydXP0Jx96xnLPy1nj8qQ0+gmp+1LG5kwtRDqEBz1HP4sDWABAlSKTpinVfWtBcDpU3seHERkVFaAR2eLBcjL5cfnePRn0KfuOd8vifR5M7UWzROfqz7zAF98N9F+QvxEJY24PuORw6HWfy5RdOWnxxMy7H1IOm21tSYToe6RU40v8SzBu3gu/YHXsrizGq2BkfozgWNsVZfnsV5fdfQpK0Pw1hk9rt6KcR1tJgwb3OYINn56J1kcsHYCKDSzRLJ6Z7NqVcXrhc91jgARd9jne7JZj5hk3ZIjj/8exleR39I64fvVplKkFcqQaLilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxtE20wOJWElqfTjmMo7EAGmc83EZtrZdxqWujbRSGY=;
 b=YSNLx7JgtQHz69VPlD09FIsozjebaOQ2YfvHlWtwH9qACM6eBF3umSd6gOlygnk5NP2Mm38CgCLkx5w2tmSj0mtUUk6/MmnSluhu24ss+NFWDs9eTh2KYy1TFALymWjFiRGxkIYuRGhsdD98LfdOaiPwnIDnaJoPSJ7H8qR3W04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 08:47:02 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 08:47:02 +0000
Date:   Mon, 12 Dec 2022 16:46:40 +0800
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
Subject: Re: [PATCH v7 05/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Message-ID: <Y5bqWMJPqke5gdL1@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-6-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111852.386731-6-perry.yuan@amd.com>
X-ClientProxiedBy: TYAPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:404:28::21) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5dca3c-f6ad-4947-9c62-08dadc1d6fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwDgcPSw58492Z2X1ltijPik3OQf+BL58Z8tSme+ibSFjV25V9VZtE0JhHwN5HDmxNxaUdzDMvvKtqGiwRQC+heklAfCpAkpxzrxuciAy9L9WFxvHywoa5dvOFNw2283489qOYFTLtLZUBakoJSexXmZMe/Hox7hcf8hDbVjRK1RNq/oX7M3XtXkpEDl/FUgRRe/SPx4L8Aa1mPugMwpVesTbcenljOU5k9dLw175or/xc87/lol4FQtjouyJLNbNHYJsoGLXHFEBGZ6nasGa+3Kv6PgnpgtWOMswM5GmxE64pBoNmp5W1Y8tS98W3t+0DMyV9KACLlzHvRDNkvNFjomokGiWzgJ2YmRDimirAL2gnkt52kBL//eGnuzj9MaD9Zkz/AsQi+rZD1CUvLzo0chGWlE638ALlM0lLWe0mwcIFcycCJ8wPh3Wav6tmzvt6P4J6Jbne54929X5SinR7jUv1AQerU+tggRJ9EEbqL/TPtKjy/vRuuCd023Ih5xFimEp22iVxPChLPTRHayzAGMrJu6C1q7/wBH1ikohjhCs9mRxD3ejmUWxfGEBfoX/u4O4/VoiX9LwTH5ppNZkAwLbEGEdgtFKCJ3NjMCK4Jw+K+LLa9nDuy40w8wQLCvRAw5t46YBxhqw066QCjHcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(36756003)(4326008)(66476007)(66946007)(2906002)(66556008)(38100700002)(54906003)(6636002)(37006003)(316002)(8676002)(86362001)(26005)(6666004)(6506007)(186003)(6862004)(478600001)(41300700001)(5660300002)(8936002)(6486002)(2616005)(30864003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zi/5Ngqky/cRWFplBcg45AXpvxvD2lMfX7tU+tLfmHu+1hTM8UTGAmbQ1btG?=
 =?us-ascii?Q?UETcGTNvxIYwf4X2F6wFm5/xSxR/0Bee6eFhFnUNl6+S36sHImgJIVze/Kh7?=
 =?us-ascii?Q?oQefI1TrdOBNAFSzFmCUudxs7lKDzE/hCf5WeScZNdISeJByRsWfVuPNN0Ri?=
 =?us-ascii?Q?0Z895qvDQ88kICuv02d9nN7ruGcTSDrpMZcN2KybN9+WHeAyoMLKtLfVV5wD?=
 =?us-ascii?Q?6cX2qylG0XQI/q0epriVKT5/clg/gdZc8wP3lfYV/Y+imvMwWC8rk+O9l2r0?=
 =?us-ascii?Q?EPaOqIxDXtXrSuxOL5hWoKdYT3S6x0AP6XnnfdmySD/q+F5N/hN0VcilqHSn?=
 =?us-ascii?Q?dLbM/+DM7XBP4gH2suK+eoX6VY7dsHL6OUNv3bEeQj9AwBlXf5tWSLI2Nq5f?=
 =?us-ascii?Q?9DFpbZwg2vWCAv3D7LcHRiIzSqhKbx06BM5H3hqLyzQCXAq5e8U4hXOq5F7+?=
 =?us-ascii?Q?TBduYtn2eed7UwE3+vct3ksRjm12/qGyaU2ujIzjdb3wC9enrpwmhLf/6ly+?=
 =?us-ascii?Q?0bbg9m4Lu8p1rpwq315v3Uqx9wCm+xFvCPdr3v+R3JLXvCWYkeD/Ks0bO4IE?=
 =?us-ascii?Q?M2sgDfxDyROca3L62g2JC01aHX83QJpjvH/oI509hiMHaLUWDeOZY9k0eaqe?=
 =?us-ascii?Q?YaDIhcmveqZw1KII6DQ0kEoSeOLCCJwl4TA2HoHArIAxEBLRUJyPi4kxVycm?=
 =?us-ascii?Q?r9okRHur6ex2wWFrFuHEcZgnXxYKgnoPuWT+CWIxR3aAplgGM3VQqsL/Qs2A?=
 =?us-ascii?Q?SSOfJ1MHws1g4iv0bKnFZtwqZbjxDxI94oYVOsBKMXckUrKLjEYYMQWjFkoE?=
 =?us-ascii?Q?TBjgz1DHPZvwhgM50i6OaAlDniTfnN2FIxJVxRVASD5LMPxMZ7jim9HeBJ1m?=
 =?us-ascii?Q?hgPESmPFCmvRF8PDU83QQfuC8y2N/yTZWYtcQSs0Xm67ic3vyV2Vdn4WW3qS?=
 =?us-ascii?Q?PlRiNew4JiCAuzvyqqd5V1kSVAKkS+s12YGUrSLZ19pqSP6QOfwZvNT5yfjS?=
 =?us-ascii?Q?eirz8XDLm4z7YKOuz/TXH3bn5NlM2hFGfBngfL9Xc4/hMvFV5Of1DMutbuUm?=
 =?us-ascii?Q?+s0vI64IamQRc9tB6WGaqMduQcBXWOrCClylIvS+cdg1q1+1CK6lO5PaAntw?=
 =?us-ascii?Q?byi4z26mBBeYbEmXHBio/+CMe9QJyacDOnr/xJMYl1RJgw9Bus4uKPdoEPYR?=
 =?us-ascii?Q?0q72MR3dg/d4NYNqbIgCuiCbUmbe0bMWZtLlqzRg8YULRuQVbFD5UIO8f8lj?=
 =?us-ascii?Q?03qm6p5aNs4eMZMPzo1Po2qPU5Z1vEmy7m1qziMR7dkF5gT3on6s9meWwb9o?=
 =?us-ascii?Q?olX65JjeJZOaNjzgiYXW6yCgLXObhCTsi53jtxvhR4OkfelDTxJtmPVN7FXO?=
 =?us-ascii?Q?2LV1DyTEFOhUwaCqieY7kOroA5JWEq7FtfaJAHITJdpFBWzcHuS57Tm+FwFq?=
 =?us-ascii?Q?9F4zxJOeRjNiw0diKx8kIpHpXkbdtzdOutGqQLxDe729Fcnr0jA1VUCla2QX?=
 =?us-ascii?Q?6byL7GbJR/6R1Q6Kw++MwdbivQTl8KAjVrcAe3PuUO2variddJqCV6GVgi4J?=
 =?us-ascii?Q?WjbZe3DgmCIucRi/S59SJ/7PliPatdfPmW8r1i8g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5dca3c-f6ad-4947-9c62-08dadc1d6fff
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 08:47:02.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4CtID8ZjoYkhwABBF1p4eJPm4tacF7tVtCd29Zq6lsBfdk4k5yUw/zg9wj9DHiz1dQqA5NRKuO+WMby3rqRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:18:44PM +0800, Yuan, Perry wrote:
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
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 631 ++++++++++++++++++++++++++++++++++-
>  include/linux/amd-pstate.h   |  35 ++
>  2 files changed, 660 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c17bd845f5fc..0a521be1be8a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -37,6 +37,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  #include <linux/amd-pstate.h>
> +#include <linux/cpufreq_common.h>
>  
>  #include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
> @@ -59,9 +60,125 @@
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
> +
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

It should align the static_call structure to implement the function. Please
refer amd_pstate_init_perf. I think it can even re-use the init_perf to get
the epp cap value.

> +	}
> +
> +	return epp;
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

Since the energy_perf is one of members of struct cppc_perf_ctrls, could we
use cppc_set_perf as well?

> +		if (ret) {
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +		cpudata->epp_cached = epp;
> +	}
> +
> +	return ret;
> +}

The same with above, the helpers for different cppc types of processors
such as MSR or share memory should be implemented by static_call.

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
> @@ -70,11 +187,21 @@ static inline int pstate_enable(bool enable)
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
> @@ -418,7 +545,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  		return;
>  
>  	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -592,10 +719,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
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
> @@ -604,6 +782,424 @@ static struct freq_attr *amd_pstate_attr[] = {
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

I won't need introduce the additional cppc_boost_disabled here. The
cpufreq_driver->boost_enabled and cpudata->boost_supported can manage this
function.

I believe it should be the firmware issue that the legacy ACPI Boost state
will impact the frequency of CPPC. Could you move this handling into the
cpufreq_driver->set_boost callback function to enable boost state by
default.

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

The cppc_active is a bit confused here, if we run into amd-pstate driver,
the cppc should be active. I know you want to indicate the different driver
mode you are running. Please use an enumeration type to mark it different
mode such as PASSIVE_MODE, ACTIVE_MODE, and GUIDED_MODE (Wyes proposed).

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

Please move this line into below if-case.

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

I don't see any reason that we need to define a __amd_pstate_cpu_init()
here. Intel P-State driver's __intel_pstate_cpu_init() is used both on
intel_pstate_cpu_init and intel_cpufreq_cpu_init.

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

Why do you name this function "update max frequency"?

We won't have the differnt cpudata->pstate.max_freq and
cpudata->pstate.turbo_freq on Intel P-State driver.

I think in fact we don't update anything here.

> +{
> +	struct cpufreq_policy *policy = policy = cpufreq_cpu_get(cpu);

struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);

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

This should do nothing in the amd-pstate.

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

We can use cpudata->max_perf and cpudata->min_perf directly.

> +	u32 boost_level1;
> +
> +	/* If max and min are equal or already at max, nothing to boost */

I believe this is the only case that max_perf == min_perf, not at max.

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

Could you please elaborate the reason that you separate the min_perf
(cppc_boost_min) you would like to update into cppc_req register as these
different cases? Why we pick up these cases such as (min + nominal)/2, and
around nominal? What's the help to optimize the final result? - I am
thinking the autonomous mode is handled by SMU firmware, we need to provide
some data that let us know it influences the final result.

> +
> +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> +	hwp_req |= AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
> +	wrmsrl(MSR_AMD_CPPC_REQ, hwp_req);

Do we need an update for share memory processors? In other words, epp is
also supported on share memory processors. - again, we should use
static call to handle the msr and cppc_acpi stuff.

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

I would like to know whether we can hit this case as well? If we can find
or create a use case to hit it in our platforms, I am fine to add it our
driver as well. If not, I don't suggest it we add them at this moment. I
hope we have verified each code path once we add them into the driver.

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

I didn't see where we should have epp_powersave here. Only initial this,
but it won't be used anywhere.

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
> +	amd_pstate_set_epp(cpudata, epp);
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
> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +			amd_pstate_clear_update_util_hook(policy->cpu);
> +			amd_pstate_set_max_limits(cpudata);
> +		} else {
> +			amd_pstate_set_update_util_hook(policy->cpu);
> +		}
> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +	}
> +	amd_pstate_epp_init(policy->cpu);
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

amd_pstate_verify_cpu_policy and amd_pstate_epp_verify_policy can be
squeezed in one function.

> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -617,8 +1213,20 @@ static struct cpufreq_driver amd_pstate_driver = {
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
> @@ -645,7 +1253,8 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (!cppc_active)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -653,6 +1262,10 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>  	}
>  
> +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +	if (!cpudata)
> +		return -ENOMEM;
> +	WRITE_ONCE(all_cpu_data, cpudata);

Why we cannot use cpufreq_policy->driver_data to store the cpudata? I
believe the cpudata is per-CPU can be easily get from private data.

>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> @@ -660,9 +1273,9 @@ static int __init amd_pstate_init(void)
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
> @@ -677,8 +1290,14 @@ static int __init amd_pstate_param(char *str)
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

This should not be defined in include/linux/amd-pstate.h, because it's only
used in amd-pstate.c.

Thanks,
Ray
