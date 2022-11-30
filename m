Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF963D343
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiK3KZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiK3KZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D03131
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3qb9pbfLJD1ep66GbpCldh7yIsfAPSKJe9tKT7uIVc=;
        b=IoW1gBLuQ/SPUPQ25Be1vTkUycfy81Ap7PieABF57gFAtS1bT3YZlGvnhbQtkPMWV6wYMJ
        MP9OHRG8+rgRmKixl3JzDKb20RCe2/zpBI6t+HPWk9MTsMr6ztsmSNwHMgqekeSStL/yfe
        YtzAv5wkJaVkvh/j1YuC94AK5vJPDww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-524-dtRu4xl8NVyZjVGbpXtVzA-1; Wed, 30 Nov 2022 05:24:37 -0500
X-MC-Unique: dtRu4xl8NVyZjVGbpXtVzA-1
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b003cfa148576dso9195558wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3qb9pbfLJD1ep66GbpCldh7yIsfAPSKJe9tKT7uIVc=;
        b=OsoDY/DvRe3ORGrvitiguwemZs1xGkhwK3QEI7GlieZfUdPEy86s685yr6iAEPHwBb
         NNoSEM8kiP5SSHBhq3RG7n3gTQ3Hhr8vgPtdv85IBSpPjcF/AwTFg/qO4AnLjgYBiu7a
         nITN/mnHpBUTK6HkbEOlODntJzK+02UTPXTplK3vM7Ccv3B6vtMRriKOmZaucdl0zlMZ
         7ICRMr5ejI0pH5shQ9vtWhHUv9hP8QGO+Ma72oHvv9bNf63aM8l2/2Vwu70kouvAGPcO
         zVs8FdflzzaEL6CbjTMAE7h6yCWZmdtZnzhOYnaPHyPsnkV0nFiTIo/AIjKrb9/czGL1
         Kw1w==
X-Gm-Message-State: ANoB5pkFgB1icJv/P6ln7MoAvdHfbYMW3LA0OyvMspj93kmJQnqn2yxx
        hykRYKGmDSIezzfgUe3lZ8QZ+uD7ZQ/WucmTCA1A1fshEGVMyyrFgRdhXGepMXMQ+nFPuh+g5yG
        YPhrCQ2y9gRhYQjqnlMXdc/GI
X-Received: by 2002:a05:6000:71e:b0:241:df3f:f5d6 with SMTP id bs30-20020a056000071e00b00241df3ff5d6mr25914046wrb.288.1669803876155;
        Wed, 30 Nov 2022 02:24:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6+svkIP7IzWDFFwjUhMPm8CMH5OdicwS9GB0w7SRVKR9PXGcNvAox2TZZLqcgOd+daTf+jNQ==
X-Received: by 2002:a05:6000:71e:b0:241:df3f:f5d6 with SMTP id bs30-20020a056000071e00b00241df3ff5d6mr25914023wrb.288.1669803875813;
        Wed, 30 Nov 2022 02:24:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm1057412wrw.105.2022.11.30.02.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:24:35 -0800 (PST)
Message-ID: <afce1bdf-6b5f-3393-cafa-81148277773d@redhat.com>
Date:   Wed, 30 Nov 2022 11:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 03/10] mm/hugetlb: Document huge_pte_offset usage
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221129193526.3588187-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.22 20:35, Peter Xu wrote:
> huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
> hugetlb address.
> 
> Normally, it's always safe to walk a generic pgtable as long as we're with
> the mmap lock held for either read or write, because that guarantees the
> pgtable pages will always be valid during the process.
> 
> But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
> pgtable freed by pmd unsharing, it means that even with mmap lock held for
> current mm, the PMD pgtable page can still go away from under us if pmd
> unsharing is possible during the walk.
> 
> So we have two ways to make it safe even for a shared mapping:
> 
>    (1) If we're with the hugetlb vma lock held for either read/write, it's
>        okay because pmd unshare cannot happen at all.
> 
>    (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
>        okay because even if pmd unshare can happen, the pgtable page cannot
>        be freed from under us.
> 
> Document it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 551834cd5299..81efd9b9baa2 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
>   
>   pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>   			unsigned long addr, unsigned long sz);
> +/*
> + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
> + * Returns the pte_t* if found, or NULL if the address is not mapped.
> + *
> + * Since this function will walk all the pgtable pages (including not only
> + * high-level pgtable page, but also PUD entry that can be unshared
> + * concurrently for VM_SHARED), the caller of this function should be
> + * responsible of its thread safety.  One can follow this rule:
> + *
> + *  (1) For private mappings: pmd unsharing is not possible, so it'll
> + *      always be safe if we're with the mmap sem for either read or write.
> + *      This is normally always the case, IOW we don't need to do anything
> + *      special.

Maybe worth mentioning that hugetlb_vma_lock_read() and friends already 
optimize for private mappings, to not take the VMA lock if not required.

Was happy to spot that optimization in there already :)

-- 
Thanks,

David / dhildenb

