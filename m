Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A91649C09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiLLKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiLLKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:25:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C8BE0B9;
        Mon, 12 Dec 2022 02:24:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4oUWpq94SuMI2nMD6rEUPO28Rk92G2338ULzWtbBTnRtjE1OFg2fiWdaJgYIlHgMdBzBvD6zncHqoycvevkr7mVAgvhVRar7rg6qdbMKSBEofqePJipVGEd1sHphIPb3XcqwsRa7MuFZeoG1AQg5R8gIHn/Pf7QjBDo9PEyoGLAf687HtdvSqdxc1F71CyKjo/mZrE9m0vPlLI4boX16hGlo8G+zgIZi8d0YoW7G1bUVvtce4hhalvkw/vUjtGb0WCSCXEclBeMnZFgLo8INqtwoTbm5/jPVrmcowT34LdyjXMrHENq7qVFFIg4VEJXbHjrkGgaOWHaywjflpxo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrZkYx+bCWBI5eujDYokJeI0UyQtwSZzM8WgcGLg754=;
 b=lzpx8WMC4nd43hmvnfN+etyuk9TG5x4e1w2XwYqHFZi9y7nkedW95IeqWg14NSEbMxvgn0WmYg4zp53Y2ilTANqHbeNM4G2lXBmTs9cbQtvF6E7dj6x7GI7sv+TFMZAjiV9U8iBLr0YEHiD3If8uTNRIgxvaN+7RgQsg42BIb9Atbmid9kpnLjvkq39j5IiWEbFRN2mZHn/gqBoPJAyv5P1Eh3kMKuqqEUqwCp4tKppce0yL8HAhMhij4udCsnNTyt7Hd5Ebp2Ki9xaSt7ZNHTD/gvNp0OQMZeTGAuS1CGGkjxgEAR/QXZgJV79i1TZzfy3qCuvpyvDLh9gc8xAb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrZkYx+bCWBI5eujDYokJeI0UyQtwSZzM8WgcGLg754=;
 b=0vRehmyRYe7Fg0rfw3DmDdoWNunzPI/FTh5aQ2SU5BRSXaJDo6IJUNIDfigeIKZ2MPP48UVLRbJkSjzhxVpUEbQ4lM8mq1fpRt7kk48YTu2lhJWZ/YPHShcJ+TqKsmwVDcUVW41kPS2JuqyvT55djpkF5saqar3W9v3YWArBraI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 10:24:29 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 10:24:29 +0000
Date:   Mon, 12 Dec 2022 18:24:07 +0800
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
Subject: Re: [PATCH v7 09/13] cpufreq: amd-pstate: add driver working mode
 status sysfs entry
Message-ID: <Y5cBR820cD2nc+wa@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-10-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111852.386731-10-perry.yuan@amd.com>
X-ClientProxiedBy: TY2PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:404:a::14) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b67df4-5ab0-40c0-89aa-08dadc2b0d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdfX46POBrr9RdLYBrXjk5ne9p1KHocfBZ7ma4kpTZIqHcg/Ij9KB7rmfAStQwP/T3+eTRGpdaiwacnh5qu3lHVxeA2tmkKWmBLF8rpQIbWJ3DBMa+JssI2OIdyNhd4Pa9D451l5ItsbecvyfM+06Tmcy8e7Vu7+jJhiLZISHn+igF71UEe26EfGTK0DKhvyoyYo0luWPg1/+dENIAtpaUiFLXbkbDQOARAkxxVNYpeuvpjpclVn6eNfe/rjFxpD76BDppiKp7cwu3d9mGFhYh8H9aZLRlU0Tjh+1td7uT5fEqiINnSXGbfwqfI3OijlSZPqlCfj8ds7Q255xgXlf0/tdTcWZUmLeDwqhV8wVpc2CwOTc2BCAUMLCk89JNNDopdguR7a63arfbCKVynPZ6KV3uLGnX9s0prhoHdilhKNpzz0o25koDFlbfYNZblm/KiXkCX5Djhl2aGMzWHV0i+/eVRCGluhd2l3STGZCyReL8a3YjOnrcJ37RyEBA8cZlCOrWxr7tPjW/Ho/rg5ag4IHkGPn7jWuBkcB+T11J4jQ44/eGMVbKJtnTjW6hYQW8QuY41Ue+ZC7pbZtI/Ki1kf37lCLWchDsmxHEsZIpwX16ouzfKepxj/Hk2FQWtuL3YPqBgjLgf7mUbMZqF/avEniWO8nDWFAylycdQ/cr7iV39JVQ7X72iryNyKWuOx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(2906002)(6862004)(54906003)(6636002)(316002)(8936002)(37006003)(8676002)(66556008)(4326008)(66946007)(66476007)(36756003)(41300700001)(186003)(6486002)(478600001)(5660300002)(26005)(6506007)(6512007)(2616005)(86362001)(38100700002)(83380400001)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s6XYTtZ1zyxYwAVSAe6Y3vGQ635XW5MvAksoCspiPcI6Kwev0qReaipuJLUd?=
 =?us-ascii?Q?D2vH24NJRxSzCJp9uUwzmx4vDvVxh1UnpvGpR1XgLDr5ByKH+TqwCqW1cGwE?=
 =?us-ascii?Q?qdF0KmwPmm2b2yBC+gj0LpdBScmg+1iKAjt0d099DqhyTO+01ICB6HAktUKT?=
 =?us-ascii?Q?FTEpVgdq5saczZfJ4qnzoUlnn9CMw79xtpRwcjm5wcXqzH71QE2Ft/JRWVD/?=
 =?us-ascii?Q?l2opLFKy6HJmjjFblGL7E7nSnfovpfAoUPznrM2PzCkq+IQ5WHTRf0tp337y?=
 =?us-ascii?Q?vyorCmGGc47If0oWJ1r2v/t50J4aZeAVOkbmSSdkGHyx0uDaeaNHPGU20BxS?=
 =?us-ascii?Q?+vRSmHBrBqqWad5CgjPFXL0G93yz5P0XAiaSwb7lp5sawQ2FyGifl9fzmmSn?=
 =?us-ascii?Q?/+B0YKq1SJE0N1P6SJRfwN7eiK3lKQXaMPVCRMYWl3RQIAQGOChoJlcomxXF?=
 =?us-ascii?Q?S2ylahAgA2JlxQKypI/NSYVZPsn9xH2U1lAsmYzkFFCXWoWRbRuiRR6iyBTr?=
 =?us-ascii?Q?yhVcLOXctmxlUCqU5w4zKups2OAKOgCEq8Par6NxycsjoIpayGLy/n64boUK?=
 =?us-ascii?Q?a5g/anSSnKiFUdTdmfTdHw2zwar09MgR/M2/Zx//5fauwajLaK9QJpH5vijl?=
 =?us-ascii?Q?HvWHEp99pMKLY8LYeWvg3VgAzDGMUZR3Hz+EBhcPuDa3OhVX3cpORUAm3CXB?=
 =?us-ascii?Q?TTzGtBpfszJEExuctnK01qQ6dj5pQ0oFLrv+RZlNxXR2ZnAqtMeEirX5MGtQ?=
 =?us-ascii?Q?Ypv0vDTdRW/KWwl4LkgnLxsBtIOdsUrBgjMSFG11BKdOQlhPUP+XLck8DA0Z?=
 =?us-ascii?Q?l6yuGa2Bu/LGmntCi++n0zD9C61u/EzzUV7Htn8SOfRaRAYluQOiyHZS0oRr?=
 =?us-ascii?Q?1/s3RnY0778BOyoC/dSA2PWNSJrcqhqcFrPMJyIwK52vH2IgsQ2sFhMbaDgK?=
 =?us-ascii?Q?t8SJHz5M6YCjNn4ISxeAqXTrpQPbYD4DZ8RPmDVFQeV2328L//42MjLFW6b/?=
 =?us-ascii?Q?p1WQF+3dZuZ2BJzqZF4l5HxedH5TedyvmYLs80mF6pAhl129sLyAXHPbfo7X?=
 =?us-ascii?Q?p3q7oRHRTH7d0BcHc3UOdh+g/DoLxQKliddBbifkI6u4ADz8eyglQezPJMgu?=
 =?us-ascii?Q?0EsaOwAv6jfQZ70+5AQJdTe53mpeIuGLKyyFmzLptbxhSjpB35XTvs6XDvO6?=
 =?us-ascii?Q?kwVy+pomeiBrulZ7+xcqNVFV+D+BHw2Vh/w+wEi4qEKXWcr8HUFosmEefsE2?=
 =?us-ascii?Q?OCjNXBuwOkfyfroalu+PDEVf6OhC7tIX3r/LI/33W9OcLxdM2uFvrbBYbW5B?=
 =?us-ascii?Q?injXXAvX1pALrBmlmRilqlryMkt1PGb2guvdAYChg7du6Kzs68e9t1djw/tx?=
 =?us-ascii?Q?v+GWmEPYA37ZV6jXhGSlzluvXhSWPhVqh/2lcr4gUnubDB7lmC/4lbX3YtQb?=
 =?us-ascii?Q?+e68Dvlq8cKH+VgurewZ560FV5nbA6Wu2zJdr1YewYHngc20aCCLfFBrK04m?=
 =?us-ascii?Q?hdhpixTzA9NtDd9PhdVOwoGCdiWZdKC7PRTKsJx6E+dr1fevvlYQ+DLyqvky?=
 =?us-ascii?Q?dt7qUBPw0kX64ruWUcRJCFuX2/zapvSt9gaXGWBV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b67df4-5ab0-40c0-89aa-08dadc2b0d61
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 10:24:29.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCmJRAGFHZ18lBpwehDbEbkBLl1wJVR2bAPWy6S58ID5E2q0TLbh5iz0I5ds5YOiod9uq91/jSKaqgU1qI7OVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:18:48PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> While amd-pstate driver was loaded with specific driver mode, it will
> need to check which mode is enabled for the pstate driver,add this sysfs
> entry to show the current status
> 
> $ cat /sys/devices/system/cpu/amd-pstate/status
> active
> 
> Meanwhile, user can switch the pstate driver mode with writing mode
> string to sysfs entry as below.
> 
> Enable passive mode:
> $ sudo bash -c "echo passive >  /sys/devices/system/cpu/amd-pstate/status"
> 
> Enable active mode (EPP driver mode):
> $ sudo bash -c "echo active > /sys/devices/system/cpu/amd-pstate/status"
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

I believe you should align with Wyes to send out a unify state or status
API to indicate the state machine of different work mode for AMD P-State
driver including active and guided mode.

Thanks,
Ray

> ---
>  drivers/cpufreq/amd-pstate.c | 101 +++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4cd53c010215..c90aee3ee42d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -64,6 +64,8 @@ static bool cppc_active;
>  static int cppc_load __initdata;
>  
>  static struct cpufreq_driver *default_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
> +static struct cpufreq_driver amd_pstate_driver;
>  static struct amd_cpudata **all_cpu_data;
>  static struct amd_pstate_params global_params;
>  
> @@ -72,6 +74,7 @@ static DEFINE_MUTEX(amd_pstate_driver_lock);
>  struct kobject *amd_pstate_kobj;
>  
>  static bool cppc_boost __read_mostly;
> +static DEFINE_SPINLOCK(cppc_notify_lock);
>  
>  static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
>  {
> @@ -629,6 +632,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->driver_data = cpudata;
>  
>  	amd_pstate_boost_init(cpudata);
> +	if (!default_pstate_driver->adjust_perf)
> +		default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  
>  	return 0;
>  
> @@ -802,6 +807,100 @@ static ssize_t store_cppc_dynamic_boost(struct kobject *a,
>  	return count;
>  }
>  
> +static ssize_t amd_pstate_show_status(char *buf)
> +{
> +	if (!default_pstate_driver)
> +		return sysfs_emit(buf, "off\n");
> +
> +	return sysfs_emit(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
> +					"active" : "passive");
> +}
> +
> +static void amd_pstate_clear_update_util_hook(unsigned int cpu);
> +static void amd_pstate_driver_cleanup(void)
> +{
> +	unsigned int cpu;
> +
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (all_cpu_data[cpu]) {
> +			if (default_pstate_driver == &amd_pstate_epp_driver)
> +				amd_pstate_clear_update_util_hook(cpu);
> +
> +			spin_lock(&cppc_notify_lock);
> +			kfree(all_cpu_data[cpu]);
> +			WRITE_ONCE(all_cpu_data[cpu], NULL);
> +			spin_unlock(&cppc_notify_lock);
> +		}
> +	}
> +	cpus_read_unlock();
> +
> +	default_pstate_driver = NULL;
> +}
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	if (size == 3 && !strncmp(buf, "off", size)) {
> +		if (!default_pstate_driver)
> +			return -EINVAL;
> +
> +		if (cppc_active)
> +			return -EBUSY;
> +
> +		cpufreq_unregister_driver(default_pstate_driver);
> +		amd_pstate_driver_cleanup();
> +		return 0;
> +	}
> +
> +	if (size == 6 && !strncmp(buf, "active", size)) {
> +		if (default_pstate_driver) {
> +			if (default_pstate_driver == &amd_pstate_epp_driver)
> +				return 0;
> +			cpufreq_unregister_driver(default_pstate_driver);
> +			default_pstate_driver = &amd_pstate_epp_driver;
> +		}
> +
> +		return cpufreq_register_driver(default_pstate_driver);
> +	}
> +
> +	if (size == 7 && !strncmp(buf, "passive", size)) {
> +		if (default_pstate_driver) {
> +			if (default_pstate_driver == &amd_pstate_driver)
> +				return 0;
> +			cpufreq_unregister_driver(default_pstate_driver);
> +		}
> +		default_pstate_driver = &amd_pstate_driver;
> +		return cpufreq_register_driver(default_pstate_driver);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t show_status(struct kobject *kobj,
> +			   struct kobj_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_show_status(buf);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_update_status(buf, p ? p - buf : count);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -809,6 +908,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  define_one_global_rw(cppc_dynamic_boost);
> +define_one_global_rw(status);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -828,6 +928,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&cppc_dynamic_boost.attr,
> +	&status.attr,
>  	NULL
>  };
>  
> -- 
> 2.34.1
> 
