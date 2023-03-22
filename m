Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC76C4D63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCVOUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCVOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:20:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981AF65443
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NE1PIMFkudPTW1JLolSau7zYkTz39Mje7OyjRZD68QI=; b=lI+Lu8mgPcskiOn3h0NWi5OrwF
        LYWqriodX5VFGezELDig2h3WgiiEwgBEnUOHB+VHGPktNSDDHU8J/D9wxX4PlXHN3nnToeaHB7uQs
        1u8VSEugJ6xicm+8mRDcagBa6a8O1YkSrpC8dAO4cYPf3LlPHCb6ISt7F6a/Tc3WD5slsgvA6UUy8
        N9bBp7N4iQq9FB8HOZ6ZoDrHOMo2c5Kheb+wXDdLAjyyqGoKRC7b1DrXN+LkNYnyFrm+JAGUj4J1G
        DwzgGSYL9Es/jnliUFhWr7Czr7QmWrKjA4Om1f3VbmV/oO7YyaQCchx1Z6cbbAN56n80+t0RLgRgb
        vDVwEW+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pezJO-004ZXR-1U;
        Wed, 22 Mar 2023 14:19:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB75E30031E;
        Wed, 22 Mar 2023 15:19:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93AC520106E12; Wed, 22 Mar 2023 15:19:33 +0100 (CET)
Date:   Wed, 22 Mar 2023 15:19:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] arm64/static_call: Fix static call CFI
 violations
Message-ID: <20230322141933.GD2357380@hirez.programming.kicks-ass.net>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <3d8c9e67a7e29f3bed4e44429d953e1ac9c6d5be.1679456900.git.jpoimboe@kernel.org>
 <ZBry75KS3F+a0VM0@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBry75KS3F+a0VM0@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:22:07PM +0000, Mark Rutland wrote:
> On Tue, Mar 21, 2023 at 09:00:14PM -0700, Josh Poimboeuf wrote:

> > +++ b/arch/arm64/include/asm/static_call.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_ARM64_STATIC_CALL_H
> > +#define _ASM_ARM64_STATIC_CALL_H
> > +
> > +/*
> > + * Make a dummy reference to a function pointer in C to force the compiler to
> > + * emit a __kcfi_typeid_ symbol for asm to use.
> > + */
> > +#define GEN_CFI_SYM(func)						\
> > +	static typeof(func) __used __section(".discard.cfi") *__UNIQUE_ID(cfi) = func
> > +
> > +
> > +/* Generate a CFI-compliant static call NOP function */
> > +#define __ARCH_DEFINE_STATIC_CALL_CFI(name, insns)			\
> > +	asm(".align 4						\n"	\

Should this ^ be:

	__ALIGN_STR "\n" \

> > +	    ".word __kcfi_typeid_" name "			\n"	\
> > +	    ".globl " name "					\n"	\
> > +	    name ":						\n"	\
> > +	    "bti c						\n"	\
> > +	    insns "						\n"	\
> > +	    "ret						\n"	\
> > +	    ".type " name ", @function				\n"	\
> > +	    ".size " name ", . - " name "			\n")

Also, Mark, I think you can remove __ALIGN and __ALIGN_STR from
arch/arm64/include/linkage.h they're very similar to the generic one.
