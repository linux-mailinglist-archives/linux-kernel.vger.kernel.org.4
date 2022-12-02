Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169FF64076C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiLBNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiLBNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:04:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65890D78D4;
        Fri,  2 Dec 2022 05:04:46 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNtPc2Ct8z6H7G9;
        Fri,  2 Dec 2022 21:01:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 14:04:43 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 13:04:43 +0000
Date:   Fri, 2 Dec 2022 13:04:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221202130442.0000088a@Huawei.com>
In-Reply-To: <63895c5b40770_3cbe029432@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-2-ira.weiny@intel.com>
        <63894579bf550_3cbe029458@dwillia2-xfh.jf.intel.com.notmuch>
        <Y4lIE7Fyctj6GagE@iweiny-desk3>
        <63895c5b40770_3cbe029432@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Thu, 1 Dec 2022 18:00:59 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Ira Weiny wrote:
> > On Thu, Dec 01, 2022 at 04:23:21PM -0800, Dan Williams wrote:  
> > > ira.weiny@ wrote:  
> > > > From: Davidlohr Bueso <dave@stgolabs.net>
> > > > 
> > > > Currently the only CXL features targeted for irq support require their
> > > > message numbers to be within the first 16 entries.  The device may
> > > > however support less than 16 entries depending on the support it
> > > > provides.
> > > > 
> > > > Attempt to allocate these 16 irq vectors.  If the device supports less
> > > > then the PCI infrastructure will allocate that number.  
> > > 
> > > What happens if the device supports 16, but irq-core allocates less? I
> > > believe the answer is with the first user, but this patch does not
> > > include a user.
> > >   
> > > > Store the number of vectors actually allocated in the device state for
> > > > later use by individual functions.  
> > > 
> > > The patch does not do that.  
> > 
> > Sorry missed updating this message.
> >   
> > > 
> > > I know this patch has gone through a lot of discussion, but this
> > > mismatch shows it should really be squashed with the first user because
> > > it does not stand on its own anymore.  
> > 
> > It is separate because it was Davidlohr's to begin with.
> > 
> > I'll squash it back.
> >   
> > >   
> > > > Upon successful allocation, users can plug in their respective isr at
> > > > any point thereafter, for example, if the irq setup is not done in the
> > > > PCI driver, such as the case of the CXL-PMU.
> > > > 
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > > 
> > > > ---
> > > > Changes from V1:
> > > > 	Jonathan
> > > > 		pci_alloc_irq_vectors() cleans up the vectors automatically
> > > > 		use msi_enabled rather than nr_irq_vecs
> > > > 
> > > > Changes from Ira
> > > > 	Remove reviews
> > > > 	Allocate up to a static 16 vectors.
> > > > 	Change cover letter
> > > > ---
> > > >  drivers/cxl/cxlmem.h |  3 +++
> > > >  drivers/cxl/cxlpci.h |  6 ++++++
> > > >  drivers/cxl/pci.c    | 23 +++++++++++++++++++++++
> > > >  3 files changed, 32 insertions(+)
> > > > 
> > > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > > index 88e3a8e54b6a..cd35f43fedd4 100644
> > > > --- a/drivers/cxl/cxlmem.h
> > > > +++ b/drivers/cxl/cxlmem.h
> > > > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> > > >   * @info: Cached DVSEC information about the device.
> > > >   * @serial: PCIe Device Serial Number
> > > >   * @doe_mbs: PCI DOE mailbox array
> > > > + * @msi_enabled: MSI-X/MSI has been enabled
> > > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > > >   *
> > > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> > > >  
> > > >  	struct xarray doe_mbs;
> > > >  
> > > > +	bool msi_enabled;
> > > > +  
> > > 
> > > This goes unused in this patch and it also duplicates what the core
> > > offers with pdev->{msi,msix}_enabled.  
> > 
> > I tried to argue that with Jonathan and lost.  What I had in V1 was to store
> > the number actually allocated.  Then if a function reports something higher
> > later it can't be used.  
> 
> A successful pci_alloc_irq_vectors() call assigns a vector number to all
> interrupt sources on the device regardless of how many interrupt sources
> there are. If the device has 32 interrupt sources and 16 irqs are returned
> from pci_alloc_irq_vectors() then each interrupt source will be sharing
> a vector with one or more other vectors. All PCI IRQ vectors are shared.

Assuming my understanding is correct...
Subtle tweak to that description (not that it matters in practice).
Some of the vectors will be shared. For MSI at least it is up to the
device to assign msgnums in whatever way it likes such that they are
fit in the number that were enabled.  So it 'could' put them all on the
first msgnum if it wants to, or put any that would otherwise have been
greater than 16 on msgnum 15.  Impdef how it decides that spread.

MSIX is has a layer of indirection in control of software, so it gets
more complex...



> 
> So I do not see the point of this msi_enabled flag cxl_dev_state. If
> pci_alloc_irq_vectors() returns at least 1 then you are good to go.

