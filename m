Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397FA6363BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiKWPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbiKWPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:31:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1912037A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA7B61D97
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D79C433C1;
        Wed, 23 Nov 2022 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217449;
        bh=4dZb4bbu5nzbrpcp2lGes9HS8mCCcHsdRpxYEfzRlwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5MrsbnmZ0e9R/vIHwWihmiXz3synJ+YTNPwOjj8S2ToOkfV+b7gt6q6Yf0W6OpBj
         SghD9p6rqTgwFteO2uCV61k3JlOilkYlxCjmAkbq2CEefBDLhlJR1xWuSI5RKua6MI
         A8W7I1QOk3oJgZ6SrzRqPGUofGcQ1HDsyH5wFR7KO6dMbkMPSCivo65T5JfkciUadJ
         cZkQ6qvliDm8fnHu2lvkNP13ajAvacBFGqmC+6zUAhJ9Vvokrb+DxfXjTRnfiqqmba
         kAOIDchEPRuwFqlv2ngxcJ1eFOKb9wSregiDidcZpBCW6yJOpx9NtkdDaoEokv2BEZ
         zEofxybFcJQ+A==
Date:   Wed, 23 Nov 2022 23:20:59 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] riscv: vdso: fix section overlapping under some
 conditions
Message-ID: <Y346Ww9Dt2f1Kipl@xhacker>
References: <20221102170254.1925-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221102170254.1925-1-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:02:54AM +0800, Jisheng Zhang wrote:
> lkp reported a build error, I tried the config and can reproduce
> build error as below:
> 
>   VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
> ld.lld: error: section .note file range overlaps with .text
> >>> .note range is [0x7C8, 0x803]
> >>> .text range is [0x800, 0x1993]
> 
> ld.lld: error: section .text file range overlaps with .dynamic
> >>> .text range is [0x800, 0x1993]
> >>> .dynamic range is [0x808, 0x937]
> 
> ld.lld: error: section .note virtual address range overlaps with .text
> >>> .note range is [0x7C8, 0x803]
> >>> .text range is [0x800, 0x1993]
> 
> Fix it by setting DISABLE_BRANCH_PROFILING which will disable branch
> tracing for vdso, thus avoid useless _ftrace_annotated_branch section
> and _ftrace_branch section. Although we can also fix it by removing
> the hardcoded .text begin address, but I think that's another story
> and should be put into another patch.
> 
> Link: https://lore.kernel.org/lkml/202210122123.Cc4FPShJ-lkp@intel.com/#r
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Gentle ping? This fix is still missing in mainline.

> ---
> 
> Since v1:
>  - fix the issue by setting DISABLE_BRANCH_PROFILING
> 
>  arch/riscv/kernel/vdso/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index f2e065671e4d..d6092ff678fd 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -17,6 +17,7 @@ vdso-syms += flush_icache
>  obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
>  
>  ccflags-y := -fno-stack-protector
> +ccflags-y += -DDISABLE_BRANCH_PROFILING
>  
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
> -- 
> 2.37.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
