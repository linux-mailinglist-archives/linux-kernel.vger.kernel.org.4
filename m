Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37669606C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJUAf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUAf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:35:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166861826C1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBDADB828C8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E81C43470
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666312552;
        bh=ebitv/o5a3t2vCAKwhBaDXqxzD0jZBqetTbv566wUVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YcRHuMRftYy8Glj3XCW+I+nrnBuBC63V8zTtPY69YECK5cMpDmSz8PpaSbppNGAnH
         d6r3fVonDsL9zIZ533WW7iPsjeUq+gjgmXikx97XMT19fBzrpanTZFqxoID7MOLVK/
         PTvH448HQVycptTwP0OkM8nE9oIQfDVZdPZS5LBe7xkf5Dc9u9V3pOPCvacEvsZ2LU
         jCYy2b/yN9Hw2plUQKUFHYduzEydNnO/AvBaeskou5xXeV1eE2kjpHIADgGig34ysc
         GL8iboDA4oPapAc8xQMCamcEMMhYQY+1gnBAL/eady9s54Al4iLZWpBQ02YpZxD2D8
         cd/evoR5SVMFg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-136b5dd6655so1673925fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:35:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf2TcmiQFHCyE96EYRzkhQ29LHTPNA7Z47wIyCT7XmS+TFx/wY7l
        z2dVEJU/n0nlidJDRl9P+1h2Ky8IQ2k2VNX0JPo=
X-Google-Smtp-Source: AMsMyM483SkhaxijeF6r4LxLvwyIKbEq8gBp3QOrTCWYxzdlRCXzMtRRLH1LvqBfhZHASUiwUujSnBYnGQq9tiW7nTc=
X-Received: by 2002:a05:6871:b0d:b0:13b:b91:dc94 with SMTP id
 fq13-20020a0568710b0d00b0013b0b91dc94mr2542683oab.112.1666312551610; Thu, 20
 Oct 2022 17:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221019154727.2395-1-jszhang@kernel.org> <CAJF2gTSHH69B+KAOJdpLvQdGuhS1nJ+GnW2hVCb+e+8nrnaJ7Q@mail.gmail.com>
 <Y1FdW8P9pw466hjV@xhacker>
In-Reply-To: <Y1FdW8P9pw466hjV@xhacker>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Oct 2022 08:35:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTBYR-6xGo_SrORrjJw9rYQXLukHwBFCNq_kwNLrd_1VA@mail.gmail.com>
Message-ID: <CAJF2gTTBYR-6xGo_SrORrjJw9rYQXLukHwBFCNq_kwNLrd_1VA@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:47 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Thu, Oct 20, 2022 at 10:16:47AM +0800, Guo Ren wrote:
> > On Wed, Oct 19, 2022 at 11:57 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > >
> > > Currently, when detecting vmap stack overflow, riscv firstly switches
> > > to the so called shadow stack, then use this shadow stack to call the
> > > get_overflow_stack() to get the overflow stack. However, there's
> > > a race here if two or more harts use the same shadow stack at the same
> > > time.
> > >
> > > To solve this race, we introduce spin_shadow_stack atomic var, which
> > > will make the shadow stack usage serialized.
> > >
> > > Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/kernel/entry.S | 4 ++++
> > >  arch/riscv/kernel/traps.c | 4 ++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > index b9eda3fcbd6d..7b924b16792b 100644
> > > --- a/arch/riscv/kernel/entry.S
> > > +++ b/arch/riscv/kernel/entry.S
> > > @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
> > >
> > >  #ifdef CONFIG_VMAP_STACK
> > >  handle_kernel_stack_overflow:
> > > +1:     la sp, spin_shadow_stack
> > > +       amoswap.w sp, sp, (sp)
> > If CONFIG_64BIT=y, it would be broken. Because we only hold 32bit of
> > the sp, and the next loop would get the wrong sp value of
> > &spin_shadow_stack.
>
> Hi Guo,
>
> Don't worry about it. the spin_shadow_stack is just a flag used for
> "spin", if hart is allowed to used the shadow_stack, we load its
> address in next instruction by "la sp, shadow_stack".
Haha, yes, my brain is at fault :)

> But I agree with use unsigned int instead of atomic_t, and use
> smp_store_release directly. V2 has been sent out, could you please
> review it?
Okay

>
> Thanks



-- 
Best Regards
 Guo Ren
