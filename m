Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495A85BA04D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIORTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIORTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:19:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617182F95;
        Thu, 15 Sep 2022 10:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D18AE62598;
        Thu, 15 Sep 2022 17:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318DCC433C1;
        Thu, 15 Sep 2022 17:18:57 +0000 (UTC)
Date:   Thu, 15 Sep 2022 18:18:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adam Langley <agl@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Message-ID: <YyNefT72+OqkaPMS@arm.com>
References: <YwgCrqutxmX0W72r@gmail.com>
 <CAK8P3a3LnqdJ7bp+wjwUyb=7rQqL7W4nina-yQ5_Ff=XtaTr+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3LnqdJ7bp+wjwUyb=7rQqL7W4nina-yQ5_Ff=XtaTr+A@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(catching up with this thread)

On Fri, Aug 26, 2022 at 10:45:07AM +0200, Arnd Bergmann wrote:
> On Fri, Aug 26, 2022 at 1:15 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > For arm64, it's not clear to me whether the DIT flag is privileged or not.  If
> > privileged, I expect it would need to be set by the kernel just like the Intel
> > flag.  If unprivileged, I expect there will still be work to do in the kernel,
> > as the flag will need to be set when running any crypto code in the kernel.
> 
> 7206dc93a58f ("arm64: Expose Arm v8.4 features") added the feature bit for
> Armv8.4+ processors. From what I can tell from the documentation and the
> kernel source, I see:
> 
> - if the feature is set in HWCAP (or /proc/cpuinfo), then the instruction DIT
>   register is available in user space, and sensitive code can set or clear the
>   constant-time mode for the local thread.

Indeed, the arm64 DIT feature can be enabled in user space, subject to
checking the HWCAP bit or the CPUID regs (via kernel trapping and
emulation). The expectation was that some crypto routines would set it
on function entry, restore it on return but...

> - On CPUs without the feature (almost all ARMv8 ones), the register should
>   not betouched.

That's one of the drawbacks of using the features in user-space (the
instruction is not in the hint/nop space). It can be worked around with
ifunc resolvers but with a slight overhead on function calling.

> - The bit is context switched on kernel entry, so setting the bit in user space
>   does not change the behavior inside of a syscall
> - If we add a user space interface for setting the bit per thread on x86,
>   the same interface could be supported to set the bit on arm64 to save
>   user space implementations the trouble of checking the feature bits

A prctl() would do here but I think the default should be off or at
least allow a sysctl to control this. Enabling DIT could have a small
performance impact while lots of (most?) apps don't need such
guarantees.

For arm64, my preference is to have this option per-thread and even be
able to toggle it within a thread (not sure that's possible on x86
without a syscall).

Other random ideas of deploying this (for arm64): have an ELF annotation
that data independent timing is required. If that's on the main
executable, the kernel could turn it on for the app. If it's on a
(crypto) library, it's up to the dynamic loader to either turn it on for
the whole app or just use some function veneers to save/restore it when
the library code is executed.

I assume having this per-thread would work on x86 as well but I'm not
sure about the context switching cost.

> - the in-kernel crypto code does not set the bit today but could be easily
>   changed to do this for CPUs that support it, if we can decide on a policy
>   for when to enable or disable it.

In the kernel it's easier, at least for arm64, to enable it for specific
functions (we can do boot-time code patching).

Whichever way we support it, I'd rather not turn it on by default.
Talking to some of the Arm microarchitects, such feature may prevent
certain hardware optimisations.

-- 
Catalin
