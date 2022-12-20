Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6756765248B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLTQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiLTQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:20:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A6E38;
        Tue, 20 Dec 2022 08:20:36 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nc1tl5mXmz688J2;
        Wed, 21 Dec 2022 00:17:19 +0800 (CST)
Received: from localhost (10.81.208.216) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 16:20:32 +0000
Date:   Tue, 20 Dec 2022 16:20:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <20221220162029.00001da7@Huawei.com>
In-Reply-To: <965d66486eb3ebbca6b1b265678130edd66f105e.1671135967.git.alison.schofield@intel.com>
References: <cover.1671135967.git.alison.schofield@intel.com>
        <965d66486eb3ebbca6b1b265678130edd66f105e.1671135967.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.216]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Thu, 15 Dec 2022 13:17:45 -0800
alison.schofield@intel.com wrote:

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
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
>  drivers/cxl/core/memdev.c               | 45 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  2 +-
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8494ef27e8d2..df40ed09ea67 100644
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
> +		list consists of addresses that are poisoned, or would result
> +		in poison if accessed, and the source of the poison. This
> +		attribute is only visible for devices supporting the
> +		capability. The retrieved errors are logged as kernel
> +		trace events with the label 'cxl_poison'.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a74a93310d26..e0af7e9c9989 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,12 +106,49 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
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
> +		if (rc && rc != -EFAULT)
> +			return rc;
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
> @@ -130,6 +167,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
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
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f53fae20f502..28ba0cd8f2d3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -139,7 +139,7 @@ struct cxl_mbox_cmd {
>  	C(FWROLLBACK, -ENXIO, "rolled back to the previous active FW"),         \
>  	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
>  	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
> -	C(PADDR, -ENXIO, "physical address specified is invalid"),		\
> +	C(PADDR, -EFAULT, "physical address specified is invalid"),		\
>  	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),        \
>  	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),		\
>  	C(ABORT, -ENXIO, "background cmd was aborted by device"),               \

