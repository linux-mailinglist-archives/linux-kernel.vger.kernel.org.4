Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D0C5FD9FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJMNK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJMNKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:10:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43849B51;
        Thu, 13 Oct 2022 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665666612; x=1697202612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pIfk3Oy00TX7v4Ja7S+WJqY4Sp0YwWlVkFHQfhsmpD4=;
  b=T9TNMo+sYq3YRekRwjlKmFNTMMZcQjXHHiaXVTnM+kd2BCbZU5cEAZr5
   HvYpoDY/9sjXzikO9LluYU/MoSyH04YDslvEG9FWiPQuBpq6uZloMD/DD
   Gy+LPOjyLLiV+xjEjQfe9K+d531tvulP5rgZJnoMeuWr9ikz/TtHja8DS
   cIZYx3gKhBkuFF9Rvc3ZLN6Kcs8gViFalXt5lGTYnvHk7is55h9akzBEH
   t5KxRuXjKXNbkOqxQfiUcY3IIqCd501txVXhhGA8beZLF+1DgKYvq92E+
   iFkCMCf6zQHRgk48+gLQFVSLXtg5FoiZAJXdjreWKPHjfRGSKSioJOEJ9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="331578570"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="331578570"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 06:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="604962961"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="604962961"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2022 06:10:11 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 06:10:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 06:10:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 06:10:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 06:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfR69ZdOm7hm029fRamW9IHyKwoTKKt+0uya2iE4K8wbeiMmj1Ahxqm+l0mlurOSy3mbhh8OXIYfYntwgkjFQNydhT2zfTSw2Ng/syvuHLDq3FEA0b57EO9s0escwvzOS/JioWB0A2n99epfT0Hf6DrI/tEFvOyLBbWwzf9xO2owrUBEP2ovOeD5cWMc74FQvq1MRer/7rFjvLEQNTtr+j31N0q1qZU/9K2jH39XPjBGnaVslGkQtIcnuNJ5f/8RmIvTOk31erAKaDqjk6l1qhic+tY8ORiTdOaeXzMNcaKnS8IxWsmtHCtXahsw3YkdtaIBPFFa7XfNEueas403nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge9oaalzCRw14Tb/G7TExPjkb7af2budLxNigMHZFrE=;
 b=Rcf2Bn1bsQlUpZD7pQSOIynK5NrTtxIhRN1TJ/TzN8fdixw2Yx9hEGVyX39qEFMLkOtacwrH9QE2J3XcGrmW6SZq8c/jyR6hD9P8XdjjGEYAPG9oGUEyuSx8maeL6cnrepKPF4pfOJXcDnlhHf5XMsveis0uLtjMkTANO8BgNHo602kO4OmvNUX77JYYbeEhPWMGRC1pVbZEirUIrMqqmMsRoJ4UUIL3F3mYJ23qn9FtWXxAkv3sLwjrfVf6LoflZf/csneVDAYPmbv3E9YnbXWPcwHPvq5Lh8eJg4HZcDlEWQ2gO3qwC3UXlzMm7x3CmlFeWXeF5AdsGVWB4VjgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CO1PR11MB4868.namprd11.prod.outlook.com (2603:10b6:303:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 13:10:08 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%3]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 13:10:08 +0000
Date:   Thu, 13 Oct 2022 21:09:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] thermal: intel_powerclamp: Use first online CPU as
 control_cpu
Message-ID: <Y0gOI9hiP9NXsuJP@chenyu5-mobl1>
References: <5633735.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5633735.DvuYhMxLoT@kreacher>
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CO1PR11MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 0683793b-e3bd-4031-e3bf-08daad1c40aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8t26X/xXMSvWNkQrtyZMFxzhaB8Hh8YjwMqCqbK6c33ujFrj8LzQqB5x7jqU9c4Jn6WgWec7Kn1xsdqkvU6TI6SWbNPO2As+TkdThAtDH3bJ7brCYK5WhrV1DdXXjyaixLdTvMmAThOiNyn5eQXmopvU/VEaINflIGvk5PTNrhS/IdiilLwOusTPw7QOaPQzfvhdXz3Zl8vcgrOgr3Qa/z8HQzkm6AoJPKfoEJ1HtcRzPvtWjJoZ0DKnheTEVy8ZyYvXr+whwGPZYAp1GlJFNIADIFZPbh+BmWWBVV2h9nBcPSK/IBg+qxjfeKfSVnwPmGsNQF0Igz21Fod0rYsaBpyPeno2N9q7kL3AYaOWvmG35k1L343ffByOWpuvbED7c5is5nNj+MRXPfKBZGE4UvtYEJqYFRsk7Q0ID5VVaRRFYf7Y+Ss0jfHNlaI9sjr6l5VAkzM9N2+X3x99EnDd6bka0p1MmE9FFKYQl440KrDJjbjslv8S0Tl4uIiLJmJ4jR9J2bmg0Gpk/MuvY3DC2vp86QToKlDqPMIRhfBgG7XhP6Jb1IsO4yu/qcN9qtrF19S8GD0la5ZlT2BFemJPHr0GE+6lDsFnDNWXgAG/LXEU1oh/8SBvZnrq6if7qovcXmPKcdNT2o4X1XFk+rBP/+nJ/EYkfNAMqJNTPIOWQByJvXrm3KCQXtxV9rrtX2EunduPITtRj/R1h7S6MU5ahBADsdQIlW4jtx6yHcjm4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(5660300002)(4001150100001)(2906002)(186003)(6506007)(41300700001)(53546011)(6512007)(9686003)(26005)(8936002)(33716001)(82960400001)(38100700002)(86362001)(83380400001)(316002)(6916009)(54906003)(478600001)(966005)(6486002)(66476007)(66556008)(84970400001)(4326008)(6666004)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hwFxn7aJwukxThwoW/9azEcBjGv87UV1zhQqLjyroleVMjNxCm6y/bFcPU7C?=
 =?us-ascii?Q?QIU14qvhCA2tRGulWCk0e/BmlV9RFtbYJdgkWHvicW2X74wvKMHIHp/z/izR?=
 =?us-ascii?Q?z8Offbiq5DAREi7HuEts9vcd8/TA193NtXkrby8cY6mwQNbffmAMTpalhH2X?=
 =?us-ascii?Q?fgu3eTXF1eEOKizYwb0x6xFp7uBVIco48Etn/WnlsHVFFSliEdzHKk8BO4iR?=
 =?us-ascii?Q?RVSPUni2MtUYhpQe6WzkJzFa/eZJE/UU9QXcRmMNfMhHsTj7g25JLervTobj?=
 =?us-ascii?Q?CRdyiFFV3ZEZxV1CpnIRNJl64zJZqxgHtwC1wQGQki6TOmAdTEfT5sXH1MjC?=
 =?us-ascii?Q?mT+3JYiAZZBYFLAMaKAlx5zYm7omMBuJn9LdurhJLy95N3GqlqcNhpHY4us9?=
 =?us-ascii?Q?AyxNlzFk+nGgz6MsMVSO4uHFag52PNnjqOD1qWMvVDaqZgEf2KNc8OIC50xg?=
 =?us-ascii?Q?shwl3561Z5GdmmPPk5JYMjw/JHPmN8KqjLGTH7CDcCCdgMucSaWvx/2bFXK+?=
 =?us-ascii?Q?MXcjQ+8ub6Cm2V+5iDAFLaXDAQA0kLLIuTT5tFVv2OMgzpsray9Ko3B4ALiT?=
 =?us-ascii?Q?OJGIdPOcFKZKM/Bgm2pU1o8JEr6bKHFYshVhWzW1oByErFFxNPINtfOYOWAK?=
 =?us-ascii?Q?hks8rfsVWT79uDDScYUV4m5IaR0sNCj2/M92Qe6hFxet8XJAmIskx4/5coPs?=
 =?us-ascii?Q?IKpSmiQjSDqfv6kuqGppbNQlfMXUejsxE45Kbx7McCcddjY4Oz1NakotWh0i?=
 =?us-ascii?Q?KhRW5eFKrluj9LF54Vw+qKVt6KpK41ijsqbQ38WVtknhgPAVmizBFk8GOC1Y?=
 =?us-ascii?Q?WYE8Tc4bViUYGFfz4OYFDuao8zj/hNYBWjinJGuvCsx1ulnslfb70paNaaFc?=
 =?us-ascii?Q?vQfMA7wGKyyr0uUZz6wY9wmMsQMZd5/KlMXXeY6dlPQuqUOb82OXvPY/bjE5?=
 =?us-ascii?Q?zHaRE8JSzaBH1kJVQTDYIuC79a8qseGeVOJy9jnehw/IYZfAVQpBTeMULI0e?=
 =?us-ascii?Q?r2J4hrF5F+XwDBlmrMn18dKuoqG1uW6RybQ6n/LZFzpJEzSSGJbw2CjZDsin?=
 =?us-ascii?Q?fIptwiBYjy+1cgh2+nAQ9Gsal2EqcIrtWLnGWNaHUauRpnJsSD6Rx5faTIlf?=
 =?us-ascii?Q?MwlfI7VAIBjXCS+kgaFYEUu1/mNfTYinCuS/R/htjaITn9udE2fkADG7x23I?=
 =?us-ascii?Q?deKyuKlneicSAQBt1Me5xIzamec4OJcKECiYWvY6+tyJKqy4reFodi4kkeLX?=
 =?us-ascii?Q?nfAadWSVpu9hA2BhaEJ6UcPuC5AIX0plbGT+18iV8q2mwoVik/S1FrkUeVQx?=
 =?us-ascii?Q?xSMCBMSTnH7bmPOdYiNdLpgEHt/7hloI5qPmhNqrFvBEGuyzrgb4txA2KPdo?=
 =?us-ascii?Q?ymPZrrfeMgiDaF8CpTd5g598CfchYrO6MtnDZLRh1g+jK9SaEsGg82bkNCeR?=
 =?us-ascii?Q?FCEZHD/1L++Kd8d+qsWsyfqPdFaLawaxBWg/xyaaAOlBUG7i23wqVH8oU12j?=
 =?us-ascii?Q?1fkjJeWNid0HKyEhZQLbXR8aHLd7uYvgveRFNB/ep9Cnd1KToBB/gNywN71c?=
 =?us-ascii?Q?d1pLdEty/lY1QysXu5idOyWIA5jm6NYmqqZZLTVb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0683793b-e3bd-4031-e3bf-08daad1c40aa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:10:08.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttsjPNZ6ktfElunuNqA5CLlicnDySAmR1hyhnMYV35WhLwa4zOZZMd+femW8do54GCNRvgjjglpLbHkeFxXG5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
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

On 2022-10-13 at 14:50:28 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 68b99e94a4a2 ("thermal: intel_powerclamp: Use get_cpu() instead
> of smp_processor_id() to avoid crash") fixed an issue related to using
> smp_processor_id() in preemptible context by replacing it with a pair
> of get_cpu()/put_cpu(), but what is needed there really is any online
> CPU and not necessarily the one currently running the code.  Arguably,
> getting the one that's running the code in there is confusing.
> 
> For this reason, simply give the control CPU role to the first online
> one which automatically will be CPU0 if it is online, so one check
> can be dropped from the code for an added benefit.
> 
> Link: https://lore.kernel.org/linux-pm/20221011113646.GA12080@duo.ucw.cz/
> Fixes: 68b99e94a4a2 ("thermal: intel_powerclamp: Use get_cpu() instead of smp_processor_id() to avoid crash")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/intel/intel_powerclamp.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/thermal/intel/intel_powerclamp.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_powerclamp.c
> +++ linux-pm/drivers/thermal/intel/intel_powerclamp.c
> @@ -516,11 +516,7 @@ static int start_power_clamp(void)
>  	cpus_read_lock();
>  
>  	/* prefer BSP */
Above comment line is not true any more, might delete it as well?

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
> -	control_cpu = 0;
> -	if (!cpu_online(control_cpu)) {
> -		control_cpu = get_cpu();
> -		put_cpu();
> -	}
> +	control_cpu = cpumask_first(cpu_online_mask);
>  
>  	clamping = true;
>  	schedule_delayed_work(&poll_pkg_cstate_work, 0);
> 
> 
> 
