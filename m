Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838AC6CBCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjC1KzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjC1Kyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:54:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823CF6A40;
        Tue, 28 Mar 2023 03:54:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pm64g18Xtz6J7dg;
        Tue, 28 Mar 2023 18:54:11 +0800 (CST)
Received: from localhost (10.48.153.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Mar
 2023 11:54:45 +0100
Date:   Tue, 28 Mar 2023 11:54:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/5] perf: Allow a PMU to have a parent.
Message-ID: <20230328115444.000036ea@Huawei.com>
In-Reply-To: <f8123e7c-36a6-a302-1101-e778622dc997@linux.intel.com>
References: <20230324171313.18448-1-Jonathan.Cameron@huawei.com>
        <20230324171313.18448-3-Jonathan.Cameron@huawei.com>
        <f8123e7c-36a6-a302-1101-e778622dc997@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Mon, 27 Mar 2023 13:04:08 -0400
"Liang, Kan" <kan.liang@linux.intel.com> wrote:

> On 2023-03-24 1:13 p.m., Jonathan Cameron wrote:
> > Some PMUs have well defined parents such as PCI devices.
> > As the device_initialize() and device_add() are all within
> > pmu_dev_alloc() which is called from perf_pmu_register()
> > there is no opportunity to set the parent from within a driver.
> > 
> > Add a struct device *parent field to struct pmu and use that
> > to set the parent.  
> 
> Why we want a PMU parent? Maybe I missed it. I don't see that the parent
> is used anywhere.

This allows you to identify the association between PMU and the hardware related
device that is providing it by looking at the directory structure in sysfs rather
than putting them directly under /sys/devices.

ls -l /sys/bus/event_sources/devices/

... armv8_pmuv3_0 -> ../../../devices/arm8_pmuv3_0
... breakpoint -> ../../../devices/breakpoint
... cpmu0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/cpmu0/cpmu0
etc

(the first cpmu0 is the parent registered as a child of the PCI EP and used for
 driver binding).  So it's of use to userspace rather than in the kernel driver
itself.

Note that almost nothing is normally in the top level /sys/devices other than
event_sources - because nearly all other struct device instances created by
subsystems have parents assigned.

On my system

ls /sys/devices

armv8_pmuv3_0	LNXSYSTEM:00	pci0000:0c	pnp0		system		uprobe
breakpoint	pci0000:00	platform	software	tracepoint	virtual

+CC Greg KH for input on whether / why this make sense.

Thanks,

Jonathan

> 
> Thanks,
> Kan
> 
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/perf_event.h | 1 +
> >  kernel/events/core.c       | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index d5628a7b5eaa..b99db1eda72c 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -303,6 +303,7 @@ struct pmu {
> >  
> >  	struct module			*module;
> >  	struct device			*dev;
> > +	struct device			*parent;
> >  	const struct attribute_group	**attr_groups;
> >  	const struct attribute_group	**attr_update;
> >  	const char			*name;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index fb3e436bcd4a..a84c282221f2 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11367,6 +11367,7 @@ static int pmu_dev_alloc(struct pmu *pmu)
> >  
> >  	dev_set_drvdata(pmu->dev, pmu);
> >  	pmu->dev->bus = &pmu_bus;
> > +	pmu->dev->parent = pmu->parent;
> >  	pmu->dev->release = pmu_dev_release;
> >  
> >  	ret = dev_set_name(pmu->dev, "%s", pmu->name);  
> 

