Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EFB670CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAQXGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAQXEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:04:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7DC3C22;
        Tue, 17 Jan 2023 13:34:42 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673991280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AeA8HWTNyA+542Yy1mnW9CN08TqGtQG3B/ZL09l8uA=;
        b=rPZbbB9sKHo88rdQ3OGBFgtrGJ9u+bOjIl1UgP8rccLaNOWw1AURrjE1FyttmcBp8WPkzM
        w3Wd/bVVK5MGFa50151Bqa0BJzVN5nTIj0QfQ+6zfdj8Fs4oaSpZli4SAhzQK9MOHjsAX0
        trASDeaGpvYDg8Q5wBbswi9BpRxvz1jNwMHv2np2Agtnz1bTwa+qNk5J/NgrS2XAEy2AqN
        lqEjpxX2Q2QYSQXe4i64FZ4T+MpH6nRBUBKZ61rZa3zN6+rLz4J9UDOnHfg803nrqvyVgS
        f6SEOJgcOY1UFUx9Fpb9biZe721ptRHSJdFS27fvIbED3PzZFT95lFDk7w/5rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673991280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AeA8HWTNyA+542Yy1mnW9CN08TqGtQG3B/ZL09l8uA=;
        b=8PeqowJt1eEpwm8buo/EdAdgx5K4vk8M25cJyKrjNd9GznhMFa+Id3HxZVjnX5ja/gmNyr
        hW5dqFIElLwshyDw==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 08/19] irqdomain: Refactor __irq_domain_alloc_irqs()
In-Reply-To: <20230116135044.14998-9-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-9-johan+linaro@kernel.org>
Date:   Tue, 17 Jan 2023 22:34:40 +0100
Message-ID: <87v8l4kfpr.ffs@tglx>
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

On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:

> Refactor __irq_domain_alloc_irqs() so that it can be called internally
> while holding the irq_domain_mutex.
>
> This will be used to fix a shared-interrupt mapping race.

No functional change. The split out internal function will be used to
fix a shared interrupt mapping race. This change is therefore tagged
with the same fixes tag.

Fixes: ....

> -int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
> -			    unsigned int nr_irqs, int node, void *arg,
> -			    bool realloc, const struct irq_affinity_desc *affinity)
> +static int ___irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
> +				    unsigned int nr_irqs, int node, void *arg,
> +				    bool realloc, const struct irq_affinity_desc *affinity)

__ vs. ___ is almost undistinguishable.

irq_domain_alloc_irqs_locked() nicely explains what this is about, no?

Thanks,

        tglx
