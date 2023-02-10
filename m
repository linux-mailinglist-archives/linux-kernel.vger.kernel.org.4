Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02836918F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBJHH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjBJHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:07:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8243E5ACDC;
        Thu,  9 Feb 2023 23:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676012874; x=1707548874;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LDlWIKKarkY7YP+D3Vaa9zbQoIUnA6u6nY8W46pEhU8=;
  b=ji8x1gUwIS/4ya4cQHpZAOEiK/zNIV29Ck58E/WVIPbesbQa4gpSDkfV
   8MVTpmMhlUnghX+YbpvfHw/wBNZze4ATAbQUy+pf5gywcBjaDNRHz3sbY
   jnQElf+jq7+3x2b3efHgvm4LR1foQ1MvFsaz4O9WVXO8CAWCUK1qh9U7X
   ElKNmxrOmIVh9en4dzwa1V3ZWwU/2GQXcGlYw+7nAIqxF05yT2AOOf3tn
   YE6p7ZhUAtL8zyazg3gcXudGbZ+hSUdwIGMUgcIxXscvoINaYDtcuRBCT
   8SQqKGRAvD3DdrRbyPfmI+9IX0uX60CvRTws4NiuI4X9txeljTwF48QMm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="392755821"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="392755821"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 23:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669904776"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="669904776"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 09 Feb 2023 23:07:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 23:07:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 23:07:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 23:07:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 23:07:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF8O0ixBIW9E1fUAYVlvc/xOZWor5X7t8ZyrdylCOLNVbOFFOJQG0al+En6QpZBeuldb1DXELxb2V9Dxz1S1mEoYvs4dVPny8dvaTg3P9dPMyqBw8dxXeQmWAUsyb4eoSHgJRivw3C174kwocVbIy+Qp0O//b7Th46sIZoerzPKZdUdbLKPTnIpAm3SIYlwIB+i44cVx0qy0KYe+rT65pgK+3+L5Za7yIA+3L0nYDMzHVSLuGYa68Mw8iDoPDRnSjizuYz6qVHW1Sc29JsKY6jqEm+PEvC3Zt/3ShWcXT8WzssSMVriPDL/RJIHt32Qz101gCSSt4A4gwsx8iZImvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXesrd7mbquBq0uM9rxc5RtqY1qO9Rfc6QpEHY8hibA=;
 b=MkX02X1p1nzAIqTzcPEbI42ysFpn1K80yHTTB4fgn5lwmQOqHo7tFKyo/sixaho/GFuBQwEKAqsQF9Ij9DnZ5o9PbO0zUCQX1qdv6Iuud//JQ2Mo6P8lFg+aBzTsV54cnF61MG6Cv9yEW2Wa8OsqClkl0Skb/nnLtKHDwif+C1qBOv7YLaQ0xUiEIHREmiANSaKfGvhMv8v5sazdUnD4bjIlu45paXAM3JD6oKIxtRwVQDr0ocwynt1bbd1NiML4y9abO96r4yJzeNbDFE71kipLxLYOmqI15Xv2jG+F+x8JTdnTGj6Ee3chW/QXQWj70xO5f/JlVo/I4T5IJQFrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 07:07:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 07:07:40 +0000
Date:   Thu, 9 Feb 2023 23:07:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 0/2] cxl: Enhance trace point information
Message-ID: <63e5ed38d77d9_138fbc2947a@iweiny-mobl.notmuch>
References: <20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com>
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c9160d-4d34-43df-1148-08db0b357f00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOIw92M1KOLZnS9uWG80eXaBP3aX5Wt5N+lE5pw2Kb+Zc38z4NHNlu8rOSV/WZYlcC5BFz2cJ482KYiy+ecwixzdIyJDx7zf98XlGm57RtxKuhiehVBIs+zheQdYal3DtVmraZrqnjuqqV6+ejoq9yNEU5NCBuZROOlunXoh9SVpHXH4Tloi+0/AtnZDgLV6Qq6tMoDTu1J8D7k3WLMA1VQE0lATizQrcteb57u5lSAoXQVG1atli6KOEC+0ag9grGA5zmGJD1wMEjIbWbOXsgwq1ZESmbuiZS8coyLJnfyzkkJHWKUfGExKwK6fa7Le6u+jttXKtqGQ/nZWKyfavSZnzif1RhNkmyM+hb3VUZUQBgdb5vXniBpvbhJqSiUKlctDT7geCwGNIeV4QQ2mo0PRony8kD4tc8AVP3l0PCI6v0H589WvO5Jw2em/Aa15m2DyextOjdCzeuXtshZj1q8hQKkb9upbnA3gZIelhpzLnmtwmC1IUp2itmpJvhyqghiFLoFveSHMyAQdtCWpONIWTrmwot9GWoBj3ml+1Go4gN2hyrkW5VFb5aln2B6nBMwOh28HQ50oY1fX9DlX+G9V3keVNc5CDaaM0S9QX+BKsy1mvJ+hvesvL3WijJKkGrCkPZ2kR9gSG3ydFovQ9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199018)(86362001)(82960400001)(54906003)(6636002)(316002)(8676002)(4326008)(66476007)(66556008)(66946007)(110136005)(478600001)(6486002)(2906002)(8936002)(41300700001)(44832011)(4744005)(5660300002)(83380400001)(38100700002)(6512007)(186003)(26005)(9686003)(6666004)(107886003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wfsUpyM16ijg7SH2xIb6kXgmaC4oFMWGgr1cCF/axOhQPBPaTrP0HWaN/HFt?=
 =?us-ascii?Q?EWO741NJ6h1xNIN9PWIhXFUpveZz5rl70nvJXeONzV5bcxl8uhXLVVFu9PUh?=
 =?us-ascii?Q?PxlUoa+cgCei2DhbODsPv+v78P25bsL/dZGaQD3gwsIJeaWXRd4pXCVy/foo?=
 =?us-ascii?Q?ArL/EDn7EV66qLE8RC0AqHd81wNRcwL//BaHzET1iWEi9+F014WHUOBfHZs+?=
 =?us-ascii?Q?Ylpac1XFTOB2SEKqSLuHW3wwHRe9ILujK6ALeFx02AJ4fnpeLwgjE6FF1tWP?=
 =?us-ascii?Q?pPHvrdhdZDE9OOU1R07XxLA30RTLz450k+x983SZRnq/e2iuBmtVvygxD4EW?=
 =?us-ascii?Q?n7+RzNnNlZmGPz0qpYwLgCFbDqnvDPrLN40Wi404j+v9xf8HO05Xz8EiD7Oo?=
 =?us-ascii?Q?VOvNElWjBVTO0BRs+GSvRtxaH7GjmEFRw6U8qGGekB35AQgj2N8DzJdvmYjR?=
 =?us-ascii?Q?QbHJwVx2H1roWQ6nrYNhF0JPugGQjjg4vl8kBH/HAKkRlUKxB1Da8O9IVgs+?=
 =?us-ascii?Q?f4adJgIZtJAXvb5Sz+R7ZYlFI/xDTF0ERE7Z7xoXdixDt2OTdHX2RxixkdnP?=
 =?us-ascii?Q?a91dcfE/m18H0pOJMR10ZzKAlvcLvx7Q50243zidq8SxfpNWAEhsZx4Fo52Z?=
 =?us-ascii?Q?EiVm4Rc3s/DLmmbSzhccG+7XqFnCU8xac7AXC55y47h/8MFwmbI/J36QkK7B?=
 =?us-ascii?Q?88ogYa4YOjofVNikOowapAVBs4tSmN2qKa8drx0E8+56EzKJEltv5z/uWCg8?=
 =?us-ascii?Q?KxfDyB/taUPz1rseaW7kzAzayMe4xx5Rkuh9eTv0g0lqAcmlly+ZkzpM2RCy?=
 =?us-ascii?Q?uVnSuCfN8vzbWmxzp4L1pZPYkuv4voG2TnU9CXJlqaNkkkNntKWqA3bekKkD?=
 =?us-ascii?Q?5sAMJz3fH1v89csyd7NAPu+Jqpo+xFlptGAMX8Alq+pNSy87EIXvDTdWbUSP?=
 =?us-ascii?Q?5WOjPmjt2sWrN3roR+IojN8rgnocEDjoTFwGAi0c3fbtVp7T4udmTTaswliH?=
 =?us-ascii?Q?mY9znhnc+KvkLkxw1dqaBp4bgz4Gx8mRonMIxnPQ3rYXbcHSSqSsjLSbcjBA?=
 =?us-ascii?Q?d6NA91NVOlq6Wavh5AdAIvPI/JIi+jOyf1FPvpqgkS5Dqv6WYHGvCXRdcJ45?=
 =?us-ascii?Q?1DxiHrGpH1tZTPXK0elxM1cowbs4Ow0hgwFlJ4pskV9uwqz0aZYOyhCvyOu8?=
 =?us-ascii?Q?cKFlRHlHEcsMMOD3EkQHNtgEOGeuO+yPMAowY6drxgRf5ToPm22wWAhv8nu8?=
 =?us-ascii?Q?ihLVCXF3fYf8pGVO6KL3QBTxh6+e6TqUnblNSUMLb99jYjxYdyt8ok7UsCbh?=
 =?us-ascii?Q?MLziH647C2csPLTDiDMwfYYUrvhH5l5SVZShBqQDwexWwmyLCAyfI/nEVMQh?=
 =?us-ascii?Q?Zz96OvlvflzqWFDJoMen7JeB2SmlQh+xFZLSYn50A3H8pWUWE99MXFYlsZse?=
 =?us-ascii?Q?P9gv3UsQM1cOz8sSnzAc20KgbErWePJKtt1Avfet4w4NiZ6AcJ+UUDz3PYYF?=
 =?us-ascii?Q?LrACokGHqwrtBjR51Vk3Z2eqAT6elU458MBAYzQh22kH1Y3rpgwOL0VUHN34?=
 =?us-ascii?Q?D+sanNOONTw45oRDe5ifsgn+JykQT9Rj4wQxLt7J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c9160d-4d34-43df-1148-08db0b357f00
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 07:07:39.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoxH2UaiY1zgJTpjDgXnvWcXvnkJD815BcxVmO3xfWzDZPocZOAw56uk54hf+ekj7hYvOJj6x1/0448eaJD7SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> Trace point definitions are reporting different linux devices for
> the same CXL hardware device.  Clean this up and add parent device
> information to all the trace points.

I've found a couple of small changes that I wanted to make but got side
tracked and forgot when I sent this.

Also Dan reminded me we would like to see the device serial number in
these traces as well.

v2 coming shortly.

Ira

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Ira Weiny (2):
>       cxl/trace: Standardize device information output
>       cxl/trace: Add host output to trace points
> 
>  drivers/cxl/core/mbox.c  | 14 ++++----
>  drivers/cxl/core/pci.c   |  8 ++---
>  drivers/cxl/core/trace.h | 85 +++++++++++++++++++++++++++---------------------
>  3 files changed, 57 insertions(+), 50 deletions(-)
> ---
> base-commit: dbe9f7d1e155b97a42f7da81e22acc98fe0a9072
> change-id: 20230208-cxl-event-names-9372fb72a607
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 


