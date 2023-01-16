Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD666CF46
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjAPTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjAPTB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:01:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B233A9A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OTvEP0dk4mOnC2iv0N91tfWHpSStEQbuT03o4jsB+3k=; b=SJcYe70efrX8NSS8Oee1AV7oXk
        9+KXywD1yVF9dgdzQNDkDQZsc2W3A3X7sBqpZ5JPqn63Ow7j8GgTrImpeRecy4QUIFl6ljfcUQqEa
        t87JAqa/QYU7shrT2vJTbdrGkqcaBcQBYp9KvWq3t74wTeYM7Xwr6zIqcWyMMKvjCu9W3BqE6/3rA
        YMnpnqqcYNrOafNGhECpltEHsNkGlaPwFsC3KqYJg/50+O/WC/MQZN3GKSApQ/Dg/WZ4JPe/vJCGM
        dSmUKDFurx2BcqKKe3Ri7baVFaWaUo6sjj7wlvWvISzoX+SDGE28lj9TDcd5qWnPh2Bf7A7M7jbmU
        hl85AbnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHUjd-008zPN-Oh; Mon, 16 Jan 2023 19:01:33 +0000
Date:   Mon, 16 Jan 2023 19:01:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y8WfDSRkc/OHP3oD@casper.infradead.org>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-4-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:17AM +0800, Baoquan He wrote:
> +	spin_lock(&vb->lock);
> +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> +		spin_unlock(&vb->lock);
> +		memset(buf, 0, count);
> +		return;
> +	}
> +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> +		if (!count)
> +			break;
> +		start = vmap_block_vaddr(vb->va->va_start, rs);
> +		while (addr < start) {
> +			if (count == 0)
> +				break;
> +			*buf = '\0';
> +			buf++;
> +			addr++;
> +			count--;
> +		}
> +		/*it could start reading from the middle of used region*/
> +		offset = offset_in_page(addr);
> +		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
> +		if (n > count)
> +			n = count;
> +		aligned_vread(buf, start+offset, n);

The whole vread() interface is rather suboptimal.  The only user is proc,
which is trying to copy to userspace.  But the vread() interface copies
to a kernel address, so kcore has to copy to a bounce buffer.  That makes
this spinlock work, but the price is that we can't copy to a user address
in the future.  Ideally, read_kcore() would be kcore_read_iter() and
we'd pass an iov_iter into vread().  vread() would then need to use a
mutex rather than a spinlock.

I don't think this needs to be done now, but if someone's looking for
a project ...
