Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EFD60569E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJTFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJTFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:08:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21119182C7C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666242494; x=1697778494;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=QDKNlP2NJ82iJ8MSKId879sWFVAwfC+2ZJLTKW8Ec4c=;
  b=AIPnJl9BEasCMNDM5QDt6g8fTAvfz+pELQVknEmAqd9Z9wWutNPE7CDl
   tx46UBQDqvtw9hW9fxRTWP2E3GiiljbYyeL8iDYKP5KoZihKHFkdhVTD3
   mD4Cs12mXfpd9KHtd4zD91d0Q5jebRosWvEke0foKaz365uZA3cWXL6kv
   DzY1UX8VY9EXgTG6UfUyFQ6dyfOWDJa6BMM8PX+D1TODsBBqNvR4V2xx7
   Nk1TW8ES/smbZk1fRtiJkxCGnBly/s2FD9Ifc2rbTmnnIuTa8gtwxRJ3+
   cbc8r6j/nfiK3FCi7peSOyu/Rl42bAgitBqpkTkZ2MwY2uQcD2vPPeGYj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="307704258"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="307704258"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 22:08:13 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="958697924"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="958697924"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 22:08:10 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Rik van Riel <riel@surriel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
References: <202210181535.7144dd15-yujie.liu@intel.com>
        <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
Date:   Thu, 20 Oct 2022 13:07:09 +0800
In-Reply-To: <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X> (Nathan Chancellor's
        message of "Wed, 19 Oct 2022 21:23:29 -0700")
Message-ID: <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nathan,

Thanks for your information!  That's valuable.

Nathan Chancellor <nathan@kernel.org> writes:

> Hi Ying,
>
> On Wed, Oct 19, 2022 at 10:05:50AM +0800, Huang, Ying wrote:
>> Hi, Yujie,
>>=20
>> >      32528  48%    +147.6%      80547  38%  numa-meminfo.node0.AnonHug=
ePages
>> >      92821  23%     +59.3%     147839  28%  numa-meminfo.node0.AnonPag=
es
>>=20
>> The Anon pages allocated are much more than the parent commit.  This is
>> expected, because THP instead of normal page will be allocated for
>> aligned memory area.
>>=20
>> >      95.23           -79.8       15.41   6%  perf-profile.calltrace.cy=
cles-pp.__munmap
>> >      95.08           -79.7       15.40   6%  perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe.__munmap
>> >      95.02           -79.6       15.39   6%  perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>> >      94.96           -79.6       15.37   6%  perf-profile.calltrace.cy=
cles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mun=
map
>> >      94.95           -79.6       15.37   6%  perf-profile.calltrace.cy=
cles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.__munmap
>> >      94.86           -79.5       15.35   6%  perf-profile.calltrace.cy=
cles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe
>> >      94.38           -79.2       15.22   6%  perf-profile.calltrace.cy=
cles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
>> >      42.74           -42.7        0.00        perf-profile.calltrace.c=
ycles-pp.lru_add_drain.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
>> >      42.74           -42.7        0.00        perf-profile.calltrace.c=
ycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap.__vm_munm=
ap
>> >      42.72           -42.7        0.00        perf-profile.calltrace.c=
ycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region.=
__do_munmap
>> >      41.84           -41.8        0.00        perf-profile.calltrace.c=
ycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.l=
ru_add_drain.unmap_region
>> >      41.70           -41.7        0.00        perf-profile.calltrace.c=
ycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_=
lru.lru_add_drain_cpu.lru_add_drain
>> >      41.62           -41.6        0.00        perf-profile.calltrace.c=
ycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_=
finish_mmu.unmap_region
>> >      41.55 -41.6 0.00
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_d=
rain_cpu
>> >      41.52           -41.5        0.00        perf-profile.calltrace.c=
ycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb=
_batch_pages_flush.tlb_finish_mmu
>> >      41.28 -41.3 0.00
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_=
flush
>>=20
>> In the parent commit, most CPU cycles are used for contention on LRU loc=
k.
>>=20
>> >       0.00            +4.8        4.82   7%  perf-profile.calltrace.cy=
cles-pp.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_use=
r_addr_fault.exc_page_fault
>> >       0.00            +4.9        4.88   7%  perf-profile.calltrace.cy=
cles-pp.zap_huge_pmd.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
>> >       0.00            +8.2        8.22   8%  perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueu=
e.get_page_from_freelist
>> >       0.00            +8.2        8.23   8%  perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_=
pages
>> >       0.00            +8.3        8.35   8%  perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.=
free_unref_page.release_pages
>> >       0.00            +8.3        8.35   8%  perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.free_pcppages_bulk.free_unref_page.release_pages.tlb=
_batch_pages_flush
>> >       0.00            +8.4        8.37   8%  perf-profile.calltrace.cy=
cles-pp.free_pcppages_bulk.free_unref_page.release_pages.tlb_batch_pages_fl=
ush.tlb_finish_mmu
>> >       0.00            +9.6        9.60   6%  perf-profile.calltrace.cy=
cles-pp.free_unref_page.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.=
unmap_region
>> >       0.00           +65.5       65.48   2%  perf-profile.calltrace.cy=
cles-pp.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__hand=
le_mm_fault.handle_mm_fault
>> >       0.00           +72.5       72.51   2%  perf-profile.calltrace.cy=
cles-pp.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.hand=
le_mm_fault.do_user_addr_fault
>>=20
>> With the commit, most CPU cycles are consumed for clear huge page.  This
>> is expected.  We allocate more pages, so, we need more cycles to clear
>> them.
>>=20
>> Check the source code of test case (will-it-scale/malloc1), I found that
>> it will allocate some memory with malloc() then free it.
>>=20
>> In the parent commit, because the virtual memory address isn't aligned
>> with 2M, normal page will be allocated.  With the commit, THP will be
>> allocated, so more page clearing and less LRU lock contention.  I think
>> this is the expected behavior of the commit.  And the test case isn't so
>> popular (malloc() then free() but don't access the memory allocated).  So
>> this regression isn't important.  We can just ignore it.
>
> For what it's worth, I just bisected a massive and visible performance
> regression on my Threadripper 3990X workstation to commit f35b5d7d676e
> ("mm: align larger anonymous mappings on THP boundaries"), which seems
> directly related to this report/analysis. I initially noticed this
> because my full set of kernel builds against mainline went from 2 hours
> and 20 minutes or so to over 3 hours. Zeroing in on x86_64 allmodconfig,
> which I used for the bisect:
>
> @ 7b5a0b664ebe ("mm/page_ext: remove unused variable in offline_page_ext"=
):
>
> Benchmark 1: make -skj128 LLVM=3D1 allmodconfig all
>   Time (mean =C2=B1 =CF=83):     318.172 s =C2=B1  0.730 s    [User: 3175=
0.902 s, System: 4564.246 s]
>   Range (min =E2=80=A6 max):   317.332 s =E2=80=A6 318.662 s    3 runs
>
> @ f35b5d7d676e ("mm: align larger anonymous mappings on THP boundaries"):
>
> Benchmark 1: make -skj128 LLVM=3D1 allmodconfig all

Have you tried to build with gcc?  Want to check whether is this clang
specific issue or not.

Best Regards,
Huang, Ying

>   Time (mean =C2=B1 =CF=83):     406.688 s =C2=B1  0.676 s    [User: 3181=
9.526 s, System: 16327.022 s]
>   Range (min =E2=80=A6 max):   405.954 s =E2=80=A6 407.284 s    3 run
>
> That is a pretty big difference (27%), which is visible while doing a
> lot of builds, only because of the extra system time. If there is any
> way to improve this, it should certainly be considered.
>
> For now, I'll just revert it locally.
>
> Cheers,
> Nathan
>
> # bad: [aae703b02f92bde9264366c545e87cec451de471] Merge tag 'for-6.1-rc1-=
tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> # good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
> git bisect start 'aae703b02f92bde9264366c545e87cec451de471' 'v6.0'
> # good: [18fd049731e67651009f316195da9281b756f2cf] Merge tag 'arm64-upstr=
eam' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 18fd049731e67651009f316195da9281b756f2cf
> # good: [ab0c23b535f3f9d8345d8ad4c18c0a8594459d55] MAINTAINERS: add RISC-=
V's patchwork
> git bisect good ab0c23b535f3f9d8345d8ad4c18c0a8594459d55
> # bad: [f721d24e5dae8358b49b24399d27ba5d12a7e049] Merge tag 'pull-tmpfile=
' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect bad f721d24e5dae8358b49b24399d27ba5d12a7e049
> # good: [ada3bfb6492a6d0d3eca50f3b61315fe032efc72] Merge tag 'tpmdd-next-=
v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpm=
dd
> git bisect good ada3bfb6492a6d0d3eca50f3b61315fe032efc72
> # bad: [4e07acdda7fc23f5c4666e54961ef972a1195ffd] mm/hwpoison: add __init=
/__exit annotations to module init/exit funcs
> git bisect bad 4e07acdda7fc23f5c4666e54961ef972a1195ffd
> # bad: [000a449345bbb4ffbd880f7143b5fb4acac34121] radix tree test suite: =
add allocation counts and size to kmem_cache
> git bisect bad 000a449345bbb4ffbd880f7143b5fb4acac34121
> # bad: [47d55419951312d723de1b6ad53ee92948b8eace] btrfs: convert process_=
page_range() to use filemap_get_folios_contig()
> git bisect bad 47d55419951312d723de1b6ad53ee92948b8eace
> # bad: [4d86d4f7227c6f2acfbbbe0623d49865aa71b756] mm: add more BUILD_BUG_=
ONs to gfp_migratetype()
> git bisect bad 4d86d4f7227c6f2acfbbbe0623d49865aa71b756
> # bad: [816284a3d0e27828b5cc35f3cf539b0711939ce3] userfaultfd: update doc=
umentation to describe /dev/userfaultfd
> git bisect bad 816284a3d0e27828b5cc35f3cf539b0711939ce3
> # good: [be6667b0db97e10b2a6d57a906c2c8fd2b985e5e] selftests/vm: dedup hu=
gepage allocation logic
> git bisect good be6667b0db97e10b2a6d57a906c2c8fd2b985e5e
> # bad: [2ace36f0f55777be8a871c370832527e1cd54b15] mm: memory-failure: cle=
anup try_to_split_thp_page()
> git bisect bad 2ace36f0f55777be8a871c370832527e1cd54b15
> # good: [9d0d946840075e0268f4f77fe39ba0f53e84c7c4] selftests/vm: add self=
test to verify multi THP collapse
> git bisect good 9d0d946840075e0268f4f77fe39ba0f53e84c7c4
> # bad: [f35b5d7d676e59e401690b678cd3cfec5e785c23] mm: align larger anonym=
ous mappings on THP boundaries
> git bisect bad f35b5d7d676e59e401690b678cd3cfec5e785c23
> # good: [7b5a0b664ebe2625965a0fdba2614c88c4b9bbc6] mm/page_ext: remove un=
used variable in offline_page_ext
> git bisect good 7b5a0b664ebe2625965a0fdba2614c88c4b9bbc6
> # first bad commit: [f35b5d7d676e59e401690b678cd3cfec5e785c23] mm: align =
larger anonymous mappings on THP boundaries
