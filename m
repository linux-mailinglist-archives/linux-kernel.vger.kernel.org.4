Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1818E65753C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiL1KUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiL1KUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:20:05 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368721009
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672222789; bh=yaSeTGEOIHFUCNv85STZQEEdflntXgAfikFausxiyNQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=o3z6ig/mwe1pOTfipWIAixNbdYJreeh/1tjproiEss1amx8twidj1vIfz0kBOBGI5
         Ls2nklyGlBVyvBoE2DDdPfCs4J7wISFy5sk2h5NXxQ2gHSWQBtZMUdhJdBhIvZffQI
         RDQTnImemxjgbqNbN39kMmICZM+yhs6tNvZJOVbk=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 28 Dec 2022 11:19:49 +0100 (CET)
X-EA-Auth: HTwR0RTVn3jmTAnZvKty8PhPAQ09MjALLL2vXYUaBOtEbkvPSuYBqLA55Dc031s0qJx6Yu4fYJvUgMpUXgqC8wfLRY27uWCz
Date:   Wed, 28 Dec 2022 15:49:44 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v2] ARM/dma-mapping: use kvcalloc for fallback memory
 allocation need
Message-ID: <Y6wYQNvloBeW1oq4@qemulion>
References: <Y6HDwOyR23QPssRa@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6HDwOyR23QPssRa@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:46:32PM +0530, Deepak R Varma wrote:
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

Hello,
May I please request a review and feedback on this patch proposal?

Thank you,
./drv

> ---
>
> Changes in v2:
>    1. Update patch subject to use kvcalloc
>    2. Use kvcalloc instead of kvzalloc helper function. Revise the patch
>       proposal and the patch description accordingly.
>
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


