Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04A5FE304
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJMT43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJMT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:56:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8417FD43;
        Thu, 13 Oct 2022 12:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3544B81F3B;
        Thu, 13 Oct 2022 19:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED922C433D6;
        Thu, 13 Oct 2022 19:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665690982;
        bh=cxvv2dUAFxAacTUfnF9gIs2mfss86y4K+cxeNNpBBd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwC5r1QRmuvXQVN1MvYktm/SVjfwpad2BfvX2YhN+mOJgx0Ghr47cbgn48wX23Acb
         k6LX5WG/Qpx3xGYRD4r0ekTCgUBWG+tUOW2V/hjkjnVymvDdmGCbV6qA7bV0icqsVW
         bTRh50FQZd3UU5GW9W96sYA4UpD3DYIQdKNTU9ZBIHVo3zGgirfuVLUk+p4OJbDBzW
         ESqpPSyQkJE1Ntb0kqRgnZNr91EywFudFZ/iC6U9bnvkGfkx3xRUihZSWCwPqvPxA4
         N0rMnkeH8smD89k3bosvxYViP0zvgNKkXTripboXaZrAHcAiiBNlEc5p7AGubkjXSy
         gzY7tn3HTIHjw==
Date:   Thu, 13 Oct 2022 12:56:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: add -fno-discard-value-names to cmd_cc_ll_c
Message-ID: <Y0htZDJoTuQegVQR@dev-arch.thelio-3990X>
References: <20221007203236.1750890-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007203236.1750890-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 01:32:36PM -0700, Nick Desaulniers wrote:
> When debugging LLVM IR, it can be handy for clang to not discard value
> names used for local variables and parameters. Compare the generated IR.
> 
> Implicit Default (-fdiscard-value-names):
>   define i32 @core_sys_select(i32 %0, ptr %1, ptr %2, ptr %3, ptr %4) {
>     %6 = alloca i64
>     %7 = alloca %struct.poll_wqueues
>     %8 = alloca [64 x i32]
> 
> Explicit -fno-discard-value-names:
>   define i32 @core_sys_select(i32 %n, ptr %inp, ptr %outp, ptr %exp,
>                               ptr %end_time) {
>     %expire.i = alloca i64
>     %table.i = alloca %struct.poll_wqueues
>     %stack_fds = alloca [64 x i32]
> 
> The rule for generating human readable LLVM IR (.ll) is only useful as a
> debugging feature:
> 
> $ make LLVM=1 fs/select.ll
> 
> Clang defaults to -fdiscard-value-names to save memory when generating
> LLVM IR. For debugging purposes, the improvement in readability at a
> cost of more verbose IR is a cost we're happy to pay.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch!

Link: https://github.com/ClangBuiltLinux/linux/issues/1467
Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 27be77c0d6d8..d0e4f476dfee 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -140,7 +140,7 @@ $(obj)/%.symtypes : $(src)/%.c FORCE
>  # LLVM assembly
>  # Generate .ll files from .c
>  quiet_cmd_cc_ll_c = CC $(quiet_modtag)  $@
> -      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -o $@ $<
> +      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -fno-discard-value-names -o $@ $<
>  
>  $(obj)/%.ll: $(src)/%.c FORCE
>  	$(call if_changed_dep,cc_ll_c)
> 
> base-commit: 93ed07a23fd08b8613f64cf0a15d7fbdaca010fd
> -- 
> 2.38.0.rc2.412.g84df46c1b4-goog
> 
