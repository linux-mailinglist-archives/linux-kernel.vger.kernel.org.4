Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8A6288A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiKNSz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:55:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF831C405;
        Mon, 14 Nov 2022 10:55:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B0F1B811BC;
        Mon, 14 Nov 2022 18:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1EBC433D6;
        Mon, 14 Nov 2022 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668452147;
        bh=T6xKQPxTeP2SzkQqKrXGMazn5WCy4nuKwoW9/ToNfkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJhfPbqsNSP8CQEOentXag+R0uFTWNhgrdsogtjE7YHl9NHkklNQS41G/95HYml4N
         RX6OePsKxwN7L+NPX4T5usT9kpIFfmMllUb12aSqr5pSYfJczqR+jt7hRtuhjgmA/H
         eyRVRnJlTW+Qb3AzrjqpFkbyfj7H0R2ZP+utoq/1qs3GE3DYn1qWi489v3Rl6TaJjx
         wHZnPpYhr1OjG7KJejUzQbPR+IG0zv4yRYiHzDDxV42NpZxEbmc4RG2q3m7CdOd1no
         8H7tvAMiGWjGR3eU1r8uJVJWfiPWGeiZedLWlOG1dTKwrF3EyYRR+RYEUe9R8LAbEz
         DBpdS1h1+8AsA==
Date:   Mon, 14 Nov 2022 10:55:45 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Richard Biener <RGuenther@suse.com>,
        Jan Hubicka <jh@suse.de>, "H . J . Lu" <hjl.tools@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Martin Liska <mliska@suse.cz>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 30/46] Kbuild, lto: Add Link Time Optimization support
Message-ID: <20221114185545.yobf3faky2njugfq@treble>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-31-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221114114344.18650-31-jirislaby@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:43:28PM +0100, Jiri Slaby (SUSE) wrote:
> +++ b/Documentation/kbuild/lto-build.rst
> @@ -0,0 +1,76 @@
> +=====================================================
> +gcc link time optimization (LTO) for the Linux kernel
> +=====================================================
> +
> +Link Time Optimization allows the compiler to optimize the complete program
> +instead of just each file.
> +
> +The compiler can inline functions between files and do various other global
> +optimizations, like specializing functions for common parameters,
> +determing when global variables are clobbered, making functions pure/const,
> +propagating constants globally, removing unneeded data and others.
> +
> +It will also drop unused functions which can make the kernel
> +image smaller in some circumstances, in particular for small kernel
> +configurations.
> +
> +For small monolithic kernels it can throw away unused code very effectively
> +(especially when modules are disabled) and usually shrinks
> +the code size.
> +
> +Build time and memory consumption at build time will increase, depending
> +on the size of the largest binary. Modular kernels are less affected.
> +With LTO incremental builds are less incremental, as always the whole
> +binary needs to be re-optimized (but not re-parsed)
> +
> +Oopses can be somewhat more difficult to read, due to the more aggressive
> +inlining: it helps to use scripts/faddr2line.
> +
> +It is currently incompatible with live patching.

... because ?

-- 
Josh
