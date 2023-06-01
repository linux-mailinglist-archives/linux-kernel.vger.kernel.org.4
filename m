Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B481719C69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjFAMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjFAMqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:46:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825F7124;
        Thu,  1 Jun 2023 05:46:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX5Rf57msz67Z7y;
        Thu,  1 Jun 2023 20:44:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 13:45:58 +0100
Date:   Thu, 1 Jun 2023 13:45:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 07/23] cxl/acpi: Directly bind the CEDT detected
 CHBCR to the Host Bridge's port
Message-ID: <20230601134557.0000242b@Huawei.com>
In-Reply-To: <20230523232214.55282-8-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-8-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Tue, 23 May 2023 18:21:58 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> During a Host Bridge's downstream port enumeration the CHBS entries in
> the CEDT table are parsed, its Component Register base address
> extracted and then stored in struct cxl_dport. The CHBS may contain
> either the RCRB (RCH mode) or the Host Bridge's Component Registers
> (CHBCR, VH mode). The RCRB further contains the CXL downstream port
> register base address, while in VH mode the CXL Downstream Switch
> Ports are visible in the PCI hierarchy and the DP's component regs are
> disovered using the CXL DVSEC register locator capability. The
> Component Registers derived from the CHBS for both modes are different
> and thus also must be treated differently. That is, in RCH mode, the
> component regs base should be bound to the dport, but in VH mode to
> the CXL host bridge's port object.
> 
> The current implementation stores the CHBCR in addition in struct
> cxl_dport and copies it later from there to struct cxl_port. As a
> result, the dport contains the wrong Component Registers base address
> and, e.g. the RAS capability of a CXL Root Port cannot be detected.
> 
> To fix the CHBCR binding, attach it directly to the Host Bridge's
> @cxl_port structure. Do this during port creation of the Host Bridge
> in add_host_bridge_uport(). Factor out CHBS parsing code in
> add_host_bridge_dport() and use it in both functions.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
A few trivial formatting things.  With those tidied up or
reason given for why not,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c | 65 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 4fd9fe32f830..78a24b2ca923 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -333,8 +333,8 @@ struct cxl_chbs_context {
>  	u32 cxl_version;
>  };
>  
> -static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> -			 const unsigned long end)
> +static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
> +			     const unsigned long end)
>  {
>  	struct cxl_chbs_context *ctx = arg;
>  	struct acpi_cedt_chbs *chbs;
> @@ -362,6 +362,22 @@ static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
>  	return 0;
>  }
>  
> +static int cxl_get_chbs(struct acpi_device *hb, struct cxl_chbs_context *ctx)
> +{
> +	unsigned long long uid;
> +	int rc;
> +
> +	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> +	if (rc != AE_OK)
> +		return -ENOENT;
> +
> +	memset(ctx, 0, sizeof(*ctx));
> +	ctx->uid = uid;

For consistency with original code better to use

	*ctx = (struct cxl_chbs_context) {
		.uid = uid,
	};

> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
> +
> +	return 0;
> +}
> +
>  static int add_host_bridge_dport(struct device *match, void *arg)
>  {
>  	acpi_status rc;
> @@ -377,19 +393,15 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	if (!hb)
>  		return 0;
>  
> -	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> -	if (rc != AE_OK) {
> +	rc = cxl_get_chbs(hb, &ctx);
> +	if (rc == -ENOENT)
>  		dev_err(match, "unable to retrieve _UID\n");

Why not push that down into the cxl_get_chbs() where no special handling
of error code is needed?

> -		return -ENODEV;
> -	}
> +	if (rc)
> +		return rc;
>  
> +	uid = ctx.uid;
>  	dev_dbg(match, "UID found: %lld\n", uid);
>  
> -	ctx = (struct cxl_chbs_context) {
> -		.uid = uid,
> -	};
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
> -
>  	if (!ctx.base) {
>  		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
>  			 uid);
> @@ -405,12 +417,17 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	pci_root = acpi_pci_find_root(hb->handle);
>  	bridge = pci_root->bus->bridge;
>  
> +	/*
> +	 * In RCH mode, bind the component regs base to the dport. In
> +	 * VH mode it will be bound to the CXL host bridge's port
> +	 * object later in add_host_bridge_uport().
> +	 */
>  	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
>  		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.base);
>  		dport = devm_cxl_add_rch_dport(root_port, bridge, uid, ctx.base);
>  	} else {
> -		dev_dbg(match, "CHBCR found for UID %lld: %pa\n", uid, &ctx.base);
> -		dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.base);
> +		dport = devm_cxl_add_dport(root_port, bridge, uid,
> +					   CXL_RESOURCE_NONE);
>  	}
>  
>  	if (IS_ERR(dport))
> @@ -432,6 +449,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	struct cxl_dport *dport;
>  	struct cxl_port *port;
>  	struct device *bridge;
> +	struct cxl_chbs_context ctx;
> +	resource_size_t component_reg_phys;
>  	int rc;
>  
>  	if (!hb)
> @@ -450,12 +469,28 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> +	rc = cxl_get_chbs(hb, &ctx);
> +	if (rc)
> +		return rc;
> +
> +	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
> +		/* RCH mode, should never happen */
> +		return 0;
> +
> +	if (ctx.base)
> +		component_reg_phys = ctx.base;
> +	else
> +		component_reg_phys = CXL_RESOURCE_NONE;
> +
> +	if (component_reg_phys != CXL_RESOURCE_NONE)
> +		dev_dbg(match, "CHBCR found for UID %lld: %pa\n",
> +			ctx.uid, &component_reg_phys);

Why not put that in the block above?  Fine leaving it here if this
makes sense after further refactoring.

> +
>  	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
>  	if (rc)
>  		return rc;
>  
> -	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
> -				 dport);
> +	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
>  

