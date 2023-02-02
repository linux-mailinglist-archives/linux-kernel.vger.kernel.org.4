Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC05C68851F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjBBRJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBBRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:09:17 -0500
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264131E37;
        Thu,  2 Feb 2023 09:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=FgJ1MpEAedxgRW92zU8Oq1Rlz5dibZ2q/uh+lDC8C1s=; b=K3ceqWXBPGBOcpnSN5X9Yy12pi
        mYF++2H/Ro6jIt+ddYjdDxkr8ZWQrwxhwMLM5n2ngKS0qO7TUDyHiW04c35b2jRT/ljeX/NRZoDCz
        sXchYBAIgR84pgLmNwOGGiJQcdozeg5zYkLzmMRGWPgkhhbctfgKAth9o8+KJg9KehddYdrWP/QGH
        SJBgq9zLSeSHaRLWh7li+I73/iGIp0f1T5icwCEegART9hrIC0wbETcZMuqLzmS3aR+x5yg7mEen0
        +rrXqRgBAp7wwIqCmXq/Y8/PcevVy8++7v7LMPdaWOusGh0nz5iL3mIthh0dTI9eaFnsRZZUPlTKO
        r89C3y+w==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1pNd53-001lSA-FT; Thu, 02 Feb 2023 17:09:01 +0000
Date:   Thu, 2 Feb 2023 17:09:01 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux.dev, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression: v4l/bttv vbi vs iommu
Message-ID: <Y9vuLV+dQM/MpyWv@gallifrey>
References: <Y9qSwkLxeMpffZK/@gallifrey>
 <20230202100926.GA14931@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230202100926.GA14931@lst.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 17:04:19 up 328 days,  3:30,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@lst.de) wrote:
> On Wed, Feb 01, 2023 at 04:26:42PM +0000, Dr. David Alan Gilbert wrote:
> > f5ff79fddf0efecca538046b5cc20fb3ded2ec4f is the first bad commit
> > commit f5ff79fddf0efecca538046b5cc20fb3ded2ec4f
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Sat Feb 26 16:40:21 2022 +0100
> > 
> >     dma-mapping: remove CONFIG_DMA_REMAP

Hi Christoph,
  Thanks for having a look.

> Which just enabled some code on common x86 configs that was already
> used on many other platforms.  In other words:  the code already
> was buggy, but got away with it on x86 so far as no one tested on
> e.g. arm or arm64.

I guess most of these are older PCI devices (that are on the older
v4l api), and there were never a huge number of arm boxes with
parallel PCI, and the ones that there were became even rarer
by 2014 when this code was added.

> The bug is in videobuf_dma_init_kernel:
> 
> 	for (i = 0; i < nr_pages; i++) {
> 		void *addr;
> 
> 		addr = dma_alloc_coherent(dma->dev, PAGE_SIZE,
> 					  &(dma->dma_addr[i]), GFP_KERNEL);
> 		if (addr == NULL)
> 			goto out_free_pages;
> 
> 		dma->vaddr_pages[i] = virt_to_page(addr);
> 	}
> 	dma->vaddr = vmap(dma->vaddr_pages, nr_pages, VM_MAP | VM_IOREMAP,
> 			  PAGE_KERNEL);
> 
> The address by dma_alloc_coherent is just a kernel virtual address,
> and virt_to_page must not be used on it as it could be vmalloc (as in
> this case) or various other really odd forms of memory.

OK, so at least why we know it's broken, the temporary work around
for most is turning the iommu off, and the long term fix is the new
API.

Thanks,

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
