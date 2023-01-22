Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2467722E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjAVUDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAVUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:03:00 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280E94C37
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674417770; bh=gQYpdNUvbpdt7S9VnvBLbbayL/I4Ccx9gS5MFpgDNlw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Ymn/hcxIq1w9+bjOQYhU7TnGyv8jw10NTXX3IoMdTMRjh0n9CHkcY4jBKI7KRX8v0
         UBCPfPPc3slPsVuQsIheDQUp9ytobRsJ11eEq1/GkE9KDZe5aesQu/Ha6Q4MgF9cBe
         dJ0xaQJRpUK16dft3lhj6wnbGZCWcai3pXxuhIFQ=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 21:02:50 +0100 (CET)
X-EA-Auth: 4cGvfQ07Bv1cZibYxMWoF0klLeid1awWQNctpJPioLhapGFkOFUSqVQpt55QVFIDF5HFJNSGgj6uyYTZd9PSooZgW3ItTXFJ
Date:   Mon, 23 Jan 2023 01:32:47 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v3] ARM/dma-mapping: use kvcalloc for fallback memory
 allocation need
Message-ID: <Y82WZwzocySE7a86@ubun2204.myguest.virtualbox.org>
References: <Y7QJ5rahtDBz2WNO@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7QJ5rahtDBz2WNO@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 04:26:38PM +0530, Deepak R Varma wrote:
> Current conditional determination of whether to use kzalloc or vzalloc
> has known issues such as "indefinite retry" when less than PAGE_SIZE
> memory is needed, but is unavailable. This LWN article [1] describes
> these issues in greater detail. Use helper function kvcalloc() instead
> which is more efficient in terms of performance and security.
> 
>  	[1] https://lwn.net/Articles/711653/
> 
> This patch proposal is based on following Coccinelle warning using the
> kvmalloc.cocci semantic patch.
> 	arch/arm/mm/dma-mapping.c:858:28-29: WARNING opportunity for kvmalloc
> 
> The semantic patch suggests using kvzalloc() helper function, however,
> this patch proposes to use kvcalloc instead. kvcalloc() helper function
> uses 2-factor argument form which is better from a security perspective
> as described in the following KSPP project commit.
> 
> 	Commit 4e3fd7217105 ("wireguard: ratelimiter: use kvcalloc() instead of kvzalloc()")
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v3:
>    1. Use updated maintainer list to send the patch.
>       Suggested by "Russell King (Oracle)" <linux@armlinux.org.uk>

Hello,
May I request a review and feedback comment on this patch proposal please?

Thank you,
./drv

> 
> Changes in v2:
>    1. Update patch subject to use kvcalloc
>    2. Use kvcalloc instead of kvzalloc helper function. Revise the patch
>       proposal and the patch description accordingly.
> 
>  arch/arm/mm/dma-mapping.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c135f6e37a00..35092ecd30e1 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -851,14 +851,10 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>  {
>  	struct page **pages;
>  	int count = size >> PAGE_SHIFT;
> -	int array_size = count * sizeof(struct page *);
>  	int i = 0;
>  	int order_idx = 0;
> 
> -	if (array_size <= PAGE_SIZE)
> -		pages = kzalloc(array_size, GFP_KERNEL);
> -	else
> -		pages = vzalloc(array_size);
> +	pages = kvcalloc(count, sizeof(struct page *), GFP_KERNEL);
>  	if (!pages)
>  		return NULL;
> 
> --
> 2.34.1
> 


