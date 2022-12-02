Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2664008A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiLBGZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiLBGZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:25:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DBA457;
        Thu,  1 Dec 2022 22:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669962346; x=1701498346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gfPwY6LBMJud5WEIvde6XMxxUOsGFG17F9RzMGVYHuQ=;
  b=JrtJBN1MtICCZ4GmuQXZMDSkguzTs5fd38DI9iZQRaPQ955PKPUisyOz
   VuVhRsM1kKJHEElLIujPPYekl2DZfdn4WmLstecldXq50lWak0pPkT1dh
   Z/Dhq0JERGdgkNn3R00DOT2oLB1ITFqZ356OQegk3BmF//c+SWBsN6s59
   qOTOjdDds4sIlMpuZx4tcX/R6EfberhPNs2Ju+5rCvdf++k74fJKQ+w6y
   +BP+resq3Mz8pC8wRy7lYfzrLKoljeQLm+JFLe5ePPbMo+v+ZgVE626va
   7vzA2da70F4JYh7zaA9MgNl4LlmrBPIVxL3FVQAXkY820ESbW8vyh47MZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="299248307"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="299248307"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 22:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="675725965"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="675725965"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2022 22:25:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 22:25:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 22:25:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 22:25:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 22:25:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfL+PVucWtw/jb+wbBz5qZPCjkrTltuRfZRIO3nbhDDXQMgp97EeQmdP10jZcQaTjOPeSEV8hGZS3ZpG8g8rlN/YWA1ubQwFR/gOxA/aieWE4NHo2RG7wcZwaoupmAorEaUZrLQEOZWa/T7nH4iO8AAswQH4ve9LO1w1MyZZPwl+S2D+4tjGIm3Usv4Li8wJ3JY1YpjA6SKEiZpLoaWoL4ziY2dvWqEaqonBGL5M72+tfE1Gqczg8FuRarAHPpo+7/7ZUiBf3DdQhFacG5DQxuA1Z+Bs7fEBZ3o1sZRkqE81pFInKNdky7yo7GEOvjjPfk+YbZHihJBhUJFKKYbezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PioxuTSVrZ7hOVNiSRwfNAHQZ2gAChdtidS5GVhCMqQ=;
 b=N95U1T7C3bfUxSi5ykhsxPzZUEnOQfRJNy483WihPQRow073GMrqnTqdxyAccOBTH1O84CKDaU/P1vrURzFn4O3yazAW3H5jqG4DvU1Y3JnMxnPLKe6IxA7ekCYrbKGDxMghPRrlN/HqFenQekWV/QNcYYxx6GJpry0q5IeR4HN8ApePK2UAKYkdgx9jZ58nJqzYExPxXoOItzKpo6sOwjsS5qcn+4dPt4gsdMUYd9mBuhYE7TtgP5iEGjS26sOkCLaoSre3i0cWmNoDqbehTdEVJO1X6+eY11aQeqQ3kLLZdqpyblaDeQNA3MkP2u5qcFGfmq0SIzYMl8yHntb1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 06:25:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 06:25:36 +0000
Date:   Thu, 1 Dec 2022 22:25:33 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2 07/11] cxl/mem: Trace Memory Module Event Record
Message-ID: <63899a5d8280d_c95729462@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-8-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-8-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7215597d-7d19-4559-5c7c-08dad42e061f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCmK8wH97SRqO3Xe92XEr1jtnJRnvBUJ/Oe+nLcDGhWl3JNl1Bf2hnG4wspOHB5fPcJOGcEn6Jd1rI0diHgizjh6hqCurX+HCNkS8jnq8IF1JsJJ8BBYqvtrqG0TgrzQO+FyoDQZTMAIqDlq1AoRt8pC/I1rRlMq/mx1L0kHsfU7vY9R6F+lxqaoQ8wgXELhvNzrd6BP8XMdnC0UPZVzSHxmo9ZQn/La0+pmiTdT/m7ZKgtRvJgVqtKYyM+DEzvHk1oN4JWELvnNA/Tb1Pj4PYt9H6nQZ3Rr4QLCBrD4BW3A/fLg5uFUOGslNzljqlIagVEjK5CRRl/zK3vCJCXMOw74uGYpHq8tdiiAHS7u0YK84MZljZ5Vt98LsVCixeb3sOqd6ptYE+vuO4XHnhu4GlpU0RwUWNAvnL0bghC5xfthzJjQKeqoeFbWD6m2kuUxIxqd9Mnj2uU4y0aYF/ehvUzeGqz2G32nz6HqCqYCRddxvRvQ6JDrCwMp2ZhdUK9iK09xQob8/877abAdkPePNU1xAEaRWLU0EJwEa9QxGDLEDcoRQDHQFPEoxPw3NOjagVfPOvUqLGKBOpdqDEq228I9qJkHiM2lSUlhDPSq8OOpynb2ThuYC/vyHHbFHE8yGAjgbNKB4ZhA6k+86Q2icQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199015)(478600001)(9686003)(6666004)(6486002)(6506007)(6200100001)(6512007)(26005)(2906002)(54906003)(316002)(4326008)(8676002)(5660300002)(66476007)(66556008)(186003)(66946007)(6862004)(8936002)(83380400001)(86362001)(41300700001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OiS9+RDs+fTlydp7+xh1wG9K0vDIiGrVilDvHpATZNZbr2gfcMT6Qcolp915?=
 =?us-ascii?Q?HtJVwmBwJ2ZzCejesp3wC8P/oVXZwtqeYObw0XOZdCNDv6fBJl6WenDZ0Lhx?=
 =?us-ascii?Q?Es5kKumGHBw0mq68FTYqRaCYUrv8pUisx/Kx22i83HbNeZtZdPzizaIVo5eM?=
 =?us-ascii?Q?IQ5Lp2em9rEfqfFoXlOWOUZKIH2dTJ0moExVAnrcZ1GT6QEmoExh2G56Kb8y?=
 =?us-ascii?Q?GhfUZpjsGOXKmVM++xJACVIzbB+75wW4n0OAzht2Wqbuukr+GcwX9srnelZn?=
 =?us-ascii?Q?5xXoDh9/vdGaCcpVjIVYYMmKUy4wGKE4gjQ6kcS0YsujRuY+wmvKGG3/rHM3?=
 =?us-ascii?Q?q1a90ofi2TViFU0DGcB5hKqcRj3LIFG3lFrWuIE212BMFQJ2ZLV6c531zBsf?=
 =?us-ascii?Q?TxMVZE6MyDCUOla+CZ6ZmXKoRp9+OfFQpfNLpPGC5x4T0OwlSVIPcWs+TdBO?=
 =?us-ascii?Q?a02oOdc15/Z4fXIyNAowkuoKhNbdBTPkQFKPpHxsRNYX1bMng2TEiMmTzW5o?=
 =?us-ascii?Q?ly0PGO9QjF6T3yEj1kfRNUlu5+yx//hnGmUEkcevgftRBuczInwYOVIPTQHW?=
 =?us-ascii?Q?IqLF224+ezTZGMBQksEkYPagd/PpEcUuN+lh52BzmR7d3gxM04s/isDiRQyi?=
 =?us-ascii?Q?cgdr+9Fsu5LAr6sRc8884MBvhY1FdZE24RIZpu+HDl/EC2tq09W344S5FdVF?=
 =?us-ascii?Q?Au4w8SW2ek5rDuwEWvjS7PFQptHR2Ael0YZSBxUxsvete/kidFwdlZjs7M12?=
 =?us-ascii?Q?r1hpKdVT8sJoU+HGU8BFNkgxLM2AD7S8obZxgFfkCLWhjjGF7/yIoN846vZc?=
 =?us-ascii?Q?XZI/mnQ+e20ZymDBE103sIWy0eQIGBorWpGnUyDEGjJHqujitSXygWbWILvW?=
 =?us-ascii?Q?/0wuPLcWWJDaopSzfdVHmGFMAx9uN+vs1/7Jshg9tcl3KJsn4pCF2o/zzmYy?=
 =?us-ascii?Q?euwrwqvXe5jFofxeotn/QwfkhmDJVYRT67g+JbVQxPoVaWkDhZGeqp383Ts5?=
 =?us-ascii?Q?XJnq+RcPinqCkNM2PhXj+7CQ0KFJ4nAfa29YteixxLyoH2k31XroPyNwcEwU?=
 =?us-ascii?Q?Ivu67qyBw91ZweCQpQovp2pA8HXU4aJt2GUmYexms2lHTnoJRsvVsZC9UyVf?=
 =?us-ascii?Q?4eHFZ0PbQeH8JaVf81s0vYumaLYkG1B8nhWFR3NilTL1pkghVwwrAgGedude?=
 =?us-ascii?Q?eulj8q0nIoE6LNTMrCDvfjSQx94qP0qpENer4UHqiP5/Nlzc+TrcikgdEJ9L?=
 =?us-ascii?Q?avzaWpNuAukpO7CaoLpwzRlk60c568DI7piWxfkvP+fVAKc7mi6EGxO0WuWU?=
 =?us-ascii?Q?2odMonEu2u3TreU3KPBB7IS17crqNAc+htk13/3qo9zFwI09tmTcLtqrk66v?=
 =?us-ascii?Q?B2c6SIc/ESHUMULTZTZb9yg5C80tVTPXGYVI9kGKh557vgp0lHjTiPt+6wT4?=
 =?us-ascii?Q?vl7pbYyUHyQs067X3m+anG6QouFsnX+j8P/VeBApenVyHwJZzrcIT1S6WKmM?=
 =?us-ascii?Q?xcGbHgkiascA3r+YXWpjC0/WSeGOKD9bgZNEL2ch8jE8g21BhUkgbaif7z4Q?=
 =?us-ascii?Q?QcKv2DHnb5gLihmjOwxZmoxra/7mG9pkAbzUHZk0e51oWOOwqv0I0DXMD1Lp?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7215597d-7d19-4559-5c7c-08dad42e061f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 06:25:36.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H01+QfhK5f/Cal384jbhOg5M8OWI9I+rWqfh0UGuvoNFD/xrnfqllr0M1RExT0gEbpW32xi1ErfRIhscIEs8L7aVhSCVLz4CrH3ZJB8rrwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7540
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> 
> Determine if the event read is memory module record and if so trace the
> record.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V1:
> 	Use all caps for flag fields
> 
> Changes from RFC v2:
> 	Ensure field names match TP_print output
> 	Steven
> 		prefix TRACE_EVENT with 'cxl_'
> 	Jonathan
> 		Remove reserved field
> 		Define a 1bit and 2 bit status decoder
> 		Fix paren alignment
> 
> Changes from RFC:
> 	Clean up spec reference
> 	Add reserved data
> 	Use new CXL header macros
> 	Jonathan
> 		Use else if
> 		Use get_unaligned_le*() for unaligned fields
> 	Dave Jiang
> 		s/cxl_mem_mod_event/memory_module
> 		s/cxl_evt_mem_mod_rec/cxl_event_mem_module
> ---
>  drivers/cxl/core/mbox.c    |  17 ++++-
>  drivers/cxl/cxlmem.h       |  26 +++++++
>  include/trace/events/cxl.h | 144 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 66fc50d89bf4..30840b711381 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -725,11 +725,20 @@ static const uuid_t dram_event_uuid =
>  	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
>  		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
>  
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +static const uuid_t mem_mod_event_uuid =
> +	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
> +
>  static bool cxl_event_tracing_enabled(void)
>  {
>  	return trace_cxl_generic_event_enabled() ||
>  	       trace_cxl_general_media_enabled() ||
> -	       trace_cxl_dram_enabled();
> +	       trace_cxl_dram_enabled() ||
> +	       trace_cxl_memory_module_enabled();
>  }
>  
>  static void cxl_trace_event_record(const char *dev_name,
> @@ -749,6 +758,12 @@ static void cxl_trace_event_record(const char *dev_name,
>  
>  		trace_cxl_dram(dev_name, type, rec);
>  		return;
> +	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
> +		struct cxl_event_mem_module *rec =
> +				(struct cxl_event_mem_module *)record;
> +
> +		trace_cxl_memory_module(dev_name, type, rec);
> +		return;

Replace these early returns with a final else that calls
trace_cxl_generic_event()

>  	}
>  
>  	/* For unknown record types print just the header */
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f5f63a475478..450b410f29f6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -452,6 +452,32 @@ struct cxl_event_dram {
>  	u8 reserved[0x17];
>  } __packed;
>  
> +/*
> + * Get Health Info Record
> + * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
> + */
> +struct cxl_get_health_info {
> +	u8 health_status;
> +	u8 media_status;
> +	u8 add_status;
> +	u8 life_used;
> +	u8 device_temp[2];
> +	u8 dirty_shutdown_cnt[4];
> +	u8 cor_vol_err_cnt[4];
> +	u8 cor_per_err_cnt[4];
> +} __packed;
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +struct cxl_event_mem_module {
> +	struct cxl_event_record_hdr hdr;
> +	u8 event_type;
> +	struct cxl_get_health_info info;
> +	u8 reserved[0x3d];

Decimal size please, otherwise the rest looks good to me.

> +} __packed;
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index 474390f895d9..48786d6c9615 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -334,6 +334,150 @@ TRACE_EVENT(cxl_dram,
>  	)
>  );
>  
> +/*
> + * Memory Module Event Record - MMER
> + *
> + * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
> +#define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
> +#define CXL_MMER_LIFE_USED_CHANGE		0x02
> +#define CXL_MMER_TEMP_CHANGE			0x03
> +#define CXL_MMER_DATA_PATH_ERROR		0x04
> +#define CXL_MMER_LAS_ERROR			0x05
> +#define show_dev_evt_type(type)	__print_symbolic(type,			   \
> +	{ CXL_MMER_HEALTH_STATUS_CHANGE,	"Health Status Change"	}, \
> +	{ CXL_MMER_MEDIA_STATUS_CHANGE,		"Media Status Change"	}, \
> +	{ CXL_MMER_LIFE_USED_CHANGE,		"Life Used Change"	}, \
> +	{ CXL_MMER_TEMP_CHANGE,			"Temperature Change"	}, \
> +	{ CXL_MMER_DATA_PATH_ERROR,		"Data Path Error"	}, \
> +	{ CXL_MMER_LAS_ERROR,			"LSA Error"		}  \
> +)
> +
> +/*
> + * Device Health Information - DHI
> + *
> + * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
> + */
> +#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
> +#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
> +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
> +#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
> +	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"MAINTENANCE_NEEDED"	}, \
> +	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"PERFORMANCE_DEGRADED"	}, \
> +	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"REPLACEMENT_NEEDED"	}  \
> +)
> +
> +#define CXL_DHI_MS_NORMAL							0x00
> +#define CXL_DHI_MS_NOT_READY							0x01
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST					0x02
> +#define CXL_DHI_MS_ALL_DATA_LOST						0x03
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS			0x04
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN			0x05
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT				0x06
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS				0x07
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN				0x08
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT					0x09
> +#define show_media_status(ms)	__print_symbolic(ms,			   \
> +	{ CXL_DHI_MS_NORMAL,						   \
> +		"Normal"						}, \
> +	{ CXL_DHI_MS_NOT_READY,						   \
> +		"Not Ready"						}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOST,				   \
> +		"Write Persistency Lost"				}, \
> +	{ CXL_DHI_MS_ALL_DATA_LOST,					   \
> +		"All Data Lost"						}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS,		   \
> +		"Write Persistency Loss in the Event of Power Loss"	}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN,		   \
> +		"Write Persistency Loss in Event of Shutdown"		}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT,			   \
> +		"Write Persistency Loss Imminent"			}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS,		   \
> +		"All Data Loss in Event of Power Loss"			}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN,		   \
> +		"All Data loss in the Event of Shutdown"		}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT,			   \
> +		"All Data Loss Imminent"				}  \
> +)
> +
> +#define CXL_DHI_AS_NORMAL		0x0
> +#define CXL_DHI_AS_WARNING		0x1
> +#define CXL_DHI_AS_CRITICAL		0x2
> +#define show_two_bit_status(as) __print_symbolic(as,	   \
> +	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
> +	{ CXL_DHI_AS_WARNING,		"Warning"	}, \
> +	{ CXL_DHI_AS_CRITICAL,		"Critical"	}  \
> +)
> +#define show_one_bit_status(as) __print_symbolic(as,	   \
> +	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
> +	{ CXL_DHI_AS_WARNING,		"Warning"	}  \
> +)
> +
> +#define CXL_DHI_AS_LIFE_USED(as)			(as & 0x3)
> +#define CXL_DHI_AS_DEV_TEMP(as)				((as & 0xC) >> 2)
> +#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
> +#define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
> +
> +TRACE_EVENT(cxl_memory_module,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_mem_module *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +
> +		/* Memory Module Event */
> +		__field(u8, event_type)
> +
> +		/* Device Health Info */
> +		__field(u8, health_status)
> +		__field(u8, media_status)
> +		__field(u8, life_used)
> +		__field(u32, dirty_shutdown_cnt)
> +		__field(u32, cor_vol_err_cnt)
> +		__field(u32, cor_per_err_cnt)
> +		__field(s16, device_temp)
> +		__field(u8, add_status)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +
> +		/* Memory Module Event */
> +		__entry->event_type = rec->event_type;
> +
> +		/* Device Health Info */
> +		__entry->health_status = rec->info.health_status;
> +		__entry->media_status = rec->info.media_status;
> +		__entry->life_used = rec->info.life_used;
> +		__entry->dirty_shutdown_cnt = get_unaligned_le32(rec->info.dirty_shutdown_cnt);
> +		__entry->cor_vol_err_cnt = get_unaligned_le32(rec->info.cor_vol_err_cnt);
> +		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
> +		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
> +		__entry->add_status = rec->info.add_status;
> +	),
> +
> +	CXL_EVT_TP_printk("event_type='%s' health_status='%s' media_status='%s' " \
> +		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
> +		"as_cor_per_err_cnt=%s life_used=%u device_temp=%d " \
> +		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u",
> +		show_dev_evt_type(__entry->event_type),
> +		show_health_status_flags(__entry->health_status),
> +		show_media_status(__entry->media_status),
> +		show_two_bit_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
> +		show_two_bit_status(CXL_DHI_AS_DEV_TEMP(__entry->add_status)),
> +		show_one_bit_status(CXL_DHI_AS_COR_VOL_ERR_CNT(__entry->add_status)),
> +		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
> +		__entry->life_used, __entry->device_temp,
> +		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
> +		__entry->cor_per_err_cnt
> +	)
> +);
> +
> +
>  #endif /* _CXL_TRACE_EVENTS_H */
>  
>  /* This part must be outside protection */
> -- 
> 2.37.2
> 


