Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36BC719923
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjFAKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjFAKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:17:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BAA1FC0;
        Thu,  1 Jun 2023 03:14:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX23j5PWSz67MCd;
        Thu,  1 Jun 2023 18:11:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 11:13:29 +0100
Date:   Thu, 1 Jun 2023 11:13:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 01/23] cxl/acpi: Probe RCRB later during RCH
 downstream port creation
Message-ID: <20230601111328.00005620@Huawei.com>
In-Reply-To: <20230523232214.55282-2-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-2-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Tue, 23 May 2023 18:21:52 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> The RCRB is extracted already during ACPI CEDT table parsing while the
> data of this is needed not earlier than dport creation. This
> implementation comes with drawbacks: During ACPI table scan there is
> already MMIO access including mapping and unmapping, but only ACPI
> data should be collected here. The collected data must be transferred
> through a couple of interfaces until it is finally consumed when
> creating the dport. This causes complex data structures and function
> interfaces. Additionally, RCRB parsing will be extended to also
> extract AER data, it would be much easier do this at a later point
> during port and dport creation when the data structures are available
> to hold that data.
> 
> To simplify all that, probe the RCRB at a later point during RCH
> downstream port creation. Change ACPI table parser to only extract the
> base address of either the component registers or the RCRB. Parse and
> extract the RCRB in devm_cxl_add_rch_dport().
> 
> This is in preparation to centralize all RCRB scanning.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Hi,

Some comments inline, though one of them (about extensibility of CDAT
structures) applies just as much to the existing code so doesn't affect

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
for this patch.


> ---
>  drivers/cxl/acpi.c      | 52 ++++++++++++++++-------------------------
>  drivers/cxl/core/port.c | 21 +++++++++++++----
>  drivers/cxl/cxl.h       |  1 -
>  3 files changed, 36 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 7e1765b09e04..39227070da9b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -373,20 +373,18 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  }
>  
>  struct cxl_chbs_context {
> -	struct device *dev;
>  	unsigned long long uid;
> -	resource_size_t rcrb;
> -	resource_size_t chbcr;
> +	resource_size_t base;
>  	u32 cxl_version;
>  };
>  
> -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
>  			 const unsigned long end)
>  {
>  	struct cxl_chbs_context *ctx = arg;
>  	struct acpi_cedt_chbs *chbs;
>  
> -	if (ctx->chbcr)
> +	if (ctx->base)
>  		return 0;
>  
>  	chbs = (struct acpi_cedt_chbs *) header;
> @@ -395,23 +393,16 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  		return 0;
>  
>  	ctx->cxl_version = chbs->cxl_version;
> -	ctx->rcrb = CXL_RESOURCE_NONE;
> -	ctx->chbcr = CXL_RESOURCE_NONE;
> +	ctx->base = CXL_RESOURCE_NONE;
>  
>  	if (!chbs->base)
>  		return 0;
>  
> -	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11) {
> -		ctx->chbcr = chbs->base;

Trivial: This is a functional change and should be called out -
previously the base address was stashed even if the length test
fails, now it isn't. May make no difference because it was never used
if that's the case, but would be nice to still mention it in patch description.

Also, ACPI tables are designed to be extensible and I think that
applies to CDAT tables as well - so this code should not be
checking for a precise match, but rather that it is greater than
or equal to the size we will read from.


> +	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> +	    chbs->length != CXL_RCRB_SIZE)
>  		return 0;
> -	}

>  
> -	if (chbs->length != CXL_RCRB_SIZE)
> -		return 0;
> -
> -	ctx->rcrb = chbs->base;
> -	ctx->chbcr = cxl_rcrb_to_component(ctx->dev, chbs->base,
> -					   CXL_RCRB_DOWNSTREAM);
> +	ctx->base = chbs->base;
>  
>  	return 0;
>  }

