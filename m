Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AC9606380
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJTOsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJTOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389731AE2BD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E06761BB2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBB3C433C1;
        Thu, 20 Oct 2022 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666277276;
        bh=KeuClFyItXAr2NxGDYmWyD1/MqyrreJJLWFewSUCVBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7IA0Bae6xgvWe0tFPlANFfmuUqMfq70YY1OhhrGfDk7kqVNbgcwGBdssix3Vb6at
         ugqrmDaDBDud8t3pzxZK6YaHhgE2HAmnLOb0LaeRIxopt+OoD4ZpmwUeUOdXzM28BO
         cFQJnLgWeuC8S1EwCpXQkuark4KrknEG5G4NVuTyeQLYI/ramnuMWX7ael1N2YBzkd
         CuumOldsvDn0pBUfyelEhjQWFnXbOE+xCKN9zl2GhRzHMLCfc3GcWtvVOzjZJPht2D
         0ybQvZR795KyoqrjWR6+5j8zlu3q32BjpuOqwiEYtdvlLvTvDNe8YXqllNQHd9njtD
         69Fei41GfYOQQ==
Date:   Thu, 20 Oct 2022 22:38:19 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
Message-ID: <Y1FdW8P9pw466hjV@xhacker>
References: <20221019154727.2395-1-jszhang@kernel.org>
 <CAJF2gTSHH69B+KAOJdpLvQdGuhS1nJ+GnW2hVCb+e+8nrnaJ7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTSHH69B+KAOJdpLvQdGuhS1nJ+GnW2hVCb+e+8nrnaJ7Q@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:16:47AM +0800, Guo Ren wrote:
> On Wed, Oct 19, 2022 at 11:57 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > Currently, when detecting vmap stack overflow, riscv firstly switches
> > to the so called shadow stack, then use this shadow stack to call the
> > get_overflow_stack() to get the overflow stack. However, there's
> > a race here if two or more harts use the same shadow stack at the same
> > time.
> >
> > To solve this race, we introduce spin_shadow_stack atomic var, which
> > will make the shadow stack usage serialized.
> >
> > Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Suggested-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/kernel/entry.S | 4 ++++
> >  arch/riscv/kernel/traps.c | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index b9eda3fcbd6d..7b924b16792b 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
> >
> >  #ifdef CONFIG_VMAP_STACK
> >  handle_kernel_stack_overflow:
> > +1:     la sp, spin_shadow_stack
> > +       amoswap.w sp, sp, (sp)
> If CONFIG_64BIT=y, it would be broken. Because we only hold 32bit of
> the sp, and the next loop would get the wrong sp value of
> &spin_shadow_stack.

Hi Guo,

Don't worry about it. the spin_shadow_stack is just a flag used for
"spin", if hart is allowed to used the shadow_stack, we load its
address in next instruction by "la sp, shadow_stack".
But I agree with use unsigned int instead of atomic_t, and use
smp_store_release directly. V2 has been sent out, could you please
review it?

Thanks
