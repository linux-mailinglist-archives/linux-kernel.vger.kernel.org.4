Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663F65B4113
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiIIUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIIUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:54:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6043B754A2;
        Fri,  9 Sep 2022 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662756842; x=1694292842;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qq02EWFJlIq2yWLR550V6wAdlSZIDEfXPJ+ScS1Q4lE=;
  b=YZdliPizFst8OAHBRvTX1AZmfYPrKQkp7FgZMEdPzHve2Q5sitcJ70jW
   P/5qQ039BPL9b8IUGnQ0w+NlIKkdcteBc09ctt35Uf5haoPEp2PjyWn0w
   MfrAtMAbrCAjOVhxjshfpNBJnM2po9v/TVsgSAa6J+sAe+D/U14rpIqL9
   me/V4hH7L5ZYf3z8WqpK2q/jrSz7OkM8ade+7Ncy5FmQ9vHx0FHzNyIdC
   REefqX9cXV3NSmr86QpPrlXoqXbU4pv7eGsyO/85ymEZEtRcUOBpNuMRb
   BPm8vKZGbhCaTECLmME1YU2NlqhML64wTZAcAOUAcoDkMeU4xa7l/7usa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277301184"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="277301184"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="757728207"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2022 13:54:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 13:54:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 13:54:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 13:54:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 13:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHxjDEGCghOqQNnhq2BvNXIZetepHtq2rE/j2ZFGz9w2JwWjDhF3zIoBPBFuaLUkj9qhzmPRYWPI8Jl9YpqQMeU7lc4OxKWq5tjxFTSREfmwllM0rEpiLPalFlIVK4Ld4PEw6e22hB0Nx0C1bLXpg3jsFBepHtTiknsQlykUaMSi5qz0DG7EofzdMPMzX73gce5x1oe1fLVlt461MVOm/WFevQtd38Dn6JdP6ZNjtPYc5czlJp34DOh41RQX6L679Pf5EnSdxwwhM1lcIt9l4HoyZfsxULGFgXKmEoAUOm+MBfIHFWMFfwCVdiagPOlZPu++0ueFDVkGa4NgP5M/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUwL2oGFNnvO95DO1DNkG/fKphG8H82kjiI2QR+pPOQ=;
 b=U+91D+v+6z9wWied50V8ub3Xz4kvcrTGq+O+k4AJz1g0I6nyrBzmd+RQ8C9icX+gCefR7anN+cprFA7HbxwKruR4LmKmk6QYI3c1o/pqsynEEkUUnXdnaiZDTOaLR11e5gO3CDVa23w5RVZ9VVCweuibulJ+Sj0EzhMvouzN/Sv36bR14R5MsfqUvNqJy5Uc3gpEDBx53TuXweJERAKUHCtmtozfGEOLubfMb8Lmv86rt9ELGHkRzOvxZatNV7ooFTGOFPoq+4D0gxsBnLHrdejrYkJEITRknVgJc+njAZDjvAp0kbi5fKB6VKAnyS/mdIiVc3o8C6rncwE/CVl0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Fri, 9 Sep
 2022 20:53:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0%6]) with mapi id 15.20.5588.012; Fri, 9 Sep 2022
 20:53:58 +0000
Date:   Fri, 9 Sep 2022 13:53:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <Yxun42yjtZREEeRv@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-2-ira.weiny@intel.com>
 <20220824165058.00007d4f@huawei.com>
 <Yxgd51zdrk9pEXE6@iweiny-mobl>
 <20220908135240.00001217@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220908135240.00001217@huawei.com>
X-ClientProxiedBy: SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f8cf642-8e6b-4174-c91d-08da92a56af4
X-MS-TrafficTypeDiagnostic: MN0PR11MB6058:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKSe7hFmtao68N5Tvw4WK6MUoj5QOmplRbrmLAhTZpQIVrh/nrFkCjPaU4TYWvI5i5nL7zmnPDOppyObH4z7VLLCrxmkI+cJHAgg7etGHyL9WpMnG7hxEmmtdOHX6CXHWjCEGJ6lgZOkRaY9vxcsmYJBu61BACWrj6cuH5oXpixYZqyPOSmH8wMNYiR/PMolWOtnuPJxNetjEn+mVjLDAvLKUw7AxQP9W9oO9EhD833r8TFBSHR+l06Cex7S8G1RwrXodujMsP7YObGcLkkE87IOOFKR9ucIydzMTllXOPka748l2FJXnOAvgvEzAKRJiylvRbqoTwZvMTHEFIR8XVm8iLQxYiCYp3Yyp8pU37LlWqqVAXfscBxvuGeOOJrf49I7Su0x3SwGAu8Aapg3cVvGAHVEbfGpgJWTnyKnuUn+/Lp3VK26cjWwV0WUpHvxgk0Vouu/afMHR/L8cBR3TPI/Q+6kU5f0K9ffBQ7+RnyR4Hwr+sQhUomyPscvZceEuxf/f68z6AKtccJqsSGbxSzOTPiCqxcCxaSK55n3Hc2IP6Kv1j2BXZsyI+u0WMfU+iRy8mPBV2mWR+LZyBDQjpZ2Mb1KMkiPDrz2Pht/eFCx1E1ugtD3nQAq534BPyrGJgzzttmFZIRh9qOcEDHrXzuBIYvR/EDk94jK42c3Vg88BLL3t207d/JHK1cx2/6+qfe3NGh4iLfGLk6mE8d22A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(346002)(376002)(39860400002)(396003)(82960400001)(478600001)(44832011)(2906002)(83380400001)(186003)(41300700001)(86362001)(6486002)(8936002)(8676002)(54906003)(6666004)(6506007)(4326008)(26005)(66556008)(5660300002)(6512007)(38100700002)(66946007)(9686003)(66476007)(6916009)(33716001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RP7m6fyRA15iiYh4kYgpiEuUaZOT1Hv09x5OIpJENHJlW3/5jTHXDrcuqJPb?=
 =?us-ascii?Q?sOeshu82Cdr9CC8yp7LuNqWjSa3h/8sPbz+wy2znU2uw6+JkYOTRJ8ekb1ZV?=
 =?us-ascii?Q?V1t83ZpVvoD54XFslFXl0TOnMhd+uPN7+U52DFRiZKn78nHL0nGFGUAmILjF?=
 =?us-ascii?Q?AQPeJfZzsYPUABAt08Hxle5hpclHaezN4e0qMzqL87c79g+LC4PmpWZV8Qbg?=
 =?us-ascii?Q?VOuJzmrAik0sEycS1/GnYTabj9tV7Xy/UBBjKneRJM2E9ltzkPxKuxA14ZQW?=
 =?us-ascii?Q?mh6gOqNOkx+IibMEEX4wDeuiAmc4SmpVM2Kuu/NAWVczAFBmjDziSYrp0zit?=
 =?us-ascii?Q?xGb4zyr+kwWFbMhoAxERx/lbj2fEXLmxVseOMBrn9osPmgTWqXACNcuV/t1a?=
 =?us-ascii?Q?8ei4/4iBWOZ1hpmJsMxbHD8lIlLG15Jq7eBwsOasToHoDCD+T/BCRkvJUp35?=
 =?us-ascii?Q?iYsW1+WF19n5muub2c/eY/rVosl1IOGNavw5tbj0o54kaWzcWYld/O++cET3?=
 =?us-ascii?Q?rAlGLeDex7eQ4/lgb6+LIQI2mwX2u2KeVwOShk6hyLzKb2HrXM7cKF/WiFrS?=
 =?us-ascii?Q?oSphSP/Ut7m5EoqprYSwIKTbMS4MeijkQuNqubgZSF+gQxXuWv8Ult1vm1Sx?=
 =?us-ascii?Q?j11R7Avf2tZgXhsbRNmc07DIoGHB6e2LZEJsrV9r78ycZ0hR2owVeFs8NW1o?=
 =?us-ascii?Q?ISgj1DtHEaQz7t0EohdFuBWD/6jbZd3umSZkhI2f48GEPJ7wZbyncAZ8Xd7b?=
 =?us-ascii?Q?0opryeT1CpP6Ae/gtUyGWDpObvH3GltAdhENeRgE1qFUL3Eb+TtgCDz6CBeZ?=
 =?us-ascii?Q?CpJqBReWBY2kXjDGEiqgByiMSy0/42sVyYmoaqqF8ar9OXnuo3/gfJXXkiLt?=
 =?us-ascii?Q?ZGJmWt5DgcoNBR38IxBZ41NSSkhybzZXImRDGNkYAf7R35uBEQ3AZCal15TV?=
 =?us-ascii?Q?IY24oetZzrrGqkwJPr7VR/TiDJJjlgh968OrnkrJgFf3lcS4Kflmfrsek6nX?=
 =?us-ascii?Q?3z7fPd6Sewcf4siCvuM6j/tnTm3kYk3gG4z+ty7cl1Jpjgza3d94e985UjT0?=
 =?us-ascii?Q?uLQRvWih3/4WW2NPT99OwJsOQH9+iA+RlXJkSKCXXUgTLEcl49Hj7jcfLbgy?=
 =?us-ascii?Q?ycEddaZrbIntvTrO3WhvZR46R8Lp7M0VGDTVOsoSrFSsJeUH9IDYU1hGK/Vz?=
 =?us-ascii?Q?i8WbDCl1DtuXUf9aGn30+dl4MBcBMmHho7hfbL8uVoamV/+q+s/H7kF7rM1v?=
 =?us-ascii?Q?pjd4b0XREkPxaeP2N8troHbTTWTrSoHaNTu+tBuSEK/1Jsd6QiVpMfOPBd4c?=
 =?us-ascii?Q?9Tu878lYpVvat9tLy1YYs3Vqr0BcJodKTemoJDVxNgKX95BpqJ2XFKAE9RT7?=
 =?us-ascii?Q?pUS8NxrvZwEeHiAT4BhouyS4LsCV6eMa5QP+dTF/WtdtydrMWiprJmSPtaJH?=
 =?us-ascii?Q?uoLu/DW2bicJGkcRWDSftfgjI78QEyMHQF/fBE28/m5DHKXPXyl3WlfE5JLK?=
 =?us-ascii?Q?6cVJyo3EbQOyChQFdbZvUgBoR/gGRgxj0rZoETkuEZnm64Fz2Q28WcZq1X+H?=
 =?us-ascii?Q?aaKT5u86trrbk7oDTm66tbpZq8rGE4QaNyo7cwXD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8cf642-8e6b-4174-c91d-08da92a56af4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 20:53:58.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmHxUs8Oxux4o6ba/ExKE8RBwgcy19AWzVmWsjjMnawkT/IvJUF57glACH4+8EyOmlUyqm9E1fKb49OXHa9vsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 01:52:40PM +0100, Jonathan Cameron wrote:
> 

[snip]

> > > > diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
> > > > new file mode 100644
> > > > index 000000000000..f4baeae66cf3
> > > > --- /dev/null
> > > > +++ b/include/trace/events/cxl-events.h
> > > > @@ -0,0 +1,127 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#undef TRACE_SYSTEM
> > > > +#define TRACE_SYSTEM cxl_events
> > > > +
> > > > +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> > > > +#define _CXL_TRACE_EVENTS_H
> > > > +
> > > > +#include <linux/tracepoint.h>
> > > > +
> > > > +#define EVENT_LOGS					\
> > > > +	EM(CXL_EVENT_TYPE_INFO,		"Info")		\
> > > > +	EM(CXL_EVENT_TYPE_WARN,		"Warning")	\
> > > > +	EM(CXL_EVENT_TYPE_FAIL,		"Failure")	\
> > > > +	EM(CXL_EVENT_TYPE_FATAL,	"Fatal")	\
> > > > +	EMe(CXL_EVENT_TYPE_MAX,		"<undefined>")  
> > > 
> > > Hmm. 4 is defined in CXL 3.0, but I'd assume we won't use tracepoints for
> > > dynamic capacity events so I guess it doesn't matter.  
> > 
> > I'm not sure why you would say that.  I anticipate some user space daemon
> > requiring these events to set things up.
> 
> Certainly a possible solution. I'd kind of expect a more hand shake based approach
> than a tracepoint.  Guess we'll see :)

Yea I think we should wait an see.

> 
> 
> > >   
> > > > +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> > > > +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> > > > +)
> > > > +
> > > > +TRACE_EVENT(cxl_event,
> > > > +
> > > > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > > > +		 struct cxl_event_record_raw *rec),
> > > > +
> > > > +	TP_ARGS(dev_name, log, rec),
> > > > +
> > > > +	TP_STRUCT__entry(
> > > > +		__string(dev_name, dev_name)
> > > > +		__field(int, log)
> > > > +		__array(u8, id, UUID_SIZE)
> > > > +		__field(u32, flags)
> > > > +		__field(u16, handle)
> > > > +		__field(u16, related_handle)
> > > > +		__field(u64, timestamp)
> > > > +		__array(u8, data, EVENT_RECORD_DATA_LENGTH)
> > > > +		__field(u8, length)  
> > > 
> > > Do we want the maintenance operation class added in Table 8-42 from CXL 3.0?
> > > (only noticed because I happen to have that spec revision open rather than 2.0).  
> > 
> > Yes done.
> > 
> > There is some discussion with Dan regarding not decoding anything and letting
> > user space take care of it all.  I think this shows a valid reason Dan
> > suggested this.
> 
> I like being able to print tracepoints with out userspace tools.
> This also enforces structure and stability of interface which I like.

I tend to agree with you.

> 
> Maybe a raw tracepoint or variable length trailing buffer to pass
> on what we don't understand?

I've already realized that we need to print all reserved fields for this
reason.  If there is something the kernel does not understand user space can
just figure it out on it's own.

Sound reasonable?

Ira

> 
> Jonathan
> 
> 
