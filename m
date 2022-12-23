Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE9654CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiLWHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLWHQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:16:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B330557;
        Thu, 22 Dec 2022 23:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3gae6FSYjwuu8eprZg7zC2hTcYWqY2smIq3X/BYOL6pdnbcL0X3OGOer+iCuh7+/ujZHlpgwBtISakCCJcRApvc/TW3Ho2oZBI1MZUUeW7eedUATkwAbyGz4gttO1aYTcgBqzlKM74Y3gTgPpMg2Wfviqin9KOBfOXhJnMbDbQD6y+vn5qTluhYG3n2WQsQhg3dV4UUN92po6vHviCrR9W93LAb3vF0G4CZ15gqmDiTUsPACQubHd8ooUAZ84D1FkrpvbldH5/q4c61Hu6JPsHf+f1aILTBxnU3tztjzlajNVo5z33kgO0zgNc7rXfAcSH3jLkAFPYWsDA8Temk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvBzf0GcDoiYFmLmY4vpe1h2gGpwcWLgXlex/5eWWm0=;
 b=DyfNntj+ypDTZ8/v+FEGkkpZzn69cVoOoPOKI1X17QVVBqWDG2XjIQtecYCvDmlMBz0H6WPjiWGJ5pL2AGDE4nPzco+zPMUlFHsia5VIDaoM2Skx8dUQTxE8ICKVDLTRz+M1HZ4Kn5z852qKUL8/H3XyIunSa5ZLrKMcyOd2/L1wisq7UvEMab4rf2bqdPmYWrg0Mg5R7nIC/oG+Q1gNbxQp/mE+OFVxnGTv5LJppiwMb6BrDu6PpG8Toidlg94nHI6sM8TGM0risPeKqHcjbq2pNwG8UUDdC1N671/9AOUAR1S7ETM473f0+T+j4ZOYl6N7VaHeY4vAv63lVKQxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvBzf0GcDoiYFmLmY4vpe1h2gGpwcWLgXlex/5eWWm0=;
 b=Q/kSRyBnJqcbSmZwkIhkLPbGUE4wLtRL3z7Epuelp1yWHMS/X3NKesyJ+uSJJAjE8GahnAosm+XX2l/qJVHqdMmIPyTdR61D+K3b4Z2lhRZ+1Vc1YrAs/XrKFYbUmMSRxRe7hM/j64RP7HAQNbCrHnZYohmo6PUkTPoPDC+CxtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 07:16:25 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 07:16:25 +0000
Date:   Fri, 23 Dec 2022 15:15:59 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Liang, Richard qi" <Richardqi.Liang@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 05/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Message-ID: <Y6VVr+WYqwWb6XV0@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-6-perry.yuan@amd.com>
 <Y5bqWMJPqke5gdL1@amd.com>
 <DM4PR12MB527835D9808FEE13284F36F79CE59@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB527835D9808FEE13284F36F79CE59@DM4PR12MB5278.namprd12.prod.outlook.com>
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9545a5-53a1-4754-724f-08dae4b599c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgXXnTgF9Y3eTwRJWelQEEzakmPS3Y1mwHYJDFBuwTfyg52FkqiBPQy3Q/ylnFkMXDDLZKRr8YrSllhfSKXK+IVD8TGTLqNpGaXCNdjxRTv2Suo1XBgd/mLevMupO9TCej449TgHv7RvB3fcFXq2dhcmJ+7+QKwcKoiFesKnKIQIfzbS1bY3S23OxpBkUKW9u6dFfrXbaM5Ot2WudcyHWWCidk1N82PzycB1xSEMGdDxWCmJqyVMIwU0dAs3CDS3YDF+cz9/dJ3PSIMf3QRKALa1WG+LJQomyxjzIhcBj4PtktWnsXziPJkBdKiuXx1L5VkkKFjHx0b9/U0plJzvfPwICK8oNfHvcVGoDPUBHKP8IDFqE/OB5UE6i2tT47njjha69RODkACYaoQtICxXVT1feVFSYxQNLvyctMhzIfZXHio41PS21hbVyUUGZW+1K6+MfdEQRLvH/OW4v2msBpdbEPONzbITGgHGDccV87+2MPYbLfSQmV+aEufbvQqDt2/5baZ9xtmgcD4uqACSYzZfo/gXJCjVubC1M4Cy3Qi9iWA6NI2lOOBgzDGJKGrwW//A6+l2cxajBkxGnV0CLsTqWfBfQAn5I4iqPxIOr8J58sP3OFWiMek7Isw7QgvZIkMUNgi3yX6NNe4xM0IONePzDI05yE6DmrKMwptdbWYifmyj8F1zOjMBPVz6dT4iyc0+ECvDrGAoiEruUBjOnfTxflSbO2vvLsSTuRaQw3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(478600001)(966005)(6506007)(53546011)(6486002)(186003)(6512007)(26005)(6666004)(316002)(6636002)(54906003)(36756003)(2616005)(37006003)(38100700002)(66556008)(66476007)(8676002)(4326008)(66946007)(8936002)(6862004)(83380400001)(5660300002)(41300700001)(30864003)(2906002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYkf+g8uBaRQzUtSLpo8wrhSvTUxTIr5qRRm9MHSEWxNeT/8Bs6vHdBvb3tE?=
 =?us-ascii?Q?jEa7+BvIk6cwqKd5gQwHEjGvMzVLFOAyJZoO3PM7Btsa+CJ+AOmBHo2vMycd?=
 =?us-ascii?Q?tkJyZNZ0P1K1bRwJjPsmkzcnCOIRImiYjTyiFZod5c5DogDEUodHGf0ftFBT?=
 =?us-ascii?Q?pMCo5/oMVFTuKULRxNX94g8VNbC3gKZOauGo5DeCJ4fTqv/DNdJKoedR6/Wa?=
 =?us-ascii?Q?P7ABgSQ1Le4sJ8nuawEv3aorGM5DPdgJNF7yn11ksV/Ej83rB7ug4th0Hqsc?=
 =?us-ascii?Q?hewbuMTiXnvAWWhPJxieBQMORkHUkY4PulbbEidubNPPTY11Wy5pCkQBIuTM?=
 =?us-ascii?Q?MGWsaJ0B8lBrYgZogZjB6KJjiXUnLYStbJTQ4+5G6FsanzvbYzTEDyi8Y/3S?=
 =?us-ascii?Q?51nnAkhQ3a/7jLhFZPNx7OpZFCYo1B2Vrs/Eq1b1Jk1679waK/SK7K7jQXPU?=
 =?us-ascii?Q?rSkHC1/FTvw6BzJpLUWBdmOLCyDrwirq0qH3wtudLPljJ3+u5FN6ga9UwcSY?=
 =?us-ascii?Q?Ww0S1gHHtmFF0u3ff1nQb5tMuuB6wfifjbJH7IylJViU2x6D9m6DNvTxRq7r?=
 =?us-ascii?Q?WWD/ORoSwU4fNb8yH1t9fmzLOf2xxqk9dD4twJZk8+ZBEpukpY/poNaGbBlf?=
 =?us-ascii?Q?BqHmlM6fJnVi2rJ4BocQYlQhxdJKIUQV0wHPDR0GB3tDfHRkp4lJhFFZMSBs?=
 =?us-ascii?Q?XhVdV16hz9ira04ggfmmcZclp9fXKC3zxqe7DusvmCHL/Kmja++WYgxPP/y7?=
 =?us-ascii?Q?EiSUkabYOo61yFaTrEyW3w2G/W/PYjHzv3vM8zNJ/HE4l8yq27WSkYMzUVOG?=
 =?us-ascii?Q?QAUneFafPcN8cIj1EJVDZWhZY11slrDJ7bBW4MV6V7ZQQ7Ex8ZI3OJGw2LjX?=
 =?us-ascii?Q?oIJeU9qmPYb1kci/yU9p5rBGeH+ptL9vXIdjXGuY4zNRkpAmX83j68nniOZk?=
 =?us-ascii?Q?LbKVAnDg8BkexV3OyeIMWSYOrxBnNOrzseCmj5zM/bFxhD8HLUoBQ3jxVFis?=
 =?us-ascii?Q?1Bg79K9p3Au/w/Tv97n3OMTVz5jf48FB4f85zwwq/5QMCUuhdQE88+KoNQw3?=
 =?us-ascii?Q?K8AuNa2JVVdQK+PP2zdVgqd0/UP+t05JpzdWBrZMxCFECohuWdeSwTluzuAq?=
 =?us-ascii?Q?VzU7Y5yXJAymDJ7+iX93x0aNX7UaLeCaWDRnY/G/DB/7vziTa6gKMrNPnv2Y?=
 =?us-ascii?Q?0gLE1bUhSZx8JLMv/5KU53anKL5QD1iVCHJf4NVUAtHkuC6BSaUB3sUEf4zC?=
 =?us-ascii?Q?/wyxIo/yC16SxTIm5wXUjWsZgqlup6UTU3YogmuoBmi/xtejEoXQQwRMD2PH?=
 =?us-ascii?Q?l1vmOtjT8MFXs0MwdsOKaHAzLwDQWLJuTbVy0ONsr/9jwcs1JoYMeTudFhj1?=
 =?us-ascii?Q?Ou8cQlgLVihIBqHXNTUEMNiYkOWaIL1kJ3XSRTFJMoU/GNKir2/gVUM24zMT?=
 =?us-ascii?Q?TbUpGK54czPGCbNaVksXe2S6PxwgJRpE2HmmzCJ7+TyP94CFcekKSyQTixDF?=
 =?us-ascii?Q?8vrcM6h7NqdLWdd0Y5AjefxfKSI1ljss4dHuM8wU/B5ffWbJOGLnQV1jnOkV?=
 =?us-ascii?Q?PtePjMlElbzeVUouQQNuw3COTBx+Brbhbko4GBs3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9545a5-53a1-4754-724f-08dae4b599c2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 07:16:25.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bf/Jt2Z43E5fRf+Q6hmPmGpKwFALnicOGLJdMpUUUcxJtWm5jRTXL4PyjS5K6/frgRKb4rXCKFNc8o39G/gzcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 06:21:14PM +0800, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> HI ray. 
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Monday, December 12, 2022 4:47 PM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 05/13] cpufreq: amd-pstate: implement Pstate EPP
> > support for the AMD processors
> > 
> > On Thu, Dec 08, 2022 at 07:18:44PM +0800, Yuan, Perry wrote:
> > > From: Perry Yuan <Perry.Yuan@amd.com>
> > >
> > > Add EPP driver support for AMD SoCs which support a dedicated MSR for
> > > CPPC.  EPP is used by the DPM controller to configure the frequency
> > > that a core operates at during short periods of activity.
> > >
> > > The SoC EPP targets are configured on a scale from 0 to 255 where 0
> > > represents maximum performance and 255 represents maximum efficiency.
> > >
> > > The amd-pstate driver exports profile string names to userspace that
> > > are tied to specific EPP values.
> > >
> > > The balance_performance string (0x80) provides the best balance for
> > > efficiency versus power on most systems, but users can choose other
> > > strings to meet their needs as well.
> > >
> > > $ cat
> > >
> > /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_p
> > > references default performance balance_performance balance_power
> > power
> > >
> > > $ cat
> > >
> > /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
> > > balance_performance
> > >
> > > To enable the driver,it needs to add `amd_pstate=active` to kernel
> > > command line and kernel will load the active mode epp driver
> > >
> > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > ---
> > >  drivers/cpufreq/amd-pstate.c | 631
> > ++++++++++++++++++++++++++++++++++-
> > >  include/linux/amd-pstate.h   |  35 ++
> > >  2 files changed, 660 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c
> > > b/drivers/cpufreq/amd-pstate.c index c17bd845f5fc..0a521be1be8a
> > 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -37,6 +37,7 @@
> > >  #include <linux/uaccess.h>
> > >  #include <linux/static_call.h>
> > >  #include <linux/amd-pstate.h>
> > > +#include <linux/cpufreq_common.h>
> > >
> > >  #include <acpi/processor.h>
> > >  #include <acpi/cppc_acpi.h>
> > > @@ -59,9 +60,125 @@
> > >   * we disable it by default to go acpi-cpufreq on these processors and add
> > a
> > >   * module parameter to be able to enable it manually for debugging.
> > >   */
> > > -static struct cpufreq_driver amd_pstate_driver;
> > > +static bool cppc_active;
> > >  static int cppc_load __initdata;
> > >
> > > +static struct cpufreq_driver *default_pstate_driver; static struct
> > > +amd_cpudata **all_cpu_data; static struct amd_pstate_params
> > > +global_params;
> > > +
> > > +static DEFINE_MUTEX(amd_pstate_limits_lock);
> > > +static DEFINE_MUTEX(amd_pstate_driver_lock);
> > > +
> > > +static bool cppc_boost __read_mostly;
> > > +
> > > +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64
> > > +cppc_req_cached) {
> > > +	s16 epp;
> > > +	struct cppc_perf_caps perf_caps;
> > > +	int ret;
> > > +
> > > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > > +		if (!cppc_req_cached) {
> > > +			epp = rdmsrl_on_cpu(cpudata->cpu,
> > MSR_AMD_CPPC_REQ,
> > > +					&cppc_req_cached);
> > > +			if (epp)
> > > +				return epp;
> > > +		}
> > > +		epp = (cppc_req_cached >> 24) & 0xFF;
> > > +	} else {
> > > +		ret = cppc_get_epp_caps(cpudata->cpu, &perf_caps);
> > > +		if (ret < 0) {
> > > +			pr_debug("Could not retrieve energy perf value
> > (%d)\n", ret);
> > > +			return -EIO;
> > > +		}
> > > +		epp = (s16) perf_caps.energy_perf;
> > 
> > It should align the static_call structure to implement the function. Please
> > refer amd_pstate_init_perf. I think it can even re-use the init_perf to get the
> > epp cap value.
> 
> The  amd_pstate_init_perf() is only called when driver registering,
> However the amd_pstate_get_epp() will be called frequently to update the EPP MSR value and EPP Min/Max  limitation. 
> So I suggest to keep using the amd_pstate_get_epp() to update EPP related values as it is.
> 
> Static_call method can do that for MSR and Shared memory  API  call, but amd_pstate_get_epp() is simple  enough for now. No need to make this 
> Epp update function also using static call method. 

Using static calls are to avoid retpoline, not to make them simple.

https://thenewstack.io/linux-kernel-5-10-introduces-static-calls-to-prevent-speculative-execution-attacks/

> Considering the tight schedule and merge window, I would like to keep the current way to update EPP, Otherwise the Customer release schedule will be delayed. 
> 

Mailing list is not the place to talk about internal schedule.

> Perry.
> 
> 
> > 
> > > +	}
> > > +
> > > +	return epp;
> > > +}
> > > +
> > > +static int amd_pstate_get_energy_pref_index(struct amd_cpudata
> > > +*cpudata) {
> > > +	s16 epp;
> > > +	int index = -EINVAL;
> > > +
> > > +	epp = amd_pstate_get_epp(cpudata, 0);
> > > +	if (epp < 0)
> > > +		return epp;
> > > +
> > > +	switch (epp) {
> > > +	case HWP_EPP_PERFORMANCE:
> > > +		index = EPP_INDEX_PERFORMANCE;
> > > +		break;
> > > +	case HWP_EPP_BALANCE_PERFORMANCE:
> > > +		index = EPP_INDEX_BALANCE_PERFORMANCE;
> > > +		break;
> > > +	case HWP_EPP_BALANCE_POWERSAVE:
> > > +		index = EPP_INDEX_BALANCE_POWERSAVE;
> > > +		break;
> > > +	case HWP_EPP_POWERSAVE:
> > > +		index = EPP_INDEX_POWERSAVE;
> > > +		break;
> > > +	default:
> > > +			break;
> > > +	}
> > > +
> > > +	return index;
> > > +}
> > > +
> > > +static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp) {
> > > +	int ret;
> > > +	struct cppc_perf_ctrls perf_ctrls;
> > > +
> > > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > > +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> > > +
> > > +		value &= ~GENMASK_ULL(31, 24);
> > > +		value |= (u64)epp << 24;
> > > +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> > > +
> > > +		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> > value);
> > > +		if (!ret)
> > > +			cpudata->epp_cached = epp;
> > > +	} else {
> > > +		perf_ctrls.energy_perf = epp;
> > > +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> > 
> > Since the energy_perf is one of members of struct cppc_perf_ctrls, could we
> > use cppc_set_perf as well?
> 
> cppc_set_epp_perf() can handle the EPP value update correctly, 
> cppc_set_perf() is used for desired perf updating with a very high updating rate for governor such as schedutil governor.
> And it has two Phase, Phase I and Phase II,  implement the EPP value update in this function, I  have concern that we will meet some potential 
> Firmware or performance drop risk. 

I am fine to use the separated cppc_set_epp_perf.

> The release schedule and merge window is closing for v6.2 and this change request happened after six  patch review series.
> I afraid of that we have no enough time to mitigate the risk for this new code change.
> We can consider to continue optimize this in the following patch.
> 
> Perry.
> 
> > 
> > > +		if (ret) {
> > > +			pr_debug("failed to set energy perf value (%d)\n",
> > ret);
> > > +			return ret;
> > > +		}
> > > +		cpudata->epp_cached = epp;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > 
> > The same with above, the helpers for different cppc types of processors such
> > as MSR or share memory should be implemented by static_call.
> > 
> > > +
> > > +static int amd_pstate_set_energy_pref_index(struct amd_cpudata
> > *cpudata,
> > > +		int pref_index)
> > > +{
> > > +	int epp = -EINVAL;
> > > +	int ret;
> > > +
> > > +	if (!pref_index) {
> > > +		pr_debug("EPP pref_index is invalid\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (epp == -EINVAL)
> > > +		epp = epp_values[pref_index];
> > > +
> > > +	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> > {
> > > +		pr_debug("EPP cannot be set under performance policy\n");
> > > +		return -EBUSY;
> > > +	}
> > > +
> > > +	ret = amd_pstate_set_epp(cpudata, epp);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static inline int pstate_enable(bool enable)  {
> > >  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable); @@ -70,11
> > +187,21
> > > @@ static inline int pstate_enable(bool enable)  static int
> > > cppc_enable(bool enable)  {
> > >  	int cpu, ret = 0;
> > > +	struct cppc_perf_ctrls perf_ctrls;
> > >
> > >  	for_each_present_cpu(cpu) {
> > >  		ret = cppc_set_enable(cpu, enable);
> > >  		if (ret)
> > >  			return ret;
> > > +
> > > +		/* Enable autonomous mode for EPP */
> > > +		if (!cppc_active) {
> > > +			/* Set desired perf as zero to allow EPP firmware
> > control */
> > > +			perf_ctrls.desired_perf = 0;
> > > +			ret = cppc_set_perf(cpu, &perf_ctrls);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > >  	}
> > >
> > >  	return ret;
> > > @@ -418,7 +545,7 @@ static void amd_pstate_boost_init(struct
> > amd_cpudata *cpudata)
> > >  		return;
> > >
> > >  	cpudata->boost_supported = true;
> > > -	amd_pstate_driver.boost_enabled = true;
> > > +	default_pstate_driver->boost_enabled = true;
> > >  }
> > >
> > >  static void amd_perf_ctl_reset(unsigned int cpu) @@ -592,10 +719,61
> > > @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy
> > *policy,
> > >  	return sprintf(&buf[0], "%u\n", perf);  }
> > >
> > > +static ssize_t show_energy_performance_available_preferences(
> > > +				struct cpufreq_policy *policy, char *buf) {
> > > +	int i = 0;
> > > +	int offset = 0;
> > > +
> > > +	while (energy_perf_strings[i] != NULL)
> > > +		offset += sysfs_emit_at(buf, offset, "%s ",
> > > +energy_perf_strings[i++]);
> > > +
> > > +	sysfs_emit_at(buf, offset, "\n");
> > > +
> > > +	return offset;
> > > +}
> > > +
> > > +static ssize_t store_energy_performance_preference(
> > > +		struct cpufreq_policy *policy, const char *buf, size_t count) {
> > > +	struct amd_cpudata *cpudata = policy->driver_data;
> > > +	char str_preference[21];
> > > +	ssize_t ret;
> > > +
> > > +	ret = sscanf(buf, "%20s", str_preference);
> > > +	if (ret != 1)
> > > +		return -EINVAL;
> > > +
> > > +	ret = match_string(energy_perf_strings, -1, str_preference);
> > > +	if (ret < 0)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&amd_pstate_limits_lock);
> > > +	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
> > > +	mutex_unlock(&amd_pstate_limits_lock);
> > > +
> > > +	return ret ?: count;
> > > +}
> > > +
> > > +static ssize_t show_energy_performance_preference(
> > > +				struct cpufreq_policy *policy, char *buf) {
> > > +	struct amd_cpudata *cpudata = policy->driver_data;
> > > +	int preference;
> > > +
> > > +	preference = amd_pstate_get_energy_pref_index(cpudata);
> > > +	if (preference < 0)
> > > +		return preference;
> > > +
> > > +	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]); }
> > > +
> > >  cpufreq_freq_attr_ro(amd_pstate_max_freq);
> > >  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> > >
> > >  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> > > +cpufreq_freq_attr_rw(energy_performance_preference);
> > > +cpufreq_freq_attr_ro(energy_performance_available_preferences);
> > >
> > >  static struct freq_attr *amd_pstate_attr[] = {
> > >  	&amd_pstate_max_freq,
> > > @@ -604,6 +782,424 @@ static struct freq_attr *amd_pstate_attr[] = {
> > >  	NULL,
> > >  };
> > >
> > > +static struct freq_attr *amd_pstate_epp_attr[] = {
> > > +	&amd_pstate_max_freq,
> > > +	&amd_pstate_lowest_nonlinear_freq,
> > > +	&amd_pstate_highest_perf,
> > > +	&energy_performance_preference,
> > > +	&energy_performance_available_preferences,
> > > +	NULL,
> > > +};
> > > +
> > > +static inline void update_boost_state(void) {
> > > +	u64 misc_en;
> > > +	struct amd_cpudata *cpudata;
> > > +
> > > +	cpudata = all_cpu_data[0];
> > > +	rdmsrl(MSR_K7_HWCR, misc_en);
> > > +	global_params.cppc_boost_disabled = misc_en & BIT_ULL(25);
> > 
> > I won't need introduce the additional cppc_boost_disabled here. The
> > cpufreq_driver->boost_enabled and cpudata->boost_supported can manage
> > this function.
> 
> The cppc_boost_disabled is used to mark if the PMFW Core boost disabled, 
> If some other driver for example thermal, performance limiting driver disable the core  boost.

I didn't see any other driver to control MSR_K7_HWCR_CPB_DIS except
acpi-cpufreq.

> We need to update the flag to let driver know the boost is disabled.  
> 
> * boost_supported is used to change CORE freq boost  state. 
> * EPP driver did not use the cpufreq core boost sysfs node.  So the boost_enabled is not used here. 

I would like to clarify again the core boost state is for legacy ACPI
P-State, and it's configured by MSR_K7_HWCR. The CPPC is using the highest
perf to map the boost frequency. However, here, it's because of some
hardware/firmware issues or quirks that the legacy boost setting still
impacts the target frequency. So cppc_boost will confuse the user for the
functionalities between CPPC and ACPI P-State.

Can we enable core_boost configuration by default if using amd-pstate?

> 
> > 
> > I believe it should be the firmware issue that the legacy ACPI Boost state will
> > impact the frequency of CPPC. Could you move this handling into the
> > cpufreq_driver->set_boost callback function to enable boost state by default.
> > 
> > > +}
> > > +
> > > +static bool amd_pstate_acpi_pm_profile_server(void)
> > > +{
> > > +	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
> > > +	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static int amd_pstate_init_cpu(unsigned int cpunum) {
> > > +	struct amd_cpudata *cpudata;
> > > +
> > > +	cpudata = all_cpu_data[cpunum];
> > > +	if (!cpudata) {
> > > +		cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> > > +		if (!cpudata)
> > > +			return -ENOMEM;
> > > +		WRITE_ONCE(all_cpu_data[cpunum], cpudata);
> > > +
> > > +		cpudata->cpu = cpunum;
> > > +
> > > +		if (cppc_active) {
> > 
> > The cppc_active is a bit confused here, if we run into amd-pstate driver, the
> > cppc should be active. I know you want to indicate the different driver mode
> > you are running. Please use an enumeration type to mark it different mode
> > such as PASSIVE_MODE, ACTIVE_MODE, and GUIDED_MODE (Wyes
> > proposed).
> 
> Aligned with Wyse, I add one new patch to support enumerated working mode in V8
> 
> 
> > 
> > > +			if (amd_pstate_acpi_pm_profile_server())
> > > +				cppc_boost = true;
> > > +		}
> > > +
> > > +	}
> > > +	cpudata->epp_powersave = -EINVAL;
> > > +	cpudata->epp_policy = 0;
> > > +	pr_debug("controlling: cpu %d\n", cpunum);
> > > +	return 0;
> > > +}
> > > +
> > > +static int __amd_pstate_cpu_init(struct cpufreq_policy *policy) {
> > > +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> > > +	struct amd_cpudata *cpudata;
> > > +	struct device *dev;
> > > +	int rc;
> > > +	u64 value;
> > > +
> > > +	rc = amd_pstate_init_cpu(policy->cpu);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	cpudata = all_cpu_data[policy->cpu];
> > > +
> > > +	dev = get_cpu_device(policy->cpu);
> > > +	if (!dev)
> > > +		goto free_cpudata1;
> > > +
> > > +	rc = amd_pstate_init_perf(cpudata);
> > > +	if (rc)
> > > +		goto free_cpudata1;
> > > +
> > > +	min_freq = amd_get_min_freq(cpudata);
> > > +	max_freq = amd_get_max_freq(cpudata);
> > > +	nominal_freq = amd_get_nominal_freq(cpudata);
> > > +	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> > > +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> > > +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is
> > incorrect\n",
> > > +				min_freq, max_freq);
> > > +		ret = -EINVAL;
> > > +		goto free_cpudata1;
> > > +	}
> > > +
> > > +	policy->min = min_freq;
> > > +	policy->max = max_freq;
> > > +
> > > +	policy->cpuinfo.min_freq = min_freq;
> > > +	policy->cpuinfo.max_freq = max_freq;
> > > +	/* It will be updated by governor */
> > > +	policy->cur = policy->cpuinfo.min_freq;
> > > +
> > > +	/* Initial processor data capability frequencies */
> > > +	cpudata->max_freq = max_freq;
> > > +	cpudata->min_freq = min_freq;
> > > +	cpudata->nominal_freq = nominal_freq;
> > > +	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> > > +
> > > +	policy->driver_data = cpudata;
> > > +
> > > +	update_boost_state();
> > > +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
> > > +
> > > +	policy->min = policy->cpuinfo.min_freq;
> > > +	policy->max = policy->cpuinfo.max_freq;
> > > +
> > > +	if (boot_cpu_has(X86_FEATURE_CPPC))
> > > +		policy->fast_switch_possible = true;
> > 
> > Please move this line into below if-case.
> 
> 
> Fixed In V8
> 
> > 
> > > +
> > > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > > +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> > &value);
> > > +		if (ret)
> > > +			return ret;
> > > +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> > > +
> > > +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> > &value);
> > > +		if (ret)
> > > +			return ret;
> > > +		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
> > > +	}
> > > +	amd_pstate_boost_init(cpudata);
> > > +
> > > +	return 0;
> > > +
> > > +free_cpudata1:
> > > +	kfree(cpudata);
> > > +	return ret;
> > > +}
> > > +
> > > +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy) {
> > > +	int ret;
> > > +
> > > +	ret = __amd_pstate_cpu_init(policy);
> > 
> > I don't see any reason that we need to define a __amd_pstate_cpu_init()
> > here. Intel P-State driver's __intel_pstate_cpu_init() is used both on
> > intel_pstate_cpu_init and intel_cpufreq_cpu_init.
> 
> Fixed in V8.
> 
> > 
> > > +	if (ret)
> > > +		return ret;
> > > +	/*
> > > +	 * Set the policy to powersave to provide a valid fallback value in
> > case
> > > +	 * the default cpufreq governor is neither powersave nor
> > performance.
> > > +	 */
> > > +	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy) {
> > > +	pr_debug("CPU %d exiting\n", policy->cpu);
> > > +	policy->fast_switch_possible = false;
> > > +	return 0;
> > > +}
> > > +
> > > +static void amd_pstate_update_max_freq(unsigned int cpu)
> > 
> > Why do you name this function "update max frequency"?
> > 
> > We won't have the differnt cpudata->pstate.max_freq and
> > cpudata->pstate.turbo_freq on Intel P-State driver.
> > 
> > I think in fact we don't update anything here.
> 
> When core frequency was disabled, the function will update the frequency limits. 
> Currently the boost sysfs is not added, so the max freq is not changed.
> Could we keep the code for the coming patch to add the sysfs node for boost control ?
> It has no harm to the EPP driver. 

Again, the boost frequency and state is for ACPI P-State, we cannot make it
confused in the CPPC.

I didn't see where amd-pstate updates frequency max/min (limit), why we
keep the redundant codes here?

> 
> > 
> > > +{
> > > +	struct cpufreq_policy *policy = policy = cpufreq_cpu_get(cpu);
> > 
> > struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > 
> > > +
> > > +	if (!policy)
> > > +		return;
> > > +
> > > +	refresh_frequency_limits(policy);
> > > +	cpufreq_cpu_put(policy);
> > > +}
> > > +
> > > +static void amd_pstate_epp_update_limits(unsigned int cpu) {
> > > +	mutex_lock(&amd_pstate_driver_lock);
> > > +	update_boost_state();
> > > +	if (global_params.cppc_boost_disabled) {
> > > +		for_each_possible_cpu(cpu)
> > > +			amd_pstate_update_max_freq(cpu);
> > 
> > This should do nothing in the amd-pstate.
> 
> Currently the boost sysfs is not added, so the max freq is not changed.
> Could we keep the code for the coming patch to add the sysfs node for boost control ?
> It has no harm to the EPP driver.
> 
> > 
> > > +	} else {
> > > +		cpufreq_update_policy(cpu);
> > > +	}
> > > +	mutex_unlock(&amd_pstate_driver_lock);
> > > +}
> > > +
> > > +static int cppc_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
> > > +
> > > +static inline void amd_pstate_boost_up(struct amd_cpudata *cpudata) {
> > > +	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
> > > +	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
> > > +	u32 max_limit = (hwp_req & 0xff);
> > > +	u32 min_limit = (hwp_req & 0xff00) >> 8;
> > 
> > We can use cpudata->max_perf and cpudata->min_perf directly.
> 
> Iowait boost code removed from V8.
> 
> > 
> > > +	u32 boost_level1;
> > > +
> > > +	/* If max and min are equal or already at max, nothing to boost */
> > 
> > I believe this is the only case that max_perf == min_perf, not at max.
> 
> Iowait boost code removed from V8.
> 
> > 
> > > +	if (max_limit == min_limit)
> > > +		return;
> > > +
> > > +	/* Set boost max and min to initial value */
> > > +	if (!cpudata->cppc_boost_min)
> > > +		cpudata->cppc_boost_min = min_limit;
> > > +
> > > +	boost_level1 = ((AMD_CPPC_NOMINAL_PERF(hwp_cap) +
> > min_limit) >> 1);
> > > +
> > > +	if (cpudata->cppc_boost_min < boost_level1)
> > > +		cpudata->cppc_boost_min = boost_level1;
> > > +	else if (cpudata->cppc_boost_min <
> > AMD_CPPC_NOMINAL_PERF(hwp_cap))
> > > +		cpudata->cppc_boost_min =
> > AMD_CPPC_NOMINAL_PERF(hwp_cap);
> > > +	else if (cpudata->cppc_boost_min ==
> > AMD_CPPC_NOMINAL_PERF(hwp_cap))
> > > +		cpudata->cppc_boost_min = max_limit;
> > > +	else
> > > +		return;
> > 
> > Could you please elaborate the reason that you separate the min_perf
> > (cppc_boost_min) you would like to update into cppc_req register as these
> > different cases? Why we pick up these cases such as (min + nominal)/2, and
> > around nominal? What's the help to optimize the final result? - I am thinking
> > the autonomous mode is handled by SMU firmware, we need to provide
> > some data that let us know it influences the final result.
> > 
> 
> Iowait boost code removed from V8.
> 
> > > +
> > > +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> > > +	hwp_req |= AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
> > > +	wrmsrl(MSR_AMD_CPPC_REQ, hwp_req);
> > 
> > Do we need an update for share memory processors? In other words, epp is
> > also supported on share memory processors. - again, we should use static
> > call to handle the msr and cppc_acpi stuff.
> > 
> > > +	cpudata->last_update = cpudata->sample.time; }
> > > +
> > > +static inline void amd_pstate_boost_down(struct amd_cpudata *cpudata)
> > > +{
> > > +	bool expired;
> > > +
> > > +	if (cpudata->cppc_boost_min) {
> > > +		expired = time_after64(cpudata->sample.time, cpudata-
> > >last_update +
> > > +					cppc_boost_hold_time_ns);
> > > +
> > > +		if (expired) {
> > > +			wrmsrl(MSR_AMD_CPPC_REQ, cpudata-
> > >cppc_req_cached);
> > > +			cpudata->cppc_boost_min = 0;
> > > +		}
> > > +	}
> > > +
> > > +	cpudata->last_update = cpudata->sample.time; }
> > > +
> > > +static inline void amd_pstate_boost_update_util(struct amd_cpudata
> > *cpudata,
> > > +						      u64 time)
> > > +{
> > > +	cpudata->sample.time = time;
> > > +	if (smp_processor_id() != cpudata->cpu)
> > > +		return;
> > > +
> > > +	if (cpudata->sched_flags & SCHED_CPUFREQ_IOWAIT) {
> > > +		bool do_io = false;
> > > +
> > > +		cpudata->sched_flags = 0;
> > > +		/*
> > > +		 * Set iowait_boost flag and update time. Since IO WAIT flag
> > > +		 * is set all the time, we can't just conclude that there is
> > > +		 * some IO bound activity is scheduled on this CPU with just
> > > +		 * one occurrence. If we receive at least two in two
> > > +		 * consecutive ticks, then we treat as boost candidate.
> > > +		 * This is leveraged from Intel Pstate driver.
> > 
> > I would like to know whether we can hit this case as well? If we can find or
> > create a use case to hit it in our platforms, I am fine to add it our driver as
> > well. If not, I don't suggest it we add them at this moment. I hope we have
> > verified each code path once we add them into the driver.
> 
> Sure, no problem. 
> Iowait boost code removed from V8.
> 
> 
> > 
> > > +		 */
> > > +		if (time_before64(time, cpudata->last_io_update + 2 *
> > TICK_NSEC))
> > > +			do_io = true;
> > > +
> > > +		cpudata->last_io_update = time;
> > > +
> > > +		if (do_io)
> > > +			amd_pstate_boost_up(cpudata);
> > > +
> > > +	} else {
> > > +		amd_pstate_boost_down(cpudata);
> > > +	}
> > > +}
> > > +
> > > +static inline void amd_pstate_cppc_update_hook(struct update_util_data
> > *data,
> > > +						u64 time, unsigned int flags)
> > > +{
> > > +	struct amd_cpudata *cpudata = container_of(data,
> > > +				struct amd_cpudata, update_util);
> > > +
> > > +	cpudata->sched_flags |= flags;
> > > +
> > > +	if (smp_processor_id() == cpudata->cpu)
> > > +		amd_pstate_boost_update_util(cpudata, time); }
> > > +
> > > +static void amd_pstate_clear_update_util_hook(unsigned int cpu) {
> > > +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> > > +
> > > +	if (!cpudata->update_util_set)
> > > +		return;
> > > +
> > > +	cpufreq_remove_update_util_hook(cpu);
> > > +	cpudata->update_util_set = false;
> > > +	synchronize_rcu();
> > > +}
> > > +
> > > +static void amd_pstate_set_update_util_hook(unsigned int cpu_num) {
> > > +	struct amd_cpudata *cpudata = all_cpu_data[cpu_num];
> > > +
> > > +	if (!cppc_boost) {
> > > +		if (cpudata->update_util_set)
> > > +			amd_pstate_clear_update_util_hook(cpudata->cpu);
> > > +		return;
> > > +	}
> > > +
> > > +	if (cpudata->update_util_set)
> > > +		return;
> > > +
> > > +	cpudata->sample.time = 0;
> > > +	cpufreq_add_update_util_hook(cpu_num, &cpudata->update_util,
> > > +
> > 	amd_pstate_cppc_update_hook);
> > > +	cpudata->update_util_set = true;
> > > +}
> > > +
> > > +static void amd_pstate_epp_init(unsigned int cpu) {
> > > +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> > > +	u32 max_perf, min_perf;
> > > +	u64 value;
> > > +	s16 epp;
> > > +
> > > +	max_perf = READ_ONCE(cpudata->highest_perf);
> > > +	min_perf = READ_ONCE(cpudata->lowest_perf);
> > > +
> > > +	value = READ_ONCE(cpudata->cppc_req_cached);
> > > +
> > > +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> > > +		min_perf = max_perf;
> > > +
> > > +	/* Initial min/max values for CPPC Performance Controls Register */
> > > +	value &= ~AMD_CPPC_MIN_PERF(~0L);
> > > +	value |= AMD_CPPC_MIN_PERF(min_perf);
> > > +
> > > +	value &= ~AMD_CPPC_MAX_PERF(~0L);
> > > +	value |= AMD_CPPC_MAX_PERF(max_perf);
> > > +
> > > +	/* CPPC EPP feature require to set zero to the desire perf bit */
> > > +	value &= ~AMD_CPPC_DES_PERF(~0L);
> > > +	value |= AMD_CPPC_DES_PERF(0);
> > > +
> > > +	if (cpudata->epp_policy == cpudata->policy)
> > > +		goto skip_epp;
> > > +
> > > +	cpudata->epp_policy = cpudata->policy;
> > > +
> > > +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> > > +		epp = amd_pstate_get_epp(cpudata, value);
> > > +		cpudata->epp_powersave = epp;
> > 
> > I didn't see where we should have epp_powersave here. Only initial this, but
> > it won't be used anywhere.
> 
> epp_powersave   var was removed from V8.
> 
> 
> > 
> > > +		if (epp < 0)
> > > +			goto skip_epp;
> > > +		/* force the epp value to be zero for performance policy */
> > > +		epp = 0;
> > > +	} else {
> > > +		if (cpudata->epp_powersave < 0)
> > > +			goto skip_epp;
> > > +		/* Get BIOS pre-defined epp value */
> > > +		epp = amd_pstate_get_epp(cpudata, value);
> > > +		if (epp)
> > > +			goto skip_epp;
> > > +		epp = cpudata->epp_powersave;
> > > +	}
> > > +	/* Set initial EPP value */
> > > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > > +		value &= ~GENMASK_ULL(31, 24);
> > > +		value |= (u64)epp << 24;
> > > +	}
> > > +
> > > +skip_epp:
> > > +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> > > +	amd_pstate_set_epp(cpudata, epp);
> > > +}
> > > +
> > > +static void amd_pstate_set_max_limits(struct amd_cpudata *cpudata) {
> > > +	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
> > > +	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
> > > +	u32 max_limit = (hwp_cap >> 24) & 0xff;
> > > +
> > > +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> > > +	hwp_req |= AMD_CPPC_MIN_PERF(max_limit);
> > > +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req); }
> > > +
> > > +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy) {
> > > +	struct amd_cpudata *cpudata;
> > > +
> > > +	if (!policy->cpuinfo.max_freq)
> > > +		return -ENODEV;
> > > +
> > > +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> > > +				policy->cpuinfo.max_freq, policy->max);
> > > +
> > > +	cpudata = all_cpu_data[policy->cpu];
> > > +	cpudata->policy = policy->policy;
> > > +
> > > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > > +		mutex_lock(&amd_pstate_limits_lock);
> > > +
> > > +		if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> > > +			amd_pstate_clear_update_util_hook(policy->cpu);
> > > +			amd_pstate_set_max_limits(cpudata);
> > > +		} else {
> > > +			amd_pstate_set_update_util_hook(policy->cpu);
> > > +		}
> > > +
> > > +		mutex_unlock(&amd_pstate_limits_lock);
> > > +	}
> > > +	amd_pstate_epp_init(policy->cpu);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
> > > +					   struct cpufreq_policy_data *policy)
> > {
> > > +	update_boost_state();
> > > +	cpufreq_verify_within_cpu_limits(policy);
> > > +}
> > > +
> > > +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data
> > > +*policy) {
> > > +	amd_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
> > > +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy-
> > >min);
> > > +	return 0;
> > > +}
> > 
> > amd_pstate_verify_cpu_policy and amd_pstate_epp_verify_policy can be
> > squeezed in one function.
> 
> Fixed in V8. 
> 
> > 
> > > +
> > >  static struct cpufreq_driver amd_pstate_driver = {
> > >  	.flags		= CPUFREQ_CONST_LOOPS |
> > CPUFREQ_NEED_UPDATE_LIMITS,
> > >  	.verify		= amd_pstate_verify,
> > > @@ -617,8 +1213,20 @@ static struct cpufreq_driver amd_pstate_driver =
> > {
> > >  	.attr		= amd_pstate_attr,
> > >  };
> > >
> > > +static struct cpufreq_driver amd_pstate_epp_driver = {
> > > +	.flags		= CPUFREQ_CONST_LOOPS,
> > > +	.verify		= amd_pstate_epp_verify_policy,
> > > +	.setpolicy	= amd_pstate_epp_set_policy,
> > > +	.init		= amd_pstate_epp_cpu_init,
> > > +	.exit		= amd_pstate_epp_cpu_exit,
> > > +	.update_limits	= amd_pstate_epp_update_limits,
> > > +	.name		= "amd_pstate_epp",
> > > +	.attr		= amd_pstate_epp_attr,
> > > +};
> > > +
> > >  static int __init amd_pstate_init(void)  {
> > > +	static struct amd_cpudata **cpudata;
> > >  	int ret;
> > >
> > >  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) @@ -645,7
> > +1253,8 @@
> > > static int __init amd_pstate_init(void)
> > >  	/* capability check */
> > >  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > >  		pr_debug("AMD CPPC MSR based functionality is
> > supported\n");
> > > -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> > > +		if (!cppc_active)
> > > +			default_pstate_driver->adjust_perf =
> > amd_pstate_adjust_perf;
> > >  	} else {
> > >  		pr_debug("AMD CPPC shared memory based functionality is
> > supported\n");
> > >  		static_call_update(amd_pstate_enable, cppc_enable); @@ -
> > 653,6
> > > +1262,10 @@ static int __init amd_pstate_init(void)
> > >  		static_call_update(amd_pstate_update_perf,
> > cppc_update_perf);
> > >  	}
> > >
> > > +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> > > +	if (!cpudata)
> > > +		return -ENOMEM;
> > > +	WRITE_ONCE(all_cpu_data, cpudata);
> > 
> > Why we cannot use cpufreq_policy->driver_data to store the cpudata? I
> > believe the cpudata is per-CPU can be easily get from private data.
> 
> cpufreq_policy->driver_data can do that, but global data can have better cached hit rate especially 
> for the server cluster.
> So I would prefer to use the global cpudata to store each CPU data struct. 
> Could we keep it for EPP driver ?

I didn't get your meaning what's "better cached hit rate especially for the
server cluster"? In my view, there is just different design no performance
enhancement. Since we already implemented in cpufreq_policy->driver_data, I
didn't see any visiblely improvement to change into this way.

Thanks,
Ray
