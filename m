Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE01C670CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjAQXJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAQXGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:06:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25423C1B;
        Tue, 17 Jan 2023 13:34:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673991248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QIUMiMeO37HLXHmh1Ihwd/CfbMCTUhD4A8mHgM2Czpw=;
        b=TMgeBVYqAtYPEdUD25oT5SMdrISlzChdtJSl+ZUFGSTag87Nb03Fck3z8eBuYfXvTUjUe0
        B6C65sFML/MBmgBAaEpJAdOgl7806R+uzAAuiA2fAqWLbz6sDjYJNtgd01nkw5PSm7i2sg
        hYmuYan8mvZTEtPPuFCztDeUGbj3lpcBwdhog8DEMEM5+zCmQ7ul0j7IanXG8ayKF2EGiY
        cUAgImO7uposBpaa83UqdfwVTkyr58wVCB9FjQHoLcQLtr2oiDbiMB5uTP4g6LmodGheEU
        wQY3t8WpjtD0yU5VaJvqnMnivZPROjajdz0RQomk9xo8KO+opoC3mZHCJz4TGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673991248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QIUMiMeO37HLXHmh1Ihwd/CfbMCTUhD4A8mHgM2Czpw=;
        b=s+GLdJwkzpwBSI8hb81AMVA4pKM7Xk7hlF4wgMUeQB2lMoApgWmnSBjHnMqfmh1xC4fW+0
        PdBLHAuwtwYTpsAQ==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 07/19] irqdomain: Look for existing mapping only once
In-Reply-To: <20230116135044.14998-8-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-8-johan+linaro@kernel.org>
Date:   Tue, 17 Jan 2023 22:34:07 +0100
Message-ID: <87wn5kkfqo.ffs@tglx>
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
> Avoid looking for an existing mapping twice when creating a new mapping
> using irq_create_fwspec_mapping() by factoring out the actual allocation
> which is shared with irq_create_mapping_affinity().

This changelog is incomplete and it took me a while to figure out why
this is before the race fix.

The point is that you need __irq_create_mapping_affinity() later to fix
the shared mapping race. The double check avoidance is just a nice side
effect.

So please spell it out and make it clear that this needs to be
backported too, e.g. by adding:

The split out internal function will be used to fix a shared interrupt
mapping race. This change is therefore tagged with the same fixes tag.

Fixes: ....

>  
> +static unsigned int __irq_create_mapping_affinity(struct irq_domain *domain,
> +						  irq_hw_number_t hwirq,
> +						  const struct irq_affinity_desc *affinity)

Please rename to irq_create_mapping_affinity_locked() so it's clear what
this is about and what the calling convention is. A lockdep assert to
that effect would be nice too.

Thanks,

        tglx
