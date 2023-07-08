Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5570374BFF9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 01:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGHXXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 19:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGHXXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 19:23:10 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A64E44
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 16:23:09 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5704fce0f23so39839657b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688858588; x=1691450588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJmd9FNoExrkZazabhisTEX13e3yTkQujDR9ImsW+As=;
        b=KAr00s05g8LvJTb3B4MfRknnBcOsPzBA8MpmvEk9MyW2dsnWRJ+gR0zO8PseNnhyds
         6Mt9nJsN6mDK1Dh0NvAnhRCWzYZxHAhlfLQy9RHgQ4LNeE/wsu1rS7QDkdsSrHxffmbG
         LncoxcuQ5LD5OovH5vrPd/CfkojrHatihkBkTAqHapCmqs2qMs/IOwteAtH86tzhaWr+
         E8r1XVvTEXmScKTJlgEBa93UC+N33QJ1k4AhSrsn7Uk/wL8h6+7Vf6PuBvhB/DZSWdgZ
         jmFzygQ4Fr5KUeiYWIsHonmdkl7IWGEiCBU4SkTSiHEkZDV2rwxK3hTecpts0OknAuAS
         gqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688858588; x=1691450588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJmd9FNoExrkZazabhisTEX13e3yTkQujDR9ImsW+As=;
        b=FdesqPcepZ9OEyZanLHi0d+SY6g/cSBKtTbKI9lLJ9N9Z1eU7oMC38bXx6EngHekC8
         JdUy5+y2GR3rN5h/LZxhcFwgMl8Dkiocs8CCCegyz6zkyhaQrjjywj7PbsCFImrA5eqy
         Ybwz2X34RevWgU3JBIed0So775rD37Jz7jSV2tiIxAntppaObjBtOkM5ACPihxQQ97t1
         2ecRRUgxyBNUvyYn60XeXhmQ85QrByf+f+/DlgGYLKheKYquqP9jRqVnf5QB++J4Xrog
         0UIeHIDsxByU90ILT/ylAn4wNx5SSty3m4GrYQhtonqY7Ch9kgCcxaYAjeh5e704ZvD5
         3vFQ==
X-Gm-Message-State: ABy/qLbgeEAOnjbA20p1IqLIY4r3EvEPgeaFVdr20/+9swj28zMaAPTb
        FE8Y4RPJlxO8V5V8y3M7r1cSf7tDHU1i19IuSC63+w==
X-Google-Smtp-Source: APBJJlHs1/S5FDnBZdy+MijP9fwBR6OMu6G+Y9QcTJ4N/KwfTKOEXMXKD5Sjy19yPHubJ4iO8EvZDNmedrlxShdDCY0=
X-Received: by 2002:a81:6d95:0:b0:56d:3f2:35a3 with SMTP id
 i143-20020a816d95000000b0056d03f235a3mr8095661ywc.44.1688858587953; Sat, 08
 Jul 2023 16:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <b5a5626-2684-899d-874b-801e7974b17@google.com> <CAJuCfpGXC23r11-0jz+an01tO2BUOMpjJ93Dm3pc+EUQM=BXYg@mail.gmail.com>
In-Reply-To: <CAJuCfpGXC23r11-0jz+an01tO2BUOMpjJ93Dm3pc+EUQM=BXYg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 8 Jul 2023 16:22:56 -0700
Message-ID: <CAJuCfpEyOXYh+dhW5iUFsz_s4P_pka9cD3M6qc8dDit5JxH3mw@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 4:10=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Sat, Jul 8, 2023 at 4:04=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
> >
> > Lockdep is certainly right to complain about
> > (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_write+0x2d/0x3f
> >                but task is already holding lock:
> > (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: mmap_region+0x4dc/0x6db
> > Invert those to the usual ordering.
>
> Doh! Thanks Hugh!
> I totally forgot to run this with lockdep enabled :(

I verified both the lockdep warning and the fix. Thanks again, Hugh!

Tested-by: Suren Baghdasaryan <surenb@google.com>

>
> >
> > Fixes: 33313a747e81 ("mm: lock newly mapped VMA which can be modified a=
fter it becomes visible")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  mm/mmap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 84c71431a527..3eda23c9ebe7 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2809,11 +2809,11 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> >         if (vma_iter_prealloc(&vmi))
> >                 goto close_and_free_vma;
> >
> > +       /* Lock the VMA since it is modified after insertion into VMA t=
ree */
> > +       vma_start_write(vma);
> >         if (vma->vm_file)
> >                 i_mmap_lock_write(vma->vm_file->f_mapping);
> >
> > -       /* Lock the VMA since it is modified after insertion into VMA t=
ree */
> > -       vma_start_write(vma);
> >         vma_iter_store(&vmi, vma);
> >         mm->map_count++;
> >         if (vma->vm_file) {
> > --
> > 2.35.3
