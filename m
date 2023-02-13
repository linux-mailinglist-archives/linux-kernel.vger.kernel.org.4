Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E4B694E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBMRsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjBMRr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:47:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A965FF5;
        Mon, 13 Feb 2023 09:47:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E7261137;
        Mon, 13 Feb 2023 17:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E95C433EF;
        Mon, 13 Feb 2023 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676310475;
        bh=cgM3jFeDFnj+GOFXYa97ss71Uw4otLXRm9XdSspJ3Q4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EFqgCx1c5jPBBYYO7gfmsjFblMqRQbnikl2fFBWzldiVuImzCxYUavJ326qHzCgZG
         ih0xuXhNlUVVOFjHnmupIk8RAO34cfsZNkK66A0Yg7HxcrCgbkJag6v1I4uUWZ0heN
         WdmprlrokCVdILc+8zJ2c41BqQDSOeFNEbxcWeRI=
Date:   Mon, 13 Feb 2023 09:47:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: nvme boot problems after merge of mm-stable tree into
 linux-next
Message-Id: <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
In-Reply-To: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc linux-mm)

On Sun, 12 Feb 2023 08:27:32 -0800 Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> I am having problems booting from nvme in linux-next. Bisect points to 06e5887cdcc11
> ("Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm").
> The problem was first seen on February 8.
> 
> Some of the log messages as well as the bisect log are attached. Note that the problem
> is not seen in all architectures. The list below may not be complete since several
> architectures/platforms fail to boot for other reasons.
> 
> Guenter
> 
> ---
> 
> # bad: [6ba8a227fd19d19779005fb66ad7562608e1df83] Add linux-next specific files for 20230210
> # good: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
> git bisect start 'HEAD' 'v6.2-rc7'
> # good: [94613f0efc69ed41f9229ef5c294db3ec37145da] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect good 94613f0efc69ed41f9229ef5c294db3ec37145da
> # good: [19e62c715fe70dae4582c2874ed3e66715d09af6] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> git bisect good 19e62c715fe70dae4582c2874ed3e66715d09af6
> # good: [5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6] Merge branch 'for-next' of https://gitlab.com/peda-linux/mux.git
> git bisect good 5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6
> # good: [c349bf6ec83903b20fe570c5609b9a864a64e09c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
> git bisect good c349bf6ec83903b20fe570c5609b9a864a64e09c
> # good: [5a06a9f17454df38f35672be522ff5eb9b4277d2] selftest: add testing unsharing and counting ksm zero page
> git bisect good 5a06a9f17454df38f35672be522ff5eb9b4277d2
> # good: [f5d115a7b06e5661ed5218ffa9a2644c4ff1c135] Merge branch 'mm-nonmm-unstable' into mm-everything
> git bisect good f5d115a7b06e5661ed5218ffa9a2644c4ff1c135
> # good: [9a863a6a51394bff480c959b713874c090a8f5c6] mm/gup: make locked never NULL in the internal GUP functions
> git bisect good 9a863a6a51394bff480c959b713874c090a8f5c6
> # good: [80fe99787924df7e6048204be7403a2d0b48918c] Merge branch 'for-next/kspp' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
> git bisect good 80fe99787924df7e6048204be7403a2d0b48918c
> # good: [bed9e516f1183faa0e484479701cc669efd9049a] Merge branch 'vfio-no-iommu' into iommufd.git for-next
> git bisect good bed9e516f1183faa0e484479701cc669efd9049a
> # bad: [06e5887cdcc111d64caa632c39e00a81340f0262] Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 06e5887cdcc111d64caa632c39e00a81340f0262
> # good: [223ec6ab265ead0b319bc2f15d0d1be05078a74b] mm/memremap.c: fix outdated comment in devm_memremap_pages
> git bisect good 223ec6ab265ead0b319bc2f15d0d1be05078a74b
> # good: [b942a520d9e43bc31f0808d2f2267a1ddba75518] bcache: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
> git bisect good b942a520d9e43bc31f0808d2f2267a1ddba75518
> # good: [3592abd2f44dad9d7232b09e85e8dd1b7fdf91e2] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
> git bisect good 3592abd2f44dad9d7232b09e85e8dd1b7fdf91e2
> # first bad commit: [06e5887cdcc111d64caa632c39e00a81340f0262] Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> ---
> alpha:
> 
> Unable to handle kernel paging request at virtual address 0000000000000008
> swapper(0): Oops 1
> pc = [<fffffc0000439100>]  ra = [<fffffc00004390e0>]  ps = 0007    Tainted: G                 N
> pc is at dma_pool_free+0x60/0xf0
> ra is at dma_pool_free+0x40/0xf0
> v0 = 0000000000000007  t0 = 0000000000000000  t1 = fffffc00012037c0
> t2 = 0000000000000001  t3 = fffffc0002ac1100  t4 = fffffc00000400a0
> t5 = fffffc00000400a0  t6 = 0000000000000000  t7 = fffffc00011b0000
> s0 = fffffc0001e6ae40  s1 = 0000000000000000  s2 = 0000000000000007
> s3 = 0000000000000000  s4 = fffffc0001e6ae50  s5 = 0000000000000005
> s6 = fffffc0001eb7932
> a0 = fffffc0001e6ae50  a1 = 0000000000000000  a2 = 0000000000000000
> a3 = 0000000000000002  a4 = 0000000000000000  a5 = 000000000000005a
> t8 = 0000000000000000  t9 = fffffc0001b67248  t10= 0000000000000000
> t11= 0000000000000140  pv = fffffc000037b400  at = 0000000000000001
> gp = fffffc000123cf78  sp = fffffc00011b3b80
> Disabling lock debugging due to kernel taint
> Trace:
> [<fffffc0000a0e1dc>] nvme_unmap_data+0xac/0x220
> [<fffffc0000a0e350>] nvme_pci_complete_batch+0x0/0xe0
> [<fffffc0000a0fda8>] nvme_poll_cq+0x4b8/0x510
> [<fffffc0000a0e350>] nvme_pci_complete_batch+0x0/0xe0
> [<fffffc0000a119f4>] nvme_irq+0x34/0xd0
> [<fffffc00003b076c>] tick_handle_periodic+0x8c/0xc0
> [<fffffc00003857a0>] __handle_irq_event_percpu+0x80/0x1c0
> [<fffffc00003859e8>] handle_irq_event+0x68/0x110
> [<fffffc000038af24>] handle_level_irq+0xe4/0x220
> [<fffffc0000316020>] handle_irq+0x90/0x100
> [<fffffc0000325204>] clipper_srm_device_interrupt+0x24/0x40
> [<fffffc00003161c0>] do_entInt+0x130/0x1e0
> [<fffffc0000311510>] ret_from_sys_call+0x0/0x10
> [<fffffc00003736b8>] do_idle+0x88/0x1e0
> [<fffffc0000df7460>] cpu_idle_poll.isra.0+0x0/0x70
> [<fffffc0000df74a0>] cpu_idle_poll.isra.0+0x40/0x70
> [<fffffc0000373bd8>] cpu_startup_entry+0x28/0x40
> [<fffffc0000df7640>] rest_init+0x100/0x104
> [<fffffc000031001c>] _stext+0x1c/0x20
> [<fffffc0000310000>] _stext+0x0/0x20
> 
> ---
> mips (all variants):
> 
> CPU 0 Unable to handle kernel paging request at virtual address 00000004, epc == 802d9eb8, ra == 802d9ea4
> Oops[#1]:
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                 N 6.2.0-rc7-next-20230210 #1
> $ 0   : 00000000 00000001 00000000 00000000
> $ 4   : 8260e888 00000000 810ee780 00000001
> $ 8   : 00000000 813dba24 05345ded 0000020e
> $12   : ffffffff 00000001 8198835c 00000000
> $16   : 8260e880 00000000 00000000 01244800
> $20   : 8260e888 820afec8 808b6c24 a2668290
> $24   : 00000002 810f0000
> $28   : 810c4000 820afe18 81030000 802d9ea4
> Hi    : 000656d0
> Lo    : 4b877998
> epc   : 802d9eb8 dma_pool_free+0x48/0xa0
> ra    : 802d9ea4 dma_pool_free+0x34/0xa0
> Status: 1000a402	KERNEL EXL
> Cause : 0080000c (ExcCode 03)
> BadVA : 00000004
> PrId  : 00019300 (MIPS 24Kc)
> Modules linked in:
> Process swapper/0 (pid: 0, threadinfo=d5273c62, task=cb66b3ba, tls=00000000)
> Stack : ffffffff fffffffe ffffffff ffffffff 821e0dc0 01244800 820b1000 811b61c0
>          810eaa0c 808b6af0 811b61c0 8275c000 820afec8 808b6c24 00000000 801c92f8
>          82604700 821e0dc0 00000001 811b61c0 810eaa0c 808b7b34 810d3b3c 8123447c
>          00000002 8123447c 00000000 80d6660c 81030000 810d3b2c 810f0000 00000000
>          810d3ac0 811b01e0 811b0200 0000000b 00000001 82650c80 00000000 808b86c0
>          ...
> Call Trace:
> [<802d9eb8>] dma_pool_free+0x48/0xa0
> [<808b6af0>] nvme_unmap_data+0x84/0x1b8
> [<808b7b34>] nvme_poll_cq+0x444/0x558
> [<808b86c0>] nvme_irq+0x34/0x84
> [<801b8020>] __handle_irq_event_percpu+0x280/0x434
> [<801b8284>] handle_irq_event+0x50/0xbc
> [<801bdf18>] handle_level_irq+0xf8/0x218
> [<801b6eec>] generic_handle_domain_irq+0x2c/0x44
> [<801b6eec>] generic_handle_domain_irq+0x2c/0x44
> [<80d734d8>] do_domain_IRQ+0x20/0x2c
> [<80795b88>] plat_irq_dispatch+0x64/0xcc
> [<801039a0>] handle_int+0x160/0x16c
> [<80d679b0>] r4k_wait+0xc/0x2c
> [<80d67e38>] default_idle_call+0x98/0x384
> [<80189670>] do_idle+0xfc/0x1cc
> [<80189b60>] cpu_startup_entry+0x2c/0x34
> [<80d68310>] rest_init+0x118/0x1c0
> [<811bc788>] arch_post_acpi_subsys_init+0x0/0x8
> 
> 
> ---
> sparc64:
> 
>      5.070356] Unable to handle kernel NULL pointer dereference
> [    5.071034] tsk->{mm,active_mm}->context = 0000000000000001
> [    5.071519] tsk->{mm,active_mm}->pgd = fffff800048b0000
> [    5.071812]               \|/ ____ \|/
> [    5.071812]               "@'/ .. \`@"
> [    5.071812]               /_| \__/ |_\
> [    5.071812]                  \__U_/
> [    5.072549] init(1): Oops [#1]
> [    5.073008] CPU: 0 PID: 1 Comm: init Tainted: G                 N 6.2.0-rc7-next-20230210 #1
> [    5.073599] TSTATE: 0000004480e01605 TPC: 000000000061bdb0 TNPC: 000000000061bdb4 Y: 00000000    Tainted: G                 N
> [    5.074154] TPC: <dma_pool_free+0x30/0xa0>
> [    5.074778] g0: 0265a89d01ced61d g1: 0000000000000000 g2: 0000000000000000 g3: 000000000000000a
> [    5.075311] g4: fffff800041669a0 g5: fffff8001dca0000 g6: fffff80004168000 g7: 0000000080b583eb
> [    5.075821] o0: 000000000000000e o1: 000000000000000e o2: 0000000000000006 o3: 0000000000000002
> [    5.076265] o4: 0000000000000000 o5: 000000000000000e sp: fffff8001fdff191 ret_pc: 000000000061bd90
> [    5.076716] RPC: <dma_pool_free+0x10/0xa0>
> [    5.076978] l0: 0000000001b61a58 l1: 000000000000000e l2: 000000000208c278 l3: 0000000000000002
> [    5.077421] l4: 81b8e1e5a4e0c637 l5: fffff80004167420 l6: 000000000000401e l7: 0000000000000001
> [    5.077862] i0: fffff800045bae90 i1: 000000000000000e i2: 0000000000000000 i3: 0000000000000002
> [    5.078299] i4: 0000000000000000 i5: fffff800045bae80 i6: fffff8001fdff241 i7: 0000000000b53e54
> [    5.078746] I7: <nvme_unmap_data+0x74/0x140>
> [    5.079031] Call Trace:
> [    5.079384] [<0000000000b53e54>] nvme_unmap_data+0x74/0x140
> [    5.079752] [<0000000000b54338>] nvme_handle_cqe+0x338/0x3e0
> [    5.080053] [<0000000000b5460c>] nvme_irq+0x8c/0x180
> [    5.080316] [<00000000004e7564>] __handle_irq_event_percpu+0x204/0x3a0
> [    5.080647] [<00000000004e7774>] handle_irq_event+0x34/0xc0
> [    5.080934] [<00000000004ec750>] handle_fasteoi_irq+0x90/0x220
> [    5.081231] [<00000000004e6128>] generic_handle_irq+0x28/0x40
> [    5.081526] [<0000000000f4d12c>] handler_irq+0xac/0x100
> [    5.081848] [<00000000004274b0>] sys_call_table+0x760/0x970
> [    5.082191] [<000000000090196c>] __blk_mq_run_hw_queue+0x16c/0x2a0
> [    5.082646] [<000000000090c0dc>] blk_mq_sched_insert_requests+0xdc/0x5c0
> [    5.082993] [<00000000009053c0>] blk_mq_flush_plug_list+0xe0/0x700
> [    5.083311] [<00000000008f6280>] __blk_flush_plug+0xc0/0x100
> [    5.083602] [<00000000008f66c4>] blk_finish_plug+0x24/0x40
> [    5.083886] [<00000000005b48c4>] read_pages+0x164/0x280
> [    5.084159] [<00000000005b4af8>] page_cache_ra_unbounded+0x118/0x1a0
