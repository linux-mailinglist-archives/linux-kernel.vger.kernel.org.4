Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361E7739DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjFVJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFVJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:51:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46BD955A4;
        Thu, 22 Jun 2023 02:42:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8EF51042;
        Thu, 22 Jun 2023 02:43:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B98963F663;
        Thu, 22 Jun 2023 02:42:14 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:42:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
Message-ID: <ZJQXdFxoBNUdutYx@FVFF77S0Q05N>
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJLzsWsIPD57pDgc@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:57:21PM +0100, Mark Rutland wrote:
> On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > Following boot warnings and crashes noticed on arm64 Rpi4 device running
> > Linux next-20230621 kernel.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > boot log:
> > 
> > [   22.331748] Kernel text patching generated an invalid instruction
> > at 0xffff8000835d6580!
> > [   22.340579] Unexpected kernel BRK exception at EL1
> > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] PREEMPT SMP
> 
> This indicates execution of AARCH64_BREAK_FAULT.
> 
> That could be from dodgy arguments to aarch64_insn_gen_*(), or elsewhere, and
> given this is in the networking code I suspect this'll be related to BPF.
> 
> Looking at next-20230621 I see commit:
> 
>   49703aa2adfaff28 ("bpf, arm64: use bpf_jit_binary_pack_alloc")
> 
> ... which changed the way BPF allocates memory, and has code that pads memory
> with a bunch of AARCH64_BREAK_FAULT, so it looks like that *might* be related.

For the benefit of those just looknig at this thread, there has been some
discussion in the original thread for this commit. Summary and links below.

We identified a potential issue with missing cache maintenance:

  https://lore.kernel.org/linux-arm-kernel/ZJMXqTffB22LSOkd@FVFF77S0Q05N/

Puranjay verified that was causing the problem seen here:

  https://lore.kernel.org/linux-arm-kernel/CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com/

Alexei has dropped this commit for now:

  https://lore.kernel.org/linux-arm-kernel/CAADnVQJqDOMABEx8JuU6r_Dehyf=SkDfRNChx1oNfqPoo7pSrw@mail.gmail.com/

Thanks,
Mark.
