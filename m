Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B3F6A4D13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjB0VWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB0VWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:22:40 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9526522A21;
        Mon, 27 Feb 2023 13:22:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bx12so4514332wrb.11;
        Mon, 27 Feb 2023 13:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uirSLB3F9Zb+PTXXeLN0MPijsyHCQ2xWrITr0wlr88I=;
        b=em1V+lmvXOiXWqqGeAQ2IjGFqdAYg++TzAYPyddFCk1yvxJVYBcPgfgXN9g4P0axNn
         P4KLkVkBYvYpuOsXySp7nDPzjMSAQqBYLHcamLew9fzaR781fkBCt3i/CsN/hXGUuf33
         dFztapH6nIeAADdZo5yWhT2ErYWEjTRsC/cvP+ms0WC+8IWB/5Y6MJ9dZ2K2P/aajRSh
         3Z2jWmroWtD4hQXKbRnmnsjCnEdqyTWzn4YrdPPxR/vCA9nmFolM2J5nnNffSin1VF17
         XTbPQ92H9tVBVUOtShGCLaqxTWKxfr+roLG6yUJ63d5GyIY3/AFkfTlVfX5DSdj7a00v
         cOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uirSLB3F9Zb+PTXXeLN0MPijsyHCQ2xWrITr0wlr88I=;
        b=2TzcdNU9jXV0n3Gwu9GJ06vk+XFe5/HRVopUMHhf87OVHlNcGz/zEyY2MmglXWer2I
         zca5kT6xiOG9OTPvb80fqm7mtaOxsDNmCm8EtH4sajw2p4iagvbbUcjZit1VhYNF2aPu
         Pw6+8HfBQw7A4vn7KUoTp4BhXR8/PrRKbz5VOJr8+HqDLYJHCrfyfdujkG03E0wIgT7x
         p9G+OyV/DAIS0fZlseov692gLD4kRbq7PtMI61R/ZUzqc0G0GhBvHFN2DxREeNk8SP9h
         krMzoQPQhM2n/Hih/CxMuazCF5m2z5l6ANTP7msnbFt6l5S0/LKrWWcUYqpj0rZRmHmQ
         zVZw==
X-Gm-Message-State: AO0yUKXdEu+9yJuuxnEl746y4QRial3B6JSegAmYGTsNFyIaXaQOEvdg
        sKcL2cXqz6PDil45oQJ7InpX0K8p+i6c3FXEcLA=
X-Google-Smtp-Source: AK7set8ADg0kdUtzpW9qrUsTBlfAGHGWVV37/V1prUR1shzO/2nhTvB+GPKFW2eS1wh/uaj4v+GfSVYbARZ+xcmxqnM=
X-Received: by 2002:adf:d4c3:0:b0:2cc:4ed1:f849 with SMTP id
 w3-20020adfd4c3000000b002cc4ed1f849mr120657wrk.8.1677532956794; Mon, 27 Feb
 2023 13:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20230227151847.207922-1-lucas.tanure@collabora.com>
In-Reply-To: <20230227151847.207922-1-lucas.tanure@collabora.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 27 Feb 2023 16:22:23 -0500
Message-ID: <CAMdYzYrmq1ftBaBj1XHVWWXUQ4Prr1VpTpunyNOQ2ha-DkXMjQ@mail.gmail.com>
Subject: Re: [RFC 0/1] ITS fails to allocate on rk3588
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
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

On Mon, Feb 27, 2023 at 10:18 AM Lucas Tanure
<lucas.tanure@collabora.com> wrote:
>
> I am assisting with PCIe and networking bring-up for Rock Pi 5B (RK3588).
> This chip uses the same GICv3 as RK356X but has fixed the previous
> limitation of GIC only supporting 32-bit addresses.
>
> But the implementation decision for shareability in GICR and GITS is
> still the same.
>
> I read the previous thread about this topic:
> https://lore.kernel.org/lkml/2791594e-db60-e1d0-88e5-7e5bbd98ae4d@rock-chips.com/T/#m5dbc70ff308d81e98dd0d797e23d3fbf9c353245
>
> From my understanding, the errata numbers Marc Zyngier is referring to
> are found in Arm errata documents at developer.arm.com/documentation.
> But I could not find Cavium or Broadcom pages for errata with those
> numbers in Documentation/arm64/silicon-errata.rst
>
> I could not find an errata document about this shareability issue,
> and by what Kever said in the previous thread this could be a
> RockChip design decision.
>
> Marc, as I could only find ARM errata numbers, is the errata number
> you were expecting generated by ARM only, or RockChip should issue
> a document like Arm to detail the issue?
>
> Can this shareability issue be seen as a quirk without an
> errata number?
>
> The following patch is based on the work of Peter Geis for the
> Quartz64 board and the previous thread feedback.

I see you have included rk356x in this as well. This will only work on
rk356x boards that do not exceed 4GB of ram as the on chip devices are
only 32bit addressable and the kernel by default allocates this in
highmem.

Very Respectfully,
Peter Geis

>
> Lucas Tanure (1):
>   irqchip/gic-v3: Add RK3588 GICR and GITS no share workaround
>
>  Documentation/arm64/silicon-errata.rst |  4 +++
>  arch/arm64/Kconfig                     | 13 ++++++++
>  drivers/irqchip/irq-gic-v3-its.c       | 42 ++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>
> --
> 2.39.2
>
