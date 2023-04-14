Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3F6E1E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjDNIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDNIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:23:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D646E1BC9;
        Fri, 14 Apr 2023 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4/OedsHNECWMdb1O/5CmBXIMhKWxTMAD8xpCzvQiWk4=; b=cJt80wV5U63xn0tju0Jh0AUTJp
        AW758NvMDPN4Eh2BgK4wm+ZoWVv7qdmVGZ2/4ZXuB6mHDoMACsiJfOlyVp3ZDgra439Vn/DR+wzMY
        GUKXVlFDW+LuV1S61mOEQVTYdXdwkM+2rN1CMvRIjwhtLZTnlXuUrl6yr9fkfX79nD3bD2nY86Rji
        PxYrYjrNcb6vNav4NU3sjbKOCk23dY4MnRGB90RFbCNk1Yzn5OUVrjfWCLFZzLYLMQOEUU3WcAox7
        PC/XwRv88/y5GK/P4jno8z/sfwzPbwH3lHDJs1lFQFa6/K1LhOrMCo1busLSiZpK1d9k+9YTN57Mo
        HG1G36nQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnEfg-00FWn9-0h;
        Fri, 14 Apr 2023 08:22:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2598430002F;
        Fri, 14 Apr 2023 10:20:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BC1520248CE4; Fri, 14 Apr 2023 10:20:39 +0200 (CEST)
Date:   Fri, 14 Apr 2023 10:20:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Liang Kan <kan.liang@linux.intel.com>, linux-cxl@vger.kernel.org,
        mark.rutland@arm.com, will@kernel.org, mingo@redhat.com,
        acme@kernel.org, dan.j.williams@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v6 1/5] perf: Allow a PMU to have a parent
Message-ID: <20230414082039.GT4253@hirez.programming.kicks-ass.net>
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
 <20230413142617.15995-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413142617.15995-2-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 03:26:13PM +0100, Jonathan Cameron wrote:
> Some PMUs have well defined parents such as PCI devices.
> As the device_initialize() and device_add() are all within
> pmu_dev_alloc() which is called from perf_pmu_register()
> there is no opportunity to set the parent from within a driver.
> 
> Add a struct device *parent field to struct pmu and use that
> to set the parent.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> v6: No change
> v5: Move to head of series as may merge as part of:
> https://lore.kernel.org/all/20230404134225.13408-1-Jonathan.Cameron@huawei.com/
> ---
>  include/linux/perf_event.h | 1 +
>  kernel/events/core.c       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..b99db1eda72c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -303,6 +303,7 @@ struct pmu {
>  
>  	struct module			*module;
>  	struct device			*dev;
> +	struct device			*parent;
>  	const struct attribute_group	**attr_groups;
>  	const struct attribute_group	**attr_update;
>  	const char			*name;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 435815d3be3f..32079a332480 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11367,6 +11367,7 @@ static int pmu_dev_alloc(struct pmu *pmu)
>  
>  	dev_set_drvdata(pmu->dev, pmu);
>  	pmu->dev->bus = &pmu_bus;
> +	pmu->dev->parent = pmu->parent;
>  	pmu->dev->release = pmu_dev_release;
>  
>  	ret = dev_set_name(pmu->dev, "%s", pmu->name);
> -- 
> 2.37.2
> 
