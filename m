Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463AE6B5271
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCJVBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCJVAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:00:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C517C1CAEA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d+LtKtidm6T9SV4g7NnD8w/5jUElsoTs2/W+UvbRnPk=; b=Tphoq4Z+zo8wXtHh44enAyJ4GV
        AEou7K2HYc7y5aYlmS0Wf1DC/cPLp4c4zYD5BuMqDKAAg35fUj3jLPOBt4ft5ZiOtK9KTJJqrIgah
        EtKhuqXVxoFuOuiC6Wg618IxqzI2yzOwQdHtubErR4biQ4XTyDs+4hGkf3ZtMSP2D+citXHDW92Dv
        eDhpw4eEpxtRYf5v7HvTkPpehY+m/reL8Cg1+zuYmlJfCs+53/DI5iwq3wKaBGQtpK889LaST9I2n
        UM+fFyj96sHke+6H4azEIqwszXQSF8zlVHMuB+ZEDZbVWRKDvnCI3Q4vDZppsfhkTLs7ZR2Jzw9qT
        mhSl+urA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pajpo-000ZQv-03;
        Fri, 10 Mar 2023 20:59:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5EBB63002FC;
        Fri, 10 Mar 2023 21:59:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F57F21309757; Fri, 10 Mar 2023 21:59:26 +0100 (CET)
Date:   Fri, 10 Mar 2023 21:59:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC][PATCH 1/5] static_call: Make NULL static calls consistent
Message-ID: <20230310205926.GB1605437@hirez.programming.kicks-ass.net>
References: <cover.1678474914.git.jpoimboe@kernel.org>
 <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:31:13PM -0800, Josh Poimboeuf wrote:

> -/*
> - * This horrific hack takes care of two things:
> - *
> - *  - it ensures the compiler will only load the function pointer ONCE,
> - *    which avoids a reload race.
> - *
> - *  - it ensures the argument evaluation is unconditional, similar
> - *    to the HAVE_STATIC_CALL variant.
> - *
> - * Sadly current GCC/Clang (10 for both) do not optimize this properly
> - * and will emit an indirect call for the NULL case :-(
> - */
> -#define __static_call_cond(name)					\
> -({									\
> -	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
> -	if (!func)							\
> -		func = &__static_call_nop;				\
> -	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
> -})

So a sufficiently clever compiler can optimize the above to avoid the
actual indirect call (and resulting CFI violation, see below), because
__static_call_nop() is inline and hence visible as an empty stub
function. Currently none of the compilers are that clever :/

> -#define static_call_cond(name)	(void)__static_call_cond(name)
> +#define static_call_cond(name) (void)static_call(name)
>  
>  static inline
>  void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>  {
> -	WRITE_ONCE(key->func, func);
> +	WRITE_ONCE(key->func, func ? : (void *)__static_call_nop);
>  }

This will break ARM64 I think, they don't HAVE_STATIC_CALL but do have
CLANG_CFI, which means the above will end up being a runtime indirect
call to a non-matching signature function.

Now, I suppose we don't actually have this happen in current code by the
simple expedient of not actually having any static_call_cond() usage
outside of arch code.

(/me git-grep's some and *arrrggh* trusted-keys)

I really don't think we can do this though, must not promote CFI
violations.
