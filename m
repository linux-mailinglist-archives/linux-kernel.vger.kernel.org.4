Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1710645000
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiLGAIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E4F65C8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670371667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cLsuMwiJlrQl3J8JtMcNGM+h/BlzZINz+TbY2IHIMkw=;
        b=aCMOvehgt42fuVvoNMC1QiORIfVeYZQcTPaD+mx7wvCxE9w0I5pHLLwrjmc16v3FvuEAlX
        ice2qrqouPsKZQfRo0oauFvpff9kvCPKbwpf1QueHpDYKbAkKtex2LQaEVy2zXGZuPCor9
        JIn63XmvBzCDEVNjL3Ndl5hgEG+NkRA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-252-a2whKefyOAaEZhD4Ej8InQ-1; Tue, 06 Dec 2022 19:07:46 -0500
X-MC-Unique: a2whKefyOAaEZhD4Ej8InQ-1
Received: by mail-qv1-f72.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so36118519qvb.20
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLsuMwiJlrQl3J8JtMcNGM+h/BlzZINz+TbY2IHIMkw=;
        b=E9VKVFt4k2dkdDel+m1uEaa3nwru293c8X+QZTc2RJ5tpvfWAw4kpAt+660HUt1Dqf
         IkpFGyCv9qKcB0UitZnEP5UgmV3wY3E45yCpvCb0gn0wRPJ2doZBo4zmAeyAEFgIyst/
         pTGKX8IeySEgL4u2goNyuMnrtmq/VrBr9O9kmU7eevox3qkwW+sv+2wcWIEt7TDUVbZh
         3zpswbuIxaILuivd4HPVr/iTKCUmoW9pLKcYIqa1j4LnoMZSRHhibf+15yQvFge64rdi
         +0Z/hCOLF3EGb061y5Vq3ddvNtcxxouTpqqyihYNV+UNtlQYQgU3A7PP90XZfuZboY2l
         YCCw==
X-Gm-Message-State: ANoB5pmIAXXrrRLMleOQxjVQYJhg4hVS21Mt8oWdMAGGV4PnLymWt9Li
        ymEAM2bfyv8Vvw8gSpJfTXHWnkIoFInsiq7HjRrjwtpU8ZNxupiFSEzBxifBK6dbFc2b1aNppGS
        jq8/unMRLEVPpXf+lusFG29h8
X-Received: by 2002:a05:622a:5a91:b0:3a5:fb61:c899 with SMTP id fz17-20020a05622a5a9100b003a5fb61c899mr677187qtb.0.1670371665933;
        Tue, 06 Dec 2022 16:07:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6jzT3JZZuSZmROY4u+XjwsXhDxlm0aqPPZx3Fgb6n79kWd/18ZqnsMtvyaIIIv0eApLkGMCA==
X-Received: by 2002:a05:622a:5a91:b0:3a5:fb61:c899 with SMTP id fz17-20020a05622a5a9100b003a5fb61c899mr677174qtb.0.1670371665654;
        Tue, 06 Dec 2022 16:07:45 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a258a00b006bb82221013sm16003743qko.0.2022.12.06.16.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:07:45 -0800 (PST)
Date:   Tue, 6 Dec 2022 19:07:43 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Message-ID: <Y4/ZT3ab9TL1j5TL@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com>
 <Y45/5ezH6uwn7Cfy@monkey>
 <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com>
 <Y49xlV8I2/92Flha@x1n>
 <97e3a8f2-df75-306e-2edf-85976c168955@nvidia.com>
 <Y4+5R+nh0W0RUX9R@x1n>
 <c5d839da-cb7e-e887-11a6-30ccd1c3c845@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5d839da-cb7e-e887-11a6-30ccd1c3c845@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 02:31:30PM -0800, John Hubbard wrote:
> On 12/6/22 13:51, Peter Xu wrote:
> > On Tue, Dec 06, 2022 at 01:03:45PM -0800, John Hubbard wrote:
> > > On 12/6/22 08:45, Peter Xu wrote:
> > > > I've got a fixup attached.  John, since this got your attention please also
> > > > have a look too in case there's further issues.
> > > > 
> > > 
> > > Well, one question: Normally, the pattern of "release_lock(A); call f();
> > > acquire_lock(A);" is tricky, because one must revalidate that the state
> > > protected by A has not changed while the lock was released. However, in
> > > this case, it's letting page fault handling proceed, which already
> > > assumes that pages might be gone, so generally that seems OK.
> > 
> > Yes it's tricky, but not as tricky in this case.
> > 
> > I hope my documentation supplemented that (in the fixup patch):
> > 
> > + * @hugetlb_entry:     if set, called for each hugetlb entry.  Note that
> > + *                     currently the hook function is protected by hugetlb
> > + *                     vma lock to make sure pte_t* and the spinlock is valid
> > + *                     to access.  If the hook function needs to yield the

[1]

> 
> So far so good...
> 
> > + *                     thread or retake the vma lock for some reason, it
> > + *                     needs to properly release the vma lock manually,
> > + *                     and retake it before the function returns.
> 
> ...but you can actually delete this second sentence. It does not add
> any real information--clearly, if you must drop the lock, then you must
> "manually" drop the lock.
> 
> And it still ignores my original question, which I don't think I've
> fully communicated. Basically, what can happen to the protected data
> during the time when the lock is not held?

I thought I answered this one at [1] above.  If not, I can extend the
answer.

What can happen is some thread can firstly unshare the pmd pgtable page
(e.g. by clearing the PUD entry in current mm), then release the pmd
pgtable page (e.g. by unmapping it) even if current thread is still
accessing it.  It will cause use-after-free on the pmd pgtable page on this
thread in various ways.

One way to trigger this is when the current thread tries to take the
pgtable lock and it'll trigger warning like the call stack referenced in
the cover letter of this series:

https://lore.kernel.org/r/20221129193526.3588187-1-peterx@redhat.com

Please also feel free to read the reproducer attached in the cover letter,
it has details on how this can trigger (even though it's so hard to trigger
so I added a delay in the kernel to make it trigger).  The idea should be
the same.

> 
> > 
> > The vma lock here makes sure the pte_t and the pgtable spinlock being
> > stable.  Without the lock, they're prone to be freed in parallel.
> > 
> 
> Yes, but think about this: if the vma lock protects against the pte
> going away, then:
> 
> lock()
>    get a pte
> unlock()
> 
> ...let hmm_vma_fault() cond_resched() run...
> 
> lock()
>    ...whoops, something else release the pte that I'd previously
>    retrieved.

Here the pte_t* is never referenced again after hugetlb_entry() returned.

The loop looks like:

	do {
		next = hugetlb_entry_end(h, addr, end);
		pte = hugetlb_walk(vma, addr & hmask, sz);
		if (pte)
			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
		else if (ops->pte_hole)
			err = ops->pte_hole(addr, next, -1, walk);
		if (err)
			break;
	} while (addr = next, addr != end);

After hugetlb_entry() returned, we'll _never_ touch that pte again we got
from either huge_pte_offset() or hugetlb_walk() after this patchset
applied.

If we touch it, it's a potential bug as you mentioned.  But we didn't.

Hope it explains.

> 
> > > 
> > > However, I'm lagging behind on understanding what the vma lock actually
> > > protects. It seems to be a hugetlb-specific protection for concurrent
> > > freeing of the page tables?
> > 
> > Not exactly freeing, but unsharing.  Mike probably has more to say.  The
> > series is here:
> > 
> > https://lore.kernel.org/all/20220914221810.95771-1-mike.kravetz@oracle.com/#t
> > 
> > > If so, then running a page fault handler seems safe. If there's something
> > > else it protects, then we might need to revalidate that after
> > > re-acquiring the vma lock.
> > 
> > Nothing to validate here.  The only reason to take the vma lock is to match
> > with the caller who assumes the lock taken, so either it'll be released
> > very soon or it prepares for the next hugetlb pgtable walk (huge_pte_offset).
> > 
> 
> ummm, see above. :)
> 
> > > 
> > > Also, scattering hugetlb-specific locks throughout mm seems like an
> > > unfortuate thing, I wonder if there is a longer term plan to Not Do
> > > That?
> > 
> > So far HMM is really the only one - normally hugetlb_entry() hook is pretty
> > light, so not really throughout the whole mm yet.  It's even not urgently
> > needed for the other two places calling cond_sched(), I added it mostly
> > just for completeness, and with the slight hope that maybe we can yield
> > earlier for some pmd unsharers.
> > 
> > But yes it's unfortunate, I just didn't come up with a good solution.
> > Suggestion is always welcomed.
> > 
> 
> I guess it's on me to think of something cleaner, so if I do I'll pipe
> up. :)

That'll be very much appricated.

It's really that I don't know how to make this better, or I can rework the
series as long as it hasn't land upstream.

Thanks,

-- 
Peter Xu

