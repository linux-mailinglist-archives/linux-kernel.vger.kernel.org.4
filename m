Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024756D9D99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbjDFQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDFQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:34:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6499766;
        Thu,  6 Apr 2023 09:33:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Psn9T5WxSz67MmR;
        Fri,  7 Apr 2023 00:33:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 17:33:50 +0100
Date:   Thu, 6 Apr 2023 17:33:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 5/5] docs: perf: Minimal introduction the the CXL PMU
 device and driver
Message-ID: <20230406173349.00007503@Huawei.com>
In-Reply-To: <642ca39865e8b_21a8294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
        <20230330164556.31533-6-Jonathan.Cameron@huawei.com>
        <642ca39865e8b_21a8294d9@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
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
> 
> So I went to go add some text about how to identify PMUs in a persistent
> manner from one boot to the next. For CXL memdevs this is done by the
> 'serial' attribute which is always stable regardless of the device init
> order. That's harder to get to from the pmu device because it may be
> associated with a device that does not have a memdev.
> 
> I think it's also going to be frustrating for userspace to see
> randomized pmu ids across devices since that probing will happen in
> parallel. So how about:

Solving this in general for perf PMU drivers was what the parent device thing
was about.  There is an argument that enabling any other path to get to
this association is both unnecessary and just possibly unwise.

The nice advantage of just using an IDA and relying on parentage for the
association was that I could avoid naming questions for all the other
places these might turn in a CXL topology. The Lazy / efficient option ;)

You can now see exactly which PCI device a given instance is associated with.
Custom ABI is going to be harder for anyone to use than that.

I suppose we can potentially enable both paths - but it's not quite
as straight forwards as you suggest.

> 
> 1/ Add serial as an attribute for each PMU to export

Where does it come from? We only have one source of serial number per device.
That's no where near enough to work out where a PMU is. 

> 2/ Change the device name format to be "pmuX.Y" where X can just reuse

Could use something a little more detailed cxl bus, but the one registered and use
to address this in bus/event_sources needs to be cxl specific so a cxl_ prefix
is needed I think

Given we need to namespace what the ids refer to, I'm currently going with
pmu_memX.Y pmu_dspX.Y.Z pmu_uspX.Y
on the cxl bus and
cxl_pmu_memX.Y cxl_pmu_dspX.Y.Z cxl_pmu_uspX.Y on even sources bus.
(Z needed because dsp index from 0 for each usp)
We can figure out what to do about other CXL EPs later and for now at least
there is no way to hand a CPMU instance off a host bridge (nothing in CEDT
to tell you where to find it).

I've had a fun day hacking PMUs onto the other emulated CXL devices to test
this. 
There is a can of worms I'll avoid for this series by just sticking to type3
device PMUs for now.

  I have no idea yet how we handle the interrupts safely for ports as those
  interrupts are in control the pcie port driver not the CXL dport one.
  At somepoint I'll send out an RFC about that if no one gets to it before
  me.  For now I've hacked portdrv to always allocate max vectors and am ignoring the
  lovely back traces due to thing getting torn down in the wrong order on shutdown.
  For upstream ports I've hacked portdrv to pretend it knows there is something to handle.
  As a starting point I think we'll need to teach portdrv enough about CXL
  to be able to tell if it should provide interrupt services..

Hence I'll keep the code to register the other PMUs for a future patch set
and just make sure the code is structured to enable that in this series.


> the memdev id for endpoints and be another value for switches, and Y is
> guaranteed to be 0-based and in hardware discovery order.

Also need to change registration order as PMUs were registered before the
memdev, but that's easy enough to do.

> 
> ...with that, someone can write a udev script that can persistently
> identify PMU[Y] on device[serial] each boot.

> 
> That also cleans up a /sys/bus/cxl/devices listing to make it clear
> which pmu instances belong together.
>  
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
> 
> Ah here's the examples I was looking for in the last patch, nice.
> 
> > +
> > +Vendor specific events may also be available and if so can be used via
> > +
> > +  $# perf stat -e cpmu0/vid=VID,gid=GID,mask=MASK/
> > +
> > +The driver does not support sampling. So "perf record" and attaching to
> > +a task are unsupported.  
> 
> Is this a common restriction for CPU-external pmus, or do you see
> sampling support required to get this upstream?

It's a common restriction. Whilst we could potentially implement sampling
based on the presence of a suitable clock_ticks event it don't see it
as a requirement initially.

Jonathan


