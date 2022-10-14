Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79225FE679
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJNBLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJNBLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:11:15 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE7912B35B;
        Thu, 13 Oct 2022 18:11:12 -0700 (PDT)
Message-ID: <e8509e11-3a40-09ba-330e-1e8371eac323@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665709870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxNGLneyLXiEIftrmWJ7UR9IFJikkY+SVPP4K4jC414=;
        b=AQcOVBmmnWzup8jej9bMok8KskVHNuJTxaJ5yoetWfZH6A1UApc8jvAxMXhruVHWkTERJJ
        vErOe0yRFjEkQbGatCDV58uqb3MI3FXFUAO58yf/+dMGYHjve1ts/3EMOesOkyP1Zjb/2C
        B3tFEnJpjT/3KWiMgNDRsyaEsIYLcrE=
Date:   Thu, 13 Oct 2022 19:11:06 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] md/bitmap: Add chunk-threshold unplugging
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
References: <20221013224151.300-1-jonathan.derrick@linux.dev>
 <20221013224151.300-2-jonathan.derrick@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20221013224151.300-2-jonathan.derrick@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2022 4:41 PM, Jonathan Derrick wrote:
> Add a mechanism to allow bitmap unplugging and flushing to wait until it
> has surpassed a defined threshold of dirty chunks. This allows certain
> high I/O write workloads to make good forward progress between bitmap
> updates or provide reliable bitmap consistency. The default behavior is
> previous behavior of always unplugging when called.
> 
> Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> ---
>  drivers/md/md-bitmap.c | 35 +++++++++++++++++++++++++++++++----
>  drivers/md/md-bitmap.h |  1 +
>  drivers/md/md.h        |  1 +
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index bf6dffadbe6f..c5c77f8371a8 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1004,7 +1004,7 @@ static int md_bitmap_file_test_bit(struct bitmap *bitmap, sector_t block)
>  /* this gets called when the md device is ready to unplug its underlying
>   * (slave) device queues -- before we let any writes go down, we need to
>   * sync the dirty pages of the bitmap file to disk */
> -void md_bitmap_unplug(struct bitmap *bitmap)
> +static void __md_bitmap_unplug(struct bitmap *bitmap)
>  {
>  	unsigned long i;
>  	int dirty, need_write;
> @@ -1038,6 +1038,33 @@ void md_bitmap_unplug(struct bitmap *bitmap)
>  	if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags))
>  		md_bitmap_file_kick(bitmap);
>  }
> +
> +/*
> + * Conditional unplug based on user-defined parameter
> + * Defaults to unconditional behavior
> + */
> +void md_bitmap_unplug(struct bitmap *bitmap)
> +{
> +	unsigned int flush_threshold = bitmap->mddev->bitmap_info.flush_threshold;
> +
> +	if (!flush_threshold) {
> +		__md_bitmap_unplug(bitmap);
> +	} else {
> +		struct bitmap_page *bp = bitmap->counts.bp;
> +		unsigned long pages = bitmap->counts.pages;
> +		unsigned long k, count = 0;
> +
> +		for (k = 0; k < pages; k++)
> +			if (bp[k].map && !bp[k].hijacked)
> +				count += bp[k].count;
> +
> +		if (count - bitmap->unplugged_count > flush_threshold) {
> +			bitmap->unplugged_count = count;
> +			md_bitmap_daemon_work(&bitmap->mddev->daemon_timer);
I just noticed I call daemon_timer before adding it in 3/3
I'll fix that in v3

> +			__md_bitmap_unplug(bitmap);
> +		}
> +	}
> +}
>  EXPORT_SYMBOL(md_bitmap_unplug);
>  
>  static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t offset, int needed);
> @@ -2012,9 +2039,9 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
>  		for (i = 0; i < bitmap->storage.file_pages; i++)
>  			if (test_page_attr(bitmap, i, BITMAP_PAGE_PENDING))
>  				set_page_attr(bitmap, i, BITMAP_PAGE_NEEDWRITE);
> -		md_bitmap_unplug(bitmap);
> +		__md_bitmap_unplug(bitmap);
>  	}
> -	md_bitmap_unplug(mddev->bitmap);
> +	__md_bitmap_unplug(mddev->bitmap);
>  	*low = lo;
>  	*high = hi;
>  	md_bitmap_free(bitmap);
> @@ -2246,7 +2273,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
>  	spin_unlock_irq(&bitmap->counts.lock);
>  
>  	if (!init) {
> -		md_bitmap_unplug(bitmap);
> +		__md_bitmap_unplug(bitmap);
>  		bitmap->mddev->pers->quiesce(bitmap->mddev, 0);
>  	}
>  	ret = 0;
> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> index cfd7395de8fd..49a93d8ff307 100644
> --- a/drivers/md/md-bitmap.h
> +++ b/drivers/md/md-bitmap.h
> @@ -223,6 +223,7 @@ struct bitmap {
>  	unsigned long daemon_lastrun; /* jiffies of last run */
>  	unsigned long last_end_sync; /* when we lasted called end_sync to
>  				      * update bitmap with resync progress */
> +	unsigned long unplugged_count; /* last dirty count from md_bitmap_unplug */
>  
>  	atomic_t pending_writes; /* pending writes to the bitmap file */
>  	wait_queue_head_t write_wait;
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index b4e2d8b87b61..1a558cb18bd4 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -501,6 +501,7 @@ struct mddev {
>  		int			external;
>  		int			nodes; /* Maximum number of nodes in the cluster */
>  		char                    cluster_name[64]; /* Name of the cluster */
> +		unsigned int		flush_threshold; /* how many dirty chunks between updates */
>  	} bitmap_info;
>  
>  	atomic_t			max_corr_read_errors; /* max read retries */
