Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9605770DBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjEWLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjEWLps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:45:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4A4FE;
        Tue, 23 May 2023 04:45:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1B63120540;
        Tue, 23 May 2023 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684842345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwznIrELPYLWwydAYNIqJzHwi6mbsjXfEygWrt5kgFg=;
        b=twQpZTwUAduFDvyrn/btduKthKphe6tUYKcM13EM9uQJnnGbA+/tzOdgNDG3JmL4BjSByc
        n4a8Ke1XYcAI2/M3x+kl4ijn9ob2921LsYwVdvz+1/kST+5Z4rr0578WynqlcrOsM335MR
        oM5DqKg8Dbes0acQZ55Wc7n8a3+jfXw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C81E62C141;
        Tue, 23 May 2023 11:45:40 +0000 (UTC)
Date:   Tue, 23 May 2023 13:45:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 08/18] watchdog/hardlockup: Move perf hardlockup
 checking/panic to common watchdog.c
Message-ID: <ZGynZJ6Kvf1w7Pyu@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.8.Id4133d3183e798122dc3b6205e7852601f289071@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.8.Id4133d3183e798122dc3b6205e7852601f289071@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-19 10:18:32, Douglas Anderson wrote:
> The perf hardlockup detector works by looking at interrupt counts and
> seeing if they change from run to run. The interrupt counts are
> managed by the common watchdog code via its watchdog_timer_fn().
> 
> Currently the API between the perf detector and the common code is a
> function: is_hardlockup(). When the hard lockup detector sees that
> function return true then it handles printing out debug info and
> inducing a panic if necessary.
> 
> Let's change the API a little bit in preparation for the buddy
> hardlockup detector. The buddy hardlockup detector wants to print
> nearly the same debug info and have nearly the same panic
> behavior. That means we want to move all that code to the common
> file. For now, the code in the common file will only be there if the
> perf hardlockup detector is enabled, but eventually it will be
> selected by a common config.
> 
> Right now, this _just_ moves the code from the perf detector file to
> the common file and changes the names. It doesn't make the changes
> that the buddy hardlockup detector will need and doesn't do any style
> cleanups. A future patch will do cleanup to make it more obvious what
> changed.
> 
> With the above, we no longer have any callers of is_hardlockup()
> outside of the "watchdog.c" file, so we can remove it from the header,
> make it static, and move it to the same "#ifdef" block as our new
> watchdog_hardlockup_check(). While doing this, it can be noted that
> even if no hardlockup detectors were configured the existing code used
> to still have the code for counting/checking "hrtimer_interrupts" even
> if the perf hardlockup detector wasn't configured. We didn't need to
> do that, so move all the "hrtimer_interrupts" counting to only be
> there if the perf hardlockup detector is configured as well.
> 
> This change is expected to be a no-op.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
