Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A5C6278B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiKNJI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiKNJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EDB1E3D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668416734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQXjHcPTPGjzJPcozw9XlMPufcfNMdzCPnNa7JaQbHE=;
        b=aCOUjX3RWwYlDDYBD6qKqriM5SmWq5UGMT/eVRqcNfVLn2Syg3IwEI6goXCdJoXYm+kOzN
        Ycohbyb2fUA4VwGCbD9BMUM9hfeqHURKQj0qd/zz0BrdvXjk5/lRsuLtHgaq50xdqlOc6X
        uhsSbrJKgvc13In4p3SJ6o6fPE/cgEk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-19-OncrLEU4PgO2aoEIJ_inhQ-1; Mon, 14 Nov 2022 04:05:32 -0500
X-MC-Unique: OncrLEU4PgO2aoEIJ_inhQ-1
Received: by mail-wm1-f69.google.com with SMTP id z15-20020a1c4c0f000000b003cf6f80007cso2696474wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQXjHcPTPGjzJPcozw9XlMPufcfNMdzCPnNa7JaQbHE=;
        b=u5AMeDl/I+znu4hRU7lkrCjWaBv5sWRKC6w81qbkRDw9OvPgsE1us3VVfG4TdPA92Y
         hiAaXtOeOwwNi8X6KjNrAJyv7atT4rKtujXVG7Q1ocpF+sD6W4U01q7J2u15CifD8BER
         XplP3ZuuCEKzkHaqf6VU9GYCo6+AmWyGuu7jureinAde2sFwIPKVwUUvWyAIrI8+FZ6Z
         JW2YuT4fwgqrsS5hsRlGYmLVn8mevl9EZkCByeHs14dp/VfdxW2PaE/1H+U686M9ujJt
         1NvbS+0Gs90SrgLv5HdhtMC7Qivos1oZzCeaz5YR3OLGy0sW3sP3PWqYWEaT11BLnVb9
         4Lwg==
X-Gm-Message-State: ANoB5plVl8W4tktSHY8LBQUI2v0Q2TQKp8hKVXpeyNV4OqxDEClUExem
        zew6Zxl77rc0T1foXAK2cWCF8Eu6TLfLvXORUCZsd7R0E7Cpi/eDd4Z5E2duV5LjYAP5het0WCV
        ujzSo1dQEbaRBbLZwRUE4VM2Y
X-Received: by 2002:a05:600c:1d11:b0:3cf:a6eb:3290 with SMTP id l17-20020a05600c1d1100b003cfa6eb3290mr7351116wms.116.1668416731179;
        Mon, 14 Nov 2022 01:05:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7sZnxZjO9PA2WoU/6SFgkFehlEaEQRXZ25UkYLSrPfGtQBu33zNpdq9IZYvVadzLyMtvS+nw==
X-Received: by 2002:a05:600c:1d11:b0:3cf:a6eb:3290 with SMTP id l17-20020a05600c1d1100b003cfa6eb3290mr7351090wms.116.1668416730828;
        Mon, 14 Nov 2022 01:05:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:8765:6ef2:3111:de53? (p200300cbc703d30087656ef23111de53.dip0.t-ipconnect.de. [2003:cb:c703:d300:8765:6ef2:3111:de53])
        by smtp.gmail.com with ESMTPSA id p2-20020a7bcc82000000b003b50428cf66sm11744715wma.33.2022.11.14.01.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:05:30 -0800 (PST)
Message-ID: <3d3e48cc-687c-8d4e-1e33-c34fb76c284f@redhat.com>
Date:   Mon, 14 Nov 2022 10:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v9 1/3] madvise: use zap_page_range_single for madvise
 dontneed
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Chen <harperchen1110@gmail.com>, stable@vger.kernel.org
References: <20221111232628.290160-1-mike.kravetz@oracle.com>
 <20221111232628.290160-2-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221111232628.290160-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.22 00:26, Mike Kravetz wrote:
> Expose the routine zap_page_range_single to zap a range within a single
> vma.  The madvise routine madvise_dontneed_single_vma can use this
> routine as it explicitly operates on a single vma.  Also, update the mmu
> notification range in zap_page_range_single to take hugetlb pmd sharing
> into account.  This is required as MADV_DONTNEED supports hugetlb vmas.
> 
> Fixes: 90e7e7f5ef3f ("mm: enable MADV_DONTNEED for hugetlb mappings")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> Cc: <stable@vger.kernel.org>


[...]

>   
> -/*
> - * Parameter block passed down to zap_pte_range in exceptional cases.
> - */
> -struct zap_details {
> -	struct folio *single_folio;	/* Locked folio to be unmapped */
> -	bool even_cows;			/* Zap COWed private pages too? */
> -	zap_flags_t zap_flags;		/* Extra flags for zapping */
> -};
> -
>   /* Whether we should zap all COWed (private) pages too */
>   static inline bool should_zap_cows(struct zap_details *details)
>   {
> @@ -1736,19 +1727,27 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>    *
>    * The range must fit into one VMA.
>    */
> -static void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> +void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
>   		unsigned long size, struct zap_details *details)
>   {
> +	unsigned long end = address + size;

Could make that const.

>   	struct mmu_notifier_range range;
>   	struct mmu_gather tlb;
>   
>   	lru_add_drain();
>   	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> -				address, address + size);
> +				address, end);
> +	if (is_vm_hugetlb_page(vma))
> +		adjust_range_if_pmd_sharing_possible(vma, &range.start,
> +						     &range.end);
>   	tlb_gather_mmu(&tlb, vma->vm_mm);
>   	update_hiwater_rss(vma->vm_mm);
>   	mmu_notifier_invalidate_range_start(&range);
> -	unmap_single_vma(&tlb, vma, address, range.end, details);
> +	/*
> +	 * unmap 'address-end' not 'range.start-range.end' as range
> +	 * could have been expanded for hugetlb pmd sharing.
> +	 */
> +	unmap_single_vma(&tlb, vma, address, end, details);
>   	mmu_notifier_invalidate_range_end(&range);
>   	tlb_finish_mmu(&tlb);
>   }


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

