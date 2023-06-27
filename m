Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379C7402B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjF0Rzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjF0Rzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:55:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167721BD1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:55:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687888534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npF85FRxKY2gXCkKDnvL4/qKiC7YOuDmznNqzXS/8KY=;
        b=u+cLz1qF4NiJjuh3fRrrfmsjVJ5KAZfhIlqgkGQYtU4yihpoplZXMoIDI0kNe1z3xXtn/I
        AIeyL9wDz6ArsH1K+Tx/2eUkAYzihpl/1UwpKgvJ6yHRQ608gOhhCq92hF8582hrOtJS+r
        +7JkTv98Or9UihjXGhmYewP6c3cf8zi3pBNMdETaFc4IV2pD31eCXYe7eOJejGZSdM4Yg6
        0k7vC+wYv3y46flKRHKeBpz+mA/Bi4KnkxujBu0XSHXSKEek1B9XTj+vgvjAJ4KekImKil
        wkOAXb8VHcvrDf/4+wgq5HciNxTGO5gW2J6jpWKipytIjEiLH2Lkk2Z9ye29PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687888534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npF85FRxKY2gXCkKDnvL4/qKiC7YOuDmznNqzXS/8KY=;
        b=cTjf63vv8QIMEM4W7/74fDFGhPaoe8bfX43ehcOf6IkCJZ1Sl5y5peAG9PA5RvHJ4J/o5d
        RjI8ncpK9CHo1XCw==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
In-Reply-To: <ZJhUiO+bdBoLU5WF@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <ZIwMstkB7CG3pDYu@feng-clx> <87h6qz7et0.ffs@tglx> <87edm36qqb.ffs@tglx>
 <ZJW0gi5oQQbxf8Df@feng-clx> <ZJhUiO+bdBoLU5WF@feng-clx>
Date:   Tue, 27 Jun 2023 13:14:34 +0200
Message-ID: <87r0px40o5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25 2023 at 22:51, Feng Tang wrote:
> From debug, the reason of the hung/stall is detect_extended_topology_early()
> is called by cpu hotplug after boot, where there is "maxcpus=XXX" setting,
> (#echo 1 > /sys/devices/system/cpu/cpuX/online).
>
> It could be fixed with below patch:
> ----------------------------------------------------------------
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 828c1f7edac1..1ff73c8c4972 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -29,7 +29,7 @@ unsigned int __max_die_per_package __read_mostly = 1;
>  EXPORT_SYMBOL(__max_die_per_package);
>  
>  #ifdef CONFIG_SMP
> -unsigned int apic_to_pkg_shift __ro_after_init;
> +unsigned int apic_to_pkg_shift;

Bah, yes. I missed the early_init() call from init_intel(). I hate that
code with a passion.
  
