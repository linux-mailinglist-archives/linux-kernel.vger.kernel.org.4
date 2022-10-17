Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B5601066
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJQNnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJQNnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:43:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03903F02F;
        Mon, 17 Oct 2022 06:43:06 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrdQk0yWQz67j7Z;
        Mon, 17 Oct 2022 21:39:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 15:43:03 +0200
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 14:43:03 +0100
Date:   Mon, 17 Oct 2022 14:43:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] cxl/region: Add trigger_poison_list sysfs
 attribute
Message-ID: <20221017144302.0000521c@huawei.com>
In-Reply-To: <b5e7787816326854b736c922f7fcf195fba71338.1665606782.git.alison.schofield@intel.com>
References: <cover.1665606782.git.alison.schofield@intel.com>
        <b5e7787816326854b736c922f7fcf195fba71338.1665606782.git.alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
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

On Wed, 12 Oct 2022 14:28:20 -0700
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

Hi Alison,

For some reason I don't have cxl_dpa_resource().
Should that be cxl_dpa_resource_start()?

Looks like it got renamed in
cxl/hdm: Add support for allocating DPA to an endpoint decoder
cf880423b6a0599499c1f83542cab0b75daa29ba

Jonathan

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
> +		offset = cxl_dpa_resource(cxled);
> +		length = cxl_dpa_size(cxled);
> +		rc = cxl_mem_get_poison(cxlmd, offset, length,
> +					dev_name(&cxlr->dev));
> +		if (rc)
> +			return rc;
> +	}
> +	return len;
> +}
> +static DEVICE_ATTR_WO(trigger_poison_list);
