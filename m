Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20BC606C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJUArL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJUAqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:46:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029721CD64
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666313209; x=1697849209;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iB9hpAaHR6KlbYLWkzHbGRH/nbCowOaU1EIpunCm4fk=;
  b=CD5d0JiP9TIM/5Gzy4u0Ty5WFzOEud1B7Nr0LmLCEuNMa15Ny+z/DnLG
   JX5wLahLc27mhH14lpiA3mkV1j51DQeW66iZwyiunJAcZJH2Pg2Wg7Qe9
   AQOtC1+GnOHhs0F2HQIoK5ZPBevIP9DZvXPK+yIj0M0z+Tysc41hj8GHH
   Bpexd/LiRkmnoAoupTYX+C9mVOpZ41PjAl74qMdKWFpBYPrBj4JJMKDi0
   o9AoN9lsueYwPbuihGxVTDAcv9acS+u3JwKO4mRvBHjBtV8t6o3ihmnz5
   5vRHJW2RaKUMGHNLsC98n1AKrzinkIFW997XH5f3iTbdxUP2+Nut2IiBn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290185726"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="290185726"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:46:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="805243762"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="805243762"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 20 Oct 2022 17:46:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:46:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:46:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 17:46:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 17:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfN4Ogo0dwK6LvcLsdOiN4x/WAI6unuDfXyEN2Tcxi+uYn1nJECT8Y/UbtSKNCrvubYH3mmnD/Q0Up+pbm00Z9XMw0JrC4+N08XAwBKQGk43ieuAKldXb8BzsdEpZvW+xHOolLL+VisVNnQ5jOzrVbaDuiF7ZhHWKGmqKKVRGzMzpBywF0dQw1YJRV4WuouL1/VZ3jay3MC79u+ibsLAWCge1ohmkqHo03Dj8h+jUUsca1siLaPXL9sHV4kiNnobuxowCX/Z01E5yPm8IqhSC0GZazm5LSjrA9sW/MOjtddjz4q3hpXNdAPf2VRpAVfsivOcKbQ+DlokBns0V93y5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU+igmeftI/X2Gyt8kbvE1Bo6G4iTBAGcExOLpJ34FY=;
 b=IGY7MOQs3yn+mTqFg/sBH6qwil7jc786fLzVoKDYnz1CxG48msKFPQlbgeH24r7J1hdjGoaEiEipl5XzMGzpXGKRISV9YTkxLbUTEuMl2gHJA6bldMV7u7c723o3RKRxEgbzSYMw08LgeZi6Ok3i6u3iAgagQ0X1SwNxYOxtqDP1ce402jzp7oH4NC3zhw4AJqPClYMh/Pzw50O1cAMgPCSK4HsJcuQ8K/5S3P/GaFpUEfQPoDPAzFq8FfdMCzD55g+yySul0fO0y7ZX1otyn9Pu6jkTyZiROUiegLR5ueCCpAcz7+djL0a+1aNSC/wELioS1yqS1Wcd+ikulGVWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 00:46:44 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 00:46:44 +0000
Date:   Fri, 21 Oct 2022 08:46:32 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <clm@meta.com>,
        <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <longman@redhat.com>
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <Y1Hr6PNy9EJk245f@feng-clx>
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c0fcfa-c169-49fa-9eda-08dab2fdb9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T97fRhZ+rVen4Ie0oBjRvAviDpuDB4I0GW6cBIDLCqrHQ8mBOfjmy5qQ3qqsUs/19FXHmK8oJ28F1U5zDJc7fKxSFvv6G5Am7CCH1oIVHmMbs3BAlxDKgwXJxIIu7MTf8jX51dzWTRNTtAB6nh1ySrgWwrsyDymamvTpBikvwMuAzMq++K2OrL/e+N4+18P3RaaX1BRkiqEgt3n4sXJ7UJ7ogJJucRKhG3875DPt/nvQ+rkWDW8fEJ+5lyKu3pcXJ9987tzloVuH1BQNp1rRjXOo/s55nFhrnf3tk1QQuBjLdOk4MruUc77HI4MOJaNtM4pGFlCxCC5SlzA7DpBspwbW6eRmXnc2tqFNs5eX7pREx1Ajkb+FDrcr7Rc5AsvfzPg0mkxsM4skznIHEWdESA8tCOoLs9I1ClVouTWgNlo+Z1t8ROhIYLdRXJbYIqK79jMYas76XMfLlW+XcXysE0WJSEwVJIZanHkOpadEQ+yUs/r6ozqN1faDVkgiGkhuSPUURNrnJHtgzq9vISngzs3xjFTSrELlt/JMWLowcE35OXgoB176jMrOEWcA8NJZM7nQlH6rhy+Nx2CJ9QKs2nNByszsXajeV83KJviEU4aiwLz5HrNikVNPstPU5sxgM/gc1DxxJbCiXHR3azsJtTSN9Nl+Qs04kjOkeWA39f4OXeSFTHlZLJIELQeQ0JDWsF0xZ7XBOzER9o09osScwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(82960400001)(33716001)(478600001)(44832011)(6486002)(38100700002)(6916009)(316002)(6666004)(6506007)(4326008)(66946007)(66476007)(66556008)(8676002)(8936002)(5660300002)(186003)(26005)(9686003)(41300700001)(6512007)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uAQ676KI1Vg/P1A287Vf1SYEgd1VIoF0wG4qPBBweH5HgT8t1Q30nnxo5VDx?=
 =?us-ascii?Q?+xzzK3G3HErcfED8VRpuLxqvyXMGGhiB+zOO8Xqjl46E1o0up4BIggl8MA2m?=
 =?us-ascii?Q?6do6zTtcu52nFTrHhwrjfKzjtLrAUzTN10c2JEWk0eD+qbOEKLyjECoz6Oio?=
 =?us-ascii?Q?yvqUgVE8vL3Yj8SxRb4E/ojQ9MeXglR0dYEkH4MZXC6QapylWcnEL9EQag/v?=
 =?us-ascii?Q?KIoC/znVRI57N06YiHM04MtsVyjZfy3ju62nZDe5QTAv9uL4v6jZFLMoDkA8?=
 =?us-ascii?Q?k+BVCd0naDlPjr4zE3YZMzA2GQPpIDcauYbkZNgWk8jFimDYAA7U/2/dS4WF?=
 =?us-ascii?Q?KNrqG1/idCD0eDEejw/exUi5LXe4jYTEwfH6w84pcNfGQ2mNPhmVYIsCf22t?=
 =?us-ascii?Q?IHa64T4IY4sE3d0M0N5Fs7DK0k5sW4MCiyeorqkcXCEvNKkv/0d7EWsCN+L/?=
 =?us-ascii?Q?OlI63p+0jPbWKDkeysbbZ2Ictl+AdnAC9YkFf9io6XBBgKAM7wRtAfSn5+Np?=
 =?us-ascii?Q?vyVD08d3iS85VeSTUUO3UBW7MEKOEX88iZaA2dO2CWRaGyN9ySf+gb+Wmh29?=
 =?us-ascii?Q?Xi4oq3anYhZ4LzsJRRrTwo8Uf8RCPL0RwIwe10GeMWj4O5g590pK7wXXQNLn?=
 =?us-ascii?Q?+uZmAKY5cCMuBK+L4yYmeYBx7N/HxamXXPwjE4la3XuuwlWnmkem/Y/d3TYR?=
 =?us-ascii?Q?RrpNQi0doppqz2RVIT8h4iFKmzwPVK7iMqukFmGmAFkU5Gmpg2hE6fvLbgCa?=
 =?us-ascii?Q?NRteqDbI+ohJvg47GohKFoasSnriH/KxIPPNtBmXF6XhcSQnddoVfWNxmaaT?=
 =?us-ascii?Q?MCNL+7gvT5gspZNuEXBPKlvWnEHpLuRHKCRURvOPXu+OpVtQAJUwpbivWu/2?=
 =?us-ascii?Q?B71oYuQQvXZbQzabFvnEBigBsQIvP5C3bXoKV8S1NecROd+WT8AV/qqSL3Rn?=
 =?us-ascii?Q?YjXaWG4wPKGcNjgwKET69VUIcE9x+f4/oft3VAaTPXkk39JZgJQZG0+/n9Pw?=
 =?us-ascii?Q?55qYuTYwMPv9vTgH1GJmt7z/LxHDJMohIALSpLPLTEKeG1bUDB4PRTEFttUH?=
 =?us-ascii?Q?8xdLiWSBIcUYM96NaCPP1BCST93QHbrXGG4R+E4GD10LIkm4DGTALKefbxNP?=
 =?us-ascii?Q?kzDgIwIIUOXoBOtqW/ows9MaZfED7P3vOwF9Jc+3WFmIB8rkduib+vLnPG9Y?=
 =?us-ascii?Q?824/itmwwVUzvQmUp/De7UPmiyRcjrPAbfN//O6FyuS0CZPOTlRoETdRDBwt?=
 =?us-ascii?Q?qrtg2vqjYg880HdHfk7jOcCB8ya7SX3EhHrIKnEjvvBI+VXInMJDZIDbpbnR?=
 =?us-ascii?Q?gixvzVP8tdmLRFugeeSmrzrYq6iVnzSHpDawUV4ce4YcO69E9VwKUen+L1EJ?=
 =?us-ascii?Q?Qi1MGCvYo4uwKw67gP/9ymrB+mgbfOLRYETG5ugdVbfV+cQKw+EvB7NpbT7D?=
 =?us-ascii?Q?zXoujwCgSdC/ZBpRf5otQuxG2lB6fxmABzIhE0MyvAHzQ79w/bgC1fi8tUD8?=
 =?us-ascii?Q?NkvLQ/e0kvvUz9hOm6YRXs/+rcoxqqeqRtmJtWPZxhjRRG0g9xyAi9S8BPJz?=
 =?us-ascii?Q?RN1mut2crvU7YE4EktZdBbSWDIlKn2Xg484bMJoO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c0fcfa-c169-49fa-9eda-08dab2fdb9ed
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 00:46:44.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ca7fSd/GWCD9DDGkwOHDZ0bjNkmbeZKMZM30jMVqSA8ZHrzckfFRkQG4puFcQ3sAF4vn6hkPQnPu3i1EsJi5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:09:44AM -0700, Paul E. McKenney wrote:
[...]
> > >  static void clocksource_watchdog(struct timer_list *unused)
> > >  {
> > > -	u64 csnow, wdnow, cslast, wdlast, delta;
> > > +	u64 csnow, wdnow, cslast, wdlast, delta, wdi;
> > >  	int next_cpu, reset_pending;
> > >  	int64_t wd_nsec, cs_nsec;
> > >  	struct clocksource *cs;
> > > @@ -440,6 +440,17 @@ static void clocksource_watchdog(struct timer_list *unused)
> > >  		if (atomic_read(&watchdog_reset_pending))
> > >  			continue;
> > >  
> > > +		/* Check for bogus measurements. */
> > > +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > > +		if (wd_nsec < (wdi >> 2)) {
> > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > +			continue;
> > > +		}
> > 
> > If this happens (500ms timer happens only after less than 125ms),
> > there is some severe problem with timer/interrupt system. 
> 
> Should I add ", suspect timer/interrupt bug" just after "jiffy time
> interval"?  Or would a comment before that pr_warn() work better for you?

Both are fine for me.

> > > +		if (wd_nsec > (wdi << 2)) {
> > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > +			continue;
> > > +		}
> > 
> > I agree with Waiman that some rate limiting may be needed. As there
> > were reports of hundreds of seconds of delay, 2 seconds delay could
> > easily happen if a system is too busy or misbehave to trigger this
> > problem.
> 
> Good points, thank you both!
> 
> Left to myself, I would use a capped power-of-two backoff that was reset
> any time that the interval was within bounds.  Maybe a cap of 10 minutes?

Yep, that's more informative. Thanks!

- Feng

> Or is there a better way to do this?
> 
> 							Thanx, Paul
