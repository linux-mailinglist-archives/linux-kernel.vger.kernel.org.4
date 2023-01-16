Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5B66BD32
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjAPLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjAPLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:50:55 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A9D558C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:50:54 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j17so42392166lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WW+GdQuvnNnKm/U4vO+vCnOCQLrE79/XGPwNYhmpQik=;
        b=ALG6KyeBBO+EAxG/y7g2nLAT+M09WHeqe4zvSaVz94dDYLHEb5YV7JFHVdh14ziGnG
         Kmk9HvT6NUsvly3g2fRh5XmvRo5AXIvfzKJRiAMnyWXpsCDkVlT79pkW9F3cKR/++ZyW
         Z/XKUJxpjhgzlF4i/UfE1PP7Hpn/jRfLg1Lyn90fRLoU9392Hh8Mad5hEe8p0RNBAM2g
         ZrWIg+XHaEnnSMPXib/OHoRqsRvcqVTa2julJdMtb4SWsgsd9FoyxlwLVQ8Ey0rJn+0/
         uSjpsdf3a5op1vYjxfa6O3OuWriDDpn2ptqhjeo7pGEm6x7WgOs9cLePCrUFBWXcHwYu
         VGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW+GdQuvnNnKm/U4vO+vCnOCQLrE79/XGPwNYhmpQik=;
        b=q9YPpc4mQvtZAVtGv2mYMEp0xBNItHaJiAd0WrHWTgyD94WV/CJlluJAgVa6hwNanM
         ltZn4QFxcOrwbtJCMvTTymUKxhma2TTNL1cNmYZ7cYP0OwkN7HAQy71c0kX3Ad/6mw+s
         dwLlSsz0kQrrMU0tUAkSTaDb5H6ur1HPBIvvxId+ptd0qK7Lx/csIBmv3hsabkjcxq5C
         EbZxFiV00YX7/8PaL6XmvE9aXeRAjbrbo1Nzw34W1uVaqKPHGzOPR47WpNP5w3dXsvBK
         oyklO0EqY7S2kj1J4IG2lLQ7pht76hDdNotfQYTVwqHwPzibFLq97Xy1y/a1d41NbSVn
         p3Gw==
X-Gm-Message-State: AFqh2krTIff/FwXax5AlHI5tTeXO7twcduMnpSOPd/3RN3nGiFfCJBPY
        VVhjH4wEYjEtp2qn4htlV7Y=
X-Google-Smtp-Source: AMrXdXsUqBX9MpqEpNTkbgkGeZyCBItYVHh0hP1RaL6GrvfEmE14vHDxbdPBFdb3EgNVUjIvoDbhbg==
X-Received: by 2002:ac2:42c4:0:b0:4a4:68b7:d645 with SMTP id n4-20020ac242c4000000b004a468b7d645mr20859265lfl.44.1673869852773;
        Mon, 16 Jan 2023 03:50:52 -0800 (PST)
Received: from pc636 (host-90-235-24-7.mobileonline.telia.com. [90.235.24.7])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512238f00b004cb3fbc7925sm4967081lfv.77.2023.01.16.03.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:50:52 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Jan 2023 12:50:50 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y8U6Gi5d4F8mO0ib@pc636>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-4-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:17AM +0800, Baoquan He wrote:
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
>  mm/vmalloc.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 73 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab4825050b5c..13875bc41e27 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3544,6 +3544,65 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
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
> +
> +	spin_lock(&vb->lock);
> +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
>
CPU-X invokes free_vmap_block() whereas we take the vb->lock and do
some manipulations with vb that might be already freed over RCU-core.

Should we protect it by the rcu_read_lock() also here?

--
Uladzislau Rezki
