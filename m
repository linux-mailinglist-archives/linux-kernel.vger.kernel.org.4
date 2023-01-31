Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08276828EF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAaJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjAaJf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:35:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393CD2C65A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:35:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675157723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eV5/KEkNQGWz25tW3OYTKb2cABS1ZDHAiWPDary3xd4=;
        b=1YxPNiJAGc1R9YTT56TLqSSp1wi0xwNJaG7+HDix/NDMBaUeCOfGbyIfMX/3MAYkJWk5hO
        ptztqqloTZvq9q7MFpa+2JbW+3fxnZFkbe3KA443vkBCdde+cyMjFd6hKOuHW6Zc+UEthB
        JIqxYYtAaroFv5WOziH2EHsY+oQG+/8jYcr7Yccjb5p/Ahbjc4PxeacPOMp4pH9Ip2nYuU
        V5IbvKLAp2xGWG1s++XA922I9nbt7HzY45WYchWfsi3JHujBxST5Gfr1AE9FuswOzTE+d/
        h+/0dTRSRCXhUDAzl2j2tBnWub11kkrBT/5xYdCMkCuSzWkz1VgX5L1f+8+F0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675157723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eV5/KEkNQGWz25tW3OYTKb2cABS1ZDHAiWPDary3xd4=;
        b=dw+IrB4J6V4Rki7cKSI9U8Vr45E2HcAhbShVXAPy+phcIGYN2FQwFDORIfsVWDbvuxWWPZ
        r7icZ3fLA/xLjNDw==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] genirq: Use the common function irq_expand_nr_irqs()
In-Reply-To: <20230130005725.3517597-5-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-5-sdonthineni@nvidia.com>
Date:   Tue, 31 Jan 2023 10:35:23 +0100
Message-ID: <87h6w711yc.ffs@tglx>
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

On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:

> Subject: genirq: Use the common function ...

  genirq: Unify irq_expand_nr_irqs()

  irq_expand_nr_irqs() is implemented as a stub function for !SPARSEIRQ
  builds. That's not necessary as the SPARSEIRQ version returns -ENOMEM
  correctly even for the !SPARSEIRQ case as the ....


But this common function is non-obvious for the !SPARSEIRQ case. It at
least needs a comment

> +static int irq_expand_nr_irqs(unsigned int nr)
> +{
> +	if (nr > MAX_SPARSE_IRQS)
> +		return -ENOMEM;
> +	nr_irqs = nr;
> +	return 0;
> +}

or preferrably something like this:

	if (!IS_ENABLED(CONFIG_SPARSEIRQ) || nr > MAX_SPARSE_IRQS)
		return -ENOMEM;

which makes it entirely clear and also allows the compiler to optimize
is down to a 'return -ENOMEM'.

Thanks,

        tglx
