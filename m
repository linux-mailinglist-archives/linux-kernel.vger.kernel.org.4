Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6C96FFE5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbjELBWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbjELBWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:22:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F259C6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:22:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f4c8d78a18so25182591cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683854535; x=1686446535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0EOL6LTB8cUfvNIYifV3ZbFHay8GGDSwBe2dif3Kp8=;
        b=Cb9+L6FOD7IB1lj2riMlPrBVLYqEGE9xd8ZQK2J+0Sj0EtCsqCzfoO+5gYhIhokByc
         Nnzlxaf8YFuQwHPlXu/efqHJOy3GI6cvI8mPB8t5AqlSjjQ79q6uQR4D2zryQfyfdDxq
         F6T9V0d0xPynniezKDpylx9PSenV3XT+FGhJRjvrvjEsbtoWImDTeepJBRvXQh+VnD7m
         sOvTb83dASoHf9hABqjntHOoKk0TDTME/UH9yBHCIdlo4C2oIdEllQQtGO16gYQttU/H
         tQw4wrmRKoBoJ4oxgorndvbSjR9IwTc0z4lMHdwIDs/NmqDE4sB51VIe8QCMx7031P6y
         xJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683854535; x=1686446535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0EOL6LTB8cUfvNIYifV3ZbFHay8GGDSwBe2dif3Kp8=;
        b=bcZk3BoHdLFv4UR5cer/V5Rz9E4+5wIMWvn5OTP61pidUyOioJ+jHvdTmlTljnv/iI
         uPge/KSWavsFkb0kiVlA37jLKd+67ziptheFBykCOi9tgJeLHyjs2o9OiZn71B6tfpQD
         H5BU+3lEqFLTTjOLKZxFD1wQsdJ/bnrkLrC63i9TWP5+m2DBmLEtKjmHqWRQ2SdrBAYu
         XVQ+M8HSUSwCb/ZeZemV77KTJ68DnbD71qYkJnfnOYbOg8RDxyMwVHWCWo3utl5FhacP
         VvYzjYXJJD7nydzxofVNi6IodeNEDUClCEZFRbarsY8tyc58o3oeZBxMcKvckN6S3Ldr
         yD2g==
X-Gm-Message-State: AC+VfDx3sIjBoS+uEeUgDmhitfZBd7mYo1Cj8BnNKxCfbhnQNc+PBNKq
        VKjGcPGwTAEbRqL0DE7EtLx4gyUltB+9Hw==
X-Google-Smtp-Source: ACHHUZ7L4brVemAOQ+tS5peAIkSwaiZOQtK3Cfu4k9VlCRnFDLKYz/z5Q1PqAYrUFZleLNZqh6m0gw==
X-Received: by 2002:a05:622a:1011:b0:3f4:427:dbb8 with SMTP id d17-20020a05622a101100b003f40427dbb8mr13492655qte.2.1683854535350;
        Thu, 11 May 2023 18:22:15 -0700 (PDT)
Received: from localhost ([207.164.22.35])
        by smtp.gmail.com with ESMTPSA id ci14-20020a05622a260e00b003e693d92781sm2665866qtb.70.2023.05.11.18.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 18:22:13 -0700 (PDT)
Date:   Thu, 11 May 2023 18:22:11 -0700
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Message-ID: <ZF2Uwwsreaq-zPif@murray>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
 <ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com>
 <ZFvAnF0DzEUN7F9r@murray>
 <ZFvDrZRV8RnoPR69@FVFF77S0Q05N.cambridge.arm.com>
 <ZFvFoj--H21sxzCQ@murray>
 <20230511180841.GE4135@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511180841.GE4135@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:08:41AM -0700, Mike Rapoport wrote:
> (adding Peter)
>
> On Wed, May 10, 2023 at 09:26:10AM -0700, Lorenzo Stoakes wrote:
> > On Wed, May 10, 2023 at 05:17:49PM +0100, Mark Rutland wrote:
> > > On Wed, May 10, 2023 at 09:04:44AM -0700, Lorenzo Stoakes wrote:
> > > > On Wed, May 10, 2023 at 03:15:51PM +0100, Mark Rutland wrote:
> > > > > Hi,
> > > > >
> > > > > On Sun, Apr 30, 2023 at 09:19:17PM +0100, Lorenzo Stoakes wrote:
> > > > > > We may still have inconsistent input parameters even if we choose not to
> > > > > > merge and the vma_merge() invariant checks are useful for checking this
> > > > > > with no production runtime cost (these are only relevant when
> > > > > > CONFIG_DEBUG_VM is specified).
> > > > > >
> > > > > > Therefore, perform these checks regardless of whether we merge.
> > > > > >
> > > > > > This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> > > > > > Correctly update prev when policy is equal on mbind") in the mbind logic
> > > > > > was only picked up in the 6.2.y stable branch where these assertions are
> > > > > > performed prior to determining mergeability.
> > > > > >
> > > > > > Had this remained the same in mainline this issue may have been picked up
> > > > > > faster, so moving forward let's always check them.
> > > > > >
> > > > > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > > > > ---
> > > > > >  mm/mmap.c | 10 +++++-----
> > > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > > index 5522130ae606..13678edaa22c 100644
> > > > > > --- a/mm/mmap.c
> > > > > > +++ b/mm/mmap.c
> > > > > > @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> > > > > >  		merge_next = true;
> > > > > >  	}
> > > > > >
> > > > > > +	/* Verify some invariant that must be enforced by the caller. */
> > > > > > +	VM_WARN_ON(prev && addr <= prev->vm_start);
> > > > > > +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > > > > > +	VM_WARN_ON(addr >= end);
> > > > > > +
> > > > >
> > > > > I'm seeing this fire a lot when fuzzing v6.4-rc1 on arm64 using Syzkaller.
> > > > >
> > > >
> > > > Thanks, from the line I suspect addr != curr->vm_start, but need to look
> > > > into the repro, at lsf/mm so a bit time lagged :)
> > >
> > > No problem; FWIW I can confirm your theory, the reproducer is causing:
> > >
> > > 	addr > curr->vm_start
> > >
> > > ... confirmed the the following hack, log below.
> >
> > Awesome thanks for that! Just been firing up qemu to do this.
> >
> > Cases 5-8 should really have addr == curr->vm_start, I wonder if it's
> > another case but curr is being set incorrectly, it should in theory not be
> > the case.
>
> AFAIU, it's a case of "adjust vma, but don't merge, because prev is not
> compatible". Looks like uffd first attempts to merge compatible the newly
> registered range with adjacent vmas relying on that there won't be no merge
> when addr != curr->vm_start and only after the merge attempt it splits the
> edges.
>
> I think that moving the split in fs/userfaultfd.c:1495 (as of v6.4-rc1)
> before vma_merge() will be the right fix.
>

Ack this was my strong suspicion, just want to get back to the UK and
de-lagged before I dig in properly.

> > (See [1] for a visualisation of merge cases as a handy reference)
> >
> > Of course userfaultfd might be the offender here and might be relying on no
> > merge case arising but passing dodgy parameters.
> >
> > [1]:https://ljs.io/merge_cases.png
>
> You really should put it into Documentation/mm ;-)

Well... will reply to your lsf/mm docs thread on this topic ;)

>
> > >
> > > | diff --git a/mm/mmap.c b/mm/mmap.c
> > > | index 13678edaa22c..2cdebba15719 100644
> > > | --- a/mm/mmap.c
> > > | +++ b/mm/mmap.c
> > > | @@ -961,9 +961,21 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> > > |         }
> > > |
> > > |         /* Verify some invariant that must be enforced by the caller. */
> > > | -       VM_WARN_ON(prev && addr <= prev->vm_start);
> > > | -       VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > > | -       VM_WARN_ON(addr >= end);
> > > | +       VM_WARN(prev && addr <= prev->vm_start,
> > > | +               "addr = 0x%016lx, prev->vm_start = 0x%016lx\n",
> > > | +               addr, prev->vm_start);
> > > | +
> > > | +       VM_WARN(curr && addr != curr->vm_start,
> > > | +               "addr = 0x%016lx, curr->vm_start = 0x%016lx\n",
> > > | +               addr, curr->vm_start);
> > > | +
> > > | +       VM_WARN(curr && addr > curr->vm_end,
> > > | +               "addr = 0x%016lx, curr->vm_end = 0x%016lx\n",
> > > | +               addr, curr->vm_end);
> > > | +
> > > | +       VM_WARN(addr >= end,
> > > | +               "addr = 0x%016lx, end = 0x%016lx\n",
> > > | +               addr, end);
> > > |
> > > |         if (!merge_prev && !merge_next)
> > > |                 return NULL; /* Not mergeable. */
> > >
> > > ... with that applied, running the reproducer results in:
> > >
> > > | addr = 0x0000ffff99dc2000, curr->vm_start = 0x0000ffff99db2000
> > > | WARNING: CPU: 0 PID: 163 at mm/mmap.c:968 vma_merge+0x3d4/0x1260
> > >
> > > ... i.e. addr > curr->vm_start
> > >
> > > Thanks,
> > > Mark.
> >
