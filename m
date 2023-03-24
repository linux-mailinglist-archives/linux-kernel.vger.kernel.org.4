Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB26C7DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCXMY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCXMY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:24:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7129B12CC4;
        Fri, 24 Mar 2023 05:24:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PjhF13cy6z6J7VZ;
        Fri, 24 Mar 2023 20:23:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 24 Mar
 2023 12:24:22 +0000
Date:   Fri, 24 Mar 2023 12:24:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jie Zhan <zhanjie9@hisilicon.com>
CC:     Yicong Yang <yangyicong@huawei.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <james.clark@arm.com>, <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <21cnbao@gmail.com>, <tim.c.chen@intel.com>,
        <prime.zeng@hisilicon.com>, <shenyang39@huawei.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: Re: [PATCH] perf stat: Support per-cluster aggregation
Message-ID: <20230324122422.00006a2b@Huawei.com>
In-Reply-To: <039a2fc2-48e2-fe3b-73c1-f7f658c7f22f@hisilicon.com>
References: <20230313085911.61359-1-yangyicong@huawei.com>
        <039a2fc2-48e2-fe3b-73c1-f7f658c7f22f@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Fri, 24 Mar 2023 10:34:33 +0800
Jie Zhan <zhanjie9@hisilicon.com> wrote:

> On 13/03/2023 16:59, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > Some platforms have 'cluster' topology and CPUs in the cluster will
> > share resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2
> > cache (for Intel Jacobsville). Currently parsing and building cluster
> > topology have been supported since [1].
> >
> > perf stat has already supported aggregation for other topologies like
> > die or socket, etc. It'll be useful to aggregate per-cluster to find
> > problems like L3T bandwidth contention or imbalance.
> >
> > This patch adds support for "--per-cluster" option for per-cluster
> > aggregation. Also update the docs and related test. The output will
> > be like:
> >
> > [root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
> >
> >   Performance counter stats for 'system wide':
> >
> > S56-D0-CLS158    4      1,321,521,570      LLC-load
> > S56-D0-CLS594    4        794,211,453      LLC-load
> > S56-D0-CLS1030    4             41,623      LLC-load
> > S56-D0-CLS1466    4             41,646      LLC-load
> > S56-D0-CLS1902    4             16,863      LLC-load
> > S56-D0-CLS2338    4             15,721      LLC-load
> > S56-D0-CLS2774    4             22,671      LLC-load
> > [...]
> >
> > [1] commit c5e22feffdd7 ("topology: Represent clusters of CPUs within a die")
> >
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>  
> 
> An end user may have to check sysfs to figure out what CPUs those 
> cluster IDs account for.
> 
> Any better method to show the mapping between CPUs and cluster IDs?

The cluster code is capable of using the ACPI_PPTT_ACPI_PROCESSOR_ID field
if valid for the cluster level of PPTT.

The numbers in the example above look like offsets into the PPTT table
so I think the PPTT table is missing that information.

Whilst not a great description anyway (it's just an index), the UUID
that would be in there can convey more info on which cluster this is.


> 
> Perhaps adding a conditional cluster id (when there are clusters) in the 
> "--per-core" output may help.

That's an interesting idea.  You'd want to include the other levels
if doing that.  So whenever you do a --per-xxx it also provides the
cluster / die / node / socket etc as relevant 'above' the level of xxx
Fun is that node and die can flip which would make this tricky to do.

Jonathan

> 
> Apart form that, this works well on my aarch64.
> 
> Tested-by: Jie Zhan <zhanjie9@hisilicon.com>

> 
> 

