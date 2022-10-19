Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21695603739
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJSAms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJSAmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:42:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F85B9AF9B;
        Tue, 18 Oct 2022 17:42:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CBEB1042;
        Tue, 18 Oct 2022 17:42:47 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 238213F792;
        Tue, 18 Oct 2022 17:42:40 -0700 (PDT)
Message-ID: <a63cddd8-b9d3-2bd7-1965-8cd974511678@arm.com>
Date:   Tue, 18 Oct 2022 19:41:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ACPI: scan: Fix DMA range assignment
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, rafael@kernel.org
Cc:     lvjianmin@loongson.cn, yangyicong@huawei.com,
        lpieralisi@kernel.org, chenhuacai@loongson.cn,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org
References: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/18/22 08:14, Robin Murphy wrote:
> Assigning the device's dma_range_map from the iterator variable after
> the loop means it always points to the empty terminator at the end of
> the map, which is not what we want. Similarly, freeing the iterator on
> error when it points to somwhere in the middle of the allocated array
> won't work either. Fix this.

This fixes the boot problem on both SoC generations of the rpi4+ACPI,

Thanks,

Tested-by: Jeremy Linton <jeremy.linton@arm.com>

> 
> Fixes: bf2ee8d0c385 ("ACPI: scan: Support multiple DMA windows with different offsets")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/acpi/scan.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 558664d169fc..024cc373a197 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1509,9 +1509,12 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   			goto out;
>   		}
>   
> +		*map = r;
> +
>   		list_for_each_entry(rentry, &list, node) {
>   			if (rentry->res->start >= rentry->res->end) {
> -				kfree(r);
> +				kfree(*map);
> +				*map = NULL;
>   				ret = -EINVAL;
>   				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>   				goto out;
> @@ -1523,8 +1526,6 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   			r->offset = rentry->offset;
>   			r++;
>   		}
> -
> -		*map = r;
>   	}
>    out:
>   	acpi_dev_free_resource_list(&list);

