Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2817869BF44
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBSJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjBSJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:03:03 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C86C01117D;
        Sun, 19 Feb 2023 01:03:00 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pTfaz-0000LC-01; Sun, 19 Feb 2023 10:02:57 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4CE44C28CF; Sun, 19 Feb 2023 09:30:39 +0100 (CET)
Date:   Sun, 19 Feb 2023 09:30:39 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH v2] MIPS: SMP-CPS: fix build error when HOTPLUG_CPU not
 set
Message-ID: <20230219083039.GB2924@alpha.franken.de>
References: <20230217200749.1001-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217200749.1001-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:07:49PM -0800, Randy Dunlap wrote:
> When MIPS_CPS=y, MIPS_CPS_PM is not set, HOTPLUG_CPU is not set, and
> KEXEC=y, cps_shutdown_this_cpu() attempts to call cps_pm_enter_state(),
> which is not built when MIPS_CPS_PM is not set.
> Conditionally execute the else branch based on CONFIG_HOTPLUG_CPU
> to remove the build error.
> This build failure is from a randconfig file.
> 
> mips-linux-ld: arch/mips/kernel/smp-cps.o: in function `$L162':
> smp-cps.c:(.text.cps_kexec_nonboot_cpu+0x31c): undefined reference to `cps_pm_enter_state'
> 
> Fixes: 1447864bee4c ("MIPS: kexec: CPS systems to halt nonboot CPUs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dengcheng Zhu <dzhu@wavecomp.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> ---
> v2: use IS_ENABLED() instead of #ifdef-ery (Sergei)
> 
>  arch/mips/kernel/smp-cps.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff -- a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -424,9 +424,11 @@ static void cps_shutdown_this_cpu(enum c
>  			wmb();
>  		}
>  	} else {
> -		pr_debug("Gating power to core %d\n", core);
> -		/* Power down the core */
> -		cps_pm_enter_state(CPS_PM_POWER_GATED);
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> +			pr_debug("Gating power to core %d\n", core);
> +			/* Power down the core */
> +			cps_pm_enter_state(CPS_PM_POWER_GATED);
> +		}
>  	}
>  }
>  

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
