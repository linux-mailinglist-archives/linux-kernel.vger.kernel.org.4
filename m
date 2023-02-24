Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D126A1B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBXLYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBXLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:24:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C77136C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:24:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7E652CE235D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B698DC433EF;
        Fri, 24 Feb 2023 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677237873;
        bh=9aONgM0t91DAUrni1sQSIqjLB4LIW5B8ISxMZGcx34o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfAqtqPvjSDj7VQdkiZaBCk84WocOmdAV8XoJFTAPPFrFkDx2h84Gd908uFcOkYKv
         S8goIqLh7tCbD5JJ2qAiA9pGHungMCINR9OvqsogL3x88OtBoHS3vaRJf/wDjgzuvi
         lq6//BSEJFWIsLd3w91KI/rODimosGJTeGML5K7dHEjcikaqfC4Id0Vx3O8xGUJl7u
         l7WwoW8T8lXdtAgbklG1tnqYMZtkUUa1fNQXuYK6JURwhy/W/FhJqrNtzYeC1EeDHW
         x0FzqfkPyiiVDpX/LZBm7xb/Y0qE3bPJuI34oCWr86aEMdFPJVmnyUvt8PFb8Svtdg
         IM+Cg9mVZK+Bg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pVWBx-0004pT-BS; Fri, 24 Feb 2023 12:24:45 +0100
Date:   Fri, 24 Feb 2023 12:24:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqdomain: fix regression for Xen guests
Message-ID: <Y/iefavPQ95lkzDe@hovoldconsulting.com>
References: <20230223083800.31347-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223083800.31347-1-jgross@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 09:38:00AM +0100, Juergen Gross wrote:
> The recent switch to per-domain locking caused a NULL dereference in
> irq_domain_create_hierarchy(), as Xen code is calling
> msi_create_irq_domain() with a NULL parent pointer.

This was unexpected. Apparently the Intel VMD driver also does this (see
vmd_enable_domain()).

> Fix that by testing parent to be set before dereferencing it. For a
> non-existing parent the irq-domain's root will stay to point to
> itself.

An alternative could be to have msi_create_irq_domain() handle the
no-parent case explicitly, but this looks the right fix for now (e.g. as
irq_domain_create_tree() does not take a flag parameter).

> Fixes: 9dbb8e3452ab ("irqdomain: Switch to per-domain locking")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  kernel/irq/irqdomain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index aa5b7eeeceb8..6522dfb2e49c 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1172,7 +1172,8 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
>  		domain = __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
>  
>  	if (domain) {
> -		domain->root = parent->root;
> +		if (parent)
> +			domain->root = parent->root;
>  		domain->parent = parent;
>  		domain->flags |= flags;

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
