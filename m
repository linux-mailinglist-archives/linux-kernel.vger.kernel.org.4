Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD662BE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiKPMti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiKPMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:49:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E3E1740A;
        Wed, 16 Nov 2022 04:48:58 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC2qD1h5gz6H7RN;
        Wed, 16 Nov 2022 20:46:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:48:56 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 12:48:56 +0000
Date:   Wed, 16 Nov 2022 12:48:55 +0000
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
Subject: Re: [PATCH v3 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <20221116124855.00002f58@Huawei.com>
In-Reply-To: <5055dd47526d900f85f43bb0d85f4ccd4c9502b6.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
        <5055dd47526d900f85f43bb0d85f4ccd4c9502b6.1668115235.git.alison.schofield@intel.com>
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

On Thu, 10 Nov 2022 19:12:41 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a boolean 'true' is written to this attribute the memdev driver
> retrieves the poison list from the device. The list includes addresses
> that are poisoned, or would result in poison if accessed, and the
> source of the poison. This attribute is only visible for devices
> supporting the capability. The retrieved errors are logged as kernel
> trace events with the label 'cxl_poison'.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Hi Alison,

A few comments inline.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++++
>  drivers/cxl/core/memdev.c               | 41 +++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8494ef27e8d2..1c5f4a853ba2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -388,3 +388,17 @@ Description:
>  		1), and checks that the hardware accepts the commit request.
>  		Reading this value indicates whether the region is committed or
>  		not.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> +Date:		November, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a boolean 'true' is written to this attribute the
> +		memdev driver retrieves the poison list from the device. The
> +		list includes addresses that are poisoned or would result in
> +		poison if accessed, and the source of the poison. This

Trivial, but 'includes' kind of implies it might have other things as well.

The list consists of addresses that are... perhaps?

> +		attribute is only visible for devices supporting the
> +		capability. The retrieved errors are logged as kernel
> +		trace events with the label 'cxl_poison'.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 20ce488a7754..06d265db5127 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,12 +106,45 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t trigger_poison_list_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 offset, length;
> +	bool tmp;
> +	int rc;
> +
> +	if (kstrtobool(buf, &tmp))
> +		return -EINVAL;
> +
> +	/* Per CXL Spec, separate the pmem and ram poison list reads */

Reference?  I assume this is the bit about what happens if the
device doesn't support poison list retrieval for volatile memory?
I can't find anything more specific but maybe I'm looking in wrong place.

> +	if (resource_size(&cxlds->pmem_res)) {
> +		offset = cxlds->pmem_res.start;
> +		length = resource_size(&cxlds->pmem_res);
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc)
> +			return rc;
> +	}
> +	if (resource_size(&cxlds->ram_res)) {
> +		offset = cxlds->ram_res.start;
> +		length = resource_size(&cxlds->ram_res);
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc)
> +			return rc;

Hmm.  So should we handle the return of Invalid Physical Address as an
error or not?  I think not given it's optional to support the poison
list for volatile memory.

> +	}
> +	return len;
> +}
> +static DEVICE_ATTR_WO(trigger_poison_list);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_trigger_poison_list.attr,
>  	NULL,
>  };
>  
> @@ -130,6 +163,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  {
>  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>  		return 0;
> +
> +	if (a == &dev_attr_trigger_poison_list.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> +			return 0;
> +	}
>  	return a->mode;
>  }
>  

