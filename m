Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE576EBFD3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDWNsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:48:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F94E47;
        Sun, 23 Apr 2023 06:48:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q48bg0h4kz67KJs;
        Sun, 23 Apr 2023 21:43:11 +0800 (CST)
Received: from localhost (10.48.150.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 14:48:03 +0100
Date:   Sun, 23 Apr 2023 14:48:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v6 4/5] perf: CXL Performance Monitoring Unit driver
Message-ID: <20230423144801.00006efd@Huawei.com>
In-Reply-To: <6444603653882_1b41629414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
        <20230413142617.15995-5-Jonathan.Cameron@huawei.com>
        <6444603653882_1b41629414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.150.148]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Apr 2023 15:31:18 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > CXL rev 3.0 introduces a standard performance monitoring hardware
> > block to CXL. Instances are discovered using CXL Register Locator DVSEC
> > entries. Each CXL component may have multiple PMUs.
> > 
> > This initial driver supports a subset of types of counter.
> > It supports counters that are either fixed or configurable, but requires
> > that they support the ability to freeze and write value whilst frozen.
> > 
> > Development done with QEMU model which will be posted shortly.
> > 
> > Example:
> > 
> > $ perf stat -e cxl_pmu_mem0.0/h2d_req_snpcur/ -e cpmu0/h2d_req_snpdata/ -e cpmu0/clock_ticks/ sleep 1
> > 
> > Performance counter stats for 'system wide':
> > 
> > 96,757,023,244,321      cxl_pmu_mem0.0/h2d_req_snpcur/
> > 96,757,023,244,365      cxl_pmu_mem0.0/h2d_req_snpdata/
> > 193,514,046,488,653      cxl_pmu_mem0.0/clock_ticks/
> > 
> >        1.090539600 seconds time elapsed
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Jonathan, I was awaiting a "perf maintainer ack" before applying this,
> only to now realize there is no maintainer entry for drivers/perf/ in
> general, only "ARM PMU PROFILING AND DEBUGGING". Were you waiting on any
> additional acks from perf folks for this?

I'm always hopeful.  For everything similar we've done in the past in
drivers/perf, Will Deacon has taken a look and ultimately taken the series
(often Mark has as well), but then those drivers could be very loosely
termed ARM PMU on basis they happen to be PMUs on an ARM architecture
system even if they have nothing at all to do with the ARM architecture
itself (e.g. our PCI PMUs).

I see the riscv stuff has been going in drivers/perf without an Ack from
them though so there is precedent for non ARM stuff in this directory
going in through other trees despite the catch all maintainers entry.

So, Will / Mark do you consider this in your maintainer scope? 

Your input is welcome either way but as you might be very busy I
don't want to commit you to taking a look at this CXL driver.

> 
> If there are no objections I think this can be included in the back half
> of the merge window for v6.4, as it stands now I was still awaiting the
> final go ahead.

That would be great if possible. If not I'll just back new features up
behind this series and hopefully a larger set might go in next cycle.

Thanks,

Jonathan

