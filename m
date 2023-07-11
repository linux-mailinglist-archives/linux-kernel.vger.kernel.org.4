Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57374E5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGKEfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGKEfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:35:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA72E51
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:34:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so4756571276.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689050095; x=1691642095;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=59lHc5cCO4CCd9AaCyKQZBif+8hRbZLDuQW/Fgs4KeI=;
        b=TgMxfCmEug4Hqci9c95+8Pz0VXZ+wwRqfJm0LlEemaGfb3GfQMhI9ZnUuwoy6Fu7yz
         YVT1f8uqh7sHBlkDw72AzQs9L93loFH4I3xAtt5tWPZfkFagyrfAWktnOXAkeG9sWk02
         4IKnsIEamCg8TBBG/OrGXPLPKMktnwa3Zb3g6sdbXZjEf/AAS3ntExLhqCzUXcfh/jwn
         lPPEwM1P8QVjI9xwgPctWZ0w6jJMBmPudIJjw3rbx+pMzZVVCMz+0rllFdmOGv6Zh07X
         3wpIMi7qby9hYknxzsLOcSIaUV8QW8L7tItwmeapYa6kzOaYGhbBzfumq9FbrfPlS+TR
         qp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689050095; x=1691642095;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59lHc5cCO4CCd9AaCyKQZBif+8hRbZLDuQW/Fgs4KeI=;
        b=YTYI31EnKvIR+zh+KK9uEWSps7T/DC77+XsT8Ea2pDsiyDJgkqz/zx4mZ2+Z+2uTXM
         rRVcQ7S3pYYwN9x3gAdxchAjbu8vMGF/sEdDBdsAmoBPkSUrRyerd0BPWH4m1zTHl/k9
         ydMZfy7VpjwUo5k+on4UcT459CQG9bYHWHs81iegQ06gpbtDM5ZVegWte9aQwohTYtbH
         wcih0oIN/zjjo2yaylePph152JXqayF2/k7Eao6WIHYpd4+edhbHdjoItj9Pi6dkPak9
         fSYEaINL5Bb5RCqpuqYOi4Q/8u7l2QvEaYp3ld8AhPVfGMGS9dX7lD76+knDwmuvSwJp
         mKIQ==
X-Gm-Message-State: ABy/qLYN7iCQvwbjLKlpQjtOwSi1aZiXk7G7qnwJG0061kUYtnDuOQiP
        1XIi15KrpSLgVueSy2aYwu+PZQ==
X-Google-Smtp-Source: APBJJlECU9hb9crfksCQd+CQBlVo69/nP5NSfK3cb4UgLtyr7WZLSvPO5Vz952AMVAWrmXSiJNPxEg==
X-Received: by 2002:a25:3243:0:b0:c6b:2072:e35c with SMTP id y64-20020a253243000000b00c6b2072e35cmr10298911yby.59.1689050095332;
        Mon, 10 Jul 2023 21:34:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c197-20020a25c0ce000000b00c5d48ed4317sm288700ybf.49.2023.07.10.21.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 21:34:54 -0700 (PDT)
Date:   Mon, 10 Jul 2023 21:34:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mark Brown <broonie@kernel.org>
cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@leemhuis.info, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
In-Reply-To: <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
Message-ID: <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <696386a-84f8-b33c-82e5-f865ed6eb39@google.com> <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk> <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
 <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 06:18:27PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jul 10, 2023 at 03:42:31PM +0100, Mark Brown wrote:
> 
> > > We end up seeing NULL or otherwise bad pointer dereferences, the
> > > specific error does vary a bit though it mostly appears to be in the
> > > pinctrl code.  A bisect (full log below) identified this patch as
> > > introducing the failure, nothing is jumping out at me about the patch
> > > and it's not affecting everything so I'd not be surprised if it's just
> > > unconvering some bug in the platform support but I'm not super familiar
> > > with the code.
> 
> > Yeah seems likely. Do you have a .config you can share for this board? For
> > a 64-bit device you'd expect that this change would probably be a nop.
> 
> It's definitely happening with arm64 defconfig, possibly with other
> configs but that's the main one.

I'm sorry for dropping you in it, Mark, but I'm totally baffled.
I've spent most of the day trying to come up with ideas, but failed.
I've no doubt that you're seeing what you're seeing, but how it comes
about is a mystery.

Lorenzo is right that the change should be a no-op - compared with 6.4.
But it's not quite a no-op in this series, because 04/32 0d940a9b270b
("mm/pgtable: allow pte_offset_map[_lock]() to fail") diverts the old
pte_offset_map() macro off to a new function in mm/pgtable-generic.c;
then this commit restores it back to being the pte_offset_kernel() macro.

So the asm in vmalloc_to_page() is expected to change in this commit,
but change back to what it would have been in 6.4.

This feels like one of those bugs which depends on the code size in
some way (a bit like those bugs we used to have, where a function was
mistakenly marked __init, then in some configs its code landed on a
page which got freed at startup - I'm not saying this is that at all,
just saying it feels weird in that way).

Yet your bisection converges convincingly, which I wouldn't expect
in that case.

I suppose I should ask you to try reverting this 0d1c81edc61e alone
from 6.5-rc1: the consistency of your bisection implies that it will
"fix" the issues, and it is a commit which we could drop.  It makes
me a little nervous, applying userspace-pagetable validation to kernel
pagetables, so I don't want to drop it; and it would really be cargo-
culting to drop it without understanding.  But we could drop it.

I guess it would be interesting to know whether vmalloc_to_page() is
ever even called in your kernel, before it crashes on the pinctrl stuff.
But putting in a printk to report on that may change everything.

And I guess it would be interesting to know (from a DEBUG_INFO build
of the crashing kernel) which line of dt_remember_or_free_map() it
oopses on i.e. which pointer is NULL when it shouldn't be - or maybe
you already worked that out.

And what device (which ->dt_node_to_map) is involved.  If one of the
many dt_node_to_map's fails to initialize *map to NULL when it should,
and has relied on it happening to be a NULL on the stack already...
that might explain it.

Another thing to try, would be the kernel at 0d940a9b270b^, just before
pte_offset_map() grew a function call: there's a faint possibility that
the bug came in before this series, that 0d940a9b270b somehow masked it
(I don't see how: vmalloc_to_page() does sensible validation itself),
and then 0d1c81edc61e unmasked it again - so that the bisection skipped
over, and converged on the wrong point.

But I'm thrashing about: I have no confidence that any of this info will
help us.  Sorry for wasting your time.

Thanks,
Hugh
