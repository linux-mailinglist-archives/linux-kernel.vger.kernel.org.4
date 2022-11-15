Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D121462AE18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKOWRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKOWRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:17:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C12271F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8632E61522
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D82BC433C1;
        Tue, 15 Nov 2022 22:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668550652;
        bh=0hu7rKCEN7EFEfQlBLLzIaScplCM3c5RZS+5NSeqKAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pEMH4orDzHDiNvbLvQQI0vvUFneS7XXW+lBWsmjjvGTxHw7FthyZ8ACBRJ9ZAafEp
         8fXBRcxEjfmu/ZkqgZg6FjJqrL461SNq4SN3KBAlqcrAxI+0UWreMhHdkCZBExDDyg
         bt9Rofs8zCs3WqEiSDNYCoWQhf9AFb/TpwOIzVmS3LIIViZnio42Z3WQGN2cBNDTV0
         o6HWlJ5MmUZ2EQNX1RARcN2M2ronhI1W5ZfCeBYJXiVcR66EwfjDmoWFPtm7daUw3F
         RoNmU+0HUjSop/wTxPsuJalBuPFAhczLY0W7/1QgXxXRhgSwZ/N/XOwEhZt/0fCxQC
         xpsduM0buvSrg==
Date:   Tue, 15 Nov 2022 22:17:27 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Vineet Gupta <vineetg@rivosinc.com>
Cc:     Conor.Dooley@microchip.com, bjorn@kernel.org,
        stillson@rivosinc.com, greentime.hu@sifive.com,
        guoren@linux.alibaba.com, vincent.chen@sifive.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        ajones@ventanamicro.com
Subject: Re: [PATCH v12 04/17] riscv: Add vector feature to compile
Message-ID: <Y3QP9zjM3a4yifvi@spud>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-4-stillson@rivosinc.com>
 <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
 <98343aa8-b04d-fe58-8af8-4eeca03106d1@microchip.com>
 <9cda597c-1d31-4b8b-99ba-deab58975976@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cda597c-1d31-4b8b-99ba-deab58975976@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 09:38:53AM -0800, Vineet Gupta wrote:
> On 11/13/22 08:16, Conor.Dooley@microchip.com wrote:
> > > > +config VECTOR
> > > > +     bool "VECTOR support"
> > > > +     depends on GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
> > > > +     default n
> > > > +     help
> > > > +       Say N here if you want to disable all vector related procedure
> > > > +       in the kernel.
> > > > +
> > > > +       If you don't know what to do here, say Y.
> > > > +
> > > > +endmenu
> > > "VECTOR" is not really consistent to how the other configs are named;
> > > RISCV_ISA_V, RISCV_ISA_VECTOR, RISCV_VECTOR?
> > It'd be RISCV_ISA_V to match the others single letter extentions, right?
> 
> Yep.
> 
> > The toolchain dependency check here also seems rather naive.
> 
> Indeed. I can build the code just fine with gcc-11 (and gcc-12), although my
> reworked patcheset doesn't include all the orig patches including the
> in-kernel xor stuff.

By naive here I meant that checking cc alone is probably not a
sufficient check for whether the toolchain supports the extension.
What about the assembler etc?

With Zicbom and Zihintpause we ran into problems with mixed usage, eg
binutils 2.35 + gcc 12. In his Zicboz series Drew has gone with insn
definitions - but while that's okay for something small like Zicboz,
do we want to do that for something with as many instructions as vector?

The alternative is cc-option, but that feels a lot less clean than what
Drew cooked up here:
https://lore.kernel.org/linux-riscv/20221027130247.31634-1-ajones@ventanamicro.com/

I've not checked this because I am lazy, but I am also assuming that
whoever put clang-13 in there picked it such that it doesn't require
experimental extensions flags. Mostly just writing this to remind myself
to check it at some point.
