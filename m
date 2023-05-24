Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84770F8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjEXOaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEXOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:30:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FAD132
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nc519PSu5SWSabTfI9++VrdsO+ErJ6GJg/mXPX8sTiY=; b=OLgIJNeGEIf7a6jVCmM2zaw4k9
        IbyTrT330wN0Muw33nS4mdJDVFueMoA7fm+BOYhEZU4NUCOUrKNqYRhTYEZK1Xscl+g/r36R1pR73
        Tss2+tZ8lourfOi+Kh4d4KUpJWO/66NoEQRq3s+YLpsNlbrPwqIQC4gx2CIDzH5963TnSBhRGr5eI
        ZbEHa2ZHJjrL9f8Zf7/kYjInnzFHCbVFByDSnRAvaMXm9n80IIcYyjt8PcrYrq7nX43G0QLMAujgg
        p9qC3z4Y3timz6Via63D19BI/C5yZ3q3YJnBk4wr/vHoGafeU2ny+CLIqTTKK4AWb9L54BGNR8j24
        JMFAFcjg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1pUx-00BHWF-TB; Wed, 24 May 2023 14:29:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F3F13002C5;
        Wed, 24 May 2023 16:29:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DFED2423AA01; Wed, 24 May 2023 16:29:54 +0200 (CEST)
Date:   Wed, 24 May 2023 16:29:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: xen_sched_clock+0x4a: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <20230524142954.GN4253@hirez.programming.kicks-ass.net>
References: <202305242215.M2ZKRxS0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305242215.M2ZKRxS0-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 10:22:42PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9d646009f65d62d32815f376465a3b92d8d9b046
> commit: 8739c6811572b087decd561f96382087402cc343 sched/clock/x86: Mark sched_clock() noinstr
> date:   4 months ago
> config: x86_64-randconfig-a002-20230524
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8739c6811572b087decd561f96382087402cc343
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8739c6811572b087decd561f96382087402cc343
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 olddefconfig
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305242215.M2ZKRxS0-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    vmlinux.o: warning: objtool: ibt_selftest+0x11: sibling call from callable instruction with modified stack frame
>    vmlinux.o: warning: objtool: __asan_memset+0x3b: call to __memset() with UACCESS enabled
>    vmlinux.o: warning: objtool: __asan_memmove+0x4d: call to __memmove() with UACCESS enabled
>    vmlinux.o: warning: objtool: __asan_memcpy+0x4d: call to __memcpy() with UACCESS enabled
> >> vmlinux.o: warning: objtool: xen_sched_clock+0x4a: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __rdgsbase_inactive+0x26: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __wrgsbase_inactive+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: fixup_bad_iret+0x7f: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: noist_exc_debug+0x45: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_nmi+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: poke_int3_handler+0x36: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: native_sched_clock+0x8c: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_check_crashing_cpu+0x30: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_start+0x6d: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: do_machine_check+0x57: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_machine_check+0x58: call to ftrace_likely_update() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: kvm_clock_read+0x3b: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: pvclock_clocksource_read_nowd+0x82: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_nmi_enter+0x53: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_nmi_exit+0x4b: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: enter_from_user_mode+0x38: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x38: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x38: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_exit+0x32: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ct_kernel_exit_state+0x27: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ct_kernel_enter_state+0x27: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ct_kernel_enter.constprop.0+0x2b: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ct_kernel_exit.constprop.0+0x49: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ct_idle_enter+0x18: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ct_nmi_enter+0x40: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ct_irq_enter+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ct_irq_exit+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mwait_idle+0x33: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0xfb: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x85: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: acpi_idle_enter+0x65: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: ibt_selftest+0x1e: return with modified stack frame

Robot folks; could you please discard all:

 ftrace_likey_update.*noinstr

warnings, they're -EWONTFIX.
