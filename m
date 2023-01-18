Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C56671DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjARNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjARNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:23:53 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BB445F6F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:51:08 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id r71so7397637iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7Rqiin9Kbad8ru/LcIchuAOUvYmmUjlYJik2JJBLXA=;
        b=DhsG3zM8wnA8HofZfhQ4706XMhy790XGUqogcXCqHX85Tk8zZYxt5jMYu+eLJpJd0W
         WeZPMkDrbovMJNBWiALe2hNQO8RzVtnNL439Lg2lNDDkCN2JbO2/orikCzbM4nXJ7Ric
         pxfkouKT613poEWiZM0/S3Q0O76EFSePCk6Wx7nVSwD2fTxP6JpqrPF+F0bbjgoXhdSo
         JRONC1h0hiGS5i3GPDsY5q0sJr2GonkT+Yc4S8N+6WB4gZtHvq+jv8OZ5eQyCbLl1GpR
         opC+QyjARoxP8394hD2OHnWQsI8rTlz89//+DOWhBL6cmnhWRNKu2nd1HuPty+PyYUI0
         rVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7Rqiin9Kbad8ru/LcIchuAOUvYmmUjlYJik2JJBLXA=;
        b=2/SN+PICH65CsQmhNWclHIgsOyDYdLa7fcTbNIVlq2+OIWOnHa40icK9ZfC9XNBZFa
         GprfD/pFiscTohQRMrE2n3spWNQNrG5gt2/KVeswpLZnzI+oRvugv29yerDcbdQz4Dvn
         HbHFXv4348M0KOsyeQQvh1RJBDnQoHCaVQkJffIZ1NY7w+WfkiQ4UM9xaOPfq9jyeB8n
         fvoIVZZSJ7c0OJ4hJK0eSbzq0RLhxVf4smIEpNnYvk65Lv6AI4G/M+4gXRNszzoynhLx
         VpDcRZ7+sTfP5ApQF4R6HHVTxYWKd3FZpaZ22Hik/3Kdss8dh2SNRMwMPQUrYDLjjAnr
         9nXA==
X-Gm-Message-State: AFqh2krLBNIyaCGQthZZXlGIZ9fbv3JosfxUmudXJa+5/i0nKB6ZIdon
        AS4gpiqRdXbTfTQWRoebz5ocS8UwPhF2boPKJ4clGg==
X-Google-Smtp-Source: AMrXdXubEhuDA02ILCkh7B1Dp3y4Bt1fmHskBAwMDp3qrJV2IDmWe32RqObGG2ZP8z4nawtc1f2Tp/05rwFtfOAFxMY=
X-Received: by 2002:a02:c884:0:b0:39e:9d33:a47 with SMTP id
 m4-20020a02c884000000b0039e9d330a47mr496380jao.58.1674046267428; Wed, 18 Jan
 2023 04:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-28-surenb@google.com>
In-Reply-To: <20230109205336.3665937-28-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 18 Jan 2023 13:50:31 +0100
Message-ID: <CAG48ez3EAai=1ghnCMF6xcgUebQRm-u2xhwcpYsfP9=r=oVXig@mail.gmail.com>
Subject: Re: [PATCH 27/41] mm/mmap: prevent pagefault handler from racing with
 mmu_notifier registration
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
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

On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> Page fault handlers might need to fire MMU notifications while a new
> notifier is being registered. Modify mm_take_all_locks to write-lock all
> VMAs and prevent this race with fault handlers that would hold VMA locks.
> VMAs are locked before i_mmap_rwsem and anon_vma to keep the same
> locking order as in page fault handlers.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 30c7d1c5206e..a256deca0bc0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3566,6 +3566,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
>   * of mm/rmap.c:
>   *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
>   *     hugetlb mapping);
> + *   - all vmas marked locked

The existing comment above says that this is an *ordered* listing of
which locks are taken.

>   *   - all i_mmap_rwsem locks;
>   *   - all anon_vma->rwseml
>   *
> @@ -3591,6 +3592,7 @@ int mm_take_all_locks(struct mm_struct *mm)
>         mas_for_each(&mas, vma, ULONG_MAX) {
>                 if (signal_pending(current))
>                         goto out_unlock;
> +               vma_write_lock(vma);
>                 if (vma->vm_file && vma->vm_file->f_mapping &&
>                                 is_vm_hugetlb_page(vma))
>                         vm_lock_mapping(mm, vma->vm_file->f_mapping);

Note that multiple VMAs can have the same ->f_mapping, so with this,
the lock ordering between VMA locks and the mapping locks of hugetlb
VMAs is mixed: If you have two adjacent hugetlb VMAs with the same
->f_mapping, then the following operations happen:

1. lock VMA 1
2. lock mapping of VMAs 1 and 2
3. lock VMA 2
4. [second vm_lock_mapping() is a no-op]

So for VMA 1, we ended up taking the VMA lock first, but for VMA 2, we
took the mapping lock first.

The existing code has one loop per lock type to ensure that the locks
really are taken in the specified order, even when some of the locks
are associated with multiple VMAs.

If we don't care about the ordering between these two, maybe that's
fine and you just have to adjust the comment; but it would be clearer
to add a separate loop for the VMA locks.

> @@ -3677,6 +3679,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
>                 if (vma->vm_file && vma->vm_file->f_mapping)
>                         vm_unlock_mapping(vma->vm_file->f_mapping);
>         }
> +       vma_write_unlock_mm(mm);
>
>         mutex_unlock(&mm_all_locks_mutex);
>  }
> --
> 2.39.0
>
