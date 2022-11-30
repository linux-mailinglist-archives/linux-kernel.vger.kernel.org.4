Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA163D33D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiK3KXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiK3KXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9587208B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5ATvP26yVV+R3lUMUH5z5/Q+n5P1qd+MA+woq6nwek=;
        b=FSDPhOEbW7AWiLqZGblDv71nRfpqtz4siQZWWSyAcK+N0VNCFApUQJUW6uK0mNlEzwWo1W
        SSbZWF/HAk7u15Vw7JlYGjZSqEEa26QP/Xa8lu17/AQVqifL99cz28mUXWreQQtGD30nNY
        jK8o97HYMxSvW7AAE+OkuM+4NEAW8xk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-GE3NV9Q4NCyGanIkFBv7LQ-1; Wed, 30 Nov 2022 05:21:43 -0500
X-MC-Unique: GE3NV9Q4NCyGanIkFBv7LQ-1
Received: by mail-wm1-f71.google.com with SMTP id 204-20020a1c02d5000000b003d06031f2cfso3042428wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5ATvP26yVV+R3lUMUH5z5/Q+n5P1qd+MA+woq6nwek=;
        b=LBTIfZz9V/zlmYgrecH1vheC49ZS1m3pSSoZd1rGBukq1RfijZNfgMTyYTF7lK5zUH
         rItc8UCjsE7Am96nqEaQYP81+OnNocSQaWPQM6Gr4B1WY5vGNUGjRpWa2/8BVz5njXVD
         JHv3pqsTRGb+bsDDCeDWKRhdeGrTOSZpNSonUlPrTUq/WwbTUx1NgdiiXNIq0gtrhgY1
         /DmcAHI7lmtK33DTD/jHr4Hr8w454QL0WgaNtNdybq/NhdG/hg7pFucQ/KnYbex3F/ay
         tJbF8Ls7+XVtP+LhoN04PtPg10TC/SjcZEAcGL29jHpzDQYA0biVRV8/OfjaIYFpze9j
         pBVg==
X-Gm-Message-State: ANoB5ploz1M2SJbD065NC6wqI6qy4KFDF/UjPgS06RSBwvIkwB45ieoA
        OmaCJou9BoR2kk5z7O6s4DLO8pqMAzZqXX4bM2B42KzBb/uMUl5qSLh3KmG4DmepheONV0KEzQ1
        jBEaFIUnzAtMO0jKqTU8/p6Or
X-Received: by 2002:a5d:628b:0:b0:242:26f0:d395 with SMTP id k11-20020a5d628b000000b0024226f0d395mr3327847wru.510.1669803701961;
        Wed, 30 Nov 2022 02:21:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5guwVCW+BtHzSPu91RpZEmoDYmQ1ZVTA7NZdgSktSwlLqK3Z1u1RReeCVk0cLUdT051neAXQ==
X-Received: by 2002:a5d:628b:0:b0:242:26f0:d395 with SMTP id k11-20020a5d628b000000b0024226f0d395mr3327824wru.510.1669803701619;
        Wed, 30 Nov 2022 02:21:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003b4fe03c881sm5563207wmq.48.2022.11.30.02.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:21:41 -0800 (PST)
Message-ID: <9bd6e57e-2c77-33f9-f9ea-7916b20ee6a5@redhat.com>
Date:   Wed, 30 Nov 2022 11:21:40 +0100
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

With the addition, that it's only safe to walk within VMA ranges while 
holding the mmap lock in read mode. It's not safe to walk outside VMA 
ranges.

But the point is that we're walking within a known hugetlbfs VMA, I 
assume, just adding it for completeness :)

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

In general, I like that documentation. Let's see if we can figure out 
what to do with the i_mmap_rwsem.

-- 
Thanks,

David / dhildenb

