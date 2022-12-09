Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF87647EE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiLIICD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiLIIBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:01:54 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47E396CE;
        Fri,  9 Dec 2022 00:01:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLEthorPtw5z5lzAaXEfw5GvQur1MoRboA8dKijIf92GxYctA3O/yHmQu1Iac8J7mlAtTtUU/hF0fgyJU01GYEDPl2D2ALh4jV8XlcPEw2TfkicxhPH+LHOyzhOCfEeYzUC85XZE8m9crSbBiswkfjH4+5ekdRJH1jMZp/CzE55DmmAkt+x30OyZjc2qvX4DYPofuMQtQXNTwW7GdG23pUBHrHaMtB2RlBIiDbtR/qN28tqBCnlTt01uYFXXpqxmV4Of5m5zfxYLQdiToGDyE3syhnW2PUR7kOfdi+R1DqiCcS+XXfZlBEYRu2H2zXhZwebU5w9MHBzFkeyJmkplxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy8ALMGW+exuHtDKrmWrAtplgJRrLe6Yz77LyWq4LX0=;
 b=bGIoWiqxGfZxMd13LLguLA+q0IJZGGklMRUiG/QnDg0vtmkZL0FAD4wGnzzJyjuyi9SfjwD43VSx19BMHhOqBut1BxNtS/1jtYhdWyBnMgKt4JNPcEN4To1liFKRIppSOd/Rmwjhaxj9Y2qXHzLij7O0HJZ+xk0HHZOe4UppsHpnFT1LZ3az74vXOKI6esdOND94tu0aOoborvyoStJ/8gmrUpJC/3Gru6iDlh3qS0D2ejZCmnXGdoQ/ebgU+rMwuf9KWTl3g+LMAeMJJxRXQ0z5DGHoKI1WMkYSumhLIvJXZG13ykCRYOuhY8V2UgemX9kj5KQewMjCpZWvG92kxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy8ALMGW+exuHtDKrmWrAtplgJRrLe6Yz77LyWq4LX0=;
 b=K3vYajPSB/90yJn7uwYqPrYckBkkSpu60Rvw4KyUnWunSMbJDb8MFv21aEswkrpE9ca7oJwgMQ/CTSKR6CkdYBLibtErMrRV9Du1NKmVXlUHiA9sasQPxC45Ig/CyRkN5OOOZN4aDf/6/vv73ojJE1Cs+ztHg9Tor82pLKI9W8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 08:01:50 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 9 Dec 2022
 08:01:50 +0000
Date:   Fri, 9 Dec 2022 16:01:25 +0800
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
Subject: Re: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Message-ID: <Y5LrVdS9oFKIvC70@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-4-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111852.386731-4-perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: efe5ffb3-5692-453c-1652-08dad9bba00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opDNI+fBTNMIcVWqzEt2EtFoCgWV9BRV0VFHzHJMSMg1yHLA2RegRgf6wFgNOUgUhZhot8POccLI36G5GxUodbXg1Oq2+Mjdqq6CjhIe36sM6n0bs+y7K9/d+KoclLZO40unZJAC79ONyzKUMhocSSJVICiM2T+//n4Z3rjN86QomsbJ4mjOyzKwF/OF6g/m20w5q3CZ4WDZ9aXA32QSOAgZ1zNZX1uZBCZx0mknHMQ1wYkXUwSnoiYxIyIP46kUzBMS2pSOXnvY33k8b4rMYRRd2q4KxSp77PgLAgCmNqglOSOBUb/W6pMg2WPD+vo8RdGjZLtgzjgkpQeNo8hQJ9Ik5Dub+oTsJ5Mn00DZl8BLhTAoUHn+wJ3micTC2wetVgKBHqCT3Bp61/kJyTxsw4P/CRo5GFxk4hTGWo+4kOYRKEWq+OVLdocXyq2mx2DFhfJDnIUxlOprVdRgTgKbRNI5s0BiJhgwjzGo44SYuQRvPjqGOmROkmmPYx6CnGlQnrxxxIRhkVH0o4o8yUGEwcwX1T/ADJ11aaTav1/mWWt6nqS87BQnJFOBOuVXhRYFRw+jpYmq2LUX/K2xPNus9+ztJYUJMNc53ys45G6A97zgxSshSarLysPR8eIhWtysVPcsaEG8pszvPdvPQL3s4eTkGL9d5SnXTHMQ0whS3aY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(41300700001)(66476007)(8676002)(36756003)(66556008)(66946007)(4326008)(2906002)(5660300002)(6862004)(38100700002)(2616005)(83380400001)(6636002)(54906003)(37006003)(316002)(86362001)(6506007)(966005)(186003)(26005)(6512007)(8936002)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0Q3777zv7QAePWbJayPBhUNxoFjAWpB1uqe98O7r6vqRFdTGkBKRbIaLXPi?=
 =?us-ascii?Q?JLsBKnbuyU+PJBBTuqy1WJMhZyRVIOh8dMAJcsJrDVjY3bCIRYFN112yA3v+?=
 =?us-ascii?Q?ELgWywt69eBgml2/6upC0v9Z+hvBpXKTH7aehDiXmsNCoJbg386uJlSqFIGL?=
 =?us-ascii?Q?ShueGzhTzQFipiy93c0m7pTllJ+xkTPswE3xlmOy04TUjXhb7Y/FZ+QQ47Qq?=
 =?us-ascii?Q?EVNVonhT+wpvqcC//JsO43SeMqICChOVfcqFCOX9qosyU20dszbtODVgzOQf?=
 =?us-ascii?Q?jDM5P55Gc+JiaY0CdvAZkxsYYwzBMEpMRcO1vPyGonPpzpfdrUrUxnc7M68R?=
 =?us-ascii?Q?2nCyHCA3+qb/QphkPUFXuclXE3YR39iJbvnONBbb3LUMbohPeEu9KWfAYew+?=
 =?us-ascii?Q?pqLMF1CAfo7sUMUtSjDND5qHhgsgoUShjm/iiovStvWsgrPttluF7X4RI0aX?=
 =?us-ascii?Q?b2U+x+MRHkeKRmlaFUrDZeDi78TF+h/A5J0g3545NNJRG/6JMU5MU85D0NTb?=
 =?us-ascii?Q?Zsz29NAK862nxNZE30P7Ai2dDdC6e9FsT7PnBNj/DwPR11Yu18y13IO25szW?=
 =?us-ascii?Q?dHmwvKzWJuqsnf0e1XJnx2SP4XPFXkg2xmmv4EGM4SCrPzkBrBfgVkl83/RS?=
 =?us-ascii?Q?3V6UqYhGspTPtcRbVIPJ0d5OJV2JhmGeLi8Z4i/O/dPg3lENjnHbBk3UolzO?=
 =?us-ascii?Q?/RtYwY1esOIGK253+68BFBF0/XkGX9PcCbmI5SeDsdc/gTDgN+DbGmk9yWhN?=
 =?us-ascii?Q?tcnArdW+cfT0HE7OY7HHYAtlEqudFkXe7TvMZPY9Qs3NwiqKJTs/tDPKPYpf?=
 =?us-ascii?Q?DTnMdP5oRWzLuFYE75W2vXZxjWiY4ta9/CroQxUSKdG2n59c9FIXy8MaN8Fi?=
 =?us-ascii?Q?2DYXia4lpITgAM6JQvSS86XrQLb3IuqylINV70kyrR6Bt+5PlpcIxcwA28L4?=
 =?us-ascii?Q?d8MI6XI+9F++O2rlxnz2bCdNQetX5wFe2cmFnbVNcKUCxIaQzel+wJnNd316?=
 =?us-ascii?Q?RrBFL+KVEHIMVmBmelPBVjZPu0OQkSDROd0nHO/05bsfgfNspD16BeEhujnf?=
 =?us-ascii?Q?PwTrzvsfmEdgRzuVwJceOv923drsO7+cULSEksuFvkXV2kfaqAT46eFmuqaP?=
 =?us-ascii?Q?dAFBW0tM7ReSMBL+1j7Yi7VAa+dsiZ1xjMS7aUroOF1Bk+bAN5q9ffH8ZbOk?=
 =?us-ascii?Q?r6NCPxZ9j0ftdQO5tXe7n3a/NtfRnINOWcZEcrcLgn5IAEkWx4+WUH8NK6rm?=
 =?us-ascii?Q?bJIAM7YOBjnVjQjyQYf+Y9kHTc7Y0yHKudn5qNbpS0ZFXFWE7vX7dnibRO3t?=
 =?us-ascii?Q?inc/ydnqxcy0VSwPnYCigS8ikwgHNdmgDfLuFehtYdKws43fNkz+q98Exake?=
 =?us-ascii?Q?sgwGHUhIRpPVhdweKfv9+SCDLTsp1m4BphCV6cE14FOHNzLDPYG0y//A65/B?=
 =?us-ascii?Q?+7l9JhEHHzt6FbiaYGynu0pRhMTB2vTchaqezrjRT3NFIQynaUw57DkglVnB?=
 =?us-ascii?Q?JRnezWG1zBlTAXxyG5lO2c35JAtxMZvMR5iVG5Rmgks+AoYuEJDn3+RJNB7R?=
 =?us-ascii?Q?uKydwuO/YxciZavxxDNQFunsz3iTEtWah2rU1Cfj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe5ffb3-5692-453c-1652-08dad9bba00c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 08:01:49.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wbrKo3XCAvm3MYF7ZJPEMSfBsGLpuIBdwsq7Wjd1/p0KY57SRBrM9ZAE6GWnwL0+hC2AuTogkPBplptsKWAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:18:42PM +0800, Yuan, Perry wrote:
> make the energy preference performance strings and profiles using one
> common header for intel_pstate driver, then the amd_pstate epp driver can
> use the common header as well. This will simpify the intel_pstate and
> amd_pstate driver.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Please address the comment in V6:

https://lore.kernel.org/linux-pm/Y43aq2gMKnFRIhxh@amd.com/T/#md503ee2fa32858e6cc9ab4da9ec1b89a6bae6058

Thanks,
Ray

> ---
>  arch/x86/include/asm/msr-index.h |  4 ---
>  drivers/cpufreq/intel_pstate.c   | 37 +---------------------
>  include/linux/cpufreq_common.h   | 53 ++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 40 deletions(-)
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
> index ad9be31753b6..1b842ed874ab 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -26,6 +26,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/pm_qos.h>
>  #include <trace/events/power.h>
> +#include <linux/cpufreq_common.h>
>  
>  #include <asm/cpu.h>
>  #include <asm/div64.h>
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
> index 000000000000..c1224e3bc68b
> --- /dev/null
> +++ b/include/linux/cpufreq_common.h
> @@ -0,0 +1,53 @@
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
> +#endif /* _LINUX_CPUFREQ_COMMON_H */
> -- 
> 2.34.1
> 
