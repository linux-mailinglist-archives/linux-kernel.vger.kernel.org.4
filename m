Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63463FDFC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiLBCJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiLBCJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:09:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C4BB3933
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:09:05 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669946944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chh0G08/xLk5pzy1L0Ry5SpkFEB3qVhaXDAsS5cW5fs=;
        b=L0E7sVyXw6Jblb0n5un5BreQdt4t9bg+f6AbFVIwch5tO/p7/v/6ezmKLmT+d0U7IIXZX/
        YlAgyNIpBX7wL5RuPYhq3r17HBE4V/2WMiOEm2ux+QUFGqsXHevHU5fO1iB5N5ieUJhAkE
        ZQd3hk+wmotVsMxBsqpZwocbPbR90jaz3dVjR24pYwOGG3+Cr3Zkd3xkmGmbUaQXbapxhW
        bRyPfurZkZ/mjwGxDXVkq6cBDF5NAfSE4BaiZ3ypdhh/LVXAwzifTXapMBxyAgds6DxpdI
        HiMvuPGCu7yKRJ5X1CgoACn7mnXUtGkBhX6/lMqoHTffsC6OqFPWtGJVQtfF1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669946944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chh0G08/xLk5pzy1L0Ry5SpkFEB3qVhaXDAsS5cW5fs=;
        b=Lwd+x2kzC4/ZmsV/t8MGhzJYxEo68p+5PgJlbQB65r9+GRtwHW0l3RjbRPJiu+Bo6gYCi8
        cEfMNp0XEBWYvtCw==
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 3/8] genirq: Add mechanism to multiplex a single HW IPI
In-Reply-To: <CAK9=C2WN57hHUz=3SDruyWPdAobn+QP8uGwugjPAobeFG7dBkw@mail.gmail.com>
References: <20221201130135.1115380-1-apatel@ventanamicro.com>
 <20221201130135.1115380-4-apatel@ventanamicro.com> <87v8mvqbvq.ffs@tglx>
 <CAK9=C2WN57hHUz=3SDruyWPdAobn+QP8uGwugjPAobeFG7dBkw@mail.gmail.com>
Date:   Fri, 02 Dec 2022 03:09:03 +0100
Message-ID: <87h6yer1z4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anup!

On Thu, Dec 01 2022 at 23:30, Anup Patel wrote:
> On Thu, Dec 1, 2022 at 10:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > irqchip driver and it is shared by various RISC-V irqchip drivers.
>>
>> Sure, but now we have two copies of this. One in the Apple AIC and one
>> here. The obvious thing to do is:
>>
>>    1) Provide generic infrastructure
>>
>>    2) Convert AIC to use it
>
> Mark Z already has a converted version of AIC driver.
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/ipi-mux

You are submitting generic infrastructure which is supposed to go
through the relevant maintainer tree and not be funneled through some
riscv branch.

So obviously this very maintainer asks the predictable question and also
wants to see the Acked/Tested-by of the folks who maintain apple-AIC.

How is that supposed to work without integrating this patch into your
series and without having the apple-AIC folks on cc?

You did not start kernel development as of yesterday, right?

Thanks,

        tglx
