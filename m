Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69569C01A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 12:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBSLsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 06:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBSLsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 06:48:42 -0500
Received: from kuriko.dram.page (kuriko.dram.page [65.108.252.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFDCC1C;
        Sun, 19 Feb 2023 03:48:41 -0800 (PST)
Message-ID: <4bd8c6da-6ad4-5e1a-169c-48f48560b36b@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
        t=1676807318; bh=IJFps8QiPqsxtkm8bbGRrhgiLRq/rPGQKvISbNPd8i4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=NNRikU8qtdtoR2Z2vRLJNpcLFZ/r1A7KpOQc5C8tuONVpqWi/KjOoNX1+hlr8RbnT
         6642eA05ALzSAjOkzbgUGXqGWhgVEmMG+nVesVABXBhD0jnQTLD95EitxuRhb+aIvw
         w0o2R1e3c7QtmPO6DeL4jpv3gR5cBwNb3Y2rqsAw=
Date:   Sun, 19 Feb 2023 19:48:27 +0800
MIME-Version: 1.0
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-7-apatel@ventanamicro.com>
From:   Vivian Wang <uwu@dram.page>
Subject: Re: [PATCH v2 6/9] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
In-Reply-To: <20230103141409.772298-7-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 22:14, Anup Patel wrote:
> We add DT bindings document for RISC-V advanced platform level
> interrupt controller (APLIC) defined by the RISC-V advanced
> interrupt architecture (AIA) specification.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,aplic.yaml     | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> new file mode 100644
> index 000000000000..b7f20aad72c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> @@ -0,0 +1,159 @@
>
> <snip>
>
> +  riscv,children:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      maxItems: 1
> +    description:
> +      A list of child APLIC domains for the given APLIC domain. Each child
> +      APLIC domain is assigned child index in increasing order with the
> +      first child APLIC domain assigned child index 0. The APLIC domain
> +      child index is used by firmware to delegate interrupts from the
> +      given APLIC domain to a particular child APLIC domain.
> +
> +  riscv,delegate:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      items:
> +        - description: child APLIC domain phandle
> +        - description: first interrupt number (inclusive)
> +        - description: last interrupt number (inclusive)
> +    description:
> +      A interrupt delegation list where each entry is a triple consisting
> +      of child APLIC domain phandle, first interrupt number, and last
> +      interrupt number. The firmware will configure interrupt delegation
> +      registers based on interrupt delegation list.
> +

I'm not sure if this is the right place to ask, since it could be more
of a OpenSBI/QEMU problem, but I think a more detailed description about
what 'the firmware' does is appropriate here.

My main confusion is how to describe wired interrupts connected to
APLICs. Say we have two APLIC nodes with labels aplic_m and aplic_s that
are the APLIC domains for M-mode and S-mode respectively. IIUC, wired
interrupts are connected directly to aplic_m. So how do I refer to it in
the device nodes?

 1. <&aplic_s num IRQ_TYPE_foo>, but it would be a lie to M-mode
    software, which could be a problem. QEMU 7.2.0 seems to take this
    approach. (I could also be misunderstanding QEMU and it actually
    does connect wired interrupts to the S-mode APLIC, but then
    riscv,children and riscv,delegate would be lies.)
 2. <&aplic_m ...>, and when M-mode software gives S-mode software
    access to devices, it delegates relevant interrupts and patches it
    into <&aplic_s num IRQ_TYPE_foo>. Seems to be the 'correct'
    approach, but pretty complicated.
 3. <&aplic_m ...>, S-mode software sees this, and sees that aplic_m has
    num in riscv,delegate, so goes to find the child it's been delegated
    to, which is (should be) aplic_s. A bit annoyingly abstraction
    breaking, since S-mode shouldn't even need to know about aplic_m.

I see that others are also confused by riscv,delegate and riscv,children
properties. It would be great if we could clarify the expected behavior
here rather than just saying 'the firmware will do the thing'.

> <snip>
> +...
Thanks,
Vivian
