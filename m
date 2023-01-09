Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10266620CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjAII7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbjAII6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496D17425
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673254217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eWfv7FdpZidiOCD3FxxZ2atZIbpf1JWAGYqPfaDntw=;
        b=NusqB14wiZNWcW5BIssYZAPn7F2B3ee642yQeS8DPt3/8KJAFiA3oizEOHaffCNR4YkTis
        IHZsN7HUhNW5ESihETT5fHBw1aWVP3XFdv4ih0AhOiwUZ6006bNAMDmvT6S0576U+t6pof
        LQYM0Fnh4TwnlhOTs93S8Kw89NLxLxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-IZXp540MPYqru5a67hJogA-1; Mon, 09 Jan 2023 03:50:15 -0500
X-MC-Unique: IZXp540MPYqru5a67hJogA-1
Received: by mail-wm1-f69.google.com with SMTP id c7-20020a1c3507000000b003d355c13ba8so4428140wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eWfv7FdpZidiOCD3FxxZ2atZIbpf1JWAGYqPfaDntw=;
        b=OquCAFae6Hfycx5wPBj4JltQOSJniJa+T7tRkBz3drFCEsr6Pzgo5aJbMagzEtKVaQ
         IhXNQ87xhG8UusjiRCXqPEi3+HqUpGgR5hn8EnTnCfybFgcXYkwEWJ5zX2EMg2JTDQoF
         lZOabJCCFOEgYtWfdAsRsUVtEQA1I3IC5QAZuq1CH4sXB2f4zOMbSVZ9r1KfLPtCTnnI
         b/qrxKT8OgrhnZtiQiX68QdSEBvmaX/uPReYDCgRXoQrKdN1LPcjgt/u0JdIhXjzvUgT
         MGzNEH15FAhU1/CWHQwOSoXQ+H7FPy/x9S0Lw24pyNnmLdShIuDYJdVrxLjKFXW6JiaH
         NZNQ==
X-Gm-Message-State: AFqh2kpY5splZeOxA4byn41Fd+mySml+fksIPRZpqX1rNj5IZd+NOHhu
        u1Scuv6EjjBNo/+OCk2r0oThgTbABdTN7lcg4eEkWHasd71YzzQnkn+RTKWmYbdpXJ5RbzgNO/X
        FYeaByF9dIrpPpgdYSlfkOK9i
X-Received: by 2002:a05:600c:22c4:b0:3cf:8ed7:712d with SMTP id 4-20020a05600c22c400b003cf8ed7712dmr49710081wmg.14.1673254214599;
        Mon, 09 Jan 2023 00:50:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsGIHatnBz1coWryhTd0TfmZzlMhrOvF90lJu4BkRSuKLwbzd0tI2cx093DQCQMwpYpHvc/3w==
X-Received: by 2002:a05:600c:22c4:b0:3cf:8ed7:712d with SMTP id 4-20020a05600c22c400b003cf8ed7712dmr49710064wmg.14.1673254214331;
        Mon, 09 Jan 2023 00:50:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:8f00:ba3:7d27:204f:8e29? (p200300cbc7038f000ba37d27204f8e29.dip0.t-ipconnect.de. [2003:cb:c703:8f00:ba3:7d27:204f:8e29])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003d96c811d6dsm16198618wmq.30.2023.01.09.00.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:50:13 -0800 (PST)
Message-ID: <d50eb6f2-0585-7441-081b-cadaa5901c6e@redhat.com>
Date:   Mon, 9 Jan 2023 09:50:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
 <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com>
 <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
 <7ff97950-b524-db06-9ad6-e98b80dcfefa@redhat.com>
 <CAHbLzkqjooxnAwqK7vZoJpP2bSUTCUgv3UtWsZgo444jpGSfoA@mail.gmail.com>
 <86d5f618-800d-9672-56c4-9309ef222a39@redhat.com>
 <CAAa6QmSByYrWkp+8K0NK+pocKT0CVj83RaVUB1VqMPvuPHnpNQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow
 anon_vma
In-Reply-To: <CAAa6QmSByYrWkp+8K0NK+pocKT0CVj83RaVUB1VqMPvuPHnpNQ@mail.gmail.com>
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

>>>>>>
>>>>>> Side note: set_huge_pmd() wins the award of "ugliest mm function of early
>>>>>> 2023". I was briefly concerned how do_set_pmd() decides whether the PMD can be
>>>>>> writable or not. Turns out it's communicated via vm_fault->flags. Just
>>>>>> horrible.
> 
> My first Linux award! :) At least it's not "worst mm security issue of
> early 2023". I'll take it!

Good that you're not taking my words the wrong way.

MADV_COLLAPSE is a very useful feature (especially also for THP tests 
[1]). I wish I could have looked at some of the patches earlier. But we 
cannot wait forever to get something merged, otherwise we'd never get 
bigger changes upstream.

... so there is plenty of time left in 2023 to cleanup khugepaged.c :P


[1] https://lkml.kernel.org/r/20230104144905.460075-1-david@redhat.com

[...]


>> For example: why even *care* about the complexity of installing a PMD in
>> collapse_pte_mapped_thp() using set_huge_pmd() just for MADV_COLLAPSE?
>>
>> Sure, we avoid a single page fault afterwards, but is this *really*
>> worth the extra code here? I mean, after we installed the PMD, the page
>> could just get reclaimed either way, so there is no guarantee that we
>> have a PMD mapped once we return to user space IIUC.
> 
> A valid question. The first reason is just semantic symmetry for
> MADV_COLLAPSE called on anon vs file/shmem memory. It would be nice to
> say that "on success, the memory range provided will be backed by
> PMD-mapped hugepages", rather than special-casing file/shmem.

But there will never be such a guarantee, right? We could even see a 
split before just before we return to user space IIRC.

> 
> The second reason has a more practical use case. In userfaultfd-based
> live migration (using  UFFDIO_REGISTER_MODE_MINOR) pages are migrated
> at 4KiB granularity, and it may take a long (O(many minutes)) for the
> transfer of all pages to complete. To avoid severe performance
> degradation on the target guest, the vmm wants to MADV_COLLAPSE
> hugepage-sized regions as they fill up. Since the guest memory is
> still uffd-registered, requiring refault post-MADV_COLLAPSE won't
> work, since the uffd machinery will intercept the fault, and no PMD
> will be mapped. As such, either uffd needs to be taught to install PMD
> mappings, or the PMD mapping already must be in-place.

That's an interesting point, thanks. I assume we'd get another minor 
fault and when resolving that, we'll default to a PTE mapping.

-- 
Thanks,

David / dhildenb

