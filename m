Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3E5BEA82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiITPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiITPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:49:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA869F59;
        Tue, 20 Sep 2022 08:49:08 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MX5XD4x8Bz67KvJ;
        Tue, 20 Sep 2022 23:47:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 17:49:06 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 16:49:05 +0100
Date:   Tue, 20 Sep 2022 16:49:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <20220920164904.00001be8@huawei.com>
In-Reply-To: <Yxun42yjtZREEeRv@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-2-ira.weiny@intel.com>
        <20220824165058.00007d4f@huawei.com>
        <Yxgd51zdrk9pEXE6@iweiny-mobl>
        <20220908135240.00001217@huawei.com>
        <Yxun42yjtZREEeRv@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Fri, 9 Sep 2022 13:53:55 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Sep 08, 2022 at 01:52:40PM +0100, Jonathan Cameron wrote:
> >   
> 
> [snip]
> 
> > > > > diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
> > > > > new file mode 100644
> > > > > index 000000000000..f4baeae66cf3
> > > > > --- /dev/null
> > > > > +++ b/include/trace/events/cxl-events.h
> > > > > @@ -0,0 +1,127 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +#undef TRACE_SYSTEM
> > > > > +#define TRACE_SYSTEM cxl_events
> > > > > +
> > > > > +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> > > > > +#define _CXL_TRACE_EVENTS_H
> > > > > +
> > > > > +#include <linux/tracepoint.h>
> > > > > +
> > > > > +#define EVENT_LOGS					\
> > > > > +	EM(CXL_EVENT_TYPE_INFO,		"Info")		\
> > > > > +	EM(CXL_EVENT_TYPE_WARN,		"Warning")	\
> > > > > +	EM(CXL_EVENT_TYPE_FAIL,		"Failure")	\
> > > > > +	EM(CXL_EVENT_TYPE_FATAL,	"Fatal")	\
> > > > > +	EMe(CXL_EVENT_TYPE_MAX,		"<undefined>")    
> > > > 
> > > > Hmm. 4 is defined in CXL 3.0, but I'd assume we won't use tracepoints for
> > > > dynamic capacity events so I guess it doesn't matter.    
> > > 
> > > I'm not sure why you would say that.  I anticipate some user space daemon
> > > requiring these events to set things up.  
> > 
> > Certainly a possible solution. I'd kind of expect a more hand shake based approach
> > than a tracepoint.  Guess we'll see :)  
> 
> Yea I think we should wait an see.
> 
> > 
> >   
> > > >     
> > > > > +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> > > > > +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> > > > > +)
> > > > > +
> > > > > +TRACE_EVENT(cxl_event,
> > > > > +
> > > > > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > > > > +		 struct cxl_event_record_raw *rec),
> > > > > +
> > > > > +	TP_ARGS(dev_name, log, rec),
> > > > > +
> > > > > +	TP_STRUCT__entry(
> > > > > +		__string(dev_name, dev_name)
> > > > > +		__field(int, log)
> > > > > +		__array(u8, id, UUID_SIZE)
> > > > > +		__field(u32, flags)
> > > > > +		__field(u16, handle)
> > > > > +		__field(u16, related_handle)
> > > > > +		__field(u64, timestamp)
> > > > > +		__array(u8, data, EVENT_RECORD_DATA_LENGTH)
> > > > > +		__field(u8, length)    
> > > > 
> > > > Do we want the maintenance operation class added in Table 8-42 from CXL 3.0?
> > > > (only noticed because I happen to have that spec revision open rather than 2.0).    
> > > 
> > > Yes done.
> > > 
> > > There is some discussion with Dan regarding not decoding anything and letting
> > > user space take care of it all.  I think this shows a valid reason Dan
> > > suggested this.  
> > 
> > I like being able to print tracepoints with out userspace tools.
> > This also enforces structure and stability of interface which I like.  
> 
> I tend to agree with you.
> 
> > 
> > Maybe a raw tracepoint or variable length trailing buffer to pass
> > on what we don't understand?  
> 
> I've already realized that we need to print all reserved fields for this
> reason.  If there is something the kernel does not understand user space can
> just figure it out on it's own.
> 
> Sound reasonable?

Hmm. Printing reserved fields would be unusual.  Not sure what is done for similar
cases elsewhere, CPER records etc...

We could just print a raw array of the whole event as well as decode version, but
that means logging most of the fields twice...

Not nice either.

I'm a bit inclined to say we should maybe just ignore stuff we don't know about or
is there a version number we can use to decide between decoded vs decoded as much as
possible + raw log?

Jonathan

> 
> Ira
> 
> > 
> > Jonathan
> > 
> >   

