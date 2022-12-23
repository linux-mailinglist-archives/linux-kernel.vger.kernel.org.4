Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50AD654D59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiLWITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiLWITc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:19:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173A32BA9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A0z7Vp7evF/eeIPMPIPG2cQWQ3aXjo4ZfAda63g1YR0=; b=Kz0LpaGxoJyNdE9herJniXgh5o
        PhKtbgT2ypmWtrzm0VZKQlFYFoVDtULFJ2yAjgtPWms6XH5ohTJOQz/6kem0uJCDiBstJ+6iEzie7
        nj2cE88WN+Mmf/rbYALJ3QwkjIRctQYiIglerOv7pti+dUL0YRqOljigo4kFEIOCVRjoKYHH9/zka
        mvclFQOBpcJ8hy5iJ0JgXea3h4G6ITMNTMvENJTazKq0mjtnDxmN5pi15Dd4qlQFu1IKV6zaEnykK
        s/aUvUo/Jk99AJo0GH77R3CUVnpgyX1FvxA8rnXLYR9jbypIw9rTvT8DOSfqlrd/xsSckSfsH1Ncx
        qFyzyivg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8dH4-0058iF-RN; Fri, 23 Dec 2022 08:19:26 +0000
Date:   Fri, 23 Dec 2022 00:19:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/3] mm: vmalloc: Avoid calling __find_vmap_area()
 twice in __vunmap()
Message-ID: <Y6Vkjr7DNEEv4MW5@infradead.org>
References: <20221222190022.134380-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222190022.134380-1-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 08:00:20PM +0100, Uladzislau Rezki (Sony) wrote:
> @@ -1825,9 +1825,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  	unsigned long va_start = va->va_start;
>  	unsigned long nr_lazy;
>  
> -	spin_lock(&vmap_area_lock);
> -	unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	if (WARN_ON_ONCE(!list_empty(&va->list)))
> +		return;

I'd just drop this check as the function is not exported.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
