Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8A7007DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjELM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjELM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:28:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF5F12EB8;
        Fri, 12 May 2023 05:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIXRwv60MuGfh1vdMkG/7zpadtGRvWkpdc1CWql+2LUredUGAoDMrJoOndg1HUV01QMtlPr1zm4S/4Ap3GmNCFzJTDAx5cg+t4FLxgJuI3q3T1ehhhVbDiPGEEG7DwJ167PmGTTRWrVSigzKfAzNLD1IZ3uTcV8LdUhdrrigoSWNEJU0id9kfZhtBcbVqZnLmNoMd7GG70V2Mrl+9jZnIHbnRRyOJGy/5kY60YqTVJ41xSfisF7shrTm7B/KJbRFxwynj0Eyfa0Xr8FD+fZok63suq2mnIOzo/aenNbukWM/UcQlV/yeuL+dqmmFcxrQuCAjeJNh4GClzyo84wyWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToFXQ6NTnu9riPp2zcm+7r52i/p7O+GKSK9Rl6zcVaA=;
 b=hG9tchGtHUjlkAhpOUqUIXdFqoqL9Ra0uOYqHgPZ4J/SGq6extXS5RM6IbcMIhq+DJTaulYkjpSxhVdU3EXHDCEhm+E3eqkkq6V1dtc59ztaHMn1XLwTRvYh19/TyJKU86dWN6MWQ6OJM3A5rmtpmvb4Tzyw1WGDLizjzySRUzu1nv6D0cYEzjJNrbjhLnkMyXoxwkerEzzBNHIn1+4Gf5W7OEcWG6MoQDhHYEl8JkSjZfMwhAZdd0P2CjJJB19Vb6AGOE5hiSmtdIUYW5TScezk3HzMXTA3I7XfC2i2bfY8/0s1y7xJLqgl9h30zIIkfsK3V7UmKX3iFOUuGcKulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToFXQ6NTnu9riPp2zcm+7r52i/p7O+GKSK9Rl6zcVaA=;
 b=QlRVfCVzk8IhsJsjwalWeqCpFHy065U+pskUZ/oKtTwnn7DzX8sHdu1lTYDSEdATVkQJZULMEUdHu/jCzO96pKuJRvp0hwx14C323QGssXmdRl9r96aDah5b23Mx8FOhK+wd5Zvqv+r+f7LbZ8WU4n32ixroJ+zTZHRLLFd1rg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 12:26:25 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::f4d6:1b23:560d:4022]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::f4d6:1b23:560d:4022%3]) with mapi id 15.20.6363.033; Fri, 12 May 2023
 12:26:25 +0000
Date:   Fri, 12 May 2023 17:56:08 +0530
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
Message-ID: <ZF4wYIgmFCbo1Kx+@BLR-5CG13462PL.amd.com>
References: <20230509180503.739208-1-wyes.karny@amd.com>
 <20230509180503.739208-2-wyes.karny@amd.com>
 <CAJZ5v0hN7AxkSf7=8-xP1Pb_7bA2Ba6nGUiK45q01uo_MFa1qQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hN7AxkSf7=8-xP1Pb_7bA2Ba6nGUiK45q01uo_MFa1qQ@mail.gmail.com>
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b79041-c360-4694-b859-08db52e41a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pki2o48OR5ziW4isnyDBHJLqWY3A1FrLbzc/HGZAJwI19zeYquCTiY5MlmUnxd3v5mIhSK5DIcXYKbypy9nbElwvcMDDy9UZd0XuFAs7SLpd9q3wHN3ZhsWSdgEhDATEB3BGbBRQOZOZKbVOT8cGBp/iIVf6AokHRipJ01XlX86WKY0vKd1gpYiKiW3s586epoi4v1a+a2AW5qVToBK4zhknvFNVfxR9JiAdF6e7EBpldn+yl/DarQzl9ctikaWoJuurfW+Eoyhznc30DjNQXEklgrTJmtrKsMniVSu/W56cnIfgLqH1GvlKC4Bj1s5+EmPIUawo2WlzD5Wd1P/HROtWTVEMrc4ojtA1NLGqIrseh9ExqJtrcx51RTpnmOvD/ICIoodxR9jBq0Wy5QiPaXw+S9L+KNVPTOsh38rAsZj82FBz0Qi8cM7MamQOArgD1EWYjkTmt43XpX1gIz9z+Piz2dt/N34zTQL6P2L9BO2idBhVbqPh3AwWtGBSgfDZJMMswl6K1wiIDWlruaAB/hylSJzwFhDrMB2eQbdwrQDkRnUVtBcfdA3ufm1TowvMNG2LXKXGZeMzLG1bPOLzkbJvaaL7jWqwA7+Q3HkYwsWU6yKzF4jShF8Z6/JMytnW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(53546011)(5660300002)(26005)(6512007)(83380400001)(186003)(38100700002)(6506007)(2906002)(44832011)(8676002)(7416002)(8936002)(478600001)(6486002)(6666004)(41300700001)(316002)(86362001)(66556008)(4326008)(66476007)(66946007)(6916009)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHc0OTZpZ004eW9SOCsvZmJIbmRXRDVaaXA0R0JVU3lQYzROK0FoZmhRMVZH?=
 =?utf-8?B?bzliYmpQYWdGWGM1TmVDQ3hyZjNNSVZaMGNETkY3V05BdkNTQ3YvdkdYZDVw?=
 =?utf-8?B?dUpMZ3A0UXVmVlNVTTJyVjg4VDZsRGszb1FvYlZrYkNxUzViUFVKbU1Qb1kw?=
 =?utf-8?B?eFVQdzBuQ2lDekVYcGtYK3A4MEE4TDJ2SUEwdDZBaHpQckFjZ0xPc3NEamRs?=
 =?utf-8?B?eWVYendYUCtmZ2dwS2Z1bjJvdGo1cjVhWFdoNitGM0dHM0EycUxqQjhMbVN1?=
 =?utf-8?B?Q0c4aGlnbWxQcEI3R08vSnhtVmxKVkVOTlpsSmkvT0d0TnJJR3FnM29ralhx?=
 =?utf-8?B?V3A4aXR4dW1CNnZQNnBTOUtWNHJQVWY3UTdJNHpmemN6MVF5cTFBM09DSXY1?=
 =?utf-8?B?cVJzczJlQXdJaVRQVWhJd0NzeUJkejJVZ2VCT05iY0xNVFJvMGZHcWpzTE9Q?=
 =?utf-8?B?TDRZcEEvU2U2b2wzNXlGVXV1azl4MGdtb0dWK1BQbm5FYlFEOFFOWktVeUpP?=
 =?utf-8?B?TjR1RUlCTEVpVGJRNjJ3SVpwNkJUR2NpRkoyUnBzdVFqM0tEdGN2Q2dMQnlD?=
 =?utf-8?B?aEJkOTZhcmJkMG5pUVFIRDNod1pyWmlJZjhLU0g5cXJYSm5laGFkbStGbXNT?=
 =?utf-8?B?Um9LTTJZMnFQMUYyZTlEUmpPR3pCN1RIcjVWWmlrSWZrVUFxdVF1UjllY0Z5?=
 =?utf-8?B?TSs4V2JsNk5ZZXBpL1J1UEdNSkV0c0wwQ2pkSGExeGJMWEZ3dEs4Ri9jY2V0?=
 =?utf-8?B?bW8ycU04YUpzbDJENHdCb1Y3MGxDTCs5MVVmVysreGNMNzhVeGJpcmFPRXpG?=
 =?utf-8?B?S3lQaUd5czR2N0RmcVJIblhUTlZTVk1Ja2Y2SFdBQTZIWW5HTmZtS3ZpOU5k?=
 =?utf-8?B?d1RoQ1B3SDhVb0JLSTZrYW5PUkpkdUM3Nk85SmlQMnd2RzJZcWF6SXluTGkw?=
 =?utf-8?B?OUJtWTdzaVhwMzRSdDkzOWdlTEZ6c1puRXJSSnNlaXZKSnRXb0R5NzFtWGpO?=
 =?utf-8?B?U21WK2RxWnRJT29xWTE2UXU0ODRnQ0xzd1RMc0o0MTFOZ2Y3TVNNM0phMy9P?=
 =?utf-8?B?enozK0xEcTlpMmZtMXFpYlhSL0NVZTJ6Um1SeW1oZnZsbnhQclliZ0R0LzZn?=
 =?utf-8?B?U3pLdFRONWpISDZETXVoVm9mQlBuSkMrd295LzMwSjdiaVQxeER4YWtjOENG?=
 =?utf-8?B?cVVKWjlsdUphN21pRWplcTROck92bnc0MXFpbURDZmVvd0l5bXdUdnlKSHY3?=
 =?utf-8?B?V0l5OWRPYnZiaWFqZjVtdGRQMFNlZGp2OG9tU292Q2ppK1hzWVlqNHJKWW9u?=
 =?utf-8?B?dGlFTGpUSDVKb3FrQlVuREpFbU1mSGhYNGdSYy9HMmtHYnBZbWo3bnBISVpn?=
 =?utf-8?B?c1VEK3NRZXVzZ0tOM2phMUpqcVc3K0ljS3RFTGwwemREbUc3Q1BWR3ZOU2Jo?=
 =?utf-8?B?MTV4ajBFKzNMeXF1R3Vhd1pWSmtBQm1kdXovbzJ4U29SdjZwTUQ2Y0h4OG15?=
 =?utf-8?B?eVZ6UmNRTnZJVjI2d2ozWnJNVUZxQzA1ODJaUnV6VnhidFo3UmY0QkJkRE9D?=
 =?utf-8?B?SDJISEhDYUE2NjFEa2I0RTNYancrOWpnSFlXbXRLMTJpMzV2K0phSVRZM1ZY?=
 =?utf-8?B?VjhYRmliRW1NVVoxWTh6cVFhTlFxVEVJZzBXQkdNcGFwU0lJOTNSakxDSjND?=
 =?utf-8?B?M1BuaGRqN0Q1S3NKTkdDVW04dnZjczZzejlEdFlUN2lhYWd6WU1rdkNTQVJB?=
 =?utf-8?B?dWhsTUFnWVFkc0RWcXRUQ2JiNXNxNHphMU5XZUpnd2VweWNpdDYxQjVIUzh2?=
 =?utf-8?B?ZXMwanBZdFNJK0NGOVZKN3ZxNXROUUNoUXV4WlNVYmZNUU1hejY3V2FYa29w?=
 =?utf-8?B?NzJyVi9ZSndPUERhTWNMSEcrZmFZOTIzaFJScTNuRW9mT250RlF5NnYzVU5j?=
 =?utf-8?B?cnhkb1h2WjJpaGduNkJaZG1NSTROMm1JZll6TVBJSEU2L3A5WldjM3VRTExR?=
 =?utf-8?B?dTkwMURTTnNFdngzY01FUnhiTTEzdVNkbWpaUXpOMGVpL0xONVZudkxXbk0w?=
 =?utf-8?B?aHdNZVNyY2JGM2dmNnkwNnVrcGIyc1NBcTdzdXpFekxkdzdMNm44aEpXTS9N?=
 =?utf-8?Q?shJAwgwUea3fzrquIMA1dtkqq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b79041-c360-4694-b859-08db52e41a05
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 12:26:24.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcPRIHsD0bKekgH4xyQFPoz88+MnWmMkeEP3VOWTtlxBy1+O4o2Nw5cIsprZw8dQWrOAYE3i6HogASflF3nToA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080
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

On 09 May 20:18, Rafael J. Wysocki wrote:
> On Tue, May 9, 2023 at 8:06 PM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > The set value of `fast_switch_enabled` indicates that fast_switch
> > callback is set. For some drivers such as amd_pstate and intel_pstate,
> > the adjust_perf callback is used but it still sets
> > `fast_switch_possible` flag. This is because this flag also decides
> > whether schedutil governor selects adjust_perf function for frequency
> > update. This condition in the schedutil governor forces the scaling
> > driver to set the `fast_switch_possible` flag.
> >
> > Remove `fast_switch_enabled` check when schedutil decides to select
> > adjust_perf function for frequency update. Thus removing this drivers
> > are now free to remove `fast_switch_possible` flag if they don't use
> > fast_switch callback.
> >
> > This issue becomes apparent when aperf/mperf overflow occurs.  When this
> > happens, kernel disables frequency invariance calculation which causes
> > schedutil to fallback to sugov_update_single_freq which currently relies
> > on the fast_switch callback.
> >
> > Normal flow:
> >   sugov_update_single_perf
> >     cpufreq_driver_adjust_perf
> >       cpufreq_driver->adjust_perf
> >
> > Error case flow:
> >   sugov_update_single_perf
> >     sugov_update_single_freq  <-- This is chosen because the freq invariant is disabled due to aperf/mperf overflow
> >       cpufreq_driver_fast_switch
> >          cpufreq_driver->fast_switch <-- Here NULL pointer dereference is happening, because fast_switch is not set
> 
> So you need to set fast_switch.
> 
> Please read the comment in sugov_update_single_perf().  It explains
> why adjust_perf is not used when scale invariance is not enabled: the
> mapping between the performance levels and frequency are not generally
> defined in that case and it is up to the driver to figure out what
> perf level to use to get the given frequency.  And this is exactly why
> fast_switch is not optional: because scale invariance may be disabled.
> 
> Please feel free to update the documentation to clarify this, but the
> way to fix the issue is to implement fast_switch in the driver.

Thanks for clarifying that fast_swich is not optional as frequency
invariance could be disabled in runtime and this would cause to select
fast_switch. I'll make those changes.

Thanks,
Wyes

> 
> > Fixes: a61dec744745 ("cpufreq: schedutil: Avoid missing updates for one-CPU policies")
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/cpufreq/amd-pstate.c     | 10 +++++++---
> >  drivers/cpufreq/cpufreq.c        | 20 +++++++++++++++++++-
> >  drivers/cpufreq/intel_pstate.c   |  3 +--
> >  include/linux/cpufreq.h          |  1 +
> >  kernel/sched/cpufreq_schedutil.c |  2 +-
> >  5 files changed, 29 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 5a3d4aa0f45a..007bfe724a6a 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -671,8 +671,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >         /* It will be updated by governor */
> >         policy->cur = policy->cpuinfo.min_freq;
> >
> > +       /**
> > +        * For shared memory system frequency update takes time that's why
> > +        * do this in deferred kthread context.
> > +        */
> >         if (boot_cpu_has(X86_FEATURE_CPPC))
> > -               policy->fast_switch_possible = true;
> > +               current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> > +       else
> > +               current_pstate_driver->adjust_perf = NULL;
> >
> >         ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> >                                    FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> > @@ -697,8 +703,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >         policy->driver_data = cpudata;
> >
> >         amd_pstate_boost_init(cpudata);
> > -       if (!current_pstate_driver->adjust_perf)
> > -               current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> >
> >         return 0;
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 6b52ebe5a890..366747012104 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -501,6 +501,13 @@ void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
> >         if (!policy->fast_switch_possible)
> >                 return;
> >
> > +       /**
> > +        * It's not expected driver's fast_switch callback is not set
> > +        * even fast_switch_possible is true.
> > +        */
> > +       if (WARN_ON(!cpufreq_driver_has_fast_switch()))
> > +               return;
> > +
> >         mutex_lock(&cpufreq_fast_switch_lock);
> >         if (cpufreq_fast_switch_count >= 0) {
> >                 cpufreq_fast_switch_count++;
> > @@ -2143,6 +2150,17 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> >
> > +/**
> > + * cpufreq_driver_has_fast_switch - Check "fast switch" callback.
> > + *
> > + * Return 'true' if the ->fast_switch callback is present for the
> > + * current driver or 'false' otherwise.
> > + */
> > +bool cpufreq_driver_has_fast_switch(void)
> > +{
> > +       return !!cpufreq_driver->fast_switch;
> > +}
> > +
> >  /**
> >   * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
> >   * @cpu: Target CPU.
> > @@ -2157,7 +2175,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> >   * and it is expected to select a suitable performance level equal to or above
> >   * @min_perf and preferably equal to or below @target_perf.
> >   *
> > - * This function must not be called if policy->fast_switch_enabled is unset.
> > + * By default this function takes the fast frequency update path.
> >   *
> >   * Governors calling this function must guarantee that it will never be invoked
> >   * twice in parallel for the same CPU and that it will never be called in
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 2548ec92faa2..007893514c87 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2698,8 +2698,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
> >
> >         intel_pstate_init_acpi_perf_limits(policy);
> >
> > -       policy->fast_switch_possible = true;
> > -
> >         return 0;
> >  }
> >
> > @@ -2955,6 +2953,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >         if (ret)
> >                 return ret;
> >
> > +       policy->fast_switch_possible = true;
> >         policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
> >         /* This reflects the intel_pstate_get_cpu_pstates() setting. */
> >         policy->cur = policy->cpuinfo.min_freq;
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 26e2eb399484..7a32cfca26c9 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -604,6 +604,7 @@ struct cpufreq_governor {
> >  /* Pass a target to the cpufreq driver */
> >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >                                         unsigned int target_freq);
> > +bool cpufreq_driver_has_fast_switch(void);
> >  void cpufreq_driver_adjust_perf(unsigned int cpu,
> >                                 unsigned long min_perf,
> >                                 unsigned long target_perf,
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index e3211455b203..f993ecf731a9 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -776,7 +776,7 @@ static int sugov_start(struct cpufreq_policy *policy)
> >
> >         if (policy_is_shared(policy))
> >                 uu = sugov_update_shared;
> > -       else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
> > +       else if (cpufreq_driver_has_adjust_perf())
> >                 uu = sugov_update_single_perf;
> >         else
> >                 uu = sugov_update_single_freq;
> > --
> > 2.34.1
> >
