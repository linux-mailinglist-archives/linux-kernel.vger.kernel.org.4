Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061FF70A086
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjESUXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjESUXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:23:14 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04374E49;
        Fri, 19 May 2023 13:23:11 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 95EAE92009E; Fri, 19 May 2023 22:23:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 901D792009B;
        Fri, 19 May 2023 21:23:10 +0100 (BST)
Date:   Fri, 19 May 2023 21:23:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/3] MIPS: Introduce WAR_4KC_LLSC config option
In-Reply-To: <20230519164753.72065-2-jiaxun.yang@flygoat.com>
Message-ID: <alpine.DEB.2.21.2305192117230.50034@angie.orcam.me.uk>
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com> <20230519164753.72065-2-jiaxun.yang@flygoat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023, Jiaxun Yang wrote:

> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 6d15a398d389..fd452e68cd90 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -152,6 +152,13 @@ static inline void check_errata(void)
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  
>  	switch (current_cpu_type()) {
> +	case CPU_4KC:
> +		if ((c->processor_id & PRID_REV_MASK) < PRID_REV_4KC_V1_0) {
> +			c->options &= ~MIPS_CPU_LLSC;
> +			if (!IS_ENABLED(CONFIG_WAR_4K_LLSC))
> +				pr_err("CPU have LLSC errata, please enable CONFIG_WAR_4K_LLSC");

 Given the circumstances I think this should be `panic'.  You don't want 
to continue with a system that can randomly lock up.

 Also "CPU has LLSC erratum, [...]" as both are singular.

  Maciej
