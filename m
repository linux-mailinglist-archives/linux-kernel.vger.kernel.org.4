Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1B622094
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKIADD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKIADA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:03:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7630AB7D5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 16:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27F0EB81CAB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178D0C433C1;
        Wed,  9 Nov 2022 00:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667952176;
        bh=1XAvvGmXAV0rKXk7VUNfUl0vYbJHJkoGa9C/F5unFa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3RdZhRrtNmHZcJkbbQXYCwwKtvFCVjp+chtgcH50CK2NK+PAMBGwg4mfU7/edKXo
         D4jAFh+f8uqDE6dm7QZ+IkkgaNnoSSt5rfsBVoyak8wPgEhTxviwNArwr+2CuGO+x4
         TmO1bkgQGKIqV+qr3FOy8V1cfF3riga6jcgXdXDTpWwGDxLjHWuQqRQVLH3/w/kMFp
         H7UQwVc7Na0O+6Wkgz9T2a29TgLl1h5IAlCaUeWpTUE2rcSGQiMaKT5oV3M6/TPLF6
         QgVodkuMy2LIuMxhGg7CD3VN/GOWQjRhn4ZtaB+w7RS4R7FNl5xeJh3ueyddm3js7A
         CFJpkjXLIBTDg==
Date:   Wed, 9 Nov 2022 00:02:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] RISC-V: vdso: Do not add missing symbols to version
 section in linker script
Message-ID: <Y2ruLKgi2D05YYfy@spud>
References: <20221108171324.3377226-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108171324.3377226-1-nathan@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:13:23AM -0700, Nathan Chancellor wrote:
> Recently, ld.lld moved from '--undefined-version' to
> '--no-undefined-version' as the default, which breaks the compat vDSO
> build:
> 
>   ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_gettimeofday' failed: symbol not defined
>   ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_clock_gettime' failed: symbol not defined
>   ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_clock_getres' failed: symbol not defined
> 
> These symbols are not present in the compat vDSO or the regular vDSO for
> 32-bit but they are unconditionally included in the version section of
> the linker script, which is prohibited with '--no-undefined-version'.
> 
> Fix this issue by only including the symbols that are actually exported
> in the version section of the linker script.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1756

Fixed the build for me on 99fe3d266108 ("[mlir][sparse] 3-dimensional
sparse tensor insertion test")

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks!

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/riscv/kernel/vdso/Makefile   | 3 +++
>  arch/riscv/kernel/vdso/vdso.lds.S | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index f2e065671e4d..82416ebf4cca 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -28,6 +28,9 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>  
>  obj-y += vdso.o
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
> +ifneq ($(filter vgettimeofday, $(vdso-syms)),)
> +CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
> +endif
>  
>  # Disable -pg to prevent insert call site
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> index 01d94aae5bf5..150b1a572e61 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -68,9 +68,11 @@ VERSION
>  	LINUX_4.15 {
>  	global:
>  		__vdso_rt_sigreturn;
> +#ifdef HAS_VGETTIMEOFDAY
>  		__vdso_gettimeofday;
>  		__vdso_clock_gettime;
>  		__vdso_clock_getres;
> +#endif
>  		__vdso_getcpu;
>  		__vdso_flush_icache;
>  	local: *;
> 
> base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
> -- 
> 2.38.1
> 
