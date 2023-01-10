Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE156646FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbjAJRGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbjAJRF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:05:59 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125615FEC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:05:58 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 188so12402163ybi.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ebvj0yGvXXeuBEbC7H27uQsOOqIKGQ1DiQx+VawTo=;
        b=eJ4MxecWysL64FkNsQ0teVeuLg2ZK7aEzYg5KedUsCXB6sI2SzntwwC4ze4GApLoyP
         jau+Xs3Oly2qtiu8qT3bTpKBncLVwCj38FZweARc8N2KR7ApZOcqzRRsSdlBLuANbfzk
         4erm+VGWwPa/tSgSfKm+rdTaC5WlhZVIa5OnOGdYu+SwGr9h5u4OuIsSkh2YaBqqOEKW
         IMFlQdaNmRs6vODjAQm4ADFZf7UGD0JrF5iYzJcbpl+P+V2e/rbnUBVmteLbkba/DtCp
         xY8uFj/7EZrt0wFBrJ5503evMmAtt/O7XX+ZQ0fPMXYg5xieczuQz2flhlhKOYcZxU3w
         x5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0ebvj0yGvXXeuBEbC7H27uQsOOqIKGQ1DiQx+VawTo=;
        b=s5tH/5tNIL9yPpjHwfLymDEEAEouJy2aQzoTLJ03BSZTnov9trSpCwWuOQoS22z4TE
         x+REr1wDxPA4yruClLA9tqhvsrv9O7nfW6jIoYPUCqb8BPuXpoCUFCxNm3msCFcXPJW6
         bB2IJuQRHRaoYZPW53yttgM7Svw5mY3T4B2bsy1CBgSfhCZQtnOrNkFjG19Tu9zE27BI
         lVfQr/1XquKFKTx3z34Xx9hg0lHyekbhjaZsvb4WJyUYA8+vSFRp9YbfejcFPVThSWP7
         whTCKzpE0A0CdzTF/6XIZLtNf8RlyZzPFnT4oVHC4NC6ihxdU50LRIfhZqH83r+Kec/k
         93Rw==
X-Gm-Message-State: AFqh2kpjfNjI1ogL6ocu3kRDQoxCG6V0FOZJU5XJaFOS8mb8ipQ5MWQq
        sJVdFydUtO8fJXoqDNoqsd+4KFsEX1YcRKW8sXQuMA==
X-Google-Smtp-Source: AMrXdXteeMA/N8yZFFOz1nT36N36BXsrmCxCaBU92iN32Cb30nOfOuY8OZOFV9G9dScLLy0dukOmnG8ECA5EheppOd0=
X-Received: by 2002:a25:b78f:0:b0:77a:e0bd:6b35 with SMTP id
 n15-20020a25b78f000000b0077ae0bd6b35mr5840314ybh.316.1673370356949; Tue, 10
 Jan 2023 09:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <5874fea2-fc3b-5e5d-50ac-e413a11819a5@suse.cz>
In-Reply-To: <5874fea2-fc3b-5e5d-50ac-e413a11819a5@suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 Jan 2023 09:05:45 -0800
Message-ID: <CAJuCfpEdcVEmtEsJi9j-JLqtUaG95K1tv3DRhzWreicGcWaSew@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:04 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/9/23 21:53, Suren Baghdasaryan wrote:
> > rw_semaphore is a sizable structure of 40 bytes and consumes
> > considerable space for each vm_area_struct. However vma_lock has
> > two important specifics which can be used to replace rw_semaphore
> > with a simpler structure:
> > 1. Readers never wait. They try to take the vma_lock and fall back to
> > mmap_lock if that fails.
> > 2. Only one writer at a time will ever try to write-lock a vma_lock
> > because writers first take mmap_lock in write mode.
> > Because of these requirements, full rw_semaphore functionality is not
> > needed and we can replace rw_semaphore with an atomic variable.
> > When a reader takes read lock, it increments the atomic unless the
> > value is negative. If that fails read-locking is aborted and mmap_lock
> > is used instead.
> > When writer takes write lock, it resets atomic value to -1 if the
> > current value is 0 (no readers). Since all writers take mmap_lock in
> > write mode first, there can be only one writer at a time. If there
> > are readers, writer will place itself into a wait queue using new
> > mm_struct.vma_writer_wait waitqueue head. The last reader to release
> > the vma_lock will signal the writer to wake up.
> > vm_lock_seq is also moved into vma_lock and along with atomic_t they
> > are nicely packed and consume 8 bytes, bringing the overhead from
> > vma_lock from 44 to 16 bytes:
> >
> >     slabinfo before the changes:
> >      <name>            ... <objsize> <objperslab> <pagesperslab> : ...
> >     vm_area_struct    ...    152   53    2 : ...
> >
> >     slabinfo with vma_lock:
> >      <name>            ... <objsize> <objperslab> <pagesperslab> : ...
> >     rw_semaphore      ...      8  512    1 : ...
>
> I guess the cache is called vma_lock, not rw_semaphore?

Yes, sorry. Copy/paste error when combining the results. The numbers
though look correct, so I did not screw up that part :)

>
> >     vm_area_struct    ...    160   51    2 : ...
> >
> > Assuming 40000 vm_area_structs, memory consumption would be:
> > baseline: 6040kB
> > vma_lock (vm_area_structs+vma_lock): 6280kB+316kB=6596kB
> > Total increase: 556kB
> >
> > atomic_t might overflow if there are many competing readers, therefore
> > vma_read_trylock() implements an overflow check and if that occurs it
> > restors the previous value and exits with a failure to lock.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> This patch is indeed an interesting addition indeed, but I can't help but
> think it obsoletes the previous one :) We allocate an extra 8 bytes slab
> object for the lock, and the pointer to it is also 8 bytes, and requires an
> indirection. The vma_lock cache is not cacheline aligned (otherwise it would
> be a major waste), so we have potential false sharing with up to 7 other
> vma_lock's.

True, I thought long and hard about combining the last two patches but
decided to keep them separate to document the intent. The previous
patch splits the lock for performance reasons and this one is focused
on memory consumption. I'm open to changing this if it's confusing.

> I'd expect if the vma_lock was placed with the relatively cold fields of
> vm_area_struct, it shouldn't cause much cache ping pong when working with
> that vma. Even if we don't cache align the vma to save memory (would be 192
> bytes instead of 160 when aligned) and place the vma_lock and the cold
> fields at the end of the vma, it may be false sharing the cacheline with the
> next vma in the slab.

I would love to combine the vma_lock with vm_area_struct and I spent
several days trying different combinations to achieve decent
performance. My best achieved result was when I placed the vm_lock
into the third cache line at offset 192 and allocated vm_area_structs
from cache-aligned slab (horrible memory waste with each vma consuming
256 bytes). Even then I see regression in pft-threads test on a NUMA
machine (where cache-bouncing problem is most pronounced):

This is the result with split vma locks (current version). The higher
number the better:

BASE                                PVL
Hmean     faults/sec-1    469201.7282 (   0.00%)   464453.3976 *  -1.01%*
Hmean     faults/sec-4   1754465.6221 (   0.00%)  1660688.0452 *  -5.35%*
Hmean     faults/sec-7   2808141.6711 (   0.00%)  2688910.6458 *  -4.25%*
Hmean     faults/sec-12  3750307.7553 (   0.00%)  3863490.2057 *   3.02%*
Hmean     faults/sec-21  4145672.4677 (   0.00%)  3904532.7241 *  -5.82%*
Hmean     faults/sec-30  3775722.5726 (   0.00%)  3923225.3734 *   3.91%*
Hmean     faults/sec-48  4152563.5864 (   0.00%)  4783720.6811 *  15.20%*
Hmean     faults/sec-56  4163868.7111 (   0.00%)  4851473.7241 *  16.51%*

Here are results with the vma locks integrated into cache-aligned
vm_area_struct:

BASE               PVM_MERGED
Hmean     faults/sec-1    469201.7282 (   0.00%)   465268.1274 *  -0.84%*
Hmean     faults/sec-4   1754465.6221 (   0.00%)  1658538.0217 *  -5.47%*
Hmean     faults/sec-7   2808141.6711 (   0.00%)  2645016.1598 *  -5.81%*
Hmean     faults/sec-12  3750307.7553 (   0.00%)  3664676.6956 *  -2.28%*
Hmean     faults/sec-21  4145672.4677 (   0.00%)  3722203.7950 * -10.21%*
Hmean     faults/sec-30  3775722.5726 (   0.00%)  3821025.6963 *   1.20%*
Hmean     faults/sec-48  4152563.5864 (   0.00%)  4561016.1604 *   9.84%*
Hmean     faults/sec-56  4163868.7111 (   0.00%)  4528123.3737 *   8.75%*

These two compare with the same baseline test results, I just
separated the result into two to have readable email formatting.
It's also hard to find 56 bytes worth of fields in vm_area_struct
which are not used during page faults. So, in the end I decided to
keep vma_locks separate to preserve performance. If you have an idea
on how we can combine vm_area_struct fields in a better way, I would
love to try it out.

> But that's a single vma, not up to 7, so it shouldn't be worse?

Yes, I expected that too but mmtests show very small improvement when
I cache-align vma_locks slab. My spf_test does show about 10%
regression due to vma_lock cache-line bouncing, however considering
that it also shows 90% improvement over baseline, losing 10% of that
improvement to save 56 bytes per vma sounds like a good deal.
I think the lack of considerable regression here is due to vma_locks
being used only 2 times in the pagefault path - when we take it and
when we release it, while vm_aa_struct fields are used much more
heavily. So, invalidating vma_lock cache-line does not hit us as hard
as invalidating a part of vm_area_struct.

Looking forward to suggestions and thanks for the review, Vlastimil!




>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
