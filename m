Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3327059AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEPVjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEPVjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B48170D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA6BA63384
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF5EC433D2;
        Tue, 16 May 2023 21:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684273151;
        bh=3/oGGcEbv1ygJN5WNysTrX21QOEZ0xVgg3cCGwFP/zg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xTEhu86ZHPZatPktYerX9ktOTeXYmwibdmhfROIGQXL1TdHPtFc98xN38oxILRDgm
         GK6IH6givjuYbYDzxYqKb2BDVmk0nfA1A1NQ+glxv8LvV66tsnliVxT6QJ1NHtBWDS
         nEK68E+2XL/Y09+zW8PY2BVp7ZaYYfwhkpFKuyjc=
Date:   Tue, 16 May 2023 14:39:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] auto: add "auto" keyword as alias for __auto_type
Message-Id: <20230516143910.ad39ddb949ca29d3a7cfdba1@linux-foundation.org>
In-Reply-To: <20230516164947.86543-2-adobriyan@gmail.com>
References: <20230516164947.86543-1-adobriyan@gmail.com>
        <20230516164947.86543-2-adobriyan@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 19:49:46 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> It has similar semantics to "auto" keyword from a language
> which can not be named on this mailing list, in particular:

Huh, 20 years ago C's auto meant "automatic variable".  ie, stored on
the stack.  It was never needed because that's the default, unless you
used `register', which gave the false impression that you're being
faster.

> 	{
> 		int a;
> 		const auto b = a; // const char b = a;

I assume that should be "const int b = a".

> 		b = 1;	// compile error
> 	}
> 	{
> 		char a;
> 		auto b = a; // char b = a;
> 		// no integer promotions
> 		static_assert(sizeof(b) == 1);
> 	}
> 	{
> 		int a;
> 		const auto p = &a; // int *const p = &a;
> 		*p = 1;	// works because const is applied only to top-level
> 	}
> 
> It can be used to save on macroexpansion inside macro forests which
> use typeof() somewhere deep enough. It is cool regardless.
> 
> Use "auto" in your code today!
> 
> gcc 5.1 supports __auto_type.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index 10fcc64fcd1f..d316924a466a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -570,6 +570,7 @@ KBUILD_CFLAGS += -Werror=return-type
>  KBUILD_CFLAGS += -Werror=strict-prototypes
>  KBUILD_CFLAGS += -Wno-format-security
>  KBUILD_CFLAGS += -Wno-trigraphs
> +KBUILD_CFLAGS += -Dauto=__auto_type
>  
>  KBUILD_CPPFLAGS := -D__KERNEL__
>  KBUILD_RUSTFLAGS := $(rust_common_flags) \

Examples at https://lkml.kernel.org/r/20230516164947.86543-3-adobriyan@gmail.com

It is pretty cool and could get used a lot.  Cc Linus for his thoughts?
