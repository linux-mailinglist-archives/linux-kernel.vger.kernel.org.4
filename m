Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E4613E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJaTV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaTVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E51712771
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 014A061440
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C57C433C1;
        Mon, 31 Oct 2022 19:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667244084;
        bh=o0Q9MbdmmncKUEHxnHZRV+zqBROs61ocnfVwIcKSVsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBmrcq+XXz4JAY9e02wNJrk6F4jYOd/jAfp8S8+JsCpTSD8oSyZ4sZB4yHG776g9w
         Ft73y3/tY1aeDTL9F3Ebfyaog0NIJ5WtEzdcNxz1kumyE4AJM9jDwNNyaCXHGWnZ3f
         /Tzpdtk28wx+9rUYA7BgEYX4IIaYqcqdd8oA/S3An3mpinQMZTOTjXjZUhoIX4Yih3
         /4Z1jp2adXePblNQPvfPUJmbNa+VgvSFAdjDU2DTW6O5qHJBEf3bqp5+pR8ifNDD1D
         0s5jH9Wntw/GxnJ4XwjWu4LGk7fFcbJ1VrDEySYvlN1pR36oCI2QWyK0GKaoErv1Cn
         AshK4OjoStjXw==
Date:   Mon, 31 Oct 2022 19:21:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: vdso: fix build with llvm
Message-ID: <Y2AgMLzH/RF1gQkB@spud>
References: <20221031182943.2453-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031182943.2453-1-jszhang@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 02:29:43AM +0800, Jisheng Zhang wrote:
> Even after commit 89fd4a1df829 ("riscv: jump_label: mark arguments as
> const to satisfy asm constraints"), building with CC_OPTIMIZE_FOR_SIZE
> + LLVM=1 can reproduce below build error:
> 
>   CC      arch/riscv/kernel/vdso/vgettimeofday.o
> In file included from <built-in>:4:
> In file included from lib/vdso/gettimeofday.c:5:
> In file included from include/vdso/datapage.h:17:
> In file included from
> include/vdso/processor.h:10:
> In file included from
> arch/riscv/include/asm/vdso/processor.h:7:
> In file included from
> include/linux/jump_label.h:112:
> arch/riscv/include/asm/jump_label.h:42:3: error:
> invalid operand fo
> r inline asm constraint 'i'
>                 "       .option push                            \n\t"
>                 ^
> 1 error generated.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

> 
> I think the problem is when "-Os" is passed as CFLAGS, it's removed by
> "CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os" which is
> introduced in commit e05d57dcb8c7 ("riscv: Fixup __vdso_gettimeofday
> broke dynamic ftrace"), thus no optimization at all for vgettimeofday.c
> arm64 does remove "-Os" as well, but it forces "-O2" after removing
> "-Os".
> 
> I compared the generated vgettimeofday.o with "-O2" and "-Os",
> I think no big performance difference. So let's tell the kbuild not
> to remove "-Os" rather than follow arm64 style.
> 
> vdso related performance can be improved a lot when building kernel with
> CC_OPTIMIZE_FOR_SIZE after this commit, ("-Os" VS no optimization)
> 
> Fixes: e05d57dcb8c7 ("riscv: Fixup __vdso_gettimeofday broke dynamic ftrace")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index f2e065671e4d..84ac0fe612e7 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -30,7 +30,7 @@ obj-y += vdso.o
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>  
>  # Disable -pg to prevent insert call site
> -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
>  
>  # Disable profiling and instrumentation for VDSO code
>  GCOV_PROFILE := n
> -- 
> 2.37.2
> 
