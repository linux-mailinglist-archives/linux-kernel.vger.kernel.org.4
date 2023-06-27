Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796927400FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjF0QZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjF0QZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818263594
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687883082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mgfy3ZXXgXJMVAGb4+oxMVfqPwB6JstJnnUKkP8Y35s=;
        b=LEf6A6jexaCZpSSmSzG3UqJHXo/k3Xjz2gNxBCromPyV9Y6xpgbPgl7+x2hy4hItUQQsBO
        kgFdjibvgV6nV+NYpUp114S52cjUhmvjJtqblMmqz9MbHN+NKBy1TSuPMIT7CoqI8WRSJZ
        jN8OgbWX8dP3TlrjxHwYSyKr+l2CgRY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-_v56Lc-SPKyBxnvRiaq5-w-1; Tue, 27 Jun 2023 12:24:29 -0400
X-MC-Unique: _v56Lc-SPKyBxnvRiaq5-w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76545dc12ebso77844885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883063; x=1690475063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mgfy3ZXXgXJMVAGb4+oxMVfqPwB6JstJnnUKkP8Y35s=;
        b=PtWOUtXMcwwqmaUiqqeQIRccE8gb9bl4d7l0WcfH0PM3SkLt8pbpT4GxzuQbnaMPVq
         5Duuf5slba/F90eqyzB7a4+R3Bph2RXvjwiQ7W0kNGgRi1VEeV4s9XI5phvFXlM0eG6O
         POF7Xdwzv2D3Z8E7Mn0uuQu/JyYlpjgMJDeacarQrMjFYc9zdCtH0U9uIcUHYHNJbiRo
         W96poRFfFOgIBEO9xYIUAScIAWw7OUerlOF6kpvcdx1li2yXT/wjs3mAagg3zWSqd5Mf
         6IvgOdpWbbSfbUXVJA4FELLJCaUbC3R0htDxJGqGMA5wFgclXu9to3slEWrjGIZ7bnWd
         6xUw==
X-Gm-Message-State: AC+VfDy6bLdGVFi0yHJh0KOWRKSWs/37M/Ua92pmOYSSVEiNJ7euWrRp
        LiDpsV+FwjgdHaixEkOxddX7k4e2qJCGUB9B06aDq837rwp8aJSmaxiBaODyaQYEtoF1yNor1y1
        jxdp3it1gaLFDr+N2ZBEsFdHz
X-Received: by 2002:a05:620a:4502:b0:75b:23a1:69f0 with SMTP id t2-20020a05620a450200b0075b23a169f0mr45160900qkp.7.1687883062654;
        Tue, 27 Jun 2023 09:24:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4N80tCfrDuSYYuboDG5GYUYSpis6DKre0Lz8au633iIZSaQabV/3oaNp9WWlqAr2nLop5NVA==
X-Received: by 2002:a05:620a:4502:b0:75b:23a1:69f0 with SMTP id t2-20020a05620a450200b0075b23a169f0mr45160860qkp.7.1687883062320;
        Tue, 27 Jun 2023 09:24:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z19-20020a05620a101300b007625382f4d6sm4087674qkj.84.2023.06.27.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:22 -0700 (PDT)
Date:   Tue, 27 Jun 2023 12:24:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 6/8] mm: handle swap page faults under per-VMA lock
Message-ID: <ZJsNNEDlHJL+x38n@x1n>
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-7-surenb@google.com>
 <ZJsDMRkFRz11R0dt@x1n>
 <CAJuCfpFNTj-1q=ZrNKO=4=VdBwiq_mTHWnXo0_QKi=AgCOo9yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFNTj-1q=ZrNKO=4=VdBwiq_mTHWnXo0_QKi=AgCOo9yw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 09:05:32AM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 27, 2023 at 8:41 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Jun 26, 2023 at 09:23:19PM -0700, Suren Baghdasaryan wrote:
> > > When page fault is handled under per-VMA lock protection, all swap page
> > > faults are retried with mmap_lock because folio_lock_fault (formerly
> > > known as folio_lock_or_retry) had to drop and reacquire mmap_lock
> > > if folio could not be immediately locked.
> > > Follow the same pattern as mmap_lock to drop per-VMA lock when waiting
> > > for folio in folio_lock_fault and retrying once folio is available.
> > > With this obstacle removed, enable do_swap_page to operate under
> > > per-VMA lock protection. Drivers implementing ops->migrate_to_ram might
> > > still rely on mmap_lock, therefore we have to fall back to mmap_lock in
> > > that particular case.
> > > Note that the only time do_swap_page calls synchronous swap_readpage
> > > is when SWP_SYNCHRONOUS_IO is set, which is only set for
> > > QUEUE_FLAG_SYNCHRONOUS devices: brd, zram and nvdimms (both btt and
> > > pmem). Therefore we don't sleep in this path, and there's no need to
> > > drop the mmap or per-VMA lock.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/filemap.c | 24 ++++++++++++++++--------
> > >  mm/memory.c  | 21 ++++++++++++++-------
> > >  2 files changed, 30 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 8ad06d69895b..683f11f244cd 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -1703,12 +1703,14 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
> > >   * Return values:
> > >   * 0 - folio is locked.
> > >   * VM_FAULT_RETRY - folio is not locked.
> > > - *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
> > > - *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
> > > - *     which case mmap_lock is still held.
> > > + *     FAULT_FLAG_LOCK_DROPPED bit in vmf flags will be set if mmap_lock or
> >
> > This "FAULT_FLAG_LOCK_DROPPED" should belong to that patch when introduced.
> > But again I still think this flag as a whole with that patch is not needed
> > and should be dropped, unless I miss something important..
> >
> > > + *     per-VMA lock got dropped. mmap_lock/per-VMA lock is dropped when
> > > + *     function fails to lock the folio, unless flags had both
> > > + *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in which case
> > > + *     the lock is still held.
> > >   *
> > >   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
> > > - * with the folio locked and the mmap_lock unperturbed.
> > > + * with the folio locked and the mmap_lock/per-VMA lock unperturbed.
> > >   */
> > >  vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
> > >  {
> > > @@ -1716,13 +1718,16 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
> > >
> > >       if (fault_flag_allow_retry_first(vmf->flags)) {
> > >               /*
> > > -              * CAUTION! In this case, mmap_lock is not released
> > > -              * even though return VM_FAULT_RETRY.
> > > +              * CAUTION! In this case, mmap_lock/per-VMA lock is not
> > > +              * released even though returning VM_FAULT_RETRY.
> > >                */
> > >               if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> > >                       return VM_FAULT_RETRY;
> > >
> > > -             mmap_read_unlock(mm);
> > > +             if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > > +                     vma_end_read(vmf->vma);
> > > +             else
> > > +                     mmap_read_unlock(mm);
> > >               vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
> > >               if (vmf->flags & FAULT_FLAG_KILLABLE)
> > >                       folio_wait_locked_killable(folio);
> > > @@ -1735,7 +1740,10 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
> > >
> > >               ret = __folio_lock_killable(folio);
> > >               if (ret) {
> > > -                     mmap_read_unlock(mm);
> > > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > > +                             vma_end_read(vmf->vma);
> > > +                     else
> > > +                             mmap_read_unlock(mm);
> > >                       vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
> > >                       return VM_FAULT_RETRY;
> > >               }
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 3c2acafcd7b6..5caaa4c66ea2 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3712,11 +3712,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >       if (!pte_unmap_same(vmf))
> > >               goto out;
> > >
> > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> >
> > So if with my imagination, here we'll already have the vma_read_end() and
> > this patch will remove it, which makes sense.  Then...
> >
> > > -             ret = VM_FAULT_RETRY;
> > > -             goto out;
> > > -     }
> > > -
> > >       entry = pte_to_swp_entry(vmf->orig_pte);
> > >       if (unlikely(non_swap_entry(entry))) {
> > >               if (is_migration_entry(entry)) {
> > > @@ -3726,6 +3721,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >                       vmf->page = pfn_swap_entry_to_page(entry);
> > >                       ret = remove_device_exclusive_entry(vmf);
> > >               } else if (is_device_private_entry(entry)) {
> > > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > +                             /*
> > > +                              * migrate_to_ram is not yet ready to operate
> > > +                              * under VMA lock.
> > > +                              */
> >
> > ... here we probably just do vma_read_end(), then...
> >
> > > +                             ret |= VM_FAULT_RETRY;
> > > +                             goto out;
> > > +                     }
> > > +
> > >                       vmf->page = pfn_swap_entry_to_page(entry);
> > >                       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> > >                                       vmf->address, &vmf->ptl);
> > > @@ -5089,9 +5093,12 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> > >               /*
> > >                * In case of VM_FAULT_RETRY or VM_FAULT_COMPLETED we might
> > >                * be still holding per-VMA lock to keep the vma stable as long
> > > -              * as possible. Drop it before returning.
> > > +              * as possible. In this situation vmf.flags has
> > > +              * FAULT_FLAG_VMA_LOCK set and FAULT_FLAG_LOCK_DROPPED unset.
> > > +              * Drop the lock before returning when this happens.
> > >                */
> > > -             if (vmf.flags & FAULT_FLAG_VMA_LOCK)
> > > +             if ((vmf.flags & (FAULT_FLAG_VMA_LOCK | FAULT_FLAG_LOCK_DROPPED)) ==
> > > +                 FAULT_FLAG_VMA_LOCK)
> > >                       vma_end_read(vma);
> >
> > This whole chunk should have been dropped altogether with my comment in
> > previous patch, iiuc, and it should be no-op anyway for swap case.  For the
> > real "waiting for page lock during swapin" phase we should always 100%
> > release the vma lock in folio_lock_or_retry() - just like mmap lock.
> 
> Yep, we drop FAULT_FLAG_LOCK_DROPPED, release vma lock when we return
> RETRY and that makes all this unnecessary. I just need to make sure we
> do not access VMA after we drop its lock since we will be releasing it
> now earlier than before.

Yes.  Hopefully that's not a problem, because mmap lock has it the same
way.  And that's also the good thing if we can always keep both locks
behaving the same if possible, because the problem is really shared, imho.

-- 
Peter Xu

