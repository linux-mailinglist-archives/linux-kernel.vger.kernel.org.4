Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE75640035
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiLBGSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiLBGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:18:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F0B2AC65;
        Thu,  1 Dec 2022 22:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669961894; x=1701497894;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w7n62WhLRgRQdMVIGtQyaz59fTP/8IP/R+IOkE34VQE=;
  b=B/HVrdYXnxbGaqw/3ImEqqYfjfnmAU4QtBtaHO+vsngngzMwQXC5RTja
   bxnoUSL2Npy3cPXyIpjwxkTmafPVx7zXJ1hMw9Ncmzvax1MWtx1wX/Z2+
   nkkfr9j203PnrVSCnIMq11vaIUdLzsGNAGZ15+YAF7KDSlQNCRUvErtuY
   fWKfkTa+bFdCGr7MJ18WuqLPmfTNmhHasz0FExwhSpOfYviQCg0bEf68t
   pbKcI2/Uk1E4gtgQaQc4AzwY+xk3JSVWLOBBjQRZ5JtlQ2T9jHt3Ppwho
   5sHhTbMQLF/Qfpb4dci4SLhHUl1aUjWl/hudm0wzsF3/eIp31yCxkb9AE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="313519598"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="313519598"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 22:18:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="769503864"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="769503864"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2022 22:18:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 22:18:13 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 22:18:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 22:18:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 22:18:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMsFa7Wnnn0uwwe1AT2GnPyoT50OYhpPXuT7YAYFbrUhhvn1MH20IWRlX9iqXOTY8f7apnmgpApLr2vgTlbhiHLbC/IEFu7LpVvteEY5LRbsAlCzJhd2NiifklXJZKJRspKKLnfBwKsMe3lf6Yl3zlSMbUwmyPMCHcTL8uSmYX1LfZYBZArLNGDj451m/VuuCTdzmt+e6Wfnj3YSOFDvNAEV9leCPVhgoU4uKJ8PjUuYXjcyoBAgr1CoD+r0QDz0pyd9oWk3VZzZE10sW+UAN2g8llCl/Tc2+z7mja7F9hta4ZcOTYyA47WXqRTAkHol+/uSfBf1gnSGa29B6MqQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCNeTWa0zxC+GrnVeR2oxugQ3p7rWY6dXRJFFvPMF0g=;
 b=oehxujFOkxQ0Xz6HXaHvLUzWH8OOysQ1VUpG7jhPTuKoAU5/WjJI8Wunql4NeBmC8xsqCL5S21CbZ52hiMjAoEVXza/09GVk/6yf/mbSKrproLwZdPyH5U3sPBUXQFofQAE65Qt61+6P8yRn/+5KzLD+YjZP8Hhu4uJP04Pg88AlO8q4D2Y45fRFdU0lZM6sUn0lb2YOypcnnI4koD7anQ7UP1nLwh5RjeRcNBBc20XtErl62hrz1cShezRMvADqCmcGWABC9GzD8eKaCqGhLDolzq3BK99iM10VJozUAAtOCpks/nRW8eAIH0wJ2L+NrPjXtj/3bN66kkDiw3Ar0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5560.namprd11.prod.outlook.com
 (2603:10b6:408:105::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 06:18:08 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 06:18:08 +0000
Date:   Thu, 1 Dec 2022 22:18:04 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2 05/11] cxl/mem: Trace General Media Event Record
Message-ID: <6389989c66b75_c957294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-6-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-6-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BN9PR11MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 6029faed-0e7f-40f0-c36b-08dad42cfa8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jumHuDov7GBeLYx2o4DKbdEnzEVtO+WnRUWg9MgwGE09BLHbY0o2jyfn+5AOgYW9D7iW4o7lkLnDg3rnWenVpMboWY4FIEOE+whoYxPEsjdsIl0SY6//TUztSS4QSf0LnDIbZdhhOqc6PosvVt5RopTLKs6FtwVQpyo40pK0bqBWI98iGoMtYHAXjG9RLIgWnRzvE2hkrv69olB8+NNwetxzZVvFxeAmLDnW0pmI9oELTDAoAnBLQj0AHCrY+dTIlzoofWYoRvJ0SN88IrMAxxsF+Ye0XKSGA9cF1flhg9gvuHCjfI85FVXE9qKt5YHNHZ1NROI1SzuLdvJgGWkpBgTmCmDq8nS7MBG73h6os9OkIfL6fvF3iJAQG//7hMGBTGOrIdgqPs26hmO1PMSN2vjSSW1rLHrpF+ShYnR2LPUvEBnUrk8EBhqr4t8YoP36HiHLPt86EKscAm/LBH6c7iavrfl63gy9IABqQtnGpmMy8AxWjxDJQbDT34oZbdUMLhm8hFlCgFqmeb2ogF/iOrZ3rr54COfUr7iqYC85farT/9+5B62qUj7owD9sTCzZYM1uFL7zlyXSGrOodOJ5MgeAHmCk4jYHTGZM9l2Cf3SY4GJAkAfORZV4Q97xSSERIf64DtIBrl949T26xVYatQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(38100700002)(86362001)(83380400001)(41300700001)(82960400001)(2906002)(5660300002)(8936002)(6200100001)(66946007)(66476007)(66556008)(4326008)(8676002)(6666004)(9686003)(6506007)(6512007)(26005)(186003)(54906003)(316002)(478600001)(6486002)(6862004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KBln7GDjfYI3kUHkCvIy0mVlfdCLDoe0Dy+A768OcytW0OBg6iswqZBvEiSe?=
 =?us-ascii?Q?NGCWlqSTin03n5Rjrou6OXAGP0AsCZn7eRic0KIjRPzWEK7N0JE8HnmGe3Cy?=
 =?us-ascii?Q?E9suIqJFu7urZu3wvLdmiFn2pZNt0NmGUSzSEF2tRgca/mVmX3PvREuORhWR?=
 =?us-ascii?Q?VnBOrl8iu8rfSam5q4a++9R/KJbmuA7uxaIKP2mMC2dM3ktxeM8OPy/GKKTC?=
 =?us-ascii?Q?3X0BF21+azg3mesnffYCVcNdVxDPkYGMsvBgZ6rCOi6AfCozPrgzEyihb5i9?=
 =?us-ascii?Q?i/SFZKQdymjcYclnKb10p7D4JBP86p8leyXC6gI8TN2CLWW/u/ZHjFON0yJE?=
 =?us-ascii?Q?sgS8zFjhR3SCas/wX+mv+biAvOEYPWtR0V1YCPgJ0S16H6VSrFFnHf4ND2IU?=
 =?us-ascii?Q?1k6MskFuFfPncuVdbKsaTeIyRVGcG+RMjPhcf1LB6g/6Y1B1O1bBIUGtskWj?=
 =?us-ascii?Q?43ZbMAeexMyhxsN9iabBXzZEHw9l5uxFqH9MhdZk2d7/XZY67T6mMI5vUnvU?=
 =?us-ascii?Q?m4H7qPiI4nOcFj6Ne1TQzyHVjx8kN5tLOMnWyXlaf6lYtwtS6PSdEqQFU9rq?=
 =?us-ascii?Q?czZREzR/z/L5QkroJ9suEjtGfXHiGggJBOYmfte5Py9wbewUuM07vyA8IzjT?=
 =?us-ascii?Q?Vd2lT9GNvHLpWQx4SZiSYBP4xBO9jLdGhPtpgJ0Hq3rkOqJQE49Itm2l4kng?=
 =?us-ascii?Q?EHHXMpVF0KBEwPKdwmpc9EhE1JGQja6rIxU0m8NfKIKEr1ArrrbtD11OLBGr?=
 =?us-ascii?Q?wKSn41fqCuRGVh8l33JtFoQpzW1hKlN/EDq4Im3r+JP60oUgtQdvAW2v//QG?=
 =?us-ascii?Q?zmtsWjPKWmGzQgptSf7ECbIYRsjsQWFMTVLNsfiypgfpl0fhO8p3y/Tk950O?=
 =?us-ascii?Q?3d9PgNalJpP1FsWqTGfHf+irCw5ezEPDRS4niQ/XySov84/VZ/tX3ExFpT3p?=
 =?us-ascii?Q?uV0fBb1qbMGREhpi9tSlLBgxwypvGv5wRGI0Me4aNxlwtVFuxTI3z7wcuTI0?=
 =?us-ascii?Q?V+XjnpsPSC71tEb9UOGS7MJaPKWgS11rhiOtMzOuwwHIcBPEFsUp52iZ53cB?=
 =?us-ascii?Q?mXHJhnWSgn98dgnO8WTAx9IJ4ilf1s9BW6NlsMS3yIdKxGmYsSUQAQWNnb4b?=
 =?us-ascii?Q?rY/k7pvrOxtKDCuKyhw59zNihCh2CalwJT3vbQA4x8yg7J8HdeMbdEq0j8TI?=
 =?us-ascii?Q?AAUb5e5o09m3mIwUO+4Sxri+G6rYDYjRE/OmHf420nxEGIavOQNQXJ25PlZR?=
 =?us-ascii?Q?JEOMU18OA7GNl5gfHw4lgj1G0y1sKvX/P6cDUXkuSTjEHQpDg+ahy4SIBM1i?=
 =?us-ascii?Q?pAZXZWxMKFuwqKcCekFqfHqGV44OxSo4i0cvtvMidN6yl9CwYMhtyHmYZhMP?=
 =?us-ascii?Q?5ra17yagtlHz1njEAL7VVAqv9zG4QtriZ0P7qE5fA0tQvoBfpuTfqkhbGXVY?=
 =?us-ascii?Q?7EUHsWn8jLI4WXcDDy9tlzUYjRLaqWvOHQVYYtYFfthdflQ9oJ8J2Mf8X3A4?=
 =?us-ascii?Q?ZxL7fzzp/vLMmoJtD5G4Gz9PjMU6yulyDa6omKM7ahXYRL81/ufqCPbqZzWV?=
 =?us-ascii?Q?qFUw3xhh0/kedw8kpFpXXbRzgojMpSJpB6/B2JW6sibyuXrL/HKxKBEFxU/4?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6029faed-0e7f-40f0-c36b-08dad42cfa8a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 06:18:08.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrhebBvT/pBsjr8IPI3dhy4a2ru9oGU2mYQiduk8vMLqi62mEK6ow/4mwTtXhDZ0XQ4G/NntgxZ+FW73hMyhSl93bYGALG68wGPBE5udO9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> 
> Determine if the event read is a general media record and if so trace
> the record as a General Media Event Record.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V1:
> 	Jonathan
> 		fix spec references for CXL rev 3.0
> 		Make flags all caps
> 
> Changes from RFC v2:
> 	Output DPA flags as a single field
> 	Ensure names of fields match what TP_print outputs
> 	Steven
> 		prefix TRACE_EVENT with 'cxl_'
> 	Jonathan
> 		Remove Reserved field
> 
> Changes from RFC:
> 	Add reserved byte array
> 	Use common CXL event header record macros
> 	Jonathan
> 		Use unaligned_le{24,16} for unaligned fields
> 		Don't use the inverse of phy addr mask
> 	Dave Jiang
> 		s/cxl_gen_media_event/general_media
> 		s/cxl_evt_gen_media/cxl_event_gen_media
> ---
>  drivers/cxl/core/mbox.c    |  40 ++++++++++--
>  drivers/cxl/cxlmem.h       |  19 ++++++
>  include/trace/events/cxl.h | 124 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 179 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 076a3df0ba38..20191fe55bba 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -709,6 +709,38 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +static const uuid_t gen_media_event_uuid =
> +	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
> +

Move this next to the other UUID_INITs in cxlmem.h.

> +static bool cxl_event_tracing_enabled(void)
> +{
> +	return trace_cxl_generic_event_enabled() ||
> +	       trace_cxl_general_media_enabled();
> +}

...and now the micro-optimization gets more complicated. The mailbox
command is an uncached PCI mmio memcpy(), the incremental cycles this
enabled check is saving would be difficult to spot in a profile. So
unless it has a worthwhile perf-profile impact I prefer the simplicity
of the straight through code.

> +
> +static void cxl_trace_event_record(const char *dev_name,
> +				   enum cxl_event_log_type type,
> +				   struct cxl_event_record_raw *record)
> +{
> +	uuid_t *id = &record->hdr.id;
> +
> +	if (uuid_equal(id, &gen_media_event_uuid)) {
> +		struct cxl_event_gen_media *rec =
> +				(struct cxl_event_gen_media *)record;
> +
> +		trace_cxl_general_media(dev_name, type, rec);
> +		return;
> +	}
> +
> +	/* For unknown record types print just the header */
> +	trace_cxl_generic_event(dev_name, type, record);
> +}
> +
>  static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>  				  enum cxl_event_log_type log,
>  				  struct cxl_get_event_payload *get_pl,
> @@ -772,11 +804,11 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  		if (nr_rec > 0) {
>  			int i;
>  
> -			if (trace_cxl_generic_event_enabled()) {
> +			if (cxl_event_tracing_enabled()) {
>  				for (i = 0; i < nr_rec; i++)
> -					trace_cxl_generic_event(dev_name(cxlds->dev),
> -								type,
> -								&payload->records[i]);
> +					cxl_trace_event_record(dev_name(cxlds->dev),
> +							       type,
> +							       &payload->records[i]);

Changing the same lines multiple times in the same series is sometihng
that sets off my complexity alarm bells.

>  			}
>  
>  			rc = cxl_clear_event_record(cxlds, type, payload, nr_rec);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1ae9962c5a06..10696debefa8 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -410,6 +410,25 @@ struct cxl_mbox_clear_event_payload {
>  	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
>  };
>  
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> +struct cxl_event_gen_media {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	u8 validity_flags[2];
> +	u8 channel;
> +	u8 rank;
> +	u8 device[3];
> +	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +	u8 reserved[0x2e];

s/0x2e/46/

> +} __packed;
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index c03a1a894af8..a4d6bd64e9bc 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -118,6 +118,130 @@ TRACE_EVENT(cxl_generic_event,
>  		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
>  );
>  
> +/*
> + * Physical Address field masks
> + *
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + *
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
> +
> +#define CXL_DPA_VOLATILE			BIT(0)
> +#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
> +#define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
> +	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
> +)
> +
> +/*
> + * General Media Event Record - GMER
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
> +#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
> +#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
> +#define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"UNCORRECTABLE_EVENT"	}, \
> +	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"THRESHOLD_EVENT"	}, \
> +	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"POISON_LIST_OVERFLOW"	}  \
> +)
> +
> +#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
> +#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
> +#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
> +#define show_mem_event_type(type)	__print_symbolic(type,			\
> +	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
> +	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
> +	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
> +)
> +
> +#define CXL_GMER_TRANS_UNKNOWN				0x00
> +#define CXL_GMER_TRANS_HOST_READ			0x01
> +#define CXL_GMER_TRANS_HOST_WRITE			0x02
> +#define CXL_GMER_TRANS_HOST_SCAN_MEDIA			0x03
> +#define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
> +#define show_trans_type(type)	__print_symbolic(type,					\
> +	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
> +	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
> +	{ CXL_GMER_TRANS_HOST_WRITE,			"Host Write" },			\
> +	{ CXL_GMER_TRANS_HOST_SCAN_MEDIA,		"Host Scan Media" },		\
> +	{ CXL_GMER_TRANS_HOST_INJECT_POISON,		"Host Inject Poison" },		\
> +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,		"Internal Media Scrub" },	\
> +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" }	\
> +)
> +
> +#define CXL_GMER_VALID_CHANNEL				BIT(0)
> +#define CXL_GMER_VALID_RANK				BIT(1)
> +#define CXL_GMER_VALID_DEVICE				BIT(2)
> +#define CXL_GMER_VALID_COMPONENT			BIT(3)
> +#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
> +	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
> +	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
> +	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
> +)
> +
> +TRACE_EVENT(cxl_general_media,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_gen_media *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		/* General Media */
> +		__field(u64, dpa)
> +		__field(u8, descriptor)
> +		__field(u8, type)
> +		__field(u8, transaction_type)
> +		__field(u8, channel)
> +		__field(u32, device)
> +		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> +		__field(u16, validity_flags)
> +		/* Following are out of order to pack trace record */
> +		__field(u8, rank)
> +		__field(u8, dpa_flags)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +
> +		/* General Media */
> +		__entry->dpa = le64_to_cpu(rec->phys_addr);
> +		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
> +		/* Mask after flags have been parsed */
> +		__entry->dpa &= CXL_DPA_MASK;
> +		__entry->descriptor = rec->descriptor;
> +		__entry->type = rec->type;
> +		__entry->transaction_type = rec->transaction_type;
> +		__entry->channel = rec->channel;
> +		__entry->rank = rec->rank;
> +		__entry->device = get_unaligned_le24(rec->device);
> +		memcpy(__entry->comp_id, &rec->component_id,
> +			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
> +		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
> +	),
> +
> +	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
> +		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
> +		"device=%x comp_id=%s validity_flags='%s'",
> +		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
> +		show_event_desc_flags(__entry->descriptor),
> +		show_mem_event_type(__entry->type),
> +		show_trans_type(__entry->transaction_type),
> +		__entry->channel, __entry->rank, __entry->device,
> +		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> +		show_valid_flags(__entry->validity_flags)
> +	)
> +);
> +
>  #endif /* _CXL_TRACE_EVENTS_H */
>  
>  /* This part must be outside protection */
> -- 
> 2.37.2
> 


