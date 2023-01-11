Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF30266631A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjAKSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbjAKSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:52:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26953D5DF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:52:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673463163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttuLldY4Pi3UmGhGAJKRPa4PS1VhLCj3NNSYMZ/cf5Q=;
        b=nzxu0gLLYJTkf5ZiYW7CY3jrR+VCSVh6N5vxmZ9rsR4ceES6/lgAGKfxrfGMcSdJnlyt8V
        aZJeT4/VttZv7XCuVq2yPKuaySzqvxhKLzvmzMyjCvp+DympFCmiWMKH4mmkbZ2krVYX5t
        AXNMMfdm/kpsJLPphJRyX/XxPv9CVfmrrTxH+sMIEYXKsyEVcbgly/Aj3pI3c4TMAahrsn
        5GK+B1ho41Bs2Py2puxOzIldZnXInlsrgvoDkfkIeiJ5VCavBIOtJ4Zuw/scA2F4O6aXX/
        Cgse8tUhNfbM5N019bCNiM4fHvQn0c5FELqHMRQi1UVL6Z/98pF+tWsS4k10TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673463163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttuLldY4Pi3UmGhGAJKRPa4PS1VhLCj3NNSYMZ/cf5Q=;
        b=oF8+oX6j+iTKCzfG74NyYUi7q4vrceplUWYR/1y8bamslXWgKovdcFT8XGTmOcT91KmO0O
        uzG5BN+06p0xJFBw==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 2/2] genirq/irqdomain/msi: Add
 irq_domain_alloc_irqs_affinity() wrapper
In-Reply-To: <20221213140844.15470-3-johan+linaro@kernel.org>
References: <20221213140844.15470-1-johan+linaro@kernel.org>
 <20221213140844.15470-3-johan+linaro@kernel.org>
Date:   Wed, 11 Jan 2023 19:52:42 +0100
Message-ID: <87358ggayt.ffs@tglx>
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

On Tue, Dec 13 2022 at 15:08, Johan Hovold wrote:
> The full __irq_domain_alloc_irqs() interface was initially only intended
> for some legacy (x86) use cases while most callers should use the
> irq_domain_alloc_irqs() wrapper.
>
> Add a matching irq_domain_alloc_irqs_affinity() wrapper that can be used
> when an affinity hint needs to be provided and use it for MSI
> allocations.

I definitely like the irqchip cleanup, but this one is core code and
having the extra wrapper is not really buying us much.

Thanks,

        tglx
