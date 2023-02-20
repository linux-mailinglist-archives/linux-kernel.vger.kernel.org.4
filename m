Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFAF69CF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBTObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjBTObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:31:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F1710AB2;
        Mon, 20 Feb 2023 06:31:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PL4VH47D8z6J7fc;
        Mon, 20 Feb 2023 22:26:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 20 Feb
 2023 14:31:13 +0000
Date:   Mon, 20 Feb 2023 14:31:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: dev_warn() on unsupported mixed mode decoder
Message-ID: <20230220143112.00005678@Huawei.com>
In-Reply-To: <20230218013834.31237-1-alison.schofield@intel.com>
References: <20230218013834.31237-1-alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Fri, 17 Feb 2023 17:38:34 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> A mixed mode decoder is programmed with device physical addresses
> that span both ram and pmem partitions of a memdev.
> 
> Linux does not support mixed mode decoders. The driver rejects
> sysfs writes that try to set decoder mode to mixed, and if a
> resource bieng allocated is not wholly contained in either the
> pmem or ram partition of a memdev, it is also rejected. Basically,
> the CXL region driver is not going to create regions with mixed
> mode decoders, but the BIOS could.
> 
> If the kernel driver sees the mixed mode decoder, it will fail to
> enable the region, and emit a dev_dbg() message.
> 
> A dev_dbg() is not noisy enough in this case. Change the message
> to be a dev_warn() that explicitly says mixed mode is not supported.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Makes sense.
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/hdm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 45deda18ed32..9eaf93c8ebb0 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -294,8 +294,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	else if (resource_contains(&cxlds->ram_res, res))
>  		cxled->mode = CXL_DECODER_RAM;
>  	else {
> -		dev_dbg(dev, "decoder%d.%d: %pr mixed\n", port->id,
> -			cxled->cxld.id, cxled->dpa_res);
> +		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> +			 port->id, cxled->cxld.id, cxled->dpa_res);
>  		cxled->mode = CXL_DECODER_MIXED;
>  	}
>  
> 
> base-commit: a5fcd228ca1db9810ba1ed461c90b6ee933b9daf

