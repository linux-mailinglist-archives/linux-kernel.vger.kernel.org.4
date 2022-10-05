Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F405F5B29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiJEUmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJEUmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C5D5F9B1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665002533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHrx4ZNF6Q9JTs4QbO6KR9zUQ7s8TQSOd7bK/WolviI=;
        b=UgWpL6he0fOR+n/OgyB8nyDyWMxLAxhdgd+g/FhmQUL0s0HpClBpLNMXtAzYTlkTgTE7mi
        L+0BDtPH5Y8KjLbFHAYQNPYsNOmn+2tLnauIqhl/9wGDdduRooE9+bu6WPvl+XGfP7dVLc
        7qcDsbf5FHShPoBEauaXC+na2UTlZ6E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-KbP-ESo7NuiZ0oDaPA7S2w-1; Wed, 05 Oct 2022 16:42:11 -0400
X-MC-Unique: KbP-ESo7NuiZ0oDaPA7S2w-1
Received: by mail-qk1-f199.google.com with SMTP id j13-20020a05620a410d00b006e08208eb31so4325714qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KHrx4ZNF6Q9JTs4QbO6KR9zUQ7s8TQSOd7bK/WolviI=;
        b=NY9IkdcbFVKwCWrU7CU2RSMkuvX2Vb1cnjSoiv/aghQFHsN94zHIs35ZRmbwoLsZEm
         9bhLzU4VvLuV7mLDjHNZuNxcXYZPfl+mShkaqNY1TVVhUsystPY4W8xodiGqWw0UKdvr
         HRLWsvlAlvX3pOfZ8vRxA+uW3aN+vAlphkdny+nhbe0wNm5MEBp0mBtMewldP+7ijx2l
         DJgocZWSdWmi+6mLSJQxq0CEbH1fnn6bHlck4xWlQhoLW4rYc+lF9OR5yQO3VYJBUnUn
         Mj/ASG/JQtduHgrrNpe5UUtuz14Hxbhlo0iuxfXuFQvXvq1F600u4lirKUIMrdPSgE3M
         CMUQ==
X-Gm-Message-State: ACrzQf0o64UT5H/swgdmku+3n6hd8vj7hTHpjB3dE5qMbGklAppO/Fc/
        7RAly0R0UHFBDm7FdT0n5/ILkPd0lCKymxD987DcyuVlqkW9KDSiTFb2mhkuslZZ+PgrU3K2UCR
        KlzsEhIOk+Xlz9Cxle6vrqp/Z
X-Received: by 2002:a05:622a:1248:b0:35b:b5fa:5e25 with SMTP id z8-20020a05622a124800b0035bb5fa5e25mr1041839qtx.215.1665002531454;
        Wed, 05 Oct 2022 13:42:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VIUcXTqhgXvpzJkX75ZmoU7Lo+ixxEfdl/3WdVWfbQmY8WVE4OWUXjeUt4C2zlipy5Q6F5A==
X-Received: by 2002:a05:622a:1248:b0:35b:b5fa:5e25 with SMTP id z8-20020a05622a124800b0035bb5fa5e25mr1041822qtx.215.1665002531239;
        Wed, 05 Oct 2022 13:42:11 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i10-20020ac8764a000000b0031f41ea94easm15639632qtr.28.2022.10.05.13.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:42:10 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:42:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 5/7] mm/pagewalk: add walk_page_range_vma()
Message-ID: <Yz3sIY5Njzda3XSA@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-6-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:29PM +0200, David Hildenbrand wrote:
> +int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
> +			unsigned long end, const struct mm_walk_ops *ops,
> +			void *private)
> +{
> +	struct mm_walk walk = {
> +		.ops		= ops,
> +		.mm		= vma->vm_mm,
> +		.vma		= vma,
> +		.private	= private,
> +	};
> +	int err;
> +
> +	if (start >= end || !walk.mm)
> +		return -EINVAL;
> +	if (start < vma->vm_start || end > vma->vm_end)
> +		return -EINVAL;
> +
> +	mmap_assert_locked(walk.mm);
> +
> +	err = walk_page_test(start, end, &walk);

According to test_walk():

 * @test_walk:		caller specific callback function to determine whether
 *			we walk over the current vma or not. Returning 0 means
 *			"do page table walk over the current vma", returning
 *			a negative value means "abort current page table walk
 *			right now" and returning 1 means "skip the current vma"

Since this helper has vma passed in, not sure whether this is needed at
all?

walk_page_vma_range() sounds slightly better to me as it does look more
like an extension of walk_page_vma(), rather than sister version of
walk_page_range_novma() (which works for "no backing VMA" case).  But no
strong opinion.

-- 
Peter Xu

