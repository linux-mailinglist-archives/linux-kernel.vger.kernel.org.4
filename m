Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B76BB6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjCOPA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjCOO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:59:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1C94751;
        Wed, 15 Mar 2023 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wd8qK2CA6PymeHUSx0iaO6FA3rxmYEqXDRJEu+NxeFQ=; b=PFP1zbNSgF4Lhynb68W1Zs6OoH
        HEDO+2MGSPoRsxZUfpjUK+DAEtI7EL9ir21q/hml31B0rqCSFtdkCG4//j87u+65tDB/SOig7IWbY
        QdA45IM8LaNGDys8KDlhn0jtnKyPmz4PreME22ouaOEa1moXdFlsGB7qfzpQQ8ig8C5cQZSC2Px+C
        PsaDe99yZvUZaOb5LVpCyrZRyKzsxfSRFPG10Rqi1fhJsAcDxB/Qosfj0DGyctMR458LS9bqW+ADs
        1zf0SeHzabZeqQwiV4+mxEuwnHrhQ6sR4QyEfNDFbUeCStT8CXqhNzJ0ovfHNdc2Tww3A/B2Zzfgi
        x/Z23HRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcSZk-00DvdH-FK; Wed, 15 Mar 2023 14:58:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B85213001E5;
        Wed, 15 Mar 2023 15:57:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EA362408DE43; Wed, 15 Mar 2023 15:57:57 +0100 (CET)
Date:   Wed, 15 Mar 2023 15:57:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Donglin Peng <pengdonglin@sangfor.com.cn>, mhiramat@kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing
 the return value of function
Message-ID: <20230315145757.GE2006103@hirez.programming.kicks-ass.net>
References: <20230315133911.958741-1-pengdonglin@sangfor.com.cn>
 <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
 <20230315134911.GD2006103@hirez.programming.kicks-ass.net>
 <20230315101348.1234c7f5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315101348.1234c7f5@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:13:48AM -0400, Steven Rostedt wrote:
> On Wed, 15 Mar 2023 14:49:11 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > > index 1265ad519249..35ac9c58dc77 100644
> > > --- a/arch/x86/kernel/ftrace_64.S
> > > +++ b/arch/x86/kernel/ftrace_64.S
> > > @@ -348,6 +348,10 @@ SYM_CODE_START(return_to_handler)
> > >  	movq %rax, (%rsp)
> > >  	movq %rdx, 8(%rsp)
> > >  	movq %rbp, %rdi
> > > +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> > > +	/* Pass the function return value to ftrace_return_to_handler */
> > > +	movq %rax, %rsi
> > > +#endif
> > >  
> > >  	call ftrace_return_to_handler  
> > 
> > What about the case of double register return values (when the value
> > is returned in the A,D pair) ?
> 
> Is there anything that does that in 64 bit kernels?

Note sure; but I have a patch series that introduces cmpxchg128 and
friends. Most of the actual functions are __always_inline, but still,
the moment a compiler decides to break out a subfunction on a u128
boundary we're in luck.
