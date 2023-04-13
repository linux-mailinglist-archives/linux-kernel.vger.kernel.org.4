Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2000D6E14A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDMSwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDMSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:52:50 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B5AFA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:52:48 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id B4FCF150E63;
        Thu, 13 Apr 2023 20:52:45 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1681411965; bh=T3J6sKps25KKWmuAgEarvwY0olnBOLjyVBhRaYTbnfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0k3lIFnhSDnMBra+p1TD+bRXV2Vxpt3FEsvSM+SUokyQrBmm6dzPq3prZGEKrEmWk
         bYLlIR1RL/p3poOVU7K5qiHWuCke1r9rjbuZhiMeqfLesccMelbNg1U5BBJeV/hhly
         mg5ub3TCp7u3I3H9mp94H/GidUMraw/7VwzkI3SdorTAfv68jd0A0CvBkUbOHyJI/7
         cVUZK4j4bgOFK7qoyFBkhl/4wINI7GRh2YpKxxB9cdvOhsgJcw1XPwnr8kBkU2GMpM
         w/ejQ9To4eDjF16fayze5YUCsIWfMuQyEH5BvkX5aE02C4B5/exAgTns1vLNjd5l73
         F9dK1QnMA92HA==
Date:   Thu, 13 Apr 2023 20:52:44 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com,
        petr.tesarik.ext@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] swiotlb: Fix debugfs reporting of reserved memory
 pools
Message-ID: <20230413205244.70dcbdeb@meshulam.tesarici.cz>
In-Reply-To: <1681400250-2032-1-git-send-email-mikelley@microsoft.com>
References: <1681400250-2032-1-git-send-email-mikelley@microsoft.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 08:37:30 -0700
Michael Kelley <mikelley@microsoft.com> wrote:

> For io_tlb_nslabs, the debugfs code reports the correct value for a
> specific reserved memory pool.  But for io_tlb_used, the value reported
> is always for the default pool, not the specific reserved pool. Fix this.
> 
> Fixes: 5c850d31880e ("swiotlb: fix passing local variable to debugfs_create_ulong()")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> I don't have a way to test this directly with OF reserved memory, but I
> cobbled together a hack to call rmem_swiotlb_device_init() multiple times
> for different size reserved pools. I verified that reserved pool debugfs entries
> are created as expected and that the value of io_tlb_used is *not* the value
> from the default pool.

Yeah, the only in-tree user is Mediatek Asurada, and I don't have one
either...

The patch looks good to me. But you know, I'm now well-known for
breaking things because of insufficient testing. ;-)

Petr T

>  kernel/dma/swiotlb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index dac42a2..db43de82 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -930,7 +930,9 @@ bool is_swiotlb_active(struct device *dev)
>  
>  static int io_tlb_used_get(void *data, u64 *val)
>  {
> -	*val = mem_used(&io_tlb_default_mem);
> +	struct io_tlb_mem *mem = data;
> +
> +	*val = mem_used(mem);
>  	return 0;
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL,
> "%llu\n"); @@ -943,7 +945,7 @@ static void
> swiotlb_create_debugfs_files(struct io_tlb_mem *mem, return;
>  
>  	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs,
> &mem->nslabs);
> -	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, NULL,
> +	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, mem,
>  			&fops_io_tlb_used);
>  }
>  

