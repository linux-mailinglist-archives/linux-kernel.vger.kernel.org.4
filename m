Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B465E0C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjADXNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjADXNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:13:19 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E56442E36
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 15:13:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk16so21353608wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 15:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xjj6P6cPGhiVQiupD0AtIKtwyJPxy/e9xg2W8dCMeFw=;
        b=ouGR609RZOmkZkvxjmkRCqfeRj/MaXMqx30eH319QaNfdm7YgDjxkxbal7Kja6Qh7Z
         +8BGZA+ddz6SjOd7xOBtx619uDQtRU8ZJFD0c3aGCbOcQw94ZPH1JN8lGfibLu90IPMj
         BVOPJh1aEAKa558Atw5gIiF+YzZrWeh+nFdhqFxunNNAD3xiXY+ryhwiQEfVe+a4G2Vz
         l2x/gFlxRAxYBvtmcWIMqR1rhXRJZ9rxOz7LM9bpopaSRJr42ggzM/Q+zNHRrqiiNjQp
         MiLNX+CFFRsEFnHgCrNKgVVAXsvR2wgiCN8cWy3fkJMojvWnTHMSPpw8Pv0ZRcnodyb/
         ZALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjj6P6cPGhiVQiupD0AtIKtwyJPxy/e9xg2W8dCMeFw=;
        b=xqIiWNxTCnxXgZYosEU/jppUrXynVGK4xsrJozMDBnpGH+dLBH2H7ulX3PE2u75iDD
         cIz4HO3qzmus7T/83lY8TeolrQnJtdLdEkl2PnhbyWJ8b1tBphdJu3zB1YL9lTGZc+Xp
         kGKNcPKZogREjhuVotcDVgplaKeCFtmhGyw22tS+kTHAl7frjAJrLkTzS7HxiwV5+2Vc
         8lKEUhQKL22OHj8NwF99PcMGnXVDqKTg8hrXt3XGZY5RhvaTvYw47A2Q2/Z0VEteILHA
         qBx6sis2ek3KT91HNbRrHrSpfAf0IdK5Og+o+7Mo5umpYq0I2NtDT1x5i0Eun2VKc62z
         bvXA==
X-Gm-Message-State: AFqh2kpWdcIYUzH+HlfSf3WytthF6T5DYh3eX9YzKExB7g7+0kgcOCFK
        E6vR+KNoXQnEZiq2VlYtBiFQDDaJdJfdXgHplalXKQ==
X-Google-Smtp-Source: AMrXdXvQmmKJF7je2ykyKg49si6vBOiZgYQ24TRXbwt8ecY4G5pcHzqdaCr3ixetzN2QoOodEwa6JbYV4Q8cdSd4PLo=
X-Received: by 2002:a5d:640b:0:b0:290:ef26:df02 with SMTP id
 z11-20020a5d640b000000b00290ef26df02mr947557wru.664.1672873986523; Wed, 04
 Jan 2023 15:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20230101230042.244286-1-jthoughton@google.com>
 <Y7SA839SDcpf+Ll0@monkey> <CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com>
 <Y7Sq+Rs9cpSaHZSk@monkey> <CADrL8HV73m0nVJOK3uv4sbyGKOVZhVxSv2+i4pUV7tozu6vW5Q@mail.gmail.com>
 <Y7Xbo0tUO26khHCA@x1n>
In-Reply-To: <Y7Xbo0tUO26khHCA@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 4 Jan 2023 23:12:53 +0000
Message-ID: <CADrL8HVMCxHPBUuXo6dxam0giVcx2kAn=8n-3NjVO0ZddFw_tQ@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jan 4, 2023 at 8:03 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jan 04, 2023 at 07:10:11PM +0000, James Houghton wrote:
> > > > I'll see if I can confirm that this is indeed possible and send a
> > > > repro if it is.
> > >
> > > I think your analysis above is correct.  The key being the failure to unshare
> > > in the non-PUD_SIZE vma after the split.
> >
> > I do indeed hit the WARN_ON_ONCE (repro attached), and the MADV wasn't
> > even needed (the UFFDIO_REGISTER does the VMA split before "unsharing
> > all PMDs"). With the fix, we avoid the WARN_ON_ONCE, but the behavior
> > is still incorrect: I expect the address range to be write-protected,
> > but it isn't.
> >
> > The reason why is that hugetlb_change_protection uses huge_pte_offset,
> > even if it's being called for a UFFDIO_WRITEPROTECT with
> > UFFDIO_WRITEPROTECT_MODE_WP. In that particular case, I'm pretty sure
> > we should be using huge_pte_alloc, but even so, it's not trivial to
> > get an allocation failure back up to userspace. The non-hugetlb
> > implementation of UFFDIO_WRITEPROTECT seems to also have this problem.
> >
> > Peter, what do you think?
>
> Indeed.  Thanks for spotting that, James.
>
> Non-hugetlb should be fine with having empty pgtable entries. Anon doesn't
> need to care about no-pgtable-populated ranges so far. Shmem does it with a
> few change_prepare() calls to populate the entries so the markers can be
> installed later on.

Ah ok! :)

>
> However I think the fault handling is still not well handled as you pointed
> out even for shmem: that's the path I probably never triggered myself yet
> before and the code stayed there since a very early version:
>
> #define  change_pmd_prepare(vma, pmd, cp_flags)                         \
>         do {                                                            \
>                 if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {    \
>                         if (WARN_ON_ONCE(pte_alloc(vma->vm_mm, pmd)))   \
>                                 break;                                  \
>                 }                                                       \
>         } while (0)
>
> I think a better thing we can do here (instead of warning and stop the
> UFFDIO_WRITEPROTECT at the current stage) is returning with -ENOMEM
> properly so the user can know the error.  We'll need to touch the stacks up
> to uffd_wp_range() as it's the only one that can trigger the -ENOMEM so
> far, so as to not ignore retval from change_protection().
>
> Meanwhile, I'd also wonder whether we should call pagefault_out_of_memory()
> because it should be the same as when pgtable allocation failure happens in
> page faults, we may want to OOM already.  I can take care of hugetlb part
> too along the way.

I might be misunderstanding, the only case where
hugetlb_change_protection() would *need* to allocate is when it is
called from UFFDIO_WRITEPROTECT, not while handling a #pf. So I don't
think any calls to pagefault_out_of_memory() need to be added.

>
> Man page of UFFDIO_WRITEPROTECT may need a fixup too to introduce -ENOMEM.
>
> I can quickly prepare some patches for this, and hopefully it doesn't need
> to block the current fix on split.

I don't think it should block this splitting fix. I'll send another
version of this fix soon.

>
> Any thoughts?
>
> >
> > >
> > > To me, the fact it was somewhat difficult to come up with this scenario is an
> > > argument what we should just unshare at split time as you propose.  Who
> > > knows what other issues may exist.
> > >
> > > > 60dfaad65a ("mm/hugetlb: allow uffd wr-protect none ptes") is the
> > > > commit that introduced the WARN_ON_ONCE; perhaps it's a good choice
> > > > for a Fixes: tag (if above is indeed true).
> > >
> > > If the key issue in your above scenario is indeed the failure of
> > > hugetlb_unshare_all_pmds in the non-PUD_SIZE vma, then perhaps we tag?
> > >
> > > 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when
> > > register wp")
> >
> > SGTM. Thanks Mike.
>
> Looks good here too.

Thanks, Peter!
