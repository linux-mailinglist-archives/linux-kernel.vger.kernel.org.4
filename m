Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBE6692D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbjAMJ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbjAMJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:25:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E56CFC0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0yGEeUtjPEYmvw01tTdJaP6xQOH4LDHoqrSGg4IbmmE=; b=b7GY0Fs4Kh53b766Ze4bZu1Jc3
        sQKmwNr2hglGmJZJeqnF5joOSCDOx/qOi5bgtrJcB8WFpuJ7T/vyAl8+mvecgBYhnxnO8kMgyVhNN
        v6eGdd6cwqv6aDki48ixTT8FYF5Bo9vWzEsufvVsogSfgELN6F63++l4Tzd22nVG8g1l0pwBPKGUZ
        A3lGv9kjETaf0T7YYyxcnZmF0zSy4O/IuXY3ykZGulJhVGuYa7iuM6gad8wGL8NJpmfLyHe10Qn53
        L4tqvf37g6tcW6x7srF1FtAQdXPdGN10AJOJwjFgzHtEJBO5WP16pPTYtGMQSPOZNqUmxfdGlxZpV
        w393kA+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGGCF-005xMC-Ns; Fri, 13 Jan 2023 09:17:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 518FB300094;
        Fri, 13 Jan 2023 10:17:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 088172013A2A1; Fri, 13 Jan 2023 10:17:46 +0100 (CET)
Date:   Fri, 13 Jan 2023 10:17:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        x86@kernel.org
Subject: Re: [RFC][PATCH 0/6] x86: Fix suspend vs retbleed=stuff
Message-ID: <Y8EhucZfQ2IyJtnU@hirez.programming.kicks-ass.net>
References: <20230112143141.645645775@infradead.org>
 <20230113073938.1066227-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113073938.1066227-1-joanbrugueram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 07:39:38AM +0000, Joan Bruguera wrote:
> Hi Peter,
> 
> I tried your patches on both QEMU and my two (real) computers where
> s2ram with `retbleed=stuff` was failing and they wake up fine now.

Yay \o/

> However, I think some minor reviews are needed:
> 
> (1) I got a build error due to a symbol conflict between the
>     `restore_registers` in `arch/x86/include/asm/suspend_64.h` and the
>     one in `drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c`.
> 
>     (I fixed by renaming the one in `hw_gpio.c`, but it's worth
>      an `allmodconfig` just in case there's something else)

Urgh, must be my .config for not spotting that, will fix!

> (2) Tracing with QEMU I still see two `sarq $5, %gs:0x1337B33F` before
>     `%gs` is restored. Those correspond to the calls from
>     `secondary_startup_64` in `arch/x86/kernel/head_64.S` to
>     `verify_cpu` and `sev_verify_cbit`.
>     Those don't cause a crash but look suspicious, are they correct?
> 
>     (There are also some `sarq`s in the call to `early_setup_idt` from
>     `secondary_startup_64`, but `%gs` is restored immediately before)

OK, I'll have a look, thanks!
