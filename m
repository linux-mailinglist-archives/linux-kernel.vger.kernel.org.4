Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58248654D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiLWIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbiLWIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:21:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9223F34D2E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O4FuGc97E/9yF2FvsvebSSi8vDaekl1kBRy8Km56N3c=; b=3qgbEKZDXAqmEavFKivByD5rN8
        uPtjcmZ1BEJzE1/Ut0mhxg0mEj1IDScC+8c9zRg09ExE0Cjz3EJ3vUHSTUp0z00UBoXOU2unRO8J+
        FPuh3SB5/TwY5/9xF61oIhRj7qsd8puDZWB14KaSk16aCP2xIXj7FodNf+RgCidYg2wrEOCsEdIiL
        MElHDtwWQhsnDYOi9AJEsEQ69Y58pW39fXZxzIk+Emvq2FUJbogXkTbPm+/MFb623ot3KcWR/MF5z
        gUHbVlEZtcZ0WaBOumS4/NWN5yRWwJDmF6xFAulir0TKAGNnn2eUHL88bIBm1rnuxr1hpfZ/3hwi5
        k2nw4Iew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8dIx-0059UN-Uy; Fri, 23 Dec 2022 08:21:23 +0000
Date:   Fri, 23 Dec 2022 00:21:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/3] mm: vmalloc: Switch to find_unlink_vmap_area() in
 vm_unmap_ram()
Message-ID: <Y6VlA8Mbbv7Ug6tW@infradead.org>
References: <20221222190022.134380-1-urezki@gmail.com>
 <20221222190022.134380-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222190022.134380-2-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 08:00:21PM +0100, Uladzislau Rezki (Sony) wrote:
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2252,7 +2252,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  		return;
>  	}
>  
> -	va = find_vmap_area(addr);
> +	va = find_unlink_vmap_area(addr);
>  	BUG_ON(!va);
>  	debug_check_no_locks_freed((void *)va->va_start,
>  				    (va->va_end - va->va_start));

Don't we also need to remove the manual unlink that was done
here previously?   Actually it seems like that manual unlink is missing
after patch 1, creating a bisection hazard.  So either add it there,
or just fold this patch into the previous one.
