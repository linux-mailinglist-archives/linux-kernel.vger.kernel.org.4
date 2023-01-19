Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676276738E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjASMpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjASMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:45:16 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C93F295
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:44:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw16so5287329ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YWR9OlP03r7QcJTROY9XweEp/odJNTYRZKCcANso/mU=;
        b=pbtkyFp7ZtDm+X8xuDJqBgdFYBgp1Bw/NdO5g5FfOl4kknZn/sGQw1wimziY9bYjbV
         8uxGfTHJPfMf6e3D9n2oHWBOyw7qocZPqnv5WdyDRikMqs9nHbmNi87b5FlatKNYnulA
         msKY4jV2P1gVR7cAu8500mBqVRQF3YkBmiQs2fqskH5oOSwspli/2IVyWqcVL4YSiUyK
         rg+tswGzyQhnNELBgVo05C9hE1CvgRaZvFhH/gRKWakqO/av0Xpp4aLBMjEnTGhxYPss
         q5j1sTJCYHJZcX/gcnsqkS2zz2D+UtuQWE4v24Jy3PrXvlAsQtf/bYSPp/q46mswgp51
         ZDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWR9OlP03r7QcJTROY9XweEp/odJNTYRZKCcANso/mU=;
        b=Kun45w6CSLgepGXqAXTqkVoc0zNrzz2ZJpgo7I2S5hhJ/kEA3oX3mBq3Lq5ItwaX43
         0wNUAAqmj1c5HYqjVDyjApuHf7AY+pAX8/BwaUQq6FqQLo8JeGt4j4vPB6lSJGkdblVD
         ir6T86jkp63G2jR3yYDl1yH13ELM11ypprqT5u98yZ7pifAOllJKhdm6gz1dCLxWaX4p
         I0yn60t//mn/ADnmifcSWn7+O4SBEr+WMyP8YcQo5CygJEYJG/9Ilkm5GzKLaAOPOrKt
         Lz4gC42WBPOHyKPg/t355g3EG6QG9hGxKXfqRUKXn3E+njcA1GFGUeM3cFBaQiLn+Z4Y
         iu4g==
X-Gm-Message-State: AFqh2krBYTXo2MRnVL2droSlud9w3JiGnTGlIetofoWgDw+i/iSsMaha
        rxp2beJEiO4UL+ocqZnVaO+hhPzRHGxPFnVz3FNaQpbQ
X-Google-Smtp-Source: AMrXdXsgFbI8xlO3RYYSbd3nxdAZ9bU1GFE9fNtRH8787zHz7V+RCRNvtkaN5CwqR1WER8a6JDEcrs/dNTOJ1pHAWu0=
X-Received: by 2002:a17:906:25c5:b0:86d:fa64:2941 with SMTP id
 n5-20020a17090625c500b0086dfa642941mr994344ejb.72.1674132251818; Thu, 19 Jan
 2023 04:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20221207140643.1600743-1-chenhuacai@loongson.cn>
In-Reply-To: <20221207140643.1600743-1-chenhuacai@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 19 Jan 2023 20:44:00 +0800
Message-ID: <CAAhV-H7vt5b=ZScvKRRv1dWeqRbVU65aCdgdAaR0Jtw-tvZVyQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-liointc: Save/restore int_edge/int_pol
 registers during S3/S4
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yingkun Meng <mengyingkun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a gentle ping.

This patch was sent for the 6.2 cycle but seems too late, now I think
ping it to be reviewed for 6.3 is better than resend it.

On Wed, Dec 7, 2022 at 10:06 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> If int_edge/int_pol registers are configured to not be the default values, we
> should save/restore them during S3/S4.
>
> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-liointc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index c116f70929ae..4367ce9b558f 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -55,6 +55,8 @@ struct liointc_priv {
>         struct liointc_handler_data     handler[LIOINTC_NUM_PARENT];
>         void __iomem                    *core_isr[LIOINTC_NUM_CORES];
>         u8                              map_cache[LIOINTC_CHIP_IRQ];
> +       u32                             int_pol;
> +       u32                             int_edge;
>         bool                            has_lpc_irq_errata;
>  };
>
> @@ -138,6 +140,14 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
>         return 0;
>  }
>
> +static void liointc_suspend(struct irq_chip_generic *gc)
> +{
> +       struct liointc_priv *priv = gc->private;
> +
> +       priv->int_pol = readl(gc->reg_base + LIOINTC_REG_INTC_POL);
> +       priv->int_edge = readl(gc->reg_base + LIOINTC_REG_INTC_EDGE);
> +}
> +
>  static void liointc_resume(struct irq_chip_generic *gc)
>  {
>         struct liointc_priv *priv = gc->private;
> @@ -150,6 +160,8 @@ static void liointc_resume(struct irq_chip_generic *gc)
>         /* Restore map cache */
>         for (i = 0; i < LIOINTC_CHIP_IRQ; i++)
>                 writeb(priv->map_cache[i], gc->reg_base + i);
> +       writel(priv->int_pol, gc->reg_base + LIOINTC_REG_INTC_POL);
> +       writel(priv->int_edge, gc->reg_base + LIOINTC_REG_INTC_EDGE);
>         /* Restore mask cache */
>         writel(gc->mask_cache, gc->reg_base + LIOINTC_REG_INTC_ENABLE);
>         irq_gc_unlock_irqrestore(gc, flags);
> @@ -261,6 +273,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
>         gc->private = priv;
>         gc->reg_base = base;
>         gc->domain = domain;
> +       gc->suspend = liointc_suspend;
>         gc->resume = liointc_resume;
>
>         ct = gc->chip_types;
> --
> 2.31.1
>
