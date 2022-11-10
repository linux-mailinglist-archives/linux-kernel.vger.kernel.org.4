Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C96243CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKJOCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKJOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:02:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87678301
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668088953; x=1699624953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+iWUZpZhOdOsLlUiIVRB6R8sqxN2qkpAbKM0o5ik8E0=;
  b=GFjqzuxIFHUN4TmwkhBQbEQ9EZvg1wbd7ixtd1rOlHEtK27GKPaGdy1g
   6cGkSMmceXlINGDuP81GIrgnx5r+YhbzS6Ea0Mq3Thci+s5BB9B2Nx9Pq
   eNCf1V+RmGl6D4VKBSOEMIXJ/CaVeXqk6jNWdRG+9mbS8QIP/f9wTSQrC
   df6EzuSLPpquu8jl7pHtnPvcWCJ3aeKpHNHyyZXZRBhpyNn7RW+uF1ODz
   nEZB9qTJulXx9PI3PH8GY2/kp5QtH6sHSr+tWwXf+gaq1kgAIAOZpHK+o
   xIqH99E3VCZzkP2Ts4y6FyeZgPnK3itLGZ0/ZigsY2X4hPBT34s/oM9ID
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="313086716"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="313086716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 06:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="779781873"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="779781873"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2022 06:02:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ot88G-00AA2V-31;
        Thu, 10 Nov 2022 16:02:16 +0200
Date:   Thu, 10 Nov 2022 16:02:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Ferry Toth <fntoth@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
Message-ID: <Y20EaE9Rvz3WgnWs@smile.fi.intel.com>
References: <cover.1613243844.git.luto@kernel.org>
 <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
 <YzWj9zjTJI3RCDf2@smile.fi.intel.com>
 <YzWpob6MOf1SJr5I@smile.fi.intel.com>
 <c554f363-05db-b185-1a7d-ce8ae27890da@gmail.com>
 <d1f76ef7-2d91-2be2-285c-8dbd208239a2@gmail.com>
 <Y2u+J5EEyxRuusSr@smile.fi.intel.com>
 <CAMzpN2iEQVQWsPX58ONxaH=gkUACtq1t2OpozZ55+f=Ub+AwyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2iEQVQWsPX58ONxaH=gkUACtq1t2OpozZ55+f=Ub+AwyQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:33:24PM -0500, Brian Gerst wrote:
> On Wed, Nov 9, 2022 at 9:50 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Fri, Sep 30, 2022 at 11:18:51PM +0200, Ferry Toth wrote:
> > > Op 30-09-2022 om 22:30 schreef Ferry Toth:
> > > > Op 29-09-2022 om 16:20 schreef Andy Shevchenko:
> > > > > On Thu, Sep 29, 2022 at 04:56:07PM +0300, Andy Shevchenko wrote:
> > > > > > On Sat, Feb 13, 2021 at 11:19:44AM -0800, Andy Lutomirski wrote:
> > > > > > > On 32-bit kernels, the stackprotector canary is quite nasty -- it is
> > > > > > > stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
> > > > > > > percpu storage.  It's even nastier because it means that whether %gs
> > > > > > > contains userspace state or kernel state while running kernel code
> > > > > > > depends on whether stackprotector is enabled (this is
> > > > > > > CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
> > > > > > > that segment selectors work.  Supporting both variants is a
> > > > > > > maintenance and testing mess.
> > > > > > >
> > > > > > > Merely rearranging so that percpu and the stack canary
> > > > > > > share the same segment would be messy as the 32-bit percpu address
> > > > > > > layout isn't currently compatible with putting a variable at a fixed
> > > > > > > offset.
> > > > > > >
> > > > > > > Fortunately, GCC 8.1 added options that allow the stack canary to be
> > > > > > > accessed as %fs:__stack_chk_guard, effectively turning it
> > > > > > > into an ordinary
> > > > > > > percpu variable.  This lets us get rid of all of the code to
> > > > > > > manage the
> > > > > > > stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
> > > > > > >
> > > > > > > (That name is special.  We could use any symbol we want for the
> > > > > > >   %fs-relative mode, but for CONFIG_SMP=n, gcc refuses to
> > > > > > > let us use any
> > > > > > >   name other than __stack_chk_guard.)
> > > > > > >
> > > > > > > This patch forcibly disables stackprotector on older compilers that
> > > > > > > don't support the new options and makes the stack canary into a
> > > > > > > percpu variable.  The "lazy GS" approach is now used for all 32-bit
> > > > > > > configurations.
> > > > > > >
> > > > > > > This patch also makes load_gs_index() work on 32-bit kernels.  On
> > > > > > > 64-bit kernels, it loads the GS selector and updates the user
> > > > > > > GSBASE accordingly.  (This is unchanged.)  On 32-bit kernels,
> > > > > > > it loads the GS selector and updates GSBASE, which is now
> > > > > > > always the user base.  This means that the overall effect is
> > > > > > > the same on 32-bit and 64-bit, which avoids some ifdeffery.
> > > > > > This patch broke 32-bit boot on Intel Merrifield
> > > > > >
> > > > > > git bisect start
> > > > > > # good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
> > > > > > git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
> > > > > > # bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> > > > > > git bisect bad 62fb9874f5da54fdb243003b386128037319b219
> > > > > > # bad: [85f3f17b5db2dd9f8a094a0ddc665555135afd22] Merge branch
> > > > > > 'md-fixes' of
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/song/md into
> > > > > > block-5.13
> > > > > > git bisect bad 85f3f17b5db2dd9f8a094a0ddc665555135afd22
> > > > > > # good: [ca62e9090d229926f43f20291bb44d67897baab7] Merge tag
> > > > > > 'regulator-v5.13' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
> > > > > > git bisect good ca62e9090d229926f43f20291bb44d67897baab7
> > > > > > # bad: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag
> > > > > > 'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
> > > > > > git bisect bad 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
> > > > > > # good: [49c70ece54b0d1c51bc31b2b0c1070777c992c26]
> > > > > > drm/amd/display: Change input parameter for set_drr
> > > > > > git bisect good 49c70ece54b0d1c51bc31b2b0c1070777c992c26
> > > > > > # good: [0b276e470a4d43e1365d3eb53c608a3d208cabd4] media: coda:
> > > > > > fix macroblocks count control usage
> > > > > > git bisect good 0b276e470a4d43e1365d3eb53c608a3d208cabd4
> > > > > > # bad: [c6536676c7fe3f572ba55842e59c3c71c01e7fb3] Merge tag
> > > > > > 'x86_core_for_v5.13' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > > > > > git bisect bad c6536676c7fe3f572ba55842e59c3c71c01e7fb3
> > > > > > # good: [d1466bc583a81830cef2399a4b8a514398351b40] Merge branch
> > > > > > 'work.inode-type-fixes' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> > > > > > git bisect good d1466bc583a81830cef2399a4b8a514398351b40
> > > > > > # good: [fafe1e39ed213221c0bce6b0b31669334368dc97] Merge tag
> > > > > > 'afs-netfs-lib-20210426' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
> > > > > > git bisect good fafe1e39ed213221c0bce6b0b31669334368dc97
> > > > > > # bad: [b1f480bc0686e65d5413c035bd13af2ea4888784] Merge branch
> > > > > > 'x86/cpu' into WIP.x86/core, to merge the NOP changes & resolve
> > > > > > a semantic conflict
> > > > > > git bisect bad b1f480bc0686e65d5413c035bd13af2ea4888784
> > > > > > # bad: [0c925c61dae18ee3cb93a61cc9dd9562a066034d]
> > > > > > x86/tools/insn_decoder_test: Convert to insn_decode()
> > > > > > git bisect bad 0c925c61dae18ee3cb93a61cc9dd9562a066034d
> > > > > > # bad: [514ef77607b9ff184c11b88e8f100bc27f07460d]
> > > > > > x86/boot/compressed/sev-es: Convert to insn_decode()
> > > > > > git bisect bad 514ef77607b9ff184c11b88e8f100bc27f07460d
> > > > > > # bad: [9e761296c52dcdb1aaa151b65bd39accb05740d9] x86/insn:
> > > > > > Rename insn_decode() to insn_decode_from_regs()
> > > > > > git bisect bad 9e761296c52dcdb1aaa151b65bd39accb05740d9
> > > > > > # bad: [d0962f2b24c99889a386f0658c71535f56358f77] x86/entry/32:
> > > > > > Remove leftover macros after stackprotector cleanups
> > > > > > git bisect bad d0962f2b24c99889a386f0658c71535f56358f77
> > > > > > # bad: [3fb0fdb3bbe7aed495109b3296b06c2409734023]
> > > > > > x86/stackprotector/32: Make the canary into a regular percpu
> > > > > > variable
> > > > > > git bisect bad 3fb0fdb3bbe7aed495109b3296b06c2409734023
> > > > > > # first bad commit: [3fb0fdb3bbe7aed495109b3296b06c2409734023]
> > > > > > x86/stackprotector/32: Make the canary into a regular percpu
> > > > > > variable
> > > >
> > > > With the bad commit the last words in dmesg are:
> > > >
> > > > mem auto-init: stack:off, heap alloc:off, heap free:off
> > > > Initializing HighMem for node 0 (00036ffe:0003f500)
> > > > Initializing Movable for node 0 (00000000:00000000)
> > > > Checking if this processor honours the WP bit even in supervisor
> > > > mode...Ok.
> > > > Memory: 948444K/1004124K available (12430K kernel code, 2167K rwdata,
> > > > 4948K rodata, 716K init, 716K bss, 55680K reserved, 0K cma-reserved,
> > > > 136200K highmem)
> > > > SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> > > > trace event string verifier disabled
> > > > Dynamic Preempt: voluntary
> > > > rcu: Preemptible hierarchical RCU implementation.
> > > > rcu:     RCU event tracing is enabled.
> > > > rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
> > > >  Trampoline variant of Tasks RCU enabled.
> > > >  Tracing variant of Tasks RCU enabled.
> > > > rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> > > > rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> > > > NR_IRQS: 2304, nr_irqs: 512, preallocated irqs: 0
> > > >
> > > > without the bad commit dmesg continues:
> > > >
> > > > random: get_random_bytes called from start_kernel+0x492/0x65a with
> > > > crng_init=0
> > > > Console: colour dummy device 80x25
> > > > printk: console [tty0] enabled
> > > > printk: bootconsole [uart0] disabled
> > > >
> > > > ....
> > > >
> > > > > > Any suggestions how to fix are welcome!
> > > > > >
> > > Interesting. I added the following fragment to the kernel config:
> > >
> > > # CONFIG_STACKPROTECTOR is not set
> > >
> > > And this resolves the boot issue (tested with v5.17 i686 on Intel
> > > Merrifield)
> >
> > I'm not sure that's the correct approach.
> > Any answer from the Andy Lutomirski?
> >
> > And in general to x86 maintainers, do we support all features on x86 32-bit? If
> > no, can it be said explicitly, please?
> 
> What compiler version are you using?

I guess it was gcc 11 and now gcc 12 (as of Debian unstable distro).

Currently
gcc (Debian 12.2.0-3) 12.2.0

-- 
With Best Regards,
Andy Shevchenko


