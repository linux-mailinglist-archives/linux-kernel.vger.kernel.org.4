Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906D6FDE57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbjEJNRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjEJNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:17:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3583C76B7;
        Wed, 10 May 2023 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qrq/mo5VPvcpdlilPoSg0gpK2tGH3zsYjRUh/mtynI=; b=gmSUWcEluIFGMhZfnaqi0WCy5X
        OJgr05KExnaf9gouKQ1TppKOtz2Z8DoEXlWxa9wpktSaINvC4zvJiQrZmVmaalopDVm3Bd5iWFela
        mpyZFBWiiLjBK1sbsVsUjTbpV2S5xEKCfuuZRZ0z+1R+hCHAiOHhG2Kcj9LTOAtbOt2vydZPu6e3n
        VOK7CZ68w7qjIEZWoBQSl4XzBEWb68ojLa3Mqz4yXRmWCo6EHb/UcG9d6p4YGcdiSCiKT7rBM23Rt
        c3+yypyDmShq8RpReCxDAzb+DD6iNgk4QW18rz7qVlKoM1E16rt24k3LMw2YnPYA2Ns9sWBfyg9CT
        jke6Xmcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwjgq-006D1Y-0G;
        Wed, 10 May 2023 13:17:08 +0000
Date:   Wed, 10 May 2023 06:17:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pasha.tatashin@soleen.com,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: usbdev_mmap causes type confusion in page_table_check
Message-ID: <ZFuZVDcU81WmqEvJ@infradead.org>
References: <000000000000258e5e05fae79fc1@google.com>
 <20230507135844.1231056-1-lrh2000@pku.edu.cn>
 <ZFpJ1rs+XinCYfPs@infradead.org>
 <2023050934-launch-shifty-0bbb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023050934-launch-shifty-0bbb@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 04:01:02PM +0200, Greg KH wrote:
> > > 	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
> > > 			&dma_handle);
> > > 	// ...
> > > 	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
> > > 		if (remap_pfn_range(vma, vma->vm_start,
> > > 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
> > 
> > usb_alloc_coherent and up in the DMA coherent allocator (usually
> > anyway), and you absolutely must never do a virt_to_phys or virt_to_page
> > on that return value.  This code is a buggy as f**k.
> 
> Odd, you gave it a reviewed-by: in commit a0e710a7def4 ("USB: usbfs: fix
> mmap dma mismatch") back in 2020 when it was merged as you said that was
> the way to fix this up.  :)
> 
> Do you have a better way to do it now that is more correct?  Did some
> DMA changes happen that missed this codepath getting fixed up?

Sorry, I should not have shouted as quickly.  The code is clearly
guarded by the same conditional that makes it not use the DMA API,
so from the DMA API POV this is actually correct, just ugly.

The fix for the actual remap_file_ranges thing is probably something
like this:

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index fbb087b728dc98..be56eba2558814 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -131,7 +131,7 @@ void *hcd_buffer_alloc(
 	/* some USB hosts just use PIO */
 	if (!hcd_uses_dma(hcd)) {
 		*dma = ~(dma_addr_t) 0;
-		return kmalloc(size, mem_flags);
+		return (void *)__get_free_pages(get_order(size), mem_flags);
 	}
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
@@ -160,7 +160,7 @@ void hcd_buffer_free(
 	}
 
 	if (!hcd_uses_dma(hcd)) {
-		kfree(addr);
+		free_pages((unsigned long)addr, get_order(size));
 		return;
 	}
 
