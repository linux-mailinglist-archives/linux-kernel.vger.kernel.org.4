Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5231E737067
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjFTPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjFTPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A93A4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687274654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jZI8VCXZuXM8omQpTyWulHnxj1e7QD/bvDv9W/ML+Y=;
        b=KW/uXM3HyGqRu6o3ruuYEH5rUGzkOUqiea6iii1Zd6HTeI6LDIuZgT/eIgmt1bhZgaYm+/
        7gX/kfUsGTUCA0vXfu4k3Y1WvfjqC2/nFKucdC2b0dQh54b0ALmJZds4OhLfmHg1hn0n1i
        OT1u9oDC8mhU3fJCYDCbgfB4zrpESno=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-FEGCQLT3MES3Ma3Hc-uzfg-1; Tue, 20 Jun 2023 11:24:06 -0400
X-MC-Unique: FEGCQLT3MES3Ma3Hc-uzfg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4ecb00906d0so1731564e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274641; x=1689866641;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jZI8VCXZuXM8omQpTyWulHnxj1e7QD/bvDv9W/ML+Y=;
        b=VGqGT+3FgVsv3zkgrKeZR3RQnDE19n7YXjp+m2BhgTYzWvNowhoX8Z3xXnbtA+FtlW
         qfS2DBk1zK1ZK8gZYYS5M+Yj5YrS6pvk0E3zObvaggdNIhCI2Wn8NB3zMnvlwzJhidcY
         eoFooph/c/lmQG+ShtorPTk2LnMtyNh+wVFBHdZfxGeO221S+Tcg69NOU9W+b/9U54Lp
         EInYaYkLI5x6wjuTu+xsFqemksjg0cIeKdZOd52SBHbQwfuk+s0T0Mj3i0njgOvzPPOL
         avW7L7Y1F8zrItnnomK8E4x/FgLu+80r82L9JOtDnN34BtlA+hvpEYNiZFIs78E63E2o
         i++A==
X-Gm-Message-State: AC+VfDy+7BkETEe82SZNgyzS+qQIX9Q/9DYSk+pvVDiCk5H/E//kucGx
        OkuXMSGF3XnInwxn0bH3nauesORCkKX74CFlCBuid860kYDvt64EGj2djmX9dV8MNx3d9KrnIya
        U6+fhNJIvfBpLfSX2lyPNWXdh
X-Received: by 2002:a19:5e01:0:b0:4f6:45af:70b8 with SMTP id s1-20020a195e01000000b004f645af70b8mr7261837lfb.58.1687274641308;
        Tue, 20 Jun 2023 08:24:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Y3rF0ME/txUd/uYe0tBQ1/QOJOfNykKQCjCvsEGedq6dIPBTjUzKm3PIFzTzLtyE7xur7KQ==
X-Received: by 2002:a19:5e01:0:b0:4f6:45af:70b8 with SMTP id s1-20020a195e01000000b004f645af70b8mr7261812lfb.58.1687274640644;
        Tue, 20 Jun 2023 08:24:00 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23bc9.dip0.t-ipconnect.de. [79.242.59.201])
        by smtp.gmail.com with ESMTPSA id z8-20020a05600c220800b003f9b12b1598sm5631222wml.22.2023.06.20.08.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:24:00 -0700 (PDT)
Message-ID: <451b1e7c-3669-7b55-7daa-9a2911aaf5c5@redhat.com>
Date:   Tue, 20 Jun 2023 17:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/8] mm/gup: Cleanup next_page handling
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-5-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230619231044.112894-5-peterx@redhat.com>
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

On 20.06.23 01:10, Peter Xu wrote:
> The only path that doesn't use generic "**pages" handling is the gate vma.
> Make it use the same path, meanwhile tune the next_page label upper to
> cover "**pages" handling.  This prepares for THP handling for "**pages".
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/gup.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 9fc9271cba8d..4a00d609033e 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1124,7 +1124,7 @@ static long __get_user_pages(struct mm_struct *mm,
>   			if (!vma && in_gate_area(mm, start)) {
>   				ret = get_gate_page(mm, start & PAGE_MASK,
>   						gup_flags, &vma,
> -						pages ? &pages[i] : NULL);
> +						pages ? &page : NULL);
>   				if (ret)
>   					goto out;
>   				ctx.page_mask = 0;
> @@ -1194,19 +1194,18 @@ static long __get_user_pages(struct mm_struct *mm,
>   				ret = PTR_ERR(page);
>   				goto out;
>   			}
> -
> -			goto next_page;
>   		} else if (IS_ERR(page)) {
>   			ret = PTR_ERR(page);
>   			goto out;
>   		}
> +next_page:
>   		if (pages) {
>   			pages[i] = page;
>   			flush_anon_page(vma, page, start);
>   			flush_dcache_page(page);
>   			ctx.page_mask = 0;
>   		}
> -next_page:
> +
>   		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
>   		if (page_increm > nr_pages)
>   			page_increm = nr_pages;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

