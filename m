Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA766FC863
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjEIOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjEIOBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800AB2D58;
        Tue,  9 May 2023 07:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02564646BA;
        Tue,  9 May 2023 14:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9BEC433D2;
        Tue,  9 May 2023 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683640866;
        bh=mj33fPqfFt4lD4T+X1wHRTl3U886tC9uw2mp+55gJvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moSfqhSOtlwaW3DesFw9Yd3yQt5Tk+EMUei/VbgLVPhXyhWvIb6o7+02NyLbqmfKK
         PmAYPR0Nygfx139UU9NT4Bz74V/nJIJZ80C6DpTJB0P4uDezHrtW4VPb3k74griyS1
         lZHYnvd9BAiGzXdE5/Lj9MJmlCifUAEpoDg7L+LA=
Date:   Tue, 9 May 2023 16:01:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pasha.tatashin@soleen.com,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: usbdev_mmap causes type confusion in page_table_check
Message-ID: <2023050934-launch-shifty-0bbb@gregkh>
References: <000000000000258e5e05fae79fc1@google.com>
 <20230507135844.1231056-1-lrh2000@pku.edu.cn>
 <ZFpJ1rs+XinCYfPs@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFpJ1rs+XinCYfPs@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 06:25:42AM -0700, Christoph Hellwig wrote:
> On Sun, May 07, 2023 at 09:58:44PM +0800, Ruihan Li wrote:
> > static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
> > {
> > 	// ...
> > 	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
> > 			&dma_handle);
> > 	// ...
> > 	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
> > 		if (remap_pfn_range(vma, vma->vm_start,
> > 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
> 
> usb_alloc_coherent and up in the DMA coherent allocator (usually
> anyway), and you absolutely must never do a virt_to_phys or virt_to_page
> on that return value.  This code is a buggy as f**k.

Odd, you gave it a reviewed-by: in commit a0e710a7def4 ("USB: usbfs: fix
mmap dma mismatch") back in 2020 when it was merged as you said that was
the way to fix this up.  :)

Do you have a better way to do it now that is more correct?  Did some
DMA changes happen that missed this codepath getting fixed up?

thanks,

gre gk-h
