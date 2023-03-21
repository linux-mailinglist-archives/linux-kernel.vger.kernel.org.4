Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F066C34AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjCUOsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCUOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:48:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9213FB80;
        Tue, 21 Mar 2023 07:48:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PgvZb3h7Mz6J6vG;
        Tue, 21 Mar 2023 22:47:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 21 Mar
 2023 14:48:14 +0000
Date:   Tue, 21 Mar 2023 14:48:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/pci: Find and register CXL PMU devices
Message-ID: <20230321144813.00002c19@Huawei.com>
In-Reply-To: <20230307023656.cyntxctzqgpam5u3@offworld>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
        <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
        <20230307023656.cyntxctzqgpam5u3@offworld>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Mon, 6 Mar 2023 18:36:56 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Fri, 03 Mar 2023, Jonathan Cameron wrote:
> 
> >+int devm_cxl_cpmu_add(struct device *parent, struct cxl_cpmu_regs *regs, int index)
> >+{
> >+	struct cxl_cpmu *cpmu;
> >+	struct device *dev;
> >+	int rc;
> >+
> >+	cpmu = kzalloc(sizeof(*cpmu), GFP_KERNEL);
> >+	if (!cpmu)
> >+		return -ENOMEM;
> >+
> >+	cpmu->base = regs->cpmu;
> >+	dev = &cpmu->dev;
> >+	device_initialize(dev);
> >+	device_set_pm_not_required(dev);
> >+	dev->parent = parent;
> >+	dev->bus = &cxl_bus_type;
> >+	dev->type = &cxl_cpmu_type;
> >+	rc = ida_alloc(&cpmu_ida, GFP_KERNEL);
> >+	if (rc < 0)
> >+		goto err;  
> 
> Probably better to do the ida_alloc after the cpmu allocation above, before
> arming the dev.

Hi Davidlohr,

There was a bug hiding here I think as the device_put() could cause the ida
to be freed even though the ida_alloc() failed.

Good you pointed out this oddity.

Moving the ida_alloc earlier requires an explicit free of the cpmu
but that's easy enough to locally to that if (rc < 0)

Thanks,

Jonathan
