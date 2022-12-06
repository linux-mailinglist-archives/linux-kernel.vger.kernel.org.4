Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91C464458E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiLFOX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiLFOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:23:21 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1438B8;
        Tue,  6 Dec 2022 06:23:18 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a7so17341631ljq.12;
        Tue, 06 Dec 2022 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sT1QGkgmhBkSpHiyhRuKPI4cqNjm9QnBwa8ft8tm2b4=;
        b=l+v/q+gX2uTMHA9ZkYaAEAOtqVZdgJNwEosrM3dkEf7jw4tHyTliypQOHtJCtyU/H9
         W7Rb7+6szCYzuywkLj8Zzm8bXfov7G34xh+DWePoSoe3mUbB9RTRgb4Eoe8P5za4HhYo
         dqM6Rl8x97B2IcqV6Bbti5ExuCNlqSZ8XCLIBcuNfbACL6rR0FzgrSP3QuLtkaV1X83p
         WDR8LXEIKzHxXYaMLxwysL+5yuFzANOq60Tmx256kIMgIGLGL+c3zdZhTjoEc6bXyMzb
         mTf2P51kB/RnI5TnC6bBnUbYBNumrfqdbQAc+5FEo9sqIrbg9zjykdwwm5+wVohhP2yH
         79Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT1QGkgmhBkSpHiyhRuKPI4cqNjm9QnBwa8ft8tm2b4=;
        b=A5IexOMxQnEjjrD2SOPKM7O5gWs8dGbKRGjquroWM/VLDY3YEl99XIsnSIvLPH6krs
         uWyhMSPqocrnCrb816oyMBcrSWmqAsdoLS9SI7+SZq8rz9mpYOl0EOrLfWXNNTYoLsjk
         uCnlgLfKP6I5/W/d6gvDx5XoaqDZIJ3lXiiJVH4bzytDF3Vs5PecpfWXdqXZlChzHhKK
         sx5ti9MJ/UNuUosD8s21NWjIhjX7cC0k7VsuZ7ZEafTCZ1cvu0OUJXTi5WNWwx36YGy0
         veeYTOru9oEbuMKaAPbax9RQGGxH1WbX2xorH1uzDLi6lt35TcA4qR7gxPRFx4nI/IRG
         SYGA==
X-Gm-Message-State: ANoB5plJLyVLshTEfwhpoYUT3RcskW6TkPPbjo6IC8TSGBporqFX36hS
        mt50nl/h4efXWmbVAN7BFG1fAfUCmDSclqly0SzuOPk8
X-Google-Smtp-Source: AA0mqf48L7a4pxzGkZLU939Pac44paZk+6TCPskq0MapimEioj6zash50V+a81kf7aJotA75z78shCuZOCge67gFClo=
X-Received: by 2002:a2e:a22f:0:b0:27a:d4:f94f with SMTP id i15-20020a2ea22f000000b0027a00d4f94fmr2544512ljm.499.1670336596229;
 Tue, 06 Dec 2022 06:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20221205050038.195746-1-bmeng@tinylab.org> <b3aff238-c473-e587-dd04-cc5ef4517722@kernel.org>
In-Reply-To: <b3aff238-c473-e587-dd04-cc5ef4517722@kernel.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 6 Dec 2022 22:23:04 +0800
Message-ID: <CAEUhbmVBLLppJdnw5CUiD+Vpj1jaGQ7FTZGVr4xT0_LaA7qSjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: Adapt Arm semihosting earlycon driver to RISC-V
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Bin Meng <bmeng@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 2:47 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 05. 12. 22, 6:00, Bin Meng wrote:
> ...
> > --- a/drivers/tty/serial/earlycon-arm-semihost.c
> > +++ b/drivers/tty/serial/earlycon-arm-semihost.c
> ...
> > @@ -23,7 +27,18 @@
> >    */
> >   static void smh_putc(struct uart_port *port, unsigned char c)
> >   {
> > -#ifdef CONFIG_ARM64
> > +#if defined(CONFIG_RISCV)
> > +     asm volatile("addi    a1, %0, 0\n"
> > +                  "addi    a0, zero, 3\n"
> > +                  ".balign 16\n"
> > +                  ".option push\n"
> > +                  ".option norvc\n"
> > +                  "slli    zero, zero, 0x1f\n"
> > +                  "ebreak\n"
> > +                  "srai    zero, zero, 0x7\n"
> > +                  ".option pop\n"
> > +                  : : "r" (&c) : "a0", "a1", "memory");
> > +#elif defined(CONFIG_ARM64)
> >       asm volatile("mov  x1, %0\n"
> >                    "mov  x0, #3\n"
> >                    "hlt  0xf000\n"
>
> Hmm, can we implement all those smh_putc() variants in respective
> arch/*/include/semihost.h instead?
>

I think so. Will do in v2.

Regards,
Bin
