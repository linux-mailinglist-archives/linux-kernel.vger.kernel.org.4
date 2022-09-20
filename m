Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942945BEFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiITWKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiITWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:10:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B577565;
        Tue, 20 Sep 2022 15:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663711835; x=1695247835;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UBQeKs5cl99jKPWb5OBAHbwxpiulAGlxTmlsJarxYXk=;
  b=jeQjeeU7yRfMPPcsiW6DR0M+ZwYaz/dlUFvy8TLMZSSkCyXPnCUorIxn
   zf0+/0W8LG+a6WK4GZnGF13F5Iu+1DNYC+jzO2HGMn8+GPi6kRpMgkNuo
   jJGFzBLhLMpkLgoD2qsjSz07RhghH6UH2S348XxbbNbNPPr+xxkUdQ6OA
   9t0I/FWXZM+KlpDw/wB9/3P3icg19+mAG/nbUodvFe/JPFv/3KsMiXnvJ
   1Yv22+J+/hWIJhFuBzxlzw/SHHMRIllNb6E2F6OIK4wnNfZ7VyqVp2qE7
   FKo3z5gNBrmmA4HX3af02OzS+0NugoUhUEHaXuGH4tLmmwM1ClpT0dHfU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="326140201"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="326140201"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="681489194"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2022 15:10:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:10:34 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:10:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 15:10:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 15:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb2caZMNoNiyyOXN3dDgFZ1HmyLHVQXIeoVJ3gW2IxoGACF4uMw33+50R56HNY4X8LCXFtizqeWbhmPRNwXTdxiwPmbeaLi1G2uHrygxIP6QB+Aj8uLRQoSnRAVUICuNi9r0xpGFknkTrPaPPsHzZOsabZ/HRsaHXi9bQfsRfbCHMPCf5Mavrj2IQXEesUBmVyOVm7wZW4CEqImEOjyAl7JTSIj6f/QFyjNZxoOtYkqP7Kv7tkO8rwxIoB0U5rQhfFjZTWDrZkXP4yMTaHc3jOHVB3JVWji3wDC3VJXPL/XeZplwFl+grcYZvOz0SJvMytJnWcsrcQkYjSvYoQ9gOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2VWk0z+1AcwdE83duPFN486CE8B7Fgwwa7zEabzRmE=;
 b=JQCC4mA1DlJQIUaYHwP8cjJdTPRvDI0MbVbpYYnVP0WwZ90QQWf/EG/LGsM2MHKETkIZYdkThRC7LmEEeLqfD9UtP1/R/QLkiEPTMqCSkZ/kvv35mHZqqWD9DbZqxAn4nwR/bXDQlNEkj5t4WR6BsHL8rBuEdaeF5aJ2z5YVgxJJJ7qRIJYFkZcts9OjVjdST6t2jJhaSco3Vci1XHNJlNBU4gb7x1EYA8OtwAjAEmS3gVEBAWJtcCDwZpvhr19gzpaQRche8B4nEEiH/14CqTTZoStdHUBNpzOcaieJfMu+1kXTa3es3ftwrFd+QTLXGfqxuQ3Q77nbk/VX15aGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.17; Tue, 20 Sep 2022 22:10:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 22:10:31 +0000
Date:   Tue, 20 Sep 2022 15:10:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <Yyo6Un8YmRM7aOLz@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-2-ira.weiny@intel.com>
 <20220824165058.00007d4f@huawei.com>
 <Yxgd51zdrk9pEXE6@iweiny-mobl>
 <20220908135240.00001217@huawei.com>
 <Yxun42yjtZREEeRv@iweiny-desk3>
 <20220920164904.00001be8@huawei.com>
 <afdac388-061e-a403-3b9e-1273cee98509@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afdac388-061e-a403-3b9e-1273cee98509@intel.com>
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0fffa6-a958-4d43-9ff3-08da9b54ee8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAs/O1TBGEYl9od2O2v0LXKWckI01kAdq2wrDp+9EfjDjm50oPvtkHU+gfE1T/C8mwzTYNQRF9NAsHoPH3tu3O36jmgsKS8Xw5Xb8kqTgP+HmpbHhgeXvto24Faa2WwiH1RhhAFA0F+frD1pL3PLaIfzFtQJH+gFz2QOZJXT1eXyIc7thXeQGSgAjEdR5C4wbGDovYBSzpzm+Raz2kB0XUvEUxrT3gXwehD2vCA5DJ4DCqxg2DeTS4Ib4r4n8vQPk9MK7rRi3FOyJdsc9jwXXI5T/qfrfioiu9Eg9ObHntmMULAAjda0PXv94wEuODxlKznVHpf9HKYvf13GZhm2kUdR3/XV9TAXMjV68O6VXAQtKIWhfF9546EVO+R1iXD+kUJtGwIn66MMs/XmTE8d+0DlNsI/L0D9CeFM4aw0AuW3ou/23qZuhv4rTgMRvX67fpMb+ck8mO6MCvgWUB1xZJ4Qb9WgoDyXGEnEYCCeehTwKS9iGHZg+iOPiuHz/wqxnh1LUPm8jtLSlS1KvqOmX4jlY4zKpYMXQmV1ZOGbWQq0R6L0ymb8GsZiQpRwn9omQZ2yp4vWASUufMHZTsMbsU2WH2UZwV4bibTJKWeUHoJNxBmuWdqCHN4M7wcAuvK5RHok5MQ+8q66GD/jjtse2br5jRUN7nCQ7oyRHLcX6OPLqF2D4NLdcbDZLOW0u2JPZLpVcDuu6vhiEgoromQY4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(44832011)(5660300002)(41300700001)(66946007)(8936002)(38100700002)(2906002)(86362001)(82960400001)(33716001)(6862004)(66476007)(66556008)(4326008)(8676002)(6636002)(83380400001)(53546011)(478600001)(26005)(316002)(54906003)(6506007)(6666004)(9686003)(6512007)(6486002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M54VNB1HjiwtVBxIdz6YN8p1gqeMWervIxinGLmj/ZI3M7eueWYMyj8+d7L7?=
 =?us-ascii?Q?l8+EzNf8aSKtHnK/h6w/PHbU2GqShh2mCYkpT183vMq0ipo854dNrfaTQzDU?=
 =?us-ascii?Q?iJBnfK3y8qeRAzOOWV6Qj9TB5WN2BGEPCX2MFFEPtqhtRI+Me6fujHL0Dxmo?=
 =?us-ascii?Q?R8nLL0bZ9XRSiOZGMIWLkBm7A8y+Tu9BULSkSfDVBloxUR51jmd8m1R6Umeo?=
 =?us-ascii?Q?Ld6l9P/Od1uzpac5Fa6BND8ecdZPNUKiHayuwcbxj6hZvqq1Pyfk0/m0DZQX?=
 =?us-ascii?Q?cDcKenZSOdMKmxsvDPncOSry3X79Ff5A5RceBj/PqYEpU0GP8+DyRa9y2mDi?=
 =?us-ascii?Q?uTtkcYR18qSVfsa/wp8fjbVcx/aG2sIPOsy2/AiUk181s6pSo7GxTdDzsY/Y?=
 =?us-ascii?Q?LqP10IeAiS/YvCyddGbBfXzHOLBUC1gQKi3I3tPyaSMoLuGZaMIun5NQVaZn?=
 =?us-ascii?Q?MMujzeGxMkEOu6W3DC/dnZ2HUNI3rlEcdx7l7qBU0HEgo3jDJwQmmifAo5FZ?=
 =?us-ascii?Q?4oWph2DnFoYMjuYGVGOnzCVZ6YIwEOAncr7SHk3i1jRqRHea259KUzHGnc+J?=
 =?us-ascii?Q?fRqqFRdQ41qxjf9Xq33/IPJaNfu0y8XX8m3zwO0JaSD/fbI5yqGESK4qtfbH?=
 =?us-ascii?Q?oLJ4NWblxseUFMnslI5WgIv6PbHmt5oIrB3zStXMrB8PC4YpfwE8gyfwyU1U?=
 =?us-ascii?Q?E1TN9y85jCpCClyIdyNJiESiT4+nqIhO8JsHLBgQXr/SMOn3DR70CsTI+BTn?=
 =?us-ascii?Q?f/hGZDL3zLRQDUtKq/Ue/GNn46jXVgRzI8EbuoVeqaQ1j3gmqjV5uNfNgaoN?=
 =?us-ascii?Q?UeEob/NElZFXOmKXFwBV2quyNVg9P5Vo7W/g4zyDSg3uQg4cRxC4/r1V6aWI?=
 =?us-ascii?Q?+5wYZz9vpdQZ2jhTqJqsIvAVw934jKXJf42uYKSnXYmFxK9IKO+m+6vjHjza?=
 =?us-ascii?Q?C+4VHPm0lXrpqh0FNVzaPuKWNo2sYQiBtr/j3k9KZGSipgD8Z/fN9yfi5qrV?=
 =?us-ascii?Q?Urc4gz1PnXZycrMoqmW7azxplzYnlIWWFmY3NkuRORtZJdou8atHqb9uabiC?=
 =?us-ascii?Q?rM7L0+LbkvkG2PocCzTOQhYVWSXu0bsuPBtUWwz72iHN8rIFxN55EHGPwGik?=
 =?us-ascii?Q?g2V6MLEeze3doEnhGMuEj5SOteIUMQS0pMPF4O98ZUvrTOtKXLdjWPBH+tOR?=
 =?us-ascii?Q?IJshvL1dUiQloUlg8agF/ugQgwnxz6bS7PGMV1uixfYQhVrBfJoUcHaBc4nn?=
 =?us-ascii?Q?GTjGFuHjb+XNFXfYvqxda4716u0MxPAwGwBNvGm7/TTdOkHIFeOI5N9DyYcY?=
 =?us-ascii?Q?plQMNMiLo83aBQ3j1qBesJ1pkzTFlJk/SAXxYakUcCuXEgd49GZlinq4RR2c?=
 =?us-ascii?Q?wwgvkSzLStIhY4AJH7F5E9dzJ0/j+iGizq5HXvmVe5nHumavag1Cei8BUexs?=
 =?us-ascii?Q?eni9nT8PE8FqpzoYNuSVERQkR9x7BETorUfzzIEb9+AtYcLB5SPNIsCgPScl?=
 =?us-ascii?Q?z0XQ61ImpxaJl4w6Ua6bEV1/yj+FP0gZxTsr8Nf2tMnQnU+q6U5HPZJg+AuN?=
 =?us-ascii?Q?j1jdPt/hD5+QEBdGCpIgrAioe6y7m8U4EAln8eBq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0fffa6-a958-4d43-9ff3-08da9b54ee8f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 22:10:30.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSR9CQNPdGQ0UlX31S+aSgyUjpibjoFFDi8qimXATtUnLaTQ+RDUePjq8nXLXzkaU0xPXDKvbwhwUOIejyH2VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 01:23:29PM -0700, Jiang, Dave wrote:
> 
> On 9/20/2022 8:49 AM, Jonathan Cameron wrote:
> > On Fri, 9 Sep 2022 13:53:55 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > On Thu, Sep 08, 2022 at 01:52:40PM +0100, Jonathan Cameron wrote:
> > > [snip]
> > > 
> > > > > > > diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..f4baeae66cf3
> > > > > > > --- /dev/null
> > > > > > > +++ b/include/trace/events/cxl-events.h
> > > > > > > @@ -0,0 +1,127 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > +#undef TRACE_SYSTEM
> > > > > > > +#define TRACE_SYSTEM cxl_events
> > > > > > > +
> > > > > > > +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> > > > > > > +#define _CXL_TRACE_EVENTS_H
> > > > > > > +
> > > > > > > +#include <linux/tracepoint.h>
> > > > > > > +
> > > > > > > +#define EVENT_LOGS					\
> > > > > > > +	EM(CXL_EVENT_TYPE_INFO,		"Info")		\
> > > > > > > +	EM(CXL_EVENT_TYPE_WARN,		"Warning")	\
> > > > > > > +	EM(CXL_EVENT_TYPE_FAIL,		"Failure")	\
> > > > > > > +	EM(CXL_EVENT_TYPE_FATAL,	"Fatal")	\
> > > > > > > +	EMe(CXL_EVENT_TYPE_MAX,		"<undefined>")
> > > > > > Hmm. 4 is defined in CXL 3.0, but I'd assume we won't use tracepoints for
> > > > > > dynamic capacity events so I guess it doesn't matter.
> > > > > I'm not sure why you would say that.  I anticipate some user space daemon
> > > > > requiring these events to set things up.
> > > > Certainly a possible solution. I'd kind of expect a more hand shake based approach
> > > > than a tracepoint.  Guess we'll see :)
> > > Yea I think we should wait an see.
> > > 
> > > > > > > +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> > > > > > > +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> > > > > > > +)
> > > > > > > +
> > > > > > > +TRACE_EVENT(cxl_event,
> > > > > > > +
> > > > > > > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > > > > > > +		 struct cxl_event_record_raw *rec),
> > > > > > > +
> > > > > > > +	TP_ARGS(dev_name, log, rec),
> > > > > > > +
> > > > > > > +	TP_STRUCT__entry(
> > > > > > > +		__string(dev_name, dev_name)
> > > > > > > +		__field(int, log)
> > > > > > > +		__array(u8, id, UUID_SIZE)
> > > > > > > +		__field(u32, flags)
> > > > > > > +		__field(u16, handle)
> > > > > > > +		__field(u16, related_handle)
> > > > > > > +		__field(u64, timestamp)
> > > > > > > +		__array(u8, data, EVENT_RECORD_DATA_LENGTH)
> > > > > > > +		__field(u8, length)
> > > > > > Do we want the maintenance operation class added in Table 8-42 from CXL 3.0?
> > > > > > (only noticed because I happen to have that spec revision open rather than 2.0).
> > > > > Yes done.
> > > > > 
> > > > > There is some discussion with Dan regarding not decoding anything and letting
> > > > > user space take care of it all.  I think this shows a valid reason Dan
> > > > > suggested this.
> > > > I like being able to print tracepoints with out userspace tools.
> > > > This also enforces structure and stability of interface which I like.
> > > I tend to agree with you.
> > > 
> > > > Maybe a raw tracepoint or variable length trailing buffer to pass
> > > > on what we don't understand?
> > > I've already realized that we need to print all reserved fields for this
> > > reason.  If there is something the kernel does not understand user space can
> > > just figure it out on it's own.
> > > 
> > > Sound reasonable?
> > Hmm. Printing reserved fields would be unusual.  Not sure what is done for similar
> > cases elsewhere, CPER records etc...
> > 
> > We could just print a raw array of the whole event as well as decode version, but
> > that means logging most of the fields twice...
> > 
> > Not nice either.
> > 
> > I'm a bit inclined to say we should maybe just ignore stuff we don't know about or
> > is there a version number we can use to decide between decoded vs decoded as much as
> > possible + raw log?

I'm not a fan of loging the raw + decoded versions.

> 
> libtraceevent can pull the trace event data structure fields directly. So
> the raw data can be pulled directly from the kernel.

This raw data needs to be in a field though.  If the kernel does not save the
reserved fields in the TP_fast_assign() then the data won't be in a field to
access.

>
> And what gets printed
> to the trace buffer can be decoded data constructed from those fields by the
> kernel code. So with that you can have access both.
> 

Fast assigning the entire buffer + decoded versions will roughly double the
trace event size.

Thinking through this a bit more there is a sticking point.

The difficulty will be ensuring that any new field names are documented such
that when user space starts to look at them they can determine if that data
appears as a new field or as part of a reserved field.

For example if user space needs to access data in the reserved data now it can
simply decode it.  However, when that data becomes a field it no longer is part
of the reserved data.  So what user space would need to do is look for the
field first (ie know the field name) and then if it does not appear extract it
from the reserved data.

I'm now wondering if I've wasted my time decoding anything since the kernel
does not need to know anything about these fields.  Because the above scenario
means that user space may get ugly over time.

That said I don't think it will present any incompatibilities.  So perhaps we
are ok?

Ira
