Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF56E01A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDLWEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDLWEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:04:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F947ED1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A3F5639C0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB858C433EF;
        Wed, 12 Apr 2023 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681337050;
        bh=Cs/RuiAtC+xFvrRq6kd7R2610WkOAe2Z5xGdxRo0amU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tus0xjhaLSMviaeNmpHYGDKK7PkRXSG0vHz7VRFdjrWVsrhlEMcbKx0GJn3xYbSM6
         4yc+DfrcpaLtZrqCf1iBTsRQapO26DLSFhIMrw2ZwLj0qbUssI3m2bvVyNrLnVRzf7
         kaMQsmUhyiI+rWemFnhCdHsYwQvZ7V+cKFXqWllMBEDNvvASD7mN2aMtNVinXClYv/
         zPxKkmVCnr0Ah0YVuhcs0U5HGgsI3EhpFadofHyKGgmZBeCVWRY5c59Sk4vNBY9ArZ
         368y6dvXiL+ub+7fe5stf+IlPVDumwBxF9X5ngSlP0NUebMsZkgUddRpz8/wF4pGww
         q8zy96u4IVlWA==
Date:   Wed, 12 Apr 2023 15:04:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     ndesaulniers@google.com
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] start_kernel: omit prevent_tail_call_optimization
 for newer toolchains
Message-ID: <20230412220408.GB1120303@dev-arch.thelio-3990X>
References: <20230412-no_stackp-v1-0-46a69b507a4b@google.com>
 <20230412-no_stackp-v1-2-46a69b507a4b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412-no_stackp-v1-2-46a69b507a4b@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:32:13AM -0700, ndesaulniers@google.com wrote:
> prevent_tail_call_optimization was added in
> commit a9a3ed1eff36 ("x86: Fix early boot crash on gcc-10, third try")
> to work around stack canaries getting inserted into functions that would
> initialize the stack canary in the first place.
> 
> Now that we have no_stack_protector function attribute (gcc-11+,
> clang-7+) and use it on start_kernel, remove the call to
> prevent_tail_call_optimization such that we may one day remove it
> outright.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  init/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 213baf7b8cb1..c8503d02dfa6 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1152,7 +1152,12 @@ void start_kernel(void)
>  	/* Do the rest non-__init'ed, we're now alive */
>  	arch_call_rest_init();
>  
> +	/* Avoid stack canaries in callers of boot_init_stack_canary for gcc-10
> +	 * and older.
> +	 */
> +#if !__has_attribute(__no_stack_protector__)
>  	prevent_tail_call_optimization();
> +#endif
>  }
>  
>  /* Call all constructor functions linked into the kernel. */
> 
> -- 
> 2.40.0.577.gac1e443424-goog
> 
