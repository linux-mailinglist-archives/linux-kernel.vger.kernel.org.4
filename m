Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46155654B13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiLWCRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiLWCRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:17:24 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD6139;
        Thu, 22 Dec 2022 18:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWeZkG9xyIrKSv/Y1SRp7lZS4w3BlVIhnadE0sytQ3eI/pxZN6SLIPu/ql62xaoX0axSfWAC62XV/Im7H6yg1KwH13PKQSiupGlffQMwusqudEAk+jGUsDB/4HZBdAr4FbCchBm+zeiJ9sSM7UeDX81YNbV8Mu6mNixj1f81Mfg7WIIm+OLzUJH/ietIs9a/QPc9dNEENkWeMmMH7DFZt+jRKsYhSg4uTYpOgLTjDxvR6tpg2itENHOhi6unvXCGYzIwdZSJ0AorJvQU7UEGgnsvOYoGBLpnuTSvSxaD6XxV5sGKE2LJ1MGI4iuGEMFHUYHCY0GvqDPraxD1h2V6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of7+qoeGOk2vtJAw3Mm3+/qGmXxl3YGKMjgZZIKpF9Q=;
 b=M4FEVxoJtCqbTfP7bxkdEB7KNMd8w0F68vrhE6SKQ82mnFDjK10RX2zFmrPejU3XGAzDhlNnphE5KrPjFzbbvCmX8G9rPmVfa4NXYH4o9nQO1wH3XQursk4paorsF+qxVVS/GyuP/f85e9xZT2fsVXcPSfDd4/TPUnJIjqAVkop03cOlnlLDSqdb5hAiu+3CjsVLqk8R/roMQHgxuwbjIUpNTO1Y1404WNcQ7VMkZL2x3XZrBRDYgTZgnbXA6r1z73fZZXf1Wqv1pATmdsHtDshYXCSBUpCVuUtbAhr4Pc808eyqKsOC56TJnMr9JFLzU4u3Mb1HW2yL1EvbOSEE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of7+qoeGOk2vtJAw3Mm3+/qGmXxl3YGKMjgZZIKpF9Q=;
 b=FmaakBpEoK5H0fVXVx3t0XCsy1CjTTlYTQkRUD+LiYlo1O0PWbf8ykPEyUysXcaBOAbR7qSkPjFyNEzzy0UPPPZyjS/DTwBSKdPfCcN/LkC8jNkzqUCKckndJcBxifrYBNjp1qys64DJ53c7UFdLjGevKACSDxN9WX/YFjqUN3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 02:16:28 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 02:16:28 +0000
Date:   Fri, 23 Dec 2022 10:16:06 +0800
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
Subject: Re: [PATCH v8 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Message-ID: <Y6UPZgtFvlJm3bVR@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-2-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219064042.661122-2-perry.yuan@amd.com>
X-ClientProxiedBy: TY2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:404:e2::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: b32ab645-b177-4b88-3240-08dae48bb2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtMvdbmwBNhS0XMZPlmQlPiBc9EO/VoGeOMaSkpYuKkt/FAn5z/npfEg+bM7zZ7v30XigicIGYYkjGE7xYRDd1nVYzYrXNd9dF8N9MN+1rnZdgK8urEqUpeBAb4rP6E9ADddjHfVLDIBaTOBYXtZQ0B9lu9ydsEiips2CbB9NUeLz4+1brWPLdspy8iYAfOUhIDOJ1djv7R2Ch+YgOwreIWInBrJPsgeLnqwNaLK+3ALkuQFiJljv2NaAzhKWNWfBdz/P62KqO2HuLqgu/QhNn7Adye9lvlleMVngPz0gmuw6mfP6B9PxGgfAXKMb9WJ78QOw9XN/8/11pbnz/hRkZ4DaXDkfP0gYCbFXiJ0UY0P5H8bOSNlL1VMnZ4e0+DnVx9bDzWxFO/ZKHFh1BgVtGTVkCfzmbuo3UP5dOi4WhX2l5YmJRktQs0bxsCr9FRMEX1PtfMZEiXNEXH40QeisATbDH0pjPYJ5aSTBMy1hFKI09KDGcNI3Y+30g4pQACEkUrrpsVbhOEXCJTB435sazy8YLRlkwoInKNrbefw1d704mKNtc05k7+/JH/zTPgt+a1iaV7ynJobBZpZ+IEJSb7LiUB/nTRvVDTwjvOwv22MMzL71c1+M/HjE0X6W6WoHVbE4lpBlDhFQeXwWaQRzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(66946007)(66556008)(8676002)(4326008)(316002)(6862004)(5660300002)(37006003)(36756003)(66476007)(8936002)(86362001)(2616005)(6666004)(26005)(186003)(6512007)(6506007)(83380400001)(41300700001)(38100700002)(54906003)(2906002)(6486002)(6636002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?krZlxjNdwd9jn1zXkP+r1w7gdEKWrV6dr3Av+S+ZHXmLnh9SZiF7n8sSGXC5?=
 =?us-ascii?Q?Gkj6DBpmmvnaG2h9OjXuxApLyey+64bL/GJmJRLVOx/qJ6mFD5Bl4Hc8UXgt?=
 =?us-ascii?Q?46XBgeFsjBM5mzX6UJoerQoZ9SctO3JFLH/d85b0wAADTDFKzr02ZzdKvCVV?=
 =?us-ascii?Q?m7ACtHAA1dgNKCuvQ3kymr8matYfiVlSsCB5IznM50Bfh6j9WdyuZRlsrmps?=
 =?us-ascii?Q?x9I/J7p9rG3Amn6auzzoadE6BeIhkWfRh6aoRmIHP+akCoyeH9W7gUha8583?=
 =?us-ascii?Q?6b8q2K4X1eE3cMr3P9PNkdYik4oUH5xGjPccWS5ZPxkgcGasKG0RVMz20DHz?=
 =?us-ascii?Q?mecKct95riPAmdcD1wdB7H5ePKT9VuLbF10M9ZUVjcBhEKpbURR3Wfjm8yex?=
 =?us-ascii?Q?qE8BNTZbkC2L8I5zv8Wj3tZOHs5HPXaPyrkxap8l0sM/fqUV344AFUCpbn9v?=
 =?us-ascii?Q?y8sKPEB7ooVAMj9vvTr9reRi3dIuC+Aqb887RCHSmfngp8f1X6La9nfQFfJ4?=
 =?us-ascii?Q?C3CaIXZ7XyOgX+QpJpbnM+0bjNGRhDVTJI2ExfRAb4NCSu5ANM2FR4aMrkf7?=
 =?us-ascii?Q?LLhSLHqPdD6VH0TjLeRnLBdWQuTVtlulme/AZ/FL5YVrQ3ceP5QTjT6PvPbA?=
 =?us-ascii?Q?yzYrO88Sjkb+Oa9mIUmVpGzn5GAsskWZLV24Jgui445F6ZCpauAuQNpyPpT3?=
 =?us-ascii?Q?/nmPv9GlKqSCzUoMLDMTEbl/meBlu7WF2EXxwo6A5YTvjZK0c5O05vdAQY+l?=
 =?us-ascii?Q?92AWM4Bex67zROmCfPmDuHcK6YFAE6IAo470rc6Mlm9TBTXOKuEFwOVwSqUk?=
 =?us-ascii?Q?9cy0eES6/HqZc2pQ4fWavcT4fo/KxPe71YAZ0iWN2Th7M2hB8QwsJwq/RcEf?=
 =?us-ascii?Q?WegZwqeDwrga43btHvDkfDLbBu7Jp+9B84JxB12FGV0wItNAuY052JJ1sBvs?=
 =?us-ascii?Q?3PTZiXaF/qp2E7GMg9q76/Fir3MitoCzxA6DCrGHE45XTJJH1B/TtkZa3/j4?=
 =?us-ascii?Q?nNi+GnYItqXSESvDs7+vBur9RCQMRHZMQ2s1KB36gni58mDxYZXgtwGpSK1J?=
 =?us-ascii?Q?2fPH6Zf0Yg/NTKmKbZxWx1QaNzpDGCmD/cDJozHR3lVqBNV4+C2YZsWvI4g3?=
 =?us-ascii?Q?M4Z9XlutAT7cAVwkAjKZOgH6uh6GlsGyC75SkgHi3ZNoCumJPlqCwwMYIzpc?=
 =?us-ascii?Q?pWU+TBy4fPG+q4hQ3qJvoEoNy/J5DxdmzLIQaBaQsHCqEf17lFbAhpKuREt3?=
 =?us-ascii?Q?qqvuHdPLqM/tFndX2yiY/jsvo44fYJp9ClEg45oVYtg/kilnlYyPVkvFKEPV?=
 =?us-ascii?Q?umlqIQkZbOSitOHmUsRCXGXXEXEsvNDLi9XqxbzFMyPlpL5WFauDEebSjBqY?=
 =?us-ascii?Q?smHIhaKmFl6St+Y2lTkKAby4z/QClFi+Nvs2x+vnHlt9ZlwdLEZeOdOuByAK?=
 =?us-ascii?Q?96ve3mj+k1UP+StQgWjVHeBJN7iM02JbYVjrDf51FJoA2mysMMFfbLXdVDvk?=
 =?us-ascii?Q?AGOhmIqOxTAgu1ioT9uWa//TrLEFAJJg952Hcvu0V//f2YfR2uCTvhTpOuGI?=
 =?us-ascii?Q?iUnYo+oFgWfQ5Qq63EeW9ww+5Z2+92FzCSsjrfOI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32ab645-b177-4b88-3240-08dae48bb2e8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:16:28.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NV43ZoaK7Sy9SnRzxQl7E1QlDVHm+MrAaXJ3La9TVTSi/0SYaFjyN5sn0wCgKIgFgx+lS29S1YAPQquAPWYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:40:30PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add support for setting and querying EPP preferences to the generic
> CPPC driver.  This enables downstream drivers such as amd-pstate to discover
> and use these values
> 
> Downstream drivers that want to use the new symbols cppc_get_epp_caps
> and cppc_set_epp_perf for querying and setting EPP preferences will need
> to call cppc_set_epp_perf to enable the EPP function firstly.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 76 +++++++++++++++++++++++++++++++++++++---
>  include/acpi/cppc_acpi.h | 12 +++++++
>  2 files changed, 83 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..81081eb899ea 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>  {
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>  	struct cpc_register_resource *reg;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
>  
>  	if (!cpc_desc) {
>  		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1102,10 +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>  	reg = &cpc_desc->cpc_regs[reg_idx];
>  
>  	if (CPC_IN_PCC(reg)) {
> -		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> -		struct cppc_pcc_data *pcc_ss_data = NULL;
> -		int ret = 0;
> -

Do you have any specific reason to move this piece out of if-condition?

>  		if (pcc_ss_id < 0)
>  			return -EIO;
>  
> @@ -1125,7 +1124,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>  
>  	cpc_read(cpunum, reg, perf);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -1153,6 +1152,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>  }
>  
> +/**
> + * cppc_get_epp_perf - Get the epp register value.
> + * @cpunum: CPU from which to get epp preference value.
> + * @epp_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
> +{
> +	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
> +

This function is enough to get the epp value.

Thanks,
Ray

>  /**
>   * cppc_get_perf_caps - Get a CPU's performance capabilities.
>   * @cpunum: CPU from which to get capabilities info.
> @@ -1365,6 +1377,60 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>  
> +/*
> + * Set Energy Performance Preference Register value through
> + * Performance Controls Interface
> + */
> +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *epp_set_reg;
> +	struct cpc_register_resource *auto_sel_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
> +		if (pcc_ss_id < 0) {
> +			pr_debug("Invalid pcc_ss_id\n");
> +			return -ENODEV;
> +		}
> +
> +		if (CPC_SUPPORTED(auto_sel_reg)) {
> +			ret = cpc_write(cpu, auto_sel_reg, enable);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (CPC_SUPPORTED(epp_set_reg)) {
> +			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);
> +	} else {
> +		ret = -ENOTSUPP;
> +		pr_debug("_CPC in PCC is not supported\n");
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> +
>  /**
>   * cppc_set_enable - Set to enable CPPC on the processor by writing the
>   * Continuous Performance Control package EnableRegister field.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index c5614444031f..6b487a5bd638 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -108,12 +108,14 @@ struct cppc_perf_caps {
>  	u32 lowest_nonlinear_perf;
>  	u32 lowest_freq;
>  	u32 nominal_freq;
> +	u32 energy_perf;
>  };
>  
>  struct cppc_perf_ctrls {
>  	u32 max_perf;
>  	u32 min_perf;
>  	u32 desired_perf;
> +	u32 energy_perf;
>  };
>  
>  struct cppc_perf_fb_ctrs {
> @@ -149,6 +151,8 @@ extern bool cpc_ffh_supported(void);
>  extern bool cpc_supported_by_cpu(void);
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> +extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
> +extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>  #else /* !CONFIG_ACPI_CPPC_LIB */
>  static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> @@ -202,6 +206,14 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>  {
>  	return -ENOTSUPP;
>  }
> +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif /* !CONFIG_ACPI_CPPC_LIB */
>  
>  #endif /* _CPPC_ACPI_H*/
> -- 
> 2.34.1
> 
