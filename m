Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C70731D22
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbjFOPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345021AbjFOPvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BE30EF;
        Thu, 15 Jun 2023 08:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 393AE615D9;
        Thu, 15 Jun 2023 15:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A065C433C0;
        Thu, 15 Jun 2023 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686844263;
        bh=4vpbcLIWH8N9kUhfy14gCg44JnNZ7tmcDbTQofjr2PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtfzZGG4h7OB0EE/lQpmPVeug5hEItWTKVdQh4sHq5pkRyi+IBc4bQYhPGfLUyXAE
         O6q85QbbLOckkkq+ZDCntMP7kzjRH0BvUgQTZTsRtxOQVhMz+kPywYdC329KKPHRCd
         EzHAMzGxIY08qUxBzBs5hhcSI+TdpRxjxhxRYluzPI7qsWgQhBwbTOga8HmP1oqokR
         Nfn1KKfQ7SfISyWUrNFe+l7vvHqttosQ0oHQWcCUmbPCzjqzV6ZQmJ6Lgxc8I7me24
         3i0BNy8Yi/K34Ad5bteBhAQILk/jkgdXefVdp3M52mTzK8Ji4AXkYMW3KmuCjB1GQn
         39zP25YPwdB6Q==
Date:   Thu, 15 Jun 2023 08:50:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/23] mips: update_mmu_cache() can replace
 __update_tlb()
Message-ID: <20230615155059.GB3665766@dev-arch.thelio-3990X>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
 <178970b0-1539-8aac-76fd-972c6c46ec17@google.com>
 <20230614231758.GA1503611@dev-arch.thelio-3990X>
 <f5526f17-9d78-f7ea-427a-7e76bfeb6b8@google.com>
 <344a4da-3890-45fd-607e-b5f85ca6ad48@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <344a4da-3890-45fd-607e-b5f85ca6ad48@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:43:30PM -0700, Hugh Dickins wrote:
> On Wed, 14 Jun 2023, Hugh Dickins wrote:
> > On Wed, 14 Jun 2023, Nathan Chancellor wrote:
> > > 
> > > I just bisected a crash while powering down a MIPS machine in QEMU to
> > > this change as commit 8044511d3893 ("mips: update_mmu_cache() can
> > > replace __update_tlb()") in linux-next.
> > 
> > Thank you, Nathan, that's very helpful indeed.  This patch certainly knew
> > that it wanted testing, and I'm glad to hear that it is now seeing some.
> > 
> > While powering down?  The messages below look like it was just coming up,
> > but no doubt that's because you were bisecting (or because I'm unfamiliar
> > with what messages to expect there).  It's probably irrelevant information,
> > but I wonder whether the (V)machine worked well enough for a while before
> > you first powered down and spotted the problem, or whether it's never got
> > much further than trying to run init (busybox)?  I'm trying to get a feel
> > for whether the problem occurs under common or uncommon conditions.

Ugh sorry, I have been looking into too many bugs lately and got my
wires crossed :) this is indeed a problem when running init (which is
busybox, this is a simple Buildroot file system).

> > > Unfortunately, I can still
> > > reproduce it with the existing fix you have for this change on the
> > > mailing list, which is present in next-20230614.
> > 
> > Right, that later fix was only for a build warning, nothing functional
> > (or at least I hoped that it wasn't making any functional difference).
> > 
> > Thanks a lot for the detailed instructions below: unfortunately, those
> > would draw me into a realm of testing I've never needed to enter before,
> > so a lot of time spent on setup and learning.  Usually, I just stare at
> > the source.
> > 
> > What this probably says is that I should revert most my cleanup there,
> > and keep as close to the existing code as possible.  But some change is
> > needed, and I may need to understand (or have a good guess at) what was
> > going wrong, to decide what kind of retreat will be successful.
> > 
> > Back to the source for a while: I hope I'll find examples in nearby MIPS
> > kernel source (and git history), which will hint at the right way forward.
> > Then send you a patch against next-20230614 to try, when I'm reasonably
> > confident that it's enough to satisfy my purpose, but likely not to waste
> > your time.
> 
> I'm going to take advantage of your good nature by attaching
> two alternative patches, either to go on top of next-20230614.
> 
> mips1.patch,
>  arch/mips/mm/tlb-r4k.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> is by far my favourite.  I couldn't see anything wrong with what's
> already there for mips, but it seems possible that (though I didn't
> find it) somewhere calls update_mmu_cache_pmd() on a page table.  So
> mips1.patch restores the pmd_huge() check, and cleans up further by
> removing the silly pgdp, p4dp, pudp, pmdp stuff: the pointer has now
> been passed in by the caller, why walk the tree again?  I should have
> done it this way before.
> 
> But if that doesn't work, then I'm afraid it will have to be
> mips2.patch,
>  arch/mips/include/asm/pgtable.h |   15 ++++++++++++---
>  arch/mips/mm/tlb-r3k.c          |    5 ++---
>  arch/mips/mm/tlb-r4k.c          |   27 ++++++++++++++++++---------
>  3 files changed, 32 insertions(+), 15 deletions(-)
> 
> which reverts all of the original patch and its build warning fix,
> and does a pte_unmap() to balance the silly pte_offset_map() there;
> with an apologetic comment for this being about the only place in
> the tree where I have no idea what to do if ptep were NULL.
> 
> I do hope that you find the first fixes the breakage; but if not, then

I hate to be the bearer of bad news but the first patch did not fix the
breakage, I see the same issue.

> I even more fervently hope that the second will, despite my hating it.
> Touch wood for the first, fingers crossed for the second, thanks,

Thankfully, the second one does. Thanks for the quick and thoughtful
responses!

Cheers,
Nathan
