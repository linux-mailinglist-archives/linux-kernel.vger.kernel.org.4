Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BFB6D3C4F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjDCEKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDCEKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:10:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C107AAF;
        Sun,  2 Apr 2023 21:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pxnbcc+yV5tR7zrYoF+1u6CiypRWPoqNMC+J6J/tgjI=; b=lLaewpnqM1XlP4DOm9MjzmZnic
        /DjAUjPqc39NkMTAGQcTTRpkRdi+bGH4nji5BIWQjte51kFRNnJMNBvuqcBtxs55O+/Td9SPEfYFK
        Imc9Ee3PRlbgjvlYDLzKIqFuc90x1ykBnHMfsVOeZH8z482t6fquvlrR6wBA/MGjLG54NKI56oGik
        L4/5UCxrgQJKwYdMbPrueqOyVYpV8iooLjvtt85pzMlgKz+mEJh/HZmrRzark5Ao8wp94Pe06ksmE
        /cERlyfcuvHibyXNk9x76iiUeBj0LTHIU7OQ1e0+/RDZNDNUTZ/tH4P+IronBH5HIbO9F7BxkV9Z7
        KahAKSnA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjBWW-00DmMZ-Hj; Mon, 03 Apr 2023 04:10:28 +0000
Date:   Mon, 3 Apr 2023 05:10:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org
Subject: Re: [PATCH] mm/swap: fix swap_info_struct race between swapoff and
 get_swap_pages()
Message-ID: <ZCpRtASqL5z5QphY@casper.infradead.org>
References: <20230401221920.57986-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401221920.57986-1-rongwei.wang@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 06:19:20AM +0800, Rongwei Wang wrote:
> Without this modification, a core will wait (mostly)
> 'swap_info_struct->lock' when completing
> 'del_from_avail_list(p)'. Immediately, other cores
> soon calling 'add_to_avail_list()' to add the same
> object again when acquiring the lock that released
> by former. It's not the desired result but exists
> indeed. This case can be described as below:

This feels like a very verbose way of saying

"The si->lock must be held when deleting the si from the
available list.  Otherwise, another thread can re-add the
si to the available list, which can lead to memory corruption.
The only place we have found where this happens is in the
swapoff path."

> +++ b/mm/swapfile.c
> @@ -2610,8 +2610,12 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  		spin_unlock(&swap_lock);
>  		goto out_dput;
>  	}
> -	del_from_avail_list(p);
> +	/*
> +	 * Here lock is used to protect deleting and SWP_WRITEOK clearing
> +	 * can be seen concurrently.
> +	 */

This comment isn't necessary.  But I would add a lockdep assert inside
__del_from_avail_list() that p->lock is held.

>  	spin_lock(&p->lock);
> +	del_from_avail_list(p);
>  	if (p->prio < 0) {
>  		struct swap_info_struct *si = p;
>  		int nid;
> -- 
> 2.27.0
> 
> 
