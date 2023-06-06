Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68B57234FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjFFCGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjFFCGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:06:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5311C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tUW1bJ+tB9k5TLZHiDOx5PP7jx4dWCA5NxY0A9E66mc=; b=VqVoYPkpGU6vh1KSVQuo1/2fEw
        uNC2ACr0hAuefq/ETJpbDFKMPGlksOlsqyzbLKNO/62bsjyecdTP7UGXnVijb1uzcd2EWZTTK6oho
        YVGH9KrRgh8OJ4JGUcIoc/42JlRY3MHW10W8m4HUAgIMOU4XdeHfxf/WWHvU7sHYBN96pmZqmh7fp
        xPASMV0PiQ5nmE/b6lDT3qf5nlatWTu4bxabQ+ljv3ZAr4QSZZpoGEm2C0geQFZB2Y4hj+5ZKPtiZ
        IkXwfOowzLz2ac/Wf244Qf917XYMKA8KlPHsalO5yAk5CNRCyasQCk5MI3YssqNvFKgd+nJRfmuii
        s4JmCIiw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6M5F-00HPKc-2p;
        Tue, 06 Jun 2023 02:06:05 +0000
Message-ID: <05e61770-1a20-6210-1a03-162cf27ba206@infradead.org>
Date:   Mon, 5 Jun 2023 19:06:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/2] genirq: fasteoi supports resend on concurrent
 invoke
Content-Language: en-US
To:     James Gowans <jgowans@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liao Chang <liaochang1@huawei.com>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
References: <20230605155723.2628097-1-jgowans@amazon.com>
 <20230605155723.2628097-2-jgowans@amazon.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230605155723.2628097-2-jgowans@amazon.com>
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

On 6/5/23 08:57, James Gowans wrote:
> ... and enable that functionality for GIC-v3 only.
> 
> ---
>  drivers/irqchip/irq-gic-v3-its.c |  2 ++
>  include/linux/irq.h              | 13 +++++++++++++
>  kernel/irq/chip.c                | 16 +++++++++++++++-
>  kernel/irq/debugfs.c             |  2 ++
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index b1b28affb32a..b76cc90faebd 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -223,6 +223,8 @@ struct irq_data {
>   *				  irq_chip::irq_set_affinity() when deactivated.
>   * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
>   *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
> + * RQD_RESEND_WHEN_IN_PROGRESS	- Interrupt may fire when already in progress in which

typo?  s/RQD/IRQD/

> + *				  case it must be resent at the next available opportunity.
>   */
>  enum {
>  	IRQD_TRIGGER_MASK		= 0xf,
> @@ -249,6 +251,7 @@ enum {
>  	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
>  	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
>  	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
> +	IRQD_RESEND_WHEN_IN_PROGRESS    = (1 << 31),
>  };
>  
>  #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)


-- 
~Randy
