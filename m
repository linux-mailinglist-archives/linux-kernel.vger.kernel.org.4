Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A360A66BE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjAPM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjAPM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:56:04 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6361E5D7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:54:49 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id w2so218398ilg.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3SxhgAvgDMdZQpeBwjT3HHcfCZOqbwGa4aErLEE5tZo=;
        b=WwyqIv5ugeBGMCRLeuLpLHV07NTeipvLkTInSKY42RrdU1vwWtTEUtYdXEw52BsKUK
         UWbwuyCoIkqFYwgNoVURc0Qd+yxukDctYsO4kMlxKDHjOhHUUDxij8rPJZdn7baGV7R8
         IVwBQmT+J8xjrPnEg5xWbuKr7an/po/Xo4dLxEruoxwIofEZklyzkoBABsbLvFeyVXMY
         saELXXNxzqPU2fIV2Hqg3KsVwrn/54eK6/5MJCNxToqkQApDvz/lHFtoOs4Q/txSM+rL
         bSn40FZt6uIxSLwD06kXtY7RC8GwxwprFjIrn1reOzSKbr9dWMwZZpaz+jeAOjNsEU9g
         WxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SxhgAvgDMdZQpeBwjT3HHcfCZOqbwGa4aErLEE5tZo=;
        b=tFqXxBPjKa4E79lBFKCWOALVlJrX9cehnw5sYLQgRnVakOe2DE39t/2PRz++2hns8q
         cHwvP81MJ6q/V3v563lxGqbX9MeIOC9ySCBTV7Flwutppu+eM2n6usEDuqteaalHEXBT
         zRJR3KUlkf7u+osGI6i51Bk3dDjGth6MlyCiicyKR+zMbF5hNHr+8oUyqY0gJZfJH5Rn
         Q38AcuA+Nyfyp0L5aIqC6h71yDymTZmubmahY71vz8UEQyC+wvk9P5fPnMnJ0mBzGJHL
         GwRHR01O/2p2+rpn9TqUbMhzDH7U1jrH/EXv4XR6/20MCXX5zMhsCUskk5Yl+E5voupV
         CVCQ==
X-Gm-Message-State: AFqh2kotd68YQO/zdKLo+G4Q8v/YhOolXEy2x7yuxqdU7FiqPUWMSfZ4
        wKaBHujD9TsIGX7fIfYaa/OuRVcy281J40rVM36XbQ==
X-Google-Smtp-Source: AMrXdXtF4fTIbcgFeVqFPRLkNiAKgONng9+vuomJpuOpDmWCrv9ygQHNjTNH4Xz4bhmmGP+Q9IxPNljxO4mKZyYrcZM=
X-Received: by 2002:a92:c04e:0:b0:30f:12c9:f765 with SMTP id
 o14-20020a92c04e000000b0030f12c9f765mr116249ilf.187.1673873688380; Mon, 16
 Jan 2023 04:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com> <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
 <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name> <CAG48ez2zeQ4+g1=B4eyrrvZRYMr1S1xKBh2_eAhCjVjhj7Lpfg@mail.gmail.com>
 <20230116123403.fiyv22esqgh7bzp3@box.shutemov.name>
In-Reply-To: <20230116123403.fiyv22esqgh7bzp3@box.shutemov.name>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Jan 2023 13:54:12 +0100
Message-ID: <CAG48ez2kAd3_VQRodzNxmME=nceO04TQ=y-E2uDdZzmsXdiMXw@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
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

+cc mmu-gather maintainers

On Mon, Jan 16, 2023 at 1:34 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Mon, Jan 16, 2023 at 01:06:59PM +0100, Jann Horn wrote:
> > On Sun, Jan 15, 2023 at 8:07 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > BTW, I've noticied that you recently added tlb_remove_table_sync_one().
> > > I'm not sure why it is needed. Why IPI in pmdp_collapse_flush() in not
> > > good enough to serialize against GUP fast?
> >
> > If that sent an IPI, it would be good enough; but
> > pmdp_collapse_flush() is not guaranteed to send an IPI.
> > It does a TLB flush, but on some architectures (including arm64 and
> > also virtualized x86), a remote TLB flush can be done without an IPI.
> > For example, arm64 has some fancy hardware support for remote TLB
> > invalidation without IPIs ("broadcast TLB invalidation"), and
> > virtualized x86 has (depending on the hypervisor) things like TLB
> > shootdown hypercalls (under Hyper-V, see hyperv_flush_tlb_multi) or
> > TLB shootdown signalling for preempted CPUs through shared memory
> > (under KVM, see kvm_flush_tlb_multi).
>
> I think such architectures must provide proper pmdp_collapse_flush()
> with the required serialization.

FWIW, the IPI that I added is not unconditional;
tlb_remove_table_sync_one() is a no-op depending on
CONFIG_MMU_GATHER_RCU_TABLE_FREE, which an architecture can use to
signal that it uses "Semi RCU freeing of the page directories". The
kernel has arch-independent support for these semantics in the normal
TLB flushing code. But yeah, I guess you could move the
tlb_remove_table_sync_one() calls into pmdp_collapse_flush()
(including the generic version)? I'm CC-ing the mmu-gather maintainers
in case they have an opinion.

Anyway, I'm not going to do that refactor; feel free to do that if you want.

> Power and S390 already do that.

What's the call graph from pmdp_collapse_flush() to IPI on powerpc and s390?
