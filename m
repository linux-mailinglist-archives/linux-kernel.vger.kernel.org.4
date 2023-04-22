Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A630F6EBC00
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 00:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDVWba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 18:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVWb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 18:31:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094E2700;
        Sat, 22 Apr 2023 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682202686; x=1713738686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5RDnE9mjkUIxArdNIgngSZTyp70v7Gp0eED0wqH5aos=;
  b=e7utqgg6un1ue8s3OQxQfHDXklj0Vs3hfgW+vkw7g/jVfX7MbcNqGGP3
   gSKa+CTnyPd5NsGrEj/Ag3X+02VOYpjexPU2MsqEZn+amBt1AWJgIVBNS
   TJHMeFXyzclCF0aZb+MGWQvNILTPdpI06WGOCQVZpecKxys4UhKTgZXgx
   IXcX9rRKpj+zvaHgRenIus6HVRgfzTCXxAdIBUVYD4O6veOUXfhJFd7Mj
   gGXBTMhdg52kQdy0qzOY7gDQkCOjKXoWe2AU8P0JtxVDEAJg7/hdvTBRW
   tZfQhWvtQBVuWa9U6cRxbTaL/ZN106QzJOPNN1Z1210lP+O5V2xEDBQAl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="335092926"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="335092926"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 15:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="781947059"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="781947059"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2023 15:31:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 15:31:25 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 15:31:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 22 Apr 2023 15:31:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 22 Apr 2023 15:31:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpasE63KsAnhAnhUbMdjPfVVJuxa0FaqA/Kjr2BbgX9biaEPV3IVI2m2u+1uP0cCe2soqUQmBYz8HnNAE9I3RZsVnxPHJF0DPYgileUR9Xi0QIwLvveJmv2v8aN+XdmMQk8+k1e+SCOYKF1MZ/hm3Zv7e5VMA6SO5Yv8Iy4je+XGVkXfJST0xgTj1sdq353gYDmeFpN3K30Q0T7tZDgtGwNEmvG96uwtUhbsBscFaYjwYZYepN3PaJnq0UtZBIDJdKgPdJdGBiQORdhLDW05MFvhjGZXDALaDEF1zI4E8ESey2b/pZOp1EH7UDv6rRvFqVtplNwkr0eoSq4YENWYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MOIxWnFZO2pnioNeWU3oB3IoXqdEjp0iX/YrLVbaZQ=;
 b=XjQlYPvhSDCQxAHN27a3w9ApilaR/leNBcnaqw7/7IKY8+gka34KSa5feaPoj43F0xyuVd94ELIIGYtsVKMwTbLrmnw2H7CnUDm1J+75kM/4i3we9RioeNhSTxSqBsED8Fah2rIGfpFYzUkXQN6fshX48DZOCCmy8UXtHRlZQeSVb+c21M4Fq8r5Oc5MgkwIg00vCwescR5UamdvsjY/vT7jt/4yWkXmIF1EfQbvBLZNBBNRrTM7ybOdsRLBSOVBO4tg+esepc8I+x911TuOcvkHWPCMjkkiy8gK9qrfMfnltJQQ4tlTNjxZt5NvNmqzcSphk7W8xvokLchixkm7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5308.namprd11.prod.outlook.com (2603:10b6:408:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.31; Sat, 22 Apr
 2023 22:31:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sat, 22 Apr 2023
 22:31:22 +0000
Date:   Sat, 22 Apr 2023 15:31:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <will@kernel.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>
Subject: RE: [PATCH v6 4/5] perf: CXL Performance Monitoring Unit driver
Message-ID: <6444603653882_1b41629414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
 <20230413142617.15995-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230413142617.15995-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe763ee-e52b-42cb-711b-08db43814c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQESAQVE2GqrjmbNl2aEPo7cJhcbHYY/LzJfyYTfZzyjzie5ArhgTVaUB199Lwb9dxxZWXVqdVeTL6inXzfgPsLq394KiuWbrHMVtjhH5CrvVBOcpCR+D7IxqdHakBwPLHKajItZe9SSrn+zIqLRX29z6bqaYuZOG37WrxKVW0Hbd1Q4cQdWhYfq6Wq43kHTpFM3CTD/BIZS+ClrblDjyQFvuD+AX4r0P7NZ0yMUN6qUY80t72iQ+Pc6OrUrXNXWB4cb/GISGzuq5A9n5hCNK1hRiByezGnQIP+0JegLcxD8kL2/GUKv/d/FVhheuL6Buv07eFOBufMoCjIIeToZy6agE9F1IXojJiDfgsy6wARRJ1ErPqe0n2Zh6nU9A+0Nm/cGBShv+ayRlyc0vpR88PCH7ip+ZC9zcv7i0MbRuzdAYPNYODVtDLXTuNR/xZDSx0OHUpIDHupqzNz2lrrQY0GwqJda+wM6h6YJI//RvVyB3kknCWQClyNTeCBozodZdLa+u+TyB8ygQ+2NZslOJBU162doRAfWu2vP/NOh4gzFD/DN8DK3ugYn5mCGuDwd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(66946007)(66476007)(66556008)(4326008)(186003)(82960400001)(316002)(6486002)(478600001)(6666004)(110136005)(54906003)(86362001)(6512007)(9686003)(6506007)(26005)(5660300002)(2906002)(8936002)(8676002)(38100700002)(7416002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BF/NjelJmsE6I6P0PVRaki8UW2tZntKq7ElQqw6ShILWj1osrHHV/UEKDz/L?=
 =?us-ascii?Q?KrCvFGHqbOt/4d4QhfKc3x6FLVSNvWvEEeyWmnjkpW/PeuSd5aHJvLgV9NWL?=
 =?us-ascii?Q?0mKQ19ANtjJnyz6mIacsXA7neFtUw2p+CrBHDPLMdQc0pfh5Ok2PcWf24LRE?=
 =?us-ascii?Q?h/ZPAfJQJ+8eHm2fqa9v62hHscqqrB9XQs3y+SNvACqKpHAyWdZC2bowqro1?=
 =?us-ascii?Q?QQ/qcDzLFAQ5r2FTMuKMhseqi5yXczPkYSURJedAfHB3UfverB3etd1jmzwp?=
 =?us-ascii?Q?9upyj7dbPt70YzPQz7yvswiGj7/17SRWnVD/wA4LGqa9BAznIv2DYR6hCF60?=
 =?us-ascii?Q?vktTa0TdD30g7CEPffRuRTeCB6QpzpCLhoRUwnAO0QAu6wWq+2O7cfy4lhwk?=
 =?us-ascii?Q?ufxZsp7nVzzWuLsE0+dlEMKLoQeXWYPQkhRucLIZqCuk6b2Wwocxiay6q5Ed?=
 =?us-ascii?Q?pMs8do8N2IRUJVr4buBWFweAS/epX+veb/XfPhw/s2fD7G9FNnSLQDG+P/Mc?=
 =?us-ascii?Q?oaQiRc8Pe358NQtBDeYP0qgN3qsQbrTWXD4edXxLI21UR8FN0I2//NeGcYnw?=
 =?us-ascii?Q?ruuvWAsJiCwQbtwRK3en/9ZpZt2nmFWEc+SJSvtU4ACHmjNY9fKoQP6/v2iA?=
 =?us-ascii?Q?IG1pgZn+PueAtiZG73FiG11rNwYqO8dIMiLWyJVmVBtvCmUNF6W9jHWQUiFt?=
 =?us-ascii?Q?q7jTmYwIrSqPe/gmtmMheppJutMcNNxNEX22tl0wINIkk1JlMRIeYk+ZBr0R?=
 =?us-ascii?Q?IFOhdRTFXX5ogVVHP3D1c1MQ3NfttRSeeu7BpNa2YEoD3gsh3iga8ZZ+O0Af?=
 =?us-ascii?Q?4b3ehtFnzfOgHJ60hy81+wIkCnvd44kEDxKbUtnZUCWnGXHlRWInMwqlDhlg?=
 =?us-ascii?Q?pmweB2wT4QIbOl1U8PWpLSzEKWhR0XJyCbR/bKp/u0wVpR6U3vjLgY8+BqIZ?=
 =?us-ascii?Q?RXM2kx3E3DVW/hd4ptWJK5NusV474+rGRt727eIZe/NN3inIm61lJDDU5R+8?=
 =?us-ascii?Q?YTTlsb4hkXmRyM3drKv2QZGMcMrQfm4TBJ4pOYWWefuobR9MZQly6oZAQIm6?=
 =?us-ascii?Q?PCv6A1sN7HUufcOfs7xLtz0HkOEjgg3TXI2khEaO9GwNXucu7yvkKRPAmLzw?=
 =?us-ascii?Q?WDi7HaviGiHxEodOQBCZaK8JDzT3X/xU3zGVA2kMP/jIioBzAR6G1jRK8s7/?=
 =?us-ascii?Q?fy1YujOhODYl6hfuzynkn8YeipytChEP62IqKNZrfBmahsYs/SNijCJboJ2Y?=
 =?us-ascii?Q?1Msu2O3OHB/7Sr3BE/ecJl3o7TMmHKP3bS3HuRXomK+iiJGqD5gmKZ+hf6SR?=
 =?us-ascii?Q?WBM7u9OFYNc8wpni4KGHzhIYYWIr2c97fFIUtxIxsfDrNCTsL5AVSgXotPr9?=
 =?us-ascii?Q?miT/eMT+MZpsftBkE338l+M+nWN0tK6G9Ptm3VgBmCGSKVXzNsp3Z0eCmuOO?=
 =?us-ascii?Q?ajFJIIQ0NVjBX7JxXKfLyg9Oe7o3E5XUPJ7LhjS/frRBoFwU/IInDXenTnK4?=
 =?us-ascii?Q?uTf2nJGt3fM7h9cVzPEsyimJa7Gx8C7nf5h2ReiUGFTb+fSO//u9YCAt8pnN?=
 =?us-ascii?Q?MMSPqk6yV1nFQwpThpja8tRrZxNYtTYzSTDotN/u8/xh7T74bnGzgxUcUNKs?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe763ee-e52b-42cb-711b-08db43814c71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 22:31:21.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AF/5flQWDCcXbh/huvFzW5SSiSs3z36L/N3/s/+lFDooF55/49Pr25QUcS1oPrKOelR4P0dWeE2zLytV/vN6ygUpqdZrCwK/tdnS+jgLtb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5308
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

Jonathan Cameron wrote:
> CXL rev 3.0 introduces a standard performance monitoring hardware
> block to CXL. Instances are discovered using CXL Register Locator DVSEC
> entries. Each CXL component may have multiple PMUs.
> 
> This initial driver supports a subset of types of counter.
> It supports counters that are either fixed or configurable, but requires
> that they support the ability to freeze and write value whilst frozen.
> 
> Development done with QEMU model which will be posted shortly.
> 
> Example:
> 
> $ perf stat -e cxl_pmu_mem0.0/h2d_req_snpcur/ -e cpmu0/h2d_req_snpdata/ -e cpmu0/clock_ticks/ sleep 1
> 
> Performance counter stats for 'system wide':
> 
> 96,757,023,244,321      cxl_pmu_mem0.0/h2d_req_snpcur/
> 96,757,023,244,365      cxl_pmu_mem0.0/h2d_req_snpdata/
> 193,514,046,488,653      cxl_pmu_mem0.0/clock_ticks/
> 
>        1.090539600 seconds time elapsed
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan, I was awaiting a "perf maintainer ack" before applying this,
only to now realize there is no maintainer entry for drivers/perf/ in
general, only "ARM PMU PROFILING AND DEBUGGING". Were you waiting on any
additional acks from perf folks for this?

If there are no objections I think this can be included in the back half
of the merge window for v6.4, as it stands now I was still awaiting the
final go ahead.
