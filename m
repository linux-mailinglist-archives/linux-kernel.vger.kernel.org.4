Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E756FE274
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjEJQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjEJQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:26:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A5903F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:26:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so6821830a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683735972; x=1686327972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pslZOgz8wkHeX8xxKxzfahRXVqtGiv01nZPHkXBTPI=;
        b=I00Q9fmZldW6VKmGYvR0kwD3KwNq31xAm7SgntwuvdDgZQvVU/M17zc/OLdH6a+h3t
         /f3hvwToz2QrD27di2LVQWLQuowAnHC5Jn6kbl9UyavtJ2K9NrDMocNpHbyHJbDblpo1
         AZpiwQd871Rt2i6Flu8ATmD+91ouHh+A/jR9P/rIgGxF5wFyfhVye97E60orhrOt42pQ
         Z+qOu7hZDLu+kkBruVMqUndAB8VfpBkpSNlouY4kP++WARX3HqB6cbBti/Jlgb7uMgkZ
         WGuIemMVDE7LS+0v2lksthGK25464aVrJHh79OZln8IHirYrOzKy8hPywmgkPPD3CED4
         MtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735972; x=1686327972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pslZOgz8wkHeX8xxKxzfahRXVqtGiv01nZPHkXBTPI=;
        b=kZ9qZTynNtM2Ex1k0Wtr9S7TpbCb5j2vAAcHiBH+Z3YM4KeDYK3KsZVUMdxXZE9AJO
         l97micFk27fUkdQf4ZWDwOoVMO+LqWa03k2lZy6dCf+c1vvBVdtnTcq9YCrVi065vx1s
         z3NvlOvLEgQ0lFMoS8xmPXRcqfp2eRgHy7zQjBKJtRrUI+D8lgg3GIIBiD+aSKIkBzEI
         4anTV9hrq5tHTBjvfrmTwDlF1Fa0/I+/B+3iVmKmeECZFBHP6dqH4D2NyFBWjBvQF6pT
         Gg0AX23cL3wNFeBhPwZAzp5Qi0Fp0mh/We/PZooYqwRN77+QwhRYLEPBTgtol5CENicn
         GqDw==
X-Gm-Message-State: AC+VfDw+8JPth7QgxwaaflRAdkvp2QZbxA7xT7Z8oANK3fIJmJZge2Ww
        /KGrbOazDse72y+/z4QVvXc=
X-Google-Smtp-Source: ACHHUZ58TnBTMiT7Ug0Q8LJkOim+f1uHutHZVndU+ZFGouu8a9YPGmzX2yycRlUPyF4kSS5KnMa29g==
X-Received: by 2002:a17:90a:13ce:b0:24e:3ed9:23a1 with SMTP id s14-20020a17090a13ce00b0024e3ed923a1mr18810874pjf.28.1683735971667;
        Wed, 10 May 2023 09:26:11 -0700 (PDT)
Received: from localhost ([2001:4958:15a0:30:c4b3:fc4f:6ca4:f972])
        by smtp.gmail.com with ESMTPSA id gp24-20020a17090adf1800b0024e227828a9sm8872127pjb.24.2023.05.10.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:26:10 -0700 (PDT)
Date:   Wed, 10 May 2023 09:26:10 -0700
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Message-ID: <ZFvFoj--H21sxzCQ@murray>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
 <ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com>
 <ZFvAnF0DzEUN7F9r@murray>
 <ZFvDrZRV8RnoPR69@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFvDrZRV8RnoPR69@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:17:49PM +0100, Mark Rutland wrote:
> On Wed, May 10, 2023 at 09:04:44AM -0700, Lorenzo Stoakes wrote:
> > On Wed, May 10, 2023 at 03:15:51PM +0100, Mark Rutland wrote:
> > > Hi,
> > >
> > > On Sun, Apr 30, 2023 at 09:19:17PM +0100, Lorenzo Stoakes wrote:
> > > > We may still have inconsistent input parameters even if we choose not to
> > > > merge and the vma_merge() invariant checks are useful for checking this
> > > > with no production runtime cost (these are only relevant when
> > > > CONFIG_DEBUG_VM is specified).
> > > >
> > > > Therefore, perform these checks regardless of whether we merge.
> > > >
> > > > This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> > > > Correctly update prev when policy is equal on mbind") in the mbind logic
> > > > was only picked up in the 6.2.y stable branch where these assertions are
> > > > performed prior to determining mergeability.
> > > >
> > > > Had this remained the same in mainline this issue may have been picked up
> > > > faster, so moving forward let's always check them.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > > ---
> > > >  mm/mmap.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 5522130ae606..13678edaa22c 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> > > >  		merge_next = true;
> > > >  	}
> > > >
> > > > +	/* Verify some invariant that must be enforced by the caller. */
> > > > +	VM_WARN_ON(prev && addr <= prev->vm_start);
> > > > +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > > > +	VM_WARN_ON(addr >= end);
> > > > +
> > >
> > > I'm seeing this fire a lot when fuzzing v6.4-rc1 on arm64 using Syzkaller.
> > >
> >
> > Thanks, from the line I suspect addr != curr->vm_start, but need to look
> > into the repro, at lsf/mm so a bit time lagged :)
>
> No problem; FWIW I can confirm your theory, the reproducer is causing:
>
> 	addr > curr->vm_start
>
> ... confirmed the the following hack, log below.

Awesome thanks for that! Just been firing up qemu to do this.

Cases 5-8 should really have addr == curr->vm_start, I wonder if it's
another case but curr is being set incorrectly, it should in theory not be
the case.

(See [1] for a visualisation of merge cases as a handy reference)

Of course userfaultfd might be the offender here and might be relying on no
merge case arising but passing dodgy parameters.

[1]:https://ljs.io/merge_cases.png

>
> | diff --git a/mm/mmap.c b/mm/mmap.c
> | index 13678edaa22c..2cdebba15719 100644
> | --- a/mm/mmap.c
> | +++ b/mm/mmap.c
> | @@ -961,9 +961,21 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> |         }
> |
> |         /* Verify some invariant that must be enforced by the caller. */
> | -       VM_WARN_ON(prev && addr <= prev->vm_start);
> | -       VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> | -       VM_WARN_ON(addr >= end);
> | +       VM_WARN(prev && addr <= prev->vm_start,
> | +               "addr = 0x%016lx, prev->vm_start = 0x%016lx\n",
> | +               addr, prev->vm_start);
> | +
> | +       VM_WARN(curr && addr != curr->vm_start,
> | +               "addr = 0x%016lx, curr->vm_start = 0x%016lx\n",
> | +               addr, curr->vm_start);
> | +
> | +       VM_WARN(curr && addr > curr->vm_end,
> | +               "addr = 0x%016lx, curr->vm_end = 0x%016lx\n",
> | +               addr, curr->vm_end);
> | +
> | +       VM_WARN(addr >= end,
> | +               "addr = 0x%016lx, end = 0x%016lx\n",
> | +               addr, end);
> |
> |         if (!merge_prev && !merge_next)
> |                 return NULL; /* Not mergeable. */
>
> ... with that applied, running the reproducer results in:
>
> | addr = 0x0000ffff99dc2000, curr->vm_start = 0x0000ffff99db2000
> | WARNING: CPU: 0 PID: 163 at mm/mmap.c:968 vma_merge+0x3d4/0x1260
>
> ... i.e. addr > curr->vm_start
>
> Thanks,
> Mark.
