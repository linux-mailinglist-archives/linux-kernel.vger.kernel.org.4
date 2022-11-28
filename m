Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1C63A5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiK1KSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiK1KSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:18:40 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E11581E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669630714;
  x=1701166714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZRmmKT9hPJ3FjgvhBofLhSOwOm5PgMCnZ5vPFP+dbmk=;
  b=l6Ny5m4x65DZsZvv2u8AEznMmICEaj4rs6ixn47yPF8we4wORE9Mfd3y
   UADbBTAgpTsoZE+ifj4UGef/l2FG7jLbfKFFZ/ArUvBnqLs5UlTFZs0JU
   BMjsaVcO60v71x5OTq1y6xHb2t3Y0o/LMH7udzTJY1Z7QZd8ZirWAe7YR
   AW3bl9tIALlM3x+PzNxbBeWG3d4X0nmclqjZ6WWuH05vU96VSRM1ueU5o
   dJWPFcLTMBqpL6OkEW41Nxmz6caT9kyAJygq6mhXi1l6vdJ74V4gHBVpl
   43gEBYNDfNJEss04WpTs4Xua62vmP8PJ/2ZAnBX5VtXAoTcww0GQrCjAk
   Q==;
Date:   Mon, 28 Nov 2022 11:18:30 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kernel <kernel@axis.com>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: vdso: Include .eh_frame in debug ELF
Message-ID: <Y4SK9ruHqk3giWTW@axis.com>
References: <20221125103740.2062285-1-vincent.whitchurch@axis.com>
 <Y4C0ope66V+0DzYC@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4C0ope66V+0DzYC@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 01:27:14PM +0100, Szabolcs Nagy wrote:
> The 11/25/2022 11:37, Vincent Whitchurch wrote:
> > We currently strip out .eh_frame to work around crashes in libgcc when
> > it tries to unwind out of signal handlers, see commit 87676cfca141
> > ("arm64: vdso: Disable dwarf unwinding through the sigreturn
> > trampoline").
> > 
> > The .eh_frame does however have correct unwind information for the
> > functions implemented in C in vgettimeofday.c, but currently this
> > information is not available even for offline unwinding using the
> > vdso.so.dbg.  As a result of this, perf built with libdw is unable to
> > unwind the stack when the PC is inside one of these functions.
> > 
> > To fix this, strip the .eh_frame section only from the vdso.so and not
> > from the vdso.so.dbg.  This can be used by offline unwinders with access
> > to the debug symbols, and will not affect libgcc since the section will
> > still not be present in the normal vDSO.
> 
> adding eh_frame to vdso.so.dbg makes sense.
> 
> but if libdw correctly unwinds across a signal handler
> then libgcc should be able to do so too.

I have not tested if libdw can unwind across a signal handler.  It is
unlikely to work since all the CFI directives in __kernel_rt_sigreturn
are commented out. The CFI in .eh_frame only covers the C functions and
unwinding those works with libdw.

 $ aarch64-linux-gnu-objdump --dwarf=frames arch/arm64/kernel/vdso/vdso.so.dbg | grep pc
 00000014 000000000000001c 00000018 FDE cie=00000000 pc=0000000000000330..00000000000005cc
 00000034 0000000000000014 00000038 FDE cie=00000000 pc=00000000000005d0..0000000000000784
 0000004c 0000000000000018 00000050 FDE cie=00000000 pc=0000000000000784..00000000000007fc
 $ nm -n arch/arm64/kernel/vdso/vdso.so.dbg
 0000000000000330 T __kernel_clock_gettime
 00000000000005d0 T __kernel_gettimeofday
 0000000000000784 T __kernel_clock_getres
 0000000000000820 T __kernel_rt_sigreturn

> so maybe eh_frame should be added back to vdso.so just
> without frame info for __kernel_rt_sigreturn+NOP to
> ensure unwinders use heuristics for sigreturn.
> (i dont know if this was considered back when eh_frame
> was dropped from the vdso)

I don't know either why 87676cfca141 had to both remove the CFI
directives from __kernel_rt_sigreturn and remove the .eh_frame section
completely from vdso.so instead of only doing the former, but I assume
there was a good reason for that.
