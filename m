Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF7B666699
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjAKW6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjAKW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48740630A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673477891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6X8VPVf8lP5s93B2M9ByDvI3FcsPMNaVjgr5rIK13I=;
        b=aahLQBw6kI2qwDMYTK+Q2i/ZZMxYKxwJGQTTx8/A7fRynaBAVTjwvLobe8OdqLR9pGaY3X
        2g/XgE7+i6XXw6poQm/O9UlYuh/Ka8+fQRF6Ox96oRDCoP8jOcewN7gXqtfOCeQDsGhFjF
        ZnF91MHy0PGe8bV8wq/pNBcTYiYTX3Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-3GNf0z-XOharMLKbm7W6OQ-1; Wed, 11 Jan 2023 17:58:10 -0500
X-MC-Unique: 3GNf0z-XOharMLKbm7W6OQ-1
Received: by mail-qk1-f200.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so11840131qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6X8VPVf8lP5s93B2M9ByDvI3FcsPMNaVjgr5rIK13I=;
        b=pcX9cIy50CjU+ii2V1UFjKr/gqtTy0vGwNtyBbqV7ZF20PVQf0efmsJJn6zTa9iafc
         JWjAMZDkSIFc+WeHOfpTauR8x66CHxW+S4n1uv6Vztxr9Hv+HGbq7YM+YDwJZYm61SE6
         aztQeoDBcnEvrhrKsSkS1GpKBSSaf9Yrfxdo7VeZdO4geP29IqpO7mb1m9986Qgt83Lm
         D/8pSgOdJys2p5Ua19HElqcw1VSV3F+6y8MiNA0+fi7dna20ziCptWdkMSTEoyRpGpXn
         o0PelpeXz+LHSZfQ7RVbHcrEozzwd3frVIEwcyj1AYGwL21AkH50WFxm4cATIeDn+/PZ
         QtEg==
X-Gm-Message-State: AFqh2kq3/UbGwf5nfs7yJQdyT45LFlKnX/HwNVUAzNlX6xY7Y6Vu+3H2
        HjjqIKHVVg9+roEfBbwKQNi4xkep4e9Yr9hDZquxqC6PeRDE7Vai8NVqH2AyScZDbSQlut62lL5
        1t0lJ2eS1UBFp6QDt7bV88s8b
X-Received: by 2002:a0c:e9cb:0:b0:532:3af0:136e with SMTP id q11-20020a0ce9cb000000b005323af0136emr5165320qvo.11.1673477889601;
        Wed, 11 Jan 2023 14:58:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsi2eFq9SqZp1mBl0cPsVyu20iG40mfSHvyWQpbgkoaDhXWdJ7ycJYWoytG+5kIZojWheqXXQ==
X-Received: by 2002:a0c:e9cb:0:b0:532:3af0:136e with SMTP id q11-20020a0ce9cb000000b005323af0136emr5165301qvo.11.1673477889366;
        Wed, 11 Jan 2023 14:58:09 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a44c200b006f87d28ea3asm9710811qkp.54.2023.01.11.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:58:08 -0800 (PST)
Date:   Wed, 11 Jan 2023 17:58:07 -0500
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
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y78+/wleTEC3gyqu@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105101844.1893104-22-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Thu, Jan 05, 2023 at 10:18:19AM +0000, James Houghton wrote:
> @@ -751,9 +761,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
>  		int mapcount = page_mapcount(page);
>  
>  		if (mapcount >= 2)
> -			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
> +			mss->shared_hugetlb += hugetlb_pte_size(hpte);
>  		else
> -			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
> +			mss->private_hugetlb += hugetlb_pte_size(hpte);
>  	}
>  	return 0;

One thing interesting I found with hgm right now is mostly everything will
be counted as "shared" here, I think it's because mapcount is accounted
always to the huge page even if mapped in smaller sizes, so page_mapcount()
to a small page should be huge too because the head page mapcount should be
huge.  I'm curious the reasons behind the mapcount decision.

For example, would that risk overflow with head_compound_mapcount?  One 1G
page mapping all 4K takes 0.25M counts, while the limit should be 2G for
atomic_t.  Looks like it's possible.

Btw, are the small page* pointers still needed in the latest HGM design?
Is there code taking care of disabling of hugetlb vmemmap optimization for
HGM?  Or maybe it's not needed anymore for the current design?

Thanks,

-- 
Peter Xu

