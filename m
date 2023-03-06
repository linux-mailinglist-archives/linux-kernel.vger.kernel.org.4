Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1236ABC95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCFK2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCFK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:28:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C510027992;
        Mon,  6 Mar 2023 02:27:31 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PVZSv395tz6J9jy;
        Mon,  6 Mar 2023 18:24:47 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 6 Mar
 2023 10:27:23 +0000
Date:   Mon, 6 Mar 2023 10:27:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: perf: Minimal introduction the the CXL PMU
 device and driver.
Message-ID: <20230306102722.00005ead@huawei.com>
In-Reply-To: <4dabd301-32d7-968e-e048-8135b072a7b5@intel.com>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
        <20230303175022.10806-5-Jonathan.Cameron@huawei.com>
        <4dabd301-32d7-968e-e048-8135b072a7b5@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Fri, 3 Mar 2023 11:34:37 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 3/3/23 10:50 AM, Jonathan Cameron wrote:
> > Very basic introduction to the device and the current driver support
> > provided. I expect to expand on this in future versions of this patch
> > set.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> > 
> > --
> > v1:
> > - Add docs for how to use a Vendor Defined Counter.
> > RFC:
> > - I'll post separately about this shortly, but it seems very odd
> >    to me that there is no way to assign a parent to an event_sources
> >    device.  As a result we get the messy approach of playing match
> >    the name to figure out what the CPMU instance is connected to.  
> 
> Would it be too awkward to encode the parent name into the cpmu name?

We could, though it gets messy fast as we have multiple instances per
CXL component - right now I'm only registering them for the PCI EPs but
we also need to deal with all the other places they could be.
We can also expose extra information via additional attributes, but where
I've seen that done in the past it's a topology description (i.e. socket X,
die Y) and our topology isn't stable.

Even if we do I'd like to fix the issue with parents for event_sources
and once that's done I'm not sure we need to worry so much about how
to do the reverse lookup.

Input from perf / event_sources folk on how they would like to do
the association needed!

Jonathan


> 
> > ---
> >   Documentation/admin-guide/perf/cxl.rst   | 65 ++++++++++++++++++++++++
> >   Documentation/admin-guide/perf/index.rst |  1 +
> >   2 files changed, 66 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
> > new file mode 100644
> > index 000000000000..46235dff4b21
> > --- /dev/null
> > +++ b/Documentation/admin-guide/perf/cxl.rst
> > @@ -0,0 +1,65 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +======================================
> > +CXL Performance Monitoring Unit (CPMU)
> > +======================================
> > +
> > +The CXL rev 3.0 specification provides a definition of CXL Performance
> > +Monitoring Unit in section 13.2: Performance Monitoring.
> > +
> > +CXL components (e.g. Root Port, Switch Upstream Port, End Point) may have
> > +any number of CPMU instances. CPMU capabilities are fully discoverable from
> > +the devices. The specification provides event definitions for all CXL protocol
> > +message types and a set of additional events for things commonly counted on
> > +CXL devices (e.g. DRAM events).
> > +
> > +CPMU driver
> > +===========
> > +
> > +The CPMU driver register a perf PMU with the name cpmu<id> on the CXL bus.
> > +
> > +    /sys/bus/cxl/device/cpmu<id>
> > +
> > +The associated PMU is registered as
> > +
> > +   /sys/bus/event_sources/devices/cpmu<id>
> > +
> > +In common with other CXL bus devices, the id has no specific meaning and the
> > +relationship to specific CXL device should be established via the device parent
> > +of the device on the CXL bus.
> > +
> > +PMU driver provides description of available events and filter options in sysfs.
> > +
> > +The "format" directory describes all formats of the config (event vendor id,
> > +group id and mask) config1 (threshold, filter enables) and config2 (filter
> > +parameters) fields of the perf_event_attr structure.  The "events" directory
> > +describes all documented events show in perf list.
> > +
> > +The events shown in perf list are the most fine grained events with a single
> > +bit of the event mask set. More general events may be enable by setting
> > +multiple mask bits in config. For example, all Device to Host Read Requests
> > +may be captured on a single counter by setting the bits for all of
> > +
> > +* d2h_req_rdcurr
> > +* d2h_req_rdown
> > +* d2h_req_rdshared
> > +* d2h_req_rdany
> > +* d2h_req_rdownnodata
> > +
> > +Example of usage::
> > +
> > +  $#perf list
> > +  cpmu0/clock_ticks/                                 [Kernel PMU event]
> > +  cpmu0/d2h_req_itomwr/                              [Kernel PMU event]
> > +  cpmu0/d2h_req_rdany/                               [Kernel PMU event]
> > +  cpmu0/d2h_req_rdcurr/                              [Kernel PMU event]
> > +  -----------------------------------------------------------
> > +
> > +  $# perf stat -e cpmu0/clock_ticks/ -e cpmu0/d2h_req_itowrm/
> > +
> > +Vendor specific events may also be available and if so can be used via
> > +
> > +  $# perf stat -e cpmu0/vid=VID,gid=GID,mask=MASK/
> > +
> > +The driver does not support sampling. So "perf record" and attaching to
> > +a task are unsupported.
> > diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> > index 9de64a40adab..f60be04e4e33 100644
> > --- a/Documentation/admin-guide/perf/index.rst
> > +++ b/Documentation/admin-guide/perf/index.rst
> > @@ -21,3 +21,4 @@ Performance monitor support
> >      alibaba_pmu
> >      nvidia-pmu
> >      meson-ddr-pmu
> > +   cxl  

