Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955EB719CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjFANHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjFANHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:07:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C411297;
        Thu,  1 Jun 2023 06:07:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX5vW5Rbkz682sP;
        Thu,  1 Jun 2023 21:04:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 14:07:02 +0100
Date:   Thu, 1 Jun 2023 14:07:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 11/23] cxl/port: Store the downstream port's
 Component Register mappings in struct cxl_dport
Message-ID: <20230601140701.00005e78@Huawei.com>
In-Reply-To: <20230523232214.55282-12-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-12-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Tue, 23 May 2023 18:22:02 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> Same as for ports, also store the downstream port's Component Register
> mappings, use struct cxl_dport for that.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 11 +++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 34e929f1723b..db2ba0c886e2 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -708,6 +708,13 @@ static inline int cxl_port_setup_regs(struct cxl_port *port,
>  				   component_reg_phys);
>  }
>  
> +static inline int cxl_dport_setup_regs(struct cxl_dport *dport,
> +				       resource_size_t component_reg_phys)
> +{
> +	return cxl_setup_comp_regs(dport->dev, &dport->comp_map,
> +				   component_reg_phys);
> +}
> +
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  					    struct device *uport,
>  					    resource_size_t component_reg_phys,
> @@ -986,6 +993,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	dport->port = port;
>  	dport->rcrb.base = rcrb;
>  
> +	rc = cxl_dport_setup_regs(dport, component_reg_phys);
> +	if (rc && rc != -ENODEV)
> +		return ERR_PTR(rc);
> +
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c76e1f84ba61..dc83c1d0396e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -601,6 +601,7 @@ struct cxl_rcrb_info {
>   * struct cxl_dport - CXL downstream port
>   * @dev: PCI bridge or firmware device representing the downstream link
>   * @port: reference to cxl_port that contains this downstream port
> + * @comp_map: component register capability mappings
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @component_reg_phys: downstream port component registers
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
> @@ -609,6 +610,7 @@ struct cxl_rcrb_info {
>  struct cxl_dport {
>  	struct device *dev;
>  	struct cxl_port *port;
> +	struct cxl_register_map comp_map;
>  	int port_id;
>  	resource_size_t component_reg_phys;
>  	bool rch;

