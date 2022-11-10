Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3B624C99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKJVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiKJVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:08:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B8C14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668114438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEIJGZANE1T8izU7X7oDY3JcOnGtojmHOdUtf96UKvA=;
        b=cuVgm6VxjHWs+ZCgtKtzRHNYubP0a6ZZXJCbwSLqiUA2j71+fsG9kS1HcVoBUbkjThQLvS
        ERxdNPk07i+Gm4QXaxATCTNX2Rr8b64UYUJU5Lk5z6a2DT3eje9XWCCj0fWwfHuMx+A37e
        2VmbUlzuRFImQdxN1tmL08/79u5gy7A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-101-Nl3jlJ0wOsKOT-B2QFsDqQ-1; Thu, 10 Nov 2022 16:07:16 -0500
X-MC-Unique: Nl3jlJ0wOsKOT-B2QFsDqQ-1
Received: by mail-qv1-f72.google.com with SMTP id ln3-20020a0562145a8300b004b8c29a7d50so2386164qvb.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEIJGZANE1T8izU7X7oDY3JcOnGtojmHOdUtf96UKvA=;
        b=y7+vYq6QYQOShfpxGj+Q+92f506etXoPDV50xH77ykCox9MDlwfk8FNGoWroGD4mmD
         eEdiGahAL/3xbOMhgX2eSumMG0yKvJHGwW/55ewl3uh3elXjLbVXPZ32TOAM5mCrhVuU
         nMSt82tth5xO+vcb4l7sLBFnOW+INLzM/PGiwALcJfnV7jWO7xfydHg3iCtat0q7nyDm
         IGQmar0JiZiKWT1kqJHEfzBA41Iz0UFmqRvWQZOySQYwepXKpcWZ0Hhr2EI0zRLQHRMR
         xq0Cx/mXdbpI2/pgy56lgOoknWSc0YpvB/+PlzpTo/C6pDUjinuMw70p8yjjmbJJWDoL
         8hgw==
X-Gm-Message-State: ACrzQf0hG6ez+04+LYXuRXtJQHTdwqxVRLhgAH9IlzLz38WuBXGtWXfY
        f+m4sVjqQzBvhfJYzKDCY7kVq2gWe7SiV6zThPpqcdqqQpMjvDkDr9+oV+/bUdVLxEAP9f943CH
        EM2fnawBqyqyVb3zJJywrUAGs
X-Received: by 2002:ac8:5245:0:b0:35c:ba3b:8a0c with SMTP id y5-20020ac85245000000b0035cba3b8a0cmr1859636qtn.138.1668114436248;
        Thu, 10 Nov 2022 13:07:16 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6M4K3jw0WUcNK171zqSpFP6TK1Xa1jrFSqY5iW0uY88NWreMMO+nhyti4GfcfuEp9h9wCqQA==
X-Received: by 2002:ac8:5245:0:b0:35c:ba3b:8a0c with SMTP id y5-20020ac85245000000b0035cba3b8a0cmr1859602qtn.138.1668114436014;
        Thu, 10 Nov 2022 13:07:16 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id ff5-20020a05622a4d8500b0039cc47752casm166672qtb.77.2022.11.10.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:07:15 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:07:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Chen <harperchen1110@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v8 1/2] hugetlb: don't delete vma_lock in hugetlb
 MADV_DONTNEED processing
Message-ID: <Y21oAisW6AswiNIv@x1n>
References: <20221108011910.350887-1-mike.kravetz@oracle.com>
 <20221108011910.350887-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221108011910.350887-2-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it'll also be good if we split this into a few smaller ones?

For example:

On Mon, Nov 07, 2022 at 05:19:09PM -0800, Mike Kravetz wrote:
> Address issue by:
> - Add a new zap flag ZAP_FLAG_UNMAP to indicate an unmap call from
>   unmap_vmas().  This is used to indicate the 'final' unmapping of a vma.
>   When called via MADV_DONTNEED, this flag is not set and the vm_lock is
>   not deleted.

One patch to fix the real thing (patch 2).

> - mmu notification is removed from __unmap_hugepage_range to avoid
>   duplication, and notification is added to the other calling routine
>   (unmap_hugepage_range).

One patch to fix the mmu notifier (patch 1).

> - notification range in zap_page_range_single is updated to take into
>   account the possibility of hugetlb pmd sharing.

Part of patch 2.

> - zap_page_range_single renamed to __zap_page_range_single to be used
>   internally within mm/memory.c
> - zap_vma_range() interface created to zap a range within a single vma.

Another patch 3 for the two.

> - madvise_dontneed_single_vma is updated to call zap_vma_range instead of
>   zap_page_range as it only operates on a range within a single vma

Part of patch 2.

Then patch 1 & 2 will need to copy stable, 3 won't need to.  Patch 2 in
this series will be patch 4.  Not sure whether that looks cleaner.

Mike, sorry again if this is too late as comment, feel free to go with
either way you think proper.

Thanks,

-- 
Peter Xu

