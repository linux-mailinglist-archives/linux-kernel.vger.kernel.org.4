Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC86F1B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjD1PTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjD1PTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:19:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF7B1FED
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1gWqmK1pf0FFJ4TSP7xU2y80RRLOAbNJTnqFlNM4mlc=; b=mxOtYJegObyEWHQUWDnHdnqDV2
        YfXcE224wfFB3l7fXDc6XtignNaOwjIpY5BuH2NVvfEPgPv0GxE9W0/Tw6Du5C7H+s7/bV4WIlsnX
        Fj4rJH5BcKmQP8DXrKgi8k3IOd+3+gUPu+PqRR37ZDM/PjBERIX6DwvAbl2o8CGF27vPoYEYLldDC
        xRmNJQb80K+npd79u48CI67ZT8v00ru6NZr3U/tpgYNIuGD1C5wsl1l7CmssmsMq+8qDtjNXF5iVc
        U9jEVOUmjsA7jrU0l6S0OnNqyH4sMGMFPHoTwGk8PBTPkIFa/If9tHi58I4OxNKCuLVTTDzboU73r
        3ra7qnNw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psPrr-00DMpp-1u;
        Fri, 28 Apr 2023 15:18:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12697300300;
        Fri, 28 Apr 2023 17:18:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8450241AEB03; Fri, 28 Apr 2023 17:18:37 +0200 (CEST)
Date:   Fri, 28 Apr 2023 17:18:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Subject: Re: [PATCH RFC 34/43] objtool: Adapt indirect call of __fentry__()
 for PIE support
Message-ID: <20230428151837.GD1449475@hirez.programming.kicks-ass.net>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <804a7d5a4ef939b767ae540ebbb24a811d99e100.1682673543.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804a7d5a4ef939b767ae540ebbb24a811d99e100.1682673543.git.houwenlong.hwl@antgroup.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 05:51:14PM +0800, Hou Wenlong wrote:

> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -747,15 +747,21 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
>  
>  const char *arch_nop_insn(int len)
>  {
> -	static const char nops[5][5] = {
> +	static const char nops[6][6] = {
>  		{ BYTES_NOP1 },
>  		{ BYTES_NOP2 },
>  		{ BYTES_NOP3 },
>  		{ BYTES_NOP4 },
>  		{ BYTES_NOP5 },
> +		/*
> +		 * For PIE kernel, use a 5-byte nop
> +		 * and 1-byte nop to keep the frace
> +		 * hooking algorithm working correct.
> +		 */
> +		{ BYTES_NOP5, BYTES_NOP1 },
>  	};
> -	if (len < 1 || len > 5) {
> +	if (len < 1 || len > 6) {
>  		WARN("invalid NOP size: %d\n", len);
>  		return NULL;
>  	}

Like Steve already said, this is broken, we hard rely on these things
being single instructions, this must absolutely be BYTES_NOP6.

And yes, then you get to fix a whole lot more.
