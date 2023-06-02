Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7785B7208B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjFBSBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbjFBSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:00:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8131BF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 611DF64C7D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF8CC433EF;
        Fri,  2 Jun 2023 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685728855;
        bh=cpg2kA4m9ecom4a4wqNDBo51WrTY4aWxfzQcoCpx8B8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cJLFnmyWPDpafmJQC8eEVQXtNqUKiBoo16PYhumNiCbdsMV4xqfgQo6Sd30hr7i9H
         QyrS8Lxe+/1ZXE1/VmSjFXHhNL6ClrkGDUGPbVkP3cMzTZIFB7T3t7qZpS+7TTcdxx
         7ctXtVY7PCOajePIS1OrWboMcq0B+c5crMAFdQszjQslXfoeMFkYjfmj16lZo2dDgp
         7rHJ8llwsCdZpW7q8sFGa6VZff1BnXhRv4pMMbbNrHmYh89pZ8zV75Fl1iH7UOGdfe
         Fed26dLi5Y51Ss0wI7s4etuLiE3zM7sY9cMhUnugnnUqOACd5crB9++IQSckhqA9b5
         Al18l7+61qdkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 530CBCE3B00; Fri,  2 Jun 2023 11:00:55 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:00:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        liaoyu15@huawei.com
Subject: Re: [PATCH v1 2/2] x86/tsc: Extend watchdog check exemption to
 4-Sockets platform
Message-ID: <06df410c-2177-4671-832f-339cff05b1d9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <20221021062131.1826810-2-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021062131.1826810-2-feng.tang@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 02:21:31PM +0800, Feng Tang wrote:
> There is report again that the tsc clocksource on a 4 sockets x86
> Skylake server was wrongly judged as 'unstable' by 'jiffies' watchdog,
> and disabled [1].
> 
> Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> on qualified platorms") was introduce to deal with these false
> alarms of tsc unstable issues, covering qualified platforms for 2
> sockets or smaller ones.
> 
> Extend the exemption to 4 sockets to fix the issue.
> 
> We also got similar reports on 8 sockets platform from internal test,
> but as Peter pointed out, there was tsc sync issues for 8-sockets
> platform, and it'd better be handled architecture by architecture,
> instead of directly changing the threshold to 8 here.
> 
> Rui also proposed another way to disable 'jiffies' as clocksource
> watchdog [2], which can also solve this specific problem in an
> architecture independent way, with one limitation that there are
> also some tsc false alarms which were reported by other hardware
> watchdogs like HPET/PMTIMER, while 'jiffies' watchdog is mostly
> used in kernel boot phase.
> 
> [1]. https://lore.kernel.org/all/9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com/
> [2]. https://lore.kernel.org/all/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/
> 
> Reported-by: Yu Liao <liaoyu15@huawei.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

We have a number of four-socket systems whose TSCs seem to be reliable.
We do see issues where high memory load forces the TSC to be marked
unstable, but that is because those systems are using an older kernel.

If the TSCs do start to misbehave, I will of course let you all know.
But in the meantime:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

The previous patch that changes the definition of "socket" I have no
opinion on.  I must let you guys work that out.  However, I do note that
this patch can be rebased so as to no longer depend on that patch.

						Thanx, Paul

> ---
>  arch/x86/kernel/tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 178448ef00c7..356f06287034 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1400,7 +1400,7 @@ static int __init init_tsc_clocksource(void)
>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> -	    logical_packages <= 2)
> +	    logical_packages <= 4)
>  		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
>  
>  	/*
> -- 
> 2.34.1
> 
