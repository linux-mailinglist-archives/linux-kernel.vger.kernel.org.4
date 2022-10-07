Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD05F7A4A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJGPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJGPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:09:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0C114D33
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IkEJ5cvuj/MJi7gwVwOtxmnQ/38uKGNjLnka1yFw7EI=; b=ZeG9jlVGWcNrymTsjYfOhguAT3
        Bz1QK94ec0U/Ipkr33Ge+rN2pXBXN0CHi3/j3V0cnX4pxMJN3k1dVGB2YtndtQCvQSr0VxvdR8n7i
        wSsmWC0fAwHiLnPXjH1CbwtRR0fofQr/u2h1AKAke3n+wgD/jwKm2RNXZg6NDsiGm/S3RsHzG+AhA
        EozMgaZRukDhIqU+YjJz3preibby0nNmrEdp19jrbW/JAVQv+fHCa9D4IgBC4/LTKUBEPYAJJ0SlQ
        oXPTHUzWSnwloh/zDPnEETVXfZe8ShAQUJRs0kLLl2UDVjbc+Ht3Pc/LILEZUDmZ8Gkglhm8Box4o
        CTbIX2Xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogoyl-001UPZ-Bh; Fri, 07 Oct 2022 15:09:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACA7F300155;
        Fri,  7 Oct 2022 17:09:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9631629982FD4; Fri,  7 Oct 2022 17:09:34 +0200 (CEST)
Date:   Fri, 7 Oct 2022 17:09:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Message-ID: <Y0BBLhHrgxYZahfi@hirez.programming.kicks-ass.net>
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

Something like so perhaps?

	asm_inline volatile("1:\n"
			    ALTERNATIVE("call asm_load_gs_index\n",
					LKGS_DI,
					X86_FEATURE_LKGS)
			    _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k[sel])
			    : ASM_CALL_CONSTRAINT
			    : [sel] "D" (sel)
			    : "memory", _ASM_AX);


(completely untested, not even seen a compiler upclose)
