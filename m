Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525A6427CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiLELt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLELt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:49:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9400A13F63;
        Mon,  5 Dec 2022 03:49:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJZhciA6l5dki1UtRxxtkKPrdhQskWcTicaCfyLVbx2ab8BkYVTb+Nk+LVMC6qbdOe9oeeiQmwmV5yLZNAWhg8ux2dSJnV2f+S/dpbqdmp8Tb15tEey+I/SfvlbO4OG4o+0a0p9VShFJuO6pRa4cz6qquyLVqtD7rZHL7zEJY3VAk8yGpQqMmk0/JYf30Ki1916GYFbBiC7ImsiwZOuk0tf7pt3/oUmeD5+fdLxB9XNX2Cf5k9L6E+cUi0OppZgTlHnNSWqUqxthlTuOlpQ6lwA2jZWhHICADB27Tr2Gir/IKFpxx6+Xiv99TIPJZ5fHfWb+llQ5O26LHJGdxd+SEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z8F3ZAGmv6beMVb6/rq6zXbJN+JaScJ+hHjuJgzFZg=;
 b=jiuECagU0H8tYvH2/pUhCnANW0Jx+ss5wzdq4NNNwofmYJbQgaO+zNoYinXk3M5dN8VrimozA5ZHPCnPNOJlxRe3UeU3p8HAeXM2y6bNnD28Fx9P5eX6uXClEl/G5U50CylMVuvFu9KNkZKUDC4t1s34v0dkJg9UN9QHBiI1Jmpw28PdLhjCqw2XXKlVEfnJqN2VnTRNwVYcYTBad0noUacYAGDo4i9YpeeAwO3wFNLRPX/RzCQw0mz/H21Qhj6ikZdRi7oKE+uUaHVl6ujSZbwv3hzV22UW1fp4c51t8xwl4KffCsXHEm8rxtUTHZg0shEXouzDDQXmyOQh79SMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z8F3ZAGmv6beMVb6/rq6zXbJN+JaScJ+hHjuJgzFZg=;
 b=WZOk9311As5KYvw4kvWvdgoLPkbR/0WIbPrWTLwKqj5+9HJC7DLOc68T0tLIQcIJ36DATBcffxr0yflnHWgM+i+RVYhUOAQbqWBMYjhhGMQKHgAncbmPkImGAHbCMRTG/lC5hlQBiGFTq45P6AO0eangFa09+HgCtfrOvzrVoUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA1PR12MB7103.namprd12.prod.outlook.com (2603:10b6:806:2b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 11:49:22 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 5 Dec 2022
 11:49:22 +0000
Date:   Mon, 5 Dec 2022 19:48:59 +0800
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
Subject: Re: [PATCH v6 03/11] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Message-ID: <Y43aq2gMKnFRIhxh@amd.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-4-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202074719.623673-4-perry.yuan@amd.com>
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SA1PR12MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bc2913-1f37-4bf0-81b9-08dad6b6c052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygyPsSleNTW3b1tCRZ9KpdstTHTOSh/vO5Sd/g67mQhHUbCLEKjeOxNZyre1xB08llzk9KIxuXm/jYHTkbOlUudCv648xebfuZiK1OnF97h/MZpwHkwvAQFfJxQz4Ybf7BGXRw4GK5SY/9/XPs70GljSfhzvoDZpirNVDWYLDkqweGAJ68K8EAr+094F3/RkqKrR5+rsCeUSHyoG0dXHjNSn2B3YbzZApQCfj2iPvS5xJG7SfvB3o0ktsDN013iFpVDcKrqQdMsVThwBJDKdziViIS1C8FIPZRrGLonx4fg12ssm0nsbZTAfMeKpQWDKMMlL3jjybL7NTj9fkorNdYCMp5LAiuKmYquoZBIHqnGXgVBnfJTA0ZH44HRy4HDJhREiKwtsv1tjLHj96/iSgcJDgJkzKzHRqI6LOc2urxf3lmwiZWIuJJLiZU1GgyxCc7haFN7qrpZYuAN3G3CJ7dLmfjg4kVJm3nb0BbEFjB4tno+dy/NWgW0oPGizZLTKVbecCoHjvnB3KUz+wZHCIekrNW+1uq0Caf4tZYRH2SzweS5TLyoaCjT2RdT3BGZXR+oTNrrOq9FABWxDBhFnGNWdBqI5JBBzD7/e9kfzoYSt2l8skslUhrvAokFjuuorPj1zhJHUcwCyhYO4MZKe5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(6512007)(26005)(6486002)(6636002)(6666004)(478600001)(316002)(6506007)(66556008)(66946007)(54906003)(37006003)(2616005)(66476007)(4326008)(8676002)(6862004)(83380400001)(186003)(2906002)(41300700001)(38100700002)(36756003)(5660300002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8rwafKwzQ4LlaF9UgmyypNOPuanSOF9IGjur3y1f5mg84uAFqpsiYmwxaXq?=
 =?us-ascii?Q?iHn8H9s6fx0hIDuK3ZkEiZO/OJIaHVXqlNM7VB9mWA2CeHTeaizFCD3T2Ni+?=
 =?us-ascii?Q?TvDs1ZDXznDFyjqcXFLIomoUrpAEasGBTId1y/5EThEvghfiJ8ShInVmTbuZ?=
 =?us-ascii?Q?N/wUBQ7HXEp+gQOvByfe9Tlw0XmLFS2VwrsrXKtXCkIWjD7iJcM7qtQnZ/ch?=
 =?us-ascii?Q?CeQup9II8OcOxeuUu01Gtpzbf3jFSAVDDHcXQFfUp8q8lxIUH6pla21ss3TE?=
 =?us-ascii?Q?MIJuAzl+wI7/vaQmstNw7iQcUuoru/VX2pqz5B01tQMf1dKfbSHMo7bJhMHH?=
 =?us-ascii?Q?PjffeJCmz7pPcfBUYGEJRamCzOyhzjGRE3EfKP4N8Pap899/3C7dRE2MHpJB?=
 =?us-ascii?Q?0SsAwTN88JJKlfLNQ3LR23mRHqkOwQ/EOUUWG3IgbxRbOo1O0xJHoV4zgKri?=
 =?us-ascii?Q?OgevYUlPjx0DKgSGKp8hWhFxLHUKnr7c1iJJAyWCQr8MUrBzc4V/mpM0cZgy?=
 =?us-ascii?Q?xt9bzj1Hl6Ph/J/0736mxLbMDLQ0lfsnL5YakVgPs/YU7WCtyW1p/EQZoGB6?=
 =?us-ascii?Q?k0+9WZNvz8wKuIgVzwqFCh9VamHNRzZnp+A9ZOILcWNNK9hMwyAS2qQRvyeK?=
 =?us-ascii?Q?2vPwo5Hzvz7z1zTJlFuhbV+XiyjUkE0VA3iSCBUb72tQiWjE7L5TYLftPTeq?=
 =?us-ascii?Q?Lq4EhdSDYtdsTGa5DvNx7T3QyWNxvXg1EDZj8afZ5WtF1epp4ywzDOraaT+R?=
 =?us-ascii?Q?TieygGGclyf4Bzfq+Rp/Kgscl93Q2YYib+UEB5bTudEMw8u2AUJxdUkXrDFB?=
 =?us-ascii?Q?+VvMJ6QanSHRldnRIIgF9/3SPyvAsAV+B12KuWYEO4UII2eG6+9/0+9XWe6o?=
 =?us-ascii?Q?0JW9pNW9DZDz3ufKUDQONpi2Rb4uzClUfawRcOoklo5DrmT4IzlAeZqb48v6?=
 =?us-ascii?Q?lMcg81XcanbwW2QLwB95ix3R4rq1MeTobjAROw+0k+JWYNXGbEjldsi8T2ql?=
 =?us-ascii?Q?++NbXsL02kBldM+DKLWvNnGSuO/5l82C8nYfFYdRlNnVvw84YqKz6PrHfzYy?=
 =?us-ascii?Q?r9xLICEBbu8sG8LCNBlda90tBY0npA376BJmDBgndI9zKkBbCLL7tSzbK3a1?=
 =?us-ascii?Q?gpiDOI6jivtM42D3mJUwhgzLkn5cIow+4AYBNBAtSQsMG4Z0ulzLfjGxcd+y?=
 =?us-ascii?Q?X3EVINY4D57YbRg9c5F5o6hgwlwBEYSIF5M1ZifhPSm8Q8uDm29sVVE1OoAm?=
 =?us-ascii?Q?S02TWi34a3GKfEv53plufyV5LLbUCEen03zP13LH6Up+hoigbFcM31qmhCvs?=
 =?us-ascii?Q?uR3VvfawyIEyqzti3VNeIn9xmFFBlnyGLcANq4oiADgRIPi7IQvNhPX4RZYS?=
 =?us-ascii?Q?KVHrQK+ioADkXg6cdPZ3Foe5oQe8yZ5E3uMwvUCoLpC/QiW/xSEY5xt1suIf?=
 =?us-ascii?Q?rXKBxthjLMHWIFpqCDRQcS6xVcEivkw47AUG83u4XbHIR2cBdqMouMTZEA/s?=
 =?us-ascii?Q?Bja8D+SezMdJZf7BLtrnqalpoZ1kBEUvtR+IMDW4g7LZFpblxMgWvb3WGEG+?=
 =?us-ascii?Q?ISy6YwUxtAynqeH9yuTMMyOPbLkXGzjtEeQ8fIXh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bc2913-1f37-4bf0-81b9-08dad6b6c052
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 11:49:22.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW1pbxr32jj5ljrEMdjskzjaVU43z5Gv/AP1AG0LcPZBemiWjCHX4fnulYJfVsFo/7txFmoHu8eXSnfsrCefaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 03:47:11PM +0800, Yuan, Perry wrote:
> make the energy preference performance strings and profiles using one
> common header for intel_pstate driver, then the amd_pstate epp driver can
> use the common header as well. This will simpify the intel_pstate and
> amd_pstate driver.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h |  4 ---
>  drivers/cpufreq/intel_pstate.c   | 37 +--------------------
>  include/linux/cpufreq_common.h   | 56 ++++++++++++++++++++++++++++++++

I don't find any specific reason why you have to use another common
cpufreq_common header instead of include/linux/cpufreq.h.

Thanks,
Ray

>  3 files changed, 57 insertions(+), 40 deletions(-)
>  create mode 100644 include/linux/cpufreq_common.h
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 4a2af82553e4..3983378cff5b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -472,10 +472,6 @@
>  #define HWP_MAX_PERF(x) 		((x & 0xff) << 8)
>  #define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
>  #define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long) x & 0xff) << 24)
> -#define HWP_EPP_PERFORMANCE		0x00
> -#define HWP_EPP_BALANCE_PERFORMANCE	0x80
> -#define HWP_EPP_BALANCE_POWERSAVE	0xC0
> -#define HWP_EPP_POWERSAVE		0xFF
>  #define HWP_ACTIVITY_WINDOW(x)		((unsigned long long)(x & 0xff3) << 32)
>  #define HWP_PACKAGE_CONTROL(x)		((unsigned long long)(x & 0x1) << 42)
>  
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ad9be31753b6..65036ca21719 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -25,6 +25,7 @@
>  #include <linux/acpi.h>
>  #include <linux/vmalloc.h>
>  #include <linux/pm_qos.h>
> +#include <linux/cpufreq_common.h>
>  #include <trace/events/power.h>
>  
>  #include <asm/cpu.h>
> @@ -628,42 +629,6 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
>  	return 0;
>  }
>  
> -/*
> - * EPP/EPB display strings corresponding to EPP index in the
> - * energy_perf_strings[]
> - *	index		String
> - *-------------------------------------
> - *	0		default
> - *	1		performance
> - *	2		balance_performance
> - *	3		balance_power
> - *	4		power
> - */
> -
> -enum energy_perf_value_index {
> -	EPP_INDEX_DEFAULT = 0,
> -	EPP_INDEX_PERFORMANCE,
> -	EPP_INDEX_BALANCE_PERFORMANCE,
> -	EPP_INDEX_BALANCE_POWERSAVE,
> -	EPP_INDEX_POWERSAVE,
> -};
> -
> -static const char * const energy_perf_strings[] = {
> -	[EPP_INDEX_DEFAULT] = "default",
> -	[EPP_INDEX_PERFORMANCE] = "performance",
> -	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> -	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
> -	[EPP_INDEX_POWERSAVE] = "power",
> -	NULL
> -};
> -static unsigned int epp_values[] = {
> -	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
> -	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
> -	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
> -	[EPP_INDEX_BALANCE_POWERSAVE] = HWP_EPP_BALANCE_POWERSAVE,
> -	[EPP_INDEX_POWERSAVE] = HWP_EPP_POWERSAVE,
> -};
> -
>  static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw_epp)
>  {
>  	s16 epp;
> diff --git a/include/linux/cpufreq_common.h b/include/linux/cpufreq_common.h
> new file mode 100644
> index 000000000000..2d14b0b0f55c
> --- /dev/null
> +++ b/include/linux/cpufreq_common.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * linux/include/linux/cpufreq_common.h
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> + *
> + * Author: Perry Yuan <Perry.Yuan@amd.com>
> + */
> +
> +#ifndef _LINUX_CPUFREQ_COMMON_H
> +#define _LINUX_CPUFREQ_COMMON_H
> +
> +#include <asm/msr.h>
> +/*
> + * EPP/EPB display strings corresponding to EPP index in the
> + * energy_perf_strings[]
> + *	index		String
> + *-------------------------------------
> + *	0		default
> + *	1		performance
> + *	2		balance_performance
> + *	3		balance_power
> + *	4		power
> + */
> +
> +#define HWP_EPP_PERFORMANCE		0x00
> +#define HWP_EPP_BALANCE_PERFORMANCE	0x80
> +#define HWP_EPP_BALANCE_POWERSAVE	0xC0
> +#define HWP_EPP_POWERSAVE		0xFF
> +
> +enum energy_perf_value_index {
> +	EPP_INDEX_DEFAULT = 0,
> +	EPP_INDEX_PERFORMANCE,
> +	EPP_INDEX_BALANCE_PERFORMANCE,
> +	EPP_INDEX_BALANCE_POWERSAVE,
> +	EPP_INDEX_POWERSAVE,
> +};
> +
> +static const char * const energy_perf_strings[] = {
> +	[EPP_INDEX_DEFAULT] = "default",
> +	[EPP_INDEX_PERFORMANCE] = "performance",
> +	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> +	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
> +	[EPP_INDEX_POWERSAVE] = "power",
> +	NULL
> +};
> +
> +static unsigned int epp_values[] = {
> +	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
> +	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
> +	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
> +	[EPP_INDEX_BALANCE_POWERSAVE] = HWP_EPP_BALANCE_POWERSAVE,
> +	[EPP_INDEX_POWERSAVE] = HWP_EPP_POWERSAVE,
> +};
> +
> +#endif /* _LINUX_CPUFREQ_COMMON_H */
> \ No newline at end of file
> -- 
> 2.34.1
> 
