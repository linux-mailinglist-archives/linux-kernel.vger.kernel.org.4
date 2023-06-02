Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B24720C0C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbjFBWr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFBWr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:47:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBA1AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D7Rtyb72cdysLbSdHEt6SRIzf41F62vRjWfqA6Qc0qY=; b=Y0+uR4eqNAVDRYyv0I1BrO6KSj
        BeMQBuXeME3yqAuYR59VialxhjXSE8quz8a+8dLeCWlpr9ykproHq2oWjdGuXo4NWypZuveZp1OL8
        DNVjnavmAUwuvtYcaV1oFiMP9mIIEfZgHcyeDZddRWkHgj+4Wv4f/Emug97WyiaqzMIQVJ7nwEPXC
        4ZbWeSa5i/0zZgY/uKu98Mx8JvuIDB4bRb8tlVdtGC8ytuvrH3zZRle3BHjX+iyYctnmkeWgKoWUJ
        Cej+bRrkB80gkQ6TjNwe0BQhIjowCymyHABAnEDhMAYXW/8V+AxQeQPEmKKkb02yJmZASq2pg+uRd
        6fxrB1sQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q5DYg-001Tb8-1n;
        Fri, 02 Jun 2023 22:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FA453002F0;
        Sat,  3 Jun 2023 00:47:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CE112058125D; Sat,  3 Jun 2023 00:47:45 +0200 (CEST)
Date:   Sat, 3 Jun 2023 00:47:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles" event
Message-ID: <20230602224744.GC695361@hirez.programming.kicks-ass.net>
References: <20230518002555.1114189-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518002555.1114189-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 05:25:55PM -0700, Song Liu wrote:
> NMI watchdog permanently consumes one hardware counters per CPU on the
> system. For systems that use many hardware counters, this causes more
> aggressive time multiplexing of perf events.
> 
> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
> used. Add kernel cmdline arg nmi_watchdog=ref-cycles to configure the
> watchdog to use "ref-cycles" event instead of "cycles".
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> Changes in v4:
> Fix compile error for !CONFIG_HARDLOCKUP_DETECTOR_PERF. (kernel test bot)
> 
> Changes in v3:
> 
> Pivot the design to use kernel arg nmi_watchdog=ref-cycles (Peter)
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  include/linux/nmi.h                             | 2 ++
>  kernel/watchdog.c                               | 2 ++
>  kernel/watchdog_hld.c                           | 9 +++++++++
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..d378e23dad7c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3593,10 +3593,12 @@
>  			Format: [state][,regs][,debounce][,die]
>  
>  	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
> -			Format: [panic,][nopanic,][num]
> +			Format: [panic,][nopanic,][ref-cycles][num]
>  			Valid num: 0 or 1
>  			0 - turn hardlockup detector in nmi_watchdog off
>  			1 - turn hardlockup detector in nmi_watchdog on
> +			ref-cycles - configure the watchdog with perf event
> +			             "ref-cycles" instead of "cycles"
>  			When panic is specified, panic when an NMI watchdog
>  			timeout occurs (or 'nopanic' to not panic on an NMI
>  			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)

I still hate the whole ref-cycles thing, at the very least powerpc also
has HAVE_HARDLOCKUP_DETECTOR_PERF and they don't have ref-cycles, but
perhaps them wants to use a different event when the moon is just so...

What again was wrong with the option of specifying a raw event value and
falling back to cpu-cycles if that fails?
