Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23318644604
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiLFOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiLFOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EE5A47F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iUuXMOHVf03Vb0qMF+Y5euIKjDZHBS53BDQPdht/P5M=;
        b=X+Wrw1b5vFtIZE9WrJlCjEDEfCsLaAuUxG0Rwttw45e4pQeVcs1hIl71QkpsmkofeRL3g0
        DVHPG0B2s2JyRWynZdQ4j7WuBiCIb4aR+HmcMQ7Nf2X8Kv2McckdzrNI2lS7KDWHZFpzm5
        e3yjlybd4zVjqAVlCOxhxPNXnc631G8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-uGIT1O_oMIuU4W7hfGEOWg-1; Tue, 06 Dec 2022 09:47:54 -0500
X-MC-Unique: uGIT1O_oMIuU4W7hfGEOWg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322AA811E67;
        Tue,  6 Dec 2022 14:47:55 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E89C492B04;
        Tue,  6 Dec 2022 14:47:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        David Hildenbrand <david@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH mm-unstable RFC 00/26] mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures with swap PTEs
Date:   Tue,  6 Dec 2022 15:47:04 +0100
Message-Id: <20221206144730.163732-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the follow-up on [1]:
	[PATCH v2 0/8] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of
	anonymous pages

After we implemented __HAVE_ARCH_PTE_SWP_EXCLUSIVE on most prominent
enterprise architectures, implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all
remaining architectures that support swap PTEs.

This makes sure that exclusive anonymous pages will stay exclusive, even
after they were swapped out -- for example, making GUP R/W FOLL_GET of
anonymous pages reliable. Details can be found in [1].

This primarily fixes remaining known O_DIRECT memory corruptions that can
happen on concurrent swapout, whereby we can lose DMA reads to a page
(modifying the user page by writing to it).

To verify, there are two test cases (requiring swap space, obviously):
(1) The O_DIRECT+swapout test case [2] from Andrea. This test case tries
    triggering a race condition.
(2) My vmsplice() test case [3] that tries to detect if the exclusive
    marker was lost during swapout, not relying on a race condition.


For example, on 32bit x86 (with and without PAE), my test case fails
without these patches:
	$ ./test_swp_exclusive
	FAIL: page was replaced during COW
But succeeds with these patches:
	$ ./test_swp_exclusive 
	PASS: page was not replaced during COW


Why implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE for all architectures, even
the ones where swap support might be in a questionable state? This is the
first step towards removing "readable_exclusive" migration entries, and
instead using pte_swp_exclusive() also with (readable) migration entries
instead (as suggested by Peter). The only missing piece for that is
supporting pmd_swp_exclusive() on relevant architectures with THP
migration support.

As all relevant architectures now implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE,,
we can drop __HAVE_ARCH_PTE_SWP_EXCLUSIVE in the last patch.


RFC because some of the swap PTE layouts are really tricky and I really
need some feedback related to deciphering these layouts and "using yet
unused PTE bits in swap PTEs". I tried cross-compiling all relevant setups
(phew, I might only miss some power/nohash variants), but only tested on
x86 so far.

CCing arch maintainers only on this cover letter and on the respective
patch(es).


[1] https://lkml.kernel.org/r/20220329164329.208407-1-david@redhat.com
[2] https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/page_count_do_wp_page-swap.c
[3] https://gitlab.com/davidhildenbrand/scratchspace/-/blob/main/test_swp_exclusive.c

David Hildenbrand (26):
  mm/debug_vm_pgtable: more pte_swp_exclusive() sanity checks
  alpha/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  arc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  csky/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  hexagon/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  ia64/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  loongarch/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  m68k/mm: remove dummy __swp definitions for nommu
  m68k/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  mips/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  nios2/mm: refactor swap PTE layout
  nios2/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  openrisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  parisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  powerpc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
  powerpc/nohash/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  riscv/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  sh/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit
  sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 64bit
  um/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  x86/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also on 32bit
  xtensa/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  mm: remove __HAVE_ARCH_PTE_SWP_EXCLUSIVE

 arch/alpha/include/asm/pgtable.h              | 40 ++++++++-
 arch/arc/include/asm/pgtable-bits-arcv2.h     | 26 +++++-
 arch/arm/include/asm/pgtable-2level.h         |  3 +
 arch/arm/include/asm/pgtable-3level.h         |  3 +
 arch/arm/include/asm/pgtable.h                | 34 ++++++--
 arch/arm64/include/asm/pgtable.h              |  1 -
 arch/csky/abiv1/inc/abi/pgtable-bits.h        | 13 ++-
 arch/csky/abiv2/inc/abi/pgtable-bits.h        | 19 ++--
 arch/csky/include/asm/pgtable.h               | 17 ++++
 arch/hexagon/include/asm/pgtable.h            | 36 ++++++--
 arch/ia64/include/asm/pgtable.h               | 31 ++++++-
 arch/loongarch/include/asm/pgtable-bits.h     |  4 +
 arch/loongarch/include/asm/pgtable.h          | 38 +++++++-
 arch/m68k/include/asm/mcf_pgtable.h           | 35 +++++++-
 arch/m68k/include/asm/motorola_pgtable.h      | 37 +++++++-
 arch/m68k/include/asm/pgtable_no.h            |  6 --
 arch/m68k/include/asm/sun3_pgtable.h          | 38 +++++++-
 arch/microblaze/include/asm/pgtable.h         | 44 +++++++---
 arch/mips/include/asm/pgtable-32.h            | 86 ++++++++++++++++---
 arch/mips/include/asm/pgtable-64.h            | 23 ++++-
 arch/mips/include/asm/pgtable.h               | 35 ++++++++
 arch/nios2/include/asm/pgtable-bits.h         |  3 +
 arch/nios2/include/asm/pgtable.h              | 37 ++++++--
 arch/openrisc/include/asm/pgtable.h           | 40 +++++++--
 arch/parisc/include/asm/pgtable.h             | 40 ++++++++-
 arch/powerpc/include/asm/book3s/32/pgtable.h  | 37 ++++++--
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h  | 22 +++--
 arch/powerpc/include/asm/nohash/32/pte-40x.h  |  6 +-
 arch/powerpc/include/asm/nohash/32/pte-44x.h  | 18 +---
 arch/powerpc/include/asm/nohash/32/pte-85xx.h |  4 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h  | 24 +++++-
 arch/powerpc/include/asm/nohash/pgtable.h     | 15 ++++
 arch/powerpc/include/asm/nohash/pte-e500.h    |  1 -
 arch/riscv/include/asm/pgtable-bits.h         |  3 +
 arch/riscv/include/asm/pgtable.h              | 28 ++++--
 arch/s390/include/asm/pgtable.h               |  1 -
 arch/sh/include/asm/pgtable_32.h              | 53 +++++++++---
 arch/sparc/include/asm/pgtable_32.h           | 26 +++++-
 arch/sparc/include/asm/pgtable_64.h           | 37 +++++++-
 arch/sparc/include/asm/pgtsrmmu.h             | 14 +--
 arch/um/include/asm/pgtable.h                 | 36 +++++++-
 arch/x86/include/asm/pgtable-2level.h         | 26 ++++--
 arch/x86/include/asm/pgtable-3level.h         | 26 +++++-
 arch/x86/include/asm/pgtable.h                |  3 -
 arch/xtensa/include/asm/pgtable.h             | 31 +++++--
 include/linux/pgtable.h                       | 29 -------
 mm/debug_vm_pgtable.c                         | 25 +++++-
 mm/memory.c                                   |  4 -
 mm/rmap.c                                     | 11 ---
 50 files changed, 943 insertions(+), 227 deletions(-)

-- 
2.38.1

