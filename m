Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB9747E68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGEHmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGEHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:42:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532BBDD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688542936; x=1720078936;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x2nHFL5aDBW6xVZeiHcJfx60PBIbSC8v/agGmJBmths=;
  b=dKNPaVaMGTW1EKhwB4988lpHyPrDmugkHsgU1VF1rse6Irga7M12y3NZ
   D/4T+ufFbP19SrK8UPoRnDehbF5TebC4BULdNMWqs8twlKnpqRLct91d8
   1c5278/Ieu5M88yIQFUmW2oXTaWKPa4FIEXBBjvBGEyzEy2yHPo6CwQ0R
   HYhSdH/1h9x1/gq3JXe5R6YLMIMmF5jR587s0KFKVq/3kvozB2DalT/72
   OjLlORUHs+IK8zcuezyDSMM/tFXwnHZXrFIXOJT4gabkKiUYwIwyRVeKq
   U+C25pS/O5BLmEGnwnx75F9ix4ASDIFQ8p102NI/05JAN4VKcAfg5wxdT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="353103877"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="xz'341?scan'341,208,341";a="353103877"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 00:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="784434764"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="xz'341?scan'341,208,341";a="784434764"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2023 00:42:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 00:42:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 00:42:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 00:42:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 00:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiaU2UJQJ6CGdwFq7Ei2dZigIGCXV9rjHPHlkSRO13+5GcckYCGM6weXzd/O82X9HHePj0NPQ6gU0cHKyH5EgU3r72Bg5Dy6eIdhOV68xYuYDHDpmnkQh0hdEkdncgQ+MazLv46dA2y8ped66jJMy8LFD5Bnw9T7Y5aW3LN+r6rAZE3qFq3pdEBLJ42o1l5ocs35Fvs2faTbJP85X1XMMF0deJRSsk4/q1bTT3dM+ewa7kbPZ1NIfMSQ0yXySnPZXeahY9JNqbdXKfZwuj/It+6+mhREjduzGUAnbXpyciPFkm+vO/j+a0mJI4dgudn+HwcTufXbOzv39UZbY5egdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUURn6RnsjegfQFlrhQc0KRclN2v3RnCUdbixaOimEE=;
 b=bmTlETiUhu8T8VS0/HykwNQltucgUZy3/H2VbJ9dz6eU7SwrFIklR0IefMKBBwuQsYfa+TeYj2pLyPN7geg4XE/WNr1DU/l07VA6S+Wla7EgEcwCwoUu0yWHEdBkQGHZL8aa7wbCYoDaoT0v5NclNrRYGGjFBsmW0lqblFnui00UtcmaJy58UADwsmOH74yIsghIQWdM1nk1PyFdRZNjSdNRYfJBHiWrWSSoUimWzOMWkyJUOvOJ7SiR9fuOO2+Kf3KjAwNuDurveZ56BXfPzrixnddHLxvdpXM2Jt5TmG899r0nSxX9kPgJ00DisSCRiJGdy0GQvk03CIq/5MZseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by LV3PR11MB8458.namprd11.prod.outlook.com (2603:10b6:408:1bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:41:59 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::b6b6:4109:345a:2aab]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::b6b6:4109:345a:2aab%4]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 07:41:59 +0000
Date:   Wed, 5 Jul 2023 15:41:50 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <oliver.sang@intel.com>
Subject: Re: [linus:master] [gup] a425ac5365:
 WARNING:at_mm/gup.c:#__get_user_pages
Message-ID: <ZKUevnyH8EDM971n@xsang-OptiPlex-9020>
References: <202307041023.bcdbbfc0-oliver.sang@intel.com>
 <CAHk-=wi3Nb4t-JH6BGE5TOynik=-0kXyBGi3bLKTA85rvqHngQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="L0Q8P3f2Fl+W9S90"
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3Nb4t-JH6BGE5TOynik=-0kXyBGi3bLKTA85rvqHngQ@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|LV3PR11MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: fcce9c1d-cac4-4a38-b829-08db7d2b5047
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bi1jhb3jju6ZfuRUDTdORbitmo0PQiE0GUFIT9zTk113tPhaOLBMoou/soADgq+toWMlPPPezbzTPfvuwAM0cuvQLrB5YzqPZMlYMErsJTFPK/5Aa2UGCRRZ0yi7ZxI1JT8aOkHhcKdop3nN5yCiqYJVXvnxhZEerju+lQq2YpQSVRT+9HJTzbCb2pmEmd7Vj5NE8qCj/cLfnPDuNRbZmn2mVPkcYDyG1315qa90cjkDHoraz8Lm4XozFjhYb83r47Akedi5aYhpqje/g/YpE245znGCCDF7ydVCZOldpu6eJug1WxxVPQNSS8HJZzN3FAhaH8AaakoTG7C//43/8AvJE0wfv9I+/NEW2KyyRK3Jlh86MrPa4kGs/Vs6xdq/+89IG+h+23Rb8AAy3vSHskVJjbnSobs7Y5L+FbZmKBXWofTyhyiqH7HJU5pfUX3etmaij73l/T9p3NErcbCuzzY88qhG+j9lfY7fxPKpRZudy1vnKAJg9onpXjmsOOU5LcagXYlt9eO6ia3zRTQjx8WuKt3KPvfara2/QmwZ9fS4IVKr+XIIslc0cxQW6w/bIZFjufKaIsDpMiIAeV95ibDZQVhZ8s3JNxE+TRzgyKPQ2IPQOy9+gNjwCZ4ewRtYJldvxc7JS7VtVWcBVa6fWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(44144004)(6666004)(6486002)(478600001)(83380400001)(86362001)(2906002)(66946007)(33716001)(9686003)(186003)(6506007)(26005)(107886003)(6512007)(38100700002)(82960400001)(6916009)(66556008)(316002)(4326008)(41300700001)(66476007)(8936002)(8676002)(5660300002)(235185007)(44832011)(2700100001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8wGdMny6NAyYM9VMINm4QtK7gG/uhEbip0W444WlGm2yRkNoOyOjGl1YPDc?=
 =?us-ascii?Q?WkRH1/JUnrE68971jURgMCuP6uE8izb+BCIvXUSVY8D0T8XHuoQFJnGp+kVy?=
 =?us-ascii?Q?vA1NIIeaQHIBLGXBV5NYR0y7oRFH6Qsy1IQF7PzRJzNdgbXYJgtz4fTueAql?=
 =?us-ascii?Q?te92YxYHe5PR79DdH6iTvoIE6hrJeKoXkenVjaJkQ+7lb4OpFt9mCZY484Vy?=
 =?us-ascii?Q?4DzSSC/KZuhiM+DgjOa0g8XIJ9e8hwfWfVXLGpQAem9jCaUpUTPe2aKzINNM?=
 =?us-ascii?Q?lDGZk2UPBYgF4Q7+YE7vgEDLMSBJF9u4zjk1+CFWq8MsZXiTPEgLs4t0T53N?=
 =?us-ascii?Q?J/0HSIv+AjtrXA/NHWYUsdlnaYnyYLxK/vpBYTNvbgpTvWVpwY+2fesb+2zD?=
 =?us-ascii?Q?SAb0FaJYvfJMcW0UTTRc8elSc6lH69pydITHC+ULAv7OUFqh9Ni/Yrz4gj2l?=
 =?us-ascii?Q?TzHuPXTQGCGuhxYI4LS+iisqKaJpLMJ0xxqK8fZnLoPxH/9MzMIyzCW5nLJD?=
 =?us-ascii?Q?iUoS5iDnzzoyNhVmcMbM6OmpGOQQL6U4EgRJjPooLSmTgdeq0TbKpveTVInj?=
 =?us-ascii?Q?zFFfGFKkClItRQKQf5mq79P58az4DeaIfBJ4WhLkeLgEXv4kpRT1qn6QWnSP?=
 =?us-ascii?Q?O4sWTd3+8d8P9nhlLE+HGII0+WyY8Fj4+rlpD3U73Ilz737HadywO1e/lj+d?=
 =?us-ascii?Q?61Qp3jnNt6sT0OTeegdSey3IcTzuoXkjKFZFL9X0rMerpg6/KLHQPemnEc3F?=
 =?us-ascii?Q?hDTo7gRH3Y+77qzxgavl2CKusVGOdq1SqeIKlVSEtjvm90vE5Ds5nAM9CW5T?=
 =?us-ascii?Q?Mnp5QjRAdkS5DW5Si9mTLTAcS17GsT7L13YtP3qyBbflWyjkBGBWrxCwa0HM?=
 =?us-ascii?Q?4sIXg0OIQqMdIiy5ACGOtkGPvPUZX6bvtnM6VN7zVFLiEo5LWAUqa1/Amnay?=
 =?us-ascii?Q?/Vp+lNiUaf6gSOuOWiApn1ZyfzKIpS2/KQbhwnzr10q0IsZD0PTRoM7R3SxP?=
 =?us-ascii?Q?GOywqcupZYzyoWfLYcVGFRGwrX2znYb4vnNVx6jiiXO8MHjY3k5QszP8zQJe?=
 =?us-ascii?Q?3JFjEreXclna+ShJ0t0iaNtzJPPQE852IMrnCX67upsOmV8qN2UCl2i0RoAp?=
 =?us-ascii?Q?EXN0g5Zr+kiV+RFOQhncT7pM7PUrXbZu0oCxci4FQePE7yx9/UMLa39cSJYM?=
 =?us-ascii?Q?nwGlOKw65c9cFjpuXL4oMBHO47bt8WzoubdKFw8YYZdvUbi1yTdYUcVn6Lnd?=
 =?us-ascii?Q?WRSz4A2yCEX+yf4kMNDf0+C7i6Mnj8aSdNRw9yvaJ5E+nmF3G0ujwaA6P4hU?=
 =?us-ascii?Q?iNpYwNSuWpqcNdyEC7Ww2wkeH0x8cJfxYTxMdwINKQpj7DTBVbWduLpmtJ0h?=
 =?us-ascii?Q?wl2Q2wKaGaLSELtOMUCqeEaG60x28RDIq2WXKWELVdOhaBDiZWqwojyslCVS?=
 =?us-ascii?Q?t6JKjb7phECsqTaBYJKt8XlfvDoTA9HL9NqroCz32X7ndVJ7pLa67wAys+bP?=
 =?us-ascii?Q?thb1uL5PIoo4lPK0nX/wRU9yK9WNygFNxkEM3susbjhSaCbyZWSMhpBHfYeM?=
 =?us-ascii?Q?SqHGOWKrJdQ/H8TJDldlH9oSVejm3pDbGvgSj57S6m9AWvi6rFbI0EevoK9z?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcce9c1d-cac4-4a38-b829-08db7d2b5047
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:41:59.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d2VZfv/5jg4eLR5PP+qs3emiP90mKhUV/54FV2W54dF3NJFppS3vF8neAeW1Rc8vHbjU7PoL97NTgYobyXflg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8458
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--L0Q8P3f2Fl+W9S90
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi Linus,

On Tue, Jul 04, 2023 at 07:12:23AM -0700, Linus Torvalds wrote:
> On Tue, 4 Jul 2023 at 00:03, kernel test robot <oliver.sang@intel.com> wrote:
> >
> > we noticed this commit 'add a (temporary) warning' for the case that
> > 'anybody actually does anything quite this strange'.
> > and in our this test, the warning hits. just FYI.
> 
> Yeah, so it looks like this is trinity doing system calls with random
> arguments, and that will obviously hit the whole
> 
>   "GUP will no longer expand the stack, warn if somebody seems to want
> to do GUP under the stack"
> 
> test.
> 
> So then it will warn if somebody passes in bogus addresses that *used*
> to maybe work.
> 
> But with a random argument tester like trinity, passing in random
> bogus addresses is obviously expected, so the warning will trigger
> even if it's not something that we would not want to keep working.
> 
> I do not have a good idea for how to not warn for things like syzbot
> and trinity that do random system calls, and only warn for any
> potential real applications that do crazy things and expect them to
> work.
> 
> And I *do* want the backtrace from the warning (in this case, it shows
> that it's the "process_vm_readv/writev()" path, which actually might
> be worth adding stack expansion to, the same way __access_remote_vm()
> does).
> 
> I guess I can do the limiting manually, and just avoid WARN_ON_ONCE().
> 
> If I do just "dump_stack()", will the kernel test robot react to that
> too? IOW, would a patch like the attached make the kernel test robot
> not react?

by applying below patch upon
"a425ac5365f6c gup: add warning if some caller would seem to want stack expansion"
then runing same trinity tests, we noticed there is no explict WARNING now,
instead, we saw below in dmesg (attached also):

[  323.996325][ T3994] GUP no longer grows the stack f7197000-f723e000 (f7196000)
[  323.997613][ T3994] CPU: 1 PID: 3994 Comm: trinity-c1 Not tainted 6.4.0-rc7-00014-ga7fb8f6e6830 #1
[  323.998883][ T3994] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  324.000288][ T3994] Call Trace:
[  324.000829][ T3994]  <TASK>
[  324.001326][ T3994]  dump_stack_lvl+0xc5/0x140
[  324.002020][ T3994]  dump_stack+0xc/0x10
[  324.002653][ T3994]  __get_user_pages+0x78f/0x8d0
[  324.003399][ T3994]  __gup_longterm_locked+0xa2d/0xef0
[  324.004170][ T3994]  ? process_vm_rw+0x3c8/0x690
[  324.004873][ T3994]  ? process_vm_rw+0x3c8/0x690
[  324.005594][ T3994]  ? is_valid_gup_args+0x2a2/0x2b0
[  324.006349][ T3994]  pin_user_pages_remote+0x70/0xa0
[  324.007107][ T3994]  process_vm_rw+0x3f0/0x690
[  324.007842][ T3994]  ? __ct_user_exit+0x57/0x70
[  324.008543][ T3994]  __ia32_sys_process_vm_readv+0x75/0xa0
[  324.009362][ T3994]  __do_fast_syscall_32+0xed/0x130
[  324.010116][ T3994]  ? __do_fast_syscall_32+0x108/0x130
[  324.010902][ T3994]  ? __do_fast_syscall_32+0x108/0x130
[  324.011690][ T3994]  ? __do_fast_syscall_32+0x108/0x130
[  324.012469][ T3994]  ? irqentry_exit_to_user_mode+0x23/0x40
[  324.013295][ T3994]  ? irqentry_exit+0x6d/0xc0
[  324.014002][ T3994]  do_fast_syscall_32+0x2f/0x70
[  324.014723][ T3994]  do_SYSENTER_32+0x17/0x20
[  324.015416][ T3994]  entry_SYSENTER_compat_after_hwframe+0x53/0x62
[  324.016311][ T3994] RIP: 0023:0xf7fb3539
[  324.016942][ T3994] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd
80 <5d> 5a 59 c3 90 90 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
[  324.019421][ T3994] RSP: 002b:00000000ffa1c20c EFLAGS: 00000292 ORIG_RAX: 000000000000015b
[  324.020595][ T3994] RAX: ffffffffffffffda RBX: 0000000000000f9a RCX: 0000000057150a40
[  324.021721][ T3994] RDX: 0000000000000001 RSI: 00000000571509d0 RDI: 0000000000000001
[  324.022834][ T3994] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  324.023981][ T3994] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  324.025108][ T3994] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  324.026255][ T3994]  </TASK>


> 
>               Linus

>  mm/gup.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ef29641671c7..c9d799d28de7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1091,6 +1091,21 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  	return 0;
>  }
>  
> +static void gup_stack_expansion_warning(const struct vm_area_struct *vma,
> +	unsigned long addr)
> +{
> +	static volatile unsigned long next_warn;
> +	unsigned long now = jiffies, next = next_warn;
> +
> +	/* Let's not warn more than once an hour.. */
> +	if (next && time_before(now, next))
> +		return;
> +	next_warn = now + 60*60*HZ;
> +	pr_warn("GUP no longer grows the stack %lx-%lx (%lx)\n",
> +		vma->vm_start, vma->vm_end, addr);
> +	dump_stack();
> +}
> +
>  /**
>   * __get_user_pages() - pin user pages in memory
>   * @mm:		mm_struct of target mm
> @@ -1170,7 +1185,8 @@ static long __get_user_pages(struct mm_struct *mm,
>  		if (!vma || start >= vma->vm_end) {
>  			vma = find_vma(mm, start);
>  			if (vma && (start < vma->vm_start)) {
> -				WARN_ON_ONCE(vma->vm_flags & VM_GROWSDOWN);
> +				if (unlikely(vma->vm_flags & VM_GROWSDOWN))
> +					gup_stack_expansion_warning(vma, start);
>  				vma = NULL;
>  			}
>  			if (!vma && in_gate_area(mm, start)) {


--L0Q8P3f2Fl+W9S90
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAAAARZWg==

--L0Q8P3f2Fl+W9S90--
