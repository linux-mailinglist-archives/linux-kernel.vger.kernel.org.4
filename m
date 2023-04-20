Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1020B6E96ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjDTOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjDTOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:22:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E56461BD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682000527; x=1713536527;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nGrV5DkVOKHZhXZySj6DzawYcEdL5PJC0PVsQHysVWs=;
  b=b+v1eEAvxc4hUEsLsNlPxXsigBRcvdnPqV24rIBGZwMFv0qe3Ckd5Alo
   7rx5lN3MxaKEH3fPstu6Cco5TKoRjxiFMVseTsVIm+E9QiD1z67WbnYqJ
   9gClRXR/5znDz7m+CYFaa/cE2yt7/6Oan1DCnCrKwf50CS79wa4dC0Rh7
   t6IzkbUQGTE+FW5A+oJgLcWD++5c0fGtrr1CjO0t+1hcg/FVJmJN+GfGP
   /jsUKrHrGOF7EHh0sb8bp2ksBf7YGRhMyj+RDFmcW2XTMFw7dXbRppMU2
   WUwnqO8U6pu2FphvX2NXpCkKIcafTZthb8szGfo0AUgcrTKtKoWgB8EjJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="343218570"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="343218570"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:19:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="816029839"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="816029839"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2023 07:19:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 07:19:03 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 07:19:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 07:19:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 07:19:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsO9v0gJX17tkK550SUv9EGqn5nIcSvQ7wfwtQKfioO1yYZyglWDJtp/X4ZHe3BGPOBRAl2FeBvx/lVlQsH+r8EqWMEKi1FAuW+QNJbdyUYeLVxk6DCHNvZRabKhSWB80adJjdUmNZjAkq8oB+S1aO5sTHSU8Y6Y9IbyOpJgQdCCWNPnquKDwAOrbSECwmDlA1RKHKTgjwyg5PKp98sdcJHPjGPe52pWvkqHiG7QFj24OoXs8z1Qy1+3FH5GOc6gqv6O8PYHu3J1Fcxg7A0vk5uSeC5VLIaMDvR0iJFfweESDZNqi/RzFFp4LI9LldWwnUGVVF2RQ1/YK4r0bMJ1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OARme7cQC6y7epAlieASjRIDaHc8yS9eNBQ2dEuEYIQ=;
 b=FBM0P9iKvDa0QJMUChZl1LbvRTYm8SayWzNdBmldKu5M5JLrCPE4tJnqHTzqtDm9X0+nXzqFy121hWrquF2X8P4dy+AnVGVJYD6Lhv98+Kk3XsE+amKqw2mBD0KaLiLKeBearfbIy7x6McLw/P8rOygB2tXklnM6pkUklHfcaBqAe15xtCf7GiHXxfaonY1ioHYwljYJzGAbaHjwApVgHo1Lgd6cxGVQgVY7XsH1LeJLK7BQMyk3TQD/F3e5etO7WZWP2aFKrGkDkgQtZFX2IMqCJ1oOkqOjNos9Li28aIwy5shWAlzn0f9pkd5nB7OCnunPM3weeC7L7Q9BS67hNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 14:19:00 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 14:19:00 +0000
Date:   Thu, 20 Apr 2023 22:18:52 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230420141852.GA154815@ziqianlu-desk2>
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
 <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
 <20230420095610.GA153295@ziqianlu-desk2>
 <c01ddfc5-9410-14e1-55f7-c24f44447f8a@efficios.com>
 <20230420125048.GA154262@ziqianlu-desk2>
 <721f4b8b-c238-53b1-9085-a9dae6a961e1@efficios.com>
 <20230420133519.GA154479@ziqianlu-desk2>
 <7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com>
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH0PR11MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fc46e9-94d2-44c5-55dc-08db41aa2f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJxjotoh6JKV4ABUGzoMXgIGoBWjP7F4bm2RL0gNfaUxLit42tV1NGA/Mj1R0TawByW6HghUGe2lgUcwYuToFPRHKbxfb/BYp6oRQ2t9ObUHVJg0K/alQyUAyRNahCzVpV6Xj/aaBiUo8PxHg9URaqxwrZuudFwzl5kumDCihQhYSbvb8j/mPXC+QmrNfbY64JgoX+UlezaENnLXmXLV0XFLUH1RlT4uybx8Qo4oYdo98znBJIIJY8I9GNWMMHHvx0hi8yNHSctoSbzJuF0vn4pTvTRiCFTqYHxkWxAD41kREt/Ii1SwUHn8YePWm6upWipNO9/wkQHmOHaGLguHON0w7+hSIjNwkDrZqjcCmuJa9/rSCYTMDJdjbSY2z8pjiw4Pux761R5kRJQhSPgKZoJs1yn2umP9XYgWeBSt8tc/CwHHi6tbJsApuWjIvcpLlCHO/J7z6BegLpogbngATmBSkWbcsSHHb8HWsOVQiQkW06Li/F7z9F2Hr+n0gofz19mFQP8AEeyTuH+m6Q1uIYj0Kp9GXjeYaUDfS3vi6zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(44832011)(8936002)(5660300002)(8676002)(41300700001)(2906002)(86362001)(33656002)(38100700002)(33716001)(478600001)(316002)(6506007)(26005)(53546011)(1076003)(9686003)(6512007)(54906003)(186003)(6666004)(966005)(6486002)(4326008)(6916009)(66556008)(66476007)(66946007)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJqdUFzaFBhS2IwVzlVR2ZtSERuMjlTUk4zQndnS0lhMTRJVWxUOTFUSHps?=
 =?utf-8?B?aThXaERXbDllQ2NjZkZRMWx4NFZ1NE9EcnFjdnBBS2JPbHVEb3U3c0VXN2F3?=
 =?utf-8?B?dHdGdXgvUUo4bVExVnNYYzl5aDlaSHBaT0ptc0swVThGMEN1Q0w4OHNuYWs2?=
 =?utf-8?B?S1c1MDNlT0p5eVVTVFFkNmJDWWhCR1UxdG9wUDQ0SW11N082T0VvT083SnMx?=
 =?utf-8?B?V1UxeDlqVWZIK3l2bHIxdjJqSm02bTFRZHU5RnVyNFNPZjl4SGlBTnY4Umgx?=
 =?utf-8?B?Mk9jYTgrL1N6Vm9BdUROZGVLUUZBL3R3VXhQbmJYNlViSWhTTjF3M29UTmNu?=
 =?utf-8?B?VDRBdXYxMVVFaENLa2diU3FoWkZITzlycE1yakhBYi9Ea2NYZDArMzJFb2Yr?=
 =?utf-8?B?ZGZUTVhmc0FrZXV6ZTdGUklkV1FLUHlxRUIrbjFGSHBKd3VBRTNHMm1IME80?=
 =?utf-8?B?MnUxUHB0eWZwY1hLWGRvUzNUUG80aWVXMVI4TDdwTEZMS2w0SlQweTdnSkli?=
 =?utf-8?B?YzQ2eGh2Vy9EOFVrM2RkVytuME1iL2VSV1dzUHZRQnFOVTkxWmgrMTVOSkY3?=
 =?utf-8?B?UVNVQmpCdjR4OXIxSWtXQlk4NGZBQlliY3AvSER2VVVEYU9POVhYU0I4clUw?=
 =?utf-8?B?SlpZQ3NLNnBUeUZJNXZ6SWx6enlEcC9ZN1E4RnNkdmFVbThncGhEZTlscHdH?=
 =?utf-8?B?eDNjNEY3Rm1JdEFtUnlkQk1SMWRERDhCZ0tzd0hXa2pPK3U2NW9qKzlrNlds?=
 =?utf-8?B?M1dNeitrQUFqdVdyaEF2T2JWZ21qbHd5NXdzZkJsSEtCWUp5VVhKaUN4VnZx?=
 =?utf-8?B?M1V4cS9lMUdvMGFzUm9sR2pmUHlZQUJ6emdHN3pKcjUzTEhhSXRDUVdjakxG?=
 =?utf-8?B?MHBkeUtxQ2gwVkJMV3VaMEM5S3AzZlFPSURKVm1TL1hLNkJWNnY2VDlWTkNM?=
 =?utf-8?B?eG9GT0o4VlZhMFplcVRQRkUwa3cxNlc0eHdSZVBpSTI2QU5MQ2g4UC9vcmUv?=
 =?utf-8?B?RW15Q3FDTktQdVdSWFN4ZzVMZmFPc2xCWXV4NFhJQTI4cnV0SUNKUVpKVkRM?=
 =?utf-8?B?cFl5bVN4WFhZeEMrQ0k4MnpHRnc0b0NMdml0SVhTRENHaHcvUlJkb2RJZGRQ?=
 =?utf-8?B?N2tvbFZJNFp1cy9PVmhadzFxUWgySXYyanp4Zi9WNFBLRmc3MnRHKzRjeDBE?=
 =?utf-8?B?MitSRzFzWDNlNzZ1ZVp2aHFtZmczOEZXQlhBc0NLUjNpTkRqMFhJMXJ0L2hE?=
 =?utf-8?B?cjNCQlR1LzZqSUlvRTBJQURmKzlGRVEvOVdBeUVvQ2FEcndNVDFGQnpmZHZv?=
 =?utf-8?B?aFkzT1BsTkxXKzgwNWwzSzdCeVR4eFVDQXdHOTZPOW8zOUxXdmp2NkJ3L0g5?=
 =?utf-8?B?U0lBSlJBMWxvblltUzU1VzdCaTBwejUzSzI4NzZ2dDR0bUtCNTZQaDIzNE02?=
 =?utf-8?B?Z2Zwb2J0WFRiL1JyK0R4dEFSTHA3MUZ2MjJmM2FsNWVrNkgvamlwR04xTW9h?=
 =?utf-8?B?MUhzSTRncE0wcWJyM0laeTZwQ1ZQdnl4dUt4bEh4aFBiVDZzaXVJUUZBSkpT?=
 =?utf-8?B?bW1nSTVXNVZhY1VzUlA1UEZvbGRYNkRxaFhSampELy80amluT01qWFJub0Q4?=
 =?utf-8?B?eWxYSW9HaWpaWmpseHUzUm9uRS91MnVHV0RoSTE4UjdERVZQRDRUZHZ3NnBH?=
 =?utf-8?B?cU1DS3pXU1V3YnNtNnNkYS85azZ3dVdqYjhxZ280OVVYZGdOblZOREZKdVg5?=
 =?utf-8?B?M3JaMXd5NnZGNFZlNlBqLytZUzhBbEsrbUJSa3FGR203L2FIZEw3aVh5THVO?=
 =?utf-8?B?RWZzUGo3SG5Fd0QvWGtXWk5BcTRMU055SkFSRE9pTFZRQWFvTUt4V0FTRWtJ?=
 =?utf-8?B?dCtvZUFBSVl4Z09qM2dHUGZKK045SEozaU5zMnU5Zk9XZDNOdXNCcU13T3Qx?=
 =?utf-8?B?SXhrY0RmV01MUDJ4NzN1SUJnUTh0UkxieXI0MEFVM2R5SWJaUzd5dWhLWWYx?=
 =?utf-8?B?WW5nRjdFUXdva2lTQktoQVdiWkhNMVpPcHlybzU1aE42N1JOVnl4YzFma2do?=
 =?utf-8?B?UjF4T3FFbUplaGFQblV0LzdxbHc5ZXZuWkVERWVOLzVhUWJtRnZsVjhBWW9G?=
 =?utf-8?Q?rsgOu+M8EOmRgugIxGBvOAzff?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fc46e9-94d2-44c5-55dc-08db41aa2f9c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:19:00.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjTWp7JLD2c2vsG+gp98PEzvbk1WxLtXA22ZwVq+MDSBaZwaMvdQtidjfUl+C1rDj+RHB9SpHUl3DbzDmHN/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
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

On Thu, Apr 20, 2023 at 09:54:29AM -0400, Mathieu Desnoyers wrote:
> On 2023-04-20 09:35, Aaron Lu wrote:
> [...]
> > > > > 
> > > > > Then we clearly have another member of mm_struct on the same cache line as
> > > > > pcpu_cid which is bouncing all over the place and causing false-sharing. Any
> > > > > idea which field(s) are causing this ?
> > > > 
> > > > That's my first reaction too but as I said in an earlier reply:
> > > > https://lore.kernel.org/lkml/20230419080606.GA4247@ziqianlu-desk2/
> > > > I've tried to place pcpu_cid into a dedicate cacheline with no other
> > > > fields sharing a cacheline with it in mm_struct but it didn't help...
> > > 
> > > I see two possible culprits there:
> > > 
> > > 1) The mm_struct pcpu_cid field is suffering from false-sharing. I would be
> > >     interested to look at your attempt to move it to a separate cache line to
> > >     try to figure out what is going on.
> > 
> > Brain damaged...my mistake, I only made sure its following fields not
> > share the same cacheline but forgot to exclude its preceding fields and
> > turned out it's one(some?) of the preceeding fields that caused false
> > sharing. When I did:
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5eab61156f0e..a6f9d815991c 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -606,6 +606,7 @@ struct mm_struct {
> >                   */
> >                  atomic_t mm_count;
> >   #ifdef CONFIG_SCHED_MM_CID
> > +               CACHELINE_PADDING(_pad1_);
> >                  /**
> >                   * @pcpu_cid: Per-cpu current cid.
> >                   *
> > mm_cid_get() dropped to 0.0x% when running hackbench :-)
> 
> Now we are talking! :)
> 
> > 
> > sched_mm_cid_migrate_to() is about 4% with most cycles spent on
> > accessing mm->mm_users:
> > 
> >         │     dst_cid = READ_ONCE(dst_pcpu_cid->cid);
> >    0.03 │       mov     0x8(%r12),%r15d
> >         │     if (!mm_cid_is_unset(dst_cid) &&
> >    0.07 │       cmp     $0xffffffff,%r15d
> >         │     ↓ je      87
> >         │     arch_atomic_read():
> >         │     {
> >         │     /*
> >         │     * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
> >         │     * it's non-inlined function that increases binary size and stack usage.
> >         │     */
> >         │     return __READ_ONCE((v)->counter);
> >   76.13 │       mov     0x54(%r13),%eax
> >         │     sched_mm_cid_migrate_to():
> >         │       cmp     %eax,0x410(%rdx)
> >   21.71 │     ↓ jle     1d8
> >         │     atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
> > 
> > With this info, it should be mm_users that caused false sharing for
> > pcpu_cid previously. Looks like mm_users is bouncing.
> 
> I suspect that the culprit here is mm_count rather than mm_users. mm_users
> just happens to share the same cache line as mm_count.
> 
> mm_count is incremented/decremented with mmgrab()/mmdrop() during
> context switch.
> 
> This is likely causing other issues, for instance, the
> membarrier_state field is AFAIR read-mostly, used for
> membarrier_mm_sync_core_before_usermode() to issue core
> sync before every return to usermode if needed.
> 
> Other things like mm_struct pgd pointer appear to be likely
> read-mostly variables.
> 
> I suspect it's mm_count which should be moved to its own cache line
> to eliminate false-sharing with all the other read-mostly fields
> of mm_struct.
> 
> Thoughts ?

Makes sesne, I was wondering where the write side of mm_user is. Let me
see how that goes by placing mm_count aside from other read mostly fields.
