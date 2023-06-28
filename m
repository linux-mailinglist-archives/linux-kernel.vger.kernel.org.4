Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE8C74103D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjF1Lmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:42:51 -0400
Received: from foss.arm.com ([217.140.110.172]:54076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231578AbjF1Lmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:42:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84BC9C14;
        Wed, 28 Jun 2023 04:43:21 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.29.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EED83F663;
        Wed, 28 Jun 2023 04:42:35 -0700 (PDT)
Date:   Wed, 28 Jun 2023 12:42:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 04/27] locking/atomic: make atomic*_{cmp,}xchg optional
Message-ID: <ZJwcqCLlKcCWmlDF@FVFF77S0Q05N>
References: <20230605070124.3741859-1-mark.rutland@arm.com>
 <20230605070124.3741859-5-mark.rutland@arm.com>
 <32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:07:07AM -0700, Guenter Roeck wrote:
> Hi,

Hi Guenter,

> On Mon, Jun 05, 2023 at 08:01:01AM +0100, Mark Rutland wrote:
> > Most architectures define the atomic/atomic64 xchg and cmpxchg
> > operations in terms of arch_xchg and arch_cmpxchg respectfully.
> > 
> > Add fallbacks for these cases and remove the trivial cases from arch
> > code. On some architectures the existing definitions are kept as these
> > are used to build other arch_atomic*() operations.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
> 
> This patch results in:
> 
> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
> 
> when trying to build sparc64:allmodconfig.

Hmm... it seems that in that configuration, the compiler decides to place
__arch_xchg() out-of-line, and hence can't remove the call to
__xchg_called_with_bad_pointer() via dead code elimination.

So this is due to tickling the compiler into making a different inlining
decision rather than due to a semantic issue in the patch.

Marking __arch_xchg() as __always_inline solves that in local testing, and we
should do likewise for the other bits used under the arch_ atomics.

I'll try to spin a patch for that soon, unless someone beats me to it.

Thanks,
Mark.

> 
> Guenter
> 
> ---
> bisect log:
> 
> # bad: [60e7c4a25da68cd826719b685babbd23e73b85b0] Add linux-next specific files for 20230626
> # good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
> git bisect start 'HEAD' 'v6.4-rc7'
> # good: [1fc7b1b3c9c3211898874f51919fcb1cf6f1cc79] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect good 1fc7b1b3c9c3211898874f51919fcb1cf6f1cc79
> # good: [4fce1fc9cf89412590fb681fa480cde0b23b3381] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
> git bisect good 4fce1fc9cf89412590fb681fa480cde0b23b3381
> # bad: [cf1a0283badf6d0bfb91876583c24ef535a3c04c] Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> git bisect bad cf1a0283badf6d0bfb91876583c24ef535a3c04c
> # bad: [3c5388e722ea98022b4d557ab33acca2eb16c4f0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> git bisect bad 3c5388e722ea98022b4d557ab33acca2eb16c4f0
> # good: [997730bdbf14f352ab03e42461f500aafdabc03e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> git bisect good 997730bdbf14f352ab03e42461f500aafdabc03e
> # bad: [6fd8266556af196763b9f876ed682873e605469b] Merge branch into tip/master: 'ras/core'
> git bisect bad 6fd8266556af196763b9f876ed682873e605469b
> # good: [37380ea71463658934c2d3167d559d4034ea1c5b] Merge branch into tip/master: 'irq/core'
> git bisect good 37380ea71463658934c2d3167d559d4034ea1c5b
> # bad: [a967852939f864c35f155a2f431292ad6fc3fed9] Merge branch into tip/master: 'locking/core'
> git bisect bad a967852939f864c35f155a2f431292ad6fc3fed9
> # bad: [e50f06ce2d876c740993b5e3d01e203520391ccd] locking/atomic: m68k: add preprocessor symbols
> git bisect bad e50f06ce2d876c740993b5e3d01e203520391ccd
> # good: [b1fe7f2cda2a003afe316ce8dfe8d3645694a67e] x86,intel_iommu: Replace cmpxchg_double()
> git bisect good b1fe7f2cda2a003afe316ce8dfe8d3645694a67e
> # good: [14d72d4b6f0e88b5f683c1a5b7a876a55055852d] locking/atomic: remove fallback comments
> git bisect good 14d72d4b6f0e88b5f683c1a5b7a876a55055852d
> # bad: [f739287ef57bc01155e556033462e9a6ff020c97] locking/atomic: arc: add preprocessor symbols
> git bisect bad f739287ef57bc01155e556033462e9a6ff020c97
> # bad: [d12157efc8e083c77d054675fcdd594f54cc7e2b] locking/atomic: make atomic*_{cmp,}xchg optional
> git bisect bad d12157efc8e083c77d054675fcdd594f54cc7e2b
> # good: [a7bafa7969da1c0e9c342c792d8224078d1c491c] locking/atomic: hexagon: remove redundant arch_atomic_cmpxchg
> git bisect good a7bafa7969da1c0e9c342c792d8224078d1c491c
> # first bad commit: [d12157efc8e083c77d054675fcdd594f54cc7e2b] locking/atomic: make atomic*_{cmp,}xchg optional
> 
