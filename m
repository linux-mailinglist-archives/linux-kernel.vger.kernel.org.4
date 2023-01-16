Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7752466CFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjAPTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjAPTsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:48:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F6B22A0F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:48:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o15so20730980wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=onvhX1TOdt60boJ/7IAHFv/aMGHge6Nfr/YhIhx4rzQ=;
        b=TdvrquOPOT5LXSSXAt/M7SaQWSgxwpkMFCuOGNBBXMfFgE5oUEp3LpPmSu/sjkMVV9
         dom5C304X31GgzFzDY8I6f/7j/bridJG4CmiY0wgmDDaH1aizuRnajCFlUHHFTCcpSgw
         t7SV5Q4UzEtuaIJgH6+2m/NcvEggjHT1keCxCHtEzhJt8hJgl7EHpvNvxKmkSF8nhFah
         f9hwIRqXxy9o1vLALnYNXfccgBpcB8NUZw39lpVDSRRBBsWxLwA7zjk7xB68mdz2jyEp
         NUX0xhYUTJaz28jlHBQy6B0pLHjmjoZ5K2ks53NZV/Blq1dGzwA92AfIV6qIPYSVSuYg
         o7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onvhX1TOdt60boJ/7IAHFv/aMGHge6Nfr/YhIhx4rzQ=;
        b=hU5Fj5p5uSI5mUkAISI/vYF1NfYEXr6rWEVy3xFDF+YaQUrK9GngoU12X9MOHEADGG
         RFIPL97yuTnBc0XwsIxa6hLRNdqJXkIxl0903rSg73XlQQTIbk8cjdFUFsVcEHjB2jnE
         Yy2m8qLGZOLydUr3f3dgNUyaxzqE7tyGt0oI1NZO40b2wkBKyChfIcQ7xok46Lgb3xDA
         wDJnfcI1sUYEfEzUE9pmqZ+udcwkue10zGDmudFxY+8CpLBprWp2Qg4YmLT7Am+hO8xK
         sg9qaBx1KO3z+wfdnqZlNCtdNq8X2aX//ZUdSzk/XcLzG6D0y8x6pOX5zZjDNsvpbX0F
         CZAg==
X-Gm-Message-State: AFqh2koSnZfHDgbQFTS2m2ByHR9BJYeBS+XcUzrE2OdNE83yLfN4050a
        wQAuEDAmG8fyFQu0Jop0JpQ=
X-Google-Smtp-Source: AMrXdXs848a3qdyv+SLxTCa7nmdliC7Rl6LooPQPd9DElyiKg8euw8Ei0tsWe0p7OWf3VwtebAHtGg==
X-Received: by 2002:a05:600c:3c92:b0:3d3:4007:9c88 with SMTP id bg18-20020a05600c3c9200b003d340079c88mr608217wmb.18.1673898494380;
        Mon, 16 Jan 2023 11:48:14 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b003daf89e01d3sm5910223wms.11.2023.01.16.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:48:13 -0800 (PST)
Date:   Mon, 16 Jan 2023 19:48:12 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, akpm@linux-foundation.org,
        hch@infradead.org
Subject: Re: [PATCH v3 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y8Wp/BtGWj9zk4tP@lucifer>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-4-bhe@redhat.com>
 <Y8WfDSRkc/OHP3oD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8WfDSRkc/OHP3oD@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 07:01:33PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 13, 2023 at 11:19:17AM +0800, Baoquan He wrote:
> > +	spin_lock(&vb->lock);
> > +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> > +		spin_unlock(&vb->lock);
> > +		memset(buf, 0, count);
> > +		return;
> > +	}
> > +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> > +		if (!count)
> > +			break;
> > +		start = vmap_block_vaddr(vb->va->va_start, rs);
> > +		while (addr < start) {
> > +			if (count == 0)
> > +				break;
> > +			*buf = '\0';
> > +			buf++;
> > +			addr++;
> > +			count--;
> > +		}
> > +		/*it could start reading from the middle of used region*/
> > +		offset = offset_in_page(addr);
> > +		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
> > +		if (n > count)
> > +			n = count;
> > +		aligned_vread(buf, start+offset, n);
>
> The whole vread() interface is rather suboptimal.  The only user is proc,
> which is trying to copy to userspace.  But the vread() interface copies
> to a kernel address, so kcore has to copy to a bounce buffer.  That makes
> this spinlock work, but the price is that we can't copy to a user address
> in the future.  Ideally, read_kcore() would be kcore_read_iter() and
> we'd pass an iov_iter into vread().  vread() would then need to use a
> mutex rather than a spinlock.
>
> I don't think this needs to be done now, but if someone's looking for
> a project ...

Interesting! I may take a look at this if I get the time :)
