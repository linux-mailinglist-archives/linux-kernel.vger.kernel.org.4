Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39EF610451
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiJ0VZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiJ0VZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D735D2D1EC;
        Thu, 27 Oct 2022 14:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CDFDB827D9;
        Thu, 27 Oct 2022 21:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE46C433C1;
        Thu, 27 Oct 2022 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666905898;
        bh=ra9Em2eePsRB3ynpBC3jpbouHuUgZ9DXcTtxdI0P5VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toqWQe9vUdoqzF7Uty6Iaw8Xnn8WntR1BnA6vQZnsr2dGXm9dhUkEkUSMM49OM9Ml
         LldGdHiMEtQDdp15jC1x8VWj6oQOFVXMm5QUxEeIlNlLtdNWLkNS0zVvhwzVWSJswY
         dFmBEwEFDF4AuGb7Mm5diLunAD6hri+Pdi2vwol/2BPjk6KbgHqURbnZefAALBKtxc
         Zpkc3I4l6gzT71QCYo3aizMNW5kOXoTPLKlbgTCU7VceHqIDGNxZsuO7R+pD0K5alb
         hjFSy0o/lJl8XWAsC71BlD9pXfGFcG4onZOAgsZY1bwgah133GmFrUUcXqeY3Z3pW6
         EfM7Ce5vFh/Xg==
Date:   Thu, 27 Oct 2022 14:24:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] kbuild: fix SIGPIPE error message for AR=gcc-ar and
 AR=llvm-ar
Message-ID: <Y1r3KAyhFbwJ1W1d@dev-arch.thelio-3990X>
References: <20221027162839.410720-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027162839.410720-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:28:39AM +0900, Masahiro Yamada wrote:
> Jiri Slaby reported that building the kernel with AR=gcc-ar shows:
>   /usr/bin/ar terminated with signal 13 [Broken pipe]
> 
> Nathan Chancellor reported the latest AR=llvm-ar shows
>   error: write on a pipe with no reader
> 
> The latter occurs since LLVM commit 51b557adc131 ("Add an error message
> to the default SIGPIPE handler").
> 
> The resulting vmlinux is correct, but it is better to silence it.
> 
> 'head -n1' exits after reading the first line, so the pipe is closed.
> 
> Use 'sed -n 1p' to eat the stream till the end.
> 
> Fixes: 321648455061 ("kbuild: use obj-y instead extra-y for objects placed at the head")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1651
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
> Changes in v2:
>   - Update commit description to mention llvm-ar
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index e90bb2b38607..e9e7eff906a5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
>        cmd_ar_vmlinux.a = \
>  	rm -f $@; \
>  	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> -	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
> +	$(AR) mPiT $$($(AR) t $@ | sed -n 1p) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
>  
>  targets += vmlinux.a
>  vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
> -- 
> 2.34.1
> 
