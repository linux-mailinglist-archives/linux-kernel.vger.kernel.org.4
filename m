Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3AA710599
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbjEYGOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEYGN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:13:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255F7E6;
        Wed, 24 May 2023 23:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwKhXT8tQT/8gGaXS7D+hE11DViomKVso95bZfjB0uTYDe5pYRECtV7xpgz57bU0FOmaKJsKpRS+dTimSWl6+OL2x6BnmLTbDixcqZnU9i+bz4rCMfGdZaHpp/aoSEI6/ULZj7gTGOfyozEzyibN4oJMiAD6bpbt+Me2xMDpl3jy3Zl8a0sPTOPbpkh9twZEuCmDzOzaOWUO+oi0fIZ1b3oGbpSsrAffEEW6AatVi6uF59y9FqBrovaJqGpA3ic0V4CjIIP8u+zM67OQ6hvtTCG1DgRTZb3yadrhvZvL3bNPsfg2zuEHy+bK8TDxFXjlPcy0F9E9sgdzImVkKaSvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKk+MEZTMtog2jfSaqGAO7TwN+PxRJMuwFPB1rPBJB4=;
 b=HTACLB366mhfquqApjYFOOS062COnqRSr3zBcq6WN1JPw5Y7vEtlrbUN6NNP2/EYfCPHtF9V7E0CjlQcpuxhVVDztegCt0dYADkKsDGlp1t4LkoE22Gdceeha9BUTDmJfjtMgPT3kI3KIj/1y9OVJaXlkLpCw94mpBFBoY6KMnxF9t27L/XRHgtAjyCuj1h6OFwWemyDwYar3qwybnM1UvOL8dKNz3JHxXQrRoG74Aw2MbQ32Zg2oAsTBVLdGIrJLphDNBqnmWdJRnk1VCIoxtTHxj4qgtOoZ4Vsq+r7yISCtV7YvFfL8kj+9XhXZM2jRFwZu9lRtiEIZBH7wmrxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKk+MEZTMtog2jfSaqGAO7TwN+PxRJMuwFPB1rPBJB4=;
 b=DnAgCC25GK5OGfHu/4RzP+0hlbbzB+ZkSetSmmvYXIFsdajUMKgv7LYLLLyGS7k1NEfCK5k6x3va5thDgjoeigEUJdU0eZXhpEEJlP+1z8rjOJJ2TJRiCUptSGbsfwr1AF7Rw9EbkxiZnFR4dK/phYpepnh8tHyPfJt5FoMDDOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 06:13:54 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::ea49:6972:7c9e:d7c2]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::ea49:6972:7c9e:d7c2%5]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 06:13:53 +0000
Date:   Thu, 25 May 2023 11:43:39 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ray.huang@amd.com, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com
Subject: Re: [PATCH] cpufreq: amd-pstate: Update policy->cur for adjust perf
Message-ID: <ZG78k9dOJS2vauEP@BLR-5CG13462PL.amd.com>
References: <20230518055819.71585-1-wyes.karny@amd.com>
 <CAJZ5v0iR0tvS74s+EnzaSN-7urAWZGPgOEF4OTgaKgWNFueOgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iR0tvS74s+EnzaSN-7urAWZGPgOEF4OTgaKgWNFueOgw@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::23) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: dd20b785-1c1b-4a04-3fe0-08db5ce736bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNw8HcYjC9YP6TPgr5FCQ15SWlEbFvlgQ00zUobutg99GJphqAuSknQ+0MSNwkig7JVYCWMWw34fBUfZl/AVIqclWIeZ9SUzcO8R1TidgbvMbko/emJ8ZaldyTs3NaPyk3ocbcqwy4CRL4kTYZ+riATraVodqH/Xr5zZJWYgIimMSDQ7mC5p6P3QILXy/ibcodKSHMk/mMHrQ+KePPIn5Tw0k8BJIVaGqWNSDQlzjYJGRV4nqqyk1U5nS1YH/IN0GcteL30MIM00QIAEJyo7GA9pVftoR+vYTEr63tqCX0tES5AKy20rWycf9qqX2WX84NBkzo890tdE062ViiB/NpTVIG9ScOJbHxRQOk82fDbtydrISOsYnJCntSEeWoYEPwXOI59hx/OGQDcCFXX6VHr+1X6fpsq9r+ftYmrWlftIeKyeFCSFLUt8b8imT1oLZXpRCdqnz1M70mV1A0N0RPO0lNHzaiYYtPyWz/fzh5LrGfHoflV94oCQN3KjMvDru129lVXWBPNHPGqkS3VqTCJlJL85OJdL+5q8lyO0iCRVcng3CSdH7uM9M5Y5znYy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(66946007)(478600001)(6486002)(4326008)(6916009)(8936002)(6666004)(66556008)(41300700001)(66476007)(8676002)(5660300002)(83380400001)(186003)(53546011)(15650500001)(2906002)(316002)(38100700002)(86362001)(26005)(6512007)(6506007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzAyT2hIemRuMDFIVFVjL1RucjdMd0FKZStzdmhuTWdNcXQ2ZURQSVV2aWRs?=
 =?utf-8?B?UUwrRlBiSlNYYzViWGUxZEpqR29kUXV1dWxhbEJxVlJnTlcrYlhZUzNMYWJ0?=
 =?utf-8?B?czFYNkpCWm9oYzM3V2o2bFhiUGFrM21IR3daTk04Q1BsL3RhOUZCRFVRTDBV?=
 =?utf-8?B?cVA1RlFSZmJIY2NBTG9lcW1jZHRSdDYzU1ZqV0F3NHFmQUdvcHkxc2pPOGx1?=
 =?utf-8?B?eTJSZEo2a1BHcVN3ZTZpMTJNRm05NFhibWNpU3hLa2o1MGY1VytEamNwNTJH?=
 =?utf-8?B?ZGlQUktxRTYyOXl6NjFORjRMR0E0RGExOSswblJBdDlPdVNXNkFTNjBoUUZ4?=
 =?utf-8?B?TVU5ZkV3SXpwT0k4N1Y3ZUNhdklUQWxGb3BrWVB1Rm16ZVJpMmdTWUl4ZDA2?=
 =?utf-8?B?NU1MdVBKOGpTSzhmV3pIaDBrSzJwMGphc1UvbklCcXdEd0ZORHlKWW4yS3N1?=
 =?utf-8?B?L1dKbzVLcE9HdVUrK0MydWNNMWlaUjdBRVpHVE9PMkh4a3V5QTZscFBtYkUz?=
 =?utf-8?B?SFhlT0RmZUMwSWl1MzhFSDJ5THpENy9EQnlldXVpSkIvTTZ1U0R4Ym9SZjhJ?=
 =?utf-8?B?NFM1WGxiU1lnVjlZMmZuUUhUNk5KV05FNEIwV092R3hVRi84Qm1BWktZenVM?=
 =?utf-8?B?eFBKQ2taREgrOTRlUmRJRTY0YmVueHhYUkhpU09qUE1OV2krejE1ZU9sRFdM?=
 =?utf-8?B?RDZXM21TZHJKTU0vZGI3cEgvWHFmUUo5QTNZZDYxWTVZK1IrUVNEeFI5ZnRw?=
 =?utf-8?B?QUlweGRPNmxheXJScldWU1BzcGIxLzNLQlI1WnhWV3Z0dGFUWnlhd3VGK0ds?=
 =?utf-8?B?aHNHUDFZQWcvN0ZVZjdLZnpSQTQxR01QMVFEbEVtckV1Sk5Ub2Jjd0t1OUlV?=
 =?utf-8?B?TXFPY1BEUWYwZmdLQTJINy92a2IzYmx2NmtpdEJDMG9zT3puMnVwWE1qYjd3?=
 =?utf-8?B?YVVGVXNlQ2k2MmZiMEdyaVBtb1BZdlRmSE9hVWQ0Ly90dndGcG5VRXpFa2lo?=
 =?utf-8?B?TVlHQzZOdHNiVU1ML2x6S0ZUVk4zS292Ri9nQjM2Y29DWVoxODNMVVV6UHdY?=
 =?utf-8?B?VUZBeHJ0OWdrWkJmZnJBVUhwTW0wZStaVVVUZEpmYzZXU1lqbENhN2FyL3NS?=
 =?utf-8?B?Mkp0Q1A3ZTgzQWIyS09UMk1nWlNkM3JsdUFGYzE1RTJ3SUlkTGVnM1NJN0R4?=
 =?utf-8?B?Ylc2c1E3NlA5QUs0SmZOOENWWnU5TUhlTEwvRitWZ0RNcTJHaUtmRTg2eXlh?=
 =?utf-8?B?WDNxTEpuTElFcjdRK3NrdmtGdTdtZkJXeEMzZmkrNGlYMDhQUjI0cGZhL2J1?=
 =?utf-8?B?UWpyR1BaK0FxN1V3amI1SkVlRkdtM3hEK2VubVF6MW9jZ2ZrRC9PZTlIbGhx?=
 =?utf-8?B?Nmc4c3U3VHhqYkFsZUtsK0l1RHVsaW1rRyt6RmdFY2REM3NmalIwK3g1OEw5?=
 =?utf-8?B?ODlVMWJaUnUveE5ROWZId0JPYXMyWlQ2N1ZKV0dxOXlVZVJNY3ViQXNuRGlY?=
 =?utf-8?B?YmpKdmhvY09EenBmd1EvYUhIZ3JLNXdVL0t3VmlUdjVKWnZ2YWhlbXY0dDZF?=
 =?utf-8?B?eHFTZTFyUjhId3d2S3I3VEliVUhzaXFYZytrUDN2cytVdWtRNnBEenZLRGlT?=
 =?utf-8?B?QVI4d3NyOGRJdUw4TTZNVmRid2RPWjZvVGtncjVBVEpueFc2TEk0aHhPRWpm?=
 =?utf-8?B?OTZ1UXNreEhTenBhZnhWaHVNbE1KUTd4N3RoUXI0T01oQzFWSEtkMDBiOEQx?=
 =?utf-8?B?MFhKTllINTNvaCtRS09XeUxqOHZCN0d5MCs1eUt2QktDWVBJZU9zaVZnajdw?=
 =?utf-8?B?dkVWaUJOSlRKVG5tS2JxL3l2d0xwdi9pV2toUWR3MFk4WDdCVzM1NE5waUV4?=
 =?utf-8?B?eVQ0UTRCbk1nNC9UdFB0S1BiUTZsUytoRDJlY2ZLdU84SkZwNUlYTlgvVzls?=
 =?utf-8?B?QlFJUnhoaE85REl2OUlYcFRIdnBzMUhhUDd3UEZJT2FwdjlGRUZoTmRNUjZj?=
 =?utf-8?B?SExJY3BsQTV5QWdHV3E0elZ5UVByL1d5ajlVQXRiWUdHMmE4YWRVcHlITS9D?=
 =?utf-8?B?QmVaUFdycXh1Tjlob0VESzcxUnVYZkY0bGM2ajhsTDZNckpjUGFyU2tZRjFP?=
 =?utf-8?Q?GlV3x2LkwWy4qnfmCR/Aj+FNa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd20b785-1c1b-4a04-3fe0-08db5ce736bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 06:13:53.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSm2Ga1YVAWMJx/qvpYPXhslxee/NgFrcxDi50eJuHdYSLEvp1MLnMOv03a7CytBNdVmH9DAwZnm6YLtz6NCUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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

On 24 May 19:57, Rafael J. Wysocki wrote:
> On Thu, May 18, 2023 at 7:58 AM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > Driver should update policy->cur after updating the frequency.
> > Currently amd_pstate doesn't update policy->cur when `adjust_perf`
> > is used. Which causes /proc/cpuinfo to show wrong cpu frequency.
> > Fix this by updating policy->cur with correct frequency value in
> > adjust_perf function callback.
> >
> > - Before the fix: (setting min freq to 1.5 MHz)
> >
> > [root@amd]# cat /proc/cpuinfo | grep "cpu MHz" | sort | uniq --count
> >       1 cpu MHz         : 1777.016
> >       1 cpu MHz         : 1797.160
> >       1 cpu MHz         : 1797.270
> >     189 cpu MHz         : 400.000
> >
> > - After the fix: (setting min freq to 1.5 MHz)
> >
> > [root@amd]# cat /proc/cpuinfo | grep "cpu MHz" | sort | uniq --count
> >       1 cpu MHz         : 1753.353
> >       1 cpu MHz         : 1756.838
> >       1 cpu MHz         : 1776.466
> >       1 cpu MHz         : 1776.873
> >       1 cpu MHz         : 1777.308
> >       1 cpu MHz         : 1779.900
> >     183 cpu MHz         : 1805.231
> >       1 cpu MHz         : 1956.815
> >       1 cpu MHz         : 2246.203
> >       1 cpu MHz         : 2259.984
> >
> > Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> >
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 5a3d4aa0f45a..736dab69ba1e 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -479,12 +479,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
> >                                    unsigned long capacity)
> >  {
> >         unsigned long max_perf, min_perf, des_perf,
> > -                     cap_perf, lowest_nonlinear_perf;
> > +                     cap_perf, lowest_nonlinear_perf, max_freq;
> >         struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> >         struct amd_cpudata *cpudata = policy->driver_data;
> > +       unsigned int target_freq;
> >
> >         cap_perf = READ_ONCE(cpudata->highest_perf);
> >         lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> > +       max_freq = READ_ONCE(cpudata->max_freq);
> >
> >         des_perf = cap_perf;
> >         if (target_perf < capacity)
> > @@ -501,6 +503,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
> >         if (max_perf < min_perf)
> >                 max_perf = min_perf;
> >
> > +       des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> > +       target_freq = div_u64(des_perf * max_freq, max_perf);
> > +       policy->cur = target_freq;
> > +
> >         amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> >                         policy->governor->flags);
> >         cpufreq_cpu_put(policy);
> > --
> 
> Applied under an edited subject, thanks!
> 
> I think you'd like this to go into 6.4 and "stable", right?

Yes, please. I should have added stable tag.

Thanks & Regards,
Wyes

