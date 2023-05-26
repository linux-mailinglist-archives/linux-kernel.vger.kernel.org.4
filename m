Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8271238F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbjEZJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242632AbjEZJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:27:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AFB135;
        Fri, 26 May 2023 02:27:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSKFY2DVYz6H7kP;
        Fri, 26 May 2023 17:22:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 10:27:06 +0100
Date:   Fri, 26 May 2023 10:27:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Namhyung Kim <namhyung@gmail.com>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v6 4/5] perf: CXL Performance Monitoring Unit driver
Message-ID: <20230526102705.00003345@Huawei.com>
In-Reply-To: <CAM9d7ciPW67QRRwRsY3-ouEM6wM0YdX+qnkkqYmTXRLwJcgqkA@mail.gmail.com>
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
        <20230413142617.15995-5-Jonathan.Cameron@huawei.com>
        <CAM9d7ciPW67QRRwRsY3-ouEM6wM0YdX+qnkkqYmTXRLwJcgqkA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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


Hi Namhyung,

> > +static int cxl_pmu_event_init(struct perf_event *event)
> > +{
> > +       struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
> > +
> > +       event->cpu = info->on_cpu;  
> 
> Why not change the event->cpu after validation is done?

Sure. Whilst I think it's harmless,
it logically makes more sense to do it a few lines later
so I'll move it to the end of this function.


> 
> Thanks,
> Namhyung
> 
> 
> > +       /* Top level type sanity check - is this a Hardware Event being requested */
> > +       if (event->attr.type != event->pmu->type)
> > +               return -ENOENT;
> > +
> > +       if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> > +               return -EOPNOTSUPP;
> > +       /* TODO: Validation of any filter */
> > +
> > +       /*
> > +        * Verify that it is possible to count what was requested. Either must
> > +        * be a fixed counter that is a precise match or a configurable counter
> > +        * where this is a subset.
> > +        */
> > +       return cxl_pmu_get_event_idx(event, NULL, NULL);
> > +}
