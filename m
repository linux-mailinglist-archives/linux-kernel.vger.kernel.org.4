Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4656F21AD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbjD2AgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347130AbjD2AgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:36:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394064232;
        Fri, 28 Apr 2023 17:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/Amx0qPanX05nBJv5epCbcwnXgDtZvJnLUx29Ybm7qI=; b=lyXhAFVQVRguE02Q1e9i6NPyIP
        BM365gOgviI255XwEzHfBqgUVTueSrkYwxzRRJi7sx898rViQz+LgdkBLmVlvlxC9/8J1u3psIvbK
        SVSOkZI67EXjhVbf+nDteXrfDKbqtC90Op2niz72kPhXgMAsfE9I1eUbrD19e4VS1e2BjHmQxFCL/
        sgBydIAMKLWl5tZMez3xbuRgRIKskGQj4g5WPmWBjPm3rSntYpsTLuWoTtp2aXqP0mZ+5XlfBK1hD
        7FvYQh0KDZzidM+nSNQnzhoO+UqXOGXhYtCbIBfWSsHNX6yFBd6Qo04cP+HxRuk0RQX2DgBMuRdZu
        gZhEFJBg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psYYz-00C0DK-0B;
        Sat, 29 Apr 2023 00:35:45 +0000
Message-ID: <217e697c-ad13-96ca-3829-a046469fd86a@infradead.org>
Date:   Fri, 28 Apr 2023 17:35:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] hardlockup: detect hard lockups using secondary
 (buddy) CPUs
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-perf-users@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        ravi.v.shankar@intel.com, Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Ian Rogers <irogers@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Gow <davidgow@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230428163507.v2.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230428163507.v2.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/28/23 16:37, Douglas Anderson wrote:
> From: Colin Cross <ccross@android.com>
> 
> Implement a hardlockup detector that doesn't doesn't need any extra
> arch-specific support code to detect lockups. Instead of using
> something arch-specific we will use the buddy system, where each CPU
> watches out for another one. Specifically, each CPU will use its
> softlockup hrtimer to check that the next CPU is processing hrtimer
> interrupts by verifying that a counter is increasing.
> 
> NOTE: unlike the other hard lockup detectors, the buddy one can't
> easily show what's happening on the CPU that locked up just by doing a
> simple backtrace. It relies on some other mechanism in the system to
> get information about the locked up CPUs. This could be support for
> NMI backtraces like [1], it could be a mechanism for printing the PC
> of locked CPUs at panic time like [2] / [3], or it could be something
> else. Even though that means we still rely on arch-specific code, this
> arch-specific code seems to often be implemented even on architectures
> that don't have a hardlockup detector.
> 
> This style of hardlockup detector originated in some downstream
> Android trees and has been rebased on / carried in ChromeOS trees for
> quite a long time for use on arm and arm64 boards. Historically on
> these boards we've leveraged mechanism [2] / [3] to get information
> about hung CPUs, but we could move to [1].
> 
> Although the original motivation for the buddy system was for use on
> systems without an arch-specific hardlockup detector, it can still be
> useful to use even on systems that _do_ have an arch-specific
> hardlockup detector. On x86, for instance, there is a 24-part patch
> series [4] in progress switching the arch-specific hard lockup
> detector from a scarce perf counter to a less-scarce hardware
> resource. Potentially the buddy system could be a simpler alternative
> to free up the perf counter but still get hard lockup detection.
> 
> Overall, pros (+) and cons (-) of the buddy system compared to an
> arch-specific hardlockup detector:
> + Usable on systems that don't have an arch-specific hardlockup
>   detector, like arm32 and arm64 (though it's being worked on for
>   arm64 [5]).
> + May free up scarce hardware resources.
> + If a CPU totally goes out to lunch (can't process NMIs) the buddy
>   system could still detect the problem (though it would be unlikely
>   to be able to get a stack trace).
> - If all CPUs are hard locked up at the same time the buddy system
>   can't detect it.
> - If we don't have SMP we can't use the buddy system.
> - The buddy system needs an arch-specific mechanism (possibly NMI
>   backtrace) to get info about the locked up CPU.
> 
> [1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.org
> [2] https://issuetracker.google.com/172213129
> [3] https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
> [4] https://lore.kernel.org/lkml/20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com/
> [5] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecopzer.chen@mediatek.com/
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
> Changes in v2:
> - cpu => CPU.
> - Reworked description and Kconfig based on v1 discussion.

or at least some of the comments from v1. :(

> - No code changes
> 
>  include/linux/nmi.h         |  18 ++++-
>  kernel/Makefile             |   1 +
>  kernel/watchdog.c           |  24 ++++--
>  kernel/watchdog_buddy_cpu.c | 141 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug           |  23 +++++-
>  5 files changed, 196 insertions(+), 11 deletions(-)
>  create mode 100644 kernel/watchdog_buddy_cpu.c
> 

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 39d1d93164bd..511eb14660b1 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug

> @@ -1055,9 +1059,26 @@ config HARDLOCKUP_DETECTOR
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

Be consistent in the use of "CPU". Change 2 occurrences of "cpu"
below to "CPU".

> +	  each other for lockup. Each cpu uses its softlockup hrtimer
> +	  to check that the next cpu is processing hrtimer interrupts by
> +	  verifying that a counter is increasing.
> +
> +	  This hardlockup detector is useful on systems that don't have
> +	  an arch-specific hardlockup detector or if resources needed
> +	  for the hardlockup detector are better used for other things.


-- 
~Randy
