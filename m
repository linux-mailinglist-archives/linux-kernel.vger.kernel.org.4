Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6C745B11
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGCL3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGCL3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:29:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5AE75;
        Mon,  3 Jul 2023 04:29:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QvkDy3l80z6J75p;
        Mon,  3 Jul 2023 19:28:02 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 3 Jul
 2023 12:29:40 +0100
Date:   Mon, 3 Jul 2023 19:29:36 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v8 01/14] cxl/port: Pre-initialize component register
 mappings
Message-ID: <20230703192936.00003dbd@Huawei.com>
In-Reply-To: <20230630231635.3132638-2-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
        <20230630231635.3132638-2-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 18:16:22 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> The component registers of a component may not exist or are not
> needed. The setup may fail for that reason. In some cases the
> initialization should continue anyway. Thus, always initialize struct
> cxl_register_map with valid values. In case of errors, zero it, set a
> value for @dev and make @resource a the valid value using
> CXL_RESOURCE_NONE.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 724be8448eb4..2d22e7a5629b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -693,16 +693,17 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
>  			       resource_size_t component_reg_phys)
>  {
> -	if (component_reg_phys == CXL_RESOURCE_NONE)
> -		return 0;
> -
>  	*map = (struct cxl_register_map) {
>  		.dev = dev,
> -		.reg_type = CXL_REGLOC_RBI_COMPONENT,
>  		.resource = component_reg_phys,
> -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
>  	};
>  
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return 0;
> +
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
>  	return cxl_setup_regs(map);
>  }
>  

