Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19F7044DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEPFt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjEPFtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:49:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EA940EC;
        Mon, 15 May 2023 22:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxdlTEjZl6zsoIm0tDaS0a8h6oM/t1o5a3KSPp+ab+Yr/Wac2OWRo3cWkupDooQ2a24ygqkaR30tDhV3VdNctjIeSh3k8vM7gGsPNV3OjfTqqZR3FJPGaFeIkzZFPtg3u2NsZSWljOZwjTUJdlTxl+gjKNTGbXa1tblzZ0a7uMri/u2cANE2CZbX2TmEXxC5i1EZK+GETmkVeRGKa8mXYxlKqu6pSO5sQL/s/R+wrVcEpQEYBi05YzZN74LVgTHQM/jpHxBk4GrlIfGt+5Z+JWGev6WG4xrjGpPYyTpEbeC2s7XEzQvEo4aqmjc+owbfwKyfamrmq0v9xKv9Kx8cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOIgFeN9kN6PeFLKt27lvV5IBQ2npPbwkYLDrhyQsJQ=;
 b=nuvViXq2HTu1SlkFfXW+nLPtbJW1kSyNcagbV87ktsvB0Wt8akrmqtjdrQyCITABeTpDtwfWbptdH98Q1WI0s7739c33iikIHYdOxjn9b1WYJ03zT0o4Y7zwdTm45asEqNHKxyPF4hw4cai6bFtf3yIGY6+aKTMJgq3gQ5nCRDpcvfTpnW3HCr9pmY6x5iVlN1BMJGF9PTYJHTMzyW8blUMa1s5MhTn+MdyovnCTtXOmx+3m7sWEt9qXdo2H9QKGaNlMU9bop5EiuDapDBwt5jarbQJkINXLGeCMXp2131i5MIwNQ7WjY93lx7GRoQG7kG9fxEiuhoUeRYjMnrsgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOIgFeN9kN6PeFLKt27lvV5IBQ2npPbwkYLDrhyQsJQ=;
 b=JScYnXzhXH691AHTvHGR6+sR5WWOZPeEREa8Y56UeHlnDETCCam9xwNbyQL3JXjFZB/LDk8sJl4qZ4sDOW97LBdF8qfZKcxVK4N13ArY30S7KtlHD9vOEEiczEcxuop9/nb07coXnwQyT9rpnSLprAxD4Z6lyaWgWvUq4joMZaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 05:49:18 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::ea49:6972:7c9e:d7c2]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::ea49:6972:7c9e:d7c2%5]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 05:49:18 +0000
Date:   Tue, 16 May 2023 11:19:06 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com
Subject: Re: [PATCH v3 2/2] cpufreq: Warn if fast_switch is not set
Message-ID: <ZGMZUhWCU18Wn/47@BLR-5CG13462PL.amd.com>
References: <20230515113404.4259-1-wyes.karny@amd.com>
 <20230515113404.4259-3-wyes.karny@amd.com>
 <20230516011001.epa4xlvbiimu6ai3@vireshk-i7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516011001.epa4xlvbiimu6ai3@vireshk-i7>
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: f55e0623-77bf-4921-bb55-08db55d149ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ti5sKNFQsoHR/kaNXHNFbqGmDYz9lggbgyhW/Syt+b/b3s2GdFVDcbv2quzx+8bn9VmcQUjKL5fWRdTvs83cz2oMpq55pInA12IfwHsPBynMyNT2TbWXbrGEmh+5L/vTWzVT97c9Ry3yP6xTpmOyX8Vk83VOiWxHHzwHwyIDl5KxfXy4oA+n2/UfNk+CKNbyx9E5TON5UUnhrED/+yS5cDxUXWvk6NeRJhKDyN2sDrwAb0lL5mBhqR+OCRfnXIxq6pPlXyLlyNNTfxEIXltIdXz/HZKiuFKLXf4RtBBeTiv55r1ShBFmTuwJkRTax8NaA/UJyfF8SucVCXMJsss/oVDuX0e2Z7Sw62NgfTOUNnbog3O3YoCHoIavEWhLIWGvThCT7JarAMf/06YolRxONprBLkc357OBZ+/LkqaEFywu5XNdrHECw5otLfsDgL/B9rYzXwOHd19EI+BcXGgH/5JraYTrWYjcDCGVS8lNnRurOCrelRKasx0WCh5sCCOpRmCAovqgd4bnKW1s9D3fWcc+fX/GMyfP/kwhMrSV80GYi9P1dbGuVGU4fFZNsO4Wt1173CbLX8ukG+AcLnAhGo6L6JszS/A81X8SnnsJP6bTcJQRWR+Mh53dH0nNlRmp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(44832011)(8676002)(8936002)(66946007)(86362001)(83380400001)(53546011)(38100700002)(316002)(4326008)(6916009)(41300700001)(5660300002)(66476007)(66556008)(6486002)(6666004)(26005)(186003)(6506007)(6512007)(478600001)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAxmKIib4xm3lqTgKjsPibq11YdkqlJt2y/bUFrbqZO/VyueWAHSTdZM++vn?=
 =?us-ascii?Q?h2Kc5GZ4DQeAMw0B3SV5Utpmf1p2mNjsotYC0a4ZD+6wCSEkqcdErMs0vNIt?=
 =?us-ascii?Q?ZicOr5hcRev9UwRCdEcoPGXTEuUohn/SOwO7hGXngH6MhT7oCjXP+92Qv5gk?=
 =?us-ascii?Q?HtQ4nlln2qs9nK9efVKlu32dJU89MikLt+rg0u2nJp/tLx18qFio6E60gepd?=
 =?us-ascii?Q?fMo+cbTAhz8Lt7gbkMcX5aHMDWRaEKSIS+v8z6DlGj3x0MIAKhmR48HB427e?=
 =?us-ascii?Q?BSHA2KGeZrZofqjuku9oqPxRmzS1S2wNX4HywTNdRIHxoKEdi7ixMFpLpigE?=
 =?us-ascii?Q?iMelF0HFor/oA8aEK4yHb6hlKxPCycegIW3d7brmbBXemQKG4OZnC0vYzEDf?=
 =?us-ascii?Q?06cXvHw6pgQlz3Myr8+SXK8E8ktIm78m6quovyoQoQe0BRrZmb8TOzKzLhLa?=
 =?us-ascii?Q?iE/4QGeg4WfloachM7lI8xuvE/w0HPMayg9pUu+J3tvG9hObJ56Z7mh77fAu?=
 =?us-ascii?Q?iHTJtNSMawaqSMxwJt1ohJX5rbEPYQUFyGdtDoc2B9Z/nsy+NU17VsAB034T?=
 =?us-ascii?Q?j9waNGS8aUcMfKhN2VUq17TbJSZvjWgjhMPq0bhUen5v/EhwxgJV6+GnC2WC?=
 =?us-ascii?Q?DTDw41LnnkPo0epfodlWjq9RtCEFG1loJqmJmi+bwannZm8mcryGfC3vIXQm?=
 =?us-ascii?Q?s1lsyqzx36pj5/zGlf1dbfdck3IP4H6tVmwlyieY4cYUpWnlIFC9weIwgLNk?=
 =?us-ascii?Q?C0RB43Uad+DKUitcUhfDLW6Tz+RJxOOy+Y2IIjVkDdA85t7cUGC6aHSCj5sT?=
 =?us-ascii?Q?8OYbzyINxICVYXkIs5pcnk1zM0xIBzolnhvWye1OQi/yGSIMe7UI5KNHQZQm?=
 =?us-ascii?Q?RT6bbdDgKisaKRTw0+RWa6S32/dFXCLnDLRczc+Vz6d/ZeAJ5/r5RWu+kFKV?=
 =?us-ascii?Q?U/dAeoM5I63QP2cZMaxEXh+Qw0iyatyiaO4oeQvj4hTo1LdlOHMevaT9oLeN?=
 =?us-ascii?Q?G8R4mm0NJBK6rt+yJCp6Y2cG3WKUE5bZZr1LezY7BtVxRdC5zhA3FPnQ2DAu?=
 =?us-ascii?Q?bvRiXQMfhTAHOlS+RVQ4wuh6XKxY/oi2EcXunWwQI+OKJAydr4yR9Otwoypx?=
 =?us-ascii?Q?TGs6seJl+w774NcjhCGVqxGoutZrPsRT8KJQesSGSTMLt2lmaW53la/sdqW/?=
 =?us-ascii?Q?PMa0EqAWXcUqeMeSXx7lV0HooqoF5Cq5SLuaM1w9IHuC3+k3BsjentamcyWi?=
 =?us-ascii?Q?Io2xISQGYT7HJM0Ys5hckwt04YTZkgxz0ymOp8Qt725w+ZLeX2QMxm+Pfs+m?=
 =?us-ascii?Q?msj8qftJF6qv5A3b0iHvlVsDysCRyhgFj27vTpTi+W20Wxz8z35Ckvrb3SF+?=
 =?us-ascii?Q?csscRE4pFcx+EVpcFThTYsD11HWgrb9idssfCJD8CTDIQ8oFt9am1qhhQfYO?=
 =?us-ascii?Q?imw9UiEyAbL7oVwI3AUVF2ZhrMCa9nuQIZR63+aXKrIdaU0RuONa3wjEWHMr?=
 =?us-ascii?Q?RLeHR0+TNNXQruYzTckMhGThKvpJh2DG60tdGRNdWPFBCSXhFa28q/s7aI5g?=
 =?us-ascii?Q?TWc8F5JVsB6ZR9RfBCJ4sYYMPPFxJjEgnvD67q9f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55e0623-77bf-4921-bb55-08db55d149ba
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 05:49:18.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uvQn09MGvvHw0r2jK6tR1zt/I5Cl++s2vRZdTUgPxX49J/kt4oW8cv8VWNSi4Rm7edUph/iq4f3uGbFcS4JYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
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

Hi Viresh,

Thanks for looking into this patch.

On 16 May 06:40, Viresh Kumar wrote:
> On 15-05-23, 11:34, Wyes Karny wrote:
> > If fast_switch_possible flag is set by the scaling driver, the governor
> > is free to select fast_switch function even if adjust_perf is set. When
> > the frequency invariance is disabled due to some reason governor
> > fallbacks to fast_switch if fast_switch_possible is set. This could
> > crash the kernel if the driver didn't set the fast_switch function
> > pointer.
> > 
> > This issue becomes apparent when aperf/mperf overflow occurs with
> > amd_pstate (passive) + schedutil.  When this happens, kernel disables
> > frequency invariance calculation which causes schedutil to fallback to
> > sugov_update_single_freq which currently relies on the fast_switch
> > callback.
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
> Not sure if all these details are required for this patch or not. It
> is logically incorrect to set fast_switch_possible, while fast_switch
> isn't set. That's a reason enough.

Sure, I'll remove this if it's unnecessary.

> 
> > Put up a warning message if the driver sets fast_switch_possible flag
> > but not fast_switch.
> > 
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 18 ++++++++++++++++++
> >  include/linux/cpufreq.h   |  5 ++++-
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 6b52ebe5a890..180be9235b08 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -501,6 +501,13 @@ void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
> >  	if (!policy->fast_switch_possible)
> >  		return;
> >  
> > +	/**
> 
> Doc style comments aren't required here I guess.

Okay.
> 
> > +	 * It's not expected driver's fast_switch callback is not set
> > +	 * even fast_switch_possible is true.
> > +	 */
> > +	if (!cpufreq_driver_has_fast_switch())
> > +		pr_alert_once("fast_switch callback is not set\n");
> > +
> >  	mutex_lock(&cpufreq_fast_switch_lock);
> >  	if (cpufreq_fast_switch_count >= 0) {
> >  		cpufreq_fast_switch_count++;
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
> 
> Why create a routine for this, when no one else is going to use it ?
> 
> > +{
> > +	return !!cpufreq_driver->fast_switch;
> > +}
> 
> I think you should add the required check in cpufreq_online(), after
> cpufreq_driver->init() is called, and return failure if fast_switch
> isn't set and fast_switch_possible is.

Sure, I'll do that. But one caution if we return failure, the drivers which
has the above conditions won't load.

Thanks,
Wyes
> 
> -- 
> viresh
