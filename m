Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083B6CAB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjC0RHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjC0RGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:06:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E59B6582;
        Mon, 27 Mar 2023 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679936719; x=1711472719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hlWOSQPo0QMLAreDNSpIZ2Q9rA9s2dWmZsWbzJ2/bLg=;
  b=O8BKP7vlJcHVb2kKxNBxtLct10HLitDvr94PrUQZTvEdo3ti1KOjKNm6
   ZAAysme49uNLzFmCKXnQPKTsX8ugDCSQSUM9jINmr6IFXhM1nms+GYa3A
   Klck2FIU642K+STwCUcfBLkYWQYTpe6IIl2YlS4G2CvBrWe2wWCYrmXo/
   QXHc4i1xaqE6ICV+C4Nw7rCT5JX/Cd8fd1L7o0ScAaJziHizO7zIWWfdD
   wZIql3N1/DRXb/+k1IL9HHfRjm0Icxoqn9mCfCvlMuVSXxxKAYFsJifF0
   oRAWqAaZdCh4apPu2v5kL6lQ8g2by65wc/YIq5qFOXUXz0V+kqgvLsFvg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="341906243"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="341906243"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 10:04:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="716133177"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="716133177"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2023 10:04:11 -0700
Received: from [10.212.228.64] (kliang2-mobl1.ccr.corp.intel.com [10.212.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 30BA3580689;
        Mon, 27 Mar 2023 10:04:10 -0700 (PDT)
Message-ID: <f8123e7c-36a6-a302-1101-e778622dc997@linux.intel.com>
Date:   Mon, 27 Mar 2023 13:04:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] perf: Allow a PMU to have a parent.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org, dan.j.williams@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
References: <20230324171313.18448-1-Jonathan.Cameron@huawei.com>
 <20230324171313.18448-3-Jonathan.Cameron@huawei.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230324171313.18448-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-24 1:13 p.m., Jonathan Cameron wrote:
> Some PMUs have well defined parents such as PCI devices.
> As the device_initialize() and device_add() are all within
> pmu_dev_alloc() which is called from perf_pmu_register()
> there is no opportunity to set the parent from within a driver.
> 
> Add a struct device *parent field to struct pmu and use that
> to set the parent.

Why we want a PMU parent? Maybe I missed it. I don't see that the parent
is used anywhere.

Thanks,
Kan

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> index fb3e436bcd4a..a84c282221f2 100644
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
