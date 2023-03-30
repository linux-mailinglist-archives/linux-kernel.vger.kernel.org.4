Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8649C6D12AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjC3Wz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjC3Wzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:55:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A77E1A0;
        Thu, 30 Mar 2023 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680216948; x=1711752948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zgFpmRZs/7ZR9MOQdmaZR491jtEUEudV+B86M7lXITU=;
  b=I+tWhtv7EgDXr2ygNtK/3YE0q24J/4hZ85/smvdk9/HTEK/u3lMBcEED
   2RQFygzaJm/l9SWCCHVG16BQyFOoapw/jT/pS3NNNK1yczuJbcJyT51RU
   xNk2y0hCROJipxrMqYOzYy/JswVSXiamqO4UKQcY6GGVT2Wz2zfU5MPux
   Lc1ARF8bvM9Sa+EGcvwFH7GT74f0VGzX43U1DB/qUCz+WAFvGWnybqjJ4
   KY/pg5l65/R7psjNmUBoKDsmtac4BTCY0fY5yPOGXYkVSQXFNTRhRDqAu
   AiYDgcLKbly1I/oPv/qGOw7D697MPAr9h5g2vqjRFZxuCZXKfhULVlAdG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="325262469"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="325262469"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 15:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="1014611994"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="1014611994"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.117.86]) ([10.212.117.86])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 15:55:47 -0700
Message-ID: <6e59a3d6-0b68-2d36-d25a-652167168db8@intel.com>
Date:   Thu, 30 Mar 2023 15:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v10 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1679448904.git.alison.schofield@intel.com>
 <b0d0296b7001f2646c54b56ac15cda319d133097.1679448904.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <b0d0296b7001f2646c54b56ac15cda319d133097.1679448904.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 7:12 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a boolean 'true' is written to this attribute the memdev driver
> retrieves the poison list from the device. The list consists of
> addresses that are poisoned, or would result in poison if accessed,
> and the source of the poison. This attribute is only visible for
> devices supporting the capability. The retrieved errors are logged
> as kernel trace events with the label 'cxl_poison'.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
>   drivers/cxl/core/memdev.c               | 48 +++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h                    |  5 ++-
>   drivers/cxl/mem.c                       | 36 +++++++++++++++++++
>   4 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3acf2f17a73f..02776fee6d4c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -415,3 +415,17 @@ Description:
>   		1), and checks that the hardware accepts the commit request.
>   		Reading this value indicates whether the region is committed or
>   		not.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> +Date:		March, 2023
> +KernelVersion:	v6.4
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a boolean 'true' is written to this attribute the
> +		memdev driver retrieves the poison list from the device. The
> +		list consists of addresses that are poisoned, or would result
> +		in poison if accessed, and the source of the poison. This
> +		attribute is only visible for devices supporting the
> +		capability. The retrieved errors are logged as kernel
> +		trace events with the label 'cxl_poison'.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0af8856936dc..5ef40c36f1a3 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,6 +106,53 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(numa_node);
>   
> +static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
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
> +		/*
> +		 * Invalid Physical Address is not an error for
> +		 * volatile addresses. Device support is optional.
> +		 */
> +		if (rc == -EFAULT)
> +			rc = 0;
> +	}
> +	return rc;
> +}
> +
> +ssize_t cxl_trigger_poison_list(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	bool trigger;
> +	int rc;
> +
> +	if (kstrtobool(buf, &trigger) || !trigger)
> +		return -EINVAL;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	rc = cxl_get_poison_by_memdev(cxlmd);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	return rc ? rc : len;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
> +
>   static struct attribute *cxl_memdev_attributes[] = {
>   	&dev_attr_serial.attr,
>   	&dev_attr_firmware_version.attr,
> @@ -130,6 +177,7 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>   {
>   	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>   		return 0;
> +

Stray blank line?

>   	return a->mode;
>   }
>   
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 57a5999ddb35..5febaa3f9b04 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -145,7 +145,7 @@ struct cxl_mbox_cmd {
>   	C(FWROLLBACK, -ENXIO, "rolled back to the previous active FW"),         \
>   	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
>   	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
> -	C(PADDR, -ENXIO, "physical address specified is invalid"),		\
> +	C(PADDR, -EFAULT, "physical address specified is invalid"),		\

Seems unrelated change? Does it go with previous patch?

>   	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),        \
>   	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),		\
>   	C(ABORT, -ENXIO, "background cmd was aborted by device"),               \
> @@ -675,6 +675,9 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds);
>   int cxl_poison_state_init(struct cxl_dev_state *cxlds);
>   int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   		       struct cxl_region *cxlr);
> +ssize_t cxl_trigger_poison_list(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t len);
>   
>   #ifdef CONFIG_CXL_SUSPEND
>   void cxl_mem_active_inc(void);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 39c4b54f0715..576f5b691589 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -176,10 +176,46 @@ static int cxl_mem_probe(struct device *dev)
>   	return devm_add_action_or_reset(dev, enable_suspend, NULL);
>   }
>   
> +static ssize_t trigger_poison_list_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	return cxl_trigger_poison_list(dev, attr, buf, len);
> +}
> +
> +static DEVICE_ATTR_WO(trigger_poison_list);
> +
> +static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	if (a == &dev_attr_trigger_poison_list.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> +			return 0;
> +	}
> +	return a->mode;
> +}
> +
> +static struct attribute *cxl_mem_attrs[] = {
> +	&dev_attr_trigger_poison_list.attr,
> +	NULL
> +};
> +
> +static struct attribute_group cxl_mem_group = {
> +	.attrs = cxl_mem_attrs,
> +	.is_visible = cxl_mem_visible,
> +};
> +
> +__ATTRIBUTE_GROUPS(cxl_mem);
> +
>   static struct cxl_driver cxl_mem_driver = {
>   	.name = "cxl_mem",
>   	.probe = cxl_mem_probe,
>   	.id = CXL_DEVICE_MEMORY_EXPANDER,
> +	.drv = {
> +		.dev_groups = cxl_mem_groups,
> +	},
>   };
>   
>   module_cxl_driver(cxl_mem_driver);
