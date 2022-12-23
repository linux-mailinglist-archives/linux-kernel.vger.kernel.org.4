Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6A654D46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiLWILf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiLWIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:11:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6CA32B9B;
        Fri, 23 Dec 2022 00:11:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnoxisCJYjGlv+N1+Pjs8xYYIJWQPOfNjF8vfSBf4IAx0uofMdaNcOWa6hrxeKHz86hRjhemJdqX3t/LNZmUiQN/wiTOen8Xc1SsPchnjDjIEweZrlpaVWSi0zRb9OF38Y8VA5EPXosUvNjkeAR76oGYL/QvDI4/8yO5fL/lXnUNlela+bJ44sj0gOLJlZUzOm3WyIpUPEw/UUdzyDvvU5JpI8UxS3A6KrIiK3irMORcwBVl/UhU6Mg7UJKlYJdF8goLHUEutyAIv+YTVtUvG9ZOhpY2+za9rpN7R4DImv5esmTxkA05P35ueYpzThKQ0jz0J92JKz4IRinEMXS4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOK+Z3PtctqLV8X2xz1diJ/2GMbUohddc5cFGVGpGv0=;
 b=lSvy1nz1jW1xq/Xfmek9Ne/kcA34aijyJtgcJQfbWCIjJCMhmrJHawmeX16409WpnJd+XelUqGTq1dscU7Zu95nu56nO7q+XB+nxIRZiocCeHkqfwd/b/TQy6qXhlDhutHBaMh4LY9u2x5TSSul7E7uEOEAJxYzamyq+a8xkPAR9pxSBCgZwF++VxDHcfUVb3I02JGC1cRYqF9zuJ1I2DJOgg3aTztQXt1X4HbmT9n/7fNss6MsmfzAgHNeK9orEL+c8sC6uNT4Py0HVayr7+YoOCm428cb35ctJKp4DFuz9W1d7Fwowsc1wo/+GQwlwUfF2YZnitJYds6kxNFHk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOK+Z3PtctqLV8X2xz1diJ/2GMbUohddc5cFGVGpGv0=;
 b=v8kAqbyB4YWIF3i4MnIWr9gnVeLDWGRp0jYRGgdlRX6WPptFZ6xnAZIQ99H9Zlux1to1jdp5oc9kImSgHcSdfFwE22FnpyaeeIGpalIAUgc2/o80AGH4mNSxKBtMkmVNs1lrA5TamP5rzBJTb0iLtVLMwdKyeQHowkRqsi9tRVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 08:11:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 08:11:23 +0000
Date:   Fri, 23 Dec 2022 16:11:01 +0800
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
Subject: Re: [PATCH v8 07/13] cpufreq: amd-pstate: implement amd pstate cpu
 online and offline callback
Message-ID: <Y6VilSa4FdrRAKRm@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-8-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219064042.661122-8-perry.yuan@amd.com>
X-ClientProxiedBy: TYCP286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::10) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c133e73-87a7-4a59-912a-08dae4bd4791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PN9tj3M2tGjEEVGizM15TqD5g1WTkKFZP8ddrGmmNVur+yuPbZH5DAkWgj6EKoxAE5eqKqsoGECR1ON1dUmCsyl3UoLLm4i21yr6QSjY6PQp1l2kPaOkn12jSW4dAKrj13G4Af5xKF2PoYA70E3lMpn05p5O7sk78Rg50dB446kqdH0x2gWLpLBEGEAvypID4JLbqZnZI2zw+vglF/wzsSTQCobt3LZH/VvxBtWTNsAqyyFPtfmNPZGxBZEzy3KZWf2s4IPDNdY25NV5HV5uRS9syfjRu98mJlvu3H1a3i2irJIkrFARSwA6Jn2P4E5XInmjaY/Ztem2CTcUMkn93PSjP83WY/CJyqqu1KDZ/5EzSf3C966GhRih40V/XMpsFtRU09B8CXFH7xf0l78UnhxVb3v2Rpnkwo1kVWuFyHp4d9bgqt5blwmYoocrmNcj9o5swkGngDdCKhkWInPGaBpvTR3N/cgy+dQKENNaUBACOG/D24Dq5haSWZm3X1H0PuRkrITT4kWduU0ebjZHF8Fj4kT6aGnD0TP4hThoFPLmkaZIN6bZJydhx8Kne4g9xH93+pPDNro5xhUbOReKr4krBQQqJycMqt1BbZa62IfQk4JYjAOfGQ4hTuH3yRnyxXZWe4K7lVnah9Qr3V3lxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(66476007)(6512007)(36756003)(41300700001)(37006003)(4326008)(478600001)(186003)(83380400001)(66946007)(2906002)(8676002)(2616005)(86362001)(5660300002)(8936002)(26005)(6862004)(66556008)(6486002)(6636002)(54906003)(6666004)(316002)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuEVO3QoR8Jw6ygl9HyZvecbvqtbY2oDngCasso4fZuWoGeN8JpnjrV5ZsJq?=
 =?us-ascii?Q?5LSUCqQQV0RYZ0vIvGLpf1icyyC+R/qceht4S9pRQ0by0ZzYCRTqoE4GDrEZ?=
 =?us-ascii?Q?AUZqJCDqW6P2s7u/C2TavC0dCD4v/4lc0BgJ8Ksc/GTAJ5rvKqNHZoAb17Ka?=
 =?us-ascii?Q?wj0zQ425gOs0cNLvjyMiUJ/BYgv5FOklRWei6UKQ1sOaV48HyZZ051RHMjKu?=
 =?us-ascii?Q?CndtnQdFPP3IcIo9b6WzNgchV/pyyuMCm+Rmbt9bLKmOp4YB66UpilqV2je/?=
 =?us-ascii?Q?d1fpy+dA7ZWgkmusLprfhFa8nN/ij9KvS0KC5fnCnCBmY4msBdf/pkIaN7wF?=
 =?us-ascii?Q?m8817aKoESiox2DuQ8p7iOK6VsZxykbEHZMgJRw+kBzlmTWrsYPn8sHct9Zg?=
 =?us-ascii?Q?c6/z28E0ImvIMc+jVS2+9SrhavWjtJwk0rUtePUEPGtcuLODCh0oEvokp/h5?=
 =?us-ascii?Q?NvqebLYp9Jkg3CJm+7zvlDtY40zBr1bwQsBhhbQ3nphagwCxlkA/AZh02lCk?=
 =?us-ascii?Q?+cG0xz+QntiFvfhCllteoz3jsIEwncViEztEdWoSRffZHqOVEv2pHeqxkEUr?=
 =?us-ascii?Q?zcu9+qEpssrbK4CIoEV8ppOkUuKga8JURUnS1uFKq6FynVwVPaTDnU0X3lUZ?=
 =?us-ascii?Q?/6CgDm4WWgp0gtgz/qd5u9WqjxMBQF1LXlbc1pgI2wSCF8nwLBvyqPu5cpQ3?=
 =?us-ascii?Q?ToPPFGPHL8SWAxo0hHHssWCxM/Idn+IuL/97bxYCuoRg7hTQonw1wH+bKeT+?=
 =?us-ascii?Q?EyCyMctyyoK8JKydWur0O7Q0blumEHDDfrxg7sooLYUDKM05rouN/b40673J?=
 =?us-ascii?Q?lIEB16jYm3ouTyOy9QXo9qJUTvCBUggxnL5/WZcMUqqv0kOFnjzk/JR9Vq/q?=
 =?us-ascii?Q?Q0WdMX+zKgUtKc4CbDZDS2mbBF5IUS0W8Cup+qwo9Y/uFA8jUufvmN/pUXUQ?=
 =?us-ascii?Q?vWWwkdd/orZrEsznEuZ1IzKn0yIWxJp/PQGql9UvmVUkwGiDQuSvN5wpmdUn?=
 =?us-ascii?Q?NITwaBbnfRfh5vtOJ0XMYi1fH/PPt6158SErAUj0HStj4dRrqrl+MeSbthKW?=
 =?us-ascii?Q?Jg08vf7LKBbEkX+jJdYkvVSWvJvN6MoxHQDQwavKQ5m44TrglcYM31U3cThI?=
 =?us-ascii?Q?M45QvcNhJbY1YqQ6gCWO6ukFVb97GpyCkQ84AZAW6Ld4gE83UK/92lK3CV/L?=
 =?us-ascii?Q?Kla344u5myjWuSJD1COlq8HMG3GZjnCDUY6TTli93ZHwfs1GQWlCPrCniyfg?=
 =?us-ascii?Q?1mDymtWfYKjMJNu9FKMk39TaSh0MHQxgiHFpdeJIrR7lxLIG/QftrxoYUVCA?=
 =?us-ascii?Q?bRjePUXgLkTP7mw5fOcL4+D4u4occzyZMrohgPUvEBNrUWrdCXBmPLYoi49G?=
 =?us-ascii?Q?lz/21UbptBTuqGDGgj3lc2ursBljuOxWQcBYGuECXxdECBLa5QIpcoyRkYPo?=
 =?us-ascii?Q?v+QFRc3/rb5YXfBUutrJUDIh5nJlqU8Oi7g8Fd+FCMYlbaHF8K1NOHQX1yg+?=
 =?us-ascii?Q?vthhC5P1f7aVEO/5+jgYAEG5IsNr/97TqJEQPlYn/VND/aY1tKzH1wF0EtZ1?=
 =?us-ascii?Q?5zeBjvVvtVSEImhlUZYXMDnpH+Ai+Pjw7HIo55Mw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c133e73-87a7-4a59-912a-08dae4bd4791
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 08:11:22.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfVuiZYS702TqdHe/rIK9Yntjtk6a4/qbdBThI1mR0/rh5OU4ajOSqLYzt6KVSQFvUcEm7xaWAiHJ55BfruZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:40:36PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Adds online and offline driver callback support to allow cpu cores go
> offline and help to restore the previous working states when core goes
> back online later for EPP driver mode.
> 
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++++++++++
>  include/linux/amd-pstate.h   |  1 +
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 66b39457a312..cb647f55a169 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1020,6 +1020,86 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
> +{
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u64 value, max_perf;
> +	int ret;
> +
> +	ret = amd_pstate_enable(true);
> +	if (ret)
> +		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
> +
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +	max_perf = READ_ONCE(cpudata->highest_perf);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.max_perf = max_perf;
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
> +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	}
> +}
> +
> +static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +
> +	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> +
> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
> +		amd_pstate_epp_reenable(cpudata);
> +		cpudata->suspended = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +	struct cppc_perf_ctrls perf_ctrls;
> +	int min_perf;
> +	u64 value;
> +
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	mutex_lock(&amd_pstate_limits_lock);
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
> +
> +		/* Set max perf same as min perf */
> +		value &= ~AMD_CPPC_MAX_PERF(~0L);
> +		value |= AMD_CPPC_MAX_PERF(min_perf);
> +		value &= ~AMD_CPPC_MIN_PERF(~0L);
> +		value |= AMD_CPPC_MIN_PERF(min_perf);
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.desired_perf = 0;
> +		perf_ctrls.max_perf = min_perf;
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
> +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	}
> +	mutex_unlock(&amd_pstate_limits_lock);
> +}
> +
> +static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +
> +	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
> +
> +	if (cpudata->suspended)
> +		return 0;
> +
> +	if (cppc_state == AMD_PSTATE_ACTIVE)
> +		amd_pstate_epp_offline(policy);
> +
> +	return 0;
> +}
> +
>  static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
>  {
>  	cpufreq_verify_within_cpu_limits(policy);
> @@ -1047,6 +1127,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.init		= amd_pstate_epp_cpu_init,
>  	.exit		= amd_pstate_epp_cpu_exit,
>  	.update_limits	= amd_pstate_epp_update_limits,
> +	.offline	= amd_pstate_epp_cpu_offline,
> +	.online		= amd_pstate_epp_cpu_online,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index fe1aef743c09..1424b09ef543 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -82,6 +82,7 @@ struct amd_cpudata {
>  	s16	epp_cached;
>  	u32	policy;
>  	u64	cppc_cap1_cached;
> +	bool	suspended;
>  };
>  
>  /**
> -- 
> 2.34.1
> 
