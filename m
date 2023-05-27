Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B4713517
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjE0ODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjE0ODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 10:03:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47F7DE
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 07:03:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685196210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XT9gU+956IkVzI5VTXefgPIIchLxY1FctVNSDZ2ODtY=;
        b=d2S9EJScNV630kZPlOSBoxoF3x394Wj6J2ui4UNIgnHtPLwtS0le98NLwWxomBKtH0fyXm
        gSVpDJCdPFbvn5S9SXGd0ejDcfsnMFjEtdtYvR7vToOWx2PbYQz5+v1kAE+Rh0h4FZngCJ
        nM5yurqUoAaZcHGt1BaQIgzjCc/tUm/tSgnlBwG9kpPPpxlhB0GZhMGKCZgTjVho5Onu6b
        bkcCr2GDFtebJJALMQWW6AbFWj78eObZQJjXAWIdHibvSSfb78GOPVt+FRXyMONHOgPybo
        LKLGlEihLmNvMJCTrmwZxROTvRpQNX7bRrTxMf6yFupju+VCG3nl9iNlk9TqvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685196210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XT9gU+956IkVzI5VTXefgPIIchLxY1FctVNSDZ2ODtY=;
        b=6y+r/bgvUNj/CYIPdUMHMhPWSwFWfYtFQc5u8oQTlBc76/FGS95gTLGFOWal4wlksPmuil
        wKWvkisQts/6RdBQ==
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of
 msi_domain_prepare_irqs()
In-Reply-To: <20230527054633.704916-2-chenhuacai@loongson.cn>
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn>
Date:   Sat, 27 May 2023 16:03:29 +0200
Message-ID: <87pm6llvm6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27 2023 at 13:46, Huacai Chen wrote:
> Adjust the return value semanteme of msi_domain_prepare_irqs(), which
> allows us to modify the input nvec by overriding the msi_domain_ops::
> msi_prepare(). This is necessary for the later patch.
>
> Before:
> 0 on success, others on error.
>
> After:
> = 0: Success;
>> 0: The modified nvec;
> < 0: Error code.

This explains what the patch does, but provides zero justification for
this nor any analysis why this is correct for the existing use cases.

That longsoon MSI domain is a PCI MSI domain. PCI/MSI has already a
mechanism to return the actual possible number of vectors if the
underlying space is exhausted.

Why is that not sufficient for your problem at hand?

Thanks,

        tglx
