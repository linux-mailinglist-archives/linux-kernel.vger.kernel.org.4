Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C6C6072E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJUIuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiJUIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:50:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08212A8B;
        Fri, 21 Oct 2022 01:49:54 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtymV0Nd6z6HJPl;
        Fri, 21 Oct 2022 16:48:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:49:35 +0200
Received: from localhost (10.81.215.159) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 09:49:34 +0100
Date:   Fri, 21 Oct 2022 09:49:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221021094931.0000795f@huawei.com>
In-Reply-To: <Y1Idsv0Nuu+V9aMj@iweiny-desk3>
References: <20221018030010.20913-1-dave@stgolabs.net>
        <20221018030010.20913-2-dave@stgolabs.net>
        <20221018103619.00004c39@huawei.com>
        <20221018115227.00002a4c@huawei.com>
        <20221020223125.hyrfpt2noiicisxa@offworld>
        <Y1Idsv0Nuu+V9aMj@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.215.159]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Thu, 20 Oct 2022 21:18:58 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Oct 20, 2022 at 03:31:25PM -0700, Davidlohr Bueso wrote:
> > On Tue, 18 Oct 2022, Jonathan Cameron wrote:
> >   
> > > Reality is that it is cleaner to more or less ignore the infrastructure
> > > proposed in this patch.
> > > 
> > > 1. Query how many CPMU devices there are. Whilst there stash the maximim
> > >   cpmu vector number in the cxlds.
> > > 2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
> > > 3. Carry on as before.
> > > 
> > > Thus destroying the point of this infrastructure for that usecase at least
> > > and leaving an extra bit of state in the cxl_dev_state that is just
> > > to squirt a value into the callback...  
> > 
> > If it doesn't fit, then it doesn't fit.
> > 
> > However, while I was expecting pass one to be in the callback, I wasn't
> > expecting that both pass 1 and 2 shared the cpmu_regs_array. If the array
> > could be reconstructed during pass 2, then it would fit a bit better;
> > albeit the extra allocation, cycles etc., but this is probing phase, so
> > overhead isn't that important (and cpmu_count isn't big enough to matter).

I thought about that approach, but it's really ugly to have to do

1) For the IRQ number gathering.
  a) Parse 1 to count CPMUs
  b) Parse 2 to get the register maps - grab the irq numbers and unmap them again
2) For the CPMU registration
  a) Parse 3 to count CPMUs (we could stash the number of CPMUS form 1a) but
     that's no advantage over stashing the max irq in current proposal.
     Both are putting state where it's not relevant or wanted just to make it
     available in a callback.  This way is even worse because it's getting
     stashed as a side effect of a parse in a function doing something different.
  b) Parse 4 to get the register maps and actually create the devices. Could have
     stashed this earlier as well, but same 'side effects' argument applies.

Sure, can move to this however with appropriate comments on why we are playing
these games because otherwise I suspect a future 'cleanup' would remove double, double
pass.

To allow for an irq registration wrapper that turns a series of straight
line calls into callbacks in an array.  The straight line calls aren't exactly
complex in the first place.
//find cpmu filling in cxl_cpmu_reg_maps.

max_irq = -1
rc = cxl_mailbox_get_irq()
if (rc < 0)
	return rc;
max_irq = max(max_irq, rc);

rc = cxl_events_get_irq()
if (rc < 0)
	return rc;
max_irq = max(max_irq, rc);

rc = cxl_cpmus_get_irq(cxl_cpmu_reg_maps);
if (rc < 0)
	return rc;
max_irq = max(max_irq, rC);

...

if (irq > 0) {

	pci_get...
}

//create all the devices...


> > 
> > But if we're going to go with a free-for-all approach, can we establish
> > who goes for the initial pci_alloc_irq_vectors()? I think perhaps mbox
> > since it's the most straightforward and with least requirements, I'm
> > also unsure of the status yet to merge events and pmu, but regardless
> > they are still larger patchsets. If folks agree I can send a new mbox-only
> > patch.  
> 
> I think there needs to be some mechanism for all of the sub-device-functions to
> report their max required vectors.
> 
> I don't think that the mbox code is necessarily the code which should need to
> know about all those other sub-device-thingys.  But it could certainly take
> some 'max vectors' value that probe passed to it.
> 
> I'm still not sure how dropping this infrastructure makes Jonathan's code
> cleaner.  I still think there will need to be 2 passes over the number of
> CPMU's.
> 

Primarily that there is no need to stash anything about the CPMUs in the
cxl_device_state (option 1) or repeat all the counting and discovery logic twice
(option 2).

I can live with it (it's what we have to do in pcie port for the equivalent)
but the wrapped up version feels like a false optimization.

Saves a few lines of code and adds a bunch of complexity elsewhere that looks to
me to outweigh that saving.

If people are convinced this is the way to go then fair enough, but be prepared
for the ugly corners!

Jonathan

> Ira
> 
> > 
> > Thanks,
> > Davidlohr  
> 

