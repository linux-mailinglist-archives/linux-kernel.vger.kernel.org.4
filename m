Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9771301C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjEZWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjEZWnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEA9C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685140945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogJ2tEtyBxgi9zLrPh+ylQ4Cvg3tJf/Wlr36DMH7FgE=;
        b=Bn/ZX4lceAQ0YIeQR0OgxDF4ZJxDSrWPhcTJYyn/nUW7N0Ldi7l/xHv4nIk2pD0XJiBl+f
        aK4H5qlffmBmab118K7DK/HfDNAc5tNIUnhq9uajgzcTz42zGUCTj4/RnTUbO7K0Akid5W
        luXElEuZ2mMOPRwK1d5e1VKcC+3e5ls=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-AZnlJJOfOHmhJSP1HicDQw-1; Fri, 26 May 2023 18:42:24 -0400
X-MC-Unique: AZnlJJOfOHmhJSP1HicDQw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f6b1853e80so2078771cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685140944; x=1687732944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogJ2tEtyBxgi9zLrPh+ylQ4Cvg3tJf/Wlr36DMH7FgE=;
        b=XJEWu9yboCuYmhFgeT8b1FGseE4/hb7qc7FTmmRZmtvtzct64tLLGpIvSuEmY1okVb
         Cf8hFcKmwEWiN/qGwRVbEcXhrMGv0anwoOQb/MuGrYk3SnheSbNbSXR/kvmP6uXhthm+
         0RxJC9+FKuOvEEI4/hSqSpsM9zxJy2rHhFiBAwoZZS7tES1vAJ2Yia8liGJSpOgKBd6a
         Mjms0H0Cv/u8bOVb8Mu9yt8Wnvp6511ub56W5jOR77QXOVRgLsouo6B9RoCzoFvOTB9A
         mVIzDaI5kUUQ+jsjBVV9B5yOHs4GfTzbz6rjXh5KG7mJ1bEPICkUURTuTuKUau3pE8Yx
         /btQ==
X-Gm-Message-State: AC+VfDzy1tj8c9jjuBbR4RiNtvIbkY1v2AtoVDY1NEV8OD3xJ02lWv10
        pwBj4Ze28h9kRKDVVnN+MekYmZ9o6oBLJq3afMkAqaW8ODOTgXWG/hoGo3Rpz07k/jSQGWagPMP
        86qUUGWEfh2GqGK63wYr5jEDH
X-Received: by 2002:a05:622a:1a2a:b0:3f7:fab0:6308 with SMTP id f42-20020a05622a1a2a00b003f7fab06308mr3573140qtb.6.1685140944112;
        Fri, 26 May 2023 15:42:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fzQcmVW2FTI3qLiQfBN8GUfG9nK6tEXfVb1nTd651kqyVhFQIBfH15x41vMbgJWwi02Rfqw==
X-Received: by 2002:a05:622a:1a2a:b0:3f7:fab0:6308 with SMTP id f42-20020a05622a1a2a00b003f7fab06308mr3573105qtb.6.1685140943796;
        Fri, 26 May 2023 15:42:23 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id bw7-20020a05622a098700b003f6b32a1049sm1617002qtb.55.2023.05.26.15.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 15:42:23 -0700 (PDT)
Date:   Fri, 26 May 2023 18:42:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 03/31] mm/pgtable: kmap_local_page() instead of
 kmap_atomic()
Message-ID: <ZHE1zLLF1jfcw8OI@x1n>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <9df4aba7-fd2f-2da3-1543-fc6b4b42f5b9@google.com>
 <ZHExQo3KO5PcVR76@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZHExQo3KO5PcVR76@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 06:22:58PM -0400, Peter Xu wrote:
> On Sun, May 21, 2023 at 09:52:31PM -0700, Hugh Dickins wrote:
> > pte_offset_map() was still using kmap_atomic(): update it to the
> > preferred kmap_local_page() before making further changes there, in case
> > we need this as a bisection point; but I doubt it can cause any trouble.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  include/linux/pgtable.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 8ec27fe69dc8..94235ff2706e 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -96,9 +96,9 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
> >  
> >  #if defined(CONFIG_HIGHPTE)
> >  #define pte_offset_map(dir, address)				\
> > -	((pte_t *)kmap_atomic(pmd_page(*(dir))) +		\
> > +	((pte_t *)kmap_local_page(pmd_page(*(dir))) +		\
> >  	 pte_index((address)))
> > -#define pte_unmap(pte) kunmap_atomic((pte))
> > +#define pte_unmap(pte) kunmap_local((pte))
> >  #else
> >  #define pte_offset_map(dir, address)	pte_offset_kernel((dir), (address))
> >  #define pte_unmap(pte) ((void)(pte))	/* NOP */
> 
> (I think this could be a dumb question if this patch has been running there
>  for years downstream, but still..)
> 
> I assume one major difference of using kmap_local() is page fault will not
> be disabled, while kmap_atomic() will.
> 
> Meanwhile, pte_offset_map() is also used by pte_offset_map_lock(), which
> means before this patch CONFIG_HIGHPTE systems will disable pgfault before
> taking pgtable lock for it, while it will stop doing so after the change.
> 
> Then what happens if a page fault happens on the same pgtable lock range
> that is already taken by the thread context?  What stops the deadlock from
> happening?

Ah, stupid me.  I think such a page fault just cannot happen when holding
the pgtable lock..  I believe the same applies to !HIGHPTE..

Sorry about the noise.

-- 
Peter Xu

