Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AE362BEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKPMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiKPMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:50:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B619C2C;
        Wed, 16 Nov 2022 04:50:41 -0800 (PST)
Received: from frapeml500003.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC2sD1rSzz6887q;
        Wed, 16 Nov 2022 20:48:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:50:40 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 12:50:39 +0000
Date:   Wed, 16 Nov 2022 12:50:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] cxl/region: Add trigger_poison_list sysfs
 attribute
Message-ID: <20221116125038.00006273@Huawei.com>
In-Reply-To: <a696d91e34fc845673345a6b024545df849a8fef.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
        <a696d91e34fc845673345a6b024545df849a8fef.1668115235.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Thu, 10 Nov 2022 19:12:42 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a boolean 'true' is written to this attribute the region driver
> retrieves the poison list for the capacity each device contributes
> to this region. The list includes addresses that are poisoned, or
> would result in poison if accessed, and the source of the poison.
> The retrieved errors are logged as kernel trace events with the
> label 'cxl_poison'.
> 
> Devices not supporting the poison list capability are ignored.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Trivial comment inline you might want to consider.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++++++
>  drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 1c5f4a853ba2..54fad3bdcb2b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -402,3 +402,17 @@ Description:
>  		attribute is only visible for devices supporting the
>  		capability. The retrieved errors are logged as kernel
>  		trace events with the label 'cxl_poison'.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/trigger_poison_list
> +Date:		November, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a boolean 'true' is written to this attribute the
> +		region driver retrieves the poison list for the capacity
> +		each device contributes to this region. The list includes
Trivial: Same as in previous patch. "includes" is too vague.

> +		addresses that are poisoned, or would result in poison if
> +		accessed, and the source of the poison. The retrieved
> +		errors are logged as kernel trace events with the label
> +		'cxl_poison'.
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f9ae5ad284ff..68821238491e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -72,6 +72,38 @@ static int is_dup(struct device *match, void *data)
>  	return 0;
>  }
>  
> +static ssize_t trigger_poison_list_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
> +	u64 offset, length;
> +	int rc, i;
> +	bool tmp;
> +
> +	if (kstrtobool(buf, &tmp))
> +		return -EINVAL;
> +
> +	for (i = 0; i <  p->nr_targets; i++) {
> +		cxled = p->targets[i];
> +		cxlmd = cxled_to_memdev(cxled);
> +		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
> +			      cxlmd->cxlds->enabled_cmds))
> +			continue;
> +
> +		offset = cxl_dpa_resource_start(cxled);
> +		length = cxl_dpa_size(cxled);
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, cxlr);
> +		if (rc)
> +			return rc;
> +	}
> +	return len;
> +}
> +static DEVICE_ATTR_WO(trigger_poison_list);
> +
>  static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> @@ -570,6 +602,7 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_interleave_granularity.attr,
>  	&dev_attr_resource.attr,
>  	&dev_attr_size.attr,
> +	&dev_attr_trigger_poison_list.attr,
>  	NULL,
>  };
>  

