Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A063698CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBPGJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBPGJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:09:26 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0EC15CB5;
        Wed, 15 Feb 2023 22:09:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifUrlNHlpIteYBeLzTKaAZMgdNGxTIsrDzuo6dvpYGWjufwL0b79QHr7ks1DY+NiPREItUYckt+mz0lHvckDHu/5r4WryfQUvYPpw4lKdftEWqEsenonh6lm9DbLDSTAvoioIkEImfjiph6YsKjyp3eQFwZhcVQzZDzSqpDwkbe59qNcr4oiNbDNhQlYPOJvZoj7SD3i9p8VaKCW4d8Gf+kDEHzdO6vFdvV9n6OpvXmXQZ9Pz3FWcZbL1b3ZlbNxM/ewv4q6OKSpo5ledqoR+Dlswy2Z0MAbRBv3KepNuSDBcRvGZTh5SdMIWeSdhGZicfrzzZJB9impd7tcnCsl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX4EBbd5vKIAsmj6lkXqD4u8CYkrwRah7fFm0lqeJ6o=;
 b=llvoosxt0kWzm/ruXLEjMByF7I8zpbOL7A/7tnHFXDTdkVDdB2L8SYW7iWMFFHD4qaho0EgNpO/nIO+a29Z8FeEslP0MG2Tx3khMF4zsRCvU/M+c1PIyubVspZvmYcmCptzNNS93JaikhA4kZwnj+hHDIcYHOloW1jticb/MsTw1UGmEYlZ1BEgIkW0ZsoQZGKG+NKB7MJYnyDBkffJnkruPiMCn//IT8HOQIZRoC8SBFISq3cEK0oLb/gh0E8DEI3lYzxYC0moQa3yil62m+8pq133R9KF55ALsXFOL3qO/oYnNv0CyCBcHQhEuCBhOhsC0SogQggkh0Jt68BqP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX4EBbd5vKIAsmj6lkXqD4u8CYkrwRah7fFm0lqeJ6o=;
 b=f3Qogs0safqVW+sy70njyyPOLxfFHRi7bFHOFMddCpFSfivq/136oZtiHlS/oRYC/r3xcKMZ2/ZdYbnBLoeBaBq9bE9xV7OgKvacLHhkOGIM5RUZ3S1MVSaX4xBBnF4dCtMbzCZ+ZZyz9hRr4VSflSDuY5TVeBjK2sTWTVEPnAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Thu, 16 Feb 2023 06:09:20 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 06:09:20 +0000
Date:   Thu, 16 Feb 2023 14:08:51 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v6 3/6] cpufreq: amd_pstate: Add guided autonomous mode
Message-ID: <Y+3Ic/BtRyKUcaS7@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-4-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206172157.49887-4-wyes.karny@amd.com>
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|CH2PR12MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f39dff2-a223-4ebf-81e9-08db0fe45786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wng7UT/rKAbAxqdZl5noOoj5iCdUxdvyOoTw7iBhfVh2MSSWCGfWKH9VWoJ7gSGBKt5Hu2BT0/n/edjzcPIt3UroDsODzY9H4YtYqmwPK6RuPUvDoUJp8Ajd+fK4BqNOUanFiKLuFBfPbDJAPyyGcFlGbuS7UdJYqQRB2e+/f6kUOFq9mCfmRcA5Fd8AyfneoMSMsJyYZLU6o2ltLA698CMkzZkUYv1yFUyLWVhr4mSV8NlF30mjUeHds0d0wkFh/DfF0p/GQ33NktQQbgUBTumReOD5VRwXqXDafjQ7AXxjyArm0y9ARKqxj6ey8e2co+Y2cRDRGyvddw4uokg6zlKB1cXV4Xa1IUUqGpBcIZOcVeXUD/BIAZhXiFVrB3IMROmtNQ2wJ3/rKnAtpqkEIKipIK6kLH6eKlZAT2zXTmerMNC9DY07k4uPpH4PpJWEOkTx93asN0otNd2Hpebi2WTpbJKGcM1eoqa4P9z/7j0VVlNT9IEkJa4kWm4E/39Ppjl45yvi72aChQNXx5ULrYoAmdAqgeYYTEJBrEY0OPNxyyWvu1LURtA4xIZB0BbNqc6WCvbgrTbinpKTduowaZuESiYT8441ZErbQkySQNaRtYW8EMXFhZ8h/IX+O9BYnqXgTKHwyZnhuJUU6vNX+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199018)(86362001)(6862004)(7416002)(8936002)(38100700002)(41300700001)(5660300002)(4326008)(8676002)(2906002)(66556008)(66946007)(66476007)(316002)(37006003)(83380400001)(6486002)(2616005)(478600001)(54906003)(6636002)(6666004)(6506007)(36756003)(6512007)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUYNSeRkGTLRFM+sQZXCWk/VEgKt0LEh78et0s3ba6UsIX3e0Sd2JCsyHNbL?=
 =?us-ascii?Q?dNLkOqPjhyOpUbgRzAgsq/+tcNbYt3nHkvMr11Df4f6UWDdsoupSzvzHLj/J?=
 =?us-ascii?Q?sVTtZM3q4ZFSzoEpYnTF982ZiGoYB9j11gqS9Oicazm99P6JN3AL2VZg3Zrk?=
 =?us-ascii?Q?geK1nBYIcY0dUjHz7JVwD5i3LOrU641CBvyC0KgVv0y0+T7z/QIWomu6YplN?=
 =?us-ascii?Q?om47y2hbLEzRqGMx3ZO1rYWHSEHHz9AhMxX1ZwFqgFLp+WaChAM00zYrVR1v?=
 =?us-ascii?Q?b0wWv+98QW/plY5MYn0/t0833eaoTJdE60TiBsSr1QjHpoOoYgvx8K2Bz4vb?=
 =?us-ascii?Q?3N4YnyfI3QDxGAJSVSk//2kMK+KJeIlc1TB2NC6cZgsjLhIuEArgP5fSXr4+?=
 =?us-ascii?Q?NZn1YIKUlR+7ZwzpQxgEyaZUWN8/S+RwfWAANLxfeIm/rRhakADwubf3WnIv?=
 =?us-ascii?Q?S784/IynwHRzlckT/U+twiDXX16RdYz+F0k8oPZS+IqDxofoIvzDsFQaGTdf?=
 =?us-ascii?Q?6Q7oYIPSW0WhDLaqe/sk6t5qGut4L8z0gw6NwHrGW9bXTAe+3Pq0YW4sqZEA?=
 =?us-ascii?Q?o7Z4L3ZUNbZg2hEZgR+Iovl0hkYGq/li5TvAh/iAAcy8kng53ddVKOQeJ9pl?=
 =?us-ascii?Q?FlUlwopYJIHTsg/B38H4MPlgzelK3NobMv9tPDcR4OM88Y69zj+sR69K0GRA?=
 =?us-ascii?Q?41/cCn4Xz3/iu+MrgMoHwxGUs6vNlPk0fWKwyMSCzpIDv6cK5wNAe+1C6ZLh?=
 =?us-ascii?Q?7xbRRi4YLl2/seq3FgXbO7yT6UDOOUinEaN58rwB7GKs9utGMNjavRcxsnEa?=
 =?us-ascii?Q?de7mP2S+/9SCOR0wbP6EMOE76eZMVmHoJd/ucbEaUbOdagjJLqB7QGACUwuV?=
 =?us-ascii?Q?clojmMd8DL032eDDbUKGCGnw4PvWlv+H/xTOqmS/vs1WRm1iaxZn1ahObwnP?=
 =?us-ascii?Q?ZbiySRSavnanO0hc9rm3mLj0nUhNw/UZxVs+3oiAmOvqzipdXuAgn22RQplF?=
 =?us-ascii?Q?Hr6UlGDTV5HxiFlhelbc2tU3mlauTIQaiKqu91RCctLun/tZNjFjWZ61RFsv?=
 =?us-ascii?Q?5og0OlndycPQnlJ/fjDYoju5D9M0TWj47FgEs1zsuhOs6IU19wqS1h7MGwo1?=
 =?us-ascii?Q?8Iit2ULWkKB4ISUggIZLS4CCD5MliGoC2H+0olSWoh9oq3o4lbo+LeMbpVm7?=
 =?us-ascii?Q?Tyk+X+IlrxtSZmr9EtJZbJqAfayZ4cVfLwe0OacodiVPLeoRQWaOb8d0REoX?=
 =?us-ascii?Q?2/20/SifJneoAYRyg4ZaBUi/h/pxyzb/0uAglWLBJaV5IPVzFFARfsYIg0cD?=
 =?us-ascii?Q?jN3jVnn23xe/aGlsI8FuLmw9SjaLKZczab7qYDahxIWiWTqNuRBd3V/e11bN?=
 =?us-ascii?Q?P05dZ3k/v+qTIgIDiKZZTouYdb2iuscCP6T3OcwLy4c8IBRdO5sjYY/yU9+B?=
 =?us-ascii?Q?OcHXn8S13gb91IGp5ScRRmyFwksu8yCeYSRY8zoStJaVbHvqeLTj8Q7XrxQr?=
 =?us-ascii?Q?XulKZPRZdSTiXKuRdZWecUr0UZCIrcZgDlGXvhMVyyGtJLPM7ksxEyKqVPha?=
 =?us-ascii?Q?8GLdWRm/RIaOPDe+25ycdYuRtVwo3JdN71LYjn0M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f39dff2-a223-4ebf-81e9-08db0fe45786
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 06:09:20.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG2cloQaeRIioO44HcI2u6H+l6QTggzf3R/RmTVVpr5df9v+IBQcis19snf/7zAxgjSn/5fWAQpZXy+9zlSvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:21:54AM +0800, Karny, Wyes wrote:
> From ACPI spec below 3 modes for CPPC can be defined:
> 1. Non autonomous: OS scaling governor specifies operating frequency/
>    performance level through `Desired Performance` register and platform
> follows that.
> 2. Guided autonomous: OS scaling governor specifies min and max
>    frequencies/ performance levels through `Minimum Performance` and
> `Maximum Performance` register, and platform can autonomously select an
> operating frequency in this range.

I believe the processors which are not sensitive to power consumption can
use this mode. Because this way can have better performance than "non
autonomous" mode. :-)

> 3. Fully autonomous: OS only hints (via EPP) to platform for the required
>    energy performance preference for the workload and platform autonomously
> scales the frequency.
> 
> Currently (1) is supported by amd_pstate as passive mode, and (3) is
> implemented by EPP support. This change is to support (2).
> 
> In guided autonomous mode the min_perf is based on the input from the
> scaling governor. For example, in case of schedutil this value depends
> on the current utilization. And max_perf is set to max capacity.
> 
> To activate guided auto mode ``amd_pstate=guided`` command line
> parameter has to be passed in the kernel.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Wyes, could you still use prefix "cpufreq: amd-pstate:" as the subject to
align the previous patches? Because it's easy to sort out all amd-pstate
patches for us.

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  .../admin-guide/kernel-parameters.txt         | 15 +++++---
>  drivers/cpufreq/amd-pstate.c                  | 34 +++++++++++++++----
>  include/linux/amd-pstate.h                    |  2 ++
>  3 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e3618dfdb36a..56d5c189e458 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7015,11 +7015,11 @@
>  			  Do not enable amd_pstate as the default
>  			  scaling driver for the supported processors
>  			passive
> -			  Use amd_pstate as a scaling driver, driver requests a
> -			  desired performance on this abstract scale and the power
> -			  management firmware translates the requests into actual
> -			  hardware states (core frequency, data fabric and memory
> -			  clocks etc.)
> +			  Use amd_pstate with passive mode as a scaling driver.
> +			  In this mode autonomous selection is disabled.
> +			  Driver requests a desired performance level and platform
> +			  tries to match the same performance level if it is
> +			  satisfied by guaranteed performance level.
>  			active
>  			  Use amd_pstate_epp driver instance as the scaling driver,
>  			  driver provides a hint to the hardware if software wants
> @@ -7027,3 +7027,8 @@
>  			  to the CPPC firmware. then CPPC power algorithm will
>  			  calculate the runtime workload and adjust the realtime cores
>  			  frequency.
> +			guided
> +			  Activate guided autonomous mode. Driver requests minimum and
> +			  maximum performance level and the platform autonomously
> +			  selects a performance level in this range and appropriate
> +			  to the current workload.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 168a28bed6ee..6582c922ad3a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -308,7 +308,22 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  		   cppc_perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
>  
> -	return 0;
> +	if (cppc_state == AMD_PSTATE_ACTIVE)
> +		return 0;
> +
> +	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
> +	if (ret) {
> +		pr_warn("failed to get auto_sel, ret: %d\n", ret);
> +		return 0;
> +	}
> +
> +	ret = cppc_set_auto_sel(cpudata->cpu,
> +			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> +
> +	if (ret)
> +		pr_warn("failed to set auto_sel, ret: %d\n", ret);
> +
> +	return ret;
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> @@ -385,12 +400,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>  }
>  
>  static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> -			      u32 des_perf, u32 max_perf, bool fast_switch)
> +			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
>  {
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>  	u64 value = prev;
>  
>  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> +
> +	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
> +		min_perf = des_perf;
> +		des_perf = 0;
> +	}
> +
>  	value &= ~AMD_CPPC_MIN_PERF(~0L);
>  	value |= AMD_CPPC_MIN_PERF(min_perf);
>  
> @@ -445,7 +466,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  
>  	cpufreq_freq_transition_begin(policy, &freqs);
>  	amd_pstate_update(cpudata, min_perf, des_perf,
> -			  max_perf, false);
> +			  max_perf, false, policy->governor->flags);
>  	cpufreq_freq_transition_end(policy, &freqs, false);
>  
>  	return 0;
> @@ -479,7 +500,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (max_perf < min_perf)
>  		max_perf = min_perf;
>  
> -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> +			policy->governor->flags);
>  	cpufreq_cpu_put(policy);
>  }
>  
> @@ -1279,7 +1301,7 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		if (cppc_state == AMD_PSTATE_PASSIVE)
> +		if (cppc_state != AMD_PSTATE_ACTIVE)
>  			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
> @@ -1341,7 +1363,7 @@ static int __init amd_pstate_param(char *str)
>  		if (cppc_state == AMD_PSTATE_ACTIVE)
>  			current_pstate_driver = &amd_pstate_epp_driver;
>  
> -		if (cppc_state == AMD_PSTATE_PASSIVE)
> +		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
>  			current_pstate_driver = &amd_pstate_driver;
>  
>  		return 0;
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index f5f22418e64b..c10ebf8c42e6 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -97,6 +97,7 @@ enum amd_pstate_mode {
>  	AMD_PSTATE_DISABLE = 0,
>  	AMD_PSTATE_PASSIVE,
>  	AMD_PSTATE_ACTIVE,
> +	AMD_PSTATE_GUIDED,
>  	AMD_PSTATE_MAX,
>  };
>  
> @@ -104,6 +105,7 @@ static const char * const amd_pstate_mode_string[] = {
>  	[AMD_PSTATE_DISABLE]     = "disable",
>  	[AMD_PSTATE_PASSIVE]     = "passive",
>  	[AMD_PSTATE_ACTIVE]      = "active",
> +	[AMD_PSTATE_GUIDED]      = "guided",
>  	NULL,
>  };
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 
