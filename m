Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031F16FEBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjEKGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEKGsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:48:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CA2B173A;
        Wed, 10 May 2023 23:48:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D98A0807A;
        Thu, 11 May 2023 06:48:40 +0000 (UTC)
Date:   Thu, 11 May 2023 09:48:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iopoll: Call cpu_relax() in busy loops
Message-ID: <20230511064839.GG14287@atomide.com>
References: <cover.1683722688.git.geert+renesas@glider.be>
 <fe235a1f65bb6c86d2afcdf52d85f80ae728dcc5.1683722688.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe235a1f65bb6c86d2afcdf52d85f80ae728dcc5.1683722688.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven <geert+renesas@glider.be> [230510 13:23]:
> It is considered good practice to call cpu_relax() in busy loops, see
> Documentation/process/volatile-considered-harmful.rst.  This can not
> only lower CPU power consumption or yield to a hyperthreaded twin
> processor, but also allows an architecture to mitigate hardware issues
> (e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
> architecture-specific cpu_relax() implementation.
> 
> In addition, cpu_relax() is also a compiler barrier.  It is not
> immediately obvious that the @op argument "function" will result in an
> actual function call (e.g. in case of inlining).
> 
> Where a function call is a C sequence point, this is lost on inlining.
> Therefore, with agressive enough optimization it might be possible for
> the compiler to hoist the:
> 
>         (val) = op(args);
> 
> "load" out of the loop because it doesn't see the value changing. The
> addition of cpu_relax() would inhibit this.
> 
> As the iopoll helpers lack calls to cpu_relax(), people are sometimes
> reluctant to use them, and may fall back to open-coded polling loops
> (including cpu_relax() calls) instead.
> 
> Fix this by adding calls to cpu_relax() to the iopoll helpers:
>   - For the non-atomic case, it is sufficient to call cpu_relax() in
>     case of a zero sleep-between-reads value, as a call to
>     usleep_range() is a safe barrier otherwise.  However, it doesn't
>     hurt to add the call regardless, for simplicity, and for similarity
>     with the atomic case below.
>   - For the atomic case, cpu_relax() must be called regardless of the
>     sleep-between-reads value, as there is no guarantee all
>     architecture-specific implementations of udelay() handle this.

Reviewed-by: Tony Lindgren <tony@atomide.com>
