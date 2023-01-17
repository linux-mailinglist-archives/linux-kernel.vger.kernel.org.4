Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB666DBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbjAQLLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbjAQLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:10:55 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C530E93;
        Tue, 17 Jan 2023 03:10:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsRgbXuYMVK8V6tFdZ/2dr4GNOUlL3cIth8QscyR7Tfl6jkwuzaXxHimG7WAdyXCj1bBfYYKgBYBmifTtcj3Krqvsp9Av++DTKCafLkChj3vTmm3P9C1xEirKYwVf5FXB7C9ipC0ciAkJXdSMBGA63CIpPYokQysb/DzluBIJ3ZO3O2un6nw75t+Kw0OIzsIsExlUr0xHpYLT6Ib/luqoOtUZV31IFfziTPBNhY+/jIgBZQ2MQSVx3DXxRRxitbHIHSkzey6ij4ovzh0LcgzKZnd/PzA1tCho+4bS6E04+MrPByBaHP8W3FTzLSi75Xv50K1+P4ZlJAA+i5PPNEUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC1DLJZNxq9nBHyvheQ/Mdlko5R1KWDbWs5wtmgCOWs=;
 b=eGkbeuPXf7kbhdbL1QKeR2G6uRt9q1phCWuR1yZezHttbaS9i58uxqDgv8OC7TkYzoes5n0fUYmMt70JzabYgvXE4j0DpSwntL5ZxUMY5q0JEcZW27pSCOUcgP9yONMbfyjfbnOjImI0IhgPfPOxvpk3EMn+91RBRk4ZWVWLCS3L/CLznjW8CWz10QPdAuVZMyMccAs4leaWyVwrBNVcbMGa2cXMTK2GOCoGDYTpDHGLpchWaA0Fh69/qprtsbzdDTmmbKTWFtybZVWeD50lIDZrIwR5xBp22TRUQqq7UqiMXmfPDgOKrrZTSd+Vev9pBiKI8W0QFiyo1ZXT2xMltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC1DLJZNxq9nBHyvheQ/Mdlko5R1KWDbWs5wtmgCOWs=;
 b=C/gkNlgtukn3JmhdfGrqgXf1B6EFF2nVqtWpjMIy6/LRRV6Ov+NozooxcATzWtd8UN5bza6iYq5Sc6H2tUsQlM516NxbnrZMBY2shBU5L/KHtAmW3QGQaeQaGTvtlayBwk/6fiM+wrB5XcF+lUlTkQBDVQEe0va1O6GTkD+cRmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 11:10:48 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 11:10:48 +0000
Date:   Tue, 17 Jan 2023 19:10:25 +0800
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
Subject: Re: [PATCH v10 01/12] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Message-ID: <Y8aCIdrozMPUd5Vy@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
 <20230106061420.95715-2-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106061420.95715-2-perry.yuan@amd.com>
X-ClientProxiedBy: TY1PR01CA0195.jpnprd01.prod.outlook.com (2603:1096:403::25)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BN9PR12MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: 7261d141-3895-46c6-ed8d-08daf87b7c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYMHjuZgN1uOYQ/W9qkt2dLN/qhFYjkPfuWMrU6D3Kce6w3cpkdb0n1oHi6JaZQGiLZk6pJt+k3DAziqjL121ZzEArcjWax82EwoSwsr/QawS/slMQHwwoCrcHFZhoCjRntyqNzql38iiZYzxFnCCfVvEPaL812PqIiqcSAWIS3+D+I7WO8RcH6QkEXRWXaGczEE5bfl7REoNZr8Vvw0VpnobVHEbpzOfBuNMNP/VefWFS0kQ+5mpWaPnEqUzRLBB3MNNtFDFBM5bEHEsTd7MNDwoQ42Xd0eazzya5BmCHnLVbSWl0qPVHcODKxYrvE8sv48ftxulmZL9Xbe9AZRGulxqmOzD7h9UAexwCEal/5Nb71XHO/OGfYlb1o4ij9mYmkdJ+9Q04bSLuZlFBrh6w2yQ11Wuq4/uzvFdLWH3IUq1sRIW+30gzmftNW728I4At4ZGxw0Wfnswv3sFv4dDomLcFyTTgXjsVth3ZomryFji34lpltzdbwYeRGUwtCdA0dYCa6WY7OqSy+LeQV3pg839irOxomgVOcI74SMdhAZlzuntjZ9hh22BTRxkajsdRcgUVgQeB6NHl+T18UEX1vjAX13wyXdv8A95g4qNP9Wmf8yOYUc/iRgYQbTepw2PFe4r0uzFdkiZDGBRlwGOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(38100700002)(36756003)(86362001)(6486002)(37006003)(66556008)(316002)(66946007)(4326008)(66476007)(8676002)(26005)(186003)(54906003)(478600001)(6636002)(2616005)(83380400001)(6512007)(6506007)(8936002)(6862004)(41300700001)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/oRerZtTSabWLEc5fV5So0TJo9TA4LfDeNe7V6uONDTDPISTAcufqkCjRdpn?=
 =?us-ascii?Q?gZvyThkCQ50o2xiBrdRRVV40QMWIQi4eLjx1PmoTrzOSgwHZAZDeUnRaccq1?=
 =?us-ascii?Q?UALXWgbhNpOshqkSb+BBNkMmgu7fCvHVZPsXYq5b7gsSnWFhIBg9PaTK2hI3?=
 =?us-ascii?Q?9KsmovXqds3OlAkY1b2E57JxzA/57lFux2Xy92UHa2J4za3mhy7wigLK/u8W?=
 =?us-ascii?Q?kyk0X+6G5vZqBfW7REszFXYhH1fLom2UObAelaVs+7UaBJD7ka9BnbDbKF8r?=
 =?us-ascii?Q?/YijP/G8xhEsprys2erZUR8tTDftVOY5E4HDkCLH6USeM6jekjHAU+TvDrhr?=
 =?us-ascii?Q?vqCUpphgUGI1js+lDWn5HtBjKCSu/wtgKDxGIXaHaGtT/vthD7e2y7/5EDpn?=
 =?us-ascii?Q?grKieD1gDdEOAhjvrzR7+pRru028zxn25YYqDxxkqB3Fupnq7jnXW2XV4Ybr?=
 =?us-ascii?Q?SCgO0Zxul3eYzsHQsM1H9416+Bz2P4UP66rt1clD6lh+R3ziwoRxlx1QEjg+?=
 =?us-ascii?Q?B+fD4z7NZDNjJ1ssTem7U8nS88Ta+Yh7cG/b99w+ogfcwZ0naGy0XDaNYvY2?=
 =?us-ascii?Q?m7AEteAv9SZ13q2T3r1CgTJ6rab0u4NAfZkeBGfhkrbuUXuZJaXqTxXxIbJN?=
 =?us-ascii?Q?ZBTXHdI7jdek4G2Z+L9+ooyke2/SyP45oRRWE4S4OwCpLZ9M5lQnK2sxnbOu?=
 =?us-ascii?Q?/bqyYR0YfP2UCukNdXpeKDnocRSjss6WZtL3lgCHey+Y/4cJNFnI+juKqNU3?=
 =?us-ascii?Q?OYW1Mhibp4sdgnrrD3TXVDjegHSRuy+OhrdNN9qjI9xjz9iA0kcsafypNT73?=
 =?us-ascii?Q?nHcrskA+RJAFJmG03axCubWWB3at2ICSx6/6ggXPuWGt5kSgVih3NQsL+ZCf?=
 =?us-ascii?Q?/Zm+EOx24e3SpI8qHuJGen+ZX/gp8nX0bHYSVf1wYcmLKYd1/WFeFsXHSblK?=
 =?us-ascii?Q?EqPftgzF/XlA1Unc1orTmAo2rHnoc7ffQe9okySAuUIq/qP5i8ostk3DJeOP?=
 =?us-ascii?Q?6ZJfq84QpeVZOMvT5TexE7pvv179fzY2gyiN1hwNpy5UPehu01/d6pSS8U+E?=
 =?us-ascii?Q?tXsak8kBq/tZ8cjOhC42+AkwgWGFYIYCA/05VK0SR50Ztj9ohEBL4U1D7k/V?=
 =?us-ascii?Q?B4rUUJChtI5xFwEJOxGuQJoAYNEZQC2LkYm7+53tEane2r4S/J1jMBTxpXFY?=
 =?us-ascii?Q?UwFaWncZSJi01slyvMFzr5LmNrTYXli5Hk/V7IYqvfK4UV7JDPXXA7PEbLck?=
 =?us-ascii?Q?Pegj+QDvXznH/uFHP1CuRgKdcXIwsosPQ68CNqFbwZV7uMg6LlWk7jldUe4W?=
 =?us-ascii?Q?9UePfxZsuzqZ8r1OfzzR2bfT7vBAgb+8rxHsPItJjyBWX0QlXkapFkYHjnvz?=
 =?us-ascii?Q?9KWob7EBz1gsWq9tVsNpTfO32j6h/UyCgvtiJiJqAF2pHzQBQl8eTQlX4lhp?=
 =?us-ascii?Q?tHUMKibBJeHme0VJJ/YItsg+JZZSwNZG9PJ2iLCE8Hb72YxgTWwOXvN/17g7?=
 =?us-ascii?Q?49ID0lfjdWnQoFSP4rfi9PONOUwMHMLABAOXJzqxE+yWDpSVkl6sISkRJ146?=
 =?us-ascii?Q?xAYKLrc+J5Z+kCl2k2IVm+NBFmlRej/pmxymNSPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7261d141-3895-46c6-ed8d-08daf87b7c81
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:10:48.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebQFx6GP/vKiqPBNDDnlukD6cY99+GJjdSizgH8NCGQdK8B534aN4eNj3w1+UaRtomfg8jPCvtDsRrH65fh/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:14:09PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add support for setting and querying EPP preferences to the generic
> CPPC driver.  This enables downstream drivers such as amd-pstate to discover
> and use these values.
> 
> Downstream drivers that want to use the new symbols cppc_get_epp_caps
> and cppc_set_epp_perf for querying and setting EPP preferences will need
> to call cppc_set_epp_perf to enable the EPP function firstly.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/acpi/cppc_acpi.c | 67 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h | 12 +++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..0ce6c55a76ca 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1153,6 +1153,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
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
>  /**
>   * cppc_get_perf_caps - Get a CPU's performance capabilities.
>   * @cpunum: CPU from which to get capabilities info.
> @@ -1365,6 +1378,60 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
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
> +	int ret;
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
> +			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
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
