Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564C0603B33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJSINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJSINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:13:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214407B7A4;
        Wed, 19 Oct 2022 01:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0516B8229C;
        Wed, 19 Oct 2022 08:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE54AC433C1;
        Wed, 19 Oct 2022 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666167209;
        bh=grMsjd15672MfK3WGgOcqlJzZx9mIPlajFH6LUT3LyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjVAr0Il58bIZWLUGi0rCHF+ypPJCVywSKez1JCpU5/aREb1O+c1fsOY9WMqJTng8
         6pK155IBfsEku8Mk2Sji4JfTbBKqV5//ZymA9ALU95IuYmUcT3skEtAxWW1pAMl3za
         crMcr8Tei9jvrqVmx7LlXij/WR1dNi0XlnPExfHhhuU1omNyFzl4Ae2CCQ8Dd5OPKO
         HOF+HCIy2CL4K8aXeplRwMGsEIYUOvvRzzgZbQouWWIxvKWpeVXaAbneQ86brhiXBZ
         50ZM3naXT9wqbwGhu5qMyyF2JkdcdCmbFF9h0L67NdjCtUFDB6pBMivaGFKZz8ZNvJ
         5ZeclOi1xCxKA==
Date:   Wed, 19 Oct 2022 10:13:23 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     rafael@kernel.org, lvjianmin@loongson.cn, yangyicong@huawei.com,
        chenhuacai@loongson.cn, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org,
        jeremy.linton@arm.com
Subject: Re: [PATCH] ACPI: scan: Fix DMA range assignment
Message-ID: <Y0+xo2DO+M1iJc77@lpieralisi>
References: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:14:04PM +0100, Robin Murphy wrote:
> Assigning the device's dma_range_map from the iterator variable after
> the loop means it always points to the empty terminator at the end of
> the map, which is not what we want. Similarly, freeing the iterator on
> error when it points to somwhere in the middle of the allocated array
> won't work either. Fix this.
> 
> Fixes: bf2ee8d0c385 ("ACPI: scan: Support multiple DMA windows with different offsets")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/scan.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

A quick comment below, otherwise:

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 558664d169fc..024cc373a197 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1509,9 +1509,12 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>  			goto out;
>  		}
>  
> +		*map = r;

I wonder whether having a local variable to stash the base pointer
would make code easier to read (so that we avoid using *map for that
purpose and also to return the array to the caller).

Thanks for fixing it so promptly.

Lorenzo

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
> -- 
> 2.36.1.dirty
> 
