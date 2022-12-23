Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF229654BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiLWEYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWEYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:24:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A471E201B9;
        Thu, 22 Dec 2022 20:24:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu3EWciAJOi0qvSm7WDh4FOz05E3jsALInKk1jBsmY/6Vd3vHH3VQxmKcsRXxLmZiVRaCyIAFaRGIRBJZ5MLko5p88jLu+NQjr1TW1jbh57ua9TN7EKE7i0Ws3TCPGricRuDkxrBrXTNht//RUxppUR9ty5YFMS+bqzQpRzn4px32Fnxf6BrTQvXBPlM9xQoKAjFLtFrwR3n+zumbcPfhJgJMlBxoit2UTMWkKTRl9Ujn/q2GICEDzlKBNNnh6XjBZ3uf4iOG95rwpnZRkaFtQrHf/1hcGjzTZN583ME4huX5Vh/eA3pIJBFL7044unasRSqIPRw7Oa7aT1WK3aTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRuSkjxnNffJqQ7vmRPRIyiBL1lN1XsGKlORC8cdOYA=;
 b=IfwqAAKzbI6tbTostT8s71xTsCMgHn0TmjA7dK5757s3yidtWIhfGHtVKErjOz5SRBxiQhVVCeQCKxsj5dYGdfz+Njb/RkOo0LyBgXK4SpLjTq3qzxIz/AIPqK+UzmMF9JUwQkjI/PLPPhrklJDgwMplai42MTvB+snfWXBp72ZkdLWyNz8y6Q3SW7phSrB+H/P8PyhCe7L+0TuStWEsco2iX0Hhx11RgpvcOqgmMMlwDSouVdTsCnAp/v9ohT3dBECG14XNTyjtq3V0tpjGCWwbdUBRa8HkV4+e3e3fQUmBo4Q3KMFH72iWHdZJFpdxN8c0YVY3XH49rY3NuIpGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRuSkjxnNffJqQ7vmRPRIyiBL1lN1XsGKlORC8cdOYA=;
 b=bMFzU9PDyNXL6Y2mEvhJPu+d1yqHDR25IBO/ll1+Beq0tYa3ruTXeGiiY/YAl94fgg2R2j6rqjeATggpIqyn6pYNSKNb7Zi+M9fQ1qM/W/YAQ/M2jtItU/ZMqibwtzTG/xwagXrykVdl2MRQik62DF+LUzeFYmzwKR+WBzW6pgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Fri, 23 Dec 2022 04:24:10 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 04:24:09 +0000
Date:   Fri, 23 Dec 2022 12:23:48 +0800
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
Subject: Re: [PATCH v8 05/13] cpufreq: amd-pstate: optimize driver working
 mode selection in amd_pstate_param()
Message-ID: <Y6UtVGvVWJgMU5Db@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-6-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219064042.661122-6-perry.yuan@amd.com>
X-ClientProxiedBy: TYCPR01CA0020.jpnprd01.prod.outlook.com (2603:1096:405::32)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SA0PR12MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: d84cf289-7839-45f3-7ce7-08dae49d89a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/QZRX+qe6tYW0k64xoH/7v+Owph/fSI75YOauZRXqzn2BZThndpkTc6KSzsN0TkebzcR58EZg9OOA1ZeuYXlPzZoEoFVf63ddk8il08wohZVzoiemjhRRz1mlmuN+I3ufQntNa94A5rbeb58uEYdrUuKMIMjdNDTiPJ/G4yX/8SzuZt1E96t3Q/0XNhRyxJ4Zt7ggdBvdAMYmuAfIATLuEjqgLaNRxVcc0a+T24bGicFa0NPX49Xe0fXd9BIa70XVK1vWLEUfGZ5e0JFUqOTmN9ceubwR0/jG7VkrJcrMT7Lc/OlmiKGxJh2qfxSbxN3bHX5db11pgug+MG32Bv+UEBUfuLI+yt5eRVor0szlrDvipG9Q5f9/iCr22GSwKapNU4NBUwpRUdYHjzz7DCzIPLe7zzx21Y4TZ6d5ENnz3X1S+EYonS0M/2/HNiaLqpJKiuTqQtzqeMdmXZYRBBuXJrfFK4PuzQe8hWcB3mohtNxLS6WcOB7CY5nM1f2OodKh6ZjTuFPINlUIFZ8ATrHAZtxIEhQXpevz2y+I/ebmJk2fmYCyHH/etMXFpGsSy5zwWOeUAWkuJhM3MRjxNN4+pVqZ/ZR0W/v8H4mg8Exqjomtusd4oKNyjD+XuVlnANone2dN0b4XwqX9UEpm3ajIaLhWxxSS3D1OHHJ5jSw1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(2616005)(66556008)(66946007)(38100700002)(66476007)(6666004)(41300700001)(8936002)(4326008)(2906002)(8676002)(6862004)(54906003)(5660300002)(86362001)(37006003)(478600001)(6636002)(316002)(6486002)(36756003)(83380400001)(966005)(6506007)(6512007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IPPGJTXb9qYach2fwo73tYByQzvImceU3kYwMHuxCzMwxWs9otr0+mLF0R4?=
 =?us-ascii?Q?XJZkOJlFmyY5acHISUtxlscYO0Z61sd2z9byRrAppF+8W4bfwU8PoMueqAQ/?=
 =?us-ascii?Q?mpKxiAgji3OGE7ix4vZsaLbAS4xQ2E43+o7jnwzdjcDUR4smuGwOyKH7BqxM?=
 =?us-ascii?Q?DHyGVzyDWjW89FyRsXr1dk+OjERPEkP1V32soanuB2cZWlr3pEtIXBS0rihP?=
 =?us-ascii?Q?J+N4oJi5+uqJ2BqJuvFC/UDh9pNTlPYTjEG94nVcW3dksnOr+Wn6Z5my/A3e?=
 =?us-ascii?Q?qw7KyZBCVH6n4IqozgsWB06dMIqmM2G3ENACgyT6BoskEqEEUarsE3sxXDuI?=
 =?us-ascii?Q?q5GSR1ZP0C3kI3Cn6Yrb7rWJUH6xhAWEEizL8OUw/Xbg4lgvniUVk5yaFIyH?=
 =?us-ascii?Q?zWk9XTkvSchOtJgaz7fm0M/u1ZMTvKITsCt9+3jlIDf1lQkXkwUGa4czckkn?=
 =?us-ascii?Q?dXrIIJe+SScDuyN2CL5JeSyGOw0/E8qMnmfIfqAc24VIlj172hGs7vOxucSd?=
 =?us-ascii?Q?EyY9MOJvuEWHq90tRGU7m42KPEqjIQcABqUzLcFDPnNQcV1EZeOJ27RWdK0p?=
 =?us-ascii?Q?VF5Yncc5D+9st6RHnlxj6lsCSV7KJib5gmoqDPT/nPNgVxrdYJ3QtHf63RCD?=
 =?us-ascii?Q?EAAMWDJLOZJPHPDjypXW3KWRgoRTZSGCY8yBvUpVEm+JB5PA3TgHzo3DgV4A?=
 =?us-ascii?Q?K9ZHR8XKcG55KSa06h3n6hzxBc69ydNdtt2FFNJCdiEDUNCfKFuiVB5DxK8/?=
 =?us-ascii?Q?udGJbAzcWNEMBHHrBmKx8bz2Qsulj/s0O1D3KhI1xRCOJWeR9agbSZhSV13q?=
 =?us-ascii?Q?ualLvRlnlwGP+MP/xzx1koXGLO59QVzNlE6CLGDkvx0EGz2jt9zQGyPEzWrN?=
 =?us-ascii?Q?WFTE+VmOJXPtOGamwKkOsCJ8JtsKLy683SbkENJGMJaEYv9CMb72uA51o6ST?=
 =?us-ascii?Q?lPBM+QBuy7fZiG1L+zRtdVE0ejEbS1dFwXINJLwPChvMMCX2oPo7AtNIKNo9?=
 =?us-ascii?Q?KG9NejNvLX+kZahI1NwJ352mtf78vYoHuNTjOjf289V88HAEGZVu9uCSgf1k?=
 =?us-ascii?Q?nxMJxEFTVSTGBAd7aoWP4BIagpJ6BN3cbMIATbfQyaAlesSQtVeLZGB+Pqjg?=
 =?us-ascii?Q?YtNxHPtR1eruBq6BzRezBVZ20qrPYxKWImMF1sStjhrSHmmp44hxID4OBMeg?=
 =?us-ascii?Q?ZOOsPeJcmjGq3H2CHxPd7LRCK/wJnKmblePsIpUI0bBVqwH76TBdPY/kZ30V?=
 =?us-ascii?Q?s0/pbT9Gl4YuAdS5eFHy1B5ksgX/rppCZszPjrXp+fnhKw4P0mYh6Aoe289P?=
 =?us-ascii?Q?PKJesQVnIVQ2zoI3duOTjCmNLbFKmRom6+l38IhE66YsFUFzQMkY35/JhS4P?=
 =?us-ascii?Q?W3GAHOllnvGAqBN73dWRRjREL0y9/DwKaLokSIQ+TZmtMG0uzfBRlHVIJs/Q?=
 =?us-ascii?Q?XaeTrt2dSMtBqVllGFvvwVCswYUcmoZR8xPb0hE6Hrlk45KB60mwUfpFHRqx?=
 =?us-ascii?Q?CnkxI7FhmWaswPCuXgzkZTpb+y7wMrA+sI61OJS4UW9NrNp5lMk4388AisE8?=
 =?us-ascii?Q?SbquLdsAaqbIvPHR7Y4iQl9FqCWkVNE6BXAkpktS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84cf289-7839-45f3-7ce7-08dae49d89a7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 04:24:09.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtJ8qnucPKZMJNeiIp5zSTxd6QUqj1LOWfO3HfD+GI/2bHizuIHA8cA2c0GtPL2S8bIUOLjghWV87PyEHn+/KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:40:34PM +0800, Yuan, Perry wrote:
> There are some other amd pstate driver working mode to be supported.
> Here we use cppc_state var to indicate which mode is enabled.
> This change will help to simplify the the amd_pstate_param() to choose
> which mode used for the following driver registeration.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

The most of codes for this patch should be inherited by below patch:

https://lore.kernel.org/lkml/20221207154648.233759-2-wyes.karny@amd.com/

So I believe Wyes should be the author of this patch, please use git commit
--amend --author="Wyes Karny <wyes.karny@amd.com>" to update.

Thanks,
Ray

> ---
>  drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++++++++++++++--------
>  include/linux/amd-pstate.h   | 29 +++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c17bd845f5fc..861a905f9324 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -60,7 +60,18 @@
>   * module parameter to be able to enable it manually for debugging.
>   */
>  static struct cpufreq_driver amd_pstate_driver;
> -static int cppc_load __initdata;
> +static int cppc_state = AMD_PSTATE_DISABLE;
> +
> +static inline int get_mode_idx_from_str(const char *str, size_t size)
> +{
> +	int i;
> +
> +	for (i=0; i < AMD_PSTATE_MAX; i++) {
> +		if (!strncmp(str, amd_pstate_mode_string[i], size))
> +			return i;
> +	}
> +	return -EINVAL;
> +}
>  
>  static inline int pstate_enable(bool enable)
>  {
> @@ -628,7 +639,7 @@ static int __init amd_pstate_init(void)
>  	 * enable the amd_pstate passive mode driver explicitly
>  	 * with amd_pstate=passive in kernel command line
>  	 */
> -	if (!cppc_load) {
> +	if (cppc_state == AMD_PSTATE_DISABLE) {
>  		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
>  		return -ENODEV;
>  	}
> @@ -671,16 +682,24 @@ device_initcall(amd_pstate_init);
>  
>  static int __init amd_pstate_param(char *str)
>  {
> +	size_t size;
> +	int mode_idx;
> +
>  	if (!str)
>  		return -EINVAL;
>  
> -	if (!strcmp(str, "disable")) {
> -		cppc_load = 0;
> -		pr_info("driver is explicitly disabled\n");
> -	} else if (!strcmp(str, "passive"))
> -		cppc_load = 1;
> +	size = strlen(str);
> +	mode_idx = get_mode_idx_from_str(str, size);
>  
> -	return 0;
> +	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
> +		cppc_state = mode_idx;
> +		if (cppc_state == AMD_PSTATE_DISABLE)
> +			pr_info("driver is explicitly disabled\n");
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>  }
>  early_param("amd_pstate", amd_pstate_param);
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 1c4b8659f171..922d05a13902 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -74,4 +74,33 @@ struct amd_cpudata {
>  	bool	boost_supported;
>  };
>  
> +/**
> + * enum amd_pstate_mode - driver working mode of amd pstate
> + */
> +
> +enum amd_pstate_mode {
> +	/** @AMD_PSTATE_DISABLE: Driver mode is disabled */
> +	AMD_PSTATE_DISABLE = 0,
> +
> +	/** @AMD_PSTATE_PASSIVE: Drier mode is passive mode */
> +	AMD_PSTATE_PASSIVE = 1,
> +
> +	/** @AMD_PSTATE_ACTIVE: Driver mode is active mode */
> +	AMD_PSTATE_ACTIVE = 2,
> +
> +	/** @AMD_PSTATE_GUIDE: Driver mode is guided mode */
> +	AMD_PSTATE_GUIDE = 3,
> +
> +	/** @AMD_PSTATE_MAX */
> +	AMD_PSTATE_MAX = 4,
> +};
> +
> +static const char * const amd_pstate_mode_string[] = {
> +	[AMD_PSTATE_DISABLE]     = "disable",
> +	[AMD_PSTATE_PASSIVE]     = "passive",
> +	[AMD_PSTATE_ACTIVE]      = "active",
> +	[AMD_PSTATE_GUIDE]      = "guide",
> +	NULL,
> +};
> +
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 
