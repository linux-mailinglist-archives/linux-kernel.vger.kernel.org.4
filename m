Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7766D1A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjCaIlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjCaIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:40:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EDE1A478
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:40:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n19so12436971wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680251931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0O+1iDiHGqqkLLtzjSrhhvTogFFIDtpqH3SLB/+nZA=;
        b=qwp+45yDU/8FeUG/mb5yQk4Baj8bRTtm7Uvuw+61kXsPy6YmBE2gAX1gI+C2nCvB6x
         2+vrFgyZFFI9Uzw5jTqV1uFcnrLNuEFy3puFk5QDI9+zZPS72PKlQ7kg9TWY+k9DkKil
         jBNbcLCVOqXWQQxpjnMWudYmjIo0ZdvSKmStlm5lXx5zn1c1tGBUEfKu+i9QZS2mkSFU
         4DpXDUiiDevAsNhouW7Rp3s9uaCQpI+nb2lMyUeD5PU3ZSfsSZltG9xDpFLbFbkNbt+R
         gMshyalbmyFewULoENqAnQH+Q/YUqQA8AfXvjoTSdk0ykLEKTiqytW+FOtcETcvtfRA5
         TQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0O+1iDiHGqqkLLtzjSrhhvTogFFIDtpqH3SLB/+nZA=;
        b=CGSu8cKHlIZ/ct6DG9i3/2j5Th3Jmp42MGZO4vkIT5Szj52DjswyR/kfhDkoWTW+3F
         S1G00w5KfCaHsZRIPbi4bh3rK8mOc1RuZ6H0KF6axiNj8CjW32Ffblb2p6Xh7jFPjid2
         LR9Z+5M81Po9fqx+91ktdhjBgwsLdIqQV1lMfpb7MwKh0X1ura2PZuOQ3++G2e85eLiJ
         P3Y/w4o+LMrq6gZdjVMpFnfDSARpszJUtu2r5KTu+Yx0Iv9JP/MimKGNABxPuzmN43Fw
         figN1GgNrD2ewYnfkFLjL+X9FTdzbsCcIw9j+HQdaQFmDzt9hF9z/z5CHhSWmj11hG2D
         QZfg==
X-Gm-Message-State: AO0yUKVpvJaZHwZXESmk2CMsOc+cGCo1Wx7n7Qphoe/9tVfzmYQV+J3s
        DAILbsWPhoZGiqTVZnJD0E8=
X-Google-Smtp-Source: AK7set+teNQZei3rKQqSvoEESvdaLQj7q7z52K6Cha/Jmf1FC3DFlCf6DqwjFwk0c+uOGDCgCLCl/Q==
X-Received: by 2002:a1c:7919:0:b0:3ee:da1:1346 with SMTP id l25-20020a1c7919000000b003ee0da11346mr20639774wme.36.1680251931504;
        Fri, 31 Mar 2023 01:38:51 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003edf2dc7ca3sm1913937wmr.34.2023.03.31.01.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 01:38:50 -0700 (PDT)
Date:   Fri, 31 Mar 2023 09:38:49 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Rename addr_to_vb_xarray() function
Message-ID: <65a19f0a-be4d-42c9-a75d-1356996acdda@lucifer.local>
References: <20230331073727.6968-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331073727.6968-1-urezki@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 09:37:27AM +0200, Uladzislau Rezki (Sony) wrote:
> Short the name of the addr_to_vb_xarray() function to the
> addr_to_vb_xa(). This aligns with other internal function
> abbreviations.
>
> Suggested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 671d6d5d5b78..b8b646f8a00d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1945,7 +1945,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>   * used as a hash table. When used as a hash a 'cpu' passed to
>   * per_cpu() is not actually a CPU but rather a hash index.
>   *
> - * A hash function is addr_to_vb_xarray() which hashes any address
> + * A hash function is addr_to_vb_xa() which hashes any address
>   * to a specific index(in a hash) it belongs to. This then uses a
>   * per_cpu() macro to access an array with generated index.
>   *
> @@ -1971,7 +1971,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>   * however xarray spinlocks protect against any contention that remains.
>   */
>  static struct xarray *
> -addr_to_vb_xarray(unsigned long addr)
> +addr_to_vb_xa(unsigned long addr)
>  {
>  	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
>
> @@ -2048,7 +2048,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
>
> -	xa = addr_to_vb_xarray(va->va_start);
> +	xa = addr_to_vb_xa(va->va_start);
>  	vb_idx = addr_to_vb_idx(va->va_start);
>  	err = xa_insert(xa, vb_idx, vb, gfp_mask);
>  	if (err) {
> @@ -2070,7 +2070,7 @@ static void free_vmap_block(struct vmap_block *vb)
>  	struct vmap_block *tmp;
>  	struct xarray *xa;
>
> -	xa = addr_to_vb_xarray(vb->va->va_start);
> +	xa = addr_to_vb_xa(vb->va->va_start);
>  	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
>  	BUG_ON(tmp != vb);
>
> @@ -2193,7 +2193,7 @@ static void vb_free(unsigned long addr, unsigned long size)
>  	order = get_order(size);
>  	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
>
> -	xa = addr_to_vb_xarray(addr);
> +	xa = addr_to_vb_xa(addr);
>  	vb = xa_load(xa, addr_to_vb_idx(addr));
>
>  	spin_lock(&vb->lock);
> @@ -3556,7 +3556,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
>  	 * Area is split into regions and tracked with vmap_block, read out
>  	 * each region and zero fill the hole between regions.
>  	 */
> -	xa = addr_to_vb_xarray((unsigned long) addr);
> +	xa = addr_to_vb_xa((unsigned long) addr);
>  	vb = xa_load(xa, addr_to_vb_idx((unsigned long)addr));
>  	if (!vb)
>  		goto finished;
> --
> 2.30.2
>

I have no problem with this patch but it's a bit of a pain to apply, as
doesn't apply to mm-unstable or -next as it doesn't take into account my
vread_iter changes, however Andrew can probably figure it out :)

I checked it manually and it's fine, so:-

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
