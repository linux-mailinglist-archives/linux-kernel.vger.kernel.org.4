Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D836357AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiKWJop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiKWJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:44:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9DFAC6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669196444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIewY6zGMepwtTpZ6QHtBGZ6thS0v5hQWPigFbEbTdc=;
        b=YgcV03BYleHRgkMzAOUz78ymfSvo9k8q7voTGiwZ/IZHskdYrGkJDHFNf4U5Mw+zzew2gx
        VX0pw3NdeuMgNzgLHNDPFhNBplVjHdQQX/nKyjOLJAGbfe5FVJyUSZnQMyuLfiQjhtPMsc
        S6c5GengKz8e4xxOHETIKOcLZ/Y3Pss=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-25-d55aCwvAPrquHllmB9j0ug-1; Wed, 23 Nov 2022 04:40:43 -0500
X-MC-Unique: d55aCwvAPrquHllmB9j0ug-1
Received: by mail-wm1-f72.google.com with SMTP id l32-20020a05600c1d2000b003cfefa531c9so1682491wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIewY6zGMepwtTpZ6QHtBGZ6thS0v5hQWPigFbEbTdc=;
        b=eH32VH/ldTu8u7gpaI3e+h1sCgljnUg+AwlNdtaQBezMCmo0LfDNy+sRtzFjDeYw+N
         +AFZNViog8Kha1E/laKya/dAH4tB+E/ylLirxodqI0bk/8Z9m//jV7N9KdHX6qAbCF9r
         RzUnM/qHmsjJytMklrefJZwS4HKIy8xz/gq0zhvKSEMjg1UFwJZFxD7o5hhSyZgoT3ab
         8pJxfvt6gA+fw7DqAASOsdCzrfOlp8y0DtaZY3oyySNox8S7rAjGFw0kJcOcu7OaodPQ
         4HDKFnA0szvNZThl7Lumd4a9/ZZP/haZCS4MgpUQFOckI4ebAc6MGHMdL3syHuTr3SfJ
         PMMw==
X-Gm-Message-State: ANoB5pmlZT1YTBQySGbUXdIdQolz42ZqFKDBbqd4BRcnxJ4aWv+N2y9e
        1b9xIrCVmOAcJ+P2nODcgn6rMfOfcsoPt9kvGvfk1tYB4k/6Q8NNHbbW6CbvHSZgsbFSnmLyjRM
        NmBTyeXOFZIxwQ8CoNptGXbJO
X-Received: by 2002:a5d:69c4:0:b0:236:c206:b2b1 with SMTP id s4-20020a5d69c4000000b00236c206b2b1mr5861378wrw.624.1669196441771;
        Wed, 23 Nov 2022 01:40:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5bG4gFkFm+Q8OjD7Da9s09hKezfUXf8nQTiZw3I+t8CP8HdQAVnymgv3iWh5Qlsuedew9i8w==
X-Received: by 2002:a5d:69c4:0:b0:236:c206:b2b1 with SMTP id s4-20020a5d69c4000000b00236c206b2b1mr5861361wrw.624.1669196441373;
        Wed, 23 Nov 2022 01:40:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm2208981wms.9.2022.11.23.01.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:40:41 -0800 (PST)
Message-ID: <70376d57-7924-8ac9-9e93-1831248115a0@redhat.com>
Date:   Wed, 23 Nov 2022 10:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH RFC v2 00/12] mm/hugetlb: Make huge_pte_offset()
 thread-safe for pmd unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
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

On 18.11.22 02:10, Peter Xu wrote:
> Based on latest mm-unstable (96aa38b69507).
> 
> This can be seen as a follow-up series to Mike's recent hugetlb vma lock
> series for pmd unsharing, so this series also depends on that one.
> Hopefully this series can make it a more complete resolution for pmd
> unsharing.
> 
> PS: so far no one strongly ACKed this, let me keep the RFC tag.  But I
> think I'm already more confident than many of the RFCs I posted.
> 
> PS2: there're a lot of changes comparing to rfcv1, so I'm just not adding
> the changelog.  The whole idea is still the same, though.
> 
> Problem
> =======
> 
> huge_pte_offset() is a major helper used by hugetlb code paths to walk a
> hugetlb pgtable.  It's used mostly everywhere since that's needed even
> before taking the pgtable lock.
> 
> huge_pte_offset() is always called with mmap lock held with either read or
> write.
> 
> For normal memory types that's far enough, since any pgtable removal
> requires mmap write lock (e.g. munmap or mm destructions).  However hugetlb
> has the pmd unshare feature, it means not only the pgtable page can be gone
> from under us when we're doing a walking, but also the pgtable page we're
> walking (even after unshared, in this case it can only be the huge PUD page
> which contains 512 huge pmd entries, with the vma VM_SHARED mapped).  It's
> possible because even though freeing the pgtable page requires mmap write
> lock, it doesn't help us when we're walking on another mm's pgtable, so
> it's still on risk even if we're with the current->mm's mmap lock.
> 
> The recent work from Mike on vma lock can resolve most of this already.
> It's achieved by forbidden pmd unsharing during the lock being taken, so no
> further risk of the pgtable page being freed.  It means if we can take the
> vma lock around all huge_pte_offset() callers it'll be safe.
> 
> There're already a bunch of them that we did as per the latest mm-unstable,
> but also quite a few others that we didn't for various reasons.  E.g. it
> may not be applicable for not-allow-to-sleep contexts like FOLL_NOWAIT.
> Or, huge_pmd_share() is actually a tricky user of huge_pte_offset(),
> because even if we took the vma lock, we're walking on another mm's vma!
> Taking vma lock for all the vmas are probably not gonna work.
> 
> I have totally no report showing that I can trigger such a race, but from
> code wise I never see anything that stops the race from happening.  This
> series is trying to resolve that problem.

Let me try understand the basic problem first:

hugetlb walks page tables semi-lockless: while we hold the mmap lock, we 
don't grab the page table locks. That's very hugetlb specific handling 
and I assume hugetlb uses different mechanisms to sync against 
MADV_DONTNEED, concurrent page fault s... but that's no news. hugetlb is 
weird in many ways :)

So, IIUC, you want a mechanism to synchronize against PMD unsharing. 
Can't we use some very basic locking for that?

Using RCU / disabling local irqs seems a bit excessive because we *are* 
holding the mmap lock and only care about concurrent unsharing

-- 
Thanks,

David / dhildenb

