Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0533A6A50FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjB1COc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1COa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:14:30 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E63599
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:14:29 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id f14so3476515iow.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2m+6sOh3dyXOUyiPoT4Lw8BzZfcrPOpFEQSJseXRAs=;
        b=FqL5p8OZ3DK2n3cd37DdQvhpw3wHvw2tkH20Z1KoftB7Id72i2VcBm30+8pcowdVmj
         qHmc0lf1BUoYpr1591cjLFWz3BXSbZV3iZLbco7NyfA8l/jhbpklOK09efaPtpxJZ6o8
         unNkX0Zd1NikKQP4NZdUJbChiSEN4rQVY+CRXmrIAYEtmGye7gxmYtgl5wT8+Y5IAWgl
         ObvndivndepZh4QtDZUBihQi1YarfrnVl3ioFoF8/DWR8xHMQRZGg96qhwWzspHKuGjs
         7RzzQQePnuhMiDlFv/TKz4B976ktQs+IwRr1L9HaUUxF9HiZtZFxjVcu7dnERH7v9sDY
         fSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2m+6sOh3dyXOUyiPoT4Lw8BzZfcrPOpFEQSJseXRAs=;
        b=3d3mJBqiaHQhnlapIRz1weiiMeRMp2b3+vNFaoyViA2oC0pI2jy+/+eDHl+sjLSYs/
         WHcOXVg9KUiEeNZeFrXmwFmYFjmkHQH+dK1YielgY7E1ik05eVvSqY8Do/Z9IjarqqvL
         ThfXBo/XoGnvEvjGHHlMyEFNe9L3J4sWqjGrfyeSDjAKvER+ecrWu+8Oe67iWomUZKkL
         Zc6+V69mhJCD0ag05EGj6ngZxXxdk0bpoRq+cotBGzI2HWb5ut0OpcJVvjdq1dNDZ137
         3POgJAK84CvhoNoGWTA0maNLeb1QuIlFBn7lJPM23tplCrty9oxs3rJ2L9d9Td+G7HC0
         VKsw==
X-Gm-Message-State: AO0yUKUGIxWD4Mzf8lA/HYJa5/ICoodNZ9uuLwYsbnyCmcRTyE2Q2aL9
        Mc852o1I6l/+vbNB9zBc82Q=
X-Google-Smtp-Source: AK7set/0bDq770mH9N02FdUqzvYx+uX2ctrnSx+SFLIYYrsE9WCTllIMtIIoOA0Ey4OdDiu6yy+GJQ==
X-Received: by 2002:a5d:840d:0:b0:74c:ae72:dc16 with SMTP id i13-20020a5d840d000000b0074cae72dc16mr1008687ion.5.1677550468323;
        Mon, 27 Feb 2023 18:14:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16-20020a056e02109000b00316ecc80a61sm2414581ilj.11.2023.02.27.18.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 18:14:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Feb 2023 18:14:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Keith Busch <kbusch@meta.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Message-ID: <20230228021426.GA3955867@roeck-us.net>
References: <20230221165400.1595247-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221165400.1595247-1-kbusch@meta.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:54:00AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some users of the dmapool need their allocations to happen in ascending
> order. The recent optimizations pushed the blocks in reverse order, so
> restore the previous behavior by linking the next available block from
> low-to-high.
> 
> Fixes: ced6d06a81fb69 ("dmapool: link blocks across pages")
> Reported-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

This patch fixes the problem I had observed when trying to boot from
the megasas SCSI controller on powernv.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  mm/dmapool.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index 1920890ff8d3d..a151a21e571b7 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -300,7 +300,7 @@ EXPORT_SYMBOL(dma_pool_create);
>  static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
>  {
>  	unsigned int next_boundary = pool->boundary, offset = 0;
> -	struct dma_block *block;
> +	struct dma_block *block, *first = NULL, *last = NULL;
>  
>  	pool_init_page(pool, page);
>  	while (offset + pool->size <= pool->allocation) {
> @@ -311,11 +311,22 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
>  		}
>  
>  		block = page->vaddr + offset;
> -		pool_block_push(pool, block, page->dma + offset);
> +		block->dma = page->dma + offset;
> +		block->next_block = NULL;
> +
> +		if (last)
> +			last->next_block = block;
> +		else
> +			first = block;
> +		last = block;
> +
>  		offset += pool->size;
>  		pool->nr_blocks++;
>  	}
>  
> +	last->next_block = pool->next_block;
> +	pool->next_block = first;
> +
>  	list_add(&page->page_list, &pool->page_list);
>  	pool->nr_pages++;
>  }
> -- 
> 2.30.2
> 
> 
