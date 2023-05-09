Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4A6FC973
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjEIOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEIOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55661E6A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E90F2633C4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CCBC433EF;
        Tue,  9 May 2023 14:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683643744;
        bh=NBvpZ3SVsEm0RYtMI4MVcyA/5Q5NxM5iMqiiZpuJwog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYRH/oxwAZvnUeZPPirZXT7XWphCD4RiogIVrgR0hmbqX2nXQTT24uAmjwk6gbMu7
         rdbt7GsjiN/gVpBu9EodkLSk95qo4OzGy32rNn3B4iw3FCYWCG0cOVLC01M/oGpRYK
         h9suRxfgbB9B1abUln2d3A17GNmKVeEHCCZ+IHbWPiBcrhffOL/OJMB+LVCA208+V0
         yNAvnS4TXlvuq/yvOBgxbISxBplraaUTtpPg+cWZUxxCQipC3p++WVhI4ySs4trCW9
         YTooyDIqUO4mfR0WhY/yTmgzDQ/hM9yJGIQOnt+qbPHUGgJJKCI0SQZbVzrVmiPhDm
         JKBXF3mse5wUQ==
Date:   Tue, 9 May 2023 22:37:56 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: enable BUILDTIME_TABLE_SORT for !MMU
Message-ID: <ZFpaxItE8TUTXktH@xhacker>
References: <20230409164306.3801-1-jszhang@kernel.org>
 <20230411-flier-establish-d3ffd434be28@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230411-flier-establish-d3ffd434be28@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:37:36AM +0100, Conor Dooley wrote:
> Hey Jisheng,
> 
> On Mon, Apr 10, 2023 at 12:43:06AM +0800, Jisheng Zhang wrote:
> > BUILDTIME_TABLE_SORT works for !MMU as well, so enable it.
> > 
> > Tested on QEMU and FPGA.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> Fails to build for nommu_k210_defconfig:
> 
> make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- O=build -sk -j30
> no __ex_table in file: vmlinux

This failure log makes me carefully go through the ex_table mechanism
again. Now I knew where's the failure from and what should be done:
Because FUTEX is disabled in nommu_k210_defconfig. However, there's a
deeply hidden issue here: there should be no __ex_table section usage
at all in NOMMU case, becaue __ex_table usage relies on MMU to do the
*fixup*, so I need to patch the risc extable part instead.

Thanks

> Failed to sort kernel tables
> make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 1
> make[2]: *** Deleting file 'vmlinux'
> make[2]: Target '__default' not remade because of errors.
> make[1]: *** [/home/conor/stuff/linux/Makefile:1250: vmlinux] Error 2
> make[1]: Target '__all' not remade because of errors.
> make: *** [Makefile:226: __sub-make] Error 2
> make: Target '__all' not remade because of errors.
> 
> :(
> 
> > ---
> >  arch/riscv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index c5e42cc37604..212ea28e346b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -50,7 +50,7 @@ config RISCV
> >  	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
> >  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> >  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> > -	select BUILDTIME_TABLE_SORT if MMU
> > +	select BUILDTIME_TABLE_SORT
> >  	select CLINT_TIMER if !MMU
> >  	select CLONE_BACKWARDS
> >  	select COMMON_CLK
> > -- 
> > 2.40.0
> > 


