Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ABA60EB20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiJZV76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiJZV7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585524F33
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666821588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNXqWwBEWZqwUkNcA15/4+3p4mEEOSR1ir8+lCD/vgI=;
        b=BjDqeke9qvoxF2lIV8B2OE4BztA6mp6+dZK1ofO7loGwuilxdlC+T2UdPbbWjrklW2Bkci
        9KIOLDyeRDsNvo6i+7DnLzzxFaaaFcdUfQbjHKhdgYJHlB3rnJoFy12RIbR/DhCJAWHyv8
        vX06dtHFZCjHhVIl63lUErHl5irP0qo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-Qu4BXudaMnSzfbzkgEMSfA-1; Wed, 26 Oct 2022 17:59:46 -0400
X-MC-Unique: Qu4BXudaMnSzfbzkgEMSfA-1
Received: by mail-qv1-f69.google.com with SMTP id mo15-20020a056214330f00b004b96d712bccso9939626qvb.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNXqWwBEWZqwUkNcA15/4+3p4mEEOSR1ir8+lCD/vgI=;
        b=qH/PT7HnpOGf6gyhT9kKWy+/LzHzGzf7gPKF1CgZSoSjw89KgFx7Ly6X2XI7EgHuG7
         f45qcEXF++I3A+mzkf38y7uaRFNaJHjBf4IE8jAoYb6gU1wn84FYokLPK131EG3nygRu
         RH14/1DajWSffSPkNNqHmeWh4j8PcjYLHy7Zdh+eHDevWY754EEJtmq5BBg9ibsmn6bX
         x06JPZqNI2hXefJTItJOWVUQ8KNoKwEG1aGcBXTSg9szZmkWe27KaQWGjYRCg2YqYha7
         CZE6n+0b6WLQOBOCKFylNEzIeLeIif7+cS2ZQlsqBc4UaMPcWT05lPElY0azjYq3G8tL
         gWwg==
X-Gm-Message-State: ACrzQf2xYX35NKeXg11sVp2RnVjo6ld3y7Axf2PRxXZdmBzET+6fXkLc
        bVjRhE2dqp4CyLvVvZ7anYXrdOmZyZBSO8LY5kLMbFefSVHSFMrlsYH7JlyUHLNo5KLbumoH7vs
        bVR5TsEQoDtN+ayQSuO/Lop2o
X-Received: by 2002:a05:6214:258f:b0:4bb:96dc:9081 with SMTP id fq15-20020a056214258f00b004bb96dc9081mr3792318qvb.56.1666821585876;
        Wed, 26 Oct 2022 14:59:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6clLhoqa4dyYP9jIEoFLifg0EVVqBR8GsJ2D+FA1fUGq9jZpwSidSVqlrnZh8mjpv+r4IZSQ==
X-Received: by 2002:a05:6214:258f:b0:4bb:96dc:9081 with SMTP id fq15-20020a056214258f00b004bb96dc9081mr3792307qvb.56.1666821585663;
        Wed, 26 Oct 2022 14:59:45 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id gd27-20020a05622a5c1b00b0039c37a7914csm2840053qtb.23.2022.10.26.14.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:59:45 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:59:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Y1mtz7dFAlhGRsAd@x1n>
References: <20220919021348.22151-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220919021348.22151-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Sun, Sep 18, 2022 at 07:13:48PM -0700, Mike Kravetz wrote:
> +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +				unsigned long address, unsigned int flags)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long haddr = address & huge_page_mask(h);
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t *pte, entry;
> +
> +	/*
> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> +	 * follow_hugetlb_page().
> +	 */
> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
> +		return NULL;
> +
> +retry:
> +	/*
> +	 * vma lock prevents racing with another thread doing a pmd unshare.
> +	 * This keeps pte as returned by huge_pte_offset valid.
> +	 */
> +	hugetlb_vma_lock_read(vma);

I'm not sure whether it's okay to take a rwsem here, as the code can be
called by e.g. FOLL_NOWAIT?

I'm wondering whether it's fine to just drop this anyway, just always walk
it lockless.  IIUC gup callers should be safe here because the worst case
is the caller will fetch a wrong page, but then it should be invalidated
very soon with mmu notifiers.  One thing worth mention is that pmd unshare
should never free a pgtable page.

IIUC it's also the same as fast-gup - afaiu we don't take the read vma lock
in fast-gup too but I also think it's safe.  But I hope I didn't miss
something.

-- 
Peter Xu

