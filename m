Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42B64A2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiLLOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiLLOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:14:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F76E0C4;
        Mon, 12 Dec 2022 06:14:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670854474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VulB7zwTi0kemDdT1n64bpcErOOyRtll4L59c0fe90=;
        b=Kn2lcmYIxBVg4IIOPGSEGR/k1rxrXoI40fjq0Mi2Af8Pp1ZBkKGS0qXDP7lb+ypjzICgjp
        BEMtPaWgChGoZ89Aba7lMQePQSt0WnUDc8IvQiH/AD1K5sfCdM8L/Eol5/B8QnLgWSJvoj
        /xW6F9PbvVWykvvmZyQodCP/6fvIesyCPlLxNJ/SVDsdLThZSC2nawycWD64o6eZeovNAe
        lhEe6qcaPh+wsW8YvD2sTbHCqDoruRb2gGeWCbbwiNaF0geQ46HlVlp6frMAXKekQrsMlV
        lqWx7Bmj/vI4+mnvODASw7w2fHApB3XlXEhaj1ysKhU1AYeYwh8gPYeY69Hxog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670854474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VulB7zwTi0kemDdT1n64bpcErOOyRtll4L59c0fe90=;
        b=pEiYiypPCSz/2tWa+00h65aYJ3NOBXSMcRJNGIJf+cG2fJEbCiT5v7b6ioGMLLPiFzt3cH
        b7EAqQqwqlCyFzAg==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v3 19/19] irqdomain: Switch to per-domain locking
In-Reply-To: <20221209140150.1453-20-johan+linaro@kernel.org>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-20-johan+linaro@kernel.org>
Date:   Mon, 12 Dec 2022 15:14:34 +0100
Message-ID: <87mt7sbtf9.ffs@tglx>
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

On Fri, Dec 09 2022 at 15:01, Johan Hovold wrote:
> The IRQ domain structures are currently protected by the global
> irq_domain_mutex. Switch to using more fine-grained per-domain locking,
> which may potentially speed up parallel probing somewhat.
>
> Note that the domain lock of the root domain (innermost domain) must be
> used for hierarchical domains. For non-hierarchical domain (as for root
> domains), the new root pointer is set to the domain itself so that
> domain->root->mutex can be used in shared code paths.
>
> Also note that hierarchical domains should be constructed using
> irq_domain_create_hierarchy() (or irq_domain_add_hierarchy()) to avoid
> poking at irqdomain internals.

While I agree in principle, this change really makes me nervous.

Any fail in setting up domain->root correctly, e.g. by not using
irq_domain_create_hierarchy(), cannot be detected and creates nasty to
debug race conditions.

So we need some debug mechanism which allows to validate that
domain->root is set up correctly when domain->parent != NULL.

Thanks,

        tglx
