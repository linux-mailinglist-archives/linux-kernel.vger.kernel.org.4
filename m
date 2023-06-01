Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C71719DFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjFAN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjFAN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:27:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A235FE66;
        Thu,  1 Jun 2023 06:27:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX6PK5rSLz6J74d;
        Thu,  1 Jun 2023 21:27:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 14:27:18 +0100
Date:   Thu, 1 Jun 2023 14:27:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 14/23] cxl/port: Remove Component Register base
 address from struct cxl_port
Message-ID: <20230601142718.00001855@Huawei.com>
In-Reply-To: <20230523232214.55282-15-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-15-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 18:22:05 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 4 +---
>  drivers/cxl/cxl.h       | 2 --
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index db2ba0c886e2..183f9f8548e2 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -615,7 +615,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
>  static struct lock_class_key cxl_port_key;
>  
>  static struct cxl_port *cxl_port_alloc(struct device *uport,
> -				       resource_size_t component_reg_phys,
>  				       struct cxl_dport *parent_dport)
>  {
>  	struct cxl_port *port;
> @@ -665,7 +664,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  	} else
>  		dev->parent = uport;
>  
> -	port->component_reg_phys = component_reg_phys;
>  	ida_init(&port->decoder_ida);
>  	port->hdm_end = -1;
>  	port->commit_end = -1;
> @@ -724,7 +722,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  	struct device *dev;
>  	int rc;
>  
> -	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
> +	port = cxl_port_alloc(uport, parent_dport);
>  	if (IS_ERR(port))
>  		return port;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index dc83c1d0396e..4365d46606df 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -556,7 +556,6 @@ struct cxl_dax_region {
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> - * @component_reg_phys: component register capability base address (optional)
>   * @dead: last ep has been removed, force port re-creation
>   * @depth: How deep this port is relative to the root. depth 0 is the root.
>   * @cdat: Cached CDAT data
> @@ -576,7 +575,6 @@ struct cxl_port {
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> -	resource_size_t component_reg_phys;
>  	bool dead;
>  	unsigned int depth;
>  	struct cxl_cdat {

