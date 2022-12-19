Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4CA650C50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiLSNBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiLSNBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:01:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA4E1151
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:01:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f18so8548071wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nF7ws8r0mp70NFZAKD6xZ2YaUyIewxpp+mfAcRmI/lE=;
        b=g1HxN9AozAKS9+jMF74tB5TvmlEFBJjcfudBC89GlKCAfEzYdjhDlTOMLw1v4GC9M2
         GjP8gr8OOZ4Q/ezCBFDN7bJEDpnktEOT9WwtJVkTjC4TBI/ufyWIk+sfNm9SsrWbqbtY
         MgL7ZYMN8yOR9jgz7hp0Ob/3r4KEG27krKhra7ZeWBTjlsDg/ZVtT+jnYcZtPiPrs+yW
         deq9GwpLyALBVNLtShuymUfT3H5fhTGpSra60MRx5O7eFmJWFKgX7QTwG988WOtA8sS5
         fGXNWssXt10JVr1UEZaaEeqqhlXoRrIycDX0nQIqWH0I68kEUhNRfw40y4IW3qSbkSvo
         yfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF7ws8r0mp70NFZAKD6xZ2YaUyIewxpp+mfAcRmI/lE=;
        b=UqNtAuJ2HlTUCszsOMKLEPzcROOVAZEutmSolJzSu5IuldZ5sz42z0JJCnMlc50N2J
         bAp4JzzK0cj6RPCL+L5kUOSMB5pAfgsjanHrxRiawkM3G0X3e1BZVqTvu/uuKfKDp/tv
         OS7diIaTVIzjrIZKismsVZ4UBcMMb2HGH31zzW82/fFwb2qb1IP62FOKksG4D+XPB53Z
         btlTrgn/YQ9eH6soAQ1YUhLo2ZZ0ai7ES84so1rk9LFZ8irR4gVor9LDSnxzNMqGBYbG
         KXpSD3birpeMtKhWz2GB/OuhatKkoZy7I5Hu8487B4/On44LNjC0zkH1UT1b1KVrSL7q
         U1lg==
X-Gm-Message-State: ANoB5pksC0Rxsr3TmG1//+vSD5PEPvrHYCUJ3t0IL4nS6S2wRWf3yD7m
        DPVCvyaJ1Jtwf8E7Id9Wrco=
X-Google-Smtp-Source: AA0mqf7AexisWJ3Gi42FxINMFRJi1wDoQBdNXzQN8Hdn8h1x+nqYewSPMtIeamoAZEDuZCy2D5Xmfg==
X-Received: by 2002:a05:6000:170b:b0:242:806c:8612 with SMTP id n11-20020a056000170b00b00242806c8612mr31079743wrc.7.1671454904778;
        Mon, 19 Dec 2022 05:01:44 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id u1-20020a5d6ac1000000b00241cfe6e286sm9921878wrw.98.2022.12.19.05.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 05:01:44 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:01:43 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y6Bgt7k1H7Ez4EEb@lucifer>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y52rllbXHMwbpJ8K@lucifer>
 <Y6AaPKT7mdVxdHRl@MiWiFi-R3L-srv>
 <Y6AqRauq6wEYK0n5@lucifer>
 <Y6BYD24wzAogqRyT@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6BYD24wzAogqRyT@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 08:24:47PM +0800, Baoquan He wrote:
> In fact, I should not do the checking, but do the clearing anyway. If I
> change it as below, does it look better to you?
>
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5e578563784a..369b848d097a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2253,8 +2253,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	spin_lock(&vmap_area_lock);
>  	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
>  	BUG_ON(!va);
> -	if (va)
> -		va->flags &= ~VMAP_RAM;
> +	va->flags &= ~VMAP_RAM;
>  	spin_unlock(&vmap_area_lock);
>  	debug_check_no_locks_freed((void *)va->va_start,
>  				    (va->va_end - va->va_start));

This is better as it avoids the slightly contradictory situation of checking for
a condition we've asserted is not the case, but I would still far prefer keeping
this as-is and placing the unlock before the BUG_ON().

This avoids explicitly and knowingly holding a lock over a BUG_ON() and is
simple to implement, e.g.:-

  	spin_lock(&vmap_area_lock);
  	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
 	if (va)
 		va->flags &= ~VMAP_RAM;
  	spin_unlock(&vmap_area_lock);
  	BUG_ON(!va);

> > You are at this point clearing the VMAP_RAM flag though, so if it is unimportant
> > what the flags are after this call, why are you clearing this one?
>
> With my understanding, We had better do the clearing. Currently, from
> the code, not doing the clearing won't cause issue. If possible, I would
> like to clear it as below draft code.
>

Sure, it seems appropriate to clear it, I'm just unsure as to why you aren't
just clearing both flags? Perhaps just set va->flags = 0?

> >
> > It is just a little confusing, I wonder whether the VMAP_BLOCK flag is necessary
> > at all, is it possible to just treat a non-VMAP_BLOCK VMAP_RAM area as if it
> > were simply a fully occupied block? Do we gain much by the distinction?
>
> Yeah, VMAP_BLOCK flag is necessary. vmap_block contains used region,
> or dirty/free regions. While the non-vmap_blcok vm_map_ram area is
> similar with the non vm_map_ram area. When reading out vm_map_ram
> regions, vmap_block regions need be treated differently.

OK looking through again closely I see you're absolutely right, I wondered
whether you could somehow make a non-VMAP_BLOCK vread() operation be equivalent
to a block one (only across the whole mapping), but I don't think you can.
