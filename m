Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549E9654CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiLWHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiLWHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:43:45 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E89631342;
        Thu, 22 Dec 2022 23:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irqley/W1tPYtg5WvaQ2odTzoOkFQ27caWs5ftnYvIrdUgz34hM1Fayo3wXsNTwdBbFhJY7AFWRYtnr+yymWtssYzcEJ0Lm63tRvpjl2B2Kxqa5MC3CGy1x2rUubsSqjAxb75gW0badGCoPHdNiUA5br59rT8LXtLADI4riXhfM53aBeNHPRr7zuxC3hrsaNTOcvZzproMDRxAzxueyWNSOF0uDPZJ20v6wbinLh4K9yTMm8ggk8Nb6RMNUhnWn3C20KyGPKbzp+3CKjCZYk0i0EiPiDx4ZedYF8tTZbVj23aALN+lz491y5vp9hVMbq6MLPd0xxJKRbkWcaVzuLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtdlvvNlCTiRh5ktt87QlwIAmKlKIC3dfCTqsbmkEd4=;
 b=KIdfjxSSOZRXBHXVx67O3JcDprKC7ZhB+5SDAPorTwXx+cT9TydGRkNLcsl0733Al33FN2LZ36YAMY+Ns92qIWRK15I9ZFh6PfScd+udIb1LSqYaxDljcNbYCLGH2y49MasRLljWa6Cr8EtHWCg0SokKghSsfp5ZpfEXo9mBiYdrRrwmlCqAMQk8wUZxk0ljWxV8KJQfdwiljBOCed2dww/xzt2YGuQ1diOjih7IZOQThptWlPDeMmW0eK+pOVnXQEIfYItDl/cwmV/i0IMGzufy0lne6YkUzicUp5oiRjYvh1vDSY53gqLjW7KM6dTMYE4cwC6mW+9h1o8E9W+joA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtdlvvNlCTiRh5ktt87QlwIAmKlKIC3dfCTqsbmkEd4=;
 b=j8mcGpyPDQwqvXvA0GDIVZnLBL3Kf0oe162H9z4fAj+7NdmvHYidCjjn+sE8HB1x9HXYXKfZpc59dqigmOZTyoEFj/LxRpjvWkVeaT3f7zinyqVED5kkiO3TElxC78qAu9P+HwKtcSFnDe5Vp8r6rlFRs59/iT8g7EAFTWA+npM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 23 Dec
 2022 07:43:40 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 07:43:39 +0000
Date:   Fri, 23 Dec 2022 15:43:14 +0800
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
Subject: Re: [PATCH v8 06/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Message-ID: <Y6VcEvJGn+rM+DLc@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-7-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219064042.661122-7-perry.yuan@amd.com>
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BN9PR12MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 4132b940-8c57-481b-2a8c-08dae4b9680f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zxBMBXyfR9gIrTY6KC8+zTYhpR6c2VLm4XBsTNugDJ2IfiNBpbX67gQfL+kjLd/KP7RVmJM1xCHz7FOueGeUSaAGR0Sv2fIJHbAv6JfZ9FZnR8WuJ63uAsHfMy+nSAZgNYjD1DHF9wrjf2y2Vj+1ftsZX1rTDbm+Ud1raRRP3Rt8r152csyiyjUBKiSWgGJd56ClmIFv2yI5yAcKPapRHrKWmKxTxUllEH56H5EZ5vg027+mi/hvVd8hEP60nmOfC8xRSQreXfh08s+VeARe1d5oBsVgtqBica/uX6rwTfXok0I7dkW5YACGNI7OAE8dTMS0JHmEXOdTQV12YnjoqCsr3zRCXqqziDHLvwWnPIF9jtBuDZIDKirwSbTy+OtZvfE1bJwf+zgVGYDyrMSExT475gV9858EXIPurlo0n5uq8midksUpsPwpS6THVR09DwhrQZoqYerOwnwDdwnho4pxgncc5bdWu7sKWFWYN5Y9T7pcV5OXrY08NmsXHv5FMm7mCjGnz4UNvc6yXTUggEpRpgYlN4CUix7TfQU5jQv4jDqpukEO3ryL3dSUzJxIom+mRrOG9AzqbwCLIbkjRNG03A+ZIYH21NSkaqDHnfAxiIb51byGFEgZy+8wvHE+8IWWrpOHrEYMKk7jwIV6NO+iBCIxop/P/m7pCfbhIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(38100700002)(8936002)(6862004)(66946007)(66476007)(66556008)(5660300002)(4326008)(8676002)(41300700001)(30864003)(83380400001)(478600001)(6486002)(966005)(54906003)(36756003)(37006003)(6636002)(316002)(2906002)(186003)(6512007)(26005)(86362001)(6506007)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZfXBmoLmAmZNmwoG/sPSdj8Z9fazBkOCHWGhpCQGgHDOqJGpNzTCPIWztPAw?=
 =?us-ascii?Q?Wx2pPUUMTifaOMMAq3EggssxPCXNAC1emuqBjDpbVrtJPjAW3JJf+mxF3sAg?=
 =?us-ascii?Q?x++YxqsS97lJLl5GDP6JTHtZG08YHaVL5PlKg2rsbkxY8fJdBmUXibFvM8p6?=
 =?us-ascii?Q?t8/0BCwKlbGeH5D8bn0/VkdY7JfrGwvDVNbknYX7qcysMHY9ZK77Rvzu+7UT?=
 =?us-ascii?Q?OkTS7ZV/VejSF+QyeXCKjVK9YiHbanT3v/BaYJCAnuYJqzX/GyvyrbiTk9V3?=
 =?us-ascii?Q?TmJkzr2gZiOHi6xaWYBA1O8LvoWGOXHppnMfsyCesLFzjON6k3N22iJc1S68?=
 =?us-ascii?Q?b8If1Zlig2ML9D8nZIlMXKOmNRtspOzuqH+07v6nsazOgmrME+guAXovdDHM?=
 =?us-ascii?Q?wwxzb6gqhTd0TZYnXGUGav6Y3+Y6e2h75rLj3euaeY+QT7niVMIFpBcNBirZ?=
 =?us-ascii?Q?q7qYc0q8X1HgIMaNe5hyCu7qak4r22Igc8n/Vpdf8xG2CEH80vkE6p0/eQOl?=
 =?us-ascii?Q?phffVH3lYmwai4SREALFfVvIedEE1065XPP/vYa7geUqB7FNKruZ8j2iPgSf?=
 =?us-ascii?Q?w+7wjLUBqoEmFtj+HoQMPiYGblPXREDtnJnTPPeckl5Uh4jsKc8dlIxWuhww?=
 =?us-ascii?Q?IVBNDwKiX1wYqHV3H4Ubug4YhpP95CDKmsKBUGumBsFknWeEhgr5/OV837kB?=
 =?us-ascii?Q?l5/OZ7eg7kB1/hdVrSOYDmSH8s05NbkG2xYzC35XZZaFj7GRDf+jaJfNnU6Q?=
 =?us-ascii?Q?XZDNNHsG0H8+d+U8gjUBuw8zrIx1BIXzHhVFHUQS9oKzYDFoMc7YaA6XQDlF?=
 =?us-ascii?Q?eQrKstAnXNzj5A6uaJmlGLFJnO/7vzCjn0vAGjcmA3JUlW0uzmYlXjIQHejn?=
 =?us-ascii?Q?56BzbSm5ztPFvsRRZMzLYA7vZ2cNcTYZeadcipDhH03Y0Kdix6VA1UhP15mv?=
 =?us-ascii?Q?DmVai8h2kF6Wgu/SwBTR3cYmLH9BEmvmdtzGQd9o9IqXuu/M6l2Q5alQCbQQ?=
 =?us-ascii?Q?GAXqCnyyc42NZ1iUro89My9u7GNFOiqdEceEniewuz6fn8caJ51BLLxgqTd6?=
 =?us-ascii?Q?HR7xWrCRCjRBSdCwliibRGcu9A+Qr1bC0er3qr8nRzRMHVV2LREIe1kWnXfx?=
 =?us-ascii?Q?BNqoZfvyY79EVKQnIw6fJbiOP9EUtv19L3iULFtDEWqYRhwPkbqEbm6sG0EZ?=
 =?us-ascii?Q?cP3O4aSpHp3MuFDz8ToNpk3zm27q5AKl3WpVQR/2Yimqru36FnIvYAWW2TN5?=
 =?us-ascii?Q?PhBHJIkfJkOHUWBs2lH+JivUNL5x0ug2pQ0v+gWdrlvIkIA//uuYEBwnXgN2?=
 =?us-ascii?Q?Xp6CTnD45pe2IEnYfBAlljUtWGi9lAt9d63gwmKlA7fI3+5tbZkzqUQBWt2K?=
 =?us-ascii?Q?yLbfNahpJmZc7aMKyfwWyEb8SPzi0nhbVRDWaLwhY5mWHEBT54PgPF9Sa5mH?=
 =?us-ascii?Q?6hR3M9kFySyHb+No/P+jAAo5bXmVHHLujo+16B2Yh1MJOAyAGze1qYr/lJOw?=
 =?us-ascii?Q?G3gWRGzhKX7IEbf5m76ZW2y1/DkAoq+KqJ+wJjCcN6n59S+X6V4AJ1wWNwsG?=
 =?us-ascii?Q?Bvtu8Ll00i5M9rEhSXAOoWqdtVFughWFhRvGcEg1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4132b940-8c57-481b-2a8c-08dae4b9680f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 07:43:39.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUBTcmkeJh+dpSNZ/h3qdhOUhAqZez2bs1cqRYxAWb3P44dZg/q6NKRhip4gjbWUav1ICfecf/BGokqVPKKH5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:40:35PM +0800, Yuan, Perry wrote:
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

Please check the comments in V7's reply:

https://lore.kernel.org/lkml/Y6VVr+WYqwWb6XV0@amd.com/

I think the static call is not hard required at this moment.

But the boost/refresh_freq_limits stuff and cpudata may still need some
enhancement. Others, looks good for me right now.

Thanks,
Ray

> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 447 ++++++++++++++++++++++++++++++++++-
>  include/linux/amd-pstate.h   |  10 +
>  2 files changed, 451 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 861a905f9324..66b39457a312 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,7 +59,10 @@
>   * we disable it by default to go acpi-cpufreq on these processors and add a
>   * module parameter to be able to enable it manually for debugging.
>   */
> +static struct cpufreq_driver *default_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
> +static struct amd_cpudata **all_cpu_data;
>  static int cppc_state = AMD_PSTATE_DISABLE;
>  
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
> @@ -70,9 +73,128 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  		if (!strncmp(str, amd_pstate_mode_string[i], size))
>  			return i;
>  	}
> +
>  	return -EINVAL;
>  }
>  
> +/**
> + * struct amd_pstate_params - global parameters for the performance control
> + * @ cppc_boost_disabled wheher the core performance boost disabled
> + */
> +struct amd_pstate_params {
> +	bool cppc_boost_disabled;
> +};
> +
> +static struct amd_pstate_params global_params;
> +
> +static DEFINE_MUTEX(amd_pstate_limits_lock);
> +static DEFINE_MUTEX(amd_pstate_driver_lock);
> +
> +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +{
> +	u64 epp;
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
> +		ret = cppc_get_epp_perf(cpudata->cpu, &epp);
> +		if (ret < 0) {
> +			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> +			return -EIO;
> +		}
> +	}
> +
> +	return (s16)(epp & 0xff);
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
> +
>  static inline int pstate_enable(bool enable)
>  {
>  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> @@ -81,11 +203,21 @@ static inline int pstate_enable(bool enable)
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
> +		if (cppc_state == AMD_PSTATE_ACTIVE) {
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	return ret;
> @@ -429,7 +561,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  		return;
>  
>  	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -603,10 +735,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
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
> @@ -615,6 +798,235 @@ static struct freq_attr *amd_pstate_attr[] = {
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
> +	}
> +
> +	cpudata->epp_policy = 0;
> +	pr_debug("controlling: cpu %d\n", cpunum);
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
> +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
> +
> +	policy->min = policy->cpuinfo.min_freq;
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	/*
> +	 * Set the policy to powersave to provide a valid fallback value in case
> +	 * the default cpufreq governor is neither powersave nor performance.
> +	 */
> +	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		policy->fast_switch_possible = true;
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
> +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	pr_debug("CPU %d exiting\n", policy->cpu);
> +	policy->fast_switch_possible = false;
> +	return 0;
> +}
> +
> +static void amd_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
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
> +		if (epp < 0)
> +			goto skip_epp;
> +		/* force the epp value to be zero for performance policy */
> +		epp = 0;
> +	} else {
> +		/* Get BIOS pre-defined epp value */
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		if (epp)
> +			goto skip_epp;
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
> +	amd_pstate_epp_init(policy->cpu);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> +{
> +	cpufreq_verify_within_cpu_limits(policy);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> +	return 0;
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -628,8 +1040,20 @@ static struct cpufreq_driver amd_pstate_driver = {
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
> @@ -656,7 +1080,8 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -664,17 +1089,21 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>  	}
>  
> +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +	if (!cpudata)
> +		return -ENOMEM;
> +	WRITE_ONCE(all_cpu_data, cpudata);
> +
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> -		pr_err("failed to enable amd-pstate with return %d\n", ret);
> +		pr_err("failed to enable with return %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
>  	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register with return %d\n", ret);
>  
>  	return ret;
>  }
> @@ -696,6 +1125,12 @@ static int __init amd_pstate_param(char *str)
>  		if (cppc_state == AMD_PSTATE_DISABLE)
>  			pr_info("driver is explicitly disabled\n");
>  
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			default_pstate_driver = &amd_pstate_epp_driver;
> +
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			default_pstate_driver = &amd_pstate_driver;
> +
>  		return 0;
>  	}
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 922d05a13902..fe1aef743c09 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -47,6 +47,10 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +76,12 @@ struct amd_cpudata {
>  
>  	u64	freq;
>  	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u64	cppc_cap1_cached;
>  };
>  
>  /**
> -- 
> 2.34.1
> 
