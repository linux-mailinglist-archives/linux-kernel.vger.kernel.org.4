Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C870ECCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbjEXFCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjEXFB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:01:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCCA18B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684904515; x=1716440515;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=w0pkV8+BpjlI5U/+ubn40vgD11fYGxI1LPRtNMu9Nfw=;
  b=IFNFUsEhCJJpA6PF+EhzqnpTv+vKV76mFbq7rCMedofMlv3j/Zd++SI7
   fJ6hJzWn8VWOvIsTYbpizuFc7+qpoCoDopT5WtUNxFveiCG1t/um0b7az
   7Ii3Ta6cX/pVKkn2Kkp0hmLAQVMbDVrNGHsv3fh3oL4V+1cmOFAvJ8398
   uq7AWEiIEhVXrA4S7D2eAlOwHb++0Selst9I8O4Zk72dMgTGwPRZA6Fv0
   CUcwetCmlRTgdHFkkzuV+1KodxZ3wAnwt/wb5dv1oFuyGFnrgAg6mOBln
   pc9jumz8iSB+kojTkhy1hkep6RbsImJIUQtj98tulTqmcFO9w6g+7QGA7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416917663"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="416917663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="681700886"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="681700886"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 23 May 2023 22:01:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:01:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:01:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 22:01:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 22:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z25c7cyWgSii3uPLV6CQB7Is+6Nvr8jbbVk6ZRFiQpkJxZiKfpxwsBCjg0pDp+6oj7pp9rAUCAyO8J+12/03QFX7Gn50/ZmcBVOApC4UnR+MSYf0Ql05szINrOjQMhxlRqa2bWW069zGVYEr6fS9dMMHSPiRvpRN3CPQMCS7V9+yySrCTwd93va+Gi5cLWpSYzW4kylMH9UmIBplhmkpSHIzA7V3aoc1KUquqYgVkXFUwkACFtS2s7SM/eY19TqJabE4e/T2im42mTQUrkEWJe0FLi8RbWhsJ8tIbSPw0j8fy51jVPDIuRaCBbK9td9kEKhaASUCHjms5wipCc2qOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqz317bHPgUYlu9csHF5t3GZdyiddjyCu61wUfI3Pjc=;
 b=TCMDXYJLx+khAVt/XPZaPMdY5tdgfpzZuHn/zvOdiodjq/k7Fce4YJc2VjDJDFNmQNcqHFoH1lQKL0MTW4o2/fLFruda0r83vShexs5oR193EPoo0zWxq7rqdQW7jhG0Z4St5sh6mq59xXUUD8a8Zw4QzCwtH4tw7J001oTUtXzMwt6PhFOAOvhZOdKL+v16+5cJtWGNVyYCu0dU6W7qf29SKfYmgUg0cUJuH0tfXDCu7ek6w3kI2R0fYY7gwqaK3lrKd/vdcv3cJQOjC6f0x5stvP0f/32oJoqc89AJ2C21aT7VPKgiL8GjvjpNZRiGMl6PTNfpvblsFKeYgYFr4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CO1PR11MB4772.namprd11.prod.outlook.com (2603:10b6:303:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Wed, 24 May
 2023 05:01:36 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 05:01:36 +0000
Date:   Wed, 24 May 2023 12:54:45 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     John Stultz <jstultz@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>, <paulmck@kernel.org>
Subject: Re: [PATCH] clocksource: Add a helper fucntion to reduce code
 duplication
Message-ID: <ZG2YlaxJhjfHel8K@feng-clx>
References: <20230524040733.66946-1-feng.tang@intel.com>
 <CANDhNCpN8YucULaTJs9YGhWSw7KHO22TdFE171XwV3fw-xM_Yw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCpN8YucULaTJs9YGhWSw7KHO22TdFE171XwV3fw-xM_Yw@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CO1PR11MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0fc470-5d0b-4b65-f254-08db5c13f2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yoWDVLJG2jYSJKCZAr9jXFqXIS2z7as+i8fU/swmB8U8TfK9iut44+zo2iuKKQl691SXy5Z+MkoAqImvTi+W9Eb4QxwpjuVaolkMQRL+AUO8Ew2tShi+gaZXHni+/3hqGWV1ECakWZ6ToOsGMZDGIphB4xAiQyxXqxofcSwdwuqDG2IIU6H3NMAuDavkcPAKXc0co7w52KOTbywgc2GJOysd2TrU4EhWdbyVaZaGBC7N5I4uFeM2JjJLde1GxsYpaU08fYNUlcVzSCgejiOw6Fc9dDPEAaUww6iVbyyjlFt7XT7TOMW7ynmimrPJkmL8xh0pOw1aRdv3T33QRpJUJE1ciBZglMwGgLIIdVhTt2wuWbkib340ufNdyXzg0pzPMVFMXgtwhCwdGfzQukSomwq0Jh402kL0pRsnZ5NAMQYmtB4oiXDbuLsCHPLntCW4MO+qiN0jCUrDBAp4+NTTnhZvcD+woSRNA4NfWEuD1QKXvOLWTmG/iMHP6yE9HhkAox+ruavRcKOMcf77g/SOS3q2N0peH9oQ+zPD30ybvYW0fcdSo/pmsIkZD+g/Hex
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(316002)(33716001)(478600001)(54906003)(66556008)(6916009)(66476007)(66946007)(4326008)(6666004)(82960400001)(38100700002)(6486002)(41300700001)(86362001)(5660300002)(8936002)(8676002)(44832011)(186003)(53546011)(26005)(6512007)(6506007)(9686003)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZZeUY4RFIzS1Y0WTJVUWNSdk5oTERJNlI1a3p0Uk5rdUVpL3JkdlRsTVNL?=
 =?utf-8?B?YzZPcVNNbUE5WFNHclJKQ0Z6NjV5eDdYVHh1TEQvQVRsY3VSS1Ezei9TVzZU?=
 =?utf-8?B?U2h1UkFtVGI4b054T0JoSVk5bjJhUGd3L0VDN1JKQlJ0WU5MdHYwL0xiYkVa?=
 =?utf-8?B?a3NnTSthM2xPcDdsUXhmVWw5d2lROVJSOFBrYU5lbXFXSjlPMDM3YWpUQ29p?=
 =?utf-8?B?Z1UwNHg3NHBzZWFuaFdGbjJDVVM5WjJsbU9wUnlnajRodUN6TFJPalNrNnVI?=
 =?utf-8?B?MUhFbS84N2JBVCtFSUNsOEY4dXVrOE5tdmxXcUJmL3orOWZtRkU4Qk4zOG9C?=
 =?utf-8?B?ZDFxVGo2Mnc0UnlUakxqU0F4SmFYbkVudE9sS3l2clFaSE1waU10N205b3VH?=
 =?utf-8?B?V0hXaXI3N2p4R0hoTEtlYlBBSEd4MWZKWU53MUhwbFFzSjJreWF1c0xwd0Qw?=
 =?utf-8?B?bnUvcHgyN3pBdGNOalQ1cHZTVThUTnc4WUl4YjRaaU1ZVmVvMC9jZW5Bbnkz?=
 =?utf-8?B?amdhY2Y3OUNrV1IrU0YyWm5TblRXd1VPZlR1dGsyRHZpTTd3dm0vZm5LdXNP?=
 =?utf-8?B?Z0ZuWU5rNVJIZTQwaFdvNDNVSTNubzVxZlFLcnQrSUlhSUtOcGI2a2VObU10?=
 =?utf-8?B?RHZQYUxHZXl4SFRyNHZRVjJYQTdBdE90RDh3Wnpjdnl6aVRsdGgzM2lOTnBK?=
 =?utf-8?B?Z0VmVGpyaDJnWVFVYndCdjFWNkpFVDdDZ2s1WThaSzZUYUt6ZmpGcGxFWUVv?=
 =?utf-8?B?cWFyUTNjam9rZFFaN0Zha2xzM1JRNXpuMXk3aVI1b1lLUFlaUEU2UkcwMmlC?=
 =?utf-8?B?Ym1lVmJuRFMyZC9DcGV0MnNPY0ZhVDAvSFAxc295MEFzZW1XWFluNkRKYSsy?=
 =?utf-8?B?MzdPQ1pnQXhnWGQzbE82RlJEa2JIMHNLNlBSN0ZDZnQ0QXR1UzFpVmt1SEJp?=
 =?utf-8?B?ZGpzUkZ4QnEzSHhtTTc5SmhlbTNlWnRldDNGZ2dNU01Nc240TC9pUlRZSlpP?=
 =?utf-8?B?cDh2R1FUZm5UWncrbm5YZHNQaC9pR2xXYTJwMkRvbUJNbjloNXU2MlAvcWNO?=
 =?utf-8?B?WUw2MHJ2eVRJTE9ZOW56MXFhZk54MUJGaFJoSWYxMFN5VnhEb00rNTRhbUx6?=
 =?utf-8?B?ak9STW12Qklmc29TQXZIYVl2NlZzbnViTm55TzZrdWtwcS9Ea3dHaHVHcGx0?=
 =?utf-8?B?TkdId3d6VFowenl3K2JuNStLUG1ibHNxSHp6bWRsbGh5bVRITm04MlA3OFZi?=
 =?utf-8?B?a08xWmlrcVJubGtOc2xaYVozZ1QzMkI0YytCdzhQS0o1K0RSVjJlYWQvSzd3?=
 =?utf-8?B?Z09lYmZ6RTJPQjdzV2ZkUVUwV0pMTWc0UmNiYlp3TWFCcCtoSmQvRUJHV3BL?=
 =?utf-8?B?QmdKUnZTLy95OHFZNlI2dzlBQnVLSEIxUjZPNmZNUzlyUUNXNU5aaDVqczBT?=
 =?utf-8?B?alIzaENIekVuS2ZyWWJzTWszQklmUjJpL2VyQ0JpSXBNMlVzRnVBQ3RHVkpy?=
 =?utf-8?B?ejIzQkJUVUplejZjWGpvaDhoWUlyV3ZSUXd5UURONnpOSlJ5QjFOYWI1cXhq?=
 =?utf-8?B?NEVoZmxjT09ycUthS0gwNm9xK2VpN0ZadjMrOGdLbzRNK2JZL3FsL0NlbitQ?=
 =?utf-8?B?YWJLTVMxeVB5THpwMWRDYjhDRmhJL0daMzNsRWR2UXRBUDdEaG1PaTZCMHRB?=
 =?utf-8?B?UXRXMmVXVWJVUS9YWnVGbmJZMzRFb0JONG93clpiOFlZOCtzR0QzejltaHBY?=
 =?utf-8?B?ZXVlUndxb2Y2RXIvOUxIU3VieXM2aWd0d2lodjJ3ZjBaZjRDeFdQQ1lKNHFB?=
 =?utf-8?B?RUV2K3ZKTEt3TWJ0eEVFL0pFcGVFa0oxNEtHMXdTenhUNXA5WUpLblU1Y2hX?=
 =?utf-8?B?UGdST0FyVmJtV21VNUlOR1RibmpFRDZHM2Fsa3BaOTk3aWJndkkyMXZEV3hi?=
 =?utf-8?B?NUs3VUZiRG04OGprbTBhYk1xYU0xZ1hHenZWanBzaHIwUURNOXN4N2FYY3FD?=
 =?utf-8?B?YmZjT0lOcEVncWNKU0ptalFtVWtwK0VBZk00VW5kcmFPSFgyeXd3aFJISHFu?=
 =?utf-8?B?VFJpcVF1QlJ5SGtINDdDYlhEeEZ2cmZRaVllSVBmdkYrQkx6eXBKcE55RkdL?=
 =?utf-8?Q?hDBOTO/lm+Iav94zBaVylVEaA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0fc470-5d0b-4b65-f254-08db5c13f2a4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:01:35.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAjdS0AMrHVHjsttkSCzWqCn2DCUjPPIInbHkTNjlHEWKI/+IS4nZ5Nj+IpF5Gz3gTX5XMI3jfeJ7t8EMw8GWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
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

Hi John,

Thanks for the review!

On Tue, May 23, 2023 at 09:39:07PM -0700, John Stultz wrote:
> On Tue, May 23, 2023 at 9:08 PM Feng Tang <feng.tang@intel.com> wrote:
> >
> > Several places use the same pattern of 'clocksource_delta() +
> > clocksource_cyc2ns()' for calcualating the time delta in nanoseconds
> > from 2 counters read from a clocksource. Add a helper function to
> > simplify the code.
> >
> > signe-off-by: Feng Tang <feng.tang@intel.com>
> 
> Thanks for submitting this!
> 
> Can you fix your Signed-off-by: line? I would have thought checkpatch
> would have caught that for you.

Sorry. The Signed-off-by was automatically added, and I must have
messed it up during composing the change log.

> Additional thoughts below.
> 
> > ---
> >  kernel/time/clocksource.c | 36 +++++++++++++++++++++---------------
> >  1 file changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index 91836b727cef..9f9e25cf5b44 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -145,6 +145,18 @@ static inline void clocksource_watchdog_unlock(unsigned long *flags)
> >         spin_unlock_irqrestore(&watchdog_lock, *flags);
> >  }
> >
> > +
> > +/*
> > + * Calculate the delta of 2 counters read from a clocksource, and convert
> > + * it to nanoseconds. Intended only for short time interval calculation.
> > + */
> > +static inline u64 calc_counters_to_delta_ns(u64 new, u64 old, struct clocksource *cs)
> 
> Bikeshed nit:  I'd probably do  calc_counters_to_delta_ns(struct
> clocksource *cs, u64 new, u64 old) just to match the convention
> elsewhere of passing the clocksource first.

Yes, will do.

> Also, I might suggest naming it clocksource_cycle_interval_to_ns() ?
> That feels clearer to me as to what it's doing.

This is much better. Thanks! Naming the function was the most
difficult part for me on making the patch :). 

> > +{
> > +       u64 delta = clocksource_delta(new, old, cs->mask);
> > +
> > +       return clocksource_cyc2ns(delta, cs->mult, cs->shift);
> > +}
> > +
> >  static int clocksource_watchdog_kthread(void *data);
> >  static void __clocksource_change_rating(struct clocksource *cs, int rating);
> >
> > @@ -223,7 +235,7 @@ enum wd_read_status {
> >  static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> >  {
> >         unsigned int nretries;
> > -       u64 wd_end, wd_end2, wd_delta;
> > +       u64 wd_end, wd_end2;
> >         int64_t wd_delay, wd_seq_delay;
> >
> >         for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> > @@ -234,9 +246,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> >                 wd_end2 = watchdog->read(watchdog);
> >                 local_irq_enable();
> >
> > -               wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
> > -               wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
> > -                                             watchdog->shift);
> > +               wd_delay = calc_counters_to_delta_ns(wd_end, *wdnow, watchdog);
> >                 if (wd_delay <= WATCHDOG_MAX_SKEW) {
> >                         if (nretries > 1 || nretries >= max_cswd_read_retries) {
> >                                 pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> > @@ -254,8 +264,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> >                  * report system busy, reinit the watchdog and skip the current
> >                  * watchdog test.
> >                  */
> > -               wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
> > -               wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
> > +
> > +               wd_seq_delay = calc_counters_to_delta_ns(wd_end2, wd_end, watchdog);
> >                 if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
> >                         goto skip_test;
> >         }
> > @@ -366,8 +376,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
> >                 delta = (csnow_end - csnow_mid) & cs->mask;
> >                 if (delta < 0)
> >                         cpumask_set_cpu(cpu, &cpus_ahead);
> > -               delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
> > -               cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
> > +
> > +               cs_nsec = calc_counters_to_delta_ns(csnow_end, csnow_begin, cs);
> >                 if (cs_nsec > cs_nsec_max)
> >                         cs_nsec_max = cs_nsec;
> >                 if (cs_nsec < cs_nsec_min)
> > @@ -398,7 +408,7 @@ static inline void clocksource_reset_watchdog(void)
> >
> >  static void clocksource_watchdog(struct timer_list *unused)
> >  {
> > -       u64 csnow, wdnow, cslast, wdlast, delta;
> > +       u64 csnow, wdnow, cslast, wdlast;
> >         int next_cpu, reset_pending;
> >         int64_t wd_nsec, cs_nsec;
> >         struct clocksource *cs;
> > @@ -456,14 +466,10 @@ static void clocksource_watchdog(struct timer_list *unused)
> >                         continue;
> >                 }
> >
> > -               delta = clocksource_delta(wdnow, cs->wd_last, watchdog->mask);
> > -               wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
> > -                                            watchdog->shift);
> > -
> > -               delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
> > -               cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
> >                 wdlast = cs->wd_last; /* save these in case we print them */
> >                 cslast = cs->cs_last;
> > +               wd_nsec = calc_counters_to_delta_ns(wdnow, wdlast, watchdog);
> > +               cs_nsec = calc_counters_to_delta_ns(csnow, cslast, cs);
> 
> So, I get it takes common lines and combines them, but as it's an
> inline function, you're likely not going to change the resulting
> binary code, so this is just about readability, correct?
> 
> Personally, I find it easier to read code where the primitives are
> fairly obvious/explicit, even if it's somewhat repetitive.
> 
> So combining these simpler operations means the function names are
> less descriptive.  I'm sure future me will likely have to go digging
> to find the consolidated logic to remind myself what it is actually
> doing (and to double check what side effects it might have - luckily
> none!).  For instance, the ordering of the two timestamps isn't always
> obvious, whereas I know clocksource_delta() is subtraction so it
> should be delta = new - old so the ordering is easy to remember.
> 
> So I'm not sure this is much of a win for readability in my mind?
> But this is all personal taste, so I'll leave it to Thomas and others
> to decide on.

I understand your point. If people all think it's better to keep
current way, I'm fine to drop the patch. 

> I do appreciate you sending this out for consideration!

Thank you for sharing your thought!

- Feng

> 
> thanks
> -john
