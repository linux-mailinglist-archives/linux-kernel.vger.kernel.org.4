Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63A86FE23D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEJQR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjEJQR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:17:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89FBC72A6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:17:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CEA81063;
        Wed, 10 May 2023 09:18:40 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C5B43F67D;
        Wed, 10 May 2023 09:17:54 -0700 (PDT)
Date:   Wed, 10 May 2023 17:17:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Message-ID: <ZFvDrZRV8RnoPR69@FVFF77S0Q05N.cambridge.arm.com>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
 <ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com>
 <ZFvAnF0DzEUN7F9r@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFvAnF0DzEUN7F9r@murray>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 09:04:44AM -0700, Lorenzo Stoakes wrote:
> On Wed, May 10, 2023 at 03:15:51PM +0100, Mark Rutland wrote:
> > Hi,
> >
> > On Sun, Apr 30, 2023 at 09:19:17PM +0100, Lorenzo Stoakes wrote:
> > > We may still have inconsistent input parameters even if we choose not to
> > > merge and the vma_merge() invariant checks are useful for checking this
> > > with no production runtime cost (these are only relevant when
> > > CONFIG_DEBUG_VM is specified).
> > >
> > > Therefore, perform these checks regardless of whether we merge.
> > >
> > > This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> > > Correctly update prev when policy is equal on mbind") in the mbind logic
> > > was only picked up in the 6.2.y stable branch where these assertions are
> > > performed prior to determining mergeability.
> > >
> > > Had this remained the same in mainline this issue may have been picked up
> > > faster, so moving forward let's always check them.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > ---
> > >  mm/mmap.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 5522130ae606..13678edaa22c 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> > >  		merge_next = true;
> > >  	}
> > >
> > > +	/* Verify some invariant that must be enforced by the caller. */
> > > +	VM_WARN_ON(prev && addr <= prev->vm_start);
> > > +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > > +	VM_WARN_ON(addr >= end);
> > > +
> >
> > I'm seeing this fire a lot when fuzzing v6.4-rc1 on arm64 using Syzkaller.
> >
> 
> Thanks, from the line I suspect addr != curr->vm_start, but need to look
> into the repro, at lsf/mm so a bit time lagged :)

No problem; FWIW I can confirm your theory, the reproducer is causing:

	addr > curr->vm_start

... confirmed the the following hack, log below.

| diff --git a/mm/mmap.c b/mm/mmap.c
| index 13678edaa22c..2cdebba15719 100644
| --- a/mm/mmap.c
| +++ b/mm/mmap.c
| @@ -961,9 +961,21 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
|         }
|  
|         /* Verify some invariant that must be enforced by the caller. */
| -       VM_WARN_ON(prev && addr <= prev->vm_start);
| -       VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
| -       VM_WARN_ON(addr >= end);
| +       VM_WARN(prev && addr <= prev->vm_start,
| +               "addr = 0x%016lx, prev->vm_start = 0x%016lx\n",
| +               addr, prev->vm_start);
| +
| +       VM_WARN(curr && addr != curr->vm_start,
| +               "addr = 0x%016lx, curr->vm_start = 0x%016lx\n",
| +               addr, curr->vm_start);
| +
| +       VM_WARN(curr && addr > curr->vm_end,
| +               "addr = 0x%016lx, curr->vm_end = 0x%016lx\n",
| +               addr, curr->vm_end);
| +
| +       VM_WARN(addr >= end,
| +               "addr = 0x%016lx, end = 0x%016lx\n",
| +               addr, end);
|  
|         if (!merge_prev && !merge_next)
|                 return NULL; /* Not mergeable. */

... with that applied, running the reproducer results in:

| addr = 0x0000ffff99dc2000, curr->vm_start = 0x0000ffff99db2000
| WARNING: CPU: 0 PID: 163 at mm/mmap.c:968 vma_merge+0x3d4/0x1260

... i.e. addr > curr->vm_start

Thanks,
Mark.
