Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E933273B8CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjFWNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFWNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:30:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B62688;
        Fri, 23 Jun 2023 06:30:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QndMK29Prz6GD5l;
        Fri, 23 Jun 2023 21:27:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Jun
 2023 14:30:12 +0100
Date:   Fri, 23 Jun 2023 14:30:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v7 27/27] cxl/core/regs: Rename phys_addr in
 cxl_map_component_regs()
Message-ID: <20230623143011.00007076@Huawei.com>
In-Reply-To: <20230622205523.85375-28-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
        <20230622205523.85375-28-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 15:55:23 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> Trivial change that renames variable phys_addr in
> cxl_map_component_regs() to shorten its length to keep the 80 char
> size limit for the line and also for consistency between the different
> paths.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Fair enough on consistency side.  I don't care about being just over 80 chars :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/regs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 982ef79670c7..ba351a887040 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -216,16 +216,16 @@ int cxl_map_component_regs(struct cxl_register_map *map,
>  
>  	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
>  		struct mapinfo *mi = &mapinfo[i];
> -		resource_size_t phys_addr;
> +		resource_size_t addr;
>  		resource_size_t length;
>  
>  		if (!mi->rmap->valid)
>  			continue;
>  		if (!test_bit(mi->rmap->id, &map_mask))
>  			continue;
> -		phys_addr = map->resource + mi->rmap->offset;
> +		addr = map->resource + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> +		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
>  		if (!*(mi->addr))
>  			return -ENOMEM;
>  	}

