Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAED86482E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLINq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLINqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:46:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F161B85
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:46:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4F86225F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA0EC433D2;
        Fri,  9 Dec 2022 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670593611;
        bh=TlASoJDHYaWhrDt5BPhe7IzFbwqDKh9Cd5McTUZLrBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tk+X5/dU1g6PaaGUYWyVibBAA5OwblhN2TrEy84d5DYVJqTACTFuRDxxWU9N4Hc3P
         QmxKiIriUQ35EKEr1PblvcxNt+fOSBXdb6DQ8wTDAfn6X3jZeqFG/VqrpCTvXEidV9
         +Y8Lzv01CVcOk4q7CC2794xjkBcFBDqSoCA7irARZacnGw8gAMa/Fk3j4Tnbcmtcpd
         530JIVF9+0oyLYU7epHnkpc6uJ7x/doTFjCZ/GI0LDosywT3u/edcbOAwJUnsIGg2l
         BatLjAoWwpJa2t1Dyz8ex+mCPE/oAM6F/IaFZFo7wralUON909yZxNR4FPSCBZWg+Z
         Kmd/bKfMZ8APA==
Date:   Fri, 9 Dec 2022 06:46:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] x86/vdso: Conditionally export __vdso_sgx_enter_enclave
Message-ID: <Y5M8SZEN1N5Dt15X@dev-arch.thelio-3990X>
References: <20221109000306.1407357-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109000306.1407357-1-nathan@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping? The default switch was remerged a couple of days ago so builds
with tip of tree LLVM are going to be broken again:

https://github.com/llvm/llvm-project/commit/241dbd310599e3c1a0f1b0c9ced14c8b8760539e

Cheers,
Nathan

On Tue, Nov 08, 2022 at 05:03:07PM -0700, Nathan Chancellor wrote:
> Recently, ld.lld moved from '--undefined-version' to
> '--no-undefined-version' as the default, which breaks building the vDSO
> when CONFIG_X86_SGX is not set:
> 
>   ld.lld: error: version script assignment of 'LINUX_2.6' to symbol '__vdso_sgx_enter_enclave' failed: symbol not defined
> 
> __vdso_sgx_enter_enclave is only included in the vDSO when
> CONFIG_X86_SGX is set. Only export it if it will be present in the final
> object, which clears up the error.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1756
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> It would be nice if this could be picked up for an -rc release but I
> won't argue otherwise.
> 
> Alternatively, we could add '--undefined-version' to the vDSO ldflags
> but this does not seem unreasonable to me.
> 
>  arch/x86/entry/vdso/vdso.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
> index 4bf48462fca7..e8c60ae7a7c8 100644
> --- a/arch/x86/entry/vdso/vdso.lds.S
> +++ b/arch/x86/entry/vdso/vdso.lds.S
> @@ -27,7 +27,9 @@ VERSION {
>  		__vdso_time;
>  		clock_getres;
>  		__vdso_clock_getres;
> +#ifdef CONFIG_X86_SGX
>  		__vdso_sgx_enter_enclave;
> +#endif
>  	local: *;
>  	};
>  }
> 
> base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
> -- 
> 2.38.1
> 
> 
