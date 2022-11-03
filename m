Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2C617B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKCLSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCLSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:18:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB9D10FCC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ppk5oqLzoieKopIKN99v9d97TdoVzFTkLUKC1+8UAY=; b=EPeqifQDlgwfu5GqvfAuXMVRtt
        5MSxrXQq09orPef5fLujxhR6G99DLQbE2LlqeLIoesg4knHwIRJGFtUAejxG+8uQGUym8kTVNhOKo
        lK+HNoJeQyleFEFmMz0snOEFooxmv8Iediv6I056lC9mosXeF/cTGtPmQJvMJvo+Xr0v/uKEgYUeb
        7Ikiuu9eneZrqGDc4fJh1UsKk0/G809MeKFUsli3tX4uK483ckAX0kKJDL3I4zrGOKZ5Ep5eZGwx8
        G/jBWYumJPtTAszLfzqVsVPbHH0Oe2DpA0UTK7vATqZ9vRjULMyQJ7PZXEXKWO2AGU/tcquHW96EQ
        jrbrN8WA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqYEn-006PUB-CG; Thu, 03 Nov 2022 11:18:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A140930012F;
        Thu,  3 Nov 2022 12:18:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89B1320424903; Thu,  3 Nov 2022 12:18:14 +0100 (CET)
Date:   Thu, 3 Nov 2022 12:18:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH 5/5] x86/traps: avoid KMSAN bugs originating from
 handle_bug()
Message-ID: <Y2OjdsGCEfTQuqJP@hirez.programming.kicks-ass.net>
References: <20221102110611.1085175-1-glider@google.com>
 <20221102110611.1085175-5-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102110611.1085175-5-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:06:11PM +0100, Alexander Potapenko wrote:

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 178015a820f08..d3fdec706f1d2 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -15,6 +15,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/interrupt.h>
>  #include <linux/kallsyms.h>
> +#include <linux/kmsan.h>
>  #include <linux/spinlock.h>
>  #include <linux/kprobes.h>
>  #include <linux/uaccess.h>
> @@ -301,6 +302,12 @@ static noinstr bool handle_bug(struct pt_regs *regs)
>  {
>  	bool handled = false;
>  
> +	/*
> +	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
> +	 * is a rare case that uses @regs without passing them to
> +	 * irqentry_enter().
> +	 */
> +	kmsan_unpoison_entry_regs(regs);
>  	if (!is_valid_bugaddr(regs->ip))
>  		return handled;
>  

Should we place this kmsan_unpoison_entry_regs() after the
instrumentation_begin() ?
