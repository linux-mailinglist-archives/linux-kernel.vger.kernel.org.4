Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07A62CD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiKPWTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKPWTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:19:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1E85BD7D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668637087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eLacVH9A13gWTXV0mKgk98a/BsqmzWChzF1U5/Q2nY4=;
        b=WsHo4+p1fhTFuRdF1tJPoPlCdJySXZ+961ogc5J8PgIh8yoQiKQeK/L0dzBxoE612UdxmT
        G/GULdDqoXieknkWNC54EdFplYPPtqm+YUv801zwmMik90T0dl68M6d3qhd8TDelU5Mmab
        20SfNo+bN+DVKcGrZy/aU0ZS05noHc4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-qiXQclMqPZq8TS62i3wjew-1; Wed, 16 Nov 2022 17:18:05 -0500
X-MC-Unique: qiXQclMqPZq8TS62i3wjew-1
Received: by mail-qt1-f198.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso31425qtx.15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLacVH9A13gWTXV0mKgk98a/BsqmzWChzF1U5/Q2nY4=;
        b=5wj2lerKvfOm54UAPspWVUFlu9vYotijot4VJPbuhqJW1bZAN0drOdcIhJnpL9BWPM
         FYSwvqGaO3u9xEig2pjnw4rwBXelJAv58C3Tldgw9FpiBkDWsXi1JZAv1H5W3tB5C4Gw
         OMnjZ8NXUrXA4NpiUYGjAiar/AqaxUZft/t3/Ab40+gPuOMALGDVhxHKCXH0Ig8yYvQr
         L7Qp2AJOX/kT3gMjkVVsJa3ry8Bw1kSxlfYhJ3Dh6uBPjk6HlxGx3bSbv4x3GAuWdqO5
         A9vLV3nw1NwEz52wKpETcGv6yLoMpH62ZjCnzRYv3CoD8cf+pYJWUGfK/cs8otOP2bJP
         zCkg==
X-Gm-Message-State: ANoB5pmpxyq9GsucNlDxpmeyj48nMSUR40KS0On3o72v9TUIKcSLtExn
        I3/bcl29w+tZyU9ML+7hxqWVSKXoXPgb/GewDnRFgYA43yh4osMKrKu1v8PZY1VqmCZzq6Pi9Fu
        EmuM1VUlh/u4kIjW35sfU3tqt
X-Received: by 2002:ac8:44ab:0:b0:3a5:4859:8176 with SMTP id a11-20020ac844ab000000b003a548598176mr23466901qto.478.1668637085205;
        Wed, 16 Nov 2022 14:18:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5IVIYGjvz+hOM8t/mLeUfxGEfTJ1qWUuypNOzMzWaqU2N3kMAKsrFEcgvZj34OH1189VBcaQ==
X-Received: by 2002:ac8:44ab:0:b0:3a5:4859:8176 with SMTP id a11-20020ac844ab000000b003a548598176mr23466874qto.478.1668637084937;
        Wed, 16 Nov 2022 14:18:04 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h21-20020ac846d5000000b003a4f22c6507sm9441673qto.48.2022.11.16.14.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:18:00 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:17:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/47] hugetlb: add hugetlb_pte to track HugeTLB
 page table entries
Message-ID: <Y3Vhl6jzTLP0AggE@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-11-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-11-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:26PM +0000, James Houghton wrote:
> +struct hugetlb_pte {
> +	pte_t *ptep;
> +	unsigned int shift;
> +	enum hugetlb_level level;
> +	spinlock_t *ptl;
> +};

Do we need both shift + level?  Maybe it's only meaningful for ARM where
the shift may not be directly calculcated from level?

I'm wondering whether we can just maintain "shift" then we calculate
"level" realtime.  It just reads a bit weird to have these two fields, also
a burden to most of the call sites where shift and level exactly match..

> +
> +static inline
> +void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
> +			  unsigned int shift, enum hugetlb_level level)

I'd think it's nicer to replace "populate" with something else, as populate
is definitely a meaningful word in vm world for "making something appear if
it wasn't".  Maybe hugetlb_pte_setup()?

Even one step back, on the naming of hugetlb_pte..  Sorry to comment on
namings especially on this one, I really don't like to do that normally..
but here hugetlb_pte only walks the sub-page level of pgtables, meanwhile
it's not really a pte but an iterator.  How about hugetlb_hgm_iter?  "hgm"
tells that it only walks sub-level, and "iter" tells that it is an
iterator, being updated for each stepping downwards.

Then hugetlb_pte_populate() can be hugetlb_hgm_iter_init().

Take these comments with a grain of salt, and it never hurts to wait for a
2nd opinion before anything.

> +{
> +	WARN_ON_ONCE(!ptep);
> +	hpte->ptep = ptep;
> +	hpte->shift = shift;
> +	hpte->level = level;
> +	hpte->ptl = NULL;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> +{
> +	WARN_ON_ONCE(!hpte->ptep);
> +	return 1UL << hpte->shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> +{
> +	WARN_ON_ONCE(!hpte->ptep);
> +	return ~(hugetlb_pte_size(hpte) - 1);
> +}
> +
> +static inline
> +unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
> +{
> +	WARN_ON_ONCE(!hpte->ptep);
> +	return hpte->shift;
> +}
> +
> +static inline
> +enum hugetlb_level hugetlb_pte_level(const struct hugetlb_pte *hpte)
> +{
> +	WARN_ON_ONCE(!hpte->ptep);

There're definitely a bunch of hpte->ptep WARN_ON_ONCE()s..  AFAIK the
hugetlb_pte* will be setup once with valid ptep and then it should always
be.  I rem someone commented on these helpers look not useful, which I must
confess I had the same feeling.  But besides that, I'd rather drop all
these WARN_ON_ONCE()s but only check it when init() the iterator/pte.

> +	return hpte->level;
> +}
> +
> +static inline
> +void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> +{
> +	dest->ptep = src->ptep;
> +	dest->shift = src->shift;
> +	dest->level = src->level;
> +	dest->ptl = src->ptl;
> +}
> +
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
> +
>  struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
> @@ -1210,6 +1279,25 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
>  	return ptl;
>  }
>  
> +static inline
> +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +
> +	BUG_ON(!hpte->ptep);

Another BUG_ON(); better be dropped too.

> +	if (hpte->ptl)
> +		return hpte->ptl;
> +	return huge_pte_lockptr(hugetlb_pte_shift(hpte), mm, hpte->ptep);

I'm curious whether we can always have hpte->ptl set for a valid
hugetlb_pte.  I think that means we'll need to also init the ptl in the
init() fn of the iterator.  Then it'll be clear on which lock to take for
each valid hugetlb_pte.

> +}

-- 
Peter Xu

