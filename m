Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A469C6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjBTIff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBTIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:35:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F3C656
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:35:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3341260D14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A52FC433EF;
        Mon, 20 Feb 2023 08:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676882122;
        bh=t6o76SpkKeY0IDaJlCcpDVZz0b59aNg8O2fMx9z3208=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=da/twIOg+FJsGXDHG1kgjRR4NcXBO0fHM5I3FX69wQMCMrn5RWwc9FJQR9uQzpF96
         kQfj/xoa6H2p4yHQQlkJ+JPVFiyWb9PPL0vA/+fnCEjfwfg1exTPPRJ7HKZNCS6ws2
         h5CaUJpaOJmiSk9TqBmn1gwd06LTr7M3I2qSHThNaNOlNtnQirLqpM7042vkmj0nsd
         V+aTDXnDyp6NhkCHjm7A0M//dx3+gGGkTVkKIp7LKscxcviSeOKJq7te0ZjGPHa1py
         5oc6lMnMfAX7gM+jPP/az7ZCjXOZhiQtJm1Tm4Uly7b1PnH4kBc5dMbohZmYVrHfW0
         z2egG6w/f4z7Q==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pU1do-00Bjku-3c;
        Mon, 20 Feb 2023 08:35:20 +0000
MIME-Version: 1.0
Date:   Mon, 20 Feb 2023 08:35:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        tglx@linutronix.de, daniel.lezcano@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH v16 0/9] RISC-V IPI Improvements
In-Reply-To: <mhng-a886c4b4-d748-420f-889b-76ada4f9a432@palmer-ri-x1c9>
References: <mhng-a886c4b4-d748-420f-889b-76ada4f9a432@palmer-ri-x1c9>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0a0d1a182cef674a8e70347b2ed6f67b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: palmer@dabbelt.com, apatel@ventanamicro.com, paul.walmsley@sifive.com, tglx@linutronix.de, daniel.lezcano@linaro.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, atishp@atishpatra.org, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-15 03:17, Palmer Dabbelt wrote:
> On Sun, 05 Feb 2023 03:04:14 PST (-0800), Marc Zyngier wrote:
>> On Tue, 03 Jan 2023 14:12:12 +0000,
>> Anup Patel <apatel@ventanamicro.com> wrote:
>>> 
>>> This series aims to improve IPI support in Linux RISC-V in following 
>>> ways:
>>>  1) Treat IPIs as normal per-CPU interrupts instead of having custom 
>>> RISC-V
>>>     specific hooks. This also makes Linux RISC-V IPI support aligned 
>>> with
>>>     other architectures.
>>>  2) Remote TLB flushes and icache flushes should prefer local IPIs 
>>> instead
>>>     of SBI calls whenever we have specialized hardware (such as 
>>> RISC-V AIA
>>>     IMSIC and RISC-V SWI) which allows S-mode software to directly 
>>> inject
>>>     IPIs without any assistance from M-mode runtime firmware.
>> 
>> [...]
>> 
>> I'm queuing patches 3 and 9 via the irqchip tree as they are
>> standalone.
>> 
>> For the rest, I need an Ack from the riscv maintainers as they change
>> a large amount of arch-specific code, and the couple of irqchip
>> patches depend on these changes.
>> 
>> Palmer, Paul?
> 
> I haven't gotten time to give this a proper review, but I think we've
> got enough of a mess with our interrupt handling that it doesn't
> really matter so
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> if you want to take it for this cycle that's fine with me, but I'm
> also fine holding off so it can have a while to bake in linux-next --
> there's no real rush for any of this, as there's no hardware yet.

Letting this sort of things simmering in -next is the way.

Now that the basic dependencies are on their way, I'd expect this to be
rebased on 6.3-rc1, and we can then put the whole thing in -next.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
