Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754826E2A19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDNScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:32:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23244EDD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 11:32:20 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id t16so6972068ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681497139; x=1684089139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R5kWy896vjoesu4O0RFZZzRsEx8VcqeAkJsUgFCRL0=;
        b=Ul6jEmOGCg1c3Ihk12V0PQAuS1Bk9LAP66eWiedesgOMFnNLIHcata9Vf96fQ/AL0v
         c1EDsgGWvKZex15KRoLvZ6Mb2a0lIvYxmJLUEViyOwBT5ap8l6wDqOEjFxZ8HuKKjQgI
         Va3A/rpo6T1yG6sgzHfLXhlQbAHQC9cP5j+O4Gb+0QpDFF/A7DR85vHLr4ZTXMMtM0Ge
         +dOrvVa3N93oFr19YuljSDF9Y5efKW6fqEThzuU1pLQl048K58ZCjT5nGig9B57NWtQK
         hYhv5n0/2uNEdthA/KhH06hTSopgwV/PcaFiJuf83uBZKJNnJ8+Z1SwipjQVHTnQyiCZ
         NQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497139; x=1684089139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R5kWy896vjoesu4O0RFZZzRsEx8VcqeAkJsUgFCRL0=;
        b=Doh4dcHm3dgp4fM14zgCd8va/kq0TobOk6CXXm2nP9vc3D9ARAtd/jzIbEpEfZQJ3x
         7v44bH9g0ctklzBG+GVU/zfUEK0kkiWqOj6b+lfb3izGW7LwyRNpZN+nboN9qeTWzQ80
         yaseP+FD2WG72GGyp7VXBfbbTuFBW94ENKuEX92jFleBTaUhXEbzQ3LOUkw6mUz+P+qH
         taQZwQygP3j/ESGX0gI7oXpeIYfXR6h9ohH1eVr5AfTOrGop86cHqzkP4zReT6GIVLqe
         XW79QZ1KnYc56rkAq4pqgsXu9i662yUNgS+ZfgoUPbOQMP3xd+7RiZMSnnYpoo4tX6xQ
         K7mg==
X-Gm-Message-State: AAQBX9cj3k0J6llFtqLoxK0uB7Jj1Vsi8chirFQ7oAeZkSqiPFHQFcDa
        bgro0aWA8UOeIjJt1M5i4XAcujYp+TYW0I1ztvrwFQ==
X-Google-Smtp-Source: AKy350YDghSfb9CJEUH62FyYCXzTg2oCqrdREQ+EUBJ6LuVV+B8OSqGENxuxWXX2ErxGsRZROj0sUJreyqv67SwRBIU=
X-Received: by 2002:a25:d2d2:0:b0:b8f:480c:ba49 with SMTP id
 j201-20020a25d2d2000000b00b8f480cba49mr4004954ybg.4.1681497139125; Fri, 14
 Apr 2023 11:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230414180043.1839745-1-surenb@google.com>
In-Reply-To: <20230414180043.1839745-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Apr 2023 11:32:08 -0700
Message-ID: <CAJuCfpFwFxYo22to73bi6WwOtrSZNCQrF4PGD65wjEroRKoK5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page can
 be locked
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:00=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> When page fault is handled under VMA lock protection, all swap page
> faults are retried with mmap_lock because folio_lock_or_retry
> implementation has to drop and reacquire mmap_lock if folio could
> not be immediately locked.
> Instead of retrying all swapped page faults, retry only when folio
> locking fails.

I just realized that the title of the patch is misleading. It's about
handling page fault under VMA lock. A better title would be something
like:

"mm: handle swap page faults under vma lock if page is uncontended"

>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Patch applies cleanly over linux-next and mm-unstable
>
>  mm/filemap.c | 6 ++++++
>  mm/memory.c  | 5 -----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6f3a7e53fccf..67b937b0f436 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1706,6 +1706,8 @@ static int __folio_lock_async(struct folio *folio, =
struct wait_page_queue *wait)
>   *     mmap_lock has been released (mmap_read_unlock(), unless flags had=
 both
>   *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
>   *     which case mmap_lock is still held.
> + *     If flags had FAULT_FLAG_VMA_LOCK set, meaning the operation is pe=
rformed
> + *     with VMA lock only, the VMA lock is still held.
>   *
>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
>   * with the folio locked and the mmap_lock unperturbed.
> @@ -1713,6 +1715,10 @@ static int __folio_lock_async(struct folio *folio,=
 struct wait_page_queue *wait)
>  bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>                          unsigned int flags)
>  {
> +       /* Can't do this if not holding mmap_lock */
> +       if (flags & FAULT_FLAG_VMA_LOCK)
> +               return false;
> +
>         if (fault_flag_allow_retry_first(flags)) {
>                 /*
>                  * CAUTION! In this case, mmap_lock is not released
> diff --git a/mm/memory.c b/mm/memory.c
> index d88f370eacd1..3301a8d01820 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3715,11 +3715,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (!pte_unmap_same(vmf))
>                 goto out;
>
> -       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> -               ret =3D VM_FAULT_RETRY;
> -               goto out;
> -       }
> -
>         entry =3D pte_to_swp_entry(vmf->orig_pte);
>         if (unlikely(non_swap_entry(entry))) {
>                 if (is_migration_entry(entry)) {
> --
> 2.40.0.634.g4ca3ef3211-goog
>
