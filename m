Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919636F4705
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjEBPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjEBPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:23:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9838DD7;
        Tue,  2 May 2023 08:23:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4879F221BC;
        Tue,  2 May 2023 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683041028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uxhui/Ir4eT5sPQEaZT+4zpzC7jhoc2yOtRKPtRVLuQ=;
        b=aq3JR34r8i83T70pqTkemzrSH10xQCplmij5pIQyD0YK8z+itGyO9k/Zvwi7Qf+IAKSBhy
        eo5tEqIAixUbBkkCE5eSv5dIFEOV+IPzcaBToFTE8efSam2JM1pCB6A8Hp2m1P1M7YFOvF
        iPQTkRjELszxauRKGj1883nDqmBx4G8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1DBAC2C141;
        Tue,  2 May 2023 15:23:46 +0000 (UTC)
Date:   Tue, 2 May 2023 17:23:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ian Rogers <irogers@google.com>, ravi.v.shankar@intel.com,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>, Andi Kleen <ak@linux.intel.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: cpu hotplug : was: Re: [PATCH v3] hardlockup: detect hard lockups
 using secondary (buddy) CPUs
Message-ID: <ZFEqynvf5nqkzEvQ@alley>
References: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-05-01 08:24:46, Douglas Anderson wrote:
> From: Colin Cross <ccross@android.com>
> 
> Implement a hardlockup detector that doesn't doesn't need any extra
> arch-specific support code to detect lockups. Instead of using
> something arch-specific we will use the buddy system, where each CPU
> watches out for another one. Specifically, each CPU will use its
> softlockup hrtimer to check that the next CPU is processing hrtimer
> interrupts by verifying that a counter is increasing.
> 
> --- /dev/null
> +++ b/kernel/watchdog_buddy_cpu.c
> +int watchdog_nmi_enable(unsigned int cpu)
> +{
> +	/*
> +	 * The new CPU will be marked online before the first hrtimer interrupt
> +	 * runs on it.

It does not need to be the first hrtimer interrupt. The CPU might have
been offlined/onlined repeatedly. The counter might have any value.

> +      * If another CPU tests for a hardlockup on the new CPU
> +	 * before it has run its first hrtimer, it will get a false positive.
> +	 * Touch the watchdog on the new CPU to delay the first check for at
> +	 * least 3 sampling periods to guarantee one hrtimer has run on the new
> +	 * CPU.
> +	 */
> +	per_cpu(watchdog_touch, cpu) = true;

We should touch also the next_cpu:

	/*
	 * We are going to check the next CPU. Our watchdog_hrtimer
	 * need not be zero if the CPU has already been online earlier.
	 * Touch the watchdog on the next CPU to avoid false positive
	 * if we try to check it in less then 3 interrupts.
	 */
	next_cpu = watchdog_next_cpu(cpu);
	if (next_cpu < nr_cpu_ids)
		per_cpu(watchdog_touch, next_cpu) = true;

Alternative would be to clear watchdog_hrtimer. But it would kind-of
affect also the softlockup detector.


> +	/* Match with smp_rmb() in watchdog_check_hardlockup() */
> +	smp_wmb();
> +	cpumask_set_cpu(cpu, &watchdog_cpus);
> +	return 0;
> +}
> +
> +void watchdog_nmi_disable(unsigned int cpu)
> +{
> +	unsigned int next_cpu = watchdog_next_cpu(cpu);
> +
> +	/*
> +	 * Offlining this CPU will cause the CPU before this one to start
> +	 * checking the one after this one. If this CPU just finished checking
> +	 * the next CPU and updating hrtimer_interrupts_saved, and then the
> +	 * previous CPU checks it within one sample period, it will trigger a
> +	 * false positive. Touch the watchdog on the next CPU to prevent it.
> +	 */
> +	if (next_cpu < nr_cpu_ids)
> +		per_cpu(watchdog_touch, next_cpu) = true;
> +	/* Match with smp_rmb() in watchdog_check_hardlockup() */
> +	smp_wmb();
> +	cpumask_clear_cpu(cpu, &watchdog_cpus);
> +}
> +

Best Regards,
Petr
