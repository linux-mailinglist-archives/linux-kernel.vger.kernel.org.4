Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2E6BD46A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCPPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCPPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:54:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9AC7D084
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678982097; x=1710518097;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9ZapoCn0QyV7xNaEkaXLOHM6mHXuQwmQvVeKhzR46vM=;
  b=I15lYjLFZTxLZRfY+eoYXPzcPtnwMOeq4Tdm2M6o+QTbLbfd305SATNx
   jzU8+ij9hHRV4CBPz6SKgHrFjP6hjwWJOvWgurHkYDLj/9LQ9bIvXKXLh
   ty94lClzcYtp7CGlD+DwQLL+ubpqH4pKLi3Tmpb49C8Th+H0MA6I7MzTs
   wAHA4lPiWsGe1uuDuRACza6sT+1wB0FUUWVUfR+Fn4gO0E/u7zlkUNS9D
   lQOwmVjbcB1tRZIY8ZQrTGDqxVP7llw3JqKvBFh86VAGjOn2rMtI7Ya9B
   KIFQVhjtDS5js6bDIYv+kXtmCtVHyNIluh/P2tsMN64hp16z3bhHWGmBm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="365726245"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="365726245"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="682355149"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="682355149"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 16 Mar 2023 08:54:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 08:54:55 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 08:54:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 08:54:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 08:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjXnlFMgNnAjfk9LNWWeb+N/TTtg9xUUulLvw4CDNwGp68omQvCSJOE+MHIqL4V85MFA5WJO7mAKyeyBFBCKa6z+niEmZTHM7LUyrsW4V0TFUDSYAC+vuLXl11lAy4jaFWUvC782+MRehh2eAqdo1l5eAEQooRRxEfkEjdPC8Yqb7d1IiC16+4Fz61L7cifhReNSyWP+qTLNVmOFNzq+BxWyuqbmMlE9tEJZlKxSwbmlg5BsTuZ/Uvf2R8SIjD0d83C2zdlrd30GjY0z+BiBdSFGUR8ZSPFjnDIKwHq/1Xpeu/sHq+OhDvzSyIugItMGhFLMJ3FzvGqH29fRRfZpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQiOyR6up7US8BBoay8cmDnsMz25VO8fKr/rKhj48NQ=;
 b=SE/tLmm+loUFWJ0jHh5ihI4xKEnjNk0I9z1w0cJgZ8mpfBzBiq66X3nzzS8tL02VgEHWjUy/d+ln1EvSjMfHYjeQyxSbCLeRj1VdBrIHTSUITCGM+fZNWICh+FIFx1jFubdcLZTXEeprS4HhkLaTOJpOQ7PjcBrepx3AW1pfO4742YOCJuC228tLmCnug/8BPlkvz8h5tx5OvHWw9bZF5H/+nWuuIPukis6pA3GmK6Uq+FtZYt9U/AaUktwlczTMfR7NtIr4kPuqAYQF3QuGjUZ00naV/Gm2Q0eZlOvKkocMwf7QuvHMPJP+IzmJVyI0JOctLi6L/ScToLl7UyjJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30; Thu, 16 Mar
 2023 15:54:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 15:54:53 +0000
Date:   Thu, 16 Mar 2023 08:54:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: RE: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Message-ID: <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 327256ca-bbfe-426a-0610-08db2636c85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/H0yO0EwHfxW+zsV29K+9+osr7quZKo4TGFM2Awuv34bsV7XvO/dx/rqMvGmIj+ZYHwokiwxwVI4z+A7sHnvtcQ0LQl/m5/hT0yjQlWfL8d1tFEzZ9Cgy2dYzNhNdQP4rSHy64S/e14WTwFeDZY/ybPYeudsfbXfnS+zBVf1rzN1ZgjPcObufsOq0fxbShP7fWXvqjtxBDUBHqoT8ZsEDjoKUyWx5t5lBSFgm/a+gl+0oo2nMe0e92MnPJuaBa0dyuQ/P59XaZt1iS6CaZN/U3ChCdzC1F4Oa4eCjvNMe8lMkPC8p3QFs82rvLT1dzsEHov0uGj2xRdEEqdigkF6ZL7BwFeM4otYsg1KpvQ6wrtqjLqGwVtuHGt49xF6sCK4ILMKvIXmNTUwKiHw2veIuTyKba38d/FWXntoGg/ycTNjgMyH0USUOWMdo1mEtf2IwRnqIcdGDOnvsBVzlAO8BnAG76mm0rqmS5A1+GynuLjFiTYRfzeUA0b5Xi9TCqU/kdLaySVjmVKzpaJoD492C4EbSR4Cpj+UmMcDVkBVCgCvFAIkE3HHaMm4CPdoK3z27WZV0Ph7bI7GhxrFSqV8Fvbec0yLyisY/xEAewN81OJ1ZScJW5wyFJs6ftwlcb/SKUnUpFqkRW/+xvThsMtIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199018)(26005)(6506007)(6486002)(6512007)(8676002)(66476007)(38100700002)(4326008)(66556008)(316002)(66946007)(478600001)(82960400001)(186003)(9686003)(5660300002)(86362001)(8936002)(41300700001)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBNxuJYPAXZWKPfh3c9NDf85OvUu0vDfnsj3w7vAkw3ajfvK10AQJocrvvqj?=
 =?us-ascii?Q?vO/kYcYcEZw0rLjXILmMZZ7OjUBdvi2T9ItYIxOgB6QYaPPv3KYOuRsq8Nwk?=
 =?us-ascii?Q?eHgmL/m4+1oltZVCfm/+1a7jm92LB0dDozJcF4gU0ePO7Bo3ZnUsAfiMFnTf?=
 =?us-ascii?Q?V28u25CHpvlhZ+pYhV8/naJRDnJJAbvrFrK1kTvu2RA8H7mYid0z+DFUie1X?=
 =?us-ascii?Q?akHgp/maWulGppcw4o91/F1ZL+QKEo6OFwc1vLS2Ga+q+rzBlTokuhCy5d9A?=
 =?us-ascii?Q?9WP6wjgOnUFwDzRGG66ncCe7K2FvekM4b3HuIC0AI6Oi8GHOyRDVvGS4TQO+?=
 =?us-ascii?Q?4CPGRqqE2QYN+M0tuzzW8Tg2WTZJRlEN7PCtuFYxBM+wIIzGguL2u+KTLMon?=
 =?us-ascii?Q?6etRQxxIcDfIz97hXRjVQCKkVKPSY3tZqhUWzGyaHLnVJFqmF9OF1Jx3w+PN?=
 =?us-ascii?Q?TQhbknE60sbWj2pB9nje3RVzlgVA43qgum6YWSaGQxuY04whb4lkapzPgUmV?=
 =?us-ascii?Q?G+h3/BXN0bCOHthJLBSuoMAcGsyybl3nsEP3y4ptU5dJUjBmRaWaKRoV+Sa3?=
 =?us-ascii?Q?hI0qGRXFy/oBy2PF009GRW32fLazML3UgdgEj7SX/Zkop9nYzJPUImww/2fC?=
 =?us-ascii?Q?l1J1/ozvhxG8WyRgsL20N6wckbGA5HBi+5AXeCOzpwXSzTxC4TE7Kq5qxkL+?=
 =?us-ascii?Q?xhd7WV88LhjJa9txVLbQsLK0FkGm83JB8FzqQfJWWtDqpO16PnXBDx3djdAm?=
 =?us-ascii?Q?aKMRP9z2mTD+ik7V8+VKDAWDBIjzXCO0Ma4BzIEBAxeI2NMpX2r3D4oplcCc?=
 =?us-ascii?Q?xRUBCvMhTZx3BPvckyzX6FtIuwaIsPgDxJNKjyqA4d6onWLmLvYlWneS/nkc?=
 =?us-ascii?Q?cjLGe+1FrocZt4uYEv9OeDZh4fFIQbcmoNyHz9XOpCAkE1ytJP1EcAlLGC0b?=
 =?us-ascii?Q?YAvfgUJcyIhn6lklEKYhh9byLMfdFuJciuOqV3Uj4WOwq+9T+qYxmLtqHgGH?=
 =?us-ascii?Q?LjYCJ3xGlK9CDTk8SnfFEh0hsqDWs1YvsMrGTt1ZJn6m6yGmWYaKYxxkPjj5?=
 =?us-ascii?Q?9d6kqteg74LGzcr6q9A2nsdRRtg5j7TZnjTA5Kn4z/eAypCOdGADRW9M7Sc0?=
 =?us-ascii?Q?3rArGQO5kOOEIuo5wgX9b4ErrYfH5mYPitAHCD/jdmGL5wpslnFrcvugi72O?=
 =?us-ascii?Q?OPUB/FfdQGkfxobdmzZRzxfFFvH/MJC85NoIZIMQvF0kyCaLiTe+AnWJiGtE?=
 =?us-ascii?Q?qjiIiSfz/c+kFwQ17GlKptN1j0UHNr+b6luJJUOUCJP36o4NbRVXIa2c6QQq?=
 =?us-ascii?Q?N3Iea86DCZ4xOmgyMA7PfR4ag46HODLtUtZ0K6k2JlyhNWKb4ZxsvMz0JST0?=
 =?us-ascii?Q?zMo+HfQiSMYSW03X/0wA+Cxu9c2KyBrFccREax24+Hla83sFhi6Jm3surIDk?=
 =?us-ascii?Q?w23kt6qCYx5g69Q6jJ5xhxdiIjPSsimf/KV+FPgAY8tl+wfrD3hHdwSlX4h2?=
 =?us-ascii?Q?s6EA4vQazvJOSFSwZ/qP/1DZ7xpoVGOb2ZRLAxoTOR0Zu+HGZPlSrOkSbbdl?=
 =?us-ascii?Q?8WfWgjj2vXLRIiAdd+W5GEGha/X3YHmCmII/h9lqRvrBlC3p3FKIUOBJIInl?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 327256ca-bbfe-426a-0610-08db2636c85f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 15:54:53.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XISbIJFpNjPQQzrCmMNvolZVj365fau0ngEBkyznATDsig0e4av6Uy8nYcb73430JxrXyk21w6OB8wyh3B1lo3MPpV0EHZBQITy35o0N2SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Zhijian wrote:
> nvdimm_bus_register() could be called from other modules, such as nfit,
> but it can only be called after the nvdimm_bus_type is registered.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000098
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 0 PID: 117 Comm: systemd-udevd Not tainted 6.2.0-rc6-pmem+ #97
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:bus_add_device+0x58/0x150
>  Call Trace:
>   <TASK>
>   device_add+0x3ac/0x980
>   nvdimm_bus_register+0x16d/0x1d0
>   acpi_nfit_init+0xb72/0x1f90 [nfit]
>   acpi_nfit_add+0x1d5/0x200 [nfit]
>   acpi_device_probe+0x45/0x160

Can you explain a bit more how to hit this crash? This has not been a
problem historically and the explanation above makes it sound like this
is a theoretical issue.

libnvdimm_init() *should* be done before the nfit driver can attempt
nvdimm_bus_register(). So, something else is broken if
nvdimm_bus_register() can be called before libnvdimm_init(), or after
libnvdimm_exit().
