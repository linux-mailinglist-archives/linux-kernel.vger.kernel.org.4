Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53E06FEDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjEKIVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjEKIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:21:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F75B84
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:21:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso4184893b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683793268; x=1686385268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Jp5FMcj8qW/qF9+EPM6cpVi/auZQyM2oJutX39eAmo=;
        b=cdm0u5zGxEfYEeUz8qOBXpt0efyu/r3E/BtQnk58SviivLMfKnwbXdPa4DtXsdUvh0
         ZFMHolZ3JeJyJ8LI6V3dS3jpUGnY963K1zBRNfHL2U/0wo01Gf2VRgQo/FICBxEA7BQJ
         7/piaZt36cczH0T6GPGw7d51DXDDpFD+ltSTw5y1rlBHqMTvQb3w41iXB3UTFDAqAzBZ
         IH2wwVzU7zga3ewk/tQ0pfCCcBiZILzxmkd+Jt5XlRkeFIk3L4D1JuvwT1oN7zaypmxE
         k2/+Zn2EiyIqygWODox0/JeeGDCxx0UyXrqkcDqWRjgoDZN38XFEmrf0fkhQl3sqmq34
         DBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683793268; x=1686385268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Jp5FMcj8qW/qF9+EPM6cpVi/auZQyM2oJutX39eAmo=;
        b=Gri+arzWzU2Zsn8ojlpPnWeaSnaFyY0WyjNVg85pWd0M9SFeAhGCwU2FvFNMV7zA3D
         /jiW12AitMGAAu4fqk5zYlzmN9IzMpaAsxGUdSDRdBxjohCgdR6dl1Msp8nGNeQxvjJr
         P+uCKz867dOKfvzoXDqJj8jK/Fqr1OSMUIfRlBVhRCep7LRJQ3SAyNSg/mm3Ssj5ICZX
         g36vZzDXcjmDkyB6+CL62Emhzyxl78rUgpwdyUh3oSksV8NLFf/ZEAbpVpcdXPNS8mSp
         1/xcpWQVjZW2iXcNvzkSYvvN6LZoMl84VQ2NBdFOg5lmJta09q/wsDXaIUJpUSmxjzcw
         oRzw==
X-Gm-Message-State: AC+VfDy/vC6CDxfLZKI1RVVTRrxXj+xtd2+HFYOzkRiBx7v1i0xMYZZM
        znRKs/NHdR9nxP6hvjDSvhxaPcEYBb/bGw==
X-Google-Smtp-Source: ACHHUZ6poMgSpBXjekCHCU2R0xtu8ZoPNSfut814Zgk2iJ/eD+Pg1WoMG8fpwM9cN9KzuLKt0HXb8Q==
X-Received: by 2002:a17:902:b493:b0:1ac:921c:87fc with SMTP id y19-20020a170902b49300b001ac921c87fcmr9878342plr.32.1683793268240;
        Thu, 11 May 2023 01:21:08 -0700 (PDT)
Received: from localhost ([64.141.80.140])
        by smtp.gmail.com with ESMTPSA id 16-20020a631150000000b0050f85ef50d1sm4429322pgr.26.2023.05.11.01.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 01:21:07 -0700 (PDT)
Date:   Thu, 11 May 2023 01:21:06 -0700
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Message-ID: <ZFylcp2pmUVgxE7g@murray>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
 <ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com>
 <ZFvAnF0DzEUN7F9r@murray>
 <ZFvDrZRV8RnoPR69@FVFF77S0Q05N.cambridge.arm.com>
 <ZFvFoj--H21sxzCQ@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFvFoj--H21sxzCQ@murray>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 09:26:10AM -0700, Lorenzo Stoakes wrote:
> On Wed, May 10, 2023 at 05:17:49PM +0100, Mark Rutland wrote:
> > On Wed, May 10, 2023 at 09:04:44AM -0700, Lorenzo Stoakes wrote:
> > > On Wed, May 10, 2023 at 03:15:51PM +0100, Mark Rutland wrote:
> > > > Hi,
> > > >
> > > > On Sun, Apr 30, 2023 at 09:19:17PM +0100, Lorenzo Stoakes wrote:
> > > > > We may still have inconsistent input parameters even if we choose not to
> > > > > merge and the vma_merge() invariant checks are useful for checking this
> > > > > with no production runtime cost (these are only relevant when
> > > > > CONFIG_DEBUG_VM is specified).
> > > > >
> > > > > Therefore, perform these checks regardless of whether we merge.
> > > > >
> > > > > This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> > > > > Correctly update prev when policy is equal on mbind") in the mbind logic
> > > > > was only picked up in the 6.2.y stable branch where these assertions are
> > > > > performed prior to determining mergeability.
> > > > >
> > > > > Had this remained the same in mainline this issue may have been picked up
> > > > > faster, so moving forward let's always check them.
> > > > >
> > > > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > > > ---
> > > > >  mm/mmap.c | 10 +++++-----
> > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 5522130ae606..13678edaa22c 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> > > > >  		merge_next = true;
> > > > >  	}
> > > > >
> > > > > +	/* Verify some invariant that must be enforced by the caller. */
> > > > > +	VM_WARN_ON(prev && addr <= prev->vm_start);
> > > > > +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > > > > +	VM_WARN_ON(addr >= end);
> > > > > +
> > > >
> > > > I'm seeing this fire a lot when fuzzing v6.4-rc1 on arm64 using Syzkaller.
> > > >
> > >
> > > Thanks, from the line I suspect addr != curr->vm_start, but need to look
> > > into the repro, at lsf/mm so a bit time lagged :)
> >
> > No problem; FWIW I can confirm your theory, the reproducer is causing:
> >
> > 	addr > curr->vm_start
> >
> > ... confirmed the the following hack, log below.
>
> Awesome thanks for that! Just been firing up qemu to do this.
>
> Cases 5-8 should really have addr == curr->vm_start, I wonder if it's
> another case but curr is being set incorrectly, it should in theory not be
> the case.
>
> (See [1] for a visualisation of merge cases as a handy reference)
>
> Of course userfaultfd might be the offender here and might be relying on no
> merge case arising but passing dodgy parameters.
>
> [1]:https://ljs.io/merge_cases.png
>
> >
> > | diff --git a/mm/mmap.c b/mm/mmap.c
> > | index 13678edaa22c..2cdebba15719 100644
> > | --- a/mm/mmap.c
> > | +++ b/mm/mmap.c
> > | @@ -961,9 +961,21 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> > |         }
> > |
> > |         /* Verify some invariant that must be enforced by the caller. */
> > | -       VM_WARN_ON(prev && addr <= prev->vm_start);
> > | -       VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > | -       VM_WARN_ON(addr >= end);
> > | +       VM_WARN(prev && addr <= prev->vm_start,
> > | +               "addr = 0x%016lx, prev->vm_start = 0x%016lx\n",
> > | +               addr, prev->vm_start);
> > | +
> > | +       VM_WARN(curr && addr != curr->vm_start,
> > | +               "addr = 0x%016lx, curr->vm_start = 0x%016lx\n",
> > | +               addr, curr->vm_start);
> > | +
> > | +       VM_WARN(curr && addr > curr->vm_end,
> > | +               "addr = 0x%016lx, curr->vm_end = 0x%016lx\n",
> > | +               addr, curr->vm_end);
> > | +
> > | +       VM_WARN(addr >= end,
> > | +               "addr = 0x%016lx, end = 0x%016lx\n",
> > | +               addr, end);
> > |
> > |         if (!merge_prev && !merge_next)
> > |                 return NULL; /* Not mergeable. */
> >
> > ... with that applied, running the reproducer results in:
> >
> > | addr = 0x0000ffff99dc2000, curr->vm_start = 0x0000ffff99db2000
> > | WARNING: CPU: 0 PID: 163 at mm/mmap.c:968 vma_merge+0x3d4/0x1260
> >
> > ... i.e. addr > curr->vm_start
> >
> > Thanks,
> > Mark.

It looks like userfaultfd_register() is indeed using vma_merge() to
determine whether potentially broken input is mergeable, e.g.:-

		if (vma->vm_start < start) {
			ret = split_vma(&vmi, vma, start, 1);
			if (ret)
				break;
		}


So it is proactively using this to determine whether the VMA needs
splitting which is... interesting :)

I need to look at this in detail, but I do suspect uffd could do this check
_before_ the vma_merge() (I'd need to double-check this though), or perhaps
vma_merge could un-warn it.

What's worrying here is that having addr > curr->vm_start but end ==
next->vm_start could result in a broken, overlapped merged.

In any case this needs some post-jet lag analysis (happy for you or Liam or
whoever to step in too if you fancy ;)

THe most proximal solution is to just drop the addr != curr->vm_start check
or at least return NULL if that check is failed, but I think it'd be better
to take a step back and examing the uffd code in detail because the
approach seems like it might have a broken edge case.

I think this check has more so brought out an issue rather than caused one,
but until I can give a post-lsf/mm, post-jet lag analysis I can't be
conclusively coherent on this.

Instinct says we should probably change uffd but might be wrong!
