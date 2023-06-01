Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C2719A38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjFAKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjFAKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:54:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F302F2;
        Thu,  1 Jun 2023 03:54:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX2zN4Smcz67Ph9;
        Thu,  1 Jun 2023 18:53:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 11:54:48 +0100
Date:   Thu, 1 Jun 2023 11:54:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 06/23] cxl/acpi: Moving add_host_bridge_uport()
 around
Message-ID: <20230601115447.000055e6@Huawei.com>
In-Reply-To: <20230523232214.55282-7-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-7-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Tue, 23 May 2023 18:21:57 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> Just moving code to reorder functions to later share cxl_get_chbs()
> with add_host_bridge_uport().
> 
> This makes changes in the next patch visible. No other changes at all.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Given it's just a move FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c | 90 +++++++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 39227070da9b..4fd9fe32f830 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -327,51 +327,6 @@ __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
>  	return NULL;
>  }
>  
> -/*
> - * A host bridge is a dport to a CFMWS decode and it is a uport to the
> - * dport (PCIe Root Ports) in the host bridge.
> - */
> -static int add_host_bridge_uport(struct device *match, void *arg)
> -{
> -	struct cxl_port *root_port = arg;
> -	struct device *host = root_port->dev.parent;
> -	struct acpi_device *hb = to_cxl_host_bridge(host, match);
> -	struct acpi_pci_root *pci_root;
> -	struct cxl_dport *dport;
> -	struct cxl_port *port;
> -	struct device *bridge;
> -	int rc;
> -
> -	if (!hb)
> -		return 0;
> -
> -	pci_root = acpi_pci_find_root(hb->handle);
> -	bridge = pci_root->bus->bridge;
> -	dport = cxl_find_dport_by_dev(root_port, bridge);
> -	if (!dport) {
> -		dev_dbg(host, "host bridge expected and not found\n");
> -		return 0;
> -	}
> -
> -	if (dport->rch) {
> -		dev_info(bridge, "host supports CXL (restricted)\n");
> -		return 0;
> -	}
> -
> -	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
> -	if (rc)
> -		return rc;
> -
> -	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
> -				 dport);
> -	if (IS_ERR(port))
> -		return PTR_ERR(port);
> -
> -	dev_info(bridge, "host supports CXL\n");
> -
> -	return 0;
> -}
> -
>  struct cxl_chbs_context {
>  	unsigned long long uid;
>  	resource_size_t base;
> @@ -464,6 +419,51 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	return 0;
>  }
>  
> +/*
> + * A host bridge is a dport to a CFMWS decode and it is a uport to the
> + * dport (PCIe Root Ports) in the host bridge.
> + */
> +static int add_host_bridge_uport(struct device *match, void *arg)
> +{
> +	struct cxl_port *root_port = arg;
> +	struct device *host = root_port->dev.parent;
> +	struct acpi_device *hb = to_cxl_host_bridge(host, match);
> +	struct acpi_pci_root *pci_root;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	struct device *bridge;
> +	int rc;
> +
> +	if (!hb)
> +		return 0;
> +
> +	pci_root = acpi_pci_find_root(hb->handle);
> +	bridge = pci_root->bus->bridge;
> +	dport = cxl_find_dport_by_dev(root_port, bridge);
> +	if (!dport) {
> +		dev_dbg(host, "host bridge expected and not found\n");
> +		return 0;
> +	}
> +
> +	if (dport->rch) {
> +		dev_info(bridge, "host supports CXL (restricted)\n");
> +		return 0;
> +	}
> +
> +	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
> +	if (rc)
> +		return rc;
> +
> +	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
> +				 dport);
> +	if (IS_ERR(port))
> +		return PTR_ERR(port);
> +
> +	dev_info(bridge, "host supports CXL\n");
> +
> +	return 0;
> +}
> +
>  static int add_root_nvdimm_bridge(struct device *match, void *data)
>  {
>  	struct cxl_decoder *cxld;

