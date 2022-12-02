Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A82640841
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiLBOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiLBOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:19:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301693828;
        Fri,  2 Dec 2022 06:19:05 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNw2x5Cz0z689QP;
        Fri,  2 Dec 2022 22:15:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 2 Dec 2022 15:19:02 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 14:19:02 +0000
Date:   Fri, 2 Dec 2022 14:19:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Message-ID: <20221202141901.00003016@Huawei.com>
In-Reply-To: <6389ab5156083_c9572947c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-9-ira.weiny@intel.com>
        <6389ab5156083_c9572947c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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


> > +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> > +			     struct cxl_event_interrupt_policy *policy)
> > +{
> > +	int rc;
> > +
> > +	policy->info_settings = CXL_INT_MSI_MSIX;
> > +	policy->warn_settings = CXL_INT_MSI_MSIX;
> > +	policy->failure_settings = CXL_INT_MSI_MSIX;
> > +	policy->fatal_settings = CXL_INT_MSI_MSIX;  
> 
> I think this needs to be careful not to undo events that the BIOS
> steered to itself in firmware-first mode, which raises another question,
> does firmware-first mean more the OS needs to backoff on some event-log
> handling as well?

Hmm. Does the _OSC cover these.  There is one for Memory error reporting
that I think covers it (refers to 12.2.3.2)

Note that should cover any means of obtaining these, not just interrupt
driven - so including the initial record clear.

..

> > +
> > +static irqreturn_t cxl_event_failure_thread(int irq, void *id)
> > +{
> > +	struct cxl_dev_state *cxlds = id;
> > +
> > +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> > +	return IRQ_HANDLED;
> > +}  
> 
> So I think one of the nice side effects of moving log priorty handling
> inside of cxl_mem_get_records_log() and looping through all log types in
> priority order until all status is clear is that an INFO interrupt also
> triggers a check of the FATAL status for free.
> 

I go the opposite way on this in thinking that an interrupt should only
ever be used to handle the things it was registered for - so we should
not be clearing fatal records in the handler triggered for info events.

Doing other actions like this relies on subtlies of the generic interrupt
handling code which happens to force interrupt threads on a shared interrupt
line to be serialized.  I'm not sure we are safe at all the interrupt
isn't shared unless we put a lock around the whole thing (we have one
because of the buffer mutex though).

If going this way I think the lock needs a rename.
It's not just protecting the buffer used, but also serialize multiple
interrupt threads.

Jonathan

> You likely do not even need to do the status read in hardirq part of the
> handler, just unconditionally wake the event handler thread. I.e. just
> pass NULL for @handler to devm_request_threaded_irq() and let the
> thread_fn figure it all out in priority order.



