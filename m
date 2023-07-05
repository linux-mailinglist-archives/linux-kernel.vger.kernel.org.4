Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF06748064
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGEJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjGEJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:04:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B210E3;
        Wed,  5 Jul 2023 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=po3pt2+JvDM3t8kMU662g0QnICdzZ8LSuXyQfthUCe0=; b=H+ZXcDGwt5XwMmRuvecxP2j2ms
        r3QLBeF/6vnftXdiHdyNJfXxCJvWwioWrbdQr/2fdAvY7fpBYwwf+rj7iatUZTvyNVpbn2VbzvYE3
        MsJataDuoheidY1wnWipmIqn0fI1+v+dRiXr7xhhKSS1d9VLMSRfGKvoqxJrYMBxenlGYFKY2TTli
        SMAglfTs9oY/sP3GniecfCkvwQayD9L5Wx1KKoUSuzUEgQu2W312PMZ4adW30V4XXrWqAcvJ9WulP
        Fg1IZJEmEG33taIjxTK3pqZt1aI951NKN9+QR2tYTJxbVe9YIGhXfIfxNGfAeitd9mOYNJZgqCV5f
        fZaJydNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGyPN-00C3EX-0v;
        Wed, 05 Jul 2023 09:04:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C895C30036B;
        Wed,  5 Jul 2023 11:02:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B05452028F056; Wed,  5 Jul 2023 11:02:44 +0200 (CEST)
Date:   Wed, 5 Jul 2023 11:02:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org,
        samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-ID: <20230705090244.GH462772@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
 <20230705081547.25130-3-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705081547.25130-3-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:15:47AM +0200, Petr Pavlu wrote:

> ---
>  arch/x86/kernel/vmlinux.lds.S | 2 --
>  arch/x86/lib/retpoline.S      | 4 ++++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index a4cd04c458df..dd5b0a68cf84 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -133,9 +133,7 @@ SECTIONS
>  		KPROBES_TEXT
>  		SOFTIRQENTRY_TEXT
>  #ifdef CONFIG_RETPOLINE
> -		__indirect_thunk_start = .;
>  		*(.text..__x86.*)
> -		__indirect_thunk_end = .;
>  #endif

Arguably you could do:

		__indirect_thunk_start = .;
		*(.text..__x86.indirect_thunk)
		__indirect_thunk_end = .;
		*(.text..__x86.return_think)

Or somesuch, seems simpler to me.
