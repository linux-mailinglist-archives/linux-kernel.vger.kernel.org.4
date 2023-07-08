Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5210674BFEB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGHXKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 19:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGHXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 19:10:20 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD81102
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 16:10:19 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c1aad78d5b2so6468034276.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688857819; x=1691449819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHBmqS8NwC99Z9QtRqyVciJnx9vOvvM1ypQPd7HicZU=;
        b=aC4JvRwH236lHuuVjAmz79NEJVSGu4y/lyV+aIB63wbpLAmWiLZozzV/UUf7clKQdy
         +r3PNew5EFTC1WrC/weTl9Rg4KI9C1loeR7rdfhvftl7bFZBvg+WX5rXFHoUHlwRccHG
         H5roPa9rNRZpaOd/D7jMAJ7mC2TUiS4BVHWIC8SW3iTtVDYqMAaGIgWohMK2lnVNoynB
         hJJZqyMf7CIF+Mjkeh/5GT66mCZKLJeXGdex0kJ7A1CYTZ4IW+10Kb5CuhiMT2XcDU2V
         USI9u190+1iYAZmtXcU8yuRMzj6cmZmjxLxj2oxypX5TZLV/7cn58g+QvYRPWbGj2IG9
         isgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688857819; x=1691449819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHBmqS8NwC99Z9QtRqyVciJnx9vOvvM1ypQPd7HicZU=;
        b=Jfx2atdWzthGcBAO4nuoJ84LmcrjhwwMn7Pdeo0NQxByp2aXiiX7OGkGneOnWF0CpW
         U3g7GHgynql4/iE+etM2+BrqDrhkr05EGtZW2LrKbL5nYBrcpoam/5RKN3JpOssuIwtS
         uxF8xjqM4u+k3XCtt1sWuNc2x0fkFsv9iB2gq4h3oBAg0Lyj6DKQZgNdzvBFT8ZwcRlM
         RJUH0exvS2nbpI8AyNalfY2OHy57SUceKgk+DVFducJUu4SwpBhoVOvLAuA7n0FSfWcp
         CALxsWY3XDS7kfocGrel5MCX/qVtDOY+VlyhHc4fXXsJnwL/XM4/Z2fteKcfihs2F3yF
         0Iww==
X-Gm-Message-State: ABy/qLb2Fz/lnTEhkYG12DkxDrrlEnb6Dfn70j+97Ts9WASzHhib0eLn
        /hRmapRIbBP5QvPB7Bcg4MwC4vbgSjTwaM21HV9PYg==
X-Google-Smtp-Source: APBJJlGlS5xEDkfZpc19JrLy3RDko6OpCb3oW1HWrIZs49KQqhT9ol0NyMJ1vIr071SbtX0uRyAhsa+cCc58DLTyhYY=
X-Received: by 2002:a81:a114:0:b0:56d:2e66:bd55 with SMTP id
 y20-20020a81a114000000b0056d2e66bd55mr6858350ywg.3.1688857818674; Sat, 08 Jul
 2023 16:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <b5a5626-2684-899d-874b-801e7974b17@google.com>
In-Reply-To: <b5a5626-2684-899d-874b-801e7974b17@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 8 Jul 2023 16:10:07 -0700
Message-ID: <CAJuCfpGXC23r11-0jz+an01tO2BUOMpjJ93Dm3pc+EUQM=BXYg@mail.gmail.com>
Subject: Re: [PATCH] mm: lock newly mapped VMA with corrected ordering
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 4:04=E2=80=AFPM Hugh Dickins <hughd@google.com> wrot=
e:
>
> Lockdep is certainly right to complain about
> (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_write+0x2d/0x3f
>                but task is already holding lock:
> (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: mmap_region+0x4dc/0x6db
> Invert those to the usual ordering.

Doh! Thanks Hugh!
I totally forgot to run this with lockdep enabled :(

>
> Fixes: 33313a747e81 ("mm: lock newly mapped VMA which can be modified aft=
er it becomes visible")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/mmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 84c71431a527..3eda23c9ebe7 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2809,11 +2809,11 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>         if (vma_iter_prealloc(&vmi))
>                 goto close_and_free_vma;
>
> +       /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> +       vma_start_write(vma);
>         if (vma->vm_file)
>                 i_mmap_lock_write(vma->vm_file->f_mapping);
>
> -       /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> -       vma_start_write(vma);
>         vma_iter_store(&vmi, vma);
>         mm->map_count++;
>         if (vma->vm_file) {
> --
> 2.35.3
