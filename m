Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B434738308
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjFULRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFULRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41ED18C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687346173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fnhuWzdBfkar4+hdkMDDz6Iqk6jdX4zAVvcaAIwIr8=;
        b=OqPrb7ZLhugWK1GRlNinB5b4C9mRIujv43Np5141tb8EjpzpuPxIsaeT87qISAubuLLOo8
        oCcltPMgCwE/asy+25/IPyjIi2l7IzHtNKO6aKIa4vkSIzk+MdnOrhf0EXR+3UUaweTio1
        mICSnWsI0SicDZeUjqcK8PAPyuQ2kqc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-h9D5XfnzMlaRY0Pa8rJY9A-1; Wed, 21 Jun 2023 07:16:12 -0400
X-MC-Unique: h9D5XfnzMlaRY0Pa8rJY9A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31275586740so1312310f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346171; x=1689938171;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fnhuWzdBfkar4+hdkMDDz6Iqk6jdX4zAVvcaAIwIr8=;
        b=WVDn7awFmozvnKDcKPbD3PmlfKAPSzjy7eZoShJvPgPjPNTkFmfMzEpFW9Q6M2AGeR
         +qAix/ZYjKyHYuYwFhiH965XujYgmXZ239Lkhp8wmoNFKu6wCrBugOEvj7BrKgkt5xN8
         GyPeBkXhYhGvmxiqBLKtyultlfygLiebJMDlRkhWROMAUOt0aIDSe8u7ZPUuraDdNQaK
         5rKJ73LOB7ye6KGhofspiNZdkYvbXXqGMB4JVcz8wffK9tzMAVrTJaBT5HJ1EKNeTnXB
         eLvey9xH8s3vzcjAJE3Ahrw3+JQ+K8mI44mf/YEE+zl+2Wi1JliRzoWJlLkxBHZ05Sxh
         +krQ==
X-Gm-Message-State: AC+VfDxaCDcR8T9vgY/5aiQ+oEgAkpY+ueje0mK25ekSFMkHwZtXTB6q
        P35h61ckj5G4fsN/KB4T01QeALD5QLktINJOTbio70MTtJNNbHB7Wl4F1wjuBpwDrDS9vr5UgKC
        EaEUIiw+02/X8fecAJ4P7un+Ka7cpghf9
X-Received: by 2002:a5d:538b:0:b0:30a:b3c4:3b8d with SMTP id d11-20020a5d538b000000b0030ab3c43b8dmr14642953wrv.41.1687346171173;
        Wed, 21 Jun 2023 04:16:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nq5w3zbOV5Ltq1LgoMFUtlUu6NJWp8HfGSS4V3Lye+jtg/ZXPvFGiVckUSDLFBBLXHZSA/w==
X-Received: by 2002:a5d:538b:0:b0:30a:b3c4:3b8d with SMTP id d11-20020a5d538b000000b0030ab3c43b8dmr14642931wrv.41.1687346170806;
        Wed, 21 Jun 2023 04:16:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:9c00:7978:3030:9d9a:1aef? (p200300cbc70b9c00797830309d9a1aef.dip0.t-ipconnect.de. [2003:cb:c70b:9c00:7978:3030:9d9a:1aef])
        by smtp.gmail.com with ESMTPSA id a1-20020adff7c1000000b0030fafcbbd33sm4172812wrq.50.2023.06.21.04.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 04:16:10 -0700 (PDT)
Message-ID: <490e71a6-e5fb-e063-5c0e-20085548f88e@redhat.com>
Date:   Wed, 21 Jun 2023 13:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: page_alloc: use the correct type of list for free
 pages
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <7e7ab533247d40c0ea0373c18a6a48e5667f9e10.1687333557.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7e7ab533247d40c0ea0373c18a6a48e5667f9e10.1687333557.git.baolin.wang@linux.alibaba.com>
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

On 21.06.23 10:14, Baolin Wang wrote:
> Commit bf75f200569d ("mm/page_alloc: add page->buddy_list and page->pcp_list")
> introduces page->buddy_list and page->pcp_list as a union with page->lru, but
> missed to change get_page_from_free_area() to use page->buddy_list to clarify
> the correct type of list for a free page.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5c691426822a..c1839a53326c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -727,7 +727,7 @@ static inline struct page *get_page_from_free_area(struct free_area *area,
>   					    int migratetype)
>   {
>   	return list_first_entry_or_null(&area->free_list[migratetype],
> -					struct page, lru);
> +					struct page, buddy_list);
>   }
>   
>   /*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

