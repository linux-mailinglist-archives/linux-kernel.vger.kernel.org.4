Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9B647ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLIHzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIHzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:55:32 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725AE51C12;
        Thu,  8 Dec 2022 23:55:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HINXxhDQkmEm/pcovCCpe0oSwDalamp2o5MQKiMJxpT6q+8+gm7KqBtjLGlQxP/UZDoZy2V60luv75JTKlprn0d5kfSa2Qrkw3sm0fjB7gLPyZkYG3UDamLLbmTq+GWXb2D/DnLmCTnaGv4rugDuCaNwlJeD26yBq1Uz3Fzn9ikpae65+pMaZtZeGd+403mKbxdodJWIuroJo4sFAfmfIhbRZZ28Q6Jm933sVqgmtXvWJJvW44NiYzSgMGb/E4P6aiTbQYeJvPe3k8jIP7eV1pmFbkb+tHTNOG/ZizgF0351NoroedrBf5CyaS5dYjuoCGLbpPp0fEdEDjCuvQoaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmrOh95mcBZMa5+oW3FmHSw0v4AmF/hTx1h8xgxXp/M=;
 b=S39f3Qs7a2slO+KBno3fS3TQAvaQhG76nRq//slN1whedtmMnjaFroQD9zQ+pHmjMPTEX7zScfB76EdVql2H4jrWmrrwdNt57/NUYjtdkeNetuMoQyKQVgcLsM0alDmFO1n5dZ7nYcde2gsnq0PDZQpd/wYdkYqD8rAk4jyxtmzYCf4A8gjBhH6uaeewPwzc7CjXOsWOE15HLl1Aygd3RUSikBYbiK7W+gfzCsQA5uhVLQn1I9pcaRNDmbzoQoCf41Nn3YiYhFUFJ7BK6qf1jWXjRVHKBeWajQg9SIjT8AmP4yUF7pu+D9pD2J4ZP6g0JRNnblaUNCIl92qdQlMsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmrOh95mcBZMa5+oW3FmHSw0v4AmF/hTx1h8xgxXp/M=;
 b=WgBcwFA8T7oeN3SET0xDIp/v7RzHkFrvvG1gfaWVUtxAFK3dN1Tl8m/e+6+AuJyHz74GhmJp8JpBafWFEx2YJO87Jr9mnHQYMiZpPNUr4lLQM8pKBSbBJIElPA5UTeSTBBkr53CTAYgMhWp9ZtMqCyfDDnER8Hk2HdIiR2UnvaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 07:55:28 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 9 Dec 2022
 07:55:28 +0000
Date:   Fri, 9 Dec 2022 15:55:02 +0800
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
Subject: Re: [PATCH v7 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Message-ID: <Y5Lp1n3ZuSsWjeEx@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-2-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111852.386731-2-perry.yuan@amd.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3097c3f6-22d3-404c-12d0-08dad9babc5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLkiiKQ3U7dGtHgK1b3ewX7+mgq3TsXdwVhaSz2UdAKTvK8DNRLIk0vA28xtq6qLvEpDmq658HBAfRJLLMN+eAQcox6tB21kPzQtLmCj5+1cA7HtEnMOAYQeRobco29+xPh7yh2oVR/yYvDLtDb+VMremVnmvqc2Q4ZeeSUu1Y9teKr7hE8okFIz4TdV/PfZgzNsqNvUX9y1WvYEhQOpaTplsXuO0MJX0w2r+t1a0RXXhO1YG6zhAh5EOKt4xWlfko9w+DT52YgKVxvmpZ0E0of5qcWqFdXPYaZQ9GWeqSuxZhgNEx9bsQjdt14G2zoRpOohLPf8R8Y+kYiBlILWsP3y/LGnC1y63nkcQ2NbSyeOdbkIixalInFLKdQHXAk7lgdYi8Bal8AdEgLFrVmre83U74L8PqJjTZL7dBrbj8I9VHG5TI3nwjrvWNLwf1EGqQizedOa8unFt8iG/1U/WjH+WQIOJUSlqDdGOulZ+VcC5FuNL/nt+IMISWkVM/OGsG4gVFtasVz99hONuEvoftpqNSrw3ltOR0KCWLzd0B/FhTVHeBpSC+cZ4/s+QJ81fZPlSeCDCvcKGLAMQ4fsf6uh6XGuoocbmAadh6sY8zkAOVEyTG5Iw3XNWsla1qxqdRqIV2gLWhbQHEMuHfuk0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(2906002)(66476007)(66556008)(6512007)(36756003)(83380400001)(4326008)(5660300002)(41300700001)(6636002)(54906003)(37006003)(316002)(8936002)(6862004)(6486002)(6666004)(8676002)(86362001)(6506007)(478600001)(66946007)(38100700002)(186003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FPbUdPI52MrI3lE8nG8zRXKt/nVL4zGbNfeXuzx/0Vef71AKm0TlGmzNDphA?=
 =?us-ascii?Q?lHEspyIV5KkEQiOPf6bRdVwF/682ETqn48BU4EJi06kfK2qsAz2UG72pMLXW?=
 =?us-ascii?Q?w4eEwAIM9NsKX+cmBrvTMqkn8hjmfjJIA+8QLgROF+Qlp89DFSfUrrx09vxb?=
 =?us-ascii?Q?RO3Z9t/rM17hTJzkVNWAyreC45GdQS++1FBljafUJcDzsDj6XxIs9B4Qkmvr?=
 =?us-ascii?Q?HkHQ1sl3KYR5iHSpSxZU0MZ6SgT62c+oPxNJFDk5pkFTEH4FyKkEMZPDxsDI?=
 =?us-ascii?Q?hqJe54iCQYOcYKihKX59ViA5i42WNzsRcTCMyg2KsEhh5Mq1ztThXza3jvm0?=
 =?us-ascii?Q?QP21Jj0FN0pEW6bWNpY60CE9lUrvtRVXUpSTPt48mcGxzxXwz1PywrnpBxDs?=
 =?us-ascii?Q?2gyNGw15l6sOeANolTRYGdkpnho8InR54i6v+5h5QCx/gcPvfWbolCIomb80?=
 =?us-ascii?Q?njMKtb1LIlUQ7cLXzagWtDUzLNxQ8zeTq8+54Vt1tivRjpVPfBdM8k0quJiN?=
 =?us-ascii?Q?LeaXkMqxArccyufE0KXf7WeLWuR1r6Rulxe7MRLukiXm9eqGqOxyR+2gI1w5?=
 =?us-ascii?Q?SkZE0rKNlKh97kCbrUmUkfhfG2PBLqpekH3/Dw53WgVrqyyXwL9U4dWvKBkg?=
 =?us-ascii?Q?d7jRzUw+pLdzrU3Fq+Tixz+oZYXQTysVfTPktWWcLI5e6qCUYyCIFvbCTWod?=
 =?us-ascii?Q?TU1CHDDD2/KWCxJz2Upz5ONW7SXN4DSGW0xBIXtOFBMhzQZen4BmQS930/dH?=
 =?us-ascii?Q?kJDLyWUES2ipTtSOv6NkARLvkGWFVPopQ24SShA7zfyUFfTxLy5WjAybJpjZ?=
 =?us-ascii?Q?3nXAnJXbmZpUhyIBMh2pdsyMvy9Gn/vRvkpWQnYMRrDmlRgqCi1yTPPlq05U?=
 =?us-ascii?Q?kwQPyOQpBPd4yC3ztXSld/FzVBl4eaa7W5rwi6r5obBf0SpUNE/zj2YRrqW3?=
 =?us-ascii?Q?d0vMEC/uXON7glpVsIOYb9xxV4MRaVf+nMgzmJVCgLBVyWRycwn0JRhDtoel?=
 =?us-ascii?Q?NHcvQqWZxuoQKmpqEFzx5j9f+QtWFBOKMwy8B79Tq/FPfJmHAoS6BV1mJw3c?=
 =?us-ascii?Q?k18OPgG53UJ92Q18PKqqA0G5Pgcx2SDMFOnPYjeyRjAKQBOCwW4p4mFxU6mC?=
 =?us-ascii?Q?dhnQL3LX+DdRU78sWu8Pqd6qq50BW6Zsj+8Pl9vOQZMKDxDDjxpxLGKGEv7k?=
 =?us-ascii?Q?KPLD4UZh9KJMeezmlIcLrHIM79MxU/AWXCMiBXp0Bc9somHMpVzX8JDJKp9Z?=
 =?us-ascii?Q?r+eODYJE9rlfVavSI8pIBndYYTHlPET7HxyUQJOeCZ0xdTXOTFDkt3p3Jrn4?=
 =?us-ascii?Q?ChL7684fc9TAi/yvDkYZtfZVB8w4052HVuiwtn021yCBgjEhkgB/ysx86lrW?=
 =?us-ascii?Q?fnmuw6z4F/hS1F5o3pQgHXmvORhDbOehpbRV0ISSFH/gFr3IF0wUb+zf6NvZ?=
 =?us-ascii?Q?XmU41pEbcItkNh4LyHFKV/NftVReXibr4MJdMktJIHY/feKc7NL5lmxI3M3I?=
 =?us-ascii?Q?wUrWIiNmXa5hZuGtZMGo+TAMwAGbwY7aypWEDjm6upBgmXHLOCnFeZh9xJ7u?=
 =?us-ascii?Q?szEykhVXCY59ioU3pm+FNB61PSbp08xb1mzSmqdg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3097c3f6-22d3-404c-12d0-08dad9babc5f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 07:55:27.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgySwzrFlT2SRODgBOVMQ+KFHFiBbKDhDiui33UowdlcQNpbP86N46LMAh0vicToVf43RSTXKw4GE1gcip/C5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:18:40PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add support for setting and querying EPP preferences to the generic
> CPPC driver.  This enables downstream drivers such as amd-pstate to discover
> and use these values
> 
> Downstream drivers that want to use the new symbols cppc_get_epp_caps
> and cppc_set_epp_perf for querying and setting EPP preferences will need
> to call cppc_set_auto_epp to enable the EPP function first.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/acpi/cppc_acpi.c | 114 +++++++++++++++++++++++++++++++++++++--
>  include/acpi/cppc_acpi.h |  12 +++++
>  2 files changed, 121 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..37fa75f25f62 100644
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
> @@ -1365,6 +1364,111 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>  
> +/**
> + * cppc_get_epp_caps - Get the energy preference register value.
> + * @cpunum: CPU from which to get epp preference level.
> + * @perf_caps: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *energy_perf_reg;
> +	u64 energy_perf;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (!CPC_SUPPORTED(energy_perf_reg))
> +		pr_warn_once("energy perf reg update is unsupported!\n");
> +
> +	if (CPC_IN_PCC(energy_perf_reg)) {
> +		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +		struct cppc_pcc_data *pcc_ss_data = NULL;
> +		int ret = 0;
> +
> +		if (pcc_ss_id < 0)
> +			return -ENODEV;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
> +			cpc_read(cpunum, energy_perf_reg, &energy_perf);
> +			perf_caps->energy_perf = energy_perf;
> +		} else {
> +			ret = -EIO;
> +		}
> +
> +		up_write(&pcc_ss_data->pcc_lock);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_epp_caps);
> +
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
> index c5614444031f..a45bb876a19c 100644
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
> +extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
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
> +static inline int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif /* !CONFIG_ACPI_CPPC_LIB */
>  
>  #endif /* _CPPC_ACPI_H*/
> -- 
> 2.34.1
> 
