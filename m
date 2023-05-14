Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8977701EC3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbjENRdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbjENRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:33:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B040D0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:33:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f415a90215so95069435e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684085601; x=1686677601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3oyPTS4otLOfmn6LYBOukn6SNOD9cL2QMwdCto8rE20=;
        b=lQlKcKPgMsLJt1PYvRl+VJBA83DYneeWlWGJg1IJdPizzfzTYkVApVfWoN8B+VLA5G
         iP/3aseJAKUeyqeEZ9fPNo2KGaOeAXdYWwAVDiN2xYqW//TDHyqtjEysFyxEArAElbvH
         i7TCtYvav2So1Szs8iN5F61bt0tGvWSV17/xOSDZnf8m/ABfvLByeuH5ZShHobckS5Je
         WtWrXgoY7TD5/Vc4Wy1rA+O97+6H/YW2rH+6rUkydBfVHNDHN7PAtMmu7b4bCiztS3u3
         CIJDptbypmBHF8ooTmCH/g/p7x4gwjbtsQQBfUtnYPg8mz4qFnWJPT5uNsEomk/15KA6
         aiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684085601; x=1686677601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oyPTS4otLOfmn6LYBOukn6SNOD9cL2QMwdCto8rE20=;
        b=S8stCVOnUzUXWuA54YXds+v8/kwDxJ2tuQAn0Lvhqk4eU6U7S5AbkpiiR6ZvYevuuo
         XpIhccrAznXzrFGRbcgZR7XnPCgp8vlcpZZdv9lskGErYTdPQfVWDrSsf6v0MbvVHI5l
         W14+t/alDHwSFdZonCGmzTt0SH5uPpnU8KoxlvnLQtUPcrLkjG///ItX3LfkJSICgHl8
         WQiiNqWjamY9jVImzH93+6znAb5wl/wggvLsbyaMgBzh2+f+0d/g7QYhndm2YYseZWvP
         uSsemO7FqwSWXfP5SjBUMMU3UcoL136va2vt4hXebR2O1OYuX5jiOH6hDf80QAOEqzRB
         uovg==
X-Gm-Message-State: AC+VfDx24KKrp5Eq1RXy9YSRvgOWegWDHliY4bdSYf36vOH0sE7ZmlTP
        hIjyRB6JVhAC4kAe1OwAM7M=
X-Google-Smtp-Source: ACHHUZ6gpXe+/3AAYQBH0swh7QCoG2baZCsxWC+fIQZJKQMa6A3tlGi2eF7LVHATng1qrvpgUbn3Qw==
X-Received: by 2002:a7b:c8d6:0:b0:3f4:271a:8aaf with SMTP id f22-20020a7bc8d6000000b003f4271a8aafmr14958153wml.38.1684085600479;
        Sun, 14 May 2023 10:33:20 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003f1733feb3dsm34484227wmc.0.2023.05.14.10.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 10:33:19 -0700 (PDT)
Date:   Sun, 14 May 2023 18:33:18 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Message-ID: <67f638d9-4853-49ed-b2e6-5000e1cea558@lucifer.local>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Indeed it was, patch at
https://lore.kernel.org/all/20230514172731.134188-1-lstoakes@gmail.com/

[snip]
