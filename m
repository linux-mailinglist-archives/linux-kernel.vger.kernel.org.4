Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050636FC7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjEINZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEINZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:25:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B4C2D73;
        Tue,  9 May 2023 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KkqdRlUqTfle/lYv4ZxNsnZATjCjThA8plTsZKPzERM=; b=FBbYsSJDiapHHKmOXLJjPcHlfA
        2b7UFlLrJM2/KG1rwYBEUmutob3kdAzgoMniGXUUy1YL64qvbxmGBESnIi6KWBlf2AarPUfZJbMXe
        RHh/+6ovolYDesxApYaOOV69N4ZFqBugnidcCDrLCUp4zraIg/KphUf/AGLkmvco8LE0baHsiiIH5
        YCWKT7p4+J2kU+UA3Fe8u2WdLmCf2WdpkAzvBZrC0Iavymmc2vFlwT0aPizuD015Wxh06Yp8Gt485
        v1SifxO1pisxS8h2ksTNDhhQ4kt5S3ELar5M+ZwlwMPwExrn/2TwGxgF3I+IrQt1a+2O0zf6Lf7FH
        QXMfVEXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwNLa-003Ota-1B;
        Tue, 09 May 2023 13:25:42 +0000
Date:   Tue, 9 May 2023 06:25:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pasha.tatashin@soleen.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: usbdev_mmap causes type confusion in page_table_check
Message-ID: <ZFpJ1rs+XinCYfPs@infradead.org>
References: <000000000000258e5e05fae79fc1@google.com>
 <20230507135844.1231056-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507135844.1231056-1-lrh2000@pku.edu.cn>
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

On Sun, May 07, 2023 at 09:58:44PM +0800, Ruihan Li wrote:
> static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
> {
> 	// ...
> 	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
> 			&dma_handle);
> 	// ...
> 	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
> 		if (remap_pfn_range(vma, vma->vm_start,
> 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,

usb_alloc_coherent and up in the DMA coherent allocator (usually
anyway), and you absolutely must never do a virt_to_phys or virt_to_page
on that return value.  This code is a buggy as f**k.
