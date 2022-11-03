Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF31618B41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiKCWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKCWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:19:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F511C16
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:19:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N3J7j4yHJz4x1G;
        Fri,  4 Nov 2022 09:18:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1667513939;
        bh=VR6Mm9ZHp7WtU2Fa2nUanqpeKXo980HrZ6AWhIqgPP8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R7HTBz4l7NOogMvdkkYnluPBOStvtLJb5Kjm54ZcVKtSUxohHMPydfXwVamBQvux+
         kWILI3eGk8inAfxlkK3Zuy4GCckJRcN19RV87u19RkO3cWYbWn4WXdFYoQULPYr97d
         3OiqJodFQ6p33NpSw1vnbbYntsT/lRnq/sMbdV0kaE90G1WUJevDYm4trxn/WCQaYV
         G+kbYmjjidV2kxWM707p1x0Vlcf1tbkKuHgSCjSma6s9d8+VnJxF9/NJFyqiNzychW
         n9ETDtlJQCjWuDRSMrXcrJ88soYBZhH7nbRfSNSo1p7mg8R+Vto6z7eNE+CtxAH9ze
         Q1TRR9azQ7HJw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        schwab@linux-m68k.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, guoren@kernel.org, arnd@arndb.de
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-4 tag
In-Reply-To: <CAHk-=wh87aGtg3eJPkA31V0Pn22hah0DWRc8oWsQ__5P2SXaTw@mail.gmail.com>
References: <87o7tossaa.fsf@mpe.ellerman.id.au>
 <CAHk-=wh87aGtg3eJPkA31V0Pn22hah0DWRc8oWsQ__5P2SXaTw@mail.gmail.com>
Date:   Fri, 04 Nov 2022 09:18:54 +1100
Message-ID: <87iljvsmup.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Wed, Nov 2, 2022 at 7:09 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>>  - Fix an endian thinko in the asm-generic compat_arg_u64() which led to syscall arguments
>>    being swapped for some compat syscalls.
>
> Am I mis-reading this, or did this bug (introduced in this merge
> window by commit 43d5de2b67d7 "asm-generic: compat: Support BE for
> long long args in 32-bit ABIs") break *every* architecture?

No. Just RISC-V and powerpc.

> And people just didn't scream, because 32-bit code has just become so rare?

I had two systems and several VMs that booted happily with the bug
present, so there's some luck involved as to whether your userspace
trips over the bug in a way that matters.

But we did have people scream eventually :/

> Or is it just because those compat macros are effectively not used
> elsewhere, and x86 has its own versions? Looks like possibly mainly
> RISC-V?

Yeah. Although compat_arg_u64() is defined for all arches, it's only
used in places guarded by __ARCH_WANT_COMPAT_FOO macros, and those are
only selected by RISC-V and powerpc.

Full list is:

  __ARCH_WANT_COMPAT_FADVISE64_64       riscv
  __ARCH_WANT_COMPAT_FALLOCATE          riscv, powerpc
  __ARCH_WANT_COMPAT_FTRUNCATE64        riscv
  __ARCH_WANT_COMPAT_PREAD64            riscv
  __ARCH_WANT_COMPAT_PWRITE64           riscv
  __ARCH_WANT_COMPAT_READAHEAD          riscv
  __ARCH_WANT_COMPAT_SYNC_FILE_RANGE    riscv
  __ARCH_WANT_COMPAT_TRUNCATE64         riscv


> Side note: why is it doing
>
>         #ifndef compat_arg_u64
>
> at all? That macro is not actually defined anywhere else, so that
> #ifdef seems to be just confused.

That goes back to the original submission:

  59c10c52f573 ("riscv: compat: syscall: Add compat_sys_call_table implementation")

I guess it was following the example in asm-generic/compat.h where a
bunch of other things are guarded by ifndefs. But agree it's
unnecessarily flexible in this case until we have another definition.

cheers
