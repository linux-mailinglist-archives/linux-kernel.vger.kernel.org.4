Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1D5F79E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJGOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJGOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:47:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9323CD7E08
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r59kNkXhpt4gtGyh6fpSoAengjLndWGi45RCYvEV0Z0=; b=MP0SEjefJHb1UlmDvIcf8WQ1ye
        sQYTucWVE29MIjuasnxlYarz8ZKgAiKyCphRWag3k3RAbBS+tQxeo8JEt3H3yJmpBXgHq7yR2fkYV
        peo/NEKBmVSqlCnObAu6sqwC6RBKe9wO406q873JPH1efi9565CWqsFTK+noCcPyaNYDYwPjLizsy
        ISagdRFNRcaZ29hBUBCxYcG35yNwryhwri/HN/I4IORVF9mSIOt1RQu2b1IUZg9u4lsrmmE3fXH84
        UaekJNZHFpTMn4yzZ/5JS6Ni3DKXpRpMFEVm8W1DNgSxz8B1axROOB6vpGQ+x5yjQbfynYYA9SHs8
        ofT8GlRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogod5-001U6W-TR; Fri, 07 Oct 2022 14:47:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38186300155;
        Fri,  7 Oct 2022 16:47:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCB0C2BDA8087; Fri,  7 Oct 2022 16:47:09 +0200 (CEST)
Date:   Fri, 7 Oct 2022 16:47:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Message-ID: <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006154041.13001-7-xin3.li@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:40:41AM -0700, Xin Li wrote:

>  static inline void native_load_gs_index(unsigned int selector)
>  {
> +	u16 sel = selector;
> +
> +	/*
> +	 * Note: the fixup is used for the LKGS instruction, but
> +	 * it needs to be attached to the primary instruction sequence
> +	 * as it isn't something that gets patched.
> +	 *
> +	 * %rax is provided to the assembly routine as a scratch
> +	 * register.
> +	 */
> +	alternative_io("1: call asm_load_gs_index\n"
> +		       ".pushsection \".fixup\",\"ax\"\n"
> +		       "2:	xorl %k[sel], %k[sel]\n"
> +		       "	jmp 1b\n"
> +		       ".popsection\n"
> +		       _ASM_EXTABLE(1b, 2b),
> +		       _ASM_BYTES(0x3e) LKGS_DI,
> +		       X86_FEATURE_LKGS,
> +		       ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
> +		       ASM_NO_INPUT_CLOBBER(_ASM_AX));
>  }

I'm very sure none of this was tested... the .fixup section hasn't
existed for almost a year now.

  e5eefda5aa51 ("x86: Remove .fixup section")
