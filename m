Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30A64FC53
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 21:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLQU5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 15:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLQU5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 15:57:21 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A59FCF8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 12:57:20 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a01:e0a:a6a:5f90:5db3:4ad4:9c19:1e87])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 020015FF88;
        Sat, 17 Dec 2022 21:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1671310637;
        bh=OVeURlGUnn7ZUf0+Hoi0DPTZGsHXfWN8ZeCbFAHiRHU=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=PE5m16C+/cBk5GWZuBSql3yTv14i9bD9Fi84WIiXIMlVxH2r/0UpMrxznwcb3fNhi
         cZojmjSCinyHlIMWsUjIu0u0wrV+ZaHi/kTE/NAR/NenML4vTa/aWkpWGVKtx4Hco4
         T//Df9XpmOHdcwBhiRBJtbYqFcMAMRLVX3WHoBhAWLz1JrRw0WpIk/XZ+QJrUzaVQ7
         TmWlJ+QxsM3ZyPU4Zs9VOi3h0gvJOVZYycP3u+gVwr66irRl+IvMb7UO2ZkvDDl94O
         7kUortuccTscYgqykMewPJuQwdd6Ruei3N4YB2XX5nz921f/7gN8BttSy1sGSQHso3
         qqHSW4GZR8dZQ==
References: <20221215160747.2173998-1-arnd@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] ARM: pxa: fix building with clang
Date:   Sat, 17 Dec 2022 21:45:41 +0100
In-reply-to: <20221215160747.2173998-1-arnd@kernel.org>
Message-ID: <m21qoxiw9t.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The integrated assembler in clang does not understand the xscale
> specific mra/mar instructions:
>
> arch/arm/mach-pxa/pxa27x.c:136:15: error: unsupported 
> architectural extension: xscale
>         asm volatile(".arch_extension xscale\n\t"
> arch/arm/mach-pxa/pxa27x.c:136:40: error: invalid instruction, 
> did you mean: mcr, mla, mrc, mrs, msr?
>         mra r2, r3, acc0
>
> Since these are coprocessor features, the same can be expressed 
> using
> mrrc/mcrr, so use that for builds with IAS.
Ok Arnd, but "mrrc" is an ARMv6 instruction if I'm not mistaken.
Yet PXA27X is an ARMv5 XScale instruction set IP.

Is that patch correct therefore, or is it just to make clang happy 
even if it's
not correct ?

Cheers.

--
Robert
