Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31D716A94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjE3RNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjE3RNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F3EA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685466779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XA7kTwQFWkusxdUrUJ42PHbG7/6n1MWIHbwCRsAO7Gk=;
        b=HfVtWqhqwxRe6DMOVX6eNeEKSpuxhJsAgml00r5NAJpnvBiUjCj2idHs26ZqgSq7D5WM+G
        l75WV4JjGFFhCREld4Z96Kn3yeyApoCLsM2zcfoLibA8lieRg5NG0Agf7WCD1c+1SdDt48
        a43bTwwxHvgOp8a+Xxt+AVJuuuYwUik=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-tGv1dI6tNvC5yj77WEWALg-1; Tue, 30 May 2023 13:12:58 -0400
X-MC-Unique: tGv1dI6tNvC5yj77WEWALg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f80c446cdeso28694381cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466777; x=1688058777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA7kTwQFWkusxdUrUJ42PHbG7/6n1MWIHbwCRsAO7Gk=;
        b=ZSJykdzGRT4csRZ1Bh1FCzr59rDPu+Z/Vukel/3j1SgT453rCP08Z5Z8KwE9Rpu9oL
         +nzWKxlDPmS3d9QtIgM7kC+76MN00yjmjgLESd3AEUiyN4LVrCFAcTYWZ7fccScThdxJ
         P43YoJv1lxU+R7kobr6zfu9cuIjn4YZTIQSloOQmNOWpcL/IG/P8IIthIv8hnfZsZ9I/
         VQuH7NzRqeA1HyEpQHy3vzZ30O9ogFajNiOzt8j1bmPLCGIpUDIy5MwpGzQax7lBfwFn
         2FaJP66UQjBAFWYyPoFFE3LwGJ61++gzRY8wdOdtQL8LLDwacIX7uNKon4hR3TofjPax
         k0MA==
X-Gm-Message-State: AC+VfDwiIsH+43KZafK46j2eMKz9NK4QSc/wZIdUaWKjfmtpqjPXLa4u
        ZqwCNzEpjQq7dMwMDpIlkUzIjbRxyXhxMTFFCp7G+6dlPEJ94NHOtwCv+MgHh7ZwacGcbB3FvB+
        v2nP/O4D+KinbJPPZ21J+Uso1
X-Received: by 2002:a05:622a:174d:b0:3f4:f1be:557 with SMTP id l13-20020a05622a174d00b003f4f1be0557mr3131662qtk.1.1685466777332;
        Tue, 30 May 2023 10:12:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qwgDWrkXZfO0XXI4rNB+nmQ4QAL5V50cC0Yr+i5N2M5STCwfndfEKWLAKtvbQpD9izUPdKg==
X-Received: by 2002:a05:622a:174d:b0:3f4:f1be:557 with SMTP id l13-20020a05622a174d00b003f4f1be0557mr3131640qtk.1.1685466777094;
        Tue, 30 May 2023 10:12:57 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p9-20020a05622a048900b003e1cf472b17sm4800652qtx.97.2023.05.30.10.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:12:56 -0700 (PDT)
Date:   Tue, 30 May 2023 10:12:54 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com
Subject: Re: [PATCH] dma-mapping: Name SG DMA flag helpers consistently
Message-ID: <jsgp55bzui7af7hvaa2hvbhgvqqe3qe7qtaiqu4xdndmgw5zpm@yt3bspzckv4t>
References: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 06:46:31PM +0100, Robin Murphy wrote:
> sg_is_dma_bus_address() is inconsistent with the naming pattern of its
> corresponding setters and its own kerneldoc, so take the majority vote
> and rename it sg_dma_is_bus_address() (and fix up the missing
> underscores in the kerneldoc too). This gives us a nice clear pattern
> where SG DMA flags are SG_DMA_<NAME>, and the helpers for acting on them
> are sg_dma_<action>_<name>().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/dma-iommu.c   | 8 ++++----
>  drivers/iommu/iommu.c       | 2 +-
>  include/linux/scatterlist.h | 8 ++++----
>  kernel/dma/direct.c         | 2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7a9f0b0bddbd..b8bba4aa196f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1080,7 +1080,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		sg_dma_address(s) = DMA_MAPPING_ERROR;
>  		sg_dma_len(s) = 0;
>  
> -		if (sg_is_dma_bus_address(s)) {
> +		if (sg_dma_is_bus_address(s)) {
>  			if (i > 0)
>  				cur = sg_next(cur);
>  
> @@ -1136,7 +1136,7 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
>  	int i;
>  
>  	for_each_sg(sg, s, nents, i) {
> -		if (sg_is_dma_bus_address(s)) {
> +		if (sg_dma_is_bus_address(s)) {
>  			sg_dma_unmark_bus_address(s);
>  		} else {
>  			if (sg_dma_address(s) != DMA_MAPPING_ERROR)
> @@ -1329,7 +1329,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  	 * just have to be determined.
>  	 */
>  	for_each_sg(sg, tmp, nents, i) {
> -		if (sg_is_dma_bus_address(tmp)) {
> +		if (sg_dma_is_bus_address(tmp)) {
>  			sg_dma_unmark_bus_address(tmp);
>  			continue;
>  		}
> @@ -1343,7 +1343,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  
>  	nents -= i;
>  	for_each_sg(tmp, tmp, nents, i) {
> -		if (sg_is_dma_bus_address(tmp)) {
> +		if (sg_dma_is_bus_address(tmp)) {
>  			sg_dma_unmark_bus_address(tmp);
>  			continue;
>  		}
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..eb620552967b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2567,7 +2567,7 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>  			len = 0;
>  		}
>  
> -		if (sg_is_dma_bus_address(sg))
> +		if (sg_dma_is_bus_address(sg))
>  			goto next;
>  
>  		if (len) {
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 375a5e90d86a..d1ed52d083da 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -259,7 +259,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>  #define SG_DMA_BUS_ADDRESS (1 << 0)
>  
>  /**
> - * sg_dma_is_bus address - Return whether a given segment was marked
> + * sg_dma_is_bus_address - Return whether a given segment was marked
>   *			   as a bus address
>   * @sg:		 SG entry
>   *
> @@ -267,13 +267,13 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   *   Returns true if sg_dma_mark_bus_address() has been called on
>   *   this segment.
>   **/
> -static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
> +static inline bool sg_dma_is_bus_address(struct scatterlist *sg)
>  {
>  	return sg->dma_flags & SG_DMA_BUS_ADDRESS;
>  }
>  
>  /**
> - * sg_dma_mark_bus address - Mark the scatterlist entry as a bus address
> + * sg_dma_mark_bus_address - Mark the scatterlist entry as a bus address
>   * @sg:		 SG entry
>   *
>   * Description:
> @@ -301,7 +301,7 @@ static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
>  
>  #else
>  
> -static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
> +static inline bool sg_dma_is_bus_address(struct scatterlist *sg)
>  {
>  	return false;
>  }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 5595d1d5cdcc..d29cade048db 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -463,7 +463,7 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  	int i;
>  
>  	for_each_sg(sgl,  sg, nents, i) {
> -		if (sg_is_dma_bus_address(sg))
> +		if (sg_dma_is_bus_address(sg))
>  			sg_dma_unmark_bus_address(sg);
>  		else
>  			dma_direct_unmap_page(dev, sg->dma_address,
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

