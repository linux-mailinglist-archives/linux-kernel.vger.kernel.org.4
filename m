Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18C5EB751
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiI0CAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiI0CAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:00:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C777868B0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F02C7B81693
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DFFC4347C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664244032;
        bh=19gy2EXbjjLD/l6XeEJeQfh5wNSKslif73XxWJJiya4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UycWZTDWCpwFEzNOCYzx0660ef5vI8AHfyoSmAGCveyhYBvSAuNxwgJA/vQsJV97o
         +S54clXZbOM3d7MoE0FvzwTOK0HGrNwPwp8yX4GWqhg8qZ82AvjLVgQEGkmajpiKal
         TsNeZ9ZBSWai24xZDwzpQQ4GVsGyCbMMA/TfdFVDQ5f3MQQgwheis7qbNUsWeD7n++
         oJLT1YOU9vWDnreDLshC+mDdOByl/rfHot2LU7npXCXPz5Z42Vn2zvninr7YXD/+gB
         KlOFx/YbLe1AcP3WN9HiKszD4IL5nX05NYGl8ii1PxUAJXiQ30CLXgfuivTlPreosu
         QRnftSuWrko6g==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-127dca21a7dso11551651fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:00:32 -0700 (PDT)
X-Gm-Message-State: ACrzQf3P5NKJm/eaSh0b35qU8RpARlKlNWaisk4Zdl6HodKeUvkJ6Y3X
        5b9rfFvYW6+5H1lAjjHG1uwQBaF+MV0HKdwghMA=
X-Google-Smtp-Source: AMsMyM5ea5e0PE9duPI0AiEm3Ci2ukaIEq7zGlDwmLWiQdey/Aoh7alxANCLZBRyNiFXJfv7kKNa2U+oumBHvVoRuxw=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr937824oao.112.1664244031696; Mon, 26
 Sep 2022 19:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220925175356.681-1-jszhang@kernel.org> <20220925175356.681-4-jszhang@kernel.org>
 <CAJF2gTRFXwu5QtA8GywGaSVRPA7zeexcDHRzcngcY1zD3MFjog@mail.gmail.com> <YzJBXsiWrbmxM6Q2@xhacker>
In-Reply-To: <YzJBXsiWrbmxM6Q2@xhacker>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Sep 2022 10:00:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRkPc7AQsUNZopevey61PD8o6BQBZKjgeLHmOgX+pj6dA@mail.gmail.com>
Message-ID: <CAJF2gTRkPc7AQsUNZopevey61PD8o6BQBZKjgeLHmOgX+pj6dA@mail.gmail.com>
Subject: Re: [PATCH 3/4] riscv: fix race when vmap stack overflow and remove shadow_stack
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 8:28 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
>
> > >  #ifdef CONFIG_VMAP_STACK
> > > -static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
> > > -               overflow_stack)__aligned(16);
> > > -/*
> > > - * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
> > > - * to get per-cpu overflow stack(get_overflow_stack).
> > > - */
> > > -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
> > > -asmlinkage unsigned long get_overflow_stack(void)
> > > -{
> > > -       return (unsigned long)this_cpu_ptr(overflow_stack) +
> > > -               OVERFLOW_STACK_SIZE;
> > > -}
> > > +unsigned long overflow_stack[NR_CPUS][OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
>
> If NR_CPUS is large, there's a non-trival memory waste, I have a
> solution for this case, will send a new version today.
Er...

Yes, we can't bypass the percpu mechanism. I also forgot the percpu
basic concept. In the end, I prefer the previous solution, maybe just
simply giving an atomic flag would be okay. (But we only have one
register (sp) which could be used, it seems not simple.)

>
> Thanks



-- 
Best Regards
 Guo Ren
