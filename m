Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202CF6C53B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjCVS0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCVS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0162D148
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE6D62267
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7423C433D2;
        Wed, 22 Mar 2023 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679509580;
        bh=CNp6XvgesRx5FTnJf4WjIyqASMOSmavUiGLUcOYLzso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvQKIcTFfZK63U9V7DUJe46dhC1GCCLr2F2jPTZzLZY7J0DxnFPRjCPynY75AhixD
         lH+8Pr4UfvBKblvicGrsVIoXbwfrVAU0s43W1jn+o0AY5gsKxcWjfzuh5Z9CBZwmmw
         tacWhoRTrfiZYbIFze8TFaN2P2Us4icLJgBUbrWjTWem/Ziw8CEtszTL+XiUYGYJv7
         BsP+B0oF/Lj1FZwZJqUCmzJBKV1y28cI/R6G6CKVnqIfk4OfQTOLQ5AlXfTDGyXz4/
         0598mKJlgvN7E5S27seBH/wkMN1+y279EKja7AzCALguGG1fOPGMYTUWz7piz7w5Lt
         eAjX0Ugz50xMg==
Date:   Wed, 22 Mar 2023 11:26:17 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
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
Message-ID: <20230322182617.eyfphw4o2tm5yqi2@treble>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <3d8c9e67a7e29f3bed4e44429d953e1ac9c6d5be.1679456900.git.jpoimboe@kernel.org>
 <ZBry75KS3F+a0VM0@FVFF77S0Q05N>
 <20230322141933.GD2357380@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322141933.GD2357380@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 03:19:33PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 22, 2023 at 12:22:07PM +0000, Mark Rutland wrote:
> > On Tue, Mar 21, 2023 at 09:00:14PM -0700, Josh Poimboeuf wrote:
> 
> > > +++ b/arch/arm64/include/asm/static_call.h
> > > @@ -0,0 +1,29 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _ASM_ARM64_STATIC_CALL_H
> > > +#define _ASM_ARM64_STATIC_CALL_H
> > > +
> > > +/*
> > > + * Make a dummy reference to a function pointer in C to force the compiler to
> > > + * emit a __kcfi_typeid_ symbol for asm to use.
> > > + */
> > > +#define GEN_CFI_SYM(func)						\
> > > +	static typeof(func) __used __section(".discard.cfi") *__UNIQUE_ID(cfi) = func
> > > +
> > > +
> > > +/* Generate a CFI-compliant static call NOP function */
> > > +#define __ARCH_DEFINE_STATIC_CALL_CFI(name, insns)			\
> > > +	asm(".align 4						\n"	\
> 
> Should this ^ be:
> 
> 	__ALIGN_STR "\n" \

Ah right, you did mention that before.  Will do.

-- 
Josh
