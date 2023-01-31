Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD8683430
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjAaRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjAaRpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:45:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF34B1B0;
        Tue, 31 Jan 2023 09:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH/Cgsx206aHBExHt/WvLcqxBU2vBM2A4eJNG5mAhzDeUkOT0AL2wheOeAGCPnhEQlfL765pWmrdUBLDrS3ZKB4CYxrcl96Oplu14Z72GEk+ZfzXfHM1oUqDq37AcSYlW3ZdjYNb/syLRkeQLuD08L2mZ3jMnLfQY7F17UOUpe8MMKvcwDwG2xEE7C79q//4nKmOc7LH0uWvmRimaHIwhnFSWokqV3khCdkbKw61qh8wNfUd7ZhbE6QyhwDLeZsGGMKjOQlj468cRXF+utGiSir0UBCmud0sLfUcZ1E3kt7lld2Ocdinc3Zhu91r/I3n6c7nNR3GpQKcUzsFBUbceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfMVqFYciIVh3udLaK1OxmCjIuIGF3ZCqd7s2Mrzk2Q=;
 b=boIgL5yWy9za0NvcTl1edjnM06xIRD+yA9wWnowpMYDK1dW+EJUKouzi3fYnqYruzJeE9X9OCLo8F87YdZdgc/Rq/YXJrJjTmor3AoX3CccfkHYWF5dLthlaTH/yOTfQCgHpCy8tFVekR8ftNwy/AviWaLnq/BYzpJdEDjC56CIZhMw49ZSAqq8i5YQRx17wZ141znwLLQ5OWmkrmSopW/oJR9o8wld+6kF0OES9nqCftlMGiXeXnLf5fSRygXM068ljmNNEk+ghILuoHeNqM2PVajBJmM+miHDbWwyyzBE1Pq7gIV+jBJ8NAv7rANAk70nuuqEU4OVXHz1Vf9wxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfMVqFYciIVh3udLaK1OxmCjIuIGF3ZCqd7s2Mrzk2Q=;
 b=aI1w7az36RPWFiD3drPBfxBg3ZM4ZNjP/WjWq0jfx79rA2YtVdw8QgGdqh2fIrgk8FR6SDGqQrXxMY/vrfCdt9cRa0cXyFf/IzFiGUVYEzisaEFWgM7t5ODXyMVCTlMNXgaADg5wsS/Uzodj2QbToaRD+M/cpyZH3XJII+MiwpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:45:14 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6043.033; Tue, 31 Jan 2023
 17:45:14 +0000
Date:   Tue, 31 Jan 2023 17:45:00 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v4 3/6] cpufreq: amd_pstate: Add guided autonomous mode
Message-ID: <Y9lTnOxrHOj5YiCX@beas>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <20230131052141.96475-4-wyes.karny@amd.com>
 <7bf4c9c1-69db-2a79-a925-493a9d993f47@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf4c9c1-69db-2a79-a925-493a9d993f47@amd.com>
X-ClientProxiedBy: PN2PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::15) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 829d79ad-0f16-48fa-358d-08db03b2e809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYaV5MRT6hgwCLAin2GObzgZ0WmSltZwKAynDRXSUxBXXa7vmtPHZN65CBXPs7Br04EJdBCyv2BUsovbUbvGURKGffsXSiDajgABvqZRSxtKeQc5876o5Xl47i1FPfdbASmhemhvJNUfuP5YSrR7kQ3m/77un25EC5qOJiO+fWSV/zT6XxUx20CZYkO1i22oU8D6GZiHcM7Y2O41mlZHpZHOjMtgE8jGZGj5mw75jR6zBuq3ge4DqIra1Ti3ZcWBXgA6M47ZYMczIv8xc8L984/FZD2oVb6KxzFOcRnAOhF1xVu/le/eVXN+DtGUiFXuIvQKEnsc3BaYZn19oynCN/Vr1CLazVR9ew2JNsK70dnSpZjaMN/hi3ls7j16dgYkwaW0vfUgKY7DLehGx8PnBcuAWiQMq9ImEduKVNYneP4S90079yZfylk2Patu6TQPXc4L5Bw4xGGnxAiSsj8DTevUr0JcvsW0PtXN07pXDnnazt22XbLubKkrJ4WTyuH706LKfhJlSzSfWf+UjIP8u/6oxC7YMlLs5FOsva/ZZ5z7EAEKKECVaJvF+shD9la07b+O2vTMjDdZNPJVIePNed+dHo+RLUc4QU7l1RQxsSgB+Lzo2fCx1ND/KW999UP3MVITU9TMWa4j90M5RvlDLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199018)(86362001)(6636002)(83380400001)(41300700001)(6666004)(478600001)(54906003)(316002)(26005)(5660300002)(6506007)(53546011)(9686003)(6512007)(186003)(8936002)(38100700002)(6862004)(66556008)(7416002)(44832011)(4326008)(66946007)(66476007)(8676002)(33716001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojNirOaQphbYh5xlStdEkLh7lqnbMd6+OO/xF1eyUCXTgxNCtzGMEku+P5XU?=
 =?us-ascii?Q?yqSSIVr+ykLbHlzkNuTPnhN4jSDOLX/FAbUulJKcFn88aNAEYloTndqnBFA+?=
 =?us-ascii?Q?hPKq2SaP89Nt+XsGrp6Nytdc4WxFdvhk7f/BQkkMHFH5T4O0Cz97m8ZVyeIO?=
 =?us-ascii?Q?Z6EVrvbuI7S5dGWCluQ6kHa4KzZ0EWFpwmWE3spQfw5H7Fq9WvKkajpWRG3S?=
 =?us-ascii?Q?vUuJiWROiXe46aZX9Bx4NMIt1C7oj66oG7loUsGrntmk+MiZDD79vTelNh6F?=
 =?us-ascii?Q?niWcqCcRPGoaGymMq+tmbC2I06NTF9GEX+y0/3EQYyuWMGS8naVfCQ7DDvF/?=
 =?us-ascii?Q?tGn1aA2hXewOjiXjL1UmSCeAkXEyiaklWfPs/3AnKwzllySOFWifEVm/gnOu?=
 =?us-ascii?Q?CgvPkfCDEeldFx3KRWRwgj/50gsAaOog+Gs3T9HWC6tBs4Xpl+7IKnWVS+su?=
 =?us-ascii?Q?ULKvRwSbKaZUE6QkMR2Ov66WrhWo/mav9wiXzDvshDZZTWM5wXn7CWJKrJ8W?=
 =?us-ascii?Q?RjeER6+zJT2oZR9ZfX+PfauevIdu2OXl5MjQTdn8qvnF0BijSfwzfS2jTnst?=
 =?us-ascii?Q?+xKMy+4wy8p0QYBSNBDhEHe7tkB2LAUNfgxcXEY0Zk5I1z9R+pxtwF/7EPT4?=
 =?us-ascii?Q?9jXXJS6YrlBU1YOGGjMr1f8hTXKZN67IotqaZF6ZJo5Mcs5pFfOzVDg2aMbI?=
 =?us-ascii?Q?bWExV1FeAZWK1iefg6e7mEY+xH2QR37eulhi0mSpkEH0Of02IucXSVCXx82c?=
 =?us-ascii?Q?Rx0jeQ+Rpm0BaTRbGQLlZFwQna3MC4fHAcbfXqaqdd48r2pEt2kF8o5RqAv2?=
 =?us-ascii?Q?rruHdc1rAbo5P1j39AhefqMezYVTROI02hJc0w0/Y2Lq0az4/xLJkpr5wORF?=
 =?us-ascii?Q?2WyrvPsANNWhTD6hPLWtYEFJxcAWzb4hIyfZcsZR/gKZy8Zwh8JDXi9MofaJ?=
 =?us-ascii?Q?qhJbI45oOGPcw1aXZi/ZglsbQ7E6npIU2OxKF2F0xnjg8CeIHUVjc+L5CCiT?=
 =?us-ascii?Q?oJq1wiTN3u/k/HvD7q5oXdptWE/ZXe6Uv2IYD8VjZhq6cqD1c85Twd+Utg95?=
 =?us-ascii?Q?7vKf/ANDo4JT7bycO1Wuc6a+okG0NkUOkZsGRAhcXeydkhp/WDKcqrxiMUkB?=
 =?us-ascii?Q?im68iH8xdPkZRQLnkTRwT/SCw00JN0XkNfFbBP013P73u7QYRfgnKgewvttu?=
 =?us-ascii?Q?x+G+YPx1DN9QA1xos/fWLY77gU2sSfH0L3AHrsJlVlmmJ2OYDdda19Ofm4Id?=
 =?us-ascii?Q?pPjxNrwKcom1NUfDzC0EqVZZDc61OO7qYSqpwEWoDbhfzuCew+3gAtMiANLu?=
 =?us-ascii?Q?7MYj7Oc4wgdJAJZ7DeiiskfMhzM8aQbRowOaQlG9HYFEn4iMJoCG26CsYQMT?=
 =?us-ascii?Q?Hi+P2XP1vXNwJ2fRSHbiCtIOleYEpZkoc5ov8p81JgHhh3Xd8zO/gbeHfGOo?=
 =?us-ascii?Q?6ZGHooyrpbrBZZ/v1NOwA+efYMGjjSNEzba9A+tL6Qus5rYtcH6hmin9lrwT?=
 =?us-ascii?Q?b3P+BMSsXMzvnrD6MyaTjXSRjSd/LGzMoiBiC3Rv32cGTRMijzEfbiXcj3d4?=
 =?us-ascii?Q?6Mr3x25dDlxAbHnfctDhHKcvNoxDraUDDBNJYTMP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829d79ad-0f16-48fa-358d-08db03b2e809
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:45:14.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEiaCEGw9I2843RwP746+0SzxVe9nTw3O5VznKnqv9O5+59LLyyLmJcmtR/d6cHbQ0PFTumQv4XJd4Ux4LlmEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 07:37, Mario Limonciello wrote:
> On 1/30/23 23:21, Wyes Karny wrote:
> >  From ACPI spec below 3 modes for CPPC can be defined:
> > 1. Non autonomous: OS scaling governor specifies operating frequency/
> >     performance level through `Desired Performance` register and platform
> > follows that.
> > 2. Guided autonomous: OS scaling governor specifies min and max
> >     frequencies/ performance levels through `Minimum Performance` and
> > `Maximum Performance` register, and platform can autonomously select an
> > operating frequency in this range.
> > 3. Fully autonomous: OS only hints (via EPP) to platform for the required
> >     energy performance preference for the workload and platform autonomously
> > scales the frequency.
> > 
> > Currently (1) is supported by amd_pstate as passive mode, and (3) is
> > implemented by EPP support. This change is to support (2).
> > 
> > In guided autonomous mode the min_perf is based on the input from the
> > scaling governor. For example, in case of schedutil this value depends
> > on the current utilization. And max_perf is set to max capacity.
> > 
> > To activate guided auto mode ``amd_pstate=guided`` command line
> > parameter has to be passed in the kernel.
> > 
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >   .../admin-guide/kernel-parameters.txt         | 15 +++++---
> >   drivers/cpufreq/amd-pstate.c                  | 34 +++++++++++++++----
> >   include/linux/amd-pstate.h                    |  2 ++
> >   3 files changed, 40 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index e3618dfdb36a..0d8486325c9a 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -7015,11 +7015,11 @@
> >   			  Do not enable amd_pstate as the default
> >   			  scaling driver for the supported processors
> >   			passive
> > -			  Use amd_pstate as a scaling driver, driver requests a
> > -			  desired performance on this abstract scale and the power
> > -			  management firmware translates the requests into actual
> > -			  hardware states (core frequency, data fabric and memory
> > -			  clocks etc.)
> > +			  Use amd_pstate with passive mode as a scaling driver.
> > +			  In this mode autonomous selection is disabled.
> > +			  Driver requests a desired performance level and platform
> > +			  tires to match the same performance level (if it is
> 
> s/tires/tries/
> 
> I don't think you need the () either in this sentence.
> 
> > +			  satisfied by guaranteed performance level).
> >   			active
> >   			  Use amd_pstate_epp driver instance as the scaling driver,
> >   			  driver provides a hint to the hardware if software wants
> > @@ -7027,3 +7027,8 @@
> >   			  to the CPPC firmware. then CPPC power algorithm will
> >   			  calculate the runtime workload and adjust the realtime cores
> >   			  frequency.
> > +			guided
> > +			  Activate guided autonomous mode. Driver requests minimum and
> > +			  maximum performance level and the platform autonomously
> > +			  selects a performance level in this range and appropriate
> > +			  to the current workload.
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index c5731fefcbef..48ab4684c3a5 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -267,7 +267,22 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
> >   		   cppc_perf.lowest_nonlinear_perf);
> >   	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> > -	return 0;
> > +	if (cppc_state == AMD_PSTATE_ACTIVE)
> > +		return 0;
> > +
> > +	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
> > +	if (ret) {
> > +		pr_warn("failed to get auto_sel, ret: %d\n", ret);
> > +		return 0;
> > +	}
> > +
> > +	ret = cppc_set_auto_sel(cpudata->cpu,
> > +			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> > +
> > +	if (ret)
> > +		pr_warn("failed to set auto_sel, ret: %d\n", ret);
> > +
> > +	return ret;
> >   }
> >   DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> > @@ -344,12 +359,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
> >   }
> >   static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> > -			      u32 des_perf, u32 max_perf, bool fast_switch)
> > +			      u32 des_perf, u32 max_perf, bool fast_switch, int guv_flags)
> 
> You meant "gov_flags" not "guv_flags" right?
> 
> >   {
> >   	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> >   	u64 value = prev;
> >   	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> > +
> > +	if ((cppc_state == AMD_PSTATE_GUIDED) && (guv_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
> > +		min_perf = des_perf;
> > +		des_perf = 0;
> > +	}
> > +
> >   	value &= ~AMD_CPPC_MIN_PERF(~0L);
> >   	value |= AMD_CPPC_MIN_PERF(min_perf);
> > @@ -404,7 +425,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
> >   	cpufreq_freq_transition_begin(policy, &freqs);
> >   	amd_pstate_update(cpudata, min_perf, des_perf,
> > -			  max_perf, false);
> > +			  max_perf, false, policy->governor->flags);
> >   	cpufreq_freq_transition_end(policy, &freqs, false);
> >   	return 0;
> > @@ -438,7 +459,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
> >   	if (max_perf < min_perf)
> >   		max_perf = min_perf;
> > -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> > +	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> > +			policy->governor->flags);
> >   	cpufreq_cpu_put(policy);
> >   }
> > @@ -1238,7 +1260,7 @@ static int __init amd_pstate_init(void)
> >   	/* capability check */
> >   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> >   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> > -		if (cppc_state == AMD_PSTATE_PASSIVE)
> > +		if (cppc_state != AMD_PSTATE_ACTIVE)
> >   			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> >   	} else {
> >   		pr_debug("AMD CPPC shared memory based functionality is supported\n");
> > @@ -1300,7 +1322,7 @@ static int __init amd_pstate_param(char *str)
> >   		if (cppc_state == AMD_PSTATE_ACTIVE)
> >   			current_pstate_driver = &amd_pstate_epp_driver;
> > -		if (cppc_state == AMD_PSTATE_PASSIVE)
> > +		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
> >   			current_pstate_driver = &amd_pstate_driver;
> >   		return 0;
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index e9e291b7c2f9..85e980b8e0ac 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -92,6 +92,7 @@ enum amd_pstate_mode {
> >   	AMD_PSTATE_DISABLE = 0,
> >   	AMD_PSTATE_PASSIVE,
> >   	AMD_PSTATE_ACTIVE,
> > +	AMD_PSTATE_GUIDED,
> >   	AMD_PSTATE_MAX,
> >   };
> > @@ -99,6 +100,7 @@ static const char * const amd_pstate_mode_string[] = {
> >   	[AMD_PSTATE_DISABLE]     = "disable",
> >   	[AMD_PSTATE_PASSIVE]     = "passive",
> >   	[AMD_PSTATE_ACTIVE]      = "active",
> > +	[AMD_PSTATE_GUIDED]      = "guided",
> >   	NULL,
> >   };
> 
> With two nits fixed
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks! I'll fix those.

> 
