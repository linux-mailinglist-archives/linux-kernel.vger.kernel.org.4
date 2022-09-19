Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C85BD5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiISU52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E94B4BD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56B96B82072
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EE6C433D6;
        Mon, 19 Sep 2022 20:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663621043;
        bh=7IVgxN4jKizV0N/1jpx39bak2NnAK31U23PaJaUNaVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xd/jE4qv5G2GKIlhUjgVOK4TRugup9Kxbo2h62YeeQvxfgVtEYsXEU2eCAvqu33Zb
         2GmJIs5ldqc0OWF/SaL7OzkhvdEL4vSZnc9zE3Er4LVeVfSiaQ0zLXI1n4eBlaS/4h
         l8FCav0SV/ZDiA07kEdpXj+Ehi75h4vBSVY1FfUI=
Date:   Mon, 19 Sep 2022 13:57:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     hch@lst.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mmap lock holding assertion on remap_pfn_range
Message-Id: <20220919135710.d52984bda33620f42d450010@linux-foundation.org>
In-Reply-To: <TYCP286MB23233CBD7126B624E1832699CA4D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB23233CBD7126B624E1832699CA4D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 23:47:32 +0800 Dawei Li <set_pte_at@outlook.com> wrote:

> remap_pfn_range() creates/modifies the mapping between user virtual
> address and physical address, the caller of which must hold mmap
> writer lock to achieve access consistency of mapping.
> 
> The callers fall into categories below:
> 1) fops->mmap() implemented by driver
> For this case, mmap_lock has been taken externally, the rule holds true.
> 
> 2) Some arch codes do mapping on their own(vdso e.g.), rather than via
> fops->mmap().
> 
> 3) Some driver codes do mapping into user address space, for some
> reasons, the mapping is not implemented by fops->mmap().
> 
> For the last two cases, an explicit assertion must be made.

Why "must" it be made?  Are callers known to get this wrong?

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2551,6 +2551,11 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	int err;
>  
> +	if (!vma->vm_mm)
> +		return -EINVAL;

Can this happen?  If so, under what circumstances?

> +	mmap_assert_write_locked(vma->vm_mm);
> +
>  	err = track_pfn_remap(vma, &prot, pfn, addr, PAGE_ALIGN(size));
>  	if (err)
>  		return -EINVAL;
> -- 
> 2.25.1
