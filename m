Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823E1653C39
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiLVGk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiLVGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:40:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49AC103C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671691221; x=1703227221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6xFnQhh3cJllreWWui7xqIuZUMBl8WN4sh6N1cRSc70=;
  b=fVeK6GYnrB53H0f1ufdZXfT/ttnASOwqr6DrJA/bSvYEDaWt5PSXGrLd
   hWlRAAQpcPXvQkp23LQ2SfhYH0YA7fIIRpeeblc52GVvxJNp7CkD9UrwL
   LlgOSQ961W+RcKBow9JzKTg6tI3lIKzhqBr23E5Ob6p0ohK57ZWprY514
   Wkk6tBhHr27LZHVB2xhPlqt51WgthK93HmiMy3jf7riz7/iIldf5F2tpf
   uqUu/u5xtxStV44dFlN8r83Uce+Z8uZEtQ41C3PYOEbnQnoeQA0xTDK6X
   ZyiR+qRIQPUxHVlSGJShhg+yB8XeTPfBzyAL04fSra/EAX+lQDO3nGIER
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="317695478"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="317695478"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 22:40:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="740435140"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="740435140"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Dec 2022 22:40:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 22:40:20 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 22:40:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 22:40:19 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 22:40:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmfEbdu6xl8plL2ax0fahfBEL0RC7YwqGQ6wpv4Ciq+EJ0AOcmsUo/zyFHwAT+sJ+HlRQbtVbnqVcHbOSNrt8Oy0Rt+wVniWm0XRvmtuk2IbqjcwqCctVh0ms8vl01eVgSPx/b6T4haL8cyZH9hPG8G7MNfi9w7KO7cevs7GYf+XYJBQxGJSLfjrNHfWP540lvDJCwnvi8Mcl1IwWWe/m9dyRqlp9ryMxxy8MPEl0BXqTBuziaznTmxeb2l5kQsZlTcNY1ig46+Epc5vvuSg4om6XD2Dmg5YVUjJ8SNmDmZIZlAZY5fdkhbtXVRe4dsZ43J7VaLGY6lxBIxEiX/nQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XABFcy1LIWpEqlA37laYcuFwylM5piUy7hW26ybx+1Y=;
 b=mmy4xo+UZbx+KnmO0y3YRMjlIECCXfO3coUs/K6o8xXIsCteNO3VcsLgXZgspHYVS2SzqmV7iG5K6YrAqMZSy4fdm9jrmC8+ARUbfG9h8z4QMlui6V5CPph5IzDYrr7pPmRy+8vS6RnZ5kZFLTlHgRmtIRQfDLdSc+KftJsw04LDwFD0Tsk36yu3waXyETpKZHMTclqCYHL++0kiw96LfxQB0Uk2QMntvoRJb7aHpp3yxaXNzEgTu7Aj5m+6aq0BFgtksIMTC9VkLZaiYPh7a8fvqL9VR9f8KRxsMCjDgbMoCj/AVaMCFk9sEgezF/xl+EXaASLYNOfiEUc6Rp9P0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 06:40:17 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 06:40:17 +0000
Date:   Thu, 22 Dec 2022 14:37:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <Y6P7JPHf9wDse0XK@feng-clx>
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
 <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6Ja+kYQAi4pppV6@feng-clx>
 <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
 <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
 <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6PyisHYYtde/6Xk@feng-clx>
 <20221222061429.GL4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221222061429.GL4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: ab95350b-37c1-4762-82b7-08dae3e76378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zywRzrxnh6RfnL1ZEF/cC132DTULlFrLpLoLusNWLm2Jsp0317Gs6Pgw/cDOoyu6FJZZBlkrs+CPMPzxKW+aCnBrngYshB/MEc+MSSwpf6PH1SWeCwqnagKFgY2N+aqyzcl4J4e9BZySu6m7RXI1wv1+s+zol2Z2X6JcxyXigm5bCIgIjaMbOK8VkjJkbsFuJTnG2+H1g8BidLPBqNWDsmk02oEMGCGKCR37YCDwxIu2F9omvKC46MbfI6BfCvtdazpqErHj4hy1SpgViY0b/Ulebu7/+evcKEoPbQbGYRumee+x3+Y4W+dg8pS2jRVtaKp3+30iw+WcPThxdrupiYOYUD3yD7VI0E4DuT1AbfSMMem4jpBERkK+V+LjMW/maLDqdWSLnnUJRVsvFm5nz7uYO+5oU4gNOoBo2rGyMg0Ea5rqz1Ktln6IBGDaHvBZs+xVbS7s9jCHjdbSI3zVoRQW1qW83Rfas4D5rXbp7ddQEdeQ2EknYO0rdudeojxDaKzFcTBU+Ams2+OMTla45VA/KmUgXJ6EuiMxArq6meQdQvdKh+nvPeOWqrYxSKoqytI3CqKb3L7zqPNKEL9Ug4QzRGhppNjfQAU/8IIpfXMmjlpsvexgfZDWgRQU0BwNZK59NvWq1w99ltwVegXpXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(107886003)(6666004)(66899015)(54906003)(83380400001)(8936002)(33716001)(5660300002)(6916009)(15650500001)(6506007)(478600001)(9686003)(66556008)(6486002)(2906002)(6512007)(41300700001)(26005)(186003)(38100700002)(44832011)(53546011)(82960400001)(4326008)(316002)(66946007)(8676002)(86362001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LC2vJp9PoF8oug6sa3CnmdPI63jv3gZwJyhFFJ0K/kXM8oEH4wSOyucGzEx?=
 =?us-ascii?Q?d+bASxXCQ6aN6rTgDxNw2WNcPcPclM0ynjlD4XDpD3URgFhEweefHDGG/NL3?=
 =?us-ascii?Q?+wgGHaqTlP0sbwJEJFx04YHkJs1w3/fwR+8+9nqE5gyl4xpPHG6lV2AowZ/v?=
 =?us-ascii?Q?z2oNI+hU66yOAJp5nujaOxiqfzMIOqx+ure0TbK79aaYto7Mt+JIDXEdEqwq?=
 =?us-ascii?Q?GAPqJqmmtYg8NBuqG5cpy7OfW0syKGi4GjHyRXHZriLNaZugqQoPT14JIpkf?=
 =?us-ascii?Q?60xJVXmRUoszep2nVtWT7dynBd91oSyevKxs8T8Mjeel3nVSklAK15HxQOE9?=
 =?us-ascii?Q?AET8F4GorwuET6Dr0+PXhMnv62+94kniRsUBiPM+4yaT6gaAFL4BMmYIqNqK?=
 =?us-ascii?Q?0M7RfxES3k8A1FQzRwjqu9ik5ZAJhjbwAuHpmiAr1VtfL3s3YNfMPYZ3Wnjq?=
 =?us-ascii?Q?ep23Y9Gh8IBENNRgeUsFLN7d5WjJ+YP2dd3HrLdFyInBS+hi9NaiQhYPAyio?=
 =?us-ascii?Q?B2nCim5ZmeIKfLXIHzf5XpsrfKXUhG7M1eWHmVeb2qDk0+V2bQGkSYAXABwT?=
 =?us-ascii?Q?MECd8yRPbdZ3xMEcbHFTzL+livRcX44tQ9Y8pKl8MPnn9wZ6EIfKqMwgXMfg?=
 =?us-ascii?Q?nFSMOwJIsRvR0j5KaQxwwCTBiAG5+0b+YYWQ1dJ4yDE2lyd8DJE/XFQppzE8?=
 =?us-ascii?Q?CD+WzuF4tqXwlA8HAoPlfo4COsHiagbQJmV+OsM9v/QWJaAyq4NDEGTqp9Mn?=
 =?us-ascii?Q?EmMdQrizTzDbeiPdv79+73cXLutIskOtG9jnU2Ei7GJRMRYEohRAGajfuUfb?=
 =?us-ascii?Q?dMnJl0Fs7UhEhrtHnmzAdNdw0e+ETp9cl8Oswb2RNSHxW8/WC/tD8SyqEHPV?=
 =?us-ascii?Q?fQLK3E0Z8dn6Jw+1mf0zfO/6ALx5iVTE9QkaZJTdvsJX349sCoMVcvUm/S+U?=
 =?us-ascii?Q?yE4SGriZUge1TNJxP+i0NsKsaVGz4aTfqP6HDVPs7pPBIf2FLqEJY1DP9Fpn?=
 =?us-ascii?Q?cUFc1DCBQV9DQsnzf1UAoaxSfwo1D+i+WujE8M9VxBZ9nWCODkJVFAx26KV+?=
 =?us-ascii?Q?3uEFBWxDYOCNckx3e8CJeUqQpyXejbofoVO3ydVpYGXiEj/rdCDV/Zs0U0/O?=
 =?us-ascii?Q?x57WFM1nGu/UNMZjhAQqcwmyVSAkVSpGvNOaXc88uS8XNhaqLRMIKxcJ1Vap?=
 =?us-ascii?Q?ThYU1AzaKWA1rly+DYqnAA/bjWuj/El/ESkNQTgJgDWxfSyhMLSPqU52I9x3?=
 =?us-ascii?Q?gM7uXwuIpZXEHRabxWmkw/6j4d61CE5azdM9B72oFIhgFEBvlC7cHjTI0sYa?=
 =?us-ascii?Q?EpK+sjbMD6WxN3gw9MLA+/JThuv84kd7VIagHk6OhGxqOaiI2iWZLusP2t2I?=
 =?us-ascii?Q?3zXk8aso2oSqDsg0I8FMF/oah2EFhZQFhooBu2+uUp08KC4T06ZNHeLumGtN?=
 =?us-ascii?Q?soXpF/oI9mGf0NDQeM4UmsRdR28+4VlgElE6E7n4pCTF5uiGYSxsQRxgrJnr?=
 =?us-ascii?Q?S2drnZOjL6U6OVT4jfyHRiWFf5UZccbYgg3AfAzorVl+y6JNbmDh7bKGKwWw?=
 =?us-ascii?Q?PGJ6cWvF1ttwZXbkLG5A8NDNSYk2MUbjj7NxXHHg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab95350b-37c1-4762-82b7-08dae3e76378
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 06:40:17.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th25qFOG3l1dmVoKvpdGTrvavnvusgqx27nMBkf2VZukXz8P8jswxkeW0IBzjRqtFPZMq+o8hpuB3Im8i/ilBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6006
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:14:29PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 22, 2022 at 02:00:42PM +0800, Feng Tang wrote:
> > On Wed, Dec 21, 2022 at 09:55:15PM -0800, Paul E. McKenney wrote:
> > > On Wed, Dec 21, 2022 at 10:39:53PM -0500, Waiman Long wrote:
> > > > On 12/21/22 19:40, Paul E. McKenney wrote:
> > > > > commit 199dfa2ba23dd0d650b1482a091e2e15457698b7
> > > > > Author: Paul E. McKenney<paulmck@kernel.org>
> > > > > Date:   Wed Dec 21 16:20:25 2022 -0800
> > > > > 
> > > > >      clocksource: Verify HPET and PMTMR when TSC unverified
> > > > >      On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> > > > >      NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> > > > >      TSC is disabled.  This works well much of the time, but there is the
> > > > >      occasional system that meets all of these criteria, but which still
> > > > >      has a TSC that skews significantly from atomic-clock time.  This is
> > > > >      usually attributed to a firmware or hardware fault.  Yes, the various
> > > > >      NTP daemons do express their opinions of userspace-to-atomic-clock time
> > > > >      skew, but they put them in various places, depending on the daemon and
> > > > >      distro in question.  It would therefore be good for the kernel to have
> > > > >      some clue that there is a problem.
> > > > >      The old behavior of marking the TSC unstable is a non-starter because a
> > > > >      great many workloads simply cannot tolerate the overheads and latencies
> > > > >      of the various non-TSC clocksources.  In addition, NTP-corrected systems
> > > > >      often seem to be able to tolerate significant kernel-space time skew as
> > > > >      long as the userspace time sources are within epsilon of atomic-clock
> > > > >      time.
> > > > >      Therefore, when watchdog verification of TSC is disabled, enable it for
> > > > >      HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> > > > >      time-skew diagnostic without degrading the system's performance.
> > > > >      Signed-off-by: Paul E. McKenney<paulmck@kernel.org>
> > > > >      Cc: Thomas Gleixner<tglx@linutronix.de>
> > > > >      Cc: Ingo Molnar<mingo@redhat.com>
> > > > >      Cc: Borislav Petkov<bp@alien8.de>
> > > > >      Cc: Dave Hansen<dave.hansen@linux.intel.com>
> > > > >      Cc: "H. Peter Anvin"<hpa@zytor.com>
> > > > >      Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
> > > > >      Cc: Feng Tang<feng.tang@intel.com>
> > > > >      Cc: Waiman Long <longman@redhat.com
> > > > >      Cc:<x86@kernel.org>
> > > > 
> > > > As I currently understand, you are trying to use TSC as a watchdog to check
> > > > against HPET and PMTMR. I do have 2 questions about this patch.
> > > > 
> > > > First of all, why you need to use both HPET and PMTMR? Can you just use one
> > > > of those that are available. Secondly, is it possible to enable this
> > > > time-skew diagnostic for a limit amount of time instead running
> > > > indefinitely? The running of the clocksource watchdog itself will still
> > > > consume a tiny amount of CPU cycles.
> > > 
> > > I could certainly do something so that only the first of HPET and PMTMR
> > > is checked.  Could you give me a quick run-through of the advantages of
> > > using only one?  I would need to explain that in the commit log.
> > > 
> > > Would it make sense to have a kernel boot variable giving the number of
> > > minutes for which the watchdog was to run, with a default of zero
> > > meaning "indefinitely"?
> > 
> > We've discussed about the "os noise", which customer may really care.
> > IIUC, this patch intends to test if HPET/PMTIMER HW is broken, so how
> > about making it run for a number of minutes the default behavior.   
> 
> It is also intended to determine if TSC is broken, with NTP drift rates
> used to determine which timer is at fault.
> 
> OK, how about a Kconfig option for the number of minutes, set to whatever
> you guys tell me?  (Three minutes?  Five minutes?  Something else?)
> People wanting to run it continuously could then build their kernels
> with that Kconfig option set to zero.
 
I don't have specific preference for 5 or 10 minutes, as long as it
is a one time deal :) 

> > Also I've run the patch on a Alderlake system, with a fine acpi pm_timer
> > and a fake broken pm_timer, and they both works without errors.
> 
> Thank you!  Did it correctly identify the fake broken pm_timer as being
> broken?  If so, may I have your Tested-by?

On that Alderlake system, HPET will be disabled by kernel, and I
manually increased the tsc frequency about 1/256 to make pm_timer
look to have 1/256 deviation. And got dmesg like:

[    2.738554] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'acpi_pm' as unstable because the skew is too large:
[    2.738558] clocksource:                       'tsc' wd_nsec: 275956624 wd_now: 13aab38d0d wd_last: 1382c1144d mask: ffffffffffffffff
[    2.738564] clocksource:                       'acpi_pm' cs_nsec: 277034651 cs_now: 731575 cs_last: 63f3cb mask: ffffff
[    2.738568] clocksource:                       'tsc' (not 'acpi_pm') is current clocksource.

The deviation is indeed about 1/256. And pm_timer won't be shown in /sys/:

/sys/devices/system/clocksource/clocksource0/available_clocksource:tsc 
/sys/devices/system/clocksource/clocksource0/current_clocksource:tsc

So feel free to add:

	Tested-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng

> 
> 							Thanx, Paul
