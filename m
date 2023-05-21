Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084C470ADCB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjEULsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjEUKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:38:21 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39171997;
        Sun, 21 May 2023 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1684664996; bh=e3IlEUIS0YZb9RcH/MFffadUgOKgE4/OOTvldAk2fPU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n4GgtwXSJpFvWbpo6KvQvw+iIdRu6evVkaurBxnqqFeZFbO37X4n4V+3zK2SqLnhg
         u1YE0qHW4LCVmCtlqbNslblwidA9vKuThNF9Ez+LigMwKtvH6UDBqqIrfZXTAsQC5h
         MO5jNMUoZHuiFGm1s8fIaaxcATklEeX+gOsK2gb8=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id D2B3A6006F;
        Sun, 21 May 2023 18:29:55 +0800 (CST)
Message-ID: <b9430cda-7ae9-25ca-fc22-d4dd02bae53f@xen0n.name>
Date:   Sun, 21 May 2023 18:29:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH V1 1/4] irqchip/loongson-pch-pic: Fix initialization of HT
 vector register
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
 <20230520063818.27208-2-lvjianmin@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230520063818.27208-2-lvjianmin@loongson.cn>
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

Hi,

On 2023/5/20 14:38, Jianmin Lv wrote:
> In a dual-bridge system based ACPI, the IRQ on PCH PIC of

"In an ACPI-based dual-bridge system"?

Also what's "the IRQ on PCH PIC of each bridge", is it "IRQ of each 
bridge's PCH PIC"? Or did I misunderstand it?

> each bridge sent to CPU is always a zero-based number, which
> means that the IRQ on PCH PIC of each bridge is mapped into
> vector range from 0 to 63 of upstream irqchip(e.g. EIOINTC).
> 
>        EIOINTC N: [0 ... 63 | 64 ... 255]
>                    --------   ----------
>                        ^          ^
>                        |          |
>                    PCH PIC N      |
>                               PCH MSI N
> 
> For example, the IRQ vector number of sata controller on
> PCH PIC of each bridge is 16, which is sent to upstream
> irqchip of EIOINTC when an interrupt occurs, which will set
> bit 16 of EIOINTC. Since hwirq of 16 on EIOINTC has been
> mapped to a irq_desc for sata controller during hierarchy
> irq allocation, the related mapped IRQ will be found through
> irq_resolve_mapping() in the IRQ domain of EIOINTC.
> 
> So, the IRQ number set in HT vector register should be fixed
> to be a zero-based number.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: liuyun <liuyun@loongson.cn>

What's the patch's proper authorship, Yun Liu or you? Based on the 
ordering of the tags it seems you should be the author, but Yun should 
be submitting (because their tag comes later, the patch should be 
flowing from your tree to theirs); otherwise they should be the author 
and the two signoff lines should be reversed.

> ---
>   drivers/irqchip/irq-loongson-pch-pic.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
> index e5fe4d50be05..921c5c0190d1 100644
> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> @@ -401,14 +401,12 @@ static int __init acpi_cascade_irqdomain_init(void)
>   int __init pch_pic_acpi_init(struct irq_domain *parent,
>   					struct acpi_madt_bio_pic *acpi_pchpic)
>   {
> -	int ret, vec_base;
> +	int ret;
>   	struct fwnode_handle *domain_handle;
>   
>   	if (find_pch_pic(acpi_pchpic->gsi_base) >= 0)
>   		return 0;
>   
> -	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
> -
>   	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
>   	if (!domain_handle) {
>   		pr_err("Unable to allocate domain handle\n");
> @@ -416,7 +414,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
>   	}
>   
>   	ret = pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
> -				vec_base, parent, domain_handle, acpi_pchpic->gsi_base);
> +				0, parent, domain_handle, acpi_pchpic->gsi_base);
>   
>   	if (ret < 0) {
>   		irq_domain_free_fwnode(domain_handle);

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

