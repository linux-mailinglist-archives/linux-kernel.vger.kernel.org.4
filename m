Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C16727755
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjFHGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHGgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:36:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84001BE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686206201; x=1717742201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T0dkwr9E2nPBZP/40kzpURsTXGuRMpkgqnYwj78x1+o=;
  b=dntGvRmqmtYA44lGOUzDeaRIBTMEiNZPoOGZqNtK35GNakD63uVZGTyc
   x9FnTW2cRHPngj9To0aveAv8SXtgfIF+eSZ6LKiO8tQJxrrdrC5rdAz4/
   St/5qnD+ijhPZxJ/kGtUiBAKCoSc6wFUKpYqD78SwwGJoTbG5pXZghTAZ
   O3ngpQ4JhqklVxw0BLwDKOTQAFND4opArzm65iDvz2XA4+uaW0rRo+gwg
   jYlwdSZQM+htUoO+I2LQmkRqEloLlijpPqWS6bMUfxDiwCPZC5xV0ozvm
   yu5wAXbnqlyem6fofj8T+6faZRVeFItI1ecrU6j+oFQoLbidpVNIuX2Uu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="356077796"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="356077796"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 23:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739570860"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="739570860"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2023 23:36:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 23:36:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 23:36:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 23:36:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 23:36:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK9jPFddYaQEkQ3urh5sjmwa31zlzPwHNCX4zr8Lly7AGmdd3rUc95CEb7x21kWXBGttvmQzLSawgG9B5dbwUC4fnwFDx6SzOl81ZKo+bTfYs3DtOanCy679QwPXELY5/nD7F1HOnQRZ3eOCoKUwyq6HciBDGAZ+ITF9SJm9rTXtBDvg1Ol8XOw/ZdSiWiuys4qAJluC4GgLX7ywsgM2mqQeH/CgJjyDp/x/Jom61RWNDltvWyu1hBliAKhM8QYbKedIC8BPta0dMwZ/kS1vDBRVdQiEL5xeADpqhEDI8+Sb7Bpgcafb0mv1TOyb45/G3ZwxaqElnYVKX/wzCje4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt8Kp8cI19YgnyYqPjmOEWfEjvjWhuoQXfd2rSrrwLY=;
 b=X454JazJ39Pqsg9xI1tyexUjlFlV2F2YnAzdzU0BmeioOOLnedN4qdYtz28TmYjtRk6/IJHgXizJHzHRv7J7t+OGDuWG31nT2W/mJnsnL4xtmYf2/50jOM1vzN39K8cpQ/V7JtPuIRgwqwmaB+M7UweEHJCYsIqvFTbnEm7OqCu7I+RFdD+eYHmPk8a+eW5Dd7MGiVL6g9SlUlnLfqqzJW6OYMR92TkSikYxHSwzBN3/4SNlt1BY7/n4rXQwO2JiiWC8L+MworoYPseqb0U0L2T91H8I3eptBouZs2vHxotJpC6lZYptwcUDmjy2F0Iv1ylYZxYPU/mJviGO8GBfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN9PR11MB5467.namprd11.prod.outlook.com (2603:10b6:408:100::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Thu, 8 Jun
 2023 06:36:37 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7%4]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 06:36:39 +0000
Date:   Thu, 8 Jun 2023 14:29:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Chris Bainbridge <chris.bainbridge@gmail.com>,
        <tglx@linutronix.de>, <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
Message-ID: <ZIF1SsbmR2GHzQ//@feng-clx>
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx>
 <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
 <ZH8pyG1SyfGxQKAm@feng-clx>
 <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
 <ZH86C4A4qpeAz/n4@feng-clx>
 <86521835-f13f-4d43-9a38-9a55abae0b89@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86521835-f13f-4d43-9a38-9a55abae0b89@paulmck-laptop>
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BN9PR11MB5467:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c53367-2513-4721-b3c3-08db67eab6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBWWRSaSNc2gQ2oQI1Z0v6Uy37HudOVE/yoh+LwZgVjXw0KHaMZXbsnvDqItVV7GeECbfrvDCtOcYmniSg+cnquiYq1Wn3Civn82+st+jNGv0Pi1nFyZ92bFOcQ8t8xGCTVpN3eC9N3r1c0LyzlFQS4hIzV8hJO9RN9VOmEXZxDpnmx3ebkX6Pd1qync6Khy9iY38W702qH1cjxpUu0wo6Xg6GDZZH/fWZhE2tm9PCHIzWlyRaxs/ok1CIyT6xXRp4uwyfJacboRLp/RYF5H1eOJl8WNliEOH/ravU1E9F1uwyLjcke3wxrTGYt97WqUwY3gsvYcx1YI3CqxQcEEACbZH2sph4ew46MchpsQpKqR1uHNFOLRfKYjRA2F8ycGuWFp2jKjUl2m3LeD22vHBGZ/cWKwa2wJB66iRuWdX8JbYGnJZNWNBA7BC6pzSHaMKTnNwov09j1IFSlJVQhjIIVs0PvJGx69TUQpF4lK9Z3sGnqvS92UjC0VyhAvGIlltFQDeSBzAd3qsZGYg+CYClCBmNmklQR8jHuxnjknccMdMGLoLaHm1R27R6pFhdbM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2906002)(86362001)(33716001)(15650500001)(44832011)(6666004)(6486002)(186003)(83380400001)(9686003)(6506007)(26005)(6512007)(5660300002)(82960400001)(478600001)(54906003)(316002)(45080400002)(66946007)(6916009)(66476007)(66556008)(4326008)(38100700002)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJUOuuR5Btec6DvLZ2uH90ONewSvQ6qwTsukndDR79bFEZ3A4uDqPSKuGRW3?=
 =?us-ascii?Q?cRIkeHcqXSud6AIfjZ2frwZwX+n/304e8fPD/OnhlV6hvTRX/BWFf11HFv9u?=
 =?us-ascii?Q?KNnXIR5E2nxBJa+WZWjLHFrrc7IwJBHCVBtwlZ+GUGiT1DU+7cr5Q2KrGtqb?=
 =?us-ascii?Q?5fifZ3jOiHZ1PpsnGHmzPR8Qv9gaHVlpuLY8nDeAomj95dHH9OMoEUv+3PEl?=
 =?us-ascii?Q?EcuD7nGnDdmWGJl3S9Mb85OKeas05KUxeQW6Nj8Hs5R6jAeHHmLBA0Byz3On?=
 =?us-ascii?Q?To2FQTwIOQ7CnFQUtcPQrP9SOEZvhoZp0deVK5m8lFwHoc2CpDpAv6RhUd8o?=
 =?us-ascii?Q?uthGjnQxm8nKAt4HELm7F6JMlLA7kGMxn2RRfUoby4dDq6pdEgNi4B65roac?=
 =?us-ascii?Q?s5JK8UZhizBmF/myzt6kiELgqzSFoS9AfOuVXRNdCleRqB7H9V8fFx9SqAtt?=
 =?us-ascii?Q?g7CRGxUXfoLQuA7bg5zmz7VOllJ8LrqJVjCJLILmSNActlZ6y5mAjr2Q26tD?=
 =?us-ascii?Q?APZ2UrvhBz5Tdn4bZVGbgTqgSebAG3ln/yK/3P46laHXzRM9N5tkrXRXey7E?=
 =?us-ascii?Q?aXglTnQQp4/+PGjLM6ZEh6aUNuA0pHRNGlFl63sgfgYgldZO3dGEP93xPscr?=
 =?us-ascii?Q?BMH7zi4YLmqylLNRzbIO62hd+PvLMdkPlAPfPeScLjY/qJYeM3akD35GF+al?=
 =?us-ascii?Q?nqDUwNEl1saRxaLNm0Ibo7TtCZWDGFdzpohBc4MLQe5z4q9ruWIwAot72UZz?=
 =?us-ascii?Q?ixAqe40pFaF3ak29N+aRYr+ll0fsuUbgBjIsi7bK8Z8SHSUJmT7V/VPiWGAX?=
 =?us-ascii?Q?ZFJzEppjH1MfRcBwXqV8kLm1/PX34DrtBQ3YUm91O1SubQr5/wDsIMUbkhfG?=
 =?us-ascii?Q?SgoPCvpy5b0J63tFQQoDmMqV2uKN5kGubCs+My9OGtihsTOwPc9VWBStLSbz?=
 =?us-ascii?Q?EpxkUc2GdUVyaVzn52YoM9RopisbjL7YngJQjJgbWMLprM/M837Zeb8akGMM?=
 =?us-ascii?Q?y6Rm6fhG2mT2hue4llkpfkT9wAdgSEvwVAXITrcutXvNTz5XqOT1wQI2AtXM?=
 =?us-ascii?Q?CkXL/SL+WshOWNlW0k5OD7gBZ2lCurYNUZiETWc+6yoB7piBV6bJMj4pkqtk?=
 =?us-ascii?Q?ru9J/YZZgd36xt4Q1B5BXinixvNI+9v3IBj1C00eOrvzzbqXSsUoqlAXEUoP?=
 =?us-ascii?Q?JbCAug5b4c6aHRJO4ce3Thzu51NJ4gHBxosvAjx4fPtWnnnv8g6KkiMUSffK?=
 =?us-ascii?Q?x9SNJj6eJ8n15pOu1GObcaqbF7V+rlj9dNM8pBMUVgT87jtRPAHIDFfc2QRn?=
 =?us-ascii?Q?fVFV2nB9WuAJE6aJPcMFZDQ+T75awSwt56GZXL0OSnybq7vLNFjQdtD7r7Dt?=
 =?us-ascii?Q?frPt8KdvxT4N12yGdSHP7/pFmsN1lkkjq3U3UfFSkEtpvurnoZx5LgcH+3vt?=
 =?us-ascii?Q?weEl52F9ab6cMVEvhH5+Z8XKVnDbw4udiR5MjGnlqWoRmJMxfFQudJEuJ/k1?=
 =?us-ascii?Q?qGPtlpzAYgQiIsmWM5EWBzFu9Rvo0APFnxdOiuoeTxwzv78wD+EntM7KLSSR?=
 =?us-ascii?Q?x+wVlwZBRSKr7sseKliOVqhfZmvtDasV8ja/Hd0q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c53367-2513-4721-b3c3-08db67eab6f9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:36:39.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adM2QfOjCKtAGyHMD8K2Qdv/9mDWTNMHQoNC6NkDcooTu1l6hTPY+TkrpmseycM/z6c3J0IEtP4hSkztmGqR7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5467
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:04:49PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 06, 2023 at 09:52:11PM +0800, Feng Tang wrote:
> > On Tue, Jun 06, 2023 at 02:09:08PM +0100, Chris Bainbridge wrote:
> > > On Tue, 6 Jun 2023 at 13:50, Feng Tang <feng.tang@intel.com> wrote:
> > > >
> > > > And I'm have no idea if there is a real hardware/firmware issue
> > > > or just a false alarm.
> > > 
> > > Is a negative reported skew valid? I don't know, I had assumed so, so
> > > the problem was the conversion from -878159 ns to 18446744073708 ms.
> > 
> > I think it's valid. The related code is from kernel/time/clocksource.c: 
> > 
> > 	"
> > 	cs_wd_msec = div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
> > 	wd_msec = div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
> > 	pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
> > 		cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
> > 	"
> > 
> > The negative value just means the watchdog is running faster than
> > TSC in the 512 ms checking interval. The 18446744073708 ms is just
> > a conversion from s64 value in ns (-878159) to a u64 ns, then a
> > u64 ms. 
> 
> That is a bit user-unfriendly.  Does the following fix address this
> issue at your end?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 8eb836f2dd44cb1e80dfc603cf47c03603dadcdb
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Jun 7 11:59:49 2023 -0700
> 
>     clocksource: Handle negative skews in "skew is too large" messages
>     
>     The nanosecond-to-millisecond skew computation uses unsigned arithmetic,
>     which produces user-unfriendly large positive numbers for negative skews.
>     Therefore, use signed arithmetic for this computation in order to preserve
>     the negativity.

It does make the error message more consistent and less confusing. Thanks.

Reviewed-by: Feng Tang <feng.tang@intel.com>

>     
>     Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
>     Reported-by: Feng Tang <feng.tang@intel.com>
>     Fixes: dd029269947a ("clocksource: Improve "skew is too large" messages")
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 91836b727cef..0600e16dbafe 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -473,8 +473,8 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		/* Check the deviation from the watchdog clocksource. */
>  		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>  		if (abs(cs_nsec - wd_nsec) > md) {
> -			u64 cs_wd_msec;
> -			u64 wd_msec;
> +			s64 cs_wd_msec;
> +			s64 wd_msec;
>  			u32 wd_rem;
>  
>  			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
> @@ -483,8 +483,8 @@ static void clocksource_watchdog(struct timer_list *unused)
>  				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
>  			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
>  				cs->name, cs_nsec, csnow, cslast, cs->mask);
> -			cs_wd_msec = div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
> -			wd_msec = div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
> +			cs_wd_msec = div_s64_rem(cs_nsec - wd_nsec, 1000 * 1000, &wd_rem);
> +			wd_msec = div_s64_rem(wd_nsec, 1000 * 1000, &wd_rem);
>  			pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
>  				cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
>  			if (curr_clocksource == cs)
