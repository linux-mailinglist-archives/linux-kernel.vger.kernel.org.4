Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6385EF75B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiI2OU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiI2OUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:20:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9739127
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664461221; x=1695997221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwVnlaUDqM4s3xZfOLfuk/eDmUhfdgVjnMrKt81F2UI=;
  b=Nl8vlGt3zyH0/XgyBszL2UyFCBTpXtaFKHNUBgG/3G0oB5jaZQdK9lVb
   ZAyE/t2lWMkAn5voHuM6Fo8jsisF6V2/uOZ/G4CEoMaFR5Xcf429dsJ7F
   4pxTfadnWWnxiQsabgrwucvQR1LtHZKTL14JnrQUah3g80tMYIiPYCvvN
   FQwzg9L3KQHZI3HjU+0oVtMEWKuQ3u3QZ+ToJnwj79ZaHzEajMnzNAPUU
   VABmKvKn7rvaXttHgqGyc/hWSPjIR2tjGN6sqEsnysdMXie+Dn3z0fAWB
   71k7CfxtLIF3atdEuQJlXf/FpaPQfFVz7/Lpo0YE38EJONhtCq7BQBQqE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="388187920"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="388187920"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 07:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="655569084"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="655569084"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Sep 2022 07:20:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oduOf-009Qcr-1r;
        Thu, 29 Sep 2022 17:20:17 +0300
Date:   Thu, 29 Sep 2022 17:20:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ferry Toth <fntoth@gmail.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brian Gerst <brgerst@gmail.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
Message-ID: <YzWpob6MOf1SJr5I@smile.fi.intel.com>
References: <cover.1613243844.git.luto@kernel.org>
 <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
 <YzWj9zjTJI3RCDf2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzWj9zjTJI3RCDf2@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 04:56:07PM +0300, Andy Shevchenko wrote:
> +Cc: Ferry
> 
> On Sat, Feb 13, 2021 at 11:19:44AM -0800, Andy Lutomirski wrote:
> > On 32-bit kernels, the stackprotector canary is quite nasty -- it is
> > stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
> > percpu storage.  It's even nastier because it means that whether %gs
> > contains userspace state or kernel state while running kernel code
> > depends on whether stackprotector is enabled (this is
> > CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
> > that segment selectors work.  Supporting both variants is a
> > maintenance and testing mess.
> > 
> > Merely rearranging so that percpu and the stack canary
> > share the same segment would be messy as the 32-bit percpu address
> > layout isn't currently compatible with putting a variable at a fixed
> > offset.
> > 
> > Fortunately, GCC 8.1 added options that allow the stack canary to be
> > accessed as %fs:__stack_chk_guard, effectively turning it into an ordinary
> > percpu variable.  This lets us get rid of all of the code to manage the
> > stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
> > 
> > (That name is special.  We could use any symbol we want for the
> >  %fs-relative mode, but for CONFIG_SMP=n, gcc refuses to let us use any
> >  name other than __stack_chk_guard.)
> > 
> > This patch forcibly disables stackprotector on older compilers that
> > don't support the new options and makes the stack canary into a
> > percpu variable.  The "lazy GS" approach is now used for all 32-bit
> > configurations.
> > 
> > This patch also makes load_gs_index() work on 32-bit kernels.  On
> > 64-bit kernels, it loads the GS selector and updates the user
> > GSBASE accordingly.  (This is unchanged.)  On 32-bit kernels,
> > it loads the GS selector and updates GSBASE, which is now
> > always the user base.  This means that the overall effect is
> > the same on 32-bit and 64-bit, which avoids some ifdeffery.
> 
> This patch broke 32-bit boot on Intel Merrifield
> 
> git bisect start
> # good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
> git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
> # bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> git bisect bad 62fb9874f5da54fdb243003b386128037319b219
> # bad: [85f3f17b5db2dd9f8a094a0ddc665555135afd22] Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.13
> git bisect bad 85f3f17b5db2dd9f8a094a0ddc665555135afd22
> # good: [ca62e9090d229926f43f20291bb44d67897baab7] Merge tag 'regulator-v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
> git bisect good ca62e9090d229926f43f20291bb44d67897baab7
> # bad: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag 'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
> git bisect bad 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
> # good: [49c70ece54b0d1c51bc31b2b0c1070777c992c26] drm/amd/display: Change input parameter for set_drr
> git bisect good 49c70ece54b0d1c51bc31b2b0c1070777c992c26
> # good: [0b276e470a4d43e1365d3eb53c608a3d208cabd4] media: coda: fix macroblocks count control usage
> git bisect good 0b276e470a4d43e1365d3eb53c608a3d208cabd4
> # bad: [c6536676c7fe3f572ba55842e59c3c71c01e7fb3] Merge tag 'x86_core_for_v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad c6536676c7fe3f572ba55842e59c3c71c01e7fb3
> # good: [d1466bc583a81830cef2399a4b8a514398351b40] Merge branch 'work.inode-type-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect good d1466bc583a81830cef2399a4b8a514398351b40
> # good: [fafe1e39ed213221c0bce6b0b31669334368dc97] Merge tag 'afs-netfs-lib-20210426' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
> git bisect good fafe1e39ed213221c0bce6b0b31669334368dc97
> # bad: [b1f480bc0686e65d5413c035bd13af2ea4888784] Merge branch 'x86/cpu' into WIP.x86/core, to merge the NOP changes & resolve a semantic conflict
> git bisect bad b1f480bc0686e65d5413c035bd13af2ea4888784
> # bad: [0c925c61dae18ee3cb93a61cc9dd9562a066034d] x86/tools/insn_decoder_test: Convert to insn_decode()
> git bisect bad 0c925c61dae18ee3cb93a61cc9dd9562a066034d
> # bad: [514ef77607b9ff184c11b88e8f100bc27f07460d] x86/boot/compressed/sev-es: Convert to insn_decode()
> git bisect bad 514ef77607b9ff184c11b88e8f100bc27f07460d
> # bad: [9e761296c52dcdb1aaa151b65bd39accb05740d9] x86/insn: Rename insn_decode() to insn_decode_from_regs()
> git bisect bad 9e761296c52dcdb1aaa151b65bd39accb05740d9
> # bad: [d0962f2b24c99889a386f0658c71535f56358f77] x86/entry/32: Remove leftover macros after stackprotector cleanups
> git bisect bad d0962f2b24c99889a386f0658c71535f56358f77
> # bad: [3fb0fdb3bbe7aed495109b3296b06c2409734023] x86/stackprotector/32: Make the canary into a regular percpu variable
> git bisect bad 3fb0fdb3bbe7aed495109b3296b06c2409734023
> # first bad commit: [3fb0fdb3bbe7aed495109b3296b06c2409734023] x86/stackprotector/32: Make the canary into a regular percpu variable
> 
> Any suggestions how to fix are welcome!
> 
> Configuration is based on in-tree i386_defconfig with some drivers enabled
> on top (no core stuff was altered, but if you wish to check, it's here:
> https://github.com/andy-shev/linux/blob/eds-acpi/arch/x86/configs/i386_defconfig).

For the record (and preventing some questions) the v6.0-rc7 still has this issue.

I can't test reverts, because it's huge pile of changes in that area happened
for the last year or so.

-- 
With Best Regards,
Andy Shevchenko


