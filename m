Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D9730369
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbjFNPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjFNPSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907311B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686755838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJJSEeqK6QXbXzLAxpLoHNxXrX7Cx+/0FsKlU9Zst5Q=;
        b=K1UBbJzdwTj0foxQcLKjoLUoFXbCGMb//BHKvXyNBAC22f/UhwUHBFqEbIoUjGA9IFpqHJ
        6pmg0zNWmstHtSUdblqO+ez08EEvQyeblDn3k89Qc3IPoSeA/jz+J3vy5P7g32Ocpv8G4y
        pQCYgAhs9IjlQXEIMs+0eNCvsC8eAOk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-yUhkZ3JJME2neTYv06iuog-1; Wed, 14 Jun 2023 11:17:17 -0400
X-MC-Unique: yUhkZ3JJME2neTYv06iuog-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f80e7e15b0so5197785e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686755835; x=1689347835;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJJSEeqK6QXbXzLAxpLoHNxXrX7Cx+/0FsKlU9Zst5Q=;
        b=FIquESA89woqoKI5Y3RzCwsqGi8QA9MlyQZfsHjnXEtKdxjZIkH5/DVJiBMUmT9E+u
         k7n+We2TyJ7E0pBQeCNr//IJchJ/1gz46id1NOZ6L/H5wYxUcOr/lNSlnyt1d/uL38eG
         I8IchXgQwGa9BG4mUf8qoKNYyQ5uqUTIp8pQO09ot0Sn7T/tSHom3JlyDIkD0Ou7mLiF
         53KxnGD83cuxuXZorCzEooR8NQepan7E04ZFVNyrPE+X6glboq79GuWlbscxRH971awa
         qoKmUAUPZu3DcC036yrmbac0+fj9P9SNHpLFu6RhJ+OkDPqenECq1bT2mDNqYx5hR+zw
         BJ6A==
X-Gm-Message-State: AC+VfDwD6daD3EBB5vMveQD1zwCC9hp2jwLc08NStvpDwnSHPHdv/g+t
        LxOEC9Pi5nVEWAu/NOMj8Dhplwgqyt3R30Vc5UMohZxu1LuOOp11SJ7SgzsnVfWJ7W0lVULarQp
        XU84/Sqa65fyZT9odO95vU33V
X-Received: by 2002:a05:600c:220d:b0:3f7:e443:c5b3 with SMTP id z13-20020a05600c220d00b003f7e443c5b3mr11985659wml.21.1686755835722;
        Wed, 14 Jun 2023 08:17:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vgbgSXDfygOhFoX+6Zhq//KxnkS8I2CfIy8ie18zUjYJRAARJd1KYOFZ7bR8rGHX9ZJUSng==
X-Received: by 2002:a05:600c:220d:b0:3f7:e443:c5b3 with SMTP id z13-20020a05600c220d00b003f7e443c5b3mr11985636wml.21.1686755835391;
        Wed, 14 Jun 2023 08:17:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id e16-20020adffc50000000b0030fbb834074sm10722810wrs.15.2023.06.14.08.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 08:17:14 -0700 (PDT)
Message-ID: <ef0f8e0e-cbce-7c7b-1b0e-c9d52ede7e0e@redhat.com>
Date:   Wed, 14 Jun 2023 17:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-5-peterx@redhat.com>
 <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com> <ZInYh3cVUil9R/cf@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZInYh3cVUil9R/cf@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.23 17:11, Peter Xu wrote:
> On Wed, Jun 14, 2023 at 04:57:37PM +0200, David Hildenbrand wrote:
>> On 13.06.23 23:53, Peter Xu wrote:
>>> It's coming, not yet, but soon.  Loose the restriction.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    mm/hugetlb.c | 7 -------
>>>    1 file changed, 7 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index f037eaf9d819..31d8f18bc2e4 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -6467,13 +6467,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>>>    	spinlock_t *ptl;
>>>    	pte_t *pte, entry;
>>> -	/*
>>> -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
>>> -	 * follow_hugetlb_page().
>>> -	 */
>>> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
>>> -		return NULL;
>>> -
>>>    	hugetlb_vma_lock_read(vma);
>>>    	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
>>>    	if (!pte)
>> Did you fix why the warning was placed there in the first place? (IIRC, at
>> least unsharing support needs to be added, maybe more)
> 
> Feel free to have a look at patch 2 - it should be done there, hopefully in
> the right way.  And IIUC it could be a bug to not do that before (besides
> CoR there was also the pgtable permission checks that was missing).  More
> details in patch 2's commit message.  Thanks,

Oh, that slipped my eyes (unsharing is not really a permission check) -- 
and the patch description could have been more explicit about why we can 
now lift the restrictions.

For the records: we don't use CoR terminology upstream. As suggested by 
John, we use "GUP-triggered unsharing".

As unsharing only applies to FOLL_PIN, it doesn't quite fit into patch 
#2. Either move that to this patch or squash both.

-- 
Cheers,

David / dhildenb

