Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3156D4AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjDCOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjDCOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD2929066;
        Mon,  3 Apr 2023 07:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB3EE61AC1;
        Mon,  3 Apr 2023 14:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87B9C433EF;
        Mon,  3 Apr 2023 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680533281;
        bh=zkc/nP67akDuNsbOZzMSQGZOjO7R1abCnH7seOXz224=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQcv7fpEp/XLXHVw9beM+Y0yFOf8DK/VBzBKESdNgC1rd2Ol9f57uxJV6m4/BvWtS
         sWDM/YOn30RcwBdb64sOCDeDmjelSo+auLcb4LvsNSMM4uBJzv6EPSKWO3EoRjSYVw
         eTaCha+6az0nyeQ5FqBbIL5apUhW+BqbJg8fr6aLrB0dtWqpd0a7x4Uvu+4rBp5PmA
         CIRWuybasgjZTrBxHS3QgjkC7rml99JepMie/umMNwQOZErGVcqR4PIF6uKBRJ747T
         FJtvvvv0Li8x1y99+Qmw2Sicsll7Dui9LFvSuQffpDlWuR2PDpMU037XhK/cSAxaNB
         FHZHw/2n05Ylw==
Date:   Mon, 3 Apr 2023 07:47:58 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: clang: do not use CROSS_COMPILE for target triple
Message-ID: <20230403144758.GA3460665@dev-arch.thelio-3990X>
References: <20230401170117.1580840-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401170117.1580840-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 02:01:17AM +0900, Masahiro Yamada wrote:
> The target triple is overridden by the user-supplied CROSS_COMPILE,
> but I do not see a good reason to support it. Users can use a new
> architecture without adding CLANG_TARGET_FLAGS_*, but that would be
> a rare case.
> 
> Use the hard-coded and deterministic target triple all the time.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I know of one bug where the value of '--target' matters:

https://github.com/ClangBuiltLinux/linux/issues/1244

This was fixed in LLVM 12.0.0. We are not testing this in our CI though,
so we would not get bit by this (we could bump the minimum supported
version of LLVM to 12.0.0 for this, we have talked recently about doing
it for other reasons).

I guess I cannot really think of a good reason not to do this aside from
that; the target triple should only affect code generation, rather than
tool selection (i.e., this does not take away the ability to use a
custom set of binutils with clang).

However, Nick is currently OOO and I would like his opinion voiced
before we commit to this. Consider this a tentative:

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/Makefile.clang | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 70b354fa1cb4..9076cc939e87 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -13,15 +13,11 @@ CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
>  CLANG_TARGET_FLAGS_um		:= $(CLANG_TARGET_FLAGS_$(SUBARCH))
>  CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
>  
> -ifeq ($(CROSS_COMPILE),)
>  ifeq ($(CLANG_TARGET_FLAGS),)
> -$(error Specify CROSS_COMPILE or add '--target=' option to scripts/Makefile.clang)
> +$(error add '--target=' option to scripts/Makefile.clang)
>  else
>  CLANG_FLAGS	+= --target=$(CLANG_TARGET_FLAGS)
> -endif # CLANG_TARGET_FLAGS
> -else
> -CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
> -endif # CROSS_COMPILE
> +endif
>  
>  ifeq ($(LLVM_IAS),0)
>  CLANG_FLAGS	+= -fno-integrated-as
> -- 
> 2.37.2
> 
