Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0B69EB07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjBUXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBUXMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:12:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349332509
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:12:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677021146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTl9cIrBHN5sjbMNrbyx8clNfDMqulDOGoZv7yGU4OU=;
        b=uxsJGrlYAa9g/wu978vx4JGfI8jZm+gB8YqWP7ao69OqVw45Kml/Kd+CHYoKzJL0m9W5v2
        3rRu3Gha+mb2Hxfx01bHQGeh55l1bhLvKCItXI1N5U2ex2tTW4v1fxZ08hhvcfy7kLwsl0
        rUF98yxjiACFe/XoBXM3dY8kdV9M58Lfq9M/niVsvVW/ZmJ8XuSqnBJr9ziQzd8p97Z2s2
        eM93/wNuGoomRbnBngxH2JA38k/IZ0V8ygKP7tLiMuIYgrLcG+/B5fcrLptB7u2pX/0Tpz
        OQWCwK5ZzzJYLZyWE28sIi8dm+AMq/ZGrywi7GOmeb5n+Puswua0OuzMgmOt5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677021146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTl9cIrBHN5sjbMNrbyx8clNfDMqulDOGoZv7yGU4OU=;
        b=Kz+8P8acR9Za1We0sqw6CbO8wAZEjNMTwGotWy/DaE4cfbmzRvIqzDtRG/tpAmUGmBRs0c
        KqjVcu2LfT16CmCw==
To:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 2/5] X86-64 should not uniquely require a third ELF
 package to build.
In-Reply-To: <e184ece9-2779-675e-0c84-f0a62413c7fd@landley.net>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <e184ece9-2779-675e-0c84-f0a62413c7fd@landley.net>
Date:   Wed, 22 Feb 2023 00:12:26 +0100
Message-ID: <87wn4amx45.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob!

On Tue, Feb 21 2023 at 14:56, Rob Landley wrote:

The subject line is not compliant to documentation. Please read and
follow Documentation/process/* especially submitting-patches.rst and
maintainer-tip.rst

> x86-64 is the only architecture that can't compile without an extra
> ELF library installed on the host. (The kernel already has multiple ELF
> parse implementations built-in, so requiring another one is questionable
> at best.)

How are ELF parsers in the kernel itself related to a build requirement
for a tool, which is part of the kernel build process?

Next time you ask for removal of perl, python or whatever the kernel
requires to build.

> You can switch it back on in menuconfig if you want to, this
> just stops it being mandatory.

How do you switch on CONFIG_HAVE_OBJTOOL in menuconfig?

config HAVE_OBJTOOL
        bool

There is no knob.

> See https://lkml.iu.edu/hypermail/linux/kernel/2110.3/00402.html
> and https://lkml.iu.edu/hypermail/linux/kernel/2110.3/00278.html

Please use https://lore.kernel.org/lkml/ links.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3604074a878b..b63510d79baf 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -243,7 +243,6 @@ config X86
>  	select HAVE_NOINSTR_HACK		if HAVE_OBJTOOL
>  	select HAVE_NMI
>  	select HAVE_NOINSTR_VALIDATION		if HAVE_OBJTOOL
> -	select HAVE_OBJTOOL			if X86_64

This prevents runtime features, optimizations, mitigations and build
time validations rom being selected as you can see from your patch
context.

Just to be clear: objtool is mandatory for x86_64 builds.

git grep 'select HAVE_OBJTOOL' will tell you that your claim about
x86_64 being the only architecture is slightly wrong.

Thanks,

        tglx
