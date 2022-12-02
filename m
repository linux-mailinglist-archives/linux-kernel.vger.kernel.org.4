Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F6963FDFA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiLBCIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiLBCH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:07:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D836283255;
        Thu,  1 Dec 2022 18:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 919F8B82032;
        Fri,  2 Dec 2022 02:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F76C4347C;
        Fri,  2 Dec 2022 02:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669946873;
        bh=L7x3GzZtWoBfnRdvPmJ5iRAK+U+EE2V4CXeaUkVAWAs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=foQwtkgJKDbknPhyOTRO1aRIENt5mE5FWmbSMWUAdJB9JE5q7h7xWxhlmvUWZOK9P
         X+wPUjPDCXC/6/fVNYIqhVUvmOiEMgO5IbwZKdH+pEhoojcR3RgPU7Hu3yFdSQcD3d
         bIz/Cq0w3cOvrNBAPGwLaTeUoMmJynXevBLRLi6pNrgravjoR+MekOefTuOlUjhS84
         GgfKI5u9v0LU3onVZkkRyvsHQ1eKVlFX/6HLv4VCVhO/YT23HtGu3KkPd7VKwJX9I0
         j+glZoJybsNOiB2Pkzak6i61Ss/aaAC/fImLKDTiSIj9gMZRDenBm2yudAF4Cnonfe
         cuKz1dtr5hZqA==
Received: by mail-ej1-f48.google.com with SMTP id gu23so8427368ejb.10;
        Thu, 01 Dec 2022 18:07:53 -0800 (PST)
X-Gm-Message-State: ANoB5plqkFybjBb5FyqsVJRtVi1vaotqJX59rcaUJg86wLJhknO/esxB
        co8MzHnFpiMvoMi4DA+ZXOHO6+xsGAEKCmVthMs=
X-Google-Smtp-Source: AA0mqf7xXNgupaF/RrnM37TfCuq0Z/Kk9yhnddAF6zI2fYvNphwIca7gMPOCjkYRQFOTSaREu6az2U/2Vx8uQQR5gb8=
X-Received: by 2002:a17:906:840a:b0:7c0:c0c9:9c4 with SMTP id
 n10-20020a170906840a00b007c0c0c909c4mr1278895ejx.272.1669946871539; Thu, 01
 Dec 2022 18:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20221114113824.1880-1-liupeibao@loongson.cn> <20221114113824.1880-2-liupeibao@loongson.cn>
In-Reply-To: <20221114113824.1880-2-liupeibao@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 2 Dec 2022 10:07:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4euj53v=5k7iw5Ts7i41fpnRfWCUaAKuOTPpjRDushFg@mail.gmail.com>
Message-ID: <CAAhV-H4euj53v=5k7iw5Ts7i41fpnRfWCUaAKuOTPpjRDushFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] irqchip: loongarch-cpu: add DT support
To:     Liu Peibao <liupeibao@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peibao and Marc,

I found this patch has merged but lkp report a problem, this can
simply fixed by add "static" before loongarch_cpu_irq_of_init
definition. Since Marc's next branch hasn't been tagged yet, can
Peibao send a new version and Marc rebase it?

Huacai

On Mon, Nov 14, 2022 at 7:38 PM Liu Peibao <liupeibao@loongson.cn> wrote:
>
> LoongArch is coming to support booting with FDT, so DT
> support of this driver is desired.
>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
>  drivers/irqchip/irq-loongarch-cpu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
> index 741612ba6a52..a28b7c549654 100644
> --- a/drivers/irqchip/irq-loongarch-cpu.c
> +++ b/drivers/irqchip/irq-loongarch-cpu.c
> @@ -92,6 +92,25 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
>         .xlate = irq_domain_xlate_onecell,
>  };
>
> +#ifdef CONFIG_OF
> +int __init loongarch_cpu_irq_of_init(struct device_node *of_node,
> +                               struct device_node *parent)
> +{
> +       cpuintc_handle = of_node_to_fwnode(of_node);
> +
> +       irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
> +                               &loongarch_cpu_intc_irq_domain_ops, NULL);
> +       if (!irq_domain)
> +               panic("Failed to add irqdomain for loongarch CPU");
> +
> +       set_handle_irq(&handle_cpu_irq);
> +
> +       return 0;
> +}
> +IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller",
> +                                       loongarch_cpu_irq_of_init);
> +#endif
> +
>  static int __init
>  liointc_parse_madt(union acpi_subtable_headers *header,
>                        const unsigned long end)
> --
> 2.20.1
>
