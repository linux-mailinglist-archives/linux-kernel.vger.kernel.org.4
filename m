Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD073D92E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFZIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjFZIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB371B6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687766937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqoKmhBlTtHVnB8gm1nDpTAgK/1vm8kZHpYD3t91RRo=;
        b=LhwkjHo9UilqMmjQbHQwGCRLEWaxs/Grh5nL3514jwVCG0ZT21PON6uYwxi60J2AfJuKIq
        U1JLEK/mYO8bbuq3G1UzZlJjpsI85AtBC1+eyUzp1JKlPfc81AZAWUDXn7j6suMO32LDSt
        bi5QWWbsAhveNpG+BdSwM2CdhE4ZEAc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-geUHAD2JMWS4EaCL9rP_iQ-1; Mon, 26 Jun 2023 04:08:55 -0400
X-MC-Unique: geUHAD2JMWS4EaCL9rP_iQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313c930ee0eso961619f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687766934; x=1690358934;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqoKmhBlTtHVnB8gm1nDpTAgK/1vm8kZHpYD3t91RRo=;
        b=BWUxQpnnf6DOMJhKGxJnllTcjkBeCXJs5u4l9TjNfPSmHx8SziDGcPCZGdivRqAtNC
         TP1gtJCeo8Z+lxKFm4+Jeo6005Zv38n37S3eAakXcG8jYo48vKVGLO0DpUJ4HtGBfsRP
         OLjG1U+qjiesDCoR0nuoEjYDaDkhdDxCCUy/bWMZbmWML9FUPZeOECifHLQ9LiyIZdB9
         ywRDGJ+IlSuA8i//0PHWvwPx3ZXdU5xwtIolXvuqBCIftUOLT5EXuSfMjHk2IdACKxrf
         100uPqQGar825XqD+fmaFD8vh7t0V4oc/044tFXDXMj1PPxFjxOfX4y/R0xhEBgaMa7H
         t+2A==
X-Gm-Message-State: AC+VfDxVgWeqFBJ+eD4FxGhEK2CSEd8imhXuj//9vjUK+lMLGEGPe39X
        K84XnsH61BTjbovEqwy5VRHzTgt2lkkSeNLzFacCVT1yXnsT/2qMoWX9ewPALEDNMKsGFsOj7gR
        Jp6UGr/1bHOITklYaHvUuwRHV
X-Received: by 2002:a05:6000:184:b0:309:1532:8287 with SMTP id p4-20020a056000018400b0030915328287mr7714295wrx.19.1687766933841;
        Mon, 26 Jun 2023 01:08:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vrW3QD+fALJOHKAeyTZOgWHyoDD3cvdBTB698WGYKApvEdp0JvIQl5yjuAql2P8EKvsrXig==
X-Received: by 2002:a05:6000:184:b0:309:1532:8287 with SMTP id p4-20020a056000018400b0030915328287mr7714271wrx.19.1687766933528;
        Mon, 26 Jun 2023 01:08:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:7300:2ef6:6cd6:703c:e498? (p200300cbc74b73002ef66cd6703ce498.dip0.t-ipconnect.de. [2003:cb:c74b:7300:2ef6:6cd6:703c:e498])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d590a000000b002fda1b12a0bsm6643196wrd.2.2023.06.26.01.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 01:08:52 -0700 (PDT)
Message-ID: <f0bff8d9-db44-a1e8-8617-c72ac87d3678@redhat.com>
Date:   Mon, 26 Jun 2023 10:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 6/8] mm/gup: Retire follow_hugetlb_page()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230623142936.268456-1-peterx@redhat.com>
 <20230623142936.268456-7-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230623142936.268456-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.23 16:29, Peter Xu wrote:
> Now __get_user_pages() should be well prepared to handle thp completely,
> as long as hugetlb gup requests even without the hugetlb's special path.
> 
> Time to retire follow_hugetlb_page().
> 
> Tweak misc comments to reflect reality of follow_hugetlb_page()'s removal.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/userfaultfd.c        |   2 +-
>   include/linux/hugetlb.h |  12 ---
>   mm/gup.c                |  19 ----
>   mm/hugetlb.c            | 224 ----------------------------------------
>   4 files changed, 1 insertion(+), 256 deletions(-)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

