Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0524688491
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjBBQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjBBQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:36:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9336A6A33D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:36:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3195161BF7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1953FC433EF;
        Thu,  2 Feb 2023 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675355776;
        bh=JytctRnLlmIQWNjAzhvXjLyHz2fxuSYWfasVqPSiFbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejpBmvWqofPsVRnlh+Aksey5eg0wIpLSXz9WQMa6HvO4WwE00TY4q0TdohUFhbKab
         oKmEmhXcTzBaodCHEZGnHj9boK9rd8Pj7y+R3rsgttcy04XdCRNb/rbJ7wWWQOHagG
         52pAygw16+yZMT3j80dvwTGM24fuQmNQk6q0nCnvhneUwfl5IZi+FXBCAEIqtPG9Vg
         y6dnsjaherSc173i1mVO+4dtlDacQKVYiv2LYO62l+UQU2rg+RMphek4SlwE3MHh7n
         DVM+8TngSeFGTNePYBxPART7PWayF4jHNhaCiPvW7NPTBoY8Zh+T96gkMK7zb4QTH3
         7RxEarDiVsPuw==
Date:   Fri, 3 Feb 2023 00:25:41 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dao Lu <daolu@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
Message-ID: <Y9vkBZknfDOHGZzu@xhacker>
References: <20220922060958.44203-1-samuel@sholland.org>
 <167523607081.29266.3967297527966644183.b4-ty@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <167523607081.29266.3967297527966644183.b4-ty@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:21:10PM -0800, Palmer Dabbelt wrote:
> On Thu, 22 Sep 2022 01:09:58 -0500, Samuel Holland wrote:
> > commit 8eb060e10185 ("arch/riscv: add Zihintpause support") broke
> > building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.0):
> > 
> >   CC      arch/riscv/kernel/vdso/vgettimeofday.o
> > In file included from <command-line>:
> > ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> > ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 probably does not match constraints
> >   285 | #define asm_volatile_goto(x...) asm goto(x)
> >       |                                 ^~~
> > ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
> >    41 |         asm_volatile_goto(
> >       |         ^~~~~~~~~~~~~~~~~
> > ././include/linux/compiler_types.h:285:33: error: impossible constraint in 'asm'
> >   285 | #define asm_volatile_goto(x...) asm goto(x)
> >       |                                 ^~~
> > ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
> >    41 |         asm_volatile_goto(
> >       |         ^~~~~~~~~~~~~~~~~
> > make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> > make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> > 
> > [...]
> 
> Applied, thanks!

Hi Palmer,

I assume the build error is already fixed in v6.1 and can't be reproduced.

Thanks
> 
> [1/1] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>       https://git.kernel.org/palmer/c/3c349eacc559
> 
> Best regards,
> -- 
> Palmer Dabbelt <palmer@rivosinc.com>
