Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15B9720C62
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjFBXel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbjFBXei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:34:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76953E42;
        Fri,  2 Jun 2023 16:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685748874; x=1717284874;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uk0q3VHgQBwoHEEM4OghLie94rfr4ABeJLTUv2XQ0A0=;
  b=efpIffRAqbyRFN/tBr3M6pRYJy8plrJ02i3czg57UeEmf4can5kaFXag
   3ncCZAxXEa7+5u/Xhulgz27WCgmptYt91qwhl8QTLSgJ2ZpL+hGkoR2D8
   vSkP47G2Ib0UeitDZR4r/dpUItguOqt6eQVQ2zRdSFDuDSdVFzTzqGtPu
   mBcIBVAubdFKjoNuCxRXvtmRSeElCNqzaxPPwNhAyNjYt3p0vSc4d1XmA
   OjCEjVdEd7BeWrkUZE1Zcxc3T2cP6pz2sOSPVK7u5M8mb1pUipGwYfDZD
   HHXTGHgIEvxTQ+9S7J7vv7Y9tVMXVT85c4O4CTW6HIS0LKwMRgnqpm7Cc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354847059"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="354847059"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 16:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="658427752"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="658427752"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2023 16:34:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 16:34:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 16:34:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 16:34:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 16:34:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSWLc7/I6Wzu6MooSMP76jUSjCsHICFokPhORLIDCFyo8EkYMMVr+yXGEcR8ppUz9x5hExcptJx/HLXw1HNvNZoP9/22lSjZT8Cc570srf9Gk0iLMJsBvjVz7ulCNv4uTWPGylj5+7+N0vAifPR9rvN86MZ1YLqs+LMv5Oef1qe5ujsjeZo1sRRNzcABKcr/1r7SVLt+86grC1dDGj11Fxfp4L86FTrWCfJ/yCjtA7iC+W5RUDNfbOrztYLQzrMe0egPV62eIbJrvVZVTB8p9G/UaxnJKGq6bsOvQSS5Pe0sSH6ptpHpkzG0SVG0viegjlGKEs22KlW41F0hGb/91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDvQyTVtNsrR1Obr2v1A6sdv7uEVdWBoHuZkuuP0aK0=;
 b=NSY1HVsY+mn630xshxh06wkCOyRnUqbmuq7AT/VC4r7lJ1gU0PcEUgyo83Z0OhqJK4tQyfIUoQwVHORJVoWvB8ML+4zilWf6I0yEWkAB3p4mGdvgSwPxhyDzJnBcuJ1JwHgZtgreY93Wz/NoK9BkK+vZhAIQVMhnIWuKD7YzOfjI4a0slZmc485y0gJVmx2iZl6T5DesimBCbqUtaGql/J9AuAo04jRtUW7K6Y+Uh7ngBbA2AgRBD+gxhwbAfkj+TL68m401MCOFYS6KZSPCx2Ywkj8+PfjXhIkMbp5rlJFW9w6Eji/pL7d7WvwUkU9xVwspOZ+QRH8aRyfIWsmBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 23:34:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9679:34f7:f1b:1e7c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9679:34f7:f1b:1e7c%6]) with mapi id 15.20.6455.027; Fri, 2 Jun 2023
 23:34:14 +0000
Date:   Fri, 2 Jun 2023 16:34:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Paul Cassella <cassella@hpe.com>, Ira Weiny <ira.weiny@intel.com>
CC:     <dan.j.williams@intel.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <akpm@linux-foundation.org>, <joao.m.martins@oracle.com>,
        <zhangxiaoxu5@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] dax/hmem: Fix refcount leak in dax_hmem_probe()
Message-ID: <647a7c6e5686e_287a2294dc@iweiny-mobl.notmuch>
References: <20221203095858.612027-1-liuyongqiang13@huawei.com>
 <Y4u2TK4yPU9dfiDr@iweiny-mobl>
 <d0819e2a-f584-3287-61ba-88ea78a9885b@hpe.com>
 <647a384743e5d_c35b294af@iweiny-mobl.notmuch>
 <3cf0890b-4eb0-e70e-cd9c-2ecc3d496263@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cf0890b-4eb0-e70e-cd9c-2ecc3d496263@hpe.com>
X-ClientProxiedBy: SJ0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: f520c22c-eb51-430f-c103-08db63c1dfa4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/uTsjxnr4ja4jqojsoPYkT19KP0zjqUi49BL9QBOlK0p3SBP8hSRYAKWLe/W8xcpWgL6FuZLTPjLXCF7KFpKSXhwzO9H1yyFwyv+vS7JdSyBcqZTNtWL0iTvPXql8BFsEdOpJtK0M6SRQLdo3ZbRdyqX7memxK05rWxN6Pg09OnwMPV3IvUeeh0eEvCPLCirC6XxoBEF0SsPjw8l/r/pE0SUbJPSYs5Tb5zyqmkdxEFQpWa5byIvr8gELBASuu35DEJiJAePVomyiHNnirtmHX2PGF89im30NBkbdggMj/nR6KP3bHLKQKEcyuSApfZEwh9Osj9YzKXb3pDrDGcUHnySA9p1ust/O9P528f1KmIwQ9w+9zqFDfdFMOjyF6OSXA03zqiQ7ay+wE0po/OTt2oIQlBcStzfHtAx+48NTDZzgkpAxgXArX+Fqnz86AJOkmTPzofyPcYJiLeXoZzzAMv33yaUKP0tUC8j7UKj/UYoq32eMkQF8IVCSD7x7wMszdeqFG7hqvFVMRBfbyuwssW4D5d1JTnGSSX+DtVONEtFkXRm9BSAQPpMZftTY/U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(110136005)(8936002)(5660300002)(8676002)(478600001)(41300700001)(6486002)(86362001)(6666004)(296002)(316002)(4326008)(9686003)(186003)(66946007)(66476007)(44832011)(66556008)(26005)(6506007)(6512007)(2906002)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7xeo9Yv88pVFjq2Haz1/huY8a2kd1ScX28+YFtrvBgwjPXoy5xwY/FequuF?=
 =?us-ascii?Q?OR08EyGFTCF7d+fxf/vVAn4PLoli21YEnyEeA929dkIJLwJogLDGbYZPdaXk?=
 =?us-ascii?Q?Kt3C6VuUhdz3q15ytGPkptORuoB1W2bRcihYMnkEMFPu7Ox53wglt8+MlBxo?=
 =?us-ascii?Q?PeuBJsCm6pJ8qv40S6CPClrr6OrldIaPPxEOh6pNjSwpF0TdwEiE1YnldzvQ?=
 =?us-ascii?Q?bdLwaLe7r6qpt7aZulZrtYWoRdhJz+GymwTNE4QtoQx949HsL/1y5gKNMySU?=
 =?us-ascii?Q?JNi2u+IAMO4Q0aAQ7y0Gbd1V//DHZMPf9WePD+Xg5nrb2Dqdk98EpRg6Ecz9?=
 =?us-ascii?Q?MCYGfpqQpuWvHg4gSsJ22TYOKvJXWkZHx20K7++fN9u9E22WAUiaYpXDMdCQ?=
 =?us-ascii?Q?V2KiIqYkyrnQcKOTYG8TIYBO7HeBh8DnixL6WU+h5FY14E6UzHADXIOhR34e?=
 =?us-ascii?Q?/mGAkos1XWk4zAfnMppUDovw7SZX3vQev2SrnKJ9SMW+VkfL4jk13NnW6/Uc?=
 =?us-ascii?Q?yakiioMb4X/qzKTmjnaX/K9X908yth14vqANmx/BRej2tMrwPKBeAT8PPYb9?=
 =?us-ascii?Q?XtIimpZU9ghOdOTtAPabABtT5dx7Rs08MlJ31O3sKRuWf2cb0QUhddBYY9Fc?=
 =?us-ascii?Q?GUXJTGcjRLOE8thEUSjBuk2PIvXUpxlW/20+E8nN+/+QU2evmej3CDI3RYBZ?=
 =?us-ascii?Q?q34NKkKesiHWMP5mFb16glhhj7huGMCvv4B1N6Cj3Qh7HY62nr5OJbjn9zTa?=
 =?us-ascii?Q?VTgPWgM83X/JVbg5yrCm1/+LQyvIx2BjYRKwo0NHLjfaX7VsoXHd3Mwf/Fbp?=
 =?us-ascii?Q?E47/T2IXi3ue6APwJayM3PmdAmFkuQ/MKyiBigE0hMBQf1705Pn8OzrACeyd?=
 =?us-ascii?Q?bc4X0ENqlgeJ3otm83ieJnNYnA8TNkbOSdC53tUkeVikePLqgQqqHZerjUYb?=
 =?us-ascii?Q?GBXvK8bJhpUEAzV5+G7Zh3DfZxh/CvgsXBxgWPoRwccuWnlBI7Ljmkl68jre?=
 =?us-ascii?Q?Lp5WPO1ggtxegL77xsfaDzgDas0fdKFGHcizIh6+n4S4mzymV1Mrvg4UKFD+?=
 =?us-ascii?Q?dyhIB2vH7pUWwVlqRcE+BiFTjfDhqXxt+mEjlxyin2gGytvhvlmKIpgSl+vY?=
 =?us-ascii?Q?d2QdT7psXSnMAatF7sKzJ6MWVDGyWva1lDRSLOeWJhY+coT3N+KIlHZJC82g?=
 =?us-ascii?Q?Rgzu26Ltrbm1jjuZ7Ot1OczAUy67Xbbp6etEmSt1Qufk5yGod1DLGZLupwkJ?=
 =?us-ascii?Q?uG0RPi0EpmPBfMA1GfIZPw05FmnP8rlbPn42mGHzwXyAoJGmpNTNmtW4eTGc?=
 =?us-ascii?Q?IPmizEeOopkP5XdeaA5k07HJBJXg4W5RI7Pi3g3IRdVLWqCD+KzTwNODJV/z?=
 =?us-ascii?Q?eO1p+vLayny3RBNv5mmv+FDw4Vc3NUsWtcfv1cyp7LPrP0CrfY7SxPYpnn7U?=
 =?us-ascii?Q?BVhPd7RyeMyFXqpeHq2p5D1biKux9of5TyX7MgxPDEqrVaUZXYctMTmOM5G3?=
 =?us-ascii?Q?9X2krMRg70MhQebIOzyLD7cxu3061AvS8bECXkv0qf3CDTovykxe9d2Y9m8k?=
 =?us-ascii?Q?gGpjaaJkYgKVpDd2uMUiSWw7tKNDNnwweuUvybz7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f520c22c-eb51-430f-c103-08db63c1dfa4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 23:34:14.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FsbgKyhRs5cR7GlJjQZSpzjyGjhf7oJglLqiIfXTI5+PFkI9ynd+vWhT10Sk9aDq0fUwxZLyA8G8aCeccI9Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cassella wrote:
> On Fri, 2 Jun 2023, Ira Weiny wrote:
> > Paul Cassella wrote:
> > > On Sat, 3 Dec 2022, Ira Weiny wrote:
> > > > On Sat, Dec 03, 2022 at 09:58:58AM +0000, Yongqiang Liu wrote:
> 
> > > > > We should always call dax_region_put() whenever devm_create_dev_dax()
> > > > > succeed or fail to avoid refcount leak of dax_region. Move the return
> > > > > value check after dax_region_put().
> 
> > > > I think dax_region_put is called from dax_region_unregister() automatically on
> > > > tear down.
> 
> > > Note the reference dax_region_unregister() will be putting is the one 
> > > devm_create_dev_dax() takes by kref_get(&dax_region->kref).   I think 
> > > dax_hmem_probe() needs to put its reference in the error case, as in the 
> > > successful case.
> 
> > Looking at this again I'm inclined to agree that something is wrong.  But
> > I'm not sure this patch fixes it. anything.
> 
> > When you say:
> > 
> > > ...   I think 
> > > dax_hmem_probe() needs to put its reference in the error case, as in the 
> > > successful case.
> > 
> > ... which kref_get() is dax_hmem_probe() letting go?
> 
> Isn't it letting go of the initial kref_init() reference from 
> alloc_dax_region()?

Oh wow!  I did not realize that about kref_init()...  :-(

> 
> Sorry, I had gone through the code a little carelessly yesterday.  Now I 
> think that kref_init() reference is the one that dax_hmem_probe() is 
> dropping in the success case, and which still needs to be dropped in the 
> error case.

yea ok...

> 
> (If so, I think the alloc_dax_region() path that returns NULL on 
> devm_add_action_or_reset() failure, releasing the kref_get reference, will 
> leak the kref_init reference and the region.)

I see now.  The ref is taken prior to the add action or reset to ensure
the dax_region does not go away should the platform device go away...

However, in all the call paths currently the device passed to
alloc_dax_region() can't go away prior to the dev_dax taking a reference.
So I don't think this extra reference is required.  :-/

As you say the ref counting right now is not correct on error flows.  But
I'm torn on the correct solution.

I think a small series broken out so it can be backported if needed would
be best.

Ira
