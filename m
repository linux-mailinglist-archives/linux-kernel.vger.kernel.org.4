Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4428712372
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbjEZJYh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243035AbjEZJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:24:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EAD1A2;
        Fri, 26 May 2023 02:24:32 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSKFc4JZkz67lH1;
        Fri, 26 May 2023 17:22:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 10:24:29 +0100
Date:   Fri, 26 May 2023 10:24:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephane Eranian <eranian@google.com>
CC:     Namhyung Kim <namhyung@gmail.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <will@kernel.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>
Subject: Re: [PATCH v6 4/5] perf: CXL Performance Monitoring Unit driver
Message-ID: <20230526102428.00002b6a@Huawei.com>
In-Reply-To: <CABPqkBQpXAq=uk5-vx-FkYJV1nrtugit_ExFqGgQCKGQC2no6w@mail.gmail.com>
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
        <20230413142617.15995-5-Jonathan.Cameron@huawei.com>
        <CAM9d7ciPW67QRRwRsY3-ouEM6wM0YdX+qnkkqYmTXRLwJcgqkA@mail.gmail.com>
        <CABPqkBQpXAq=uk5-vx-FkYJV1nrtugit_ExFqGgQCKGQC2no6w@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 18:18:55 -0700
Stephane Eranian <eranian@google.com> wrote:

> On Thu, May 25, 2023 at 6:06 PM Namhyung Kim <namhyung@gmail.com> wrote:
> >
> > Add Stephane to CC.
> >
> > On Thu, Apr 13, 2023 at 7:35 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > >
> > > CXL rev 3.0 introduces a standard performance monitoring hardware
> > > block to CXL. Instances are discovered using CXL Register Locator DVSEC
> > > entries. Each CXL component may have multiple PMUs.
> > >
> > > This initial driver supports a subset of types of counter.
> > > It supports counters that are either fixed or configurable, but requires
> > > that they support the ability to freeze and write value whilst frozen.
> > >
> > > Development done with QEMU model which will be posted shortly.
> > >
> > > Example:
> > >
> > > $ perf stat -e cxl_pmu_mem0.0/h2d_req_snpcur/ -e cpmu0/h2d_req_snpdata/ -e cpmu0/clock_ticks/ sleep 1
> > >
> > > Performance counter stats for 'system wide':
> > >  
> 
> Unless I am mistaken, I don't think this output corresponds to the
> cmdline above. I think the -a is missing.
> I don't think you can measure CXL traffic per-thread. Please confirm.
> Thanks.

It doesn't seem to make any difference whether I include -a or not and
the perf man page says 

       -a, --all-cpus
           system-wide collection from all CPUs (default if no target is
           specified)

However I'm not sure what target means in this case as there is no
mention of it anywhere else in the perf-stat man page.  My guess is thread
or process provided by -p or -t.  So default applies in the above command line.
Doesn't hurt to be more explicit though, so I've added -a.

The command line is wrong however as I failed to update the device name
for the 2nd and 3rd events.


> 
> >  
> > > 96,757,023,244,321      cxl_pmu_mem0.0/h2d_req_snpcur/
> > > 96,757,023,244,365      cxl_pmu_mem0.0/h2d_req_snpdata/
> > > 193,514,046,488,653      cxl_pmu_mem0.0/clock_ticks/
> > >
> > >        1.090539600 seconds time elapsed
