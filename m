Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC97170B76C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjEVIST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjEVISP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:18:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C6B0;
        Mon, 22 May 2023 01:18:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnmZIrZWPHTeoRbMGK95F9Nn4+EquqKb+ZfyKyz9D15cWKT09GEBMwNUuRmo/xEcZOTpXiVxhxZNyMAzpqXRGCyTpE6XH8jMtxY0dq1Hgo1+0prFfnUATOBvYY6M7VMQ9umQcw04Iv7BQIPDWzpYF74A9WQbnAOHzY/aoqgXpL9B5coaTlVpLdeQoILQAefJqSw+/SY4/k7W5IhvbICPHawwxwLS0UJu8E/DGuJDV600hsJcy5wfhbUYztOeO8sLvDiz+6RWdd4Pc7iSaa9woRDkviw39mJtaLzyn1CiNoNqVIuR0x+z+Ny3tBs1FbBi5tmoSraD+b0+OmV7P4afIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5+ikh22/NDLh4nqWor5UZxXCFNRNHZYmGqcy/4AQp0=;
 b=h71QhVZRJ2nRv6NO9EKk1+wBek/NDOAAPnGmTWItHUaUd9ExbyFfsL7irPw6+YsVMhpW7VQ9rtBF7iFDAHFrioPABPwl+ZuwjwF+BL5+r0CI4kTpjxRf63e6SLodxhgjnJ1mDYnwuW4o2GU8zYR+wOC531tABHjyZ3WALx8+JwuxEclTUlhst5m9ypq22C0MfAP8d8NLAaEUy04CIUdeE0gmR02BPILNMBGyJAfoiRyNL6Rn0vQ9AREcMy8+6uIz2/rbS9lXrOsRk4UXM9EJeRJzB9bLyIuqpQukd3SK1TIhykqvnD6vE8x1BasIyedJokGj3zHKI8Qx+Z8Bk4smtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5+ikh22/NDLh4nqWor5UZxXCFNRNHZYmGqcy/4AQp0=;
 b=Cqwl3UjDzSysE0XT0MTehNAs40JB7mN01+L4TlhTjEi60ThfjWNUeR//ZA3Mocbx170WT7wFz+6wDfLlUOafVxToipiBwcSGTfVBrYLTO2B6k7FLAwg78loBA0oIaIpgzPMrb6SARDNckjsamq9Yk0ENzihrcHFyJ5CXcvf8lOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 08:18:10 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f215:8b7f:cba3:729e]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f215:8b7f:cba3:729e%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 08:18:10 +0000
Date:   Mon, 22 May 2023 16:16:35 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Jinzhou.Su@amd.com" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate: Write CPPC enable bit for each
 core
Message-ID: <ZGsk4zzBBVEQTZQ5@amd.com>
References: <20230522063325.80193-1-wyes.karny@amd.com>
 <20230522063325.80193-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522063325.80193-2-wyes.karny@amd.com>
X-ClientProxiedBy: TYCP286CA0168.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::18) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BN9PR12MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ea1a80-b294-4d4c-ae79-08db5a9d146d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSldEBF5iBYngQTDjwyRvqc26I8HRv53/DLaMSTBW6dgYzHuS+clXl1gnPYwBoJ5JA8/GdLpM6p/lwmynqZe/oawxRxerf2u2uLqGkOIQfplzecE3gdtovJexrKxPF0X2cHsbTg4sBHSz/caWLHWdIuqqoxb/e7TFo+fiR2fZ/sTxBYBAtnmdEtudWZvKPrjPjOXpT44ofd4EK0Hn0Z/XsTNFQDeq3UewFN25UisHLk40GYzzcblX6K7GMRTWSgkGDe888D30MhLRbqk50qJtemjzGhAwnvbpLc8k911Pmr9Q6J7fwZ31ExKeCZuyZotqTYUaPPStisRmgLQ+cGZFogHB1nzNReVbKk0S3jCeu+40xALzMSd2pKlQpliSEoroIaYnI/5A4kDAF8UMIEnKkU3JvnC0DH729CfSBOCZNo2Ao9yLbMc6q9TOEDYVlH/6QuEqkkbMR5JovHMtPWcSxvSyEWHcTBp9b426A7asvhMYliADa4PlHIuVfAPMgwiEE+QQ0GCAGuGyBGj/FT8iKuztsLYjiM+DheZ+lFHM8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(6862004)(8676002)(8936002)(5660300002)(83380400001)(186003)(26005)(6512007)(6506007)(2616005)(86362001)(38100700002)(41300700001)(6666004)(6486002)(966005)(66476007)(66556008)(66946007)(316002)(6636002)(4326008)(36756003)(478600001)(37006003)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xAKd3Rke4D3yIBrNcGLZOTTVZPvAfpZFxLJnd4T7nVubrOa8XY6PxtuC6ELN?=
 =?us-ascii?Q?BHBKF5/os3iBwSWVUOS2prgomz37W21uT2ZEZYxX2CbY70RMxArgDtdty3nV?=
 =?us-ascii?Q?9G513G6s7zBYbT6XVwIlAOVGBMZFptmu18u2Mv7bfT9JDezlE8erykclBaoT?=
 =?us-ascii?Q?jmXs1iB0mC3y/a/lgtP3VaJagDW03BxyQMyCOiFEIGg2dB7feHmt34aR1t32?=
 =?us-ascii?Q?7DXwceGYFxXOgLJ8ErGGJh/S4TfvQ9W35Mqp7GBJxQ6U5N8bJGoeWszlUylP?=
 =?us-ascii?Q?77HvzIJ7QnT5dN/UmZoRxjSNdIbjO8aWUrnvZTXCV6CLxpAMnElXR+7mB0rk?=
 =?us-ascii?Q?LHlQTa05T6tpmG1jH1L0rLLwVPJl8ZGNyun6saaLIyWF5YfR7QxndHu0vBZJ?=
 =?us-ascii?Q?KL+AwXNnvo7nQR9a/AcXKs8hJGxR0pBg2/wmFQw7mTvsHE8XK+Lmrn0X/u7g?=
 =?us-ascii?Q?vvv51tSgpE4UoQI8hllUgFjLGPi7xMlnKJJRlCfFIPsftXwcX9juIsxHOUXj?=
 =?us-ascii?Q?S6UzFPJG7Qwi34GKUtrwfZb3oiwSO2BGRnsOsI8wgnW2l6lqBuzpmjJl2/LR?=
 =?us-ascii?Q?3mzuBqItq+85tONS5UvPnm4k4UF1EuX9K00NZ6QTlZifh0eo8PHWZEB6q3NA?=
 =?us-ascii?Q?SygoXtIObHxxE3IOSHURERIgEc+2jkYrbQ3gP3gWmezVSWvGvOAzfaR+h78s?=
 =?us-ascii?Q?ZpkIKZMm3VxKMb0Ejk/nMn6bY+KOmAih5cN+NTmzgh1e+5AGxaJJGSczJD1L?=
 =?us-ascii?Q?rqHVp3aVcbD22zldfwGbxMcZoUHM5FXsNZQXl7Kmd2gRmiID7ELnHIhLz/IV?=
 =?us-ascii?Q?XK1hCIFZ70lZa3PRBWEGbT1uZVZR4Ib6GfKXLsGPmqv0JEttV+PubpiVoYM5?=
 =?us-ascii?Q?ObwS0+O3tpp60BTODtGy2atA+MRSiC//v4zs6OQHxLIISJeFzlSXlYyiB4BJ?=
 =?us-ascii?Q?4RMLZWU5bJheTu0B5qz7GstFaQ8qGWjtOk1pPY6yChckMhuwDSa0UssuMRs/?=
 =?us-ascii?Q?KcBsKIiXL8vivmkgEqL7WxvAFooKpXqnuiI47NVrx2IrmfZwg5QoVzSOBasb?=
 =?us-ascii?Q?UyjxmMdswpe7881yzNtj+jdUrEHKQ7GwIvKfS2Y3PlrZjwqv1sLLhoFQ6WWY?=
 =?us-ascii?Q?ADZUm8pqiVy9zlVNwprqVAM7iyeoicBD2TiQHJkp4cFnhF97cnUiWTQNxcxj?=
 =?us-ascii?Q?Q0MKPEN2o+RBsrSzeyFHQvEjv3NhXgBd7yRVcNsAEUoi6J7pOqhMkMyP+Slq?=
 =?us-ascii?Q?MUz3myEb7tp4/2xWUrTosdQ9uyiF0smRpAhizYb/q+CZYwdY3VH+CNWpsn8u?=
 =?us-ascii?Q?VYZxueRj6w8/9YUtAPjvP1qKrcAjVFvOWIQVzh2anQiXFGq6aHwyS7ZjY9K8?=
 =?us-ascii?Q?PmApd73wOAMbujcYFlDKuTEJAOpGZa/OKNJYWHk1RyPmZB3F/rFDz6ADHQCx?=
 =?us-ascii?Q?SV+9lXEGfZM9Em/M4yw5enAhlOAXXLIrag1bhybpJlpmc80i+jXN/mb3wWjr?=
 =?us-ascii?Q?1VUdfjgsjKxwTi9LfIcXCItIuQycT/NVidFKG0GHauCz/q+jQxqC+04DRAtq?=
 =?us-ascii?Q?ymKem4M03Ge4nL3oM5SiRkOD9qf0xRXBHGv75yMj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ea1a80-b294-4d4c-ae79-08db5a9d146d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:18:10.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3yykqX+rzcSsApqGNwXdoLir5czMYX17fLcM30+bGAMyCS+fRk4OGLo28rJT+xTl9VQpJe1vIx9cxDjd0586g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 02:33:24PM +0800, Karny, Wyes wrote:
> ACPI specification [1] says: "CPPC Enable Register: If supported by the
> platform, OSPM writes a one to this register to enable CPPC on this
> processor."
> 
> Make amd_pstate align with the specification.
> 
> To do so, move amd_pstate_enable function to per-policy/per-core
> callbacks.
> 
> Also remove per-cpu loop from cppc_enable, because it's called from
> per-policy/per-core callbacks and it was causing duplicate MSR writes.
> This will improve driver-load, suspend-resume and offline-online on
> shared memory system.
> 
> [1]: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/08_Processor_Configuration_and_Control/declaring-processors.html#cppc-enable-register
> 
> Fixes: e059c184da47 ("cpufreq: amd-pstate: Introduce the support for the processors with shared memory solution")
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5a3d4aa0f45a..8c72f95ac315 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -226,29 +226,27 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
>  	return ret;
>  }
>  
> -static inline int pstate_enable(bool enable)
> +static inline int pstate_enable(int cpu, bool enable)
>  {
> -	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> +	return wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE, enable);

In the full MSR processors, the CPPCEnableRegister is per package, not per
thread. In share memory processors, it should be per thread.

Thanks,
Ray

>  }
>  
> -static int cppc_enable(bool enable)
> +static int cppc_enable(int cpu, bool enable)
>  {
> -	int cpu, ret = 0;
> +	int ret = 0;
>  	struct cppc_perf_ctrls perf_ctrls;
>  
> -	for_each_present_cpu(cpu) {
> -		ret = cppc_set_enable(cpu, enable);
> +	ret = cppc_set_enable(cpu, enable);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable autonomous mode for EPP */
> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
> +		/* Set desired perf as zero to allow EPP firmware control */
> +		perf_ctrls.desired_perf = 0;
> +		ret = cppc_set_perf(cpu, &perf_ctrls);
>  		if (ret)
>  			return ret;
> -
> -		/* Enable autonomous mode for EPP */
> -		if (cppc_state == AMD_PSTATE_ACTIVE) {
> -			/* Set desired perf as zero to allow EPP firmware control */
> -			perf_ctrls.desired_perf = 0;
> -			ret = cppc_set_perf(cpu, &perf_ctrls);
> -			if (ret)
> -				return ret;
> -		}
>  	}
>  
>  	return ret;
> @@ -256,9 +254,9 @@ static int cppc_enable(bool enable)
>  
>  DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
>  
> -static inline int amd_pstate_enable(bool enable)
> +static inline int amd_pstate_enable(int cpu, bool enable)
>  {
> -	return static_call(amd_pstate_enable)(enable);
> +	return static_call(amd_pstate_enable)(cpu, enable);
>  }
>  
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
> @@ -643,6 +641,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpudata->cpu = policy->cpu;
>  
> +	ret = amd_pstate_enable(policy->cpu, true);
> +
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -724,7 +724,7 @@ static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
>  {
>  	int ret;
>  
> -	ret = amd_pstate_enable(true);
> +	ret = amd_pstate_enable(policy->cpu, true);
>  	if (ret)
>  		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
>  
> @@ -735,7 +735,7 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
>  {
>  	int ret;
>  
> -	ret = amd_pstate_enable(false);
> +	ret = amd_pstate_enable(policy->cpu, false);
>  	if (ret)
>  		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
>  
> @@ -841,7 +841,6 @@ static ssize_t show_energy_performance_preference(
>  
>  static void amd_pstate_driver_cleanup(void)
>  {
> -	amd_pstate_enable(false);
>  	cppc_state = AMD_PSTATE_DISABLE;
>  	current_pstate_driver = NULL;
>  }
> @@ -1039,6 +1038,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	cpudata->cpu = policy->cpu;
>  	cpudata->epp_policy = 0;
>  
> +	ret = amd_pstate_enable(policy->cpu, true);
> +
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -1180,13 +1181,13 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
> +static void amd_pstate_epp_reenable(int cpu, struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_ctrls perf_ctrls;
>  	u64 value, max_perf;
>  	int ret;
>  
> -	ret = amd_pstate_enable(true);
> +	ret = amd_pstate_enable(cpu, true);
>  	if (ret)
>  		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>  
> @@ -1209,7 +1210,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE) {
> -		amd_pstate_epp_reenable(cpudata);
> +		amd_pstate_epp_reenable(policy->cpu, cpudata);
>  		cpudata->suspended = false;
>  	}
>  
> @@ -1280,7 +1281,7 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  	cpudata->suspended = true;
>  
>  	/* disable CPPC in lowlevel firmware */
> -	ret = amd_pstate_enable(false);
> +	ret = amd_pstate_enable(policy->cpu, false);
>  	if (ret)
>  		pr_err("failed to suspend, return %d\n", ret);
>  
> @@ -1295,7 +1296,7 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  		mutex_lock(&amd_pstate_limits_lock);
>  
>  		/* enable amd pstate from suspend state*/
> -		amd_pstate_epp_reenable(cpudata);
> +		amd_pstate_epp_reenable(policy->cpu, cpudata);
>  
>  		mutex_unlock(&amd_pstate_limits_lock);
>  
> @@ -1370,8 +1371,6 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>  	}
>  
> -	/* enable amd pstate feature */
> -	ret = amd_pstate_enable(true);
>  	if (ret) {
>  		pr_err("failed to enable with return %d\n", ret);
>  		return ret;
> -- 
> 2.34.1
> 
