Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F671470B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjE2J1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2J1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:27:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3AAC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:27:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685352450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9oP66CShv0wsXW7Wvc+5XvMH74LdvQ2kHTVempZbao=;
        b=0fMICRZaJTgn5JAKL78GogJ/1jaAH+tUacjala8qMFTXYwjhGgcUhArVgS9F7E38KOeTBV
        RVF+5HoUDDgpFJ/3VmomkAqCAt+vTMC/sNoQ3YggQKnjaypDBeXdsDjs6zr0RqU+hmkHne
        ApyMCzYEDKfkYCOLFW+Q1rnXLxgR45ESmMjUhEMzx97INL2mom02nBbHRjzHnzcVNgs0rj
        +J/ZTy7M2ZDWfUtVpv2hZUrDFSqbm7mwQzL60XNuJECwbTnplAwhNtWsdLRiaKVDG5VCyc
        w0ngIbsHyRFimSn8b0nayjhL7y/PuKBKfYlxOZNvzQ/EhaUSvjB1BuDEI0d4Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685352450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9oP66CShv0wsXW7Wvc+5XvMH74LdvQ2kHTVempZbao=;
        b=nX8V5aF/Xav4vH1QPSThVgfc/HoGNPiEvTWUlRqDnfEQGdOwrpFy+PQc/rgeC45js5pLkm
        QqPI04hgot9PYaAQ==
To:     Huacai Chen <chenhuacai@gmail.com>, Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of
 msi_domain_prepare_irqs()
In-Reply-To: <CAAhV-H6KpNhL5VvumvhcAKGOpe-EO0zfzm_xPprP0rTVf18Leg@mail.gmail.com>
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx>
 <86fs7gdhid.wl-maz@kernel.org>
 <CAAhV-H6KpNhL5VvumvhcAKGOpe-EO0zfzm_xPprP0rTVf18Leg@mail.gmail.com>
Date:   Mon, 29 May 2023 11:27:29 +0200
Message-ID: <87ilcblc72.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28 2023 at 20:07, Huacai Chen wrote:
> On Sun, May 28, 2023 at 3:47=E2=80=AFPM Marc Zyngier <maz@kernel.org> wro=
te:
>>
>> Being able to allocate MSIs is not a guarantee, and is always
>> opportunistic. If some drivers badly fail because the they don't get
>> the number of MSIs they need, then they need fixing.
>
> Yes, I know allocating MSIs is not a guarantee, and most existing
> drivers will fallback to use legacy irqs when failed. However, as I
> replied in an early mail, we want to do some proactive throttling in
> the loongson-pch-msi irqchip driver, rather than consume msi vectors
> aggressively. For example, if we have two NICs, we want both of them
> to get 32 msi vectors; not one exhaust all available vectors, and the
> other fallback to use legacy irq.

By default you allow up to 256 interrupts to be allocated, right? So to
prevent vector exhaustion, the admin needs to reboot the machine and set
a command line parameter to limit this, right? As that parameter is not
documented the admin is going to dice a number. That's impractical and
just a horrible bandaid.

Thanks,

        tglx


