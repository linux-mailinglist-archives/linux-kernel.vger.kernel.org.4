Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1F66E73B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAQTnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjAQTjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:39:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840EB6DB35
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:42:42 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673980960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6A0GDQmx7bbYxY5J0Tn5P+sjPqfL//EZx5j6CgC+wos=;
        b=i+rlitMLRQob9/um2VZLcmmazLMKxU3UFL5lVbfNgbL2K3bv2Ec72lTl5dsCkXwkecXw8t
        FLEhWa5wuxruuZFcWwAI/Xhd61JhQoPTiWPS9NmikpPGURe6ezzuzyDgPkzSjX8fEidsIF
        KBu662JT9wuckgzE8s3TVJCo5pk0RLrO90i2tcubXc1tlFy1FTzY/9OATY2ta6gbg5WpCK
        Ican950wZa+/fAUmBPO3aW7BhdOYdZhCFO53qBRN9xNzzzCyTwYgHvu5YZvAwsie2w840J
        BD28pfMGTQaYTbp5++JQyLumBJYYzxwEuJixl2Qh7YP5vmwQwwJYqwKXWwpWNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673980960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6A0GDQmx7bbYxY5J0Tn5P+sjPqfL//EZx5j6CgC+wos=;
        b=9VnkkO55aZMm77gsHAc53FMm2dlE5CbZoYSLb7DCOomXNZqfGlxftLXZFHtAJ94njwwbkx
        bNj5Ulb2i6eFJhCw==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Kalle Valo <kvalo@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Omri Barazi <obarazi@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] genirq/msi: Free the fwnode created by
 msi_create_device_irq_domain()
In-Reply-To: <0-v1-9195b42af947+89-msi_leak_jgg@nvidia.com>
References: <0-v1-9195b42af947+89-msi_leak_jgg@nvidia.com>
Date:   Tue, 17 Jan 2023 19:42:39 +0100
Message-ID: <87fsc9knog.ffs@tglx>
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

Jason!

On Tue, Jan 17 2023 at 11:27, Jason Gunthorpe wrote:
>  void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
>  {
> +	struct fwnode_handle *fwnode = NULL;
>  	struct msi_domain_info *info;
>  	struct irq_domain *domain;
>  
> @@ -1025,7 +1026,10 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
>  
>  	dev->msi.data->__domains[domid].domain = NULL;
>  	info = domain->host_data;
> +	if (irq_domain_is_msi_device(domain))
> +		fwnode = domain->fwnode;
>  	irq_domain_remove(domain);
> +	irq_domain_free_fwnode(fwnode);

This can't work with !device domains because then fwnode is NULL and
irq_domain_free_fwnode() will trip over its feet.

Instead of checking the NULL pointer here, we can just make
irq_domain_free_fwnode() NULL pointer tolerant. See below.

Thanks,

        tglx
---

--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -114,7 +114,7 @@ void irq_domain_free_fwnode(struct fwnod
 {
 	struct irqchip_fwid *fwid;
 
-	if (WARN_ON(!is_fwnode_irqchip(fwnode)))
+	if (!fwnode || WARN_ON(!is_fwnode_irqchip(fwnode)))
 		return;
 
 	fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
