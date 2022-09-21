Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7238B5C0487
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiIUQqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiIUQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:45:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944623B5;
        Wed, 21 Sep 2022 09:36:47 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MXkTD1jy5z682kB;
        Thu, 22 Sep 2022 00:32:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 18:36:44 +0200
Received: from localhost (10.81.200.69) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 17:36:43 +0100
Date:   Wed, 21 Sep 2022 17:36:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <20220921173642.000050ee@huawei.com>
In-Reply-To: <Yyo6Un8YmRM7aOLz@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-2-ira.weiny@intel.com>
        <20220824165058.00007d4f@huawei.com>
        <Yxgd51zdrk9pEXE6@iweiny-mobl>
        <20220908135240.00001217@huawei.com>
        <Yxun42yjtZREEeRv@iweiny-desk3>
        <20220920164904.00001be8@huawei.com>
        <afdac388-061e-a403-3b9e-1273cee98509@intel.com>
        <Yyo6Un8YmRM7aOLz@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.69]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 15:10:26 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Sep 20, 2022 at 01:23:29PM -0700, Jiang, Dave wrote:
> > 
> > On 9/20/2022 8:49 AM, Jonathan Cameron wrote:  
> > > On Fri, 9 Sep 2022 13:53:55 -0700
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >   
> > > > On Thu, Sep 08, 2022 at 01:52:40PM +0100, Jonathan Cameron wrote:
> > > > [snip]
> > > >   
> > > > > > > > diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..f4baeae66cf3
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/include/trace/events/cxl-events.h
> > > > > > > > @@ -0,0 +1,127 @@
> > > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > > +#undef TRACE_SYSTEM
> > > > > > > > +#define TRACE_SYSTEM cxl_events
> > > > > > > > +
> > > > > > > > +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> > > > > > > > +#define _CXL_TRACE_EVENTS_H
> > > > > > > > +
> > > > > > > > +#include <linux/tracepoint.h>
> > > > > > > > +
> > > > > > > > +#define EVENT_LOGS					\
> > > > > > > > +	EM(CXL_EVENT_TYPE_INFO,		"Info")		\
> > > > > > > > +	EM(CXL_EVENT_TYPE_WARN,		"Warning")	\
> > > > > > > > +	EM(CXL_EVENT_TYPE_FAIL,		"Failure")	\
> > > > > > > > +	EM(CXL_EVENT_TYPE_FATAL,	"Fatal")	\
> > > > > > > > +	EMe(CXL_EVENT_TYPE_MAX,		"<undefined>")  
> > > > > > > Hmm. 4 is defined in CXL 3.0, but I'd assume we won't use tracepoints for
> > > > > > > dynamic capacity events so I guess it doesn't matter.  
> > > > > > I'm not sure why you would say that.  I anticipate some user space daemon
> > > > > > requiring these events to set things up.  
> > > > > Certainly a possible solution. I'd kind of expect a more hand shake based approach
> > > > > than a tracepoint.  Guess we'll see :)  
> > > > Yea I think we should wait an see.
> > > >   
> > > > > > > > +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> > > > > > > > +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> > > > > > > > +)
> > > > > > > > +
> > > > > > > > +TRACE_EVENT(cxl_event,
> > > > > > > > +
> > > > > > > > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > > > > > > > +		 struct cxl_event_record_raw *rec),
> > > > > > > > +
> > > > > > > > +	TP_ARGS(dev_name, log, rec),
> > > > > > > > +
> > > > > > > > +	TP_STRUCT__entry(
> > > > > > > > +		__string(dev_name, dev_name)
> > > > > > > > +		__field(int, log)
> > > > > > > > +		__array(u8, id, UUID_SIZE)
> > > > > > > > +		__field(u32, flags)
> > > > > > > > +		__field(u16, handle)
> > > > > > > > +		__field(u16, related_handle)
> > > > > > > > +		__field(u64, timestamp)
> > > > > > > > +		__array(u8, data, EVENT_RECORD_DATA_LENGTH)
> > > > > > > > +		__field(u8, length)  
> > > > > > > Do we want the maintenance operation class added in Table 8-42 from CXL 3.0?
> > > > > > > (only noticed because I happen to have that spec revision open rather than 2.0).  
> > > > > > Yes done.
> > > > > > 
> > > > > > There is some discussion with Dan regarding not decoding anything and letting
> > > > > > user space take care of it all.  I think this shows a valid reason Dan
> > > > > > suggested this.  
> > > > > I like being able to print tracepoints with out userspace tools.
> > > > > This also enforces structure and stability of interface which I like.  
> > > > I tend to agree with you.
> > > >   
> > > > > Maybe a raw tracepoint or variable length trailing buffer to pass
> > > > > on what we don't understand?  
> > > > I've already realized that we need to print all reserved fields for this
> > > > reason.  If there is something the kernel does not understand user space can
> > > > just figure it out on it's own.
> > > > 
> > > > Sound reasonable?  
> > > Hmm. Printing reserved fields would be unusual.  Not sure what is done for similar
> > > cases elsewhere, CPER records etc...
> > > 
> > > We could just print a raw array of the whole event as well as decode version, but
> > > that means logging most of the fields twice...
> > > 
> > > Not nice either.
> > > 
> > > I'm a bit inclined to say we should maybe just ignore stuff we don't know about or
> > > is there a version number we can use to decide between decoded vs decoded as much as
> > > possible + raw log?  
> 
> I'm not a fan of loging the raw + decoded versions.
> 
> > 
> > libtraceevent can pull the trace event data structure fields directly. So
> > the raw data can be pulled directly from the kernel.  
> 
> This raw data needs to be in a field though.  If the kernel does not save the
> reserved fields in the TP_fast_assign() then the data won't be in a field to
> access.
> 
> >
> > And what gets printed
> > to the trace buffer can be decoded data constructed from those fields by the
> > kernel code. So with that you can have access both.
> >   
> 
> Fast assigning the entire buffer + decoded versions will roughly double the
> trace event size.
> 
> Thinking through this a bit more there is a sticking point.
> 
> The difficulty will be ensuring that any new field names are documented such
> that when user space starts to look at them they can determine if that data
> appears as a new field or as part of a reserved field.
> 
> For example if user space needs to access data in the reserved data now it can
> simply decode it.  However, when that data becomes a field it no longer is part
> of the reserved data.  So what user space would need to do is look for the
> field first (ie know the field name) and then if it does not appear extract it
> from the reserved data.
> 
> I'm now wondering if I've wasted my time decoding anything since the kernel
> does not need to know anything about these fields.  Because the above scenario
> means that user space may get ugly over time.
> 
> That said I don't think it will present any incompatibilities.  So perhaps we
> are ok?

I favor decoding current record in kernel and packing it appropriately.
If that means we don't provide some new data from a future version then such
is life - the kernel needs upgrading.  That information is unlikely to be
crucial - it's probably just more detail.

Jonathan

> 
> Ira

