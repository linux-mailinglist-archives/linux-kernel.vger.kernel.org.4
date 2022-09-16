Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3DB5BA4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIPDBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIPDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:01:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75F931352
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663297305; x=1694833305;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HetF/NNCgW7G9YDuQ8ps5zgLfQl8/SKyh1h23AbeNrU=;
  b=NfCkd0Yynlcudm8S+JGuTgSTBWJJ6tQKubIm/AfELLvRHszrZB6TJ5Sk
   OPto9yKaYm5TEbRKUGcjbD1sEjJOlpvaTz6s4bjrI8wrpQSIiKmORTUY4
   AU5ouaNhBU1Awq78ZWBgBUaJZJastf1H8o/emyJLifJNKFnF+7p3TC8DT
   UpJTDp/J0T+jJVdWOVEygkBUyPz0/XvgvuIw3JWHdoTLbCM5qRILdwo9l
   kSJXIMeS27Rx56Mu6hXillT77d40UbXKNyYLx/GRNhSLaqu9L+EU9aV9q
   A7MoHAeVPFgbJtvbcn/vMaYBH88bS8Bd41PX43mBtCp5bBOCPXpMCMBXG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325165775"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="325165775"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="862592840"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 15 Sep 2022 20:01:45 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 20:01:44 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 20:01:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 15 Sep 2022 20:01:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 15 Sep 2022 20:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHXkXGJ/NYUlpe5bXV7mPaGkZRE1x2MqN2zZGAKUjpHB/KRT8e/Ki8dzUyyr7D2H4tv0sDwSffHiBNJgw43Ag6SMFfsAI/FSkbQbXmDd95QjL4Hic6yqjCru1AiS9rkz5GsAKyyAdmO3GFusIjqjN7b/Vm7E3bpPBb5Qcjjmx0dfcHJ8+dXXgb+4Z/Flh1gnT1KCizUI873iI8q91SUQC0elrntZ75TOVVi9B18MdCURGml4Ex0uS0bq4x4crzteCe363T24uzsM26kTVdVbjfVRUDS6CQmraz5RyL/XjjD9AMBZ0dY4V7CzEYEbxK0NsyQaa8yF98P18tKCFZlpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4WW+JPRRxNfT1LqzIgwSC95CVt+FQ24Rl1q0o75dPE=;
 b=hqC4fV7RfYIDk/U5icn1KZ1ki/1IwSrCSselQFJfxVFdYu3hbERNmqpLfIfT0JzdZDASN7JziskSKvQBD+8ZDnUWKLlbDmAdd+UF2ea8KhiypqWrR3tJlEfMHHx958SRGW+HkXgt6ewRx0HOLN5WtJSE5hVXwYPduR49wyBKfWNEfRTFwLNxPk7JFPBXb0qIgu6yvaaFvEH2oRvRK2C+lgWjVjQKYrlNtqPGEgw9Y8p36vQwG5YbWGviGEPYqyt7wSFk/6Ov5KUpFVGhER4chpc3YMps9zTyHF8CblhAvvEH1vZ1zOFCgqpnnNhxvcekoH1h6AOjeNOEJmdok7RCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 03:01:38 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::9db5:95f1:a79:960d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::9db5:95f1:a79:960d%7]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 03:01:38 +0000
Date:   Fri, 16 Sep 2022 11:01:08 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <paulmck@kernel.org>, <rui.zhang@intel.com>, <len.brown@intel.com>,
        <tim.c.chen@intel.com>
Subject: Re: [PATCH v4] x86/tsc: Add option to force frequency recalibration
 with HW timer
Message-ID: <YyPm9G3xMuUVuTcs@feng-clx>
References: <20220817074018.10930-1-feng.tang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220817074018.10930-1-feng.tang@intel.com>
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: efd9427a-1c87-434e-7542-08da978fc5eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGAk3UF0jtz35YbWt41Iq+M/k3D39rLH+5t26rcuT8cNWdVWAaNs8ow76vX6x5onImjpqt5DRDIBtpZR0+HHyUC+gsEb/LZIKqll12LEXZz6doIhiYEhScq9lKlZ1RvrAqltb2gv70cQy50kLw7EIntV6kkpdVwz3EzWRgPOaedheSIbnE4sCrbkuu2H4kg6QxqxZ0ZWc/1JcC15gA60DzYnaasaJ8lsyXRS+kjPvhSx+0iun/F1WdO837vt+m2vu7eKoUJ4pZ79C2C8szSkSJvhdDN+oLDrmGhy1nA+47yCAHW3XL+s4abpMlMkhJYkFrzUrbTBDUAJQQE+tkT6uFDBvNC3eTMz8NDGoYQkGgCj17QPgMxYDtOwenxZYGWD74KzkWKrGEt87KkwNyiNL7atQ84u1KF4Waf6pO4IBU7KD7vJj/lil86pY0Q2Wu2LltJoYfPXXzjVh9cUttthHxqxnfBSTebZFWjFNrYJc1wfXUoGu+zuxSvdY0BmbcBUrUvFprF5JkNcMwvZOMZLhHtvl/wQPTm6iSzsrQ/p+Wfbx3n5Fgk0zwsouEw2E264S3KsTEdXcDW/5TYIb5cT55VIyHTpu0PUUlVBzxw+K8TXBOt8fMkcM6+EinOyPgjbW0cpbL/JO9xAbnPtnak7vR9m5IUNfgPKSrOwqKv/jOBNGuM9cEpFDGjI6kRQ9ECoxwluiQsG5zMkVUcp5zdPAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(4326008)(5660300002)(8676002)(66946007)(86362001)(66556008)(66476007)(8936002)(478600001)(107886003)(6666004)(6486002)(44832011)(6506007)(2906002)(41300700001)(83380400001)(82960400001)(9686003)(26005)(6512007)(38100700002)(110136005)(186003)(33716001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SlCxYJHY/r6+KNfbFVhX8KtAWIgp2SEnzvMo0+kOrD1aAcZ5a8NF68S6EldA?=
 =?us-ascii?Q?te358aV4w6FxaM/a3EDL5oL2LWt/cShc4pw0YlBbRoswbOYTRV7jNWgAKUu4?=
 =?us-ascii?Q?lYI0pF6lpYM+nRw44tR86TKsRihED4GO4/CAzTIMDNfR7gb1sWFRnoEbIAlE?=
 =?us-ascii?Q?bfXeHGcJtnqA2EDrv45rOnPGDVOoOSnm7VZLgHh67MfR8Jwsr2EKAgx49FQH?=
 =?us-ascii?Q?EG83SBrFus7K+vnY+xUnD+JTYy6gExuHFhNSL4k5WiSeYEdq6j7nCxxzGbN6?=
 =?us-ascii?Q?NLbrO4rA+o5m/wrsjAMsn/LWY05M/Lzs+AZO/RDbQQXx3hVGTawol0mjun0b?=
 =?us-ascii?Q?El8cIa8YCXN/M/dL4pWLMFoJ5k02dQvrWnCbZ+FITcZjJpVfB0V6orwrsXo7?=
 =?us-ascii?Q?+gvr45d/M4HkkHIdhvhIlfP5n+VMKlToXcbHJdCal/lpgtjp0diaqf6s2s+0?=
 =?us-ascii?Q?eYQPKDKxeJMPxC52WulI3YuP2VuLJYRHv9vZ4NcmyD9uKupQEYC5aipeg/WH?=
 =?us-ascii?Q?i71feIr5xsoKaaSZ+7W4a133BYi4HqLiLtXA6F0t3NsF2Zo2HdXFew86mALF?=
 =?us-ascii?Q?ygmePZgYCgha9fL3gOPqHPG+YKNd59TGxBgV3PXT18tRuLRj/NZ+rTWrwi7C?=
 =?us-ascii?Q?g/cmiyN0Ju8WZRXWO/EBossPNl1J0ATqeytQtduMo6BTGU7m4VfdoVFybVzJ?=
 =?us-ascii?Q?Tdd7DwdzGcX2k6tZc4WZXb7Mty7yNGTLLaXO/H2kkqBvaLPsWnCTNMj2z2D3?=
 =?us-ascii?Q?qXuWlz4BDqTnzZ6NAVcgxMVvVXGoedwWTkxbD1S0FiRkQrrtGQpzksNsWSil?=
 =?us-ascii?Q?u9Ezv41FpJr8rLblaTTJqAJ+qeaWep3+8p2WNmZn2YuBInVb4kujx6exGJcq?=
 =?us-ascii?Q?/XwVULY3F9LbARUyOh2E6vq9WqRmZTvrwuxEu+UpO6JaeSNIb033Q/0bzboa?=
 =?us-ascii?Q?eSqEfpFmT4N4db342+kBiIJOwaINFY4P3gCHc1dJ4HziVpM3gePcncorLagN?=
 =?us-ascii?Q?J4MVFIbLcSbEpxnh//NEmuiiZ5NstwdjI6BAJcT8Zaz4tbkYJLMAx/9/LKv6?=
 =?us-ascii?Q?4bV8mY1PEz2awwxJFlJyVu7FGVww7y+3FxsUgBrfmmllRMWYdEsgZaczYKkz?=
 =?us-ascii?Q?HodCRPka+e1v2BxPuqioOtYnZ/AFGGEbMEBOlw0NBWy1jWlZwOT+MU7bgyYR?=
 =?us-ascii?Q?B+SQ9xDC5LTdBHzzMbzamXARmAc7YfAoVXLbslnwPJPaFHlubx58ZZwTfIKO?=
 =?us-ascii?Q?CSJz8bIKI/OAmj8Omgrd9TpH0+advm43gke7qmFf5blazIHe2u1+HKg496bB?=
 =?us-ascii?Q?i0Mrn8jkswdv1zcxXU8jV+X4wumYmC+9MmcmZgYExEIQi41HBWFm3o57vhWD?=
 =?us-ascii?Q?Rj268EYcars9YBmWh51qmcF29J8y6n+P9usO8Wcl+E5GMrZxvUWrsvVvz/uC?=
 =?us-ascii?Q?ErVYTxlEEdUD+5iP3u13S4rYwPG5/U8ffYTVoxLGPdyKw+eO9bpIm7aEbAki?=
 =?us-ascii?Q?RLmI3AeVGrpeNNYB+noKsmzWQhnNWRyZH3B7kUQVSzqW+kpt/JcJgvvLAzt9?=
 =?us-ascii?Q?iDXHtZv0c6SgjnKrJjphZdjmCqXBz6DvamG/ZAf4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efd9427a-1c87-434e-7542-08da978fc5eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 03:01:38.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lmr+Nhx31VY6GhsKbvk1+0ZyXXHsLcs5CGRVmCU5fF9md1Vp/6oHFvsIjcKYF+0MTOtLPj7SrDAqBPeIU0bSsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Peter,

You've helped reviewing the earlier version and improving the patch
description, and do you see any other places I need to improve? thanks!

- Feng

On Wed, Aug 17, 2022 at 03:40:18PM +0800, Feng Tang wrote:
> The kernel assumes that the TSC frequency which is provided by the
> hardware / firmware via MSRs or CPUID(0x15) is correct after applying
> a few basic consistency checks. This disables the TSC recalibration
> against HPET or PM timer.
> 
> As a result there is no mechanism to validate that frequency in cases
> where a firmware or hardware defect is suspected. And there was case
> that some user used atomic clock to measure the TSC frequency and
> reported an inaccuracy issue, which was later fixed in firmware.
> 
> Add an option 'recalibrate' for 'tsc' kernel parameter to force the
> tsc freq recalibration with HPET or PM timer, and warn if the deviation
> from previous value is more than about 500 PPM, which provides a way 
> to verify the data from hardware / firmware.
> 
> There is no functional change to existing work flow.
> 
> [Thanks tglx for helping improving the commit log] 
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
> 
>   since v3:
>     * add some real world case into commit log
>     * rebase against v6.0-rc1
> 
>   since v2:
>     * revise the option description in kernel-parameters.txt
>     * rebase against v5.19-rc2
> 
>   since v1:
>     * refine commit log to state clearly the problem and intention
>       of the patch by copying Thomas' words.
> 
>  .../admin-guide/kernel-parameters.txt         |  4 +++
>  arch/x86/kernel/tsc.c                         | 34 ++++++++++++++++---
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d7f30902fda0..4924256592d9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6302,6 +6302,10 @@
>  			in situations with strict latency requirements (where
>  			interruptions from clocksource watchdog are not
>  			acceptable).
> +			[x86] recalibrate: force to do frequency recalibration
> +			with a HW timer (HPET or PM timer) for systems whose
> +			TSC frequency comes from HW or FW through MSR or CPUID(0x15),
> +			and warn if the difference is more than 500 ppm.
>  
>  	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
>  			value instead. Useful when the early TSC frequency discovery
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cafacb2e58cc..5cf62a58754a 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -48,6 +48,8 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
>  
>  int tsc_clocksource_reliable;
>  
> +static int __read_mostly tsc_force_recalibrate;
> +
>  static u32 art_to_tsc_numerator;
>  static u32 art_to_tsc_denominator;
>  static u64 art_to_tsc_offset;
> @@ -303,6 +305,8 @@ static int __init tsc_setup(char *str)
>  		mark_tsc_unstable("boot parameter");
>  	if (!strcmp(str, "nowatchdog"))
>  		no_tsc_watchdog = 1;
> +	if (!strcmp(str, "recalibrate"))
> +		tsc_force_recalibrate = 1;
>  	return 1;
>  }
>  
> @@ -1374,6 +1378,25 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>  	else
>  		freq = calc_pmtimer_ref(delta, ref_start, ref_stop);
>  
> +	/* Will hit this only if tsc_force_recalibrate has been set */
> +	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> +
> +		/* Warn if the deviation exceeds 500 ppm */
> +		if (abs(tsc_khz - freq) > (tsc_khz >> 11)) {
> +			pr_warn("Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!\n");
> +			pr_info("Previous calibrated TSC freq:\t %lu.%03lu MHz\n",
> +				(unsigned long)tsc_khz / 1000,
> +				(unsigned long)tsc_khz % 1000);
> +		}
> +
> +		pr_info("TSC freq recalibrated by [%s]:\t %lu.%03lu MHz\n",
> +			hpet ? "HPET" : "PM_TIMER",
> +			(unsigned long)freq / 1000,
> +			(unsigned long)freq % 1000);
> +
> +		return;
> +	}
> +
>  	/* Make sure we're within 1% */
>  	if (abs(tsc_khz - freq) > tsc_khz/100)
>  		goto out;
> @@ -1407,8 +1430,10 @@ static int __init init_tsc_clocksource(void)
>  	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
>  		return 0;
>  
> -	if (tsc_unstable)
> -		goto unreg;
> +	if (tsc_unstable) {
> +		clocksource_unregister(&clocksource_tsc_early);
> +		return 0;
> +	}
>  
>  	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
>  		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> @@ -1421,9 +1446,10 @@ static int __init init_tsc_clocksource(void)
>  		if (boot_cpu_has(X86_FEATURE_ART))
>  			art_related_clocksource = &clocksource_tsc;
>  		clocksource_register_khz(&clocksource_tsc, tsc_khz);
> -unreg:
>  		clocksource_unregister(&clocksource_tsc_early);
> -		return 0;
> +
> +		if (!tsc_force_recalibrate)
> +			return 0;
>  	}
>  
>  	schedule_delayed_work(&tsc_irqwork, 0);
> -- 
> 2.27.0
> 
