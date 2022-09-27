Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E85EB644
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiI0A2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiI0A2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FC579A73
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DEB61524
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3603AC433D6;
        Tue, 27 Sep 2022 00:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664238486;
        bh=196d/MXQhFQtb6lq5NyscBwIT4g5hA6PUW5f6L4dGTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JrBcJhnw70G986UbtQOdtITn/sEzt1I6kEhCpGaLMYD+O6fYxwWJWlzq7png6q8qV
         WvsfliYUlQ5myg7DVRJ0qAh6JuB7nDreSL86qUEc3BGbrX0ccxnvv3YrgNWOdlc5Sg
         iWn8Bi6RigPzYv2HOKbyZkDVtOoRHQlH+Y3XF+V8PgjeLUcNNC40ZvmMOm8e5DNDCi
         ZWWZToeFdVQK1M6t/TnYV4rPGcP/VtGNPuW1dlv01Xxmg5e6DDXkOLQJ49PMWI9gfX
         szMz2zEUWhMe/f4fSlrp8OZ8Kadzj5XgZjz2BUvh6+katb6S/64hK1/RalOnFmhVCx
         S0ZvJwJhHG6XA==
Date:   Tue, 27 Sep 2022 08:18:38 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 3/4] riscv: fix race when vmap stack overflow and remove
 shadow_stack
Message-ID: <YzJBXsiWrbmxM6Q2@xhacker>
References: <20220925175356.681-1-jszhang@kernel.org>
 <20220925175356.681-4-jszhang@kernel.org>
 <CAJF2gTRFXwu5QtA8GywGaSVRPA7zeexcDHRzcngcY1zD3MFjog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTRFXwu5QtA8GywGaSVRPA7zeexcDHRzcngcY1zD3MFjog@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >  #ifdef CONFIG_VMAP_STACK
> > -static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
> > -               overflow_stack)__aligned(16);
> > -/*
> > - * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
> > - * to get per-cpu overflow stack(get_overflow_stack).
> > - */
> > -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
> > -asmlinkage unsigned long get_overflow_stack(void)
> > -{
> > -       return (unsigned long)this_cpu_ptr(overflow_stack) +
> > -               OVERFLOW_STACK_SIZE;
> > -}
> > +unsigned long overflow_stack[NR_CPUS][OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);

If NR_CPUS is large, there's a non-trival memory waste, I have a
solution for this case, will send a new version today.

Thanks
