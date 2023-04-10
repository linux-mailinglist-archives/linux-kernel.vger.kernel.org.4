Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB16DC9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDJR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjDJRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E212114;
        Mon, 10 Apr 2023 10:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3245E61DEC;
        Mon, 10 Apr 2023 17:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2105FC433D2;
        Mon, 10 Apr 2023 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681147556;
        bh=XyF3KjeGz3tqYqm7+dQVUy0htjweUQJJzaPWHD7QUg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxDSH1VwPka9DHMiADKBky8GjMJMjDYA/U1pHszfpK5jpAKnhwl2PdIFayTLI+z5q
         9v+HZV9Yt0uBfAz1VctkK0CxIWvautSK0WXb7rbkeTvEmaSm7pYLMT2fgK3g8KJhPO
         3Ir0UFnR//sXM6jqgbkqQP72fkI2Cwh2gm1KTUKbkboB3Ga/eR21IE6UjLhvP9wQQK
         Y7cnGZwmkKHzEVJvv8/9dgnsiGg8yXH3kbTzPXYdVuEQXD7UmuNnj68pc2VDudvzlR
         oMUWsbmzNPHfCBT28E9RDU6OrQ9qE8B8+go3XLEi5fvWdKPDNVrsx42MhI1fKVNp/K
         JyrttkAi/M32g==
Date:   Mon, 10 Apr 2023 10:25:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
Message-ID: <20230410172554.GA178820@dev-arch.thelio-3990X>
References: <20230409145358.2538266-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230409145358.2538266-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Nit: s/CLANG_CFLAGS/CLANG_FLAGS/ in the title and a small typo below.

On Sun, Apr 09, 2023 at 11:53:57PM +0900, Masahiro Yamada wrote:
> When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple is
> not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.
> 
> As a result, the linker script is preprocessed with predefined macros
> for the build host instead of the target.
> 
> Assuming you use an x86 build machine, compare the following:
> 
>  $ clang -dM -E -x c /dev/null
>  $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu
> 
> There is no actual problem presumably because our linker scripts do not
> rely on such predefined macros, but it is better to define correct ones.
> 
> Move $(CFLAGS_CFLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S
         ^ CLANG_FLAGS
> will be processed with the proper target triple.
> 
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

We will need to sort out the report from the kbuild test robot before we
can do this. Otherwise, I think this should be fine, although I am
curious if -Wunused-command-line-argument might fire more because there
may be flags are unused while preprocessing. I will run this through my
test matrix once the other report has been addressed to make sure there
is nothing else obviously wrong with this change.

Cheers,
Nathan

> ---
> 
>  scripts/Makefile.clang | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 70b354fa1cb4..93ca059cc3b8 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -38,6 +38,5 @@ CLANG_FLAGS	+= -Werror=unknown-warning-option
>  CLANG_FLAGS	+= -Werror=ignored-optimization-argument
>  CLANG_FLAGS	+= -Werror=option-ignored
>  CLANG_FLAGS	+= -Werror=unused-command-line-argument
> -KBUILD_CFLAGS	+= $(CLANG_FLAGS)
> -KBUILD_AFLAGS	+= $(CLANG_FLAGS)
> +KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
>  export CLANG_FLAGS
> -- 
> 2.37.2
> 
