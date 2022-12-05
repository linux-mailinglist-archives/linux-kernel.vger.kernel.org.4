Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9546428E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiLENBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLENBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:01:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D681BEBB;
        Mon,  5 Dec 2022 05:01:33 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NQkDz2G48z685ZJ;
        Mon,  5 Dec 2022 21:00:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 13:01:30 +0000
Date:   Mon, 5 Dec 2022 13:01:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Message-ID: <20221205130129.00000cc1@Huawei.com>
In-Reply-To: <638a55611405d_3cbe02942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-9-ira.weiny@intel.com>
        <6389ab5156083_c9572947c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
        <20221202141901.00003016@Huawei.com>
        <638a55611405d_3cbe02942c@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Fri, 2 Dec 2022 11:43:29 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> >   
> > > > +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> > > > +			     struct cxl_event_interrupt_policy *policy)
> > > > +{
> > > > +	int rc;
> > > > +
> > > > +	policy->info_settings = CXL_INT_MSI_MSIX;
> > > > +	policy->warn_settings = CXL_INT_MSI_MSIX;
> > > > +	policy->failure_settings = CXL_INT_MSI_MSIX;
> > > > +	policy->fatal_settings = CXL_INT_MSI_MSIX;    
> > > 
> > > I think this needs to be careful not to undo events that the BIOS
> > > steered to itself in firmware-first mode, which raises another question,
> > > does firmware-first mean more the OS needs to backoff on some event-log
> > > handling as well?  
> > 
> > Hmm. Does the _OSC cover these.  There is one for Memory error reporting
> > that I think covers it (refers to 12.2.3.2)
> > 
> > Note that should cover any means of obtaining these, not just interrupt
> > driven - so including the initial record clear.
> > 
> > ..
> >   
> > > > +
> > > > +static irqreturn_t cxl_event_failure_thread(int irq, void *id)
> > > > +{
> > > > +	struct cxl_dev_state *cxlds = id;
> > > > +
> > > > +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> > > > +	return IRQ_HANDLED;
> > > > +}    
> > > 
> > > So I think one of the nice side effects of moving log priorty handling
> > > inside of cxl_mem_get_records_log() and looping through all log types in
> > > priority order until all status is clear is that an INFO interrupt also
> > > triggers a check of the FATAL status for free.
> > >   
> > 
> > I go the opposite way on this in thinking that an interrupt should only
> > ever be used to handle the things it was registered for - so we should
> > not be clearing fatal records in the handler triggered for info events.  
> 
> I would agree with you if this was a fast path and if the hardware
> mechanism did not involve shared status register that tells you
> that both FATAL and INFO are pending retrieval through a mechanism.
> Compare that to the separation between admin and IO queues in NVME.
> 
> If the handler is going to loop on the status register then it must be
> careful not to starve out FATAL while processing INFO.
> 
> > Doing other actions like this relies on subtlies of the generic interrupt
> > handling code which happens to force interrupt threads on a shared interrupt
> > line to be serialized.  I'm not sure we are safe at all the interrupt
> > isn't shared unless we put a lock around the whole thing (we have one
> > because of the buffer mutex though).  
> 
> The interrupt is likely shared since there is no performance benefit to
> entice hardware vendors spend transistor budget on more vector space for
> events. The events architecture does not merit that spend.
> 
> > If going this way I think the lock needs a rename.
> > It's not just protecting the buffer used, but also serialize multiple
> > interrupt threads.  
> 
> I will let Ira decide if he wants to rename, but in my mind the shared
> event buffer *is* the data being locked, the fact that multiple threads
> might be contending for it is immaterial.

It isn't he only thing being protected.  Access to the device is also
being serialized including the data in it's registers.

If someone comes along later and decides to implement multiple buffers
and there for gets rid of the lock. boom.


Jonathan

