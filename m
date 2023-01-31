Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA16827FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjAaJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjAaJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:03:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20626873
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:59:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675155578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+j2tS0z65DOC1i27lvoAnzWZSJ6RAt+rY7G1fVCJLg=;
        b=aillpvAd7JK0GYfd805/ukWb92tg+/sfF4/t/upYsUjuC+FW+mv7K+KGku+ziGb7iPQONs
        yJ5jv74wQ5kAf3U4YJN4raB/wwPdePDFgbNklup/cCzKpJB4wSb6FCgHRkyjEavRMkTq+j
        JPQynPNQ1BcA23veteEN/rn5DGrQ6A0oWwdAFt3n4M2Y9Ru8e5ulBwwL2qcBWKdG995jxv
        yRpVWYsGDxOxnPuwVTboLZbm0GcVqF1gDwI2xhqWZkyWe/c3k/tJFAWtg3Ul97uU4ddWow
        Rg4CdXZwAKh8MJiOfJzXBHFTnPTF2EGwkcrxlgJaaI2gwbwvikm6OFgV1J/Szw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675155578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+j2tS0z65DOC1i27lvoAnzWZSJ6RAt+rY7G1fVCJLg=;
        b=RLrP4M612KLDXKBC2b9FAUwEKB/CgyBnTdYZAp2Xu3i0UNska62vI7ByURH9Jx06qaKctg
        xjn7oxwTd+/bI5BA==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] genirq: Use hlist for managing resend handlers
In-Reply-To: <20230130005725.3517597-2-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-2-sdonthineni@nvidia.com>
Date:   Tue, 31 Jan 2023 09:59:37 +0100
Message-ID: <87pmav13ly.ffs@tglx>
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
> +/* hlist_head to handle software resend of interrupts: */
> +static HLIST_HEAD(irq_resend_list);
> +static DEFINE_RAW_SPINLOCK(irq_resend_lock);
>  
>  /*
>   * Run software resends of IRQ's
> @@ -30,18 +31,16 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>  static void resend_irqs(struct tasklet_struct *unused)
>  {
>  	struct irq_desc *desc;
> -	int irq;
> -
> -	while (!bitmap_empty(irqs_resend, nr_irqs)) {
> -		irq = find_first_bit(irqs_resend, nr_irqs);
> -		clear_bit(irq, irqs_resend);
> -		desc = irq_to_desc(irq);
> -		if (!desc)
> -			continue;
> +	struct hlist_node *n;
> +
> +	raw_spin_lock_irq(&irq_resend_lock);
> +	hlist_for_each_entry_safe(desc, n, &irq_resend_list, resend_node) {
> +		hlist_del_init(&desc->resend_node);
>  		local_irq_disable();
>  		desc->handle_irq(desc);
>  		local_irq_enable();
>  	}
> +	raw_spin_unlock_irq(&irq_resend_lock);

The lock ordering is broken here. irq_sw_resend() is invoked with
desc->lock held and takes irq_resend_lock.

Lockdep clearly would have told you...

	raw_spin_lock_irq(&irq_resend_lock);
        while (!hlist_empty(...)) {
        	desc = hlist_entry(irq_resend_list.first, ...);
		hlist_del_init(&desc->resend_node);
                raw_spin_unlock(&...);
                desc->handle_irq();
                raw_spin_lock(&...);
        }        

Hmm?

Thanks,

        tglx
