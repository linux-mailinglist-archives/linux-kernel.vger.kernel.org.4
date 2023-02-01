Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6B686F97
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBAUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBAUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:16:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E66187F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:16:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso2250011wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q57ln7oTT4qVotRIsJQ/UUUBpBA8wVo803kMrdqxSLk=;
        b=fpKWon3cofKU+VuXd+KGExnWbE9ugoZ+ImQSgDmMdfXpe3DAZIy5RIo9Gu+ZQFNuzH
         YSJwl41KXiMm9hVaI6RWc6kDtAQPdgcFslcI+OBZ8Lh+8DZvuqIGJ2+ZWR7Xe5nHIwwT
         4K0KpsBbYJrkIyFXF0/G6L2XFG7mxZ1CXs2nguAUiaoxFT+gj3gGQ42hqH5MbOqggcrl
         qLkV0KM2Y9c+rAv8vEjOUENIrP45M2bxA0G1Z3L2m/O4n5mOu6Tk2fjeFL0jZ0ZCxH2d
         8yOWSpitF7Rt4QYxxfMfX1eYlGnqXaqGP5/bZ413Aqo5ABGjd7ewwmiphMsbTBMhM9xG
         9+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q57ln7oTT4qVotRIsJQ/UUUBpBA8wVo803kMrdqxSLk=;
        b=zLn8CMi2bm8wgiKETgeiF601s/BGa27gcmfppqtTuRJjllJbRzR88VEuAnP/b+T6Vu
         EnfEG1P7xV2wq6qZsjvixCyUMe9p+s4swCS6cZSDGohqe4qTFL79KLUFYe0+bDNGxsHr
         mCvKTW4K0iSyTKCY+FBQ4MXNzX9MZ6/JY3fUZ6qXderS2mEubbOUcx9AImxMeyqKaS6B
         bMXux3hludSpuI0Cqo7G+THs1FeByfc4Go79Fnjmi1txua/4nStslemD946a+m9Ww1AS
         n+HpXPuLZSWIKGO9aceBtEXGWNnAyzmhXnnGeY/57u7otfEx0Mmtu5RcdNkEZCDWdb9N
         61Lw==
X-Gm-Message-State: AO0yUKVCB5DthSYu/nVoP/fi5b5Q9nHV7wOUqKOhwEMqAvayLVUvB1y9
        5s2aPNT2Z2eqf9BuVKn77tE=
X-Google-Smtp-Source: AK7set//F6ZawrhUzuTjH86mOLyXvSXwT+XRaOBN+l1u0H5aZYonxsLNXz7wR8XfOgxATfiaBk2rXw==
X-Received: by 2002:a05:600c:35d5:b0:3dc:443e:3a8b with SMTP id r21-20020a05600c35d500b003dc443e3a8bmr3459642wmq.16.1675282586058;
        Wed, 01 Feb 2023 12:16:26 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c081b00b003de77597f16sm2634549wmp.21.2023.02.01.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:16:24 -0800 (PST)
Date:   Wed, 1 Feb 2023 20:16:24 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, stephen.s.brennan@oracle.com,
        urezki@gmail.com, willy@infradead.org, hch@infradead.org,
        error27@gmail.com
Subject: Re: [PATCH v4 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y9rImPGSF/EQ1Xey@lucifer>
References: <20230201091339.61761-1-bhe@redhat.com>
 <20230201091339.61761-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201091339.61761-4-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:13:35PM +0800, Baoquan He wrote:
> Currently, vread can read out vmalloc areas which is associated with
> a vm_struct. While this doesn't work for areas created by vm_map_ram()
> interface because it doesn't have an associated vm_struct. Then in vread(),
> these areas are all skipped.
>
> Here, add a new function vmap_ram_vread() to read out vm_map_ram areas.
> The area created with vmap_ram_vread() interface directly can be handled
> like the other normal vmap areas with aligned_vread(). While areas
> which will be further subdivided and managed with vmap_block need
> carefully read out page-aligned small regions and zero fill holes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 80 insertions(+), 7 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab4825050b5c..5a3ea6cb7ec2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3544,6 +3544,67 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
>  	return copied;
>  }
>
> +static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
> +{
> +	char *start;
> +	struct vmap_block *vb;
> +	unsigned long offset;
> +	unsigned int rs, re, n;
> +
> +	/*
> +	 * If it's area created by vm_map_ram() interface directly, but
> +	 * not further subdividing and delegating management to vmap_block,
> +	 * handle it here.
> +	 */
> +	if (!(flags & VMAP_BLOCK)) {
> +		aligned_vread(buf, addr, count);
> +		return;
> +	}
> +
> +	/*
> +	 * Area is split into regions and tracked with vmap_block, read out
> +	 * each region and zero fill the hole between regions.
> +	 */
> +	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> +	if (!vb)
> +		goto finished;
> +
> +	spin_lock(&vb->lock);
> +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> +		spin_unlock(&vb->lock);
> +		goto finished;
> +	}
> +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> +		if (!count)
> +			break;
> +		start = vmap_block_vaddr(vb->va->va_start, rs);
> +		while (addr < start) {
> +			if (count == 0)
> +				break;

Bit pedantic, but you're using the `if (!count)` form of checking whether it's
zero above, but here you explicitly check it, would be good to keep both consistent.

Given you're checking here, perhaps you could simply drop the previous check?

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
> +
> +		buf += n;
> +		addr += n;
> +		count -= n;
> +	}
> +	spin_unlock(&vb->lock);
> +
> +finished:
> +	/* zero-fill the left dirty or free regions */
> +	if (count)
> +		memset(buf, 0, count);
> +}
> +
>  /**
>   * vread() - read vmalloc area in a safe way.
>   * @buf:     buffer for reading data
> @@ -3574,7 +3635,7 @@ long vread(char *buf, char *addr, unsigned long count)
>  	struct vm_struct *vm;
>  	char *vaddr, *buf_start = buf;
>  	unsigned long buflen = count;
> -	unsigned long n;
> +	unsigned long n, size, flags;
>
>  	addr = kasan_reset_tag(addr);
>
> @@ -3595,12 +3656,21 @@ long vread(char *buf, char *addr, unsigned long count)
>  		if (!count)
>  			break;
>
> -		if (!va->vm)
> +		vm = va->vm;
> +		flags = va->flags & VMAP_FLAGS_MASK;
> +		/*
> +		 * VMAP_BLOCK indicates a sub-type of vm_map_ram area, need
> +		 * be set together with VMAP_RAM.
> +		 */
> +		WARN_ON(flags == VMAP_BLOCK);
> +
> +		if (!vm && !flags)
>  			continue;
>
> -		vm = va->vm;
> -		vaddr = (char *) vm->addr;
> -		if (addr >= vaddr + get_vm_area_size(vm))
> +		vaddr = (char *) va->va_start;
> +		size = vm ? get_vm_area_size(vm) : va_size(va);
> +
> +		if (addr >= vaddr + size)
>  			continue;
>  		while (addr < vaddr) {
>  			if (count == 0)
> @@ -3610,10 +3680,13 @@ long vread(char *buf, char *addr, unsigned long count)
>  			addr++;
>  			count--;
>  		}
> -		n = vaddr + get_vm_area_size(vm) - addr;
> +		n = vaddr + size - addr;
>  		if (n > count)
>  			n = count;
> -		if (!(vm->flags & VM_IOREMAP))
> +
> +		if (flags & VMAP_RAM)
> +			vmap_ram_vread(buf, addr, n, flags);
> +		else if (!(vm->flags & VM_IOREMAP))
>  			aligned_vread(buf, addr, n);
>  		else /* IOREMAP area is treated as memory hole */
>  			memset(buf, 0, n);
> --
> 2.34.1
>

Other than the nit, feel free to add:-

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
