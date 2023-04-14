Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B486E1F36
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDNJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDNJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C88E1FD0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681464243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvOLASBCFEOc9YBL3l0OiDTQxA+MtSDI4aNYMHu4+zI=;
        b=Tm8LEbgmQDNmiNe22qCLQlVVRErRJerNLs7nM6iXYGQZHLq+gNn6b4l8Ta2JjvdFl2+Voy
        FoKZhQ5lzyuOutpbiKqcr4qY/p8LA278FhuipUZzkNAkT+EfqTM66I/0/P2gx1zDo/0TTG
        ZjMY+tpi8bHueYHfJuJba4zU6Dfj4KY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-6j_A5xM3OjilrIws9qdD1A-1; Fri, 14 Apr 2023 05:23:59 -0400
X-MC-Unique: 6j_A5xM3OjilrIws9qdD1A-1
Received: by mail-wr1-f70.google.com with SMTP id o15-20020adfba0f000000b002f78e5a7c4eso119762wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681464238; x=1684056238;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvOLASBCFEOc9YBL3l0OiDTQxA+MtSDI4aNYMHu4+zI=;
        b=Z5kyQ8yRtpToeaZ14KevfyLnNL3KZ85pvK5/WM6ab0S2jp+65dW+US6mEwwXIq3rmO
         uZ+eCC4QB2DD0cwYcEzIvY6w7vCUOp3DmXOmREc+5TlfpIxotVmqM4q04UyI7fgL6EUi
         m8nDVF5hYQvAUGaKceVvtN1ElveWe5yp48yHKygYylFLI/COOI9cHmmamLpdABo0RKjS
         nchiFfebsCB0qJig4eqXVaGOqisc8qa2E3TGbwR8aEyCzsz4Zqwb4FGQ0YyRCx7P46oV
         kh2U3L9JX1twlSYi/PLX86SW17D6ubrzgmLDMl4zTU+9q8GXXZ3CYt0SD3/644oZzRtN
         Yc4g==
X-Gm-Message-State: AAQBX9ctkimkRq7/HHdCvEZgbtLzvGDTfP3zRlP7BKsspaai4RH+S5sc
        FGvgq+dOjIPLd+AwfZd5ErNgJXvbjopLEYKf3BIZhWh/eDI6FibvVERMbn/WOAErkaoBFVxynGm
        ZQQDECGJuTVdTwMCgzw4K22xe
X-Received: by 2002:a7b:ca57:0:b0:3ed:4685:4618 with SMTP id m23-20020a7bca57000000b003ed46854618mr3937931wml.34.1681464238753;
        Fri, 14 Apr 2023 02:23:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZF60jwIOJ0EpMbzUuPDkXV6JJgi6MUazql5owLo6WvTPBwkgfjeKOAqDpjL/QnCTeALgjMJA==
X-Received: by 2002:a7b:ca57:0:b0:3ed:4685:4618 with SMTP id m23-20020a7bca57000000b003ed46854618mr3937918wml.34.1681464238392;
        Fri, 14 Apr 2023 02:23:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bca48000000b003f0373d077csm3793274wml.47.2023.04.14.02.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 02:23:57 -0700 (PDT)
Message-ID: <a8bc8c64-e436-7bd8-a160-11253cd269ad@redhat.com>
Date:   Fri, 14 Apr 2023 11:23:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/6] mm/hugetlb: Fix uffd-wp bit lost when unsharing
 happens
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-stable <stable@vger.kernel.org>
References: <20230413231120.544685-1-peterx@redhat.com>
 <20230413231120.544685-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230413231120.544685-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.23 01:11, Peter Xu wrote:
> When we try to unshare a pinned page for a private hugetlb, uffd-wp bit can
> get lost during unsharing.  Fix it by carrying it over.
> 
> This should be very rare, only if an unsharing happened on a private
> hugetlb page with uffd-wp protected (e.g. in a child which shares the same
> page with parent with UFFD_FEATURE_EVENT_FORK enabled).
> 
> Cc: linux-stable <stable@vger.kernel.org>
> Fixes: 166f3ecc0daf ("mm/hugetlb: hook page faults for uffd write protection")
> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7320e64aacc6..083aae35bff8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5637,13 +5637,16 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	spin_lock(ptl);
>   	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
>   	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
> +		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
> +
>   		/* Break COW or unshare */
>   		huge_ptep_clear_flush(vma, haddr, ptep);
>   		mmu_notifier_invalidate_range(mm, range.start, range.end);
>   		page_remove_rmap(old_page, vma, true);
>   		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
> -		set_huge_pte_at(mm, haddr, ptep,
> -				make_huge_pte(vma, &new_folio->page, !unshare));
> +		if (huge_pte_uffd_wp(pte))
> +			newpte = huge_pte_mkuffd_wp(newpte);
> +		set_huge_pte_at(mm, haddr, ptep, newpte);
>   		folio_set_hugetlb_migratable(new_folio);
>   		/* Make the old page be freed below */
>   		new_folio = page_folio(old_page);

LGTM, thanks

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

