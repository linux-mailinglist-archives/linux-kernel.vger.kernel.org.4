Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01735F7B27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJGQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJGQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:04:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345FFC1DC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:04:06 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e759329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e759:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 046351EC0432;
        Fri,  7 Oct 2022 18:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665158641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YVpmq0Ymkvut4aBgG5/WzFTmVIgDf6qvJBXSt62YJlM=;
        b=awWZh0VZCBfD2EFJ79KBMRcAVJhex+oUCJ93hTilgERpF3Bhh1GaWgr0387l3PB+rNM0Im
        t77p37BYYgOj6UP/gKL54zs7QYZSpAIZ4+TEGTW76vb0UgnO2yKE6poCX5u0Cjoc5Z3iyy
        TyQdILLIhm1JDN+pt+ymeZpUPhtjGG0=
Date:   Fri, 7 Oct 2022 18:03:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 07/59] x86: Sanitize linker script
Message-ID: <Y0BN7PDOqB1vsBih@zn.tnic>
References: <20220915111039.092790446@infradead.org>
 <20220915111143.614728935@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220915111143.614728935@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 01:10:46PM +0200, Peter Zijlstra wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The section ordering in the text section is more than suboptimal:
> 
>     ALIGN_ENTRY_TEXT_BEGIN
>     ENTRY_TEXT
>     ALIGN_ENTRY_TEXT_END
>     SOFTIRQENTRY_TEXT
>     STATIC_CALL_TEXT
>     INDIRECT_THUNK_TEXT
> 
> ENTRY_TEXT is in a seperate PMD so it can be mapped into the cpu entry area

s/seperate/separate/g

That's tglx's favourite spelling of "separate" :-)

> when KPTI is enabled. That means the sections after it are also in a
> seperate PMD. That's wasteful especially as the indirect thunk text is a
  ^^^^^^^^

ditto.


> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -132,18 +132,19 @@ SECTIONS
>  		CPUIDLE_TEXT
>  		LOCK_TEXT
>  		KPROBES_TEXT
> -		ALIGN_ENTRY_TEXT_BEGIN
> -		ENTRY_TEXT
> -		ALIGN_ENTRY_TEXT_END
>  		SOFTIRQENTRY_TEXT
> -		STATIC_CALL_TEXT
> -		*(.gnu.warning)
> -
>  #ifdef CONFIG_RETPOLINE
>  		__indirect_thunk_start = .;
>  		*(.text.__x86.*)
>  		__indirect_thunk_end = .;
>  #endif

<--- might wanna put a comment here so that people don't slap some new
sections underneath it.

> +		STATIC_CALL_TEXT
> +
> +		ALIGN_ENTRY_TEXT_BEGIN
> +		ENTRY_TEXT
> +		ALIGN_ENTRY_TEXT_END
> +		*(.gnu.warning)
> +
>  	} :text =0xcccc
>  
>  	/* End of text section, which should occupy whole number of pages */
> 
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
