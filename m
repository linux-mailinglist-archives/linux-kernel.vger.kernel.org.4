Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19D6D7A43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjDEKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjDEKsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:48:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7F74EED;
        Wed,  5 Apr 2023 03:48:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ps1Wh1tT8z6J749;
        Wed,  5 Apr 2023 18:46:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Apr
 2023 11:48:07 +0100
Date:   Wed, 5 Apr 2023 11:48:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 3/5] cxl/pci: Find and register CXL PMU devices
Message-ID: <20230405114805.000014ef@Huawei.com>
In-Reply-To: <642c77ad5f0d_21a8294fe@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
        <20230330164556.31533-4-Jonathan.Cameron@huawei.com>
        <642c77ad5f0d_21a8294fe@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Tue, 4 Apr 2023 12:17:01 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > CXL PMU devices can be found from entries in the Register
> > Locator DVSEC.
> > 
> > In order to register the minimum number of IRQ vectors necessary
> > to support all CPMUs found, separate the registration into two
> > steps.  First find the devices, and query the IRQs used and then
> > register the devices. Between these two steps, request the
> > IRQ vectors necessary and enable bus master support.  
> 
> It's not clear why this patch is talking about irq vectors and bus
> mastering when there is no irq query/setup logic in this patch?
> 

> > Future IRQ users for CXL type 3 devices (e.g. DOEs) will need to
> > follow a similar pattern the number of vectors necessary is known
> > before any parts of the driver stack rely on their availability.  
> 
> With the new pci_msix_alloc_irq_at() it's not clear that this 2 step
> approach is required, right?

Stale description. Will drop all that garbage.

> 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v4:
> > - No change.
> > ---
> >  drivers/cxl/core/Makefile |  1 +
> >  drivers/cxl/core/core.h   |  1 +
> >  drivers/cxl/core/cpmu.c   | 72 +++++++++++++++++++++++++++++++++++++++  
> 
> A quibble with the naming, I prefer:
> 
> drivers/cxl/core/pmu.c
> 
> ...since "cxl" is in the directory path. Also, usages of cpmu
> already have a cxl in their symbol names, so just s/cpmu/pmu/ throught.
> The usage of CPMU_ for register macros would seem be more clear, or at
> least more consistent, as CXL_PMU_ like the other register offset
> definitions in cxlpci.h.

Makes sense. I'll leave the register defs as
CPMU_XXX to keep them compact but use the pmu naming for pretty much everything else.

> 
> >  drivers/cxl/core/port.c   |  2 ++
> >  drivers/cxl/core/regs.c   | 16 +++++++++
> >  drivers/cxl/cpmu.h        | 56 ++++++++++++++++++++++++++++++  
> 
> drivers/cxl/pmu.h
> 
> >  drivers/cxl/cxl.h         | 14 ++++++++
> >  drivers/cxl/cxlpci.h      |  1 +
> >  drivers/cxl/pci.c         | 25 +++++++++++++-
> >  9 files changed, 187 insertions(+), 1 deletion(-)  
> 
> Other than those minor issues above, this looks good to me, with those
> fixed up.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Thanks,

