Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3BF698CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBPGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPGQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:16:24 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A628832CF7;
        Wed, 15 Feb 2023 22:16:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RenhIbbpqQrCGHpAUuxVYMoN/iLnf5i9cNXY16+d83bMRiZMWuWI7r7n9dVmtFjqhvtBIh0FeRc7HgPqT1C9sqfbFXtPiAGRZhPoy2HmjhSHA9v2zJ7N0OOQ5SKY2Oi2e8sfcqm/NObgsJuhGP7fzc7DRwUhZrYL1R+K7SXFl9nDjuIdMtFgC+o3d/Dv7xmqdcNauhg6ueS2kjDQbWbX4uau4EbC5JlKaqiRBgQPAH/x97GPtYNKcJOOe9QBp4V54dI174GDAnYGv0RpFYFH2mzFMOS9fIgLQkovqPYc6tJ5KIZXWzyGHWeHVqXp4Jj5jA9YfYaY4lrdawr2KKEt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzYr/Dc/bxPCYLBDAvRyRduY+sE2jD5Za+k4kmQ27OY=;
 b=DeWJDUjGyp4ZQwrJ9ex2oWCY3GEr7MDiBJSbnXqAQjkgEXuLgRrq/YU4rl6Wnb76Q6eOngXUXed7fcg9AjkhymVFrf6rEy23K2OFtYK9oyb5TCZSbIXuvJ83vhTa6XjDuGW/9Q4SxpXeQkmcSOxjZAGcExQ+9RW1xb8bgS31VVJieyT9aASVgAqZK3j+rjnAlA4yp+nkOMFoOssUXoYcRzAVqMzALXAflywiLWZ/BXFIZjCLmX5J4rGn0YMEMga3WcMYlDLzoErWqfIIt/xg6dekCycvPCyZLDyPNpSUPPFtzZ0YHe9ltN/pxb0jPQuR35x8HSX4UDxE6oBpK3kNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzYr/Dc/bxPCYLBDAvRyRduY+sE2jD5Za+k4kmQ27OY=;
 b=5S4y47kXxLj4iQYUAcSxBpzTw9BvjIaRgYbuumI8tw2L/7nfgZw90lfJDKjxutF28LBuEg6a36tpA7NqC4rB3cuWyn0pQtlZLFolIIaYSrhHjbj4PaknXCkrtovlan/taKCd9TTBBmwx96SXLeJgkym9ZaOJYNV2yQdHmHD4ojQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 06:16:20 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 06:16:20 +0000
Date:   Thu, 16 Feb 2023 14:15:53 +0800
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
Subject: Re: [PATCH v6 5/6] cpufreq: amd_pstate: Add guided mode control
 support via sysfs
Message-ID: <Y+3KGcHWPggR6371@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-6-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206172157.49887-6-wyes.karny@amd.com>
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e97e121-871c-431f-ae57-08db0fe551c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/9WDV64twYPtJfHBm5SU8Q77bxJ6q9P5V/2+wzdMJ0uIEyJp0nkJrbMptpx0YlvUaAaQ/thvF1Nnr31F8r0lraxsI3l8+QHmAZBuWGQ+4Z6Z8UdHFRZA9GPvzalaLMn4AJEUY3T69HWk91HWCjbOvVNaTf1cxjr2EQlpS43qlS+HCsVPIMiB/9VO+0W9yg3fwfYKqtjGhRdZhZIsixmmUBbg+tUasZSXzzg3Qgpo8Qd5jmkdbi8ZiPBQYfKgt7vDMWu8rz/zAsYGSqQP3nK1lH4OlKYbllgn9874skDCq/6F+sX2k948keUNEDJpoNnajq+R7IXej1OsCSGCPHj+k4Y4spFd6RX98gekreiyJETCt3dcTy09dXvheKbFYCWz7lWow9agrmJ2cVCRPhLnFoXPwGOvr22sprbPmBRk6qJitYyvKkAN1230+r4tMxRDlpKE9/zX33wp9Qa7B8u4Lb5o4znaRAqustvZJJrSClaKiEw8tgoR2sk1UPDP0yWYwd04fbg1VZjp56w80R98Q5NwJ8Qel1kdWOLuwI45uxBMRreqswHmGzA2xEX4Y6mTZYJcPqxDphRmLKzae8l4ASbvydDyOi+PyiA2L64eW1ajgg0bhflxyEStKeCM4Al12m4KCLBvOd/uBMAVVBIPAa1knATaawJhCMyjrOz+nkax3L+c4rBI0+RMyQ76WVM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199018)(36756003)(2906002)(54906003)(6636002)(5660300002)(7416002)(8936002)(6862004)(66946007)(66476007)(66556008)(316002)(37006003)(4326008)(8676002)(41300700001)(478600001)(6486002)(86362001)(6512007)(186003)(26005)(6506007)(6666004)(2616005)(83380400001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?maBgA7wELj3hPu2bq+B5fdhjojh195QNGxraRXcRlt3MCM22DdvB7ZClTh6r?=
 =?us-ascii?Q?BAdZ82RjREgdV89NhAp3Fwvmkw5C5Wm/e6/+gfeQEY2wpQ1ra6VozHYpkJxw?=
 =?us-ascii?Q?kItm8OwR429HFReJe6dpUsPtldpfcNsfvxgVuE2om3fDBP5C0eipCKKdJNH/?=
 =?us-ascii?Q?uuGVap0Cs0G0ucBpsc6No4rMOByczHoTr+BoJckaozJUniik6G0ax15VZDQ/?=
 =?us-ascii?Q?oq3KZN70hEotNOIod/NxD6DatzG8ZkSpG2ReEjV+WbEHsvupbihxZNQRYsE5?=
 =?us-ascii?Q?iHRJY0w01xSHra4ceN1OUnzQ6a2C1DXqwuvV1nIPQu5n/lvPsNcKmAmJt0Ou?=
 =?us-ascii?Q?+2wCZKdWNRNdQBh2QqBPcf6sltRxYU19e5q9vaC7dbTEGdPEAFVV/kaz2Af+?=
 =?us-ascii?Q?INISeReWzvVtN9t9DftyStOz7upeuDPrVYqttJhTfZDMvURcufe/ZzoQ8aOF?=
 =?us-ascii?Q?cXHxgSa1RjjSgHJtq6mj9XCK2mWeM3r4u3rYR15fJApM+drqN+fnqMhEm4pY?=
 =?us-ascii?Q?kYuv5+yIaJJlmrfof2HJjwcT0WbcvTrAeRlqJzLpfu+38nIz0UIfqBJmi6AJ?=
 =?us-ascii?Q?VrCvVxAsB8eNmT0F6vDYpoIYHlfY3fICwLNgx0NjWkR1ScHeG5a+PJAF/B/m?=
 =?us-ascii?Q?Em/0TfFQktKS5YUTOpD51irXF1KXckCS/6ExL5hsqCBWW79TstEOoCP+7Ljh?=
 =?us-ascii?Q?3plhFOZA4753AZLacWHQyOLVrSvoy+TDLBL7gkwqdKZw73LNNLf+eyzYE7iE?=
 =?us-ascii?Q?xpJ/1/SOr7X4vxhNwsA+CUija+bBcaizCLd7rt502tC8k/ACqITI1sippbQ1?=
 =?us-ascii?Q?Jqt9ZlSI8rAPnjzmwu5m9Gy9tOuKGf93WFlKAe4Tz1Wf62pqWXzaJiiu8gtK?=
 =?us-ascii?Q?Lqj96MCqqQlzzWi6T9Z1hf+yFAyqGNZc6IpIJVDyhzF6+9o8SrT9iLrXrZwx?=
 =?us-ascii?Q?bPWJgvl3uXzRXX3qsE5W2bSqjB061GirunCjK3pD5o4CpyIQAHp/w0k7+3xt?=
 =?us-ascii?Q?r2X4f6guZEwnHuqjcVGcwCj4yIaBAXBxnol1P6DDxYIYKzsziv/l42nMKJwg?=
 =?us-ascii?Q?Cz1SlKKsOvk41WbSxHMvgqAVXj3sFDpHmOvaJ3bvGZOwucU1gR++Wsrce20a?=
 =?us-ascii?Q?oe/8gWQhX0nMnvWOIiE5iVUJZGBIPPec36POL65JutVELWySAo+Vwj6nUhNn?=
 =?us-ascii?Q?Us8iAf0cBsFRZVM2UrixOxihs8v5GDl5DBgtn9DGaHbe4dsHiC8kr+qj4By3?=
 =?us-ascii?Q?allkwPWYnsxSaLNG0txf0JCQOPI0kix2WTFqrwgy3Y71ww59Gxydw2QZXbnR?=
 =?us-ascii?Q?ojvQg0e3ZPlGEVjOXZ80jUF2+KgQtp+db98pOEjRucSHO6cKSMgQYxoV5dDV?=
 =?us-ascii?Q?pjTNOv+MQihBSuIn4vcQn5mWtzJteD1lngbFTtWODOtwozahcpE9AYcoXTsU?=
 =?us-ascii?Q?txC43vftfzB78hDxlLcJHMmpsKO/BhgP9W+tlLPgkM0JNwI0ALrKNht1nJxs?=
 =?us-ascii?Q?vTP3U3ByLLAwKOOWuFQ7vz+wwB/lnxX6nZFaZSF3Hj8uB/EzvS3Mv4MNH/be?=
 =?us-ascii?Q?0Ar38WcSGfBjqLgeuT0kwqeFH8lcdbSGBksTv+9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e97e121-871c-431f-ae57-08db0fe551c1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 06:16:19.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sFOMBfz8mhQ3gRQYh6oYYB/d7EH7c0STDwwydSWUbvxmLGSnmeQyYSF1YuTIBrDZyTccArbhAEyZ3hRoT4Hpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:21:56AM +0800, Karny, Wyes wrote:
> amd_pstate driver's `status` sysfs entry helps to control the driver's
> mode dynamically by user. After the addition of guided mode the
> combinations of mode transitions have been increased (16 combinations).
> Therefore optimise the amd_pstate_update_status function by implementing
> a state transition table.
> 
> There are 4 states amd_pstate supports, namely: 'disable', 'passive',
> 'active', and 'guided'.  The transition from any state to any other
> state is possible after this change.
> 
> Sysfs interface:
> 
> To disable amd_pstate driver:
>  # echo disable > /sys/devices/system/cpu/amd_pstate/status
> 
> To enable passive mode:
>  # echo passive > /sys/devices/system/cpu/amd_pstate/status
> 
> To change mode to active:
>  # echo active > /sys/devices/system/cpu/amd_pstate/status
> 
> To change mode to guided:
>  # echo guided > /sys/devices/system/cpu/amd_pstate/status
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I suggest we can add mode change function into CPUPower tool to operate
this sysfs interface.

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 149 +++++++++++++++++++++++++----------
>  1 file changed, 107 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6582c922ad3a..4e74f59804ae 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -106,6 +106,8 @@ static unsigned int epp_values[] = {
>  	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
>   };
>  
> +typedef int (*cppc_mode_transition_fn)(int);
> +
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
>  {
>  	int i;
> @@ -838,6 +840,104 @@ static ssize_t show_energy_performance_preference(
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>  }
>  
> +static void amd_pstate_driver_cleanup(void)
> +{
> +	amd_pstate_enable(false);
> +	cppc_state = AMD_PSTATE_DISABLE;
> +	current_pstate_driver = NULL;
> +}
> +
> +static int amd_pstate_register_driver(int mode)
> +{
> +	int ret;
> +
> +	if (mode == AMD_PSTATE_PASSIVE || mode == AMD_PSTATE_GUIDED)
> +		current_pstate_driver = &amd_pstate_driver;
> +	else if (mode == AMD_PSTATE_ACTIVE)
> +		current_pstate_driver = &amd_pstate_epp_driver;
> +	else
> +		return -EINVAL;
> +
> +	cppc_state = mode;
> +	ret = cpufreq_register_driver(current_pstate_driver);
> +	if (ret) {
> +		amd_pstate_driver_cleanup();
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int amd_pstate_unregister_driver(int dummy)
> +{
> +	int ret;
> +
> +	ret = cpufreq_unregister_driver(current_pstate_driver);
> +
> +	if (ret)
> +		return ret;
> +
> +	amd_pstate_driver_cleanup();
> +	return 0;
> +}
> +
> +static int amd_pstate_change_mode_without_dvr_change(int mode)
> +{
> +	int cpu = 0;
> +
> +	cppc_state = mode;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
> +		return 0;
> +
> +	for_each_present_cpu(cpu) {
> +		cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_change_driver_mode(int mode)
> +{
> +	int ret;
> +
> +	ret = amd_pstate_unregister_driver(0);
> +	if (ret)
> +		return ret;
> +
> +	ret = amd_pstate_register_driver(mode);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
> +	[AMD_PSTATE_DISABLE]         = {
> +		[AMD_PSTATE_DISABLE]     = NULL,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_register_driver,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_register_driver,
> +	},
> +	[AMD_PSTATE_PASSIVE]         = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = NULL,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_change_mode_without_dvr_change,
> +	},
> +	[AMD_PSTATE_ACTIVE]          = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_ACTIVE]      = NULL,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
> +	},
> +	[AMD_PSTATE_GUIDED]          = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_mode_without_dvr_change,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_GUIDED]      = NULL,
> +	},
> +};
> +
>  static ssize_t amd_pstate_show_status(char *buf)
>  {
>  	if (!current_pstate_driver)
> @@ -846,57 +946,22 @@ static ssize_t amd_pstate_show_status(char *buf)
>  	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
>  }
>  
> -static void amd_pstate_driver_cleanup(void)
> -{
> -	current_pstate_driver = NULL;
> -}
> -
>  static int amd_pstate_update_status(const char *buf, size_t size)
>  {
> -	int ret;
>  	int mode_idx;
>  
> -	if (size > 7 || size < 6)
> +	if (size > strlen("passive") || size < strlen("active"))
>  		return -EINVAL;
> -	mode_idx = get_mode_idx_from_str(buf, size);
>  
> -	switch(mode_idx) {
> -	case AMD_PSTATE_DISABLE:
> -		if (!current_pstate_driver)
> -			return -EINVAL;
> -		if (cppc_state == AMD_PSTATE_ACTIVE)
> -			return -EBUSY;
> -		ret = cpufreq_unregister_driver(current_pstate_driver);
> -		amd_pstate_driver_cleanup();
> -		break;
> -	case AMD_PSTATE_PASSIVE:
> -		if (current_pstate_driver) {
> -			if (current_pstate_driver == &amd_pstate_driver)
> -				return 0;
> -			cpufreq_unregister_driver(current_pstate_driver);
> -			cppc_state = AMD_PSTATE_PASSIVE;
> -			current_pstate_driver = &amd_pstate_driver;
> -		}
> +	mode_idx = get_mode_idx_from_str(buf, size);
>  
> -		ret = cpufreq_register_driver(current_pstate_driver);
> -		break;
> -	case AMD_PSTATE_ACTIVE:
> -		if (current_pstate_driver) {
> -			if (current_pstate_driver == &amd_pstate_epp_driver)
> -				return 0;
> -			cpufreq_unregister_driver(current_pstate_driver);
> -			current_pstate_driver = &amd_pstate_epp_driver;
> -			cppc_state = AMD_PSTATE_ACTIVE;
> -		}
> +	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
> +		return -EINVAL;
>  
> -		ret = cpufreq_register_driver(current_pstate_driver);
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		break;
> -	}
> +	if (mode_state_machine[cppc_state][mode_idx])
> +		return mode_state_machine[cppc_state][mode_idx](mode_idx);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static ssize_t show_status(struct kobject *kobj,
> -- 
> 2.34.1
> 
