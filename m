Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6F63AA23
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiK1NyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiK1NyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:54:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDF5CEC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669643583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XnlbsZkof5NJhewGi9OF3NjlblvQjvfpn1girlOlzgE=;
        b=SWrsZimXMBwg9cQLb/NW6T8idKV1zm0MaPBGWuUS1MJ2kz4uhASu4wrSUp9Dt1Wjgm8ePU
        nYTDFSgK2jFLhchJ4RZueXcWPn0ioeH/hIEsKIKaEn/ntyaNgDDEA6glirqIi+cKeJkK55
        KKLq/iSKrr9GwZdMerJS8CoO9LENrGY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-mDd2tp80OPawB7DPNxJO2A-1; Mon, 28 Nov 2022 08:53:00 -0500
X-MC-Unique: mDd2tp80OPawB7DPNxJO2A-1
Received: by mail-wr1-f69.google.com with SMTP id v2-20020adfa1c2000000b002420d780a32so917266wrv.14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnlbsZkof5NJhewGi9OF3NjlblvQjvfpn1girlOlzgE=;
        b=XRG6wibD62F7Kl94XxRvFnQvN12NvIyJj96Q4F48vbjOQrp+8q2S0emi1hUEqKCw2L
         PSN55SESCA8iCdrXWqZcIZaJzez3f2t2S7lW7NS+JxHu7Uxsp2xsNTVqUVi+WX5EmJB8
         NAa3Rxk3WyG9ZnSX2GM2RAwsVR5Wa2c5E6PCoFx2H4RNNsGo+WuQ+Q7J6aM/4Z+sLaDz
         0WnabTRPpjWJwhosh79fDH5P34G7OXumy6ZOhxvUuFhNh3FUeaY7FyhD6cSsrZYW9Y2W
         8j9LmOOIoq8I7ckcsDe9mXyzbuWzVwmuIwPfbyTL1waAJ41Mb1HRXWrS7R55kZPEjuIa
         BhzQ==
X-Gm-Message-State: ANoB5pnzRJFK8zksSJicv9+Ft+3EkXa5tIXaffVVjTFiEp6RQ2wyWBOi
        GGD5OHDi9xeBKTi8ayAwqFYyRcfLHZjw4JCbXm63x9hepyzUd8sV9MfXcav3+42WlbYoqa0LYhI
        O9oyJI7lgz8AmiLWQkAeAnpVp
X-Received: by 2002:adf:ed8b:0:b0:241:d375:88b6 with SMTP id c11-20020adfed8b000000b00241d37588b6mr23251156wro.88.1669643579172;
        Mon, 28 Nov 2022 05:52:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Jjj7LYEuOV8esn9R8v9jZohPzwib9S5dbPhEQEgekrVxpp2quDTIs9gUIoqvtI4JnGmAybA==
X-Received: by 2002:adf:ed8b:0:b0:241:d375:88b6 with SMTP id c11-20020adfed8b000000b00241d37588b6mr23251139wro.88.1669643578854;
        Mon, 28 Nov 2022 05:52:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe78b000000b0023677fd2657sm10935325wrm.52.2022.11.28.05.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:52:57 -0800 (PST)
Message-ID: <fec3f46e-a777-06e7-0ba0-a8cf169afa02@redhat.com>
Date:   Mon, 28 Nov 2022 14:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Jann Horn <jannh@google.com>, security@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20221125213714.4115729-1-jannh@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/3] mm/khugepaged: Take the right locks for page table
 retraction
In-Reply-To: <20221125213714.4115729-1-jannh@google.com>
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

On 25.11.22 22:37, Jann Horn wrote:
> pagetable walks on address ranges mapped by VMAs can be done under the mmap
> lock, the lock of an anon_vma attached to the VMA, or the lock of the VMA's
> address_space. Only one of these needs to be held, and it does not need to
> be held in exclusive mode.
> 
> Under those circumstances, the rules for concurrent access to page table
> entries are:
> 
>   - Terminal page table entries (entries that don't point to another page
>     table) can be arbitrarily changed under the page table lock, with the
>     exception that they always need to be consistent for
>     hardware page table walks and lockless_pages_from_mm().
>     This includes that they can be changed into non-terminal entries.
>   - Non-terminal page table entries (which point to another page table)
>     can not be modified; readers are allowed to READ_ONCE() an entry, verify
>     that it is non-terminal, and then assume that its value will stay as-is.
> 
> Retracting a page table involves modifying a non-terminal entry, so
> page-table-level locks are insufficient to protect against concurrent
> page table traversal; it requires taking all the higher-level locks under
> which it is possible to start a page walk in the relevant range in
> exclusive mode.
> 
> The collapse_huge_page() path for anonymous THP already follows this rule,
> but the shmem/file THP path was getting it wrong, making it possible for
> concurrent rmap-based operations to cause corruption.

This sounds sane and correct to me. No expert on file-THP, though.

For anon-THP it's the mmap lock and the rmap locks. I assume the only 
difference for file-THP is that the rmap lock is actually the mapping 
lock. Looking at rmap_walk_file(), that seems to be the case.


I wish at least PTE table removal could be done easier ... I already 
experimented some time ago with some ideas (e.g., lock in PMD table 
memmap) but it's all far from trivial and space in the memmap is rare.

-- 
Thanks,

David / dhildenb

