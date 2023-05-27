Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2538D713652
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjE0Tzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0Tzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 15:55:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3ED2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 12:55:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30ad99fa586so1679497f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685217345; x=1687809345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wldCh2gzutJjtiin9a0KZhvAVvGTa21cDzVwRJ3ttrg=;
        b=ekEHq7WMTOElavxN9f/2NfgvQLD7rp3vsmwWHeWLl9jKx1r2ue7ULOWuM0AnQpenRU
         VxcxLvKsgWWBD/oMuvZs7ckyC+wgpZrG2wIYJL80+eTrcUdMey5Aoz559rYQtldk0SvM
         bWl2H3UYA/WK/oaRJ6Cbth8UG0hLTizeEsubQRFwsVA5umV75Qy/mnVWR7iEOr2QeqB9
         dArPvkTLsW5kr6FCQVksoMeW4T5rf8MPP4DAxz6eRAaNrTgPjGSyH4WKvwDvFJ6jT/0j
         sNd1fkg4B5a7sswdOYRNnyurIvroxJJZkZYwkWLlFPz6fE/klAN33hXA/2GB7EDmGxc/
         p94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685217345; x=1687809345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wldCh2gzutJjtiin9a0KZhvAVvGTa21cDzVwRJ3ttrg=;
        b=RVQ6tQ+k9gf1x0VdV091698JZBjrSH7KpiCBKT3j+9j33WA0o4OThP1qnonZgtewyK
         8X5gFzxEJkC7UPGvdVjsQmBk/J2qWvn67JoHXdi9jYaTN2hTG1/pFQcps9SszoZgTkrG
         PgDiMGNWmb1CTllfnaUY4uHtyqLi+caDbL8KpY7TMl9fIS1RXcUZdC2jAu55VsBgpmR+
         8aZSCQflV5RDv0eYm87/+embAqGLmf42SrxwrYcwGgOH1txNeDDX4FXT1h0+NiNPjrF7
         mVWTWiQYxxglXDP18fVpVKyJ+KijY1L1icj07n0K3c1/3sOxzsx9l6wNCjORYdWdjflj
         EHdQ==
X-Gm-Message-State: AC+VfDyxOE/QxJ5mpr9zqsQTAeXWF7Jfys3GDMYRTo/mA1K3RynjdjQ0
        G1Pb2R/4wQC+EBtV4+nPsUs=
X-Google-Smtp-Source: ACHHUZ6cfGOi6HpjKvFV31PjOro2m9xAkZ+MGwsCOfkLDEW1XnShLYkgqg1mb0fpXlnV5E+fSgfMrw==
X-Received: by 2002:a5d:4522:0:b0:307:4836:64e4 with SMTP id j2-20020a5d4522000000b00307483664e4mr5765062wra.52.1685217344834;
        Sat, 27 May 2023 12:55:44 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id z11-20020adff1cb000000b003093a412310sm8916050wro.92.2023.05.27.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 12:55:43 -0700 (PDT)
Date:   Sat, 27 May 2023 20:55:43 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/9] mm: vmalloc: Add va_alloc() helper
Message-ID: <96a75e2d-3108-4f9d-a90f-ad636f0401f1@lucifer.local>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-2-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:08:41PM +0200, Uladzislau Rezki (Sony) wrote:
> Currently __alloc_vmap_area() function contains an open codded
> logic that finds and adjusts a VA based on allocation request.
>
> Introduce a va_alloc() helper that adjusts found VA only. It
> will be used later at least in two places.
>
> There is no a functional change as a result of this patch.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 31ff782d368b..409285b68a67 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1482,6 +1482,32 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
>  	return 0;
>  }
>
> +static unsigned long
> +va_alloc(struct vmap_area *va,
> +	struct rb_root *root, struct list_head *head,
> +	unsigned long size, unsigned long align,
> +	unsigned long vstart, unsigned long vend)
> +{
> +	unsigned long nva_start_addr;
> +	int ret;
> +
> +	if (va->va_start > vstart)
> +		nva_start_addr = ALIGN(va->va_start, align);
> +	else
> +		nva_start_addr = ALIGN(vstart, align);
> +
> +	/* Check the "vend" restriction. */
> +	if (nva_start_addr + size > vend)
> +		return vend;
> +
> +	/* Update the free vmap_area. */
> +	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> +	if (WARN_ON_ONCE(ret))
> +		return vend;
> +
> +	return nva_start_addr;
> +}
> +
>  /*
>   * Returns a start address of the newly allocated area, if success.
>   * Otherwise a vend is returned that indicates failure.
> @@ -1494,7 +1520,6 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  	bool adjust_search_size = true;
>  	unsigned long nva_start_addr;
>  	struct vmap_area *va;
> -	int ret;
>
>  	/*
>  	 * Do not adjust when:
> @@ -1512,18 +1537,8 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  	if (unlikely(!va))
>  		return vend;
>
> -	if (va->va_start > vstart)
> -		nva_start_addr = ALIGN(va->va_start, align);
> -	else
> -		nva_start_addr = ALIGN(vstart, align);
> -
> -	/* Check the "vend" restriction. */
> -	if (nva_start_addr + size > vend)
> -		return vend;
> -
> -	/* Update the free vmap_area. */
> -	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> -	if (WARN_ON_ONCE(ret))
> +	nva_start_addr = va_alloc(va, root, head, size, align, vstart, vend);
> +	if (nva_start_addr == vend)
>  		return vend;
>
>  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> --
> 2.30.2
>

LGTM,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
