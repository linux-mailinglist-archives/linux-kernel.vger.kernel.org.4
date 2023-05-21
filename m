Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0870ADCD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjEULsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjEUKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:38:21 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6D7199E;
        Sun, 21 May 2023 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1684665065; bh=OyPM9NsCxMx6I9tXXMiKqYnKHKcV0KAitdqe+nojJM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pXEYe5cTzBo5VbxQSbXyGzPY6WEbMcmPPd5OuFuDayxaVmH/S9WuwexVEHC4z66In
         mFmrBb6Fh5U4VI1O9Xw5zx1By6kYpELq3XG9nSQGt+72Tjx0ql3L1cRFFAT4gGkrFT
         4XSOnEPi4iZkw7fQM/o79gNg/zbLmWHy3xdR/dlQ=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 311D060132;
        Sun, 21 May 2023 18:31:05 +0800 (CST)
Message-ID: <a31415d5-ca4e-49fa-60d7-9cd53ba5a680@xen0n.name>
Date:   Sun, 21 May 2023 18:31:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH V1 2/4] irqchip/loongson-pch-pic: Fix potential incorrect
 hwirq assignment
Content-Language: en-US
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Liu Peibao <liupeibao@loongson.cn>, stable@vger.kernel.org
References: <20230520063818.27208-1-lvjianmin@loongson.cn>
 <20230520063818.27208-3-lvjianmin@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230520063818.27208-3-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/20 14:38, Jianmin Lv wrote:
> From: Liu Peibao <liupeibao@loongson.cn>
> 
> In DeviceTree path, when ht_vec_base is not zero, the hwirq of PCH PIC will
> be assigned incorrectly. Because when pch_pic_domain_translate() adds the
> ht_vec_base to hwirq, the hwirq dose not subtract the ht_vec_base when

"does not have the ht_vec_base subtracted"?

> calling irq_domain_set_info().
> 
> The ht_vec_base is designed for the parent irq chip/domain of the PCH PIC.
> It seems not proper to deal this in callbacks of the PCH PIC domain and
> let's put this back like the initial commit ef8c01eb64ca ("irqchip: Add
> Loongson PCH PIC controller").
> 
> Fixes: bcdd75c596c8 ("irqchip/loongson-pch-pic: Add ACPI init support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>   drivers/irqchip/irq-loongson-pch-pic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
> index 921c5c0190d1..93a71f66efeb 100644
> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> @@ -164,7 +164,7 @@ static int pch_pic_domain_translate(struct irq_domain *d,
>   		if (fwspec->param_count < 2)
>   			return -EINVAL;
>   
> -		*hwirq = fwspec->param[0] + priv->ht_vec_base;
> +		*hwirq = fwspec->param[0];
>   		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>   	} else {
>   		if (fwspec->param_count < 1)
> @@ -196,7 +196,7 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
>   
>   	parent_fwspec.fwnode = domain->parent->fwnode;
>   	parent_fwspec.param_count = 1;
> -	parent_fwspec.param[0] = hwirq;
> +	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
>   
>   	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
>   	if (err)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

