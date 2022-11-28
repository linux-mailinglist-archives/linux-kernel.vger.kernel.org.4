Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD6E63AB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiK1Oji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiK1Oje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:39:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B51F61D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:39:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669646370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOGWCJyU8EVxbLr5IAwg4Ny/+aVspQhOJziRpfWUgmA=;
        b=ZZiUK7j3HebzWllRNO35cuCZ+iWCsiKJH0UzeGKtN9iZCAqnIHogTKtoIh6s8T+zsE6xIv
        gqYR0jrNIuQC/73JxwsMr3yVToqFIZRqxNKacqLfKw2uYcQlN7N33C5vs6BszNKPEDJ8S1
        i4uMxKhhOewxgehMA4cOhVIzztV9slo1VJgffs3wn0lm3UkJ6HQb9DPeqOSiNJQpVRWo1Q
        K1U7p+/PNnvx93/B+KZ4Up4HKvdPaI0FWZe1y2ryeDa8k9V5Gs89h+FsjjhMi12Mte+odO
        yIR0V4jkHqfeUVF+AYgmafktjw0O0MxX5eXHYjsuFhoicPgB4QiomuyXspkZhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669646370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOGWCJyU8EVxbLr5IAwg4Ny/+aVspQhOJziRpfWUgmA=;
        b=HINP/bxMrPA0BiazclPBS999ipnKOTfVfFRDxhSbuZbzS9084j4/L6Ez9xwOLB/LitoNVU
        HtLstR6kqk/y5BBA==
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch V3 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
In-Reply-To: <20221124232326.501359457@linutronix.de>
References: <20221124230505.073418677@linutronix.de>
 <20221124232326.501359457@linutronix.de>
Date:   Mon, 28 Nov 2022 15:39:30 +0100
Message-ID: <8735a3w3bx.ffs@tglx>
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

On Fri, Nov 25 2022 at 00:26, Thomas Gleixner wrote:
> +struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
> +				       const struct irq_affinity_desc *affdesc,
> +				       union msi_instance_cookie *icookie)
> +{
> +	struct msi_ctrl ctrl = { .domid	= domid, .nirqs = 1, };
> +	struct msi_domain_info *info;

Remove

> +	struct irq_domain *domain;
> +	struct msi_map map = { };
> +	struct msi_desc *desc;
> +	int ret;
> +
> +	msi_lock_descs(dev);
> +	domain = msi_get_device_domain(dev, domid);
> +	if (!domain) {
> +		map.index = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	desc = msi_alloc_desc(dev, 1, affdesc);
> +	if (!desc) {
> +		map.index = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	if (icookie)
> +		desc->data.icookie = *icookie;
> +
> +	ret = msi_insert_desc(dev, desc, domid, index);
> +	if (ret) {
> +		map.index = ret;
> +		goto unlock;
> +	}
> +
> +	ctrl.first = ctrl.last = desc->msi_index;
> +	info = domain->host_data;

Pointless

> +	ret = __msi_domain_alloc_irqs(dev, domain, &ctrl);
> +	if (ret) {
> +		map.index = ret;
> +		msi_domain_free_locked(dev, &ctrl);
> +	} else {
> +		map.index = desc->msi_index;
> +		map.virq = desc->irq;
> +	}
> +unlock:
> +	msi_unlock_descs(dev);
> +	return map;
> +}
> +
>  static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
>  				   struct msi_ctrl *ctrl)
>  {
