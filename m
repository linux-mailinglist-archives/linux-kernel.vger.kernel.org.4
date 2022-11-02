Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083EE6158CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiKBC66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKBC64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:58:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF320373
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667357934; x=1698893934;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UOQ3Lxb7ZfquwpwBak59LHgO68c0TgHDD38uBehQjQo=;
  b=TdwN6bDaoLwVGYwREeqkSAW2oWzBar97dzWnQaeRRylldEe9Q3VzVsW7
   QkzW2EEm72QA+xO6MRbOwQwBwzQNvAkyw0JMYUP0+kOWfOWcjvZpBUr+s
   hbCQx/HHVVpTDYBL7WzIo0xCxfXYbbUvcFKKAgkigL9bpYF5v83WzFzPk
   VXl7mHH9/3G4HnZ9blS6Mfj0lJuSkFHMbHH0vcyH5fR/d1Lf+kjYVdPIj
   KLHj38R5/A6ow4cqD/vTcPmDhMZtDegTs8aaaIMoGGD9nBFmBdZLTBdKE
   XJViUOseYbHRN1osm8oGn++g4cb9+uXrTkZ2gEH56qSfmFhjjmGkxHXp0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371387112"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="371387112"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 19:58:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="612074636"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="612074636"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 01 Nov 2022 19:58:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 19:58:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 19:58:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 19:58:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 19:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVESaK5c0OPR+Pehlp7VPMBi1Q8arY1kdkBaIC/uRt62BrjxfEu7zOsu3y1jlLHIlx6wkS9xj1WuLIPYagdK3013F5OqtM3Uj46uKaTzxM9mMipqt0gPefahisEwEyp4vPyBImJqHhg6TY6kPZOIPX7HasB441LnWvjiBkMWlIQrmW32B5bB2llk/abwj44Iu9GRqE1naXRPApz9A/3fDx/1rNsTx1ydM2ObCBncu38QtjHzkPPtBtbEh1fjYhOBc4H0AOgwPlOAzIMw1QqnIeT6WArDXBMllVTHiaIg40ob8SYR5QEJ5Tc4v75l+udwK3kVrQtscdDQUj+riBzP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4KlKhk16Zq1SIBMTFs3oEsDtTA3kw6k8wBGaLR7VPk=;
 b=D9CpELwT9fSxTT0E6nSol9LzpJApqGMae5+Ex77NRoLgKq9s98RciiioqVeEHdNCA+tGwNyFIjuV/RV1LKvj30bX6vsS9AbfiSFr+7IfjWQK7SmFR7eAvmlZe6ztZ2/oLv9x/6DnP3nfrvxb8r/dsnDCw4Fh677p1gnFqlGx12BjRM7Dp+CgB0pLFReuB3BKVIYuA/dqHNsggDqCZjMTikS5md1x7jc17Gx3852T1wzIMylxFVuzoKQGz7lbLWRz5feJnDzvC1WJrgknrDsr/y1OApZqC/R1PdmrgBqQvB/xTnPVtRszZ2zd775zwOOggxis4br/W/HRZ1DIc28hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 02:58:48 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b%3]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 02:58:48 +0000
Date:   Wed, 2 Nov 2022 10:58:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <clm@meta.com>,
        <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <longman@redhat.com>
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <Y2Hc47MqcGiT1lUE@feng-clx>
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1Hr6PNy9EJk245f@feng-clx>
 <20221028175245.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <Y19kStu4zBFyvKPK@feng-clx>
 <20221031174212.GB5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2CyBGNM0rMI6nCG@feng-clx>
 <20221101190627.GI5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221101190627.GI5600@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CO1PR11MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c92234-9c6f-4714-dcd1-08dabc7e29d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQjkIZ/I1saUVFOzLSWSo7UDlXLLYVpI93fQP6o4iNqNXApTpbggG9J3D+Na6wkCQ00G3i2fsYTcFDVEMzuQwZa2XISHRHgChkMCMIMooOHixdWopheJHVTKgpCwaqFappriGWR/UyvgNvrXP/ONhZA/uaVmEUsG96PtzjCmU0p7KRB3gK76xx5mAUJIOMOTf9fjCjLEWF1VEtHmaidTMduiOl1P0YAgE8/CyNef+FSsLyEdPHlirkzYWr7buZRFKxVAnMxeZNW4onFE9pEGwp3VqdDeFpwbw+qNliVf86jr57JlKEiNYRjwgwgH8BMqOU7RXhLoVqt8xUHBRAGRD4MohfuivQMRiuAi1lAMWeHAFkSdprdiWqGgI8fLX6PpgjdOu/YGnzBJg3Ny5Mv78vVITElCgYcCvT7k2Wx5ag027rE/YY4WNtc57d7ahoYq9X4JZhWVwoW9Lcy09t91VBHIoPmflp+Mdw0oWL/0cFInMdGkNsLybrnUak7VSne17v0ubGcU4q28PBpUEOq2Gkw7P1x7tqk9XMGfI26m/u5NBiO2Q57a0ejDhhIitcv4gq8XkrcczTSJLshegVGUX/E83/iFQGYaxq8VO4tVuMLHs/RoQYGICf9lj5qLPUHZcwVOa9cD3Ukh9Ade4vOoS6hOiugUQFF9BLPZhK2oskwkNH/aEnjszHmvUhNtcemlRbDR5NhOsMxRiovM+DoTSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(6916009)(5660300002)(6486002)(83380400001)(478600001)(2906002)(44832011)(66476007)(66556008)(316002)(40140700001)(4326008)(41300700001)(8676002)(66946007)(8936002)(26005)(6512007)(9686003)(186003)(33716001)(82960400001)(38100700002)(86362001)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FyF90PpiA0Pqe6K/dTZXUmWr4isd0LdYD65hlvBz1fuvscosBjxLt5UfLF2D?=
 =?us-ascii?Q?0kY3iXFCmyLrFgDGl/Pq1bK4xt+mxeLo/4yPAVo9e8XkISNG6lXi+Mdxmj3o?=
 =?us-ascii?Q?6AYYQ1DqwMDVJt0iBAvxU60HyDJbvXW0EgKxIippoM1JkgZWxXubP5L/8a64?=
 =?us-ascii?Q?eCNUfCAgxr8R7UV9CBxMlmGttJUWhEOywvYIB79rzy2dOziUtWH47T/BkvVd?=
 =?us-ascii?Q?cKnvFzNlvf2TFLv4CwHLrLNphWs8X7O5CkEH/i1gZziBMNqvWyesBalQb7n1?=
 =?us-ascii?Q?f0yxnpzqf6HTXMDLYeXbv+ceTUm74tDbFLVbRDJ65EF5MKVk1bdDcLH5z3Qv?=
 =?us-ascii?Q?IeobgphJzcgh2RoEIq8PAlalEtncN/cmu1Ob5iyXLjZ1P8lKxvbesAI3wI9A?=
 =?us-ascii?Q?Cp5fvkA21ydTJ1jEVGoc6/sCCsY4bB2d1YGM9mosTMNKwZXwjnYKj4T3aM6Z?=
 =?us-ascii?Q?o+MuVVD0tAJ8PanE17sFXwQ1QXpWbztrz3I//G0aXDXtrBmGz+6hRjBOqGfK?=
 =?us-ascii?Q?SlLZwWy2eQmVn4X9Vkw01ID8asRwnB8iWp+Pczf0UBfUBl3FUfQ8ckwKnNVR?=
 =?us-ascii?Q?MV80LBrlKA43J0aBpimgQ4XkEgS+onwRgsLL/8K4AZOwkXZ5CrZB2zOVXkFF?=
 =?us-ascii?Q?pEFpbeQ01uGxsMVQlB/zPmMZfUerBVyxutZlHEI10zbzqQZVCBI6LDzLAB88?=
 =?us-ascii?Q?01llbExMui9fL1Qz+0uBoImK79pT0a6d0tWURchrOl6nDL56Xv6sJ8pEpa5C?=
 =?us-ascii?Q?pm8Dk2GeRm2Wy6diRw1KOoO9ioiVK9VlKXNzviQrnVDT91zxr+wRurwmsmO0?=
 =?us-ascii?Q?VN1W25YBRETUwKE+3vp77P0XLB0veu84U6YwqsxBB/zjde5SyEp5R+8hhSl2?=
 =?us-ascii?Q?RdEu8V/kgo0rWjTRzTOf30ODLpwKuYSMA7xPkGC9lUSYtkN6Cx1c+7ksRVr+?=
 =?us-ascii?Q?ZvF6JaPCZeu0BB1GN++uL6/hLgoiTge7rYRIWd5+Ep2U0t8VhvskDsVGHx1Q?=
 =?us-ascii?Q?IWr9ObFa14kcp9GYRHG6wRXLtW3r+MQDhFa52XcxxpcRmjVarc2yFDjBBXIG?=
 =?us-ascii?Q?s06mzQC5sPN9SkuSIsLL3jjqHfpXElM3hVDYKD37ObRElaVMGJkLdtUiZ+kV?=
 =?us-ascii?Q?y83rcB2zXfkXKFCZ042Am2tcYAx/cF2h/IFyWXfCpEGp/gZygtXfOphWho9s?=
 =?us-ascii?Q?l6xBHMV+RLgSRm3eItjwC0s4/wS9suBnbx8rpyDXFeOmBo75B+iEYqFqVWKR?=
 =?us-ascii?Q?As/52HL9k+muDa5KhytuoW7YSPDhvEkUzgtTbXmScZC8v2CqjjQL4PcQp7Hy?=
 =?us-ascii?Q?F8g7YVDvJ3txoDzc+IqUQRWp1/el+/sUbWONwjfLf7yUsh3C0ueRK72d48nR?=
 =?us-ascii?Q?uav5Y+5+9LKPyF05wMTMAJzSlD8Yuyw/EFZ3aCvAeEA7gDxwPJPfJaAxlKz0?=
 =?us-ascii?Q?jXXZwT6nFhCtMBqp5qMdElroFqJf8GMezIWEUmxctR4IMjhbrlBlCKtkfuon?=
 =?us-ascii?Q?OZnbxUL5g352yD5M3R3e7n7Obb3UVNf61YX99A8UiDA2llNZb4a+PCX24mgq?=
 =?us-ascii?Q?zHEsNVnZLl+BAMv/AnIRDPZuDTBXmuKW1KPAr5hg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c92234-9c6f-4714-dcd1-08dabc7e29d2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 02:58:48.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7q2m2tzo5RRJhWjxzZRhBO5mazUtEh8wytic8wSHwoYWMO1y55tl2anHkhioTpQHqmirY/zbZiJjc5a4xW8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 12:06:27PM -0700, Paul E. McKenney wrote:
> On Tue, Nov 01, 2022 at 01:43:32PM +0800, Feng Tang wrote:
> > On Mon, Oct 31, 2022 at 10:42:12AM -0700, Paul E. McKenney wrote:
> > 
> > [...]
> > > > > @@ -448,8 +448,26 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > > >  			continue;
> > > > >  		}
> > > > >  		if (wd_nsec > (wdi << 2)) {
> > > > 
> > > > Just recalled one thing, that it may be better to check 'cs_nsec' 
> > > > instead of 'wd_nsec', as some watchdog may have small wrap-around
> > > > value. IIRC, HPET's counter is 32 bits long and wraps at about
> > > > 300 seconds, and PMTIMER's counter is 24 bits which wraps at about
> > > > 3 ~ 4 seconds. So when a long stall of the watchdog timer happens,
> > > > the watchdog's value could 'overflow' many times.
> > > > 
> > > > And usually the 'current' closcksource has longer wrap time than
> > > > the watchdog.
> > > 
> > > Why not both?
> > 
> > You mean checking both clocksource and the watchdog? It's fine for
> > me, though I still trust clocksource more.
> 
> OK, good, I will check both.  You never know what future hardware
> might bring.

Makes sense to me.

> I also reversed the order of the checks, so that it now checks for heavy
> load before too-short interval.  The purpose is to automatically avoid
> being fooled by clock wrap.
> 
> > I checked some old emails and found some long stall logs for reference.
> > 
> > * one stall of 471 seconds
> > 
> >  [ 2410.694068] clocksource: timekeeping watchdog on CPU262: Marking clocksource 'tsc' as unstable because the skew is too large:
> >  [ 2410.706920] clocksource:                       'hpet' wd_nsec: 0 wd_now: ffd70be2 wd_last: 40da633b mask: ffffffff
> >  [ 2410.718583] clocksource:                       'tsc' cs_nsec: 471766594285 cs_now: 44f62c184e9 cs_last: 394a7a43771 mask: ffffffffffffffff
> >  [ 2410.732568] clocksource:                       'tsc' is current clocksource.
> >  [ 2410.740553] tsc: Marking TSC unstable due to clocksource watchdog
> >  [ 2410.747611] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> >  [ 2410.757321] sched_clock: Marking unstable (2398804490960, 11943006672)<-(2419023952548, -8276474713)
> >  [ 2410.767741] clocksource: Checking clocksource tsc synchronization from CPU 233 to CPUs 0,73,93-94,226,454,602,821.
> >  [ 2410.784045] clocksource: Switched to clocksource hpet
> > 
> > 
> > * another one of 5 seconds
> > 
> >  [ 3302.211708] clocksource: timekeeping watchdog on CPU9: Marking clocksource 'tsc' as unstable because the skew is too large:
> >  [ 3302.211710] clocksource:                       'acpi_pm' wd_nsec: 312227950 wd_now: 92367f wd_last: 8128bd mask: ffffff
> >  [ 3302.211712] clocksource:                       'tsc' cs_nsec: 4999196389 cs_now: 9e811223a9754 cs_last: 9e80e767df194 mask: ffffffffffffffff
> >  [ 3302.211714] clocksource:                       'tsc' is current clocksource.
> >  [ 3302.211716] tsc: Marking TSC unstable due to clocksource watchdog
> 
> Very good, thank you!  I believe that both of these would be handled
> by the updated commit (see below for the update).

Yes, I think so too.

> 
> > >  		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
> > > 
> > > > > -			/* This can happen on busy systems, which can delay the watchdog. */
> > > > > -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > > > +			bool needwarn = false;
> > > > > +			u64 wd_lb;
> > > > > +
> > > > > +			cs->wd_bogus_count++;
> > > > > +			if (!cs->wd_bogus_shift) {
> > > > > +				needwarn = true;
> > > > > +			} else {
> > > > > +				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> > > > > +				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> > > > > +				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> > > > > +					needwarn = true;
> > > > 
> > > > I'm not sure if we need to check the last_bogus counter, or just
> > > > the current interval 'cs_nsec' is what we care, and some code
> > > > like this ?
> > > 
> > > I thought we wanted exponential backoff?  Do you really get that from
> > > the changes below?
> > 
> > Aha, I misunderstood your words. I thought to only report one time for
> > each 2, 4, 8, ... 256 seconds stall, and after that only report stall
> > of 512+ seconds. So your approach looks good to me, as our intention is
> > to avoid the flood of warning message.
> 
> Sounds good, thank you!
> 
> Please see below for a patch to be squashed into the original.
> 
> Thoughts?

It looks good to me, thanks!

- Feng

>
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit eaee921daa7091f0eb731c9217ccc638ed5f8baf
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Nov 1 12:02:18 2022 -0700
> 
>     squash! clocksource: Exponential backoff for load-induced bogus watchdog reads
>     
>     [ paulmck: Apply Feng Tang feedback. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 6537ffa02e445..de8047b6720f5 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -442,12 +442,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>  
>  		/* Check for bogus measurements. */
>  		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> -		if (wd_nsec < (wdi >> 2)) {
> -			/* This usually indicates broken timer code or hardware. */
> -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> -			continue;
> -		}
> -		if (wd_nsec > (wdi << 2)) {
> +		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
>  			bool needwarn = false;
>  			u64 wd_lb;
>  
> @@ -470,6 +465,12 @@ static void clocksource_watchdog(struct timer_list *unused)
>  			}
>  			continue;
>  		}
> +		/* Check too-short measurements second to handle wrap. */
> +		if (wd_nsec < (wdi >> 2) || cs_nsec < (wdi >> 2)) {
> +			/* This usually indicates broken timer code or hardware. */
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			continue;
> +		}
>  
>  		/* Check the deviation from the watchdog clocksource. */
>  		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
