Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272936EB5FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 02:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjDVAAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 20:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjDUX7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:59:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8A212D;
        Fri, 21 Apr 2023 16:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wT7haPhVSoi15WlZuxldv/S7DXyNS9NkPBcv78cvTg4=; b=tQ/7kO5WGRK8mh5K/22TizxJCE
        8dl7RmFvZc6P0qnJMdMfT7j0HwqFG0khdt0z8RLU/vItY9MnPEY1HMUFr66kZaVUJlVIQhFFmS51k
        YPPvqQJtiFKbbePl3USkjZD65yB8SSl4N5Xf4S1Gc5/o2e1DRJwrpu6gyoB+frIzeXrahETRf9Uwg
        B8nTlhwW4PyMwhHt+sP/mRCKLNFJX8J0/u/mFxhcRG/r03gafiEjnyvSQ3MHEScTdxtYhZJNIavSW
        XGWmAcbjfdJstkqFbPRCH7vsY5EmQMJHELXlVI+rkH54u/LI45pARRBWcVVg+tva1IpoBiH3e4s7e
        SekzjI7w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pq0f4-00C71y-2G;
        Fri, 21 Apr 2023 23:59:31 +0000
Message-ID: <d54fe26d-0f11-e422-d5f3-841c663b9d6f@infradead.org>
Date:   Fri, 21 Apr 2023 16:59:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] hardlockup: detect hard lockups using secondary (buddy)
 cpus
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Will Deacon <will@kernel.org>, ito-yuichi@fujitsu.com,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Marco Elver <elver@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/21/23 15:53, Douglas Anderson wrote:
> From: Colin Cross <ccross@android.com>
> 
> Implement a hardlockup detector that can be enabled on SMP systems
> that don't have an arch provided one or one implemented atop perf by

Is that                            one or more
?

> using interrupts on other cpus. Each cpu will use its softlockup
> hrtimer to check that the next cpu is processing hrtimer interrupts by
> verifying that a counter is increasing.
> 
> NOTE: unlike the other hard lockup detectors, the buddy one can't
> easily provide a backtrace on the CPU that locked up. It relies on
> some other mechanism in the system to get information about the locked
> up CPUs. This could be support for NMI backtraces like [1], it could
> be a mechanism for printing the PC of locked CPUs like [2], or it
> could be something else.
> 
> This style of hardlockup detector originated in some downstream
> Android trees and has been rebased on / carried in ChromeOS trees for
> quite a long time for use on arm and arm64 boards. Historically on
> these boards we've leveraged mechanism [2] to get information about
> hung CPUs, but we could move to [1].
> 
> NOTE: the buddy system is not really useful to enable on any
> architectures that have a better mechanism. On arm64 folks have been
> trying to get a better mechanism for years and there has even been
> recent posts of patches adding support [3]. However, nothing about the
> buddy system is tied to arm64 and several archs (even arm32, where it
> was originally developed) could find it useful.
> 
> [1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.org
> [2] https://issuetracker.google.com/172213129
> [3] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecopzer.chen@mediatek.com/
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch has been rebased in ChromeOS kernel trees many times, and
> each time someone had to do work on it they added their
> Signed-off-by. I've included those here. I've also left the author as
> Colin Cross since the core code is still his.
> 
> I'll also note that the CC list is pretty giant, but that's what
> get_maintainers came up with (plus a few other folks I thought would
> be interested). As far as I can tell, there's no true MAINTAINER
> listed for the existing watchdog code. Assuming people don't hate
> this, maybe it would go through Andrew Morton's tree?
> 
>  include/linux/nmi.h         |  18 ++++-
>  kernel/Makefile             |   1 +
>  kernel/watchdog.c           |  24 ++++--
>  kernel/watchdog_buddy_cpu.c | 141 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug           |  19 ++++-
>  5 files changed, 192 insertions(+), 11 deletions(-)
>  create mode 100644 kernel/watchdog_buddy_cpu.c
> 

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 39d1d93164bd..9eb86bc9f5ee 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1036,6 +1036,9 @@ config HARDLOCKUP_DETECTOR_PERF
>  config HARDLOCKUP_CHECK_TIMESTAMP
>  	bool
>  
> +config HARDLOCKUP_DETECTOR_CORE
> +	bool
> +
>  #
>  # arch/ can define HAVE_HARDLOCKUP_DETECTOR_ARCH to provide their own hard
>  # lockup detector rather than the perf based detector.
> @@ -1045,6 +1048,7 @@ config HARDLOCKUP_DETECTOR
>  	depends on DEBUG_KERNEL && !S390
>  	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_ARCH
>  	select LOCKUP_DETECTOR
> +	select HARDLOCKUP_DETECTOR_CORE
>  	select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF
>  	help
>  	  Say Y here to enable the kernel to act as a watchdog to detect
> @@ -1055,9 +1059,22 @@ config HARDLOCKUP_DETECTOR
>  	  chance to run.  The current stack trace is displayed upon detection
>  	  and the system will stay locked up.
>  
> +config HARDLOCKUP_DETECTOR_BUDDY_CPU
> +	bool "Buddy CPU hardlockup detector"
> +	depends on DEBUG_KERNEL && SMP
> +	depends on !HARDLOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
> +	depends on !S390
> +	select HARDLOCKUP_DETECTOR_CORE
> +	select SOFTLOCKUP_DETECTOR
> +	help
> +	  Say Y here to enable a hardlockup detector where CPUs check
> +	  each other for lockup. Each cpu uses its softlockup hrtimer

Preferably                            CPU

> +	  to check that the next cpu is processing hrtimer interrupts by

and                              CPU

> +	  verifying that a counter is increasing.
> +
>  config BOOTPARAM_HARDLOCKUP_PANIC
>  	bool "Panic (Reboot) On Hard Lockups"
> -	depends on HARDLOCKUP_DETECTOR
> +	depends on HARDLOCKUP_DETECTOR_CORE
>  	help
>  	  Say Y here to enable the kernel to panic on "hard lockups",
>  	  which are bugs that cause the kernel to loop in kernel

-- 
~Randy
