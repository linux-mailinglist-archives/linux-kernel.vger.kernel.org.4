Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194C568298B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjAaJws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjAaJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:52:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F07121
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:52:42 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675158760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x+Xn5MR4DXcZgmBMmJD7cXKI4JygC518oEsnEgJ4evQ=;
        b=LkZ03zwVg4+47HBXEqQXWUspPb3rQsRJcs1YCZ785pLgAWbtLCAyTNw2hUHJ2F5iwuSvHQ
        QrhFKXCTEDIBSa6ExaM5vtovAIYCMZQU7FWY1g9Pye4SjDXgBh/OFHn9o8CQVMETr8ojXV
        K4ezDqFdpv83Ki9EQBh3Yym4Hc3W2DlIsHkJUg+5P3N8ctk8Qbb6u26273Hm87RA5VksVn
        3ySYnqVfydbOIgiijsUufY1KHo4OC7l/1Qmr8cKEGce3T8gWgYsNL38faowFxzR+ChrCNo
        iblBkW9MPV8LFT+yFFUprwqjxMuf23nGny/ifIWimXLQi6RKLqqvMJlXBNi6jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675158760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x+Xn5MR4DXcZgmBMmJD7cXKI4JygC518oEsnEgJ4evQ=;
        b=FLgyx4dNzx2LlfVqbpujjqeACt08mXnt2QqrkPJPaZVLil1PgFoJtUrEXaf+/5zFU+O0av
        OgPyFQfa63WeftDQ==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <20230130005725.3517597-6-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-6-sdonthineni@nvidia.com>
Date:   Tue, 31 Jan 2023 10:52:40 +0100
Message-ID: <87edrb115j.ffs@tglx>
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
> The current implementation uses a static bitmap and a radix tree
> to manage IRQ allocation and irq_desc pointer store respectively.
> However, the size of the bitmap is constrained by the build time
> macro MAX_SPARSE_IRQS, which may not be sufficient to support the
> high-end servers, particularly those with GICv4.1 hardware, which
> require a large interrupt space to cover LPIs and vSGIs
>
> The maple tree is a highly efficient data structure for storing
> non-overlapping ranges and can handle a large number of entries,
> up to ULONG_MAX. It can be utilized for both storing IRQD and

IRQD ??. Please write it out: interrupt descriptors

Changelogs have no space constraints and there is zero value to
introduce unreadable acronyms.

>  static DEFINE_MUTEX(sparse_irq_lock);
> -static DECLARE_BITMAP(allocated_irqs, MAX_SPARSE_IRQS);
> +static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
> +					MT_FLAGS_ALLOC_RANGE |
> +					MT_FLAGS_LOCK_EXTERN |
> +					MT_FLAGS_USE_RCU, sparse_irq_lock);

Nit. Can we please format this properly:

static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
						      MT_FLAGS_ALLOC_RANGE |
					              MT_FLAGS_LOCK_EXTERN |
					              MT_FLAGS_USE_RCU,
                                                      sparse_irq_lock);

Other than that this looks really good.

Thanks,

        tglx
