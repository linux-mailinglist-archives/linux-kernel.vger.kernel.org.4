Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74BE653BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiLVGDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiLVGDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:03:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD71B1C4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671689020; x=1703225020;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lV5ka1O1FxNhSK5ikwPlySCmQKx1BrCJ8zWlsMKZzOA=;
  b=c7Yi7/fAKRZLUVVH8LzrwvcWcLnshRqWs+aM11Iirhg/Rss0qyhzHfcY
   DI9ySeO9FPsyK54WIUOKlAkjxy5/XBjgfzVOnxukj8jwEfvxxtt3PS99J
   u1H8Lo3YEs+MpLzJYMbZYxa/d5QMOY7XFry2H4jSOIm3V1FkuR/+U+BLb
   X3DIaGv8EJsN5QbMicCnDtqP06psag+VQQWrusy6PKaCzJKhOSysSv/Eh
   ylhD3yccNYnwoLyB8NU18RZornvBGlyLQjQR6rCV8Ip6kmzuhLFW1xFdM
   VsIdrEBc6vmYf87bb6vW6UoKljhq7P7gQhhoZ8uxusiPVvgd9tZ6TOmec
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="299722758"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="299722758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 22:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="645089956"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="645089956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2022 22:03:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 22:03:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 22:03:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 22:03:37 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 22:03:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvyIwvKXU8nqPaSZkueYwcY4avliCeZh7okSde+xGgxh7dV+V6Ta5ds7ClpTbbQIkMMmAe+LnCYGEBDJmUUwkFWPYAixN45I/19fB2Ili97dVbJJmpHoSR83FXmoNRYBu2un3oZefKUu6SUhi9K7qV0/UxZOCkFhb0sGYhXGNgwaea5cnQqKJt4j96xQN0GO5XIcs85ZuFhEWh5EgIsB2G7IX4F9mcYG/0CviP2BA6LIbna6yXr4okuOHO4NejsLakOQhHzAsNTniynFd+rd4FUrhSdrEp36NCkVV2YinVi6PHxmx45WPGQuZ+pvpEC9O6ss/y+lzU3Ui1ZNcR/CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIn4XOB/8RSS3612xU4xAoXu8Dsa1oc/sNIKLOtsL44=;
 b=DEHLZePjBcrFk0ZOsXr9/cZVtVvNbUwwXY74+wq4KX2Fb4JwACoAxbU7XRpXC/+6mbLejAUjhtvd60fzyo4ccuE/+4ngBBUVg/LEjQdir23WcJ/VwGaCoEex5Pkp7iUsXGxmSWHsSXVqyLY7kngaGZHqp/KKwYIowpwore3mUmfJxhB1pxJ7GuHeKVk/dZ5IiuHQR3y5RJt/5UKLe7sJFIi4TMHg11elu+JJQK/+DJn9jd7v9qqLjc0idhPelgd/HWmsMZClNmPnuS976hSCzZfK7dO7KKQkmijvN7ebAhQgc9YL5fubCifF8IKy7PLkz43H7e6UNietcT62IVi0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA1PR11MB7088.namprd11.prod.outlook.com (2603:10b6:806:2b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 22 Dec
 2022 06:03:35 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 06:03:35 +0000
Date:   Thu, 22 Dec 2022 14:00:42 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <Y6PyisHYYtde/6Xk@feng-clx>
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
 <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6Ja+kYQAi4pppV6@feng-clx>
 <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
 <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
 <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA1PR11MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f4a4d5-73b8-40d6-545a-08dae3e242ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7T9sRq1JQmCCXWVzpPrRRN8XPY55GtPkPmY0sIkdD1BqIMZP6zRdTLwwU6Dsg9rcAlJgJSbx2mieCPwxVxz2VFisAgy/dPIX/txDOBMX0YnSWLpy7ZB7ZGmL5MmaKpqTbWz/Q4eCF58ZnphdYhQG7R7AKcqobkX8xDAUb0Xepxu+pWJr7UyT5C0aS508aThZO/IC2GVyDOjClA9ZgAbgZgTv8O8tR2UnHLLTNCeCb2dUINU6rwh00KFLemo3aZT0gjLghS1J1eFIvpwBwgLxqYzqbiggha32AhUVt8ACIEYP18tTgmV/+MqG+YgH1wqBz8JQ+nCqx03JxSYMEhGgAlUSKYjZGcGriZEYjg0wZqMObPHeCoC6Bh5UPHTIxUPUhAd05vzHyLt/u542kH3dqc5cVUv0V3cvE4vsf6AEe0V1YC0IbSkPfWcqtYuxab2HEW2Rn+amF+fS8GhpBGyrowdp+rtCt8if5hjzTG1JV++EuL8Dv6ozOafS19eCEy9he1cgmqo1ofgMzOrhJvuaXOhoiQXoLxb7zLMJtzvgY/5DqhFtpPnb+RSs+OqIud6X85AouYoaRkOugK7W/xUZLbtRN7eLyUCpln6j9WJM4s/L0Kf561Ds11gr9neMBlgiUm4X4CJmvek+iDWv5Fk9lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(8936002)(5660300002)(107886003)(82960400001)(38100700002)(478600001)(41300700001)(86362001)(66946007)(6666004)(44832011)(66476007)(316002)(15650500001)(53546011)(6486002)(33716001)(186003)(6916009)(2906002)(6512007)(4326008)(54906003)(9686003)(8676002)(26005)(66556008)(83380400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lsqUL0655tXXoCFVfHtcpM5Cmh4hYDEzy/Qt/ynJBZ2/eZYf/mOtDyCp9v9l?=
 =?us-ascii?Q?pMPwx5Y4sE8PI6Rf6L11MagxLm+L5vPeVXamMZq3ljRdHs8O12F9UNoRYKms?=
 =?us-ascii?Q?vyFB7khWNb9ySYRTUHkkNhykRAV4roNyY917LW/MGbTU79jiMDfsV580GPte?=
 =?us-ascii?Q?gSHmsWicjDiZZb3fe1uwNxbVcMCNKRtSytsjsO18GW/q9nNYjHFXKVpXmz2Z?=
 =?us-ascii?Q?HGVAhVTg4+HC1G4p6jRi81Yt/uSh9vJA75cb1wG5zhKemck2K5ji7BLIm67R?=
 =?us-ascii?Q?ajLcZOtpMHH+bQcrFMcza4Vh8f5kWAZ7ddo7+aUtZPi4fzDx3zMrgvYGhvbA?=
 =?us-ascii?Q?DX6xM8GckAE4RS0oKkGI+1c2jkLd7Kokd9UPvEpAI9C5y85YIaon7hpm6n3Q?=
 =?us-ascii?Q?zKFoXLtYuaR9kkLmPDL0x/A7jIv/E8Lra4LAkJW5atTPa5w4wfMpXAy84/GR?=
 =?us-ascii?Q?80CmZjny62G7nFQ/VsxSmvWDDr82wTVuu8WytirwgkLN1z4iG/cxDQ0+yqGU?=
 =?us-ascii?Q?P5DjVXfD/xZyzNYwtY5dKgwRNoA18GoQDgPmug8kCvZwnWsNkmIg5r4ogTId?=
 =?us-ascii?Q?o/8vXCUP5osv01wM7vjLPYcNhfRJrKEH5oZhht+wZQfm8VQo+4lVV7tG8CSB?=
 =?us-ascii?Q?tjwAF3Cswe20b+1dVJLMDUFUbNgAgXz2YI6rfgE9lMFVLTcy/vYljwmxtWHw?=
 =?us-ascii?Q?faShUayg3OcWGsALAvFZKdPvZyUNKZYgZojor/hyonlKlXJi/zoTOUCGBnVu?=
 =?us-ascii?Q?MqXB1zfvp6KqyG7P3ZLlE+FPcr821umRblOhh5Eq4pJ2kSqIsX4KXGoIbknz?=
 =?us-ascii?Q?mfH0gmrTqNfqU9LCfPCZ2LF9j3F0wYzQDEiwGxI87uxu93/xuq/t05vHk5Zd?=
 =?us-ascii?Q?1qbYveE9KUXx7LuKyFNGUU8Fqh0HDCiikLnNKQe67rib9A8sAmObQFTfwWKB?=
 =?us-ascii?Q?ee4P0rFLKaiIHIOi+st7v0Tc/UQvyUQXk7Cb6MJlvLGgThMYie3tVmc3ar5s?=
 =?us-ascii?Q?k1VcpXdUB3QkAdERUTkPxmvixat1Wi+rMqe1rQAHubAOFgH+oODHGy8aw2zf?=
 =?us-ascii?Q?IHGQAiUkIdeZaggfaQUTwjw+H2z2D94kw7/ZvqPlDPzm1o0MEkYWxFI/p8D0?=
 =?us-ascii?Q?sXeGygFH2vYNZ02Ra6BaZKhFB2wtNZ9ImBpyYy/5xxOOM2+gU6MaGMNp8U/Y?=
 =?us-ascii?Q?GDip1eM396ykigIszrJL2BCgYunDdp1Dz8/6vIsPgLFBbFAHZoBnR7ZOIOFr?=
 =?us-ascii?Q?1+6hX+MaLcFGwxEZta68f7LxeJfc9iWPQ/+fEkj1NWU+Liq0SVfdUBRmBvRM?=
 =?us-ascii?Q?XEOZ/o9q9A0O4DZt3RMmD4RDKmN3FkQlCYl+ZJYNtuuQyqmsIqidlhRRbn2D?=
 =?us-ascii?Q?efA+AMtyp88qcdfBYnlwkNpz3EkPUo+JQDUsPCr35Di0+1uOwfg66rYAW1FH?=
 =?us-ascii?Q?fo8UGcyqqh/IiWEd/Lfyf9kL/5rB8PxzGdtH6grCvMd98lWLgMue/y3xEiYi?=
 =?us-ascii?Q?SRTsr4epE3gB/GktcfFH3WooVi0zGmE0KQcP7uL+z0pMIvEIqMeo+md8Btg4?=
 =?us-ascii?Q?2hGJzVvx2KVyFIXX1+6sZsTnnT23ONwLAjekAfK2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f4a4d5-73b8-40d6-545a-08dae3e242ff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 06:03:35.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUERPRk3YKg8Na/u5jr8tOD2FMOn5/9NQYDThm7j28eXtgqwXwcjKpWBJFC5fJkvtWMGxCsfa+ct4NIgUL6Zww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 09:55:15PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 21, 2022 at 10:39:53PM -0500, Waiman Long wrote:
> > On 12/21/22 19:40, Paul E. McKenney wrote:
> > > commit 199dfa2ba23dd0d650b1482a091e2e15457698b7
> > > Author: Paul E. McKenney<paulmck@kernel.org>
> > > Date:   Wed Dec 21 16:20:25 2022 -0800
> > > 
> > >      clocksource: Verify HPET and PMTMR when TSC unverified
> > >      On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> > >      NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> > >      TSC is disabled.  This works well much of the time, but there is the
> > >      occasional system that meets all of these criteria, but which still
> > >      has a TSC that skews significantly from atomic-clock time.  This is
> > >      usually attributed to a firmware or hardware fault.  Yes, the various
> > >      NTP daemons do express their opinions of userspace-to-atomic-clock time
> > >      skew, but they put them in various places, depending on the daemon and
> > >      distro in question.  It would therefore be good for the kernel to have
> > >      some clue that there is a problem.
> > >      The old behavior of marking the TSC unstable is a non-starter because a
> > >      great many workloads simply cannot tolerate the overheads and latencies
> > >      of the various non-TSC clocksources.  In addition, NTP-corrected systems
> > >      often seem to be able to tolerate significant kernel-space time skew as
> > >      long as the userspace time sources are within epsilon of atomic-clock
> > >      time.
> > >      Therefore, when watchdog verification of TSC is disabled, enable it for
> > >      HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> > >      time-skew diagnostic without degrading the system's performance.
> > >      Signed-off-by: Paul E. McKenney<paulmck@kernel.org>
> > >      Cc: Thomas Gleixner<tglx@linutronix.de>
> > >      Cc: Ingo Molnar<mingo@redhat.com>
> > >      Cc: Borislav Petkov<bp@alien8.de>
> > >      Cc: Dave Hansen<dave.hansen@linux.intel.com>
> > >      Cc: "H. Peter Anvin"<hpa@zytor.com>
> > >      Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
> > >      Cc: Feng Tang<feng.tang@intel.com>
> > >      Cc: Waiman Long <longman@redhat.com
> > >      Cc:<x86@kernel.org>
> > 
> > As I currently understand, you are trying to use TSC as a watchdog to check
> > against HPET and PMTMR. I do have 2 questions about this patch.
> > 
> > First of all, why you need to use both HPET and PMTMR? Can you just use one
> > of those that are available. Secondly, is it possible to enable this
> > time-skew diagnostic for a limit amount of time instead running
> > indefinitely? The running of the clocksource watchdog itself will still
> > consume a tiny amount of CPU cycles.
> 
> I could certainly do something so that only the first of HPET and PMTMR
> is checked.  Could you give me a quick run-through of the advantages of
> using only one?  I would need to explain that in the commit log.
> 
> Would it make sense to have a kernel boot variable giving the number of
> minutes for which the watchdog was to run, with a default of zero
> meaning "indefinitely"?

We've discussed about the "os noise", which customer may really care.
IIUC, this patch intends to test if HPET/PMTIMER HW is broken, so how
about making it run for a number of minutes the default behavior.   

Also I've run the patch on a Alderlake system, with a fine acpi pm_timer
and a fake broken pm_timer, and they both works without errors.

Thanks,
Feng

> 							Thanx, Paul
