Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB765BEB03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiITQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiITQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:20:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804316D9DE;
        Tue, 20 Sep 2022 09:17:52 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MX6B70Dssz67hlj;
        Wed, 21 Sep 2022 00:16:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 18:17:49 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 17:17:49 +0100
Date:   Tue, 20 Sep 2022 17:17:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 7/9] cxl/test: Add generic mock events
Message-ID: <20220920171748.00001260@huawei.com>
In-Reply-To: <YyN0qY5yaXwTwLDF@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-8-ira.weiny@intel.com>
        <20220825123119.00000705@huawei.com>
        <YyN0qY5yaXwTwLDF@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Thu, 15 Sep 2022 11:53:29 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Aug 25, 2022 at 12:31:19PM +0100, Jonathan Cameron wrote:
> > On Fri, 12 Aug 2022 22:32:41 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Facilitate testing basic Get/Clear Event functionality by creating
> > > multiple logs and generic events with made up UUID's.
> > > 
> > > Data is completely made up with data patterns which should be easy to
> > > spot in trace output.  
> > Hi Ira,
> > 
> > I'm tempted to hack the QEMU emulation for this in with appropriately
> > complex interface to inject all the record types...  
> 
> Every time I look at the QEMU code it makes my head spin.  :-(

You get used to it ;)`

> 
> I really thought about adding some support there.  And I think for irq's it may
> work better?  But after your talk today I did a quick search to see what it
> would take to do irqs in QEMU and got even more confused.  :-(

Copy an example - though we haven't upstreamed any yet...

Either...

https://gitlab.com/jic23/qemu/-/commit/958fec58582b5cc910d2da4e2b855e134bb2c0c3#3dfd54f69a5f2382ddf5a6c00a52546d8b57316e_0_169

Or the CPMU one. 

https://lore.kernel.org/all/20220831153336.16165-2-Jonathan.Cameron@huawei.com/
to setup then look for msix_notify in 

https://lore.kernel.org/all/20220831153336.16165-4-Jonathan.Cameron@huawei.com/

> 
> > Lots to do there though, so not sure where this fits in my priority list!  
> 
> I bet it is higher on mine!  ;-)

:)

> 
> >   
> > > 
> > > Test traces are easy to obtain with a small script such as this:
> > > 
> > > 	#!/bin/bash -x
> > > 
> > > 	devices=`find /sys/devices/platform -name cxl_mem*`
> > > 
> > > 	# Generate fake events if reset is passed in  
> > 
> > reset is rather unintuitive naming.
> > 
> > fill_event_queue maybe or something more in that direction?  
> 
> Fair enough...  Naming is hard and I'm one of the worst.
> 
> I've changed to
> 
> <sysfs>/.../event_fill_queue
> <sysfs>/.../event_trigger
> 
> Thoughts?

Works for me.

..

J
