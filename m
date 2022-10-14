Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32635FF1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJNP5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJNP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:57:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1342DD95;
        Fri, 14 Oct 2022 08:56:57 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MprXk2v91z67Vhk;
        Fri, 14 Oct 2022 23:53:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 17:56:54 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 16:56:54 +0100
Date:   Fri, 14 Oct 2022 16:56:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <bwidawsk@kernel.org>, <a.manzanares@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Add generic MSI/MSI-X interrupt support
Message-ID: <20221014165653.0000140e@huawei.com>
In-Reply-To: <20221013173703.th54drzlafvj74oo@offworld>
References: <20221012180432.473373-1-dave@stgolabs.net>
        <20221013131913.0000038b@huawei.com>
        <20221013173703.th54drzlafvj74oo@offworld>
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

On Thu, 13 Oct 2022 10:37:03 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Thanks for having a look.
> 
> On Thu, 13 Oct 2022, Jonathan Cameron wrote:
> 
> >> +struct cxl_irq_cap {
> >> +	const char *name;
> >> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);  
> >
> >For the CPMU case I need to walk the register locator dvsec block so need
> >the callback to take the pci_dev not the cxl_dev_state.  
> 
> Hmm ok, however maybe I'm missing something, but given a pdev, do we have a
> way to get back to the cxlds?

I'd failed to register we can easily get from cxlds to pci dev.
Had wrong mental model of what embedded what.

> 
> ...
> 
> >>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >>  {
> >>  	struct cxl_register_map map;
> >> @@ -498,6 +558,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >>  	if (IS_ERR(cxlmd))
> >>  		return PTR_ERR(cxlmd);
> >>
> >> +	/* TODO: When there are users, this return value must be checked */
> >> +	cxl_pci_alloc_irq_vectors(cxlds);
> >> +  
> >
> >Gut feeling is this will end up moving ahead of any of the sub device creation
> >because many of them end up needing interrupts.
> >
> >Also check response from the start - can't see a reason to not do so as we
> >won't be registering any at all if no callbacks provided.
> >
> >So I'd move it above the devm_cxl_add_memdev() call.  
> 
> Will do. In addition, are you ok with grouping the irq setup for each cxl
> feature/component, ie:
> 
> if (cxl_pci_alloc_irq_vectors(cxlds) > 0) {
>     cxl_setup_mbox_irq();
>     cxl_setup_events_irq();
>     cxl_setup_pmu_irq();
> }
> 
> I ask mostly from the mailbox perspective, in that we already have
> a mbox setup call and can certainly understand if people would prefer
> it there, but I tend to prefer the above (logically wrt irqs).

I'd rather see it in each of the setup calls.  Out in pci.c we
should just be doing minimum to find that max irq number.
e.g. the CPMU driver will rewalk and find it's vector number directly
from it's own register space.

Jonathan
> 
> Thanks,
> Davidlohr

