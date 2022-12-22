Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831C5653D29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiLVIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbiLVIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:50:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453726A83
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dOUwRecl7A2zD8gYlrrUSxjb8W4DwBivGT1G7NGZMEA=; b=COjMi5tBEGXXCeUCKH0jcI18mO
        W/UO8pS5kdDQfbW2+IrMbRBfiFQNml8i1OoM9e8IWN0o7Z1u6xR/JwJA1X581wd1J6N+vIEloDaWH
        IXd+2/qh/IsKESe66be2BHAePUhoVkfqfAHSQ0b0W98jVqTbc/R3mYXxPIuNT1sVmSgRD044n54aL
        NL9syzue84c1xPfM/gLScr2PaV9USuaksQLFAwY6YDhGluxHEWSASXwI+G8iDJX/QS/fRBnTPse60
        tqKnJ3vvHnFvSEVjErA6OL3HD9yC//mzMQ6/JDbcegljaL4mFGp5knyzIdlQkfKb8DFbtI6R/UaUz
        Kz3Kd/FQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8HHS-009Geu-74; Thu, 22 Dec 2022 08:50:22 +0000
Date:   Thu, 22 Dec 2022 00:50:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 2/3] mm: vmalloc: Switch to find_unlink_vmap_area() in
 vm_unmap_ram()
Message-ID: <Y6QaTqq8KXv3Dg7p@infradead.org>
References: <20221221174454.1085130-1-urezki@gmail.com>
 <20221221174454.1085130-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221174454.1085130-2-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Wed, Dec 21, 2022 at 06:44:53PM +0100, Uladzislau Rezki (Sony) wrote:
> Switch from find_vmap_area() to find_unlink_vmap_area() to prevent
> a double access to the vmap_area_lock: one for finding area, second
> time is for unlinking from a tree.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 28030d2441f1..17e688cc7357 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2251,7 +2251,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  		return;
>  	}
>  
> -	va = find_vmap_area(addr);
> +	va = find_unlink_vmap_area(addr);

I can't find find_unlink_vmap_area in current -next, but shouldn't
this also switch from free_vmap_area_noflush to something that
doesn't unlink from the list and avoid the lock?

In general the code could probably use a bit of refactoring to
split unmapping from freeing.
