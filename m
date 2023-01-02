Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6602F65B1E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjABMUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjABMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB58DB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672661970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3FODd3kGWx9t7PABnYSEMYuyTSxNy9JUSZLPt4AykuY=;
        b=R6Y58n0H8g6g4Hxgc2xE+gLUERbUtzDD4LsfN56+usehT7/SKxG20WyUbJzPZw62bAQiLy
        HQ6R5ht1o/cQ3faT5RUUKhBGsAsEM1+OLgSy/0p736txbbzICWcYpn2EnD2VP7kmndCKhl
        4St3PMMHkbWeL4z7Fe97AfQEeH0axUQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-pQcM74loPHKC5WYz60ircw-1; Mon, 02 Jan 2023 07:19:29 -0500
X-MC-Unique: pQcM74loPHKC5WYz60ircw-1
Received: by mail-wm1-f72.google.com with SMTP id bi18-20020a05600c3d9200b003d991844dbcso8909301wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FODd3kGWx9t7PABnYSEMYuyTSxNy9JUSZLPt4AykuY=;
        b=zaPepywNuPnBsztJylGoZ1fifw68EUegYwEnPfenaQjflvNfP1XpzTG8UJwxZUsH/V
         3jJLC/OB/MqBya1WtVKv62nuTdTsOI6hzxe8qVUiDlJsnqJ3ucO1bkDWf0tX0AzjK/5B
         MZBhR1YoaWXFcpikIuGlB6nWFctyOql4buMdhOW1sDi6wpQVs3MAFly9/qdc5QGdpWeL
         CXDtE+co8/UZNkcFT8JwIo1PF77PGd+abahRxfdpYP4bLftYccZOfx3+bWGKbo8aSeFp
         90MV6uJP1L51fqiToEX7h3AZUDP5UEE0TJkJpV36Dd0LPYprClYejvZcp3MJM/zozx37
         l+bA==
X-Gm-Message-State: AFqh2kqj8sLbFuLOjGY2jXxe6KMK+VCUkLINRAo5vDIna2ep9HjinxcM
        wRi891t07FnAOViTBR4wYdyllKXtfNXfkq//K3Bdngi8ZyZkBWfU6Z1yrgsPEJwTre0ihFckLmc
        uxSSh8aM+6lmexZxWjh39u25n
X-Received: by 2002:a05:6000:d1:b0:242:5698:6faf with SMTP id q17-20020a05600000d100b0024256986fafmr22987906wrx.2.1672661967832;
        Mon, 02 Jan 2023 04:19:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs5O0SGuhbAZjQkC8D/U4UAhuOiSy0N3xtmGR4yQ6L0PGk1sQtj6t9ER56CVRcBP0nJWGWE/w==
X-Received: by 2002:a05:6000:d1:b0:242:5698:6faf with SMTP id q17-20020a05600000d100b0024256986fafmr22987892wrx.2.1672661967513;
        Mon, 02 Jan 2023 04:19:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b002426d0a4048sm27893690wrr.49.2023.01.02.04.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 04:19:27 -0800 (PST)
Message-ID: <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com>
Date:   Mon, 2 Jan 2023 13:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow
 anon_vma
In-Reply-To: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.22 21:41, Hugh Dickins wrote:
> uprobe_write_opcode() uses collapse_pte_mapped_thp() to restore huge pmd,
> when removing a breakpoint from hugepage text: vma->anon_vma is always
> set in that case, so undo the prohibition.  And MADV_COLLAPSE ought to be
> able to collapse some page tables in a vma which happens to have anon_vma
> set from CoWing elsewhere.
> 

Just so I get this correctly: the degradation is that we won't 
re-collapse a THP after removing a breakpoint. Certainly "sub-optimal", 
but I guess nothing that particularly matters in practice.

Or am I wrong?

> Is anon_vma lock required?  Almost not: if any page other than expected
> subpage of the non-anon huge page is found in the page table, collapse is
> aborted without making any change.  However, it is possible that an anon
> page was CoWed from this extent in another mm or vma, in which case a
> concurrent lookup might look here: so keep it away while clearing pmd
> (but perhaps we shall go back to using pmd_lock() there in future).
> 
> Note that collapse_pte_mapped_thp() is exceptional in freeing a page table
> without having cleared its ptes: I'm uneasy about that, and had thought
> pte_clear()ing appropriate; but exclusive i_mmap lock does fix the problem,
> and we would have to move the mmu_notification if clearing those ptes.
> 
> Fixes: 8d3c106e19e8 ("mm/khugepaged: take the right locks for page table retraction")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: <stable@vger.kernel.org>    [5.4+]
> ---
> What this fixes is not a dangerous instability!  But I suggest Cc stable
> because uprobes "healing" has regressed in that way, so this should follow
> 8d3c106e19e8 into those stable releases where it was backported (and may
> want adjustment there - I'll supply backports as needed).

If it's really something that doesn't matter in practice (e.g., -1% 
performance while debugging :) ), I guess no CC is needed. If there are 
real production workloads that suffer, I guess ccing stable is fine.

> 
>   mm/khugepaged.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> --- 6.2-rc/mm/khugepaged.c
> +++ linux/mm/khugepaged.c
> @@ -1460,14 +1460,6 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
>   		return SCAN_VMA_CHECK;
>   
> -	/*
> -	 * Symmetry with retract_page_tables(): Exclude MAP_PRIVATE mappings
> -	 * that got written to. Without this, we'd have to also lock the
> -	 * anon_vma if one exists.
> -	 */
> -	if (vma->anon_vma)
> -		return SCAN_VMA_CHECK;
> -
>   	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
>   	if (userfaultfd_wp(vma))
>   		return SCAN_PTE_UFFD_WP;
> @@ -1567,8 +1559,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   	}
>   
>   	/* step 4: remove pte entries */
> +	/* we make no change to anon, but protect concurrent anon page lookup */
> +	if (vma->anon_vma)
> +		anon_vma_lock_write(vma->anon_vma);
> +
>   	collapse_and_free_pmd(mm, vma, haddr, pmd);
>   
> +	if (vma->anon_vma)
> +		anon_vma_unlock_write(vma->anon_vma);
>   	i_mmap_unlock_write(vma->vm_file->f_mapping);
>   
>   maybe_install_pmd:
> 

That code is 99% black magic to me, but staring at the original fix and 
at collapse_and_free_pmd() makes me assume that grabbing that lock most 
certainly won't hurt and should be the right thing to do

Acked-by: David Hildenbrand <david@redhat.com>


Side note: set_huge_pmd() wins the award of "ugliest mm function of 
early 2023". I was briefly concerned how do_set_pmd() decides whether 
the PMD can be writable or not. Turns out it's communicated via 
vm_fault->flags. Just horrible.

-- 
Thanks,

David / dhildenb

