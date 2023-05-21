Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8622070ADB0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjEULqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjEUKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:46:38 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8655A1A4;
        Sun, 21 May 2023 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1684665977; bh=ROm0pJOZNyVDKEAis1Y6Eci8XLW7KJHTxO8fnKHcE5k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mH+YJ27HMqhNsQjU+h8lFEiVcwuIQDEP7IoCIvHgdTVn5XPDbyx19NbUrmnYvOaFY
         LOz2TDlA91owpQ0zButjzTnK2/BYfFDlFq7NDtdtvjCcCYE8oKF4fEKKN+1qRGpem8
         GUqAhxAxB55f5Pt/rh+uzS/s8WEO7YeePbFRbjAU=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 4A09A60115;
        Sun, 21 May 2023 18:46:17 +0800 (CST)
Message-ID: <4a08b133-4ead-083e-4ddb-519e12a0dad6@xen0n.name>
Date:   Sun, 21 May 2023 18:46:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH V1 3/4] irqchip/loongson-liointc: Fix IRQ trigger polarity
Content-Language: en-US
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
References: <20230520063818.27208-1-lvjianmin@loongson.cn>
 <20230520063818.27208-4-lvjianmin@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230520063818.27208-4-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> For IRQ controller INT_POLARITY regitser of Loongson-2K CPU

"For the INT_POLARITY register of Loongson-2K series IRQ controller"?

> series, '0' indicates high level or rising edge triggered IRQ,
> '1' indicates low level or falling edge triggered IRQ.

Remove the two "IRQ"s; the topic is "polarity", not "IRQs".

Also please mention the source of this information; I've checked the 
Loongson 2K1000LA User Manual v1.0 and it seems a similar description is 
found in Table 9-2, Section 9.3 (中断寄存器描述 / Description of the Interrupt 
Registers). It mentioned "Intpol_0" and "Intpol_1" but the description 
is consistent with the wording here.

> 
> For Loongson-3A CPU series, setting INT_POLARITY register is not
> supported and writting it has no effect.

Only 3A and not the whole Loongson-3 series?

Also typo: "writing".

> 
> So trigger polarity setting shouled be fixed for Loongson-2K CPU
> series.

The changes seem to be just inversion of the polarity flags. It should 
be correct given your description, and not affect Loongson-3 series 
because it's supposed to behave as noops; it may be better to move the 
explanation regarding Loongson-3 behavior to code comment (e.g. 
somewhere near the definition of LIOINTC_REG_INTC_POL) so it's 
immediately visible to drive-by readers not familiar with LoongArch 
internals, without them having to dig through commit history to see this.

> 
> Fixes: 17343d0b4039 ("irqchip/loongson-liointc: Support to set IRQ type for ACPI path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>

Again, who's the proper author for this patch? Given the tags it seems 
the author should be Chong Qiao, but I didn't see an Author: line at the 
beginning.

> ---
>   drivers/irqchip/irq-loongson-liointc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index 8d00a9ad5b00..9a9c2bf048a3 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -116,19 +116,19 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
>   	switch (type) {
>   	case IRQ_TYPE_LEVEL_HIGH:
>   		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
> -		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
> +		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
>   		break;
>   	case IRQ_TYPE_LEVEL_LOW:
>   		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
> -		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
> +		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
>   		break;
>   	case IRQ_TYPE_EDGE_RISING:
>   		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
> -		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
> +		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
>   		break;
>   	case IRQ_TYPE_EDGE_FALLING:
>   		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
> -		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
> +		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
>   		break;
>   	default:
>   		irq_gc_unlock_irqrestore(gc, flags);

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

