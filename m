Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA854631598
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKTRuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 12:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKTRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 12:50:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6482409A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 09:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F395D60C92
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 17:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBBBC433D6;
        Sun, 20 Nov 2022 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668966617;
        bh=FoiYQ5R7P2clZgweCBsRCs5i3WzjolzGTXgeWwXvTFg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aO1UaDMbOq5D5ygD4Xjr+P8yrZ73qLQJSV+7PAE9ynNMaHne5KowJoie/WpkKQa4p
         yrI/1Y5V/kClJdSwEjlCDmoNwCkxfEUcTqWR2ASAUAlm5QB6CaC2tdcGYIre8QkcUN
         6bv5StYMGOcS8H+tLI/KHsBvGQIFb5Dmc7Y05L2J6PJa5ouWrmWGnXAdB5t3CBXiAH
         ZmHzYuCG52ajPxCMDWymBp8nQ7Ai3nFj/pkT/W1xvlreReBrAPp2gyJdrqZVwkgPt4
         +FciyMwFDB2aPLKsDtErrq3fMsbZqBHR2oNrxbOj4WvTZ8vzAnyXSKRlqty86pyAPy
         EzFROwD7/OqDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1BF35C09CB; Sun, 20 Nov 2022 09:50:16 -0800 (PST)
Date:   Sun, 20 Nov 2022 09:50:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, phillip.lougher@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Message-ID: <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
 <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
 <20221118155534.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 04:49:37PM +0100, Mirsad Goran Todorovac wrote:
> On 18. 11. 2022. 16:55, Paul E. McKenney wrote:
> > On Fri, Nov 18, 2022 at 06:11:16AM +0000, Phillip Lougher wrote:
> > > On 17/11/2022 23:05, Mirsad Goran Todorovac wrote:
> > > > Hi,
> > > > 
> > > > While trying to bisect, I've found another bug that predated the
> > > > introduction of squashfs_readahead(), but it has
> > > > a common denominator in squashfs_decompress() and squashfs_xz_uncompress().
> > > 
> > > Wrong, the stall is happening in the XZ decompressor library, which
> > > is *not* in Squashfs.
> > > 
> > > This reported stall in the decompressor code is likely a symptom of you
> > > deliberately thrashing your system.  When the system thrashes everything
> > > starts to happen very slowly, and the system will spend a lot of
> > > its time doing page I/O, and the CPU will spend a lot of time in
> > > any CPU intensive code like the XZ decompressor library.
> > > 
> > > So the fact the stall is being hit here is a symptom and not
> > > a cause.  The decompressor code is likely running slowly due to
> > > thrashing and waiting on paged-out buffers.  This is not indicative
> > > of any bug, merely a system running slowly due to overload.
> > > 
> > > As I said, this is not a Squashfs issue, because the code when the
> > > stall takes place isn't in Squashfs.
> > > 
> > > The people responsible for the rcu code should have a lot more insight
> > > about what happens when the system is thrashing, and how this will
> > > throw up false positives.  In this I believe this is an instance of
> > > perfectly correct code running slowly due to thrashing incorrectly
> > > being flagged as looping.
> > > 
> > > CC'ing Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > > Frankly, I need an advice on how to handle a situation like this.
> > > > 
> > > > Obviously, the best place to test the RCU problem with
> > > > squashfs_readahead() is where it is introduced + Phillip's patches
> > > > [012]/3.
> > > > 
> > > > Thanks,
> > > > Mirsad
> > > > 
> > > > P.S.
> > > > 
> > > > This is excerpt from dmesg log attached:
> > > > 
> > > > [   25.338169] rcu: INFO: rcu_preempt detected expedited stalls on
> > > > CPUs/tasks: { 4-... } 6 jiffies s: 373 root: 0x10/.
> > 
> > The "6 jiffies" leads me to believe that this kernel was built with
> > CONFIG_ANDROID=y, but also with the short expedited grace-period commit,
> > that is, with CONFIG_RCU_EXP_CPU_STALL_TIMEOUT set to 20 milliseconds
> > and with HZ set to something like 250.  This means that the kernel
> > will complain if an RCU read-side critical section exceeeds about 20
> > milliseconds.  This is a fine thing if you are actually running on an
> > Android, but a bit extreme for general usage.
> > 
> > If my guesses are correct, please apply this commit from mainline:
> > 
> > 1045a06724f3 ("remove CONFIG_ANDROID")
> > 
> > With this commit in place, CONFIG_RCU_EXP_CPU_STALL_TIMEOUT will default
> > to 21000 (that is, 21 seconds) and things will be much better.

Please apply the commit called out above and rerun your test.

But if you still cannot bring yourself to do that, more interspersed
below...

> Dear Paul,
> 
> Actually, I was able to reproduce and bisect the commit that started causing
> described stalls (I have already explained how 5.10 didn't show any under the
> exactly same saved widows and tabs set.)
> 
> # bad: [1e57930e9f4083ad5854ab6eadffe790a8167fb4] Merge tag
> 'rcu.2022.05.19a' of
> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu
> git bisect bad 1e57930e9f4083ad5854ab6eadffe790a8167fb4
> # good: [f993aed406eaf968ba3867a76bb46c95336a33d0] Merge tag 'block-5.18-2022-05-18' of git://git.kernel.dk/linux-block
> git bisect good f993aed406eaf968ba3867a76bb46c95336a33d0
> # good: [bf2431021c8cfe52c866d7bf640ced03a35ebe91] Merge tag
> 'efi-next-for-v5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
> git bisect good bf2431021c8cfe52c866d7bf640ced03a35ebe91
> # good: [be05ee54378d451e1d60196921566d6087f3079f] Merge branches
> 'docs.2022.04.20a', 'fixes.2022.04.20a', 'nocb.2022.04.11b',
> 'rcu-tasks.2022.04.11b', 'srcu.2022.
> 05.03a', 'torture.2022.04.11b', 'torture-tasks.2022.04.20a' and 'torturescript.2022.04.20a' into HEAD
> git bisect good be05ee54378d451e1d60196921566d6087f3079f
> # good: [023033fe343cdf2ba83ab762f8de69241c7fc086] tools/nolibc/types: define PATH_MAX and MAXPATHLEN
> git bisect good 023033fe343cdf2ba83ab762f8de69241c7fc086
> # good: [96980b833a21c6dc29d0dfdc8f211fb8a10256a7] tools/nolibc/string: do not use __builtin_strlen() at -O0
> git bisect good 96980b833a21c6dc29d0dfdc8f211fb8a10256a7
> # good: [0e0ff638400be8f497a35b51a4751fd823f6bd6a] tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
> git bisect good 0e0ff638400be8f497a35b51a4751fd823f6bd6a
> # good: [b2f02e9cdaade3ce565e6973ac313d2f814447f2] Merge tag
> 'lkmm.2022.05.20a' of
> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu
> git bisect good b2f02e9cdaade3ce565e6973ac313d2f814447f2
> # good: [9621fbee44df940e2e1b94b0676460a538dffefa] rcu: Move expedited grace period (GP) work to RT kthread_worker
> git bisect good 9621fbee44df940e2e1b94b0676460a538dffefa
> # bad: [ce13389053a347aa9f8ffbfda2238352536e15c9] Merge branch 'exp.2022.05.11a' into HEAD
> git bisect bad ce13389053a347aa9f8ffbfda2238352536e15c9
> # first bad commit: [ce13389053a347aa9f8ffbfda2238352536e15c9] Merge branch 'exp.2022.05.11a' into HEAD

More precisely, this commit:

28b3ae426598 ("rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT")

The idea was to cause Android-based systems to have 20-millisecond
expedited RCU CPU stall warnings, but to leave other kernels at the
traditional 21-second value.  Again, the "6 jiffies" below indicates
that you are running a kernel with CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
and CONFIG_ANDROID=y.

Except that there were a lot of non-Android systems (including Debian
and Fedora) that have nothing to do with Android, but that nevertheless
build their kernels with CONFIG_ANDROID=y, which no doubt seemed like
a good idea at the time.

For more information, please see https://lwn.net/Articles/899743/

The upshot of the discussion was this same commit that I pointed out
earlier that removes CONFIG_ANDROID completely:

1045a06724f3 ("remove CONFIG_ANDROID")

Again, please apply this commit and rerun your test.

> The bug looks like this:
> 
> [   57.876820] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-... } 6 jiffies s: 545 root: 0x1/.

Yes, again "6 jiffies" which is roughly the 20 milliseconds set for
kernels built with CONFIG_ANDROID=y and HZ=250 that have this commit:

28b3ae426598 ("rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT")

But not this commit:

1045a06724f3 ("remove CONFIG_ANDROID")

Yet again, please apply this commit and rerun your test.

> [   57.876854] rcu: blocking rcu_node structures (internal RCU debug):
> [   57.876862] Task dump for CPU 0:
> [   57.876867] task:snap-store      state:R  running task     stack:    0 pid: 2678 ppid:  2230 flags:0x00004008
> [   57.876883] Call Trace:
> [   57.876888]  <TASK>
> [   57.876893]  ? _raw_spin_lock_irqsave+0x93/0xf0
> [   57.876909]  ? sysvec_apic_timer_interrupt+0x89/0x90
> [   57.876920]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [   57.876930]  ? sysvec_apic_timer_interrupt+0x89/0x90
> [   57.876939]  ? sysvec_apic_timer_interrupt+0x89/0x90
> [   57.876948]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [   57.876959]  ? lzma_len+0x1fb/0x3b0
> [   57.876971]  ? dict_repeat+0xb3/0x120
> [   57.876981]  ? lzma_main+0x943/0x1260
> [   57.876995]  ? lzma2_lzma+0x2a4/0x3b0
> [   57.877007]  ? xz_dec_lzma2_run+0x11f/0xb90
> [   57.877018]  ? crc32_le_base+0x186/0x250
> [   57.877032]  ? xz_dec_run+0x346/0x11e0
> [   57.877046]  ? squashfs_xz_uncompress+0x135/0x330
> [   57.877060]  ? lzo_init+0xd0/0xd0
> [   57.877069]  ? squashfs_decompress+0x80/0xb0
> [   57.877079]  ? squashfs_read_data+0x1eb/0x920
> [   57.877090]  ? __filemap_get_folio+0x37e/0x540
> [   57.877104]  ? squashfs_bio_read.isra.2+0x2a0/0x2a0
> [   57.877118]  ? squashfs_readpage_block+0x493/0x950
> [   57.877131]  ? squashfs_readpage+0xa52/0x1140
> [   57.877143]  ? xas_nomem+0x2f/0x100
> [   57.877154]  ? squashfs_copy_cache+0x360/0x360
> [   57.877164]  ? folio_wait_bit+0x3c0/0x3c0
> [   57.877175]  ? __kasan_check_read+0x11/0x20
> [   57.877186]  ? pagevec_add_and_need_flush+0x8c/0xa0
> [   57.877197]  ? folio_add_lru+0x42/0x70
> [   57.877206]  ? filemap_add_folio+0xd4/0x130
> [   57.877216]  ? add_to_page_cache_locked+0xa0/0xa0
> [   57.877228]  ? filemap_read_folio.isra.62+0xbe/0x4d0
> [   57.877238]  ? __kasan_check_write+0x14/0x20
> [   57.877248]  ? filemap_page_mkwrite+0x6a0/0x6a0
> [   57.877260]  ? filemap_add_folio+0x130/0x130
> [   57.877269]  ? try_charge_memcg+0x4cc/0xa90
> [   57.877281]  ? filemap_fault+0xc9a/0xe50
> [   57.877293]  ? generic_file_read_iter+0x230/0x230
> [   57.877305]  ? __rcu_read_unlock+0x55/0x260
> [   57.877317]  ? __do_fault+0x7c/0x1b0
> [   57.877329]  ? __handle_mm_fault+0x173b/0x1970
> [   57.877340]  ? copy_page_range+0x1890/0x1890
> [   57.877356]  ? handle_mm_fault+0x11b/0x380
> [   57.877366]  ? do_user_addr_fault+0x258/0x810
> [   57.877380]  ? exc_page_fault+0x60/0xe0
> [   57.877389]  ? asm_exc_page_fault+0x8/0x30
> [   57.877398]  ? asm_exc_page_fault+0x1e/0x30
> [   57.877410]  </TASK>
> 
> Please find complete dmesg, my lshw and bisect attached.
> 
> I am not competent to estimate how this commit causes this kind of problems,
> and whether stalls up to 20 jiffies are worth eradicating.

The Android folks believe that they are on Android platforms, as you
can see from the commit log on:

28b3ae426598 ("rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT")

But this would be excessive on many other platforms, especially those
with large quantities of CPUs, devices, or memory.

> Hope this helps.

Likewise!

							Thanx, Paul

> Thank you,
> Mirsad
> 
> --
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu
> -- 
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
> The European Union






