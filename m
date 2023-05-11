Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829786FF38E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbjEKOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbjEKOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:04:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353F10FF;
        Thu, 11 May 2023 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=agTIVDV40QlNuRDmtaMpYQzLmx8ylyt8K8o0YwfCE44=; b=lL2e25Q7Ym9Z2f1ilo2kWwHtLS
        4LEtDqoDAi/1aC4kjoeLMlHtLt+a+FS4EW3ttxbaQDhTXZfyi02WOEzNc3/vCsr0owbyF5PEsIwHc
        4EGA9zShanxJYpMWANvO4AfYvUXSJigLrvPdNGyjPeVrrNrqH+tCpFoKNI6P6bYEGIKsYYtBzAtzu
        8Ajl8g5ng54yFG0pf0AiaE1GeB3gEJ+vkOMxu+NkdXV1EBgexS5qxecZBXe6DpvnyQd7D8QuN/WHz
        qIZBX6djd2pg1T+ptsLEa/faZBnf92py7b8vnk1aHVuruD1rplz5XIZSxcsHdZBQZO/oPVfH/8958
        /oI/ASsA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1px6sh-00HGyK-LW; Thu, 11 May 2023 14:02:55 +0000
Date:   Thu, 11 May 2023 15:02:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH 00/23] arch: allow pte_offset_map[_lock]() to fail
Message-ID: <ZFz1j1slZHCQmwMJ@casper.infradead.org>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
 <ZFs0k2rrLPH9A/UU@casper.infradead.org>
 <d7f3c7b2-25b8-ef66-98a8-43d68f4499f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f3c7b2-25b8-ef66-98a8-43d68f4499f@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 09:35:44PM -0700, Hugh Dickins wrote:
> On Wed, 10 May 2023, Matthew Wilcox wrote:
> > On Tue, May 09, 2023 at 09:39:13PM -0700, Hugh Dickins wrote:
> > > Two: pte_offset_map() will need to do an rcu_read_lock(), with the
> > > corresponding rcu_read_unlock() in pte_unmap().  But most architectures
> > > never supported CONFIG_HIGHPTE, so some don't always call pte_unmap()
> > > after pte_offset_map(), or have used userspace pte_offset_map() where
> > > pte_offset_kernel() is more correct.  No problem in the current tree,
> > > but a problem once an rcu_read_unlock() will be needed to keep balance.
> > 
> > Hi Hugh,
> > 
> > I shall have to spend some time looking at these patches, but at LSFMM
> > just a few hours ago, I proposed and nobody objected to removing
> > CONFIG_HIGHPTE.  I don't intend to take action on that consensus
> > immediately, so I can certainly wait until your patches are applied, but
> > if this information simplifies what you're doing, feel free to act on it.
> 
> Thanks a lot, Matthew: very considerate, as usual.
> 
> Yes, I did see your "Whither Highmem?" (wither highmem!) proposal on the

I'm glad somebody noticed the pun ;-)

> list, and it did make me think, better get these patches and preview out
> soon, before you get to vanish pte_unmap() altogether.  HIGHMEM or not,
> HIGHPTE or not, I think pte_offset_map() and pte_unmap() still have an
> important role to play.
> 
> I don't really understand why you're going down a remove-CONFIG_HIGHPTE
> route: I thought you were motivated by the awkardness of kmap on large
> folios; but I don't see how removing HIGHPTE helps with that at all
> (unless you have a "large page tables" effort in mind, but I doubt it).

Quite right, my primary concern is filesystem metadata; primarily
directories as I don't think anybody has ever supported symlinks or
superblocks larger than 4kB.

I was thinking that removing CONFIG_HIGHPTE might simplify the page
fault handling path a little, but now I've looked at it some more, and
I'm not sure there's any simplification to be had.  It should probably
use kmap_local instead of kmap_atomic(), though.

> But I've no investment in CONFIG_HIGHPTE if people think now is the
> time to remove it: I disagree, but wouldn't miss it myself - so long
> as you leave pte_offset_map() and pte_unmap() (under whatever names).
> 
> I don't think removing CONFIG_HIGHPTE will simplify what I'm doing.
> For a moment it looked like it would: the PAE case is nasty (and our
> data centres have not been on PAE for a long time, so it wasn't a
> problem I had to face before); and knowing pmd_high must be 0 for a
> page table looked like it would help, but now I'm not so sure of that
> (hmm, I'm changing my mind again as I write).
> 
> Peter's pmdp_get_lockless() does rely for complete correctness on
> interrupts being disabled, and I suspect that I may be forced in the
> PAE case to do so briefly; but detest that notion.  For now I'm just
> deferring it, hoping for a better idea before third series finalized.
> 
> I mention this (and Cc Peter) in passing: don't want this arch thread
> to go down into that rabbit hole: we can start a fresh thread on it if
> you wish, but right now my priority is commit messages for the second
> series, rather than solving (or even detailing) the PAE problem.

I infer that what you need is a pte_access_start() and a
pte_access_end() which look like they can be plausibly rcu_read_lock()
and rcu_read_unlock(), but might need to be local_irq_save() and
local_irq_restore() in some configurations?

We also talked about moving x86 to always RCU-free page tables in
order to make accessing /proc/$pid/smaps lockless.  I believe Michel
is going to take a swing at this project.
