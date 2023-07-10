Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917E674DA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjGJP5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGJP5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F08CA;
        Mon, 10 Jul 2023 08:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E17D86108F;
        Mon, 10 Jul 2023 15:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88298C433C7;
        Mon, 10 Jul 2023 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689004626;
        bh=cjUuxk+1R+kE/sabu0x+hlim8jDG+lWBNIP3U+KRE90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHeHMfqfjS84xZahsak2u7jiavteo+asrstiqP0Augi1U2xA4JM2wADU3/C/Su7O7
         c27Oow1qgRHJbZBjdGd/1gW2i+RWs42ovixJD4beYM4oijG3q1JeQXOC9Q+7sMlHX3
         l3akdQ9KiPQkFCKzkw13qC4s4oPM8OhwhjWoNeE1zvz//QzpMytC9tYxT0Ixs9bo3u
         vAwJ6+CTJ/7TPTbzSoz2gPVwPYi6FLP+zTxz+dI9M28deShT0MlMyMnnzvO+pTHsX2
         MtezhKM7Q/8K5uCwH4OBfLW8kRofpX1Ng5l6+IYB7xxoxndPEhXQjiUsW2ezTGzeQS
         Ts0Wpe671LGxw==
Date:   Mon, 10 Jul 2023 08:57:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, ndesaulniers@google.com
Subject: Re: [RFC PATCH 0/2] x86: kprobes: Fix CFI_CLANG related issues
Message-ID: <20230710155703.GA4021842@dev-arch.thelio-3990X>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168899125356.80889.17967397360941194229.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 09:14:13PM +0900, Masami Hiramatsu (Google) wrote:
> I just build tested, since I could not boot the kernel with CFI_CLANG=y.
> Would anyone know something about this error?
> 
> [    0.141030] MMIO Stale Data: Unknown: No mitigations
> [    0.153511] SMP alternatives: Using kCFI
> [    0.164593] Freeing SMP alternatives memory: 36K
> [    0.165053] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x472/0x48b
> [    0.166028] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.2-00002-g12b1b2fca8ef #126
> [    0.166028] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [    0.166028] Call Trace:
> [    0.166028]  <TASK>
> [    0.166028]  dump_stack_lvl+0x6e/0xb0
> [    0.166028]  panic+0x146/0x2f0
> [    0.166028]  ? start_kernel+0x472/0x48b
> [    0.166028]  __stack_chk_fail+0x14/0x20
> [    0.166028]  start_kernel+0x472/0x48b
> [    0.166028]  x86_64_start_reservations+0x24/0x30
> [    0.166028]  x86_64_start_kernel+0xa6/0xbb
> [    0.166028]  secondary_startup_64_no_verify+0x106/0x11b
> [    0.166028]  </TASK>
> [    0.166028] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x472/0x48b ]---

This looks like https://github.com/ClangBuiltLinux/linux/issues/1815 to
me. What version of LLVM are you using? This was fixed in 16.0.4. Commit
514ca14ed544 ("start_kernel: Add __no_stack_protector function
attribute") should resolve it on the Linux side, it looks like that is
in 6.5-rc1. Not sure if we should backport it or just let people upgrade
their toolchains on older releases.

Cheers,
Nathan
