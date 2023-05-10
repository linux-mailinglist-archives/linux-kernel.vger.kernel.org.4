Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A135A6FD650
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjEJFnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjEJFnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:43:07 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AEB30DD;
        Tue,  9 May 2023 22:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W02Bw7Sr1H9jc291K/z9lG0AfWoKo210pM3df7QSe7kd31hHs+oxwvmL0SvLNxA0IuM9sqSPMg231qCteW0HpV/GWBzsvjN5JO5My4sn7KGxSAr2/A6dIsRIf6zBaS/BRnbRq+S1ixvMf+jmNTbars+hI+NgvA2zO0ZFsWI06sj9RPQx6frRNOOOzAq9UEnZDgK4c9aX8m0gqU0USBA9sVVTOLHeRWWX4JVz04uh9uh85mrT+0NkvNdyjdofKcHCTgEQHiQo/Jjd6W5ptKoAgYVoayqbwgVZgwF6ZS9r/XCMe99Xxmb5N+eTOVZD1eeieAUQCebrFiZ2Jj7iXOvN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeC70209pRvkUt3Mkr2qIpLSyoAAtNsMpcCrULE7aAk=;
 b=UyQuxcRDZoJ6Mf0ywDEHlvxnvwiAD7tNtYuN/kzzlT7emcvOSDGlVLaC5PYkDcGhGjGIJ3kWbuidPhxG1+J8DwNkUdZpXvvDaVRQ8oBhDFgKBczf2RBe/A/Oa538r1dPa8StfLQQgiZxDBNA9siDfRCTvGOZKKxqqbigGSE4WKcdifbmT4felizTdh+2t3wGDo+g/EUDKDQF9kWNAGsLRPGCi8xzYW7C6gL06UK2s+s/arHsZnb7T2jn3+f2dX7KdxP4EaJbwRbZa/65G39JBsOGe978BuDI2O9GEneAHJCl99Hq6fuznpWZteXYC+JjgpCC0lQo0E7cChGtjTfBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeC70209pRvkUt3Mkr2qIpLSyoAAtNsMpcCrULE7aAk=;
 b=Mvdol6gHqhagZP8xPwsn4BEmINqB+Jy5eMmBCM0R4eUsTpVhoW2j3qApEhU8ecNeom0YRSaKttkQceowvAKAkt9GNNonpi+3X7X7hvyouWi+ZQ3L+/cKKJycTrDOBEGAb4ylR0qaiSxyvsvAZgCXLfLJJfAI8NbFofIGjWJ2SQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 05:43:03 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::f4d6:1b23:560d:4022]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::f4d6:1b23:560d:4022%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 05:43:02 +0000
Date:   Wed, 10 May 2023 11:12:46 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ray.huang@amd.com, viresh.kumar@linaro.org,
        srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        joel@joelfernandes.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq/schedutil: Remove fast_switch_possible
 flag if driver doesn't set fast_switch
Message-ID: <ZFsu1te+HoKB3drf@BLR-5CG13462PL.amd.com>
References: <20230509180503.739208-1-wyes.karny@amd.com>
 <20230509180503.739208-2-wyes.karny@amd.com>
 <CAJZ5v0hN7AxkSf7=8-xP1Pb_7bA2Ba6nGUiK45q01uo_MFa1qQ@mail.gmail.com>
 <CAJZ5v0gb9TpH1qCqhqAb28c7uRRk8=iufTkzc5aCpC=OJm8QaQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gb9TpH1qCqhqAb28c7uRRk8=iufTkzc5aCpC=OJm8QaQ@mail.gmail.com>
X-ClientProxiedBy: MA0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::9) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 177a4ced-ee3d-4c9f-fc6a-08db51196b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnI5g1ZNab07sq7DqMSIHryHRjTwrlKEaWKRNb7X74062VqB3fZ2lgoGF7+HvEYu4Ec633s0XzaJDVpMWCsj5lB4ZZfcPzIkxYtRjLYzlH5JdKewsd1g2GaIIx9YgTwOY/6RPbaAMJOxO5wwcPEax4Oorr8+WhKUssqVmJjFqwrLH4WNAywWFm7pHcypI6RvaucV+kWMmQacKE+mKrHbIwJtmlu9Xijus/c+9CRlboJJ/5TByKmquZkmLMKu4c38R7JIzeC86nO9ua69HFDwONSLoRCYf3lkMO2+6fGzbcfeV7z9Re17EfcP3rwHiidvwVYH2ixd1N2lq3qlmlIP4E3XKQrmZ7u/m49Zs363Vtlm0fXN2zpTkP2U6HOqislsdWU+UyekRtGs+v5IiJfhxo96aa2dmUmnQCm4KbHjVLsiluEsm/Qc1M4dnVeVfywZdcAvdSJ0PLIrCCbTiixueMUl4qJaBhccVL27f38MEQ16Pwd4a9OJ3Rp3Na5Yh4Q8H/nswP7WSkZjGXBCQcmrTb4mbDg8pBiqzkrijdbVdb0HYwyuDUdUsRIe/zCONEfRSCEoYjDxLxPS3Fwx8FyeD81yT3NibcFLUKdwP3DgZn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(478600001)(66946007)(66476007)(6916009)(66556008)(6486002)(4326008)(316002)(6666004)(86362001)(26005)(186003)(6506007)(6512007)(83380400001)(41300700001)(8936002)(44832011)(5660300002)(2906002)(7416002)(8676002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0RYxKBUD4ceZO59QM4QSDwAUWGTmdU3jux0cZvqqP+X2/NvqekLBavcTIu9?=
 =?us-ascii?Q?+LUcb0e+jnoTQk1td5rpXnIENBQEnPuvlFhnUMIH2PPA/nztE4Kc1WS9QwY4?=
 =?us-ascii?Q?1ieDB+NBTfGcHXVlEvPiQu+W29Z4cLbZ3OZ/zRV1xt9phnPkY27TYEymkvvR?=
 =?us-ascii?Q?PUDDN1g5ofIqaODZgr+8mkX1vutGrbjf9G6wSJRbVIAupayykGxzHayw8LfH?=
 =?us-ascii?Q?ItED/0MYFcmXq4jNN7fPPWWqMCdqAcgdvb3TpmihHL6Bcz8O7X2Aux1Mvcum?=
 =?us-ascii?Q?VGDyLfnti6d3Wp2sfTQtCL5Xn88AyISIjetnDNQaNcYeN9LxeO9BSAzap/j3?=
 =?us-ascii?Q?QmD1w5pfC/cKmrdeSNL/AigkHPo/JhMrCEG79ZPgdVPzWj7j+8c4Yc6UkfEw?=
 =?us-ascii?Q?/+f4iqET+I1R4hGOeIh4StZqnBmWypybeST+4tbvf4gSZe3ivNi3giX48NGS?=
 =?us-ascii?Q?REmhXtC0qswDbqSdmgGHZmmKLZLNbaqcRgrjsgeNvIyLZf1OF27iHFzr/kcH?=
 =?us-ascii?Q?hXzueZTJqZWAHPhYTO7qNp1qbOA4XxyDDK4NZpg3jpSOXPqSxBoxpwawjZRw?=
 =?us-ascii?Q?NrMQqF5UDhSag4Oif1iCVFJmhpyTpEA1eavhj6cpaFOaCzjppxB5v3sShmux?=
 =?us-ascii?Q?FH/A5tl9jSmOq22DGU2Do/8wO+74ILDROupeyGSt7v7yg3hPlWLvGLhk1W77?=
 =?us-ascii?Q?luXkwXY9PRdg6KeTCyfBXsWYeiKgFhGVQEIGO3HgX3wSktv7D6bBRYezn606?=
 =?us-ascii?Q?Go+P6qf2Ab+ThUzVvtSG3mamYQx6AuPngxZyTHRoZK+lNwWjiSHv1TZNucBM?=
 =?us-ascii?Q?zNR3Qk1KhdN+sjdWh1Iv6piHYb/TbIOFSaLaHE7fNvL+9CVJMHgnSMIccmhL?=
 =?us-ascii?Q?sjszXiXELZCDGLHbygZdh8ILNf/0iRE3b02P4VSenoW3AjAE49pXcy0tqSgX?=
 =?us-ascii?Q?ZSnh+FN5I5S5NnzlXBD/ynIXKGxvWq7SiWkAXSzYu5anDZcWheX2dScUfxnO?=
 =?us-ascii?Q?sva8+l0ywhjYCa+lO4IPqKb/bjNXeWF4Ow72A3fE1pUpxVXe2gtvBLaZ9QwK?=
 =?us-ascii?Q?gDsyegii/0eGUkZdP4hiLjeBmgxAUae54jvwJ/4MWNX6yqB+CWvTHQhMeVje?=
 =?us-ascii?Q?HxrJXfWID8o3rlqt5hWuqr6/n0JZzbRanzT4C0VJZMkH+UuO5IOA0gcuPjGJ?=
 =?us-ascii?Q?mLI5ABqDlj/xoUn83gvHQ+YUhXKZtsy0JKgF67y5Jfm74yVyKKBDVacMq3Nw?=
 =?us-ascii?Q?PJW2M/9zktRdF0URSnVM2ir0bwOG6fHxcI1JPAzT95V5YWhRM7ea5nHpVy3+?=
 =?us-ascii?Q?DFM657QsjzNyM+UddJXECnZBlLWfnjDRilQkty2Z4QtjOvqOw+PmbGRVYrna?=
 =?us-ascii?Q?6fliLpVAd9tNieKhSNMqDZcY91PSUFX53uDPebQMfPzXvVZI7ogxPUvWqhRv?=
 =?us-ascii?Q?4kPs3xOnAvQjJLC1aghAupxTCzTNTG7DUwv9FVamgkzUWVhiL32zRCGIRmg8?=
 =?us-ascii?Q?uZQNr4PHQBpYO8S+kEVSenUu0R6xczxr5eEIFoxoyOKJ5r3FVLzO3PJgP4M6?=
 =?us-ascii?Q?6ttkJXCaI1fN3QG5XbIxQMRcgdBiihqVeFYP7P5H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a4ced-ee3d-4c9f-fc6a-08db51196b77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 05:43:02.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBgQmcEgV8Cx0ZntpFj/+ezTSM9nZFhNG6ySS29+V84B0vELBa4rgihCAvOQ7MDIlJbawhH9kUq6lS/YrP8tJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Thanks for reviewing the patch.

On 09 May 20:39, Rafael J. Wysocki wrote:
------------------------------------------>8--------------------------------------
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > index 2548ec92faa2..007893514c87 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2698,8 +2698,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
> > >
> > >         intel_pstate_init_acpi_perf_limits(policy);
> > >
> > > -       policy->fast_switch_possible = true;
> > > -
> > >         return 0;
> > >  }
> > >
> > > @@ -2955,6 +2953,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       policy->fast_switch_possible = true;
> 
> I'm not sure what this is about.  Is it a cleanup of intel_pstate?

This patch intends to remove fast_switch_possible flag dependency from 
drivers which only use adjust_perf as frequency/pref update callback. As
intel_pstate and amd_pstate driver has only adjust_perf and not
fast_switch, therefore I'm removing that flag from these drivers. But
intel_cpufreq has fast_switch therefore, only adding that flag for
intel_cpufreq driver.

Thanks & Regards,
Wyes

> 
> > >         policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
> > >         /* This reflects the intel_pstate_get_cpu_pstates() setting. */
> > >         policy->cur = policy->cpuinfo.min_freq;
> > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > index 26e2eb399484..7a32cfca26c9 100644
> > > --- a/include/linux/cpufreq.h
> > > +++ b/include/linux/cpufreq.h
> > > @@ -604,6 +604,7 @@ struct cpufreq_governor {
> > >  /* Pass a target to the cpufreq driver */
> > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > >                                         unsigned int target_freq);
> > > +bool cpufreq_driver_has_fast_switch(void);
> > >  void cpufreq_driver_adjust_perf(unsigned int cpu,
> > >                                 unsigned long min_perf,
> > >                                 unsigned long target_perf,
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index e3211455b203..f993ecf731a9 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -776,7 +776,7 @@ static int sugov_start(struct cpufreq_policy *policy)
> > >
> > >         if (policy_is_shared(policy))
> > >                 uu = sugov_update_shared;
> > > -       else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
> > > +       else if (cpufreq_driver_has_adjust_perf())
> > >                 uu = sugov_update_single_perf;
> > >         else
> > >                 uu = sugov_update_single_freq;
> > > --
