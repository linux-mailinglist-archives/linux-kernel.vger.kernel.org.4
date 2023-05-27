Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1CC713692
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 23:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjE0Vw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0Vw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 17:52:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E548ED8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 14:52:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso1117994f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685224343; x=1687816343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wbENCN109xaNwDwV62gwizaYqgOfR9JxKv+tkV449k=;
        b=B9FJSy8NBudUL66TrAEA7DyenIT5ceWL2TszrRWPPl2kEdqH6ULcvuOIjk0uVAvzPC
         b4xFX5K0DMhs6Hbcv4gx8522Jl/VzYoog/jbZdhRNEsibreTS0NCg398mQmueN7IvnnY
         aSMta0zLQWY1qlOGRFWNr75f09qdtkI2AmwhDE+qgVDvXkzhNPlpQ7owQZqkxm6S7rkE
         Lm1O2n6vRStQjV62xQVboeYTeZfZzRyLuBVp1RfnBVqeSJ+AeKp1M8dmF7r07lM0hvMz
         AJF1+i8/u23aUA7lWmdVZHJeQbRwVaOKxAV5Y8a7ZAxMTX+MVNfHwCsH1vrnJUfau3X/
         /pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685224343; x=1687816343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wbENCN109xaNwDwV62gwizaYqgOfR9JxKv+tkV449k=;
        b=b79U69dmRRKF1q0kVxTF6H1VERSEpIiomccbDpC/zcJUa3ujZ0/KckkeRH3RB0L+bz
         5MsCyBpx7FjPGu/ZTV+vDMJEYnvI7H1PHWWVlVdPviuaLDHL3dYxmKMm7myaFcsvLryy
         1chhjtVvHmJwIn/klkVPZdhHwNZTvwHC80hLZNO+h0em/gQRavS55DKtBn4GYMIHDZh6
         CeI54ZWQRt09aqGE13O66svK4R/qem0pahjGi0/sT0/AKujbgtBUz4/Z4Hfy21HQZl9r
         QuVOfPh2Wv7+eYXKWA14mHzsxrGC6ecuS9o2PZHsu+KEHOEFw60UhP01d/e5cbzOCcYq
         9h3Q==
X-Gm-Message-State: AC+VfDxptiVm8GfjBPN42YWktzhfrTXPLP4EUxig/+qZkfUrC7fDGbtE
        QMF5l08aCT7IUNdNeil9X4w=
X-Google-Smtp-Source: ACHHUZ5R0Jz2wkoBnGgX7fzOUpEa2kj1uRx4gBScq5/ngkWFoUQ1wy1LuMD1Eq0uARjHbxlinY9joQ==
X-Received: by 2002:adf:f412:0:b0:306:2d3d:a108 with SMTP id g18-20020adff412000000b003062d3da108mr4187028wro.11.1685224343156;
        Sat, 27 May 2023 14:52:23 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id o8-20020adfcf08000000b00306c5900c10sm9219050wrj.9.2023.05.27.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 14:52:22 -0700 (PDT)
Date:   Sat, 27 May 2023 22:52:21 +0100
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
Subject: Re: [PATCH 3/9] mm: vmalloc: Move vmap_init_free_space() down in
 vmalloc.c
Message-ID: <31872430-964b-4884-a649-55398d751459@lucifer.local>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-4-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-4-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:08:43PM +0200, Uladzislau Rezki (Sony) wrote:
> A vmap_init_free_space() is a function that setups a vmap space
> and is considered as part of initialization phase. Since a main
> entry which is vmalloc_init(), has been moved down in vmalloc.c
> it makes sense to follow the pattern.
>
> There is no a functional change as a result of this patch.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 82 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5f900efec6a9..19dcffb0d563 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2416,47 +2416,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>  	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
>  }
>
> -static void vmap_init_free_space(void)
> -{
> -	unsigned long vmap_start = 1;
> -	const unsigned long vmap_end = ULONG_MAX;
> -	struct vmap_area *busy, *free;
> -
> -	/*
> -	 *     B     F     B     B     B     F
> -	 * -|-----|.....|-----|-----|-----|.....|-
> -	 *  |           The KVA space           |
> -	 *  |<--------------------------------->|
> -	 */
> -	list_for_each_entry(busy, &vmap_area_list, list) {
> -		if (busy->va_start - vmap_start > 0) {
> -			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> -			if (!WARN_ON_ONCE(!free)) {
> -				free->va_start = vmap_start;
> -				free->va_end = busy->va_start;
> -
> -				insert_vmap_area_augment(free, NULL,
> -					&free_vmap_area_root,
> -						&free_vmap_area_list);
> -			}
> -		}
> -
> -		vmap_start = busy->va_end;
> -	}
> -
> -	if (vmap_end - vmap_start > 0) {
> -		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> -		if (!WARN_ON_ONCE(!free)) {
> -			free->va_start = vmap_start;
> -			free->va_end = vmap_end;
> -
> -			insert_vmap_area_augment(free, NULL,
> -				&free_vmap_area_root,
> -					&free_vmap_area_list);
> -		}
> -	}
> -}
> -
>  static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
>  	struct vmap_area *va, unsigned long flags, const void *caller)
>  {
> @@ -4271,6 +4230,47 @@ module_init(proc_vmalloc_init);
>
>  #endif
>
> +static void vmap_init_free_space(void)
> +{
> +	unsigned long vmap_start = 1;
> +	const unsigned long vmap_end = ULONG_MAX;
> +	struct vmap_area *busy, *free;
> +
> +	/*
> +	 *     B     F     B     B     B     F
> +	 * -|-----|.....|-----|-----|-----|.....|-
> +	 *  |           The KVA space           |
> +	 *  |<--------------------------------->|
> +	 */
> +	list_for_each_entry(busy, &vmap_area_list, list) {
> +		if (busy->va_start - vmap_start > 0) {
> +			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +			if (!WARN_ON_ONCE(!free)) {
> +				free->va_start = vmap_start;
> +				free->va_end = busy->va_start;
> +
> +				insert_vmap_area_augment(free, NULL,
> +					&free_vmap_area_root,
> +						&free_vmap_area_list);
> +			}
> +		}
> +
> +		vmap_start = busy->va_end;
> +	}
> +
> +	if (vmap_end - vmap_start > 0) {
> +		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +		if (!WARN_ON_ONCE(!free)) {
> +			free->va_start = vmap_start;
> +			free->va_end = vmap_end;
> +
> +			insert_vmap_area_augment(free, NULL,
> +				&free_vmap_area_root,
> +					&free_vmap_area_list);
> +		}
> +	}
> +}
> +
>  void __init vmalloc_init(void)
>  {
>  	struct vmap_area *va;
> --
> 2.30.2
>

LGTM,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
