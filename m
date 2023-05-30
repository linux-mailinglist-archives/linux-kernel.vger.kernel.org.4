Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A87171BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjE3Xcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjE3Xcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:32:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC02AA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=nDJNB5RsBNc/267tcoLdyXS5Pr7u3K4HW7e+y/CbLTI=; b=S3uWmXaNkVmx1wLRs+WbmhKzhJ
        f1eOkqSZI4hppj8w4KQ9eGmbxaDeAtvXJqe+ZqXnM6iTM4oAkntGWVNzJ2zjzV91ucuuA5IqCeErn
        Gz/vCc+XLzeROXBTY8YA4IZbEk/6xYtbubw1vmqheD3AdhnGQ1NJDTNrp58umiJyXgpr1O00imNhO
        X0Xjs/4dooG4GwVSVeG40UOPQBmdOVrQNB5bI9nsPkQQUE07TD3blp8Pt5B5AvXXNqO5RvDBQhM+Q
        UnRKnkNxNXnLMG4ofH+zyoRfF553bWfO3f9F8vAbm17TAeMmCF4/S75PdchNrDNMTbKcMOQRw79/r
        4CEbJrCw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q48pX-00FUCe-25;
        Tue, 30 May 2023 23:32:43 +0000
Message-ID: <89452cc1-5322-58f1-0f4a-41c2ad201be7@infradead.org>
Date:   Tue, 30 May 2023 16:32:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] genirq: fasteoi resends interrupt on concurrent
 invoke
Content-Language: en-US
To:     James Gowans <jgowans@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Liao Chang <liaochang1@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
References: <20230530213848.3273006-1-jgowans@amazon.com>
 <20230530213848.3273006-2-jgowans@amazon.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230530213848.3273006-2-jgowans@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/30/23 14:38, James Gowans wrote:

> ---
>  kernel/irq/chip.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 49e7bc871fec..42f33e77c16b 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -692,8 +692,15 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>  
>  	raw_spin_lock(&desc->lock);
>  
> -	if (!irq_may_run(desc))
> +	/*
> +	 * When an affinity change races with IRQ delivery, the next interrupt
> +	 * can arrive on the new CPU before the original CPU has completed
> +	 * handling the previous one. Mark it as pending and return EOI.
> +	 */
> +	if (!irq_may_run(desc)) {
> +		desc->istate |= IRQS_PENDING;
>  		goto out;
> +	}
>  
>  	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>  
> @@ -715,6 +722,12 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>  
>  	cond_unmask_eoi_irq(desc, chip);
>  
> +	/*
> +	 * When the race descibed above happens, this will resend the interrupt.

	                 described

> +	 */
> +	if (unlikely(desc->istate & IRQS_PENDING))
> +		check_irq_resend(desc, false);
> +
>  	raw_spin_unlock(&desc->lock);
>  	return;
>  out:

-- 
~Randy
