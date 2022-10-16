Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CD360037E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 23:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJPVnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 17:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJPVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 17:43:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80930576;
        Sun, 16 Oct 2022 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665956622; x=1697492622;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zazm/7L4vKyCLhD7z5yAIlmUCpLbTcKc9odvtuhuij8=;
  b=noM9KnMPhuUHSWsxb51oBye4Nd+BvSl2CXxKJMcZFJoaF3A6/6Y+MWZx
   DAccgHiOpHPaOF5jgBAfIiU8dOL+BRXcnwa/gn71l0ho4Kp+g7BEC9JlD
   15t5ug6UL8WTTtNIdt+2vbp2lWaFY8iiN1ZtEpCuSL+u3AnaoQHY3F1y0
   QfZRkgvHFB7Rs/ccKWYmDuv15goxyNwDThagbC66WD2oyP2+aNqEUYOrn
   8ttNDDZ9ewpELo7HyQ+c1ZzNKEEVIqB5eYi1ilHio9dSbAGPpg9WxrJtY
   amWtDHo05AIoGGvBxTu93hQ2Bpm90C/oZ5G2Xb547pMmILkOSTZnmL1qP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="286055501"
X-IronPort-AV: E=Sophos;i="5.95,189,1661842800"; 
   d="scan'208";a="286055501"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 14:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="579167861"
X-IronPort-AV: E=Sophos;i="5.95,189,1661842800"; 
   d="scan'208";a="579167861"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2022 14:43:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 16 Oct 2022 14:43:41 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 16 Oct 2022 14:43:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 16 Oct 2022 14:43:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 16 Oct 2022 14:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/Lxat3koE2IoRFZvvI9JYA0aFsP84FqZIIpKWhHujFgqDqWvztoS8/o+NqlLaga89Da+Oxgkvub85ljv0QnI7a+WFNAXGsVpOW2lQS/3bIyiyHtsL8aSz09PWp/y7Bh5IKGJjnUA4CdkUgBubnZ2Rr+p3geolT8zM6oO3p0XAVzv4fja2NBR5cvyIIh0YAw22fPumQdBdCG1JGy5csIUVn7E5Bif6EjbpN9ed9nu3CFT0+YUVUKmzAEPMGsqJedS2M+zNP/P7MpODTkA82QGf6UN5c1XyPoff14Fk6evIjOhwrUpVx61dIYS1Wjte856D09zgJPkMS/cz/5uz1eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtuHEvgDDqItmWlLCGQ911BV/d2K0sXzN8+YYuHo+Po=;
 b=Xok5dzljIohRChs6ULSh2yz4zCKMJDXpAQXfaYlYXv9uYpN70Hr93BiwJHuHaBXGynlPUOtzvPHkf6mib7791jFBp/XjLwUMsm3KdjLzVQXmCQtE9aFmL7wnPFnp6LhKJ8PUoDjpyg+W+KXN2YUQnsmoKhcWKCK2slAXAj+daPC08qGAX19j/Ch4k47qMmhB6blSD6oHGycxnQeWTpx5Vz/yNYH2sVX+y7wegwYELDjiqi7Tp3AbmZdtymDzxWYhB0Pmw9CXRKxbhqtPXiDCItfwSVKzNrI1PKHLHw6SfeD7rYFAJEIUUJINOucPP4/9hazaIOtSycHLNBj01dFLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6936.namprd11.prod.outlook.com (2603:10b6:303:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Sun, 16 Oct
 2022 21:43:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 21:43:38 +0000
Date:   Sun, 16 Oct 2022 14:43:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y0x7BQ31M2gi3ldX@iweiny-desk3>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-3-ira.weiny@intel.com>
 <20221015072840.5f31517b@rorschach.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221015072840.5f31517b@rorschach.local.home>
X-ClientProxiedBy: BYAPR01CA0006.prod.exchangelabs.com (2603:10b6:a02:80::19)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cd06c8-5c6c-4116-b12c-08daafbf7bf5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaIlU6RAQcD6kK02sdy88WYhWKd/viWQLo1G5tz/EuX/x7hHIHoDvMeyDhGsFXdd+0I7D6Npf62Ldw4M9hT5rjNgJRqy+u3uFPB6MmyxssArPq/XOiMKQHR2b+19Anut8prZrM8r/r9gBHgkwI+hkP144RkL7wBVoNqfd4hoU4z4cHFEtG9LBhzGVPUF9+2rJkWIMhhhYAQLrK1PmiebLh0r2AnLaKxdGrtRP1mytwkhj7IcEzrH6e8/VyTpy4hHu6MOciQDI6GzR0sBccwYWlSEAmxq4/bIHfpmMcM8arUnr56lcEV0RdKxRS+LAligIICageKb5PfBIE1cWgyiZsFrIX0Lstvw8+XAVV/zyQ7QiaF/OJ8NtkbjDEPpjxmsqp/VataF76jyyntmkci4ZJD5+VqEqBFQXHTKyLhG/bXRq5xHbCo7zP4+mOIb4H73jPCxO7mwi0vpjKBlMFtMQl30VlqQIz+DkHmlNvQY4iphWkTGUJYargxHIWLzT6E7KlsxttCTZMoZkdgcs5CQfMh4kPpXlXyY0/D93CwXN8J7LFCQN+kiGnspttjJ6BtZM8EB86JYEn2YHQ+desbVyjIQtXIjiXjQXqVzlvoXcjEvbkIfwyxYPYdT6/b+g19NuI+F7VDXp47SLiu0AyXtCzXPDueSMpJvgzYJ4U1yuGnOJYHq4g1bG7Id4g6B/5x76/PRmdXZSx/BfWQibTv3csrMNYdQxlZexn3mXhwOjN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(6506007)(9686003)(26005)(66476007)(66556008)(8676002)(66946007)(4326008)(316002)(6916009)(54906003)(44832011)(5660300002)(2906002)(41300700001)(8936002)(6666004)(478600001)(966005)(6512007)(6486002)(82960400001)(86362001)(186003)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lm3LDWWEqhThJ/k8BUsV0SZ9VXcbyyACtsjEfxauUFAmThb2H4yOAhtszsan?=
 =?us-ascii?Q?CUU5zJW1BJH2ZgwoOpEoMDyVsENYe06DKulZINDdExCIkpKCKYBkjhPGEOeK?=
 =?us-ascii?Q?Qp5MBZOvsRfU2Oj6FeGVJL0oy+u8dqnxo8yhkPYs4+tw28uxCRyrLC1NDiHs?=
 =?us-ascii?Q?0/THMVFI+Y9E2qixXbXGPeTrF90Fyx97Fpay6Sn/kMCiab5bJZRwugWyIcqX?=
 =?us-ascii?Q?DVnWFYsM/v3jPEvjErNztoYhY53qmvVMifADLz1v2u7QRhUotb+BhQlLkzOL?=
 =?us-ascii?Q?2EG8otGT9ejP5MkM90BLPmJAc759/aEqknZWlOoYMhoAhsoBERmQnDbkQUQt?=
 =?us-ascii?Q?I+sXEqacliyB5hMrM5wzHpzn2NAxzjxkUuwOSrfgzgOzVZwvZr4paN6xUPq9?=
 =?us-ascii?Q?jpcbd4SfQ2GVktyY1zZkzaX6Zs8+m0Wh7s3KLMxZ3zyIPFqYodOKN743h+O1?=
 =?us-ascii?Q?rlkvA6wgvcWIKPVtwuxhOkEtF83ilIpKHGVq5rgKS47xttxFD0BbN0kPlB8+?=
 =?us-ascii?Q?7lRePw/rHWjyAykVN3KaH3T8PP0pSqM8vT8vgZVqw9sy2ONShwAm+O2v4+5t?=
 =?us-ascii?Q?5BlIKR/AZDBotvQjN718JiEBsxR5yQzBOBrcy9TDCrhNlz7xL4D53zqvIb1L?=
 =?us-ascii?Q?bhPmIqRsfnbU1gZaZPnTb2N+2KNvLIFmUADWrK47dVE/0YnM/5f62G0XQSJk?=
 =?us-ascii?Q?ZO080WNJhwjp7Y+Ef3OjvCpXtXGO0TyTHTciZkQbGfIRfceBTaTcAED6mM6A?=
 =?us-ascii?Q?+j+rTOKds52o6NQJ5ve0Tynum66pj39FoOIkiK7uBPzWg9zObWbfQfuLXBym?=
 =?us-ascii?Q?ua8RklZ8Xbe1alzQZiIpGZVBaxof06zZ8NLFPUw0OR/NB3YUFFiRHaLto7av?=
 =?us-ascii?Q?g0W2FlXatTKNZQ4m+jgv5lcfJWF0Fj5SobZnZvGLRa0UfD0J60gT0XEc/6TE?=
 =?us-ascii?Q?ixBxiOhHnMo+/2u8rZao+AnT8pMDa81ww1aHOoFQzrGZn8oz7HPDR9GlPVWG?=
 =?us-ascii?Q?jqwlt5DQMQp99KdK7CDKBSXTZNpWGEGuNRQjKIEyFaX8GVwCI62vzZY+gMqv?=
 =?us-ascii?Q?wE2r5v5zs6yWRhIFVCWRFHXZzlgQyL1CzlWapPT3RrjPM5LMiTHOuXl4wE15?=
 =?us-ascii?Q?GoIzji63EMtPKX727VbfjtFD8X7PqZmJVAw06iIzSDt5x5W3ehc2B5IY6j68?=
 =?us-ascii?Q?rYC+vOsZWOvDAWXOFITjkmYSjBp72+8sA2oR9/VSj5xBZa62ELUAn/HRnKxl?=
 =?us-ascii?Q?VB7f9yxElDny1WlO9Ji7YdcXwE787c6UQx7zkTo1UKN9zyASpTltMxgObGX3?=
 =?us-ascii?Q?fd7w1fN6HgmiV/yfEPijqkyTb30+HTmIoQh20+zL++eg1UZlCz2NGHvWaget?=
 =?us-ascii?Q?rOMuewN+rHPQzCH0pcsY5Kp2fPh45GLglfUPUIopoWO7RfCnOnra1Zi3ntZc?=
 =?us-ascii?Q?Oo1frQNX7xKgwhVF7Tfk7BQF8IclXzm7keAyyUjaeM+iILCTWow6kQ4X8J7t?=
 =?us-ascii?Q?2pe9u5TWmLiuO3Svf1AnFLjdiJbDT0lwYp8HhbfnRjX9rBmNOgT4E1xab0JK?=
 =?us-ascii?Q?WBsqNGE209QaWnxl2d+sbY8QSDYCLYacj+J9QB54?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cd06c8-5c6c-4116-b12c-08daafbf7bf5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 21:43:38.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtzFIxReseQ7EHnI/a6y6VDnccnnaHuskkvdKBR3qoPMt0pH/LMnJuPpOZ8rLk4VZ3Y6t6kvPxPOzxe6Xc75tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6936
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 07:28:40AM -0400, Steven Rostedt wrote:
> On Mon, 10 Oct 2022 15:41:22 -0700
> ira.weiny@intel.com wrote:
> 
> > new file mode 100644
> > index 000000000000..318ba5fe046e
> > --- /dev/null
> > +++ b/include/trace/events/cxl.h
> > @@ -0,0 +1,130 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM cxl
> > +
> > +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> > +#define _CXL_TRACE_EVENTS_H
> > +
> > +#include <asm-generic/unaligned.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(overflow,
> 
> Please do not use generic names for grouped events. As most tooling can
> use the name and not associate it with the group, it makes it ambiguous
> for what event it wants to enable.
> 
> That is, call it "cxl_overflow" and not "overflow".

I did not realize that.[1]

[1] https://lore.kernel.org/linux-cxl/67c4e0da-87e3-44a1-1902-220dbc312700@intel.com/

> 
> > +
> > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > +		 struct cxl_get_event_payload *payload),
> > +
> > +	TP_ARGS(dev_name, log, payload),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(dev_name, dev_name)
> > +		__field(int, log)
> > +		__field(u64, first)
> > +		__field(u64, last)
> > +		__field(u16, count)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(dev_name, dev_name);
> > +		__entry->log = log;
> > +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> > +		__entry->first = le64_to_cpu(payload->first_overflow_timestamp);
> > +		__entry->last = le64_to_cpu(payload->last_overflow_timestamp);
> > +	),
> > +
> > +	TP_printk("%s: EVENT LOG OVERFLOW log=%s : %u records from %llu to %llu",
> > +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
> > +		__entry->count, __entry->first, __entry->last)
> > +
> > +);
> > +
> 
> > +TRACE_EVENT(generic_event,
> 
> Same here. It's a "cxl_generic_event" not a "generic_event" that will
> clash with any other subsystem that would (but shouldn't) use the same
> name.

Sure I'll change it back.

Thanks for setting us straight,
Ira

> 
> -- Steve
> 
> > +
> > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > +		 struct cxl_event_record_raw *rec),
> > +
> > +	TP_ARGS(dev_name, log, rec),
> > +
> > +	TP_STRUCT__entry(
> > +		CXL_EVT_TP_entry
> > +		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> > +		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
> > +	),
> > +
> > +	CXL_EVT_TP_printk("%s",
> > +		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> > +);
> > +
> > +#endif /* _CXL_TRACE_EVENTS_H */
> > 
