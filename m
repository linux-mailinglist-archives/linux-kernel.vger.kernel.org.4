Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A16037E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJSCHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJSCHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:07:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735D16C77B;
        Tue, 18 Oct 2022 19:07:36 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MsYvq0JBGzJn3c;
        Wed, 19 Oct 2022 10:04:55 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:07:33 +0800
CC:     <yangyicong@hisilicon.com>, <lvjianmin@loongson.cn>,
        <lpieralisi@kernel.org>, <chenhuacai@loongson.cn>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lenb@kernel.org>, <jeremy.linton@arm.com>
Subject: Re: [PATCH] ACPI: scan: Fix DMA range assignment
To:     Robin Murphy <robin.murphy@arm.com>, <rafael@kernel.org>
References: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <05cb83dd-76e8-d12c-957e-90fe930d03de@huawei.com>
Date:   Wed, 19 Oct 2022 10:07:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 21:14, Robin Murphy wrote:
> Assigning the device's dma_range_map from the iterator variable after
> the loop means it always points to the empty terminator at the end of
> the map, which is not what we want. Similarly, freeing the iterator on
> error when it points to somwhere in the middle of the allocated array
> won't work either. Fix this.
> 
> Fixes: bf2ee8d0c385 ("ACPI: scan: Support multiple DMA windows with different offsets")

Thanks for fixing this. Works on my platform.

Tested-by: Yicong Yang <yangyicong@hisilicon.com>

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/scan.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 558664d169fc..024cc373a197 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1509,9 +1509,12 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>  			goto out;
>  		}
>  
> +		*map = r;
> +
>  		list_for_each_entry(rentry, &list, node) {
>  			if (rentry->res->start >= rentry->res->end) {
> -				kfree(r);
> +				kfree(*map);
> +				*map = NULL;
>  				ret = -EINVAL;
>  				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>  				goto out;
> @@ -1523,8 +1526,6 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>  			r->offset = rentry->offset;
>  			r++;
>  		}
> -
> -		*map = r;
>  	}
>   out:
>  	acpi_dev_free_resource_list(&list);
> 
