Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F0D730287
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbjFNO63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjFNO61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AAF1A7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686754662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uppa3uWzfF5tvk9avd6pQ9IphfaAL83xnkk0Cjs6Hhk=;
        b=QqQF3gPD/L1teKwah2+Dj9mq75Uio5rRaGQgfqonxora3y4wCGWsh0/qI8COZq2SI0Y92D
        84WSKMHjhYiCYOandIxUL8Rl6QFRriUkSAwEZng3Da3KSoqRtIfXwtdfZWXyj2D2qkxbHX
        VfOj8r3R42vM/SG7qydHFOxuxQ/pJmo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-muitaGOlOMe62ouaprSYTw-1; Wed, 14 Jun 2023 10:57:41 -0400
X-MC-Unique: muitaGOlOMe62ouaprSYTw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7f77ac6b6so5764255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754659; x=1689346659;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uppa3uWzfF5tvk9avd6pQ9IphfaAL83xnkk0Cjs6Hhk=;
        b=Pe3fp3RK3SuDjvFTaqcs4nxffyDy5ZKr+0r19PRz7rEP1GGW88FQ1dYwW7q7Vncw0z
         OAqZ7qnLIewo6KBWI6PieXQA2KUHGy0vibaV0hE3flPQIatskaGNXoNDzYBsFn4cMI0Z
         UKeqx87Ee++mEZWd43ZDME/Ohvpnl8Bt0eII/CmxqhZI82AOrpGytHHPj4CNJiV91xSj
         nkKFZ7CXAi1ev357JIdk1MvsPpqgOJCC8+3+L8c7KjXkIHnR/bWiZ2zfEH5s0fzs5dTI
         MdOJyRdzTQ19+yJj9CesvHbE8chy4kWBUFs31/1gxl0WCam16VYyTGeL88ayqWYS77D6
         5aHg==
X-Gm-Message-State: AC+VfDwatb2tdV1WSV+FerduglnfGNaLHzSvnBQupqzpd/PFYYdzp5xu
        I/BwQK6x2Oj28Mq4RXOjkH7lKFbsC+kd+eGga9UJblsDWQSdYlmhzLnTjGVv0/WS1NrKbCL700k
        dzpa+0fZ17QdLBnxvrV2mSgmFYEC96j/U
X-Received: by 2002:a05:600c:2948:b0:3f7:3a11:e3ae with SMTP id n8-20020a05600c294800b003f73a11e3aemr13311863wmd.38.1686754659497;
        Wed, 14 Jun 2023 07:57:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6I7h1wgATJMLGDmmkyARD4Su7DI+YrvaeE8V1DcZiJhjoRIYauvU/WmxrswjRJeCtwb2mqog==
X-Received: by 2002:a05:600c:2948:b0:3f7:3a11:e3ae with SMTP id n8-20020a05600c294800b003f73a11e3aemr13311853wmd.38.1686754659123;
        Wed, 14 Jun 2023 07:57:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c114a00b003f7e60622f0sm17749133wmz.6.2023.06.14.07.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 07:57:38 -0700 (PDT)
Message-ID: <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com>
Date:   Wed, 14 Jun 2023 16:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613215346.1022773-5-peterx@redhat.com>
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

On 13.06.23 23:53, Peter Xu wrote:
> It's coming, not yet, but soon.  Loose the restriction.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f037eaf9d819..31d8f18bc2e4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6467,13 +6467,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	spinlock_t *ptl;
>   	pte_t *pte, entry;
>   
> -	/*
> -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> -	 * follow_hugetlb_page().
> -	 */
> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> -		return NULL;
> -
>   	hugetlb_vma_lock_read(vma);
>   	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
>   	if (!pte)
Did you fix why the warning was placed there in the first place? (IIRC, 
at least unsharing support needs to be added, maybe more)

-- 
Cheers,

David / dhildenb

