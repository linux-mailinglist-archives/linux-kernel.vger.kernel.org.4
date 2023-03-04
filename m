Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54006AAD76
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 00:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCDX0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 18:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCDX0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 18:26:06 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305CD33C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 15:26:05 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id x199so5019240ybg.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 15:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677972364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RyFHuSabdXskT7o5KuCkB0maeQkY66+o/DnfFkdhBiE=;
        b=j5pUyWqIM4qqaXra/q1gm5l+Rrxt3/gxNNbU9bD+iCQfnOBIx1N/hO/J2Owi6e+Cmi
         ES+7FedXhyFT92k4iOMFTIoAChF6c+cfjEYNN81MN4eFGbTrXPFKezTpupvJrmObaxto
         msh7zvGEhiokA6mCHqfriXB9wTWrEd2aG4m/L1Gidhr8kk+gR/lq5L1aR87Gb7EcDPdp
         UUQaH5oALkzqX2vRtsj+/vjs2q1vdiX5MZeUjMYy+dqytpGC3ySDJM/iC/Yd/KvT0xLr
         lR6CBPvCrAC+XJtY5HqIH7YOb4y5GRjo0He6b8cXC+0XgEku69nOGRuym7vvp9OkGhXl
         ecJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677972364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyFHuSabdXskT7o5KuCkB0maeQkY66+o/DnfFkdhBiE=;
        b=U02dtLETg86/j4lbKksEUUxnBnIJYwvbCrJpizAw99zasgs7Dqpn7GszSYrFvnUDO1
         Hxp723Bipq7o4TA0JBwbUduFsTQ+2Ytu2bwtJ3/VNHpKkr796w0HNHo0a90MqlPzUPCk
         UTICXYl4oVSTGYMlnxNMehaxRRAxuRkSBeYML2IDThZW+d9l/1zDcrwr/HgxL5cftQL6
         4Civ1ilMoBXnddXiSDG783mxzWZbuJQDHgIDcJ4gumoipUWJodup9s40wwCWAf7TAjJM
         fDr2VHgYlHiSmqMb65l+Sgyf+l5qTJcCbnYMy1VyFnFOifg6GyiPqes8bLDT/GB1Vku9
         0wow==
X-Gm-Message-State: AO0yUKVATYdD8OsKLbGrwuMiQwgxXG9RqIeC7J79fo92W+vaf3647A0Y
        4LXFbcTwXgkCx1XLKWxAyso44YvCcP0AivFjQrI5/Q==
X-Google-Smtp-Source: AK7set9MGrcd7OX+jyQL3bPRFDTlcTb8iKtIwFr+cEznVewr5XHLHgIlkxlPYX6Wv26mEDxLxmTUjyIJ2/sYuwcoIW0=
X-Received: by 2002:a05:6902:524:b0:ab8:1ed9:cfc5 with SMTP id
 y4-20020a056902052400b00ab81ed9cfc5mr3668856ybs.6.1677972364336; Sat, 04 Mar
 2023 15:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20230303213250.3555716-1-surenb@google.com>
In-Reply-To: <20230303213250.3555716-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 4 Mar 2023 15:25:53 -0800
Message-ID: <CAJuCfpG4yM1k-RuJXzm3EpPGuD32hD_O3cLH-wAAEnnWaBKZ6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: fix vm_lock/i_mmap_rwsem inversion in retract_page_tables
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, rppt@kernel.org,
        jannh@google.com, shakeelb@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, posk@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+8955a9646d1a48b8be92@syzkaller.appspotmail.com
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

On Fri, Mar 3, 2023 at 1:32 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Internal syscaller on linux-next reported a lock inversion cause by
> vm_lock being taken after i_mmap_rwsem:
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.2.0-next-20230301-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor115/5084 is trying to acquire lock:
> ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_write include/linux/mm.h:678 [inline]
> ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: retract_page_tables mm/khugepaged.c:1826 [inline]
> ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: collapse_file+0x4fa5/0x5980 mm/khugepaged.c:2204
>
> but task is already holding lock:
> ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:468 [inline]
> ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: retract_page_tables mm/khugepaged.c:1745 [inline]
> ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: collapse_file+0x3da6/0x5980 mm/khugepaged.c:2204
>
> retract_page_tables takes i_mmap_rwsem before exclusive mmap_lock, which
> is inverse to normal order. Deadlock is avoided by try-locking mmap_lock
> and skipping on failure to obtain it. Locking the VMA should use the same
> locking pattern to avoid this lock inversion.
>
> Fixes: 44a83f2083bd ("mm/khugepaged: write-lock VMA while collapsing a huge page")
> Reported-by: syzbot+8955a9646d1a48b8be92@syzkaller.appspotmail.com
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm.h | 39 ++++++++++++++++++++++++++++-----------
>  mm/khugepaged.c    |  5 ++++-
>  2 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1b9be34a24fb..5f16263d176d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -676,18 +676,23 @@ static inline void vma_end_read(struct vm_area_struct *vma)
>         rcu_read_unlock();
>  }
>
> -static inline void vma_start_write(struct vm_area_struct *vma)
> +static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
>  {
> -       int mm_lock_seq;
> -
>         mmap_assert_write_locked(vma->vm_mm);
>
>         /*
>          * current task is holding mmap_write_lock, both vma->vm_lock_seq and
>          * mm->mm_lock_seq can't be concurrently modified.
>          */
> -       mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
> -       if (vma->vm_lock_seq == mm_lock_seq)
> +       *mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
> +       return (vma->vm_lock_seq == *mm_lock_seq);
> +}
> +
> +static inline void vma_start_write(struct vm_area_struct *vma)
> +{
> +       int mm_lock_seq;
> +
> +       if (__is_vma_write_locked(vma, &mm_lock_seq))
>                 return;
>
>         down_write(&vma->vm_lock->lock);
> @@ -695,14 +700,26 @@ static inline void vma_start_write(struct vm_area_struct *vma)
>         up_write(&vma->vm_lock->lock);
>  }
>
> +static inline bool vma_try_start_write(struct vm_area_struct *vma)
> +{
> +       int mm_lock_seq;
> +
> +       if (__is_vma_write_locked(vma, &mm_lock_seq))
> +               return true;
> +
> +       if (!down_write_trylock(&vma->vm_lock->lock))
> +               return false;
> +
> +       vma->vm_lock_seq = mm_lock_seq;
> +       up_write(&vma->vm_lock->lock);
> +       return true;
> +}
> +
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  {
> -       mmap_assert_write_locked(vma->vm_mm);
> -       /*
> -        * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> -        * mm->mm_lock_seq can't be concurrently modified.
> -        */
> -       VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
> +       int mm_lock_seq;
> +
> +       VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
>  }

Hi Andrew,
I missed vma_try_start_write() definition for CONFIG_PER_VMA_LOCK=n
configuration. Could you please patch this with the following?:

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -740,6 +740,8 @@ static inline bool vma_start_read(struct
vm_area_struct *vma)
  { return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
+static inline bool vma_try_start_write(struct vm_area_struct *vma) {
return true; }
 static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}

or should I send a separate patch?
Thanks,
Suren.


>
>  static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index c64e01f03f27..408fed42c9f5 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1795,6 +1795,10 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>                 result = SCAN_PTE_MAPPED_HUGEPAGE;
>                 if ((cc->is_khugepaged || is_target) &&
>                     mmap_write_trylock(mm)) {
> +                       /* trylock for the same lock inversion as above */
> +                       if (!vma_try_start_write(vma))
> +                               goto unlock_next;
> +
>                         /*
>                          * Re-check whether we have an ->anon_vma, because
>                          * collapse_and_free_pmd() requires that either no
> @@ -1823,7 +1827,6 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>                                 result = SCAN_PTE_UFFD_WP;
>                                 goto unlock_next;
>                         }
> -                       vma_start_write(vma);
>                         collapse_and_free_pmd(mm, vma, addr, pmd);
>                         if (!cc->is_khugepaged && is_target)
>                                 result = set_huge_pmd(vma, addr, pmd, hpage);
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
