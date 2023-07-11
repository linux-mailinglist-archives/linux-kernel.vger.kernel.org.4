Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8F674F891
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGKTyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGKTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311CB10D2;
        Tue, 11 Jul 2023 12:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3C0B615E0;
        Tue, 11 Jul 2023 19:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D90C433C8;
        Tue, 11 Jul 2023 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689105290;
        bh=QD1kIvnVeFrYv8Gze2fLJLg0i/YqJFcXn0WrP/nZGg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xup7mWiwCHAi8aT6fbGucKKPxIBbP3jLmitcW/5X7SFIUjt4qsDbEuuYt8nC30oQu
         ZemjvWFcLm/15nnd8pyYP5UqbEvcVj/BXnrt2Qx13pyqCCc9SLIOtPvDnVQkH5k3o5
         cCTVu9Aa/FhbGfk42ZRYw0MTt+5TVPJxCZY+AAFE=
Date:   Tue, 11 Jul 2023 21:54:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, ndesaulniers@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] x86: kprobes: Fix CFI_CLANG related issues
Message-ID: <2023071139-engorge-catchable-70fa@gregkh>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
 <20230710155703.GA4021842@dev-arch.thelio-3990X>
 <20230711103303.287af608cc47dcf70d709070@kernel.org>
 <20230711183704.GA2758126@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711183704.GA2758126@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:37:04AM -0700, Nathan Chancellor wrote:
> Masami, thanks for verifying!
> 
> Hi Greg and Sasha,
> 
> On Tue, Jul 11, 2023 at 10:33:03AM +0900, Masami Hiramatsu wrote:
> > On Mon, 10 Jul 2023 08:57:03 -0700
> > Nathan Chancellor <nathan@kernel.org> wrote:
> > 
> > > On Mon, Jul 10, 2023 at 09:14:13PM +0900, Masami Hiramatsu (Google) wrote:
> > > > I just build tested, since I could not boot the kernel with CFI_CLANG=y.
> > > > Would anyone know something about this error?
> > > > 
> > > > [    0.141030] MMIO Stale Data: Unknown: No mitigations
> > > > [    0.153511] SMP alternatives: Using kCFI
> > > > [    0.164593] Freeing SMP alternatives memory: 36K
> > > > [    0.165053] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x472/0x48b
> > > > [    0.166028] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.2-00002-g12b1b2fca8ef #126
> > > > [    0.166028] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> > > > [    0.166028] Call Trace:
> > > > [    0.166028]  <TASK>
> > > > [    0.166028]  dump_stack_lvl+0x6e/0xb0
> > > > [    0.166028]  panic+0x146/0x2f0
> > > > [    0.166028]  ? start_kernel+0x472/0x48b
> > > > [    0.166028]  __stack_chk_fail+0x14/0x20
> > > > [    0.166028]  start_kernel+0x472/0x48b
> > > > [    0.166028]  x86_64_start_reservations+0x24/0x30
> > > > [    0.166028]  x86_64_start_kernel+0xa6/0xbb
> > > > [    0.166028]  secondary_startup_64_no_verify+0x106/0x11b
> > > > [    0.166028]  </TASK>
> > > > [    0.166028] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x472/0x48b ]---
> > > 
> > > This looks like https://github.com/ClangBuiltLinux/linux/issues/1815 to
> > > me. What version of LLVM are you using? This was fixed in 16.0.4. Commit
> > > 514ca14ed544 ("start_kernel: Add __no_stack_protector function
> > > attribute") should resolve it on the Linux side, it looks like that is
> > > in 6.5-rc1. Not sure if we should backport it or just let people upgrade
> > > their toolchains on older releases.
> > 
> > Thanks for the info. I confirmed that the commit fixed the boot issue.
> > So I think it should be backported to the stable tree.
> 
> Would you please apply commit 514ca14ed544 ("start_kernel: Add
> __no_stack_protector function attribute") to linux-6.4.y? The series
> ending with commit 611d4c716db0 ("x86/hyperv: Mark hv_ghcb_terminate()
> as noreturn") that shipped in 6.4 exposes an LLVM issue that affected
> 16.0.0 and 16.0.1, which was resolved in 16.0.2. When using those
> affected LLVM releases, the following crash at boot occurs:
> 
>   [    0.181667] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x3cf/0x3d0
>   [    0.182621] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.3 #1
>   [    0.182621] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>   [    0.182621] Call Trace:
>   [    0.182621]  <TASK>
>   [    0.182621]  dump_stack_lvl+0x6a/0xa0
>   [    0.182621]  panic+0x124/0x2f0
>   [    0.182621]  ? start_kernel+0x3cf/0x3d0
>   [    0.182621]  ? acpi_enable+0x64/0xc0
>   [    0.182621]  __stack_chk_fail+0x14/0x20
>   [    0.182621]  start_kernel+0x3cf/0x3d0
>   [    0.182621]  x86_64_start_reservations+0x24/0x30
>   [    0.182621]  x86_64_start_kernel+0xab/0xb0
>   [    0.182621]  secondary_startup_64_no_verify+0x107/0x10b
>   [    0.182621]  </TASK>
>   [    0.182621] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x3cf/0x3d0 ]---
> 
> 514ca14ed544 aims to avoid this on the Linux side. I have verified that
> it applies to 6.4.3 cleanly and resolves the issue there, as has Masami.
> 
> If there are any issues or questions, please let me know.

Now queued up, thanks.

greg k-h
