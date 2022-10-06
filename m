Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A975F5D84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJFAID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJFAIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:08:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2729B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01246B81F67
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB950C433D6;
        Thu,  6 Oct 2022 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665014876;
        bh=EgI5M5TZ7BXqRvIKSX8CVCy28PNbu8v3l83emSft2nY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=O4ZbMxFbU6j4RmRFHUi23ZOJvwnBTO1TjieTJErvhUv7V94SIH4cmt/mCkLuw2vMI
         sL0l6ODgVeWmczm584ssbe6JPJ1Yu9yl6++jLUbVcXHP3S5eplE2u9SpHzmDlbvt9A
         eY3/0pTHSuSgBv/u3Us4DzIwLKm80l4m/0RydAXZI/UjJKsG81/jqTlzDbz6M4ikXp
         c4WGSEuLRRCZHaTCe7DCwZ1fd9WVc+MqndCcz4FDM0th3OyLf42l7Whwwjvsv/FR3W
         oM3SywnqeRJ+/WQYTt40Ki3DFWOT6E1tuCBXfib1jpi2cC38J4AiiGz3NbF44kQgKX
         o0EF/aJv/Cz0g==
Date:   Wed, 5 Oct 2022 17:07:53 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 1/2] xen/virtio: Fix n_pages calculation in
 xen_grant_dma_map(unmap)_page()
In-Reply-To: <20221005174823.1800761-2-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210051707380.3690179@ubuntu-linux-20-04-desktop>
References: <20221005174823.1800761-1-olekstysh@gmail.com> <20221005174823.1800761-2-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Take page offset into the account when calculating the number of pages
> to be granted.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Fixes: d6aca3504c7d ("xen/grant-dma-ops: Add option to restrict memory access under Xen")

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/grant-dma-ops.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 8973fc1e9ccc..1998d0e8ce82 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -153,7 +153,7 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
>  					 unsigned long attrs)
>  {
>  	struct xen_grant_dma_data *data;
> -	unsigned int i, n_pages = PFN_UP(size);
> +	unsigned int i, n_pages = PFN_UP(offset + size);
>  	grant_ref_t grant;
>  	dma_addr_t dma_handle;
>  
> @@ -185,7 +185,8 @@ static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>  				     unsigned long attrs)
>  {
>  	struct xen_grant_dma_data *data;
> -	unsigned int i, n_pages = PFN_UP(size);
> +	unsigned long offset = dma_handle & (PAGE_SIZE - 1);
> +	unsigned int i, n_pages = PFN_UP(offset + size);
>  	grant_ref_t grant;
>  
>  	if (WARN_ON(dir == DMA_NONE))
> -- 
> 2.25.1
> 
