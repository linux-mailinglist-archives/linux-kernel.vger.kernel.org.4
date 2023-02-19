Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8525869C00F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 12:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBSL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 06:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjBSL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 06:26:55 -0500
X-Greylist: delayed 531 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Feb 2023 03:26:53 PST
Received: from kuriko.dram.page (kuriko.dram.page [65.108.252.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CE910409;
        Sun, 19 Feb 2023 03:26:53 -0800 (PST)
Message-ID: <81b03d13-a1d6-91ee-9867-48e960f0549d@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
        t=1676805479; bh=1nxpGy6MS2o8HwQfGYJeWTTEYcPBkHZ07OBzzY3N5NU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=XU7bqj+Na6ART26G1bBybn3NWB01QI6wJe6S/GY0wLOBH3YWWGIdGNCQdkllY44OS
         DL0iCyUDtGY24a/y0VeSc77kng/O8QKlvnspOBFF90aZDPQRfqMUoH9iRsaD2P2umv
         BQwxwlFKtLSt/JvUmpNaXXIIZ2zDBYmA6pKEeo+w=
Date:   Sun, 19 Feb 2023 19:17:48 +0800
MIME-Version: 1.0
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
 <20230103141409.772298-5-apatel@ventanamicro.com>
Content-Language: en-US
From:   Vivian Wang <uwu@dram.page>
Subject: Re: [PATCH v2 4/9] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
In-Reply-To: <20230103141409.772298-5-apatel@ventanamicro.com>
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
> We add DT bindings document for the RISC-V incoming MSI controller
> (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> specification.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,imsics.yaml    | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> new file mode 100644
> index 000000000000..b9db03b6e95f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> <snip>
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 16384
> +    description:
> +      This property represents the set of CPUs (or HARTs) for which given
> +      device tree node describes the IMSIC interrupt files. Each node pointed
> +      to should be a riscv,cpu-intc node, which has a riscv node (i.e. RISC-V
> +      HART) as parent.
> +

This property doesn't seem to describe guest external interrupts. Should
we add a reference to e.g. <&cpuN_intc 12> to indicate that IMSIC can
send a 'Supervisor guest external interrupt'? Or just an idea, maybe we
can add an additional interrupt controller to the CPU nodes to handle
SGEI: (Various properties omitted)

cpu0: cpu@N {
	compatible = "riscv";

	cpu0_intc: interrupt-controller {
		compatible = "riscv,cpu-intc";

		cpu0_gei: interrupt-controller {
			/* intc for hart-local hgeie/hgeip */
			compatible = "riscv,..."; /* Something here */
			interrupt-parent = <&cpu0_intc>;
			interrupts = <12>; /* SGEI */
			interrupt-controller;
			#interrupt-cells = <1>;
		}
	}
}

interrupt-controller@... {
	compatible = "riscv,imsics";
	interrupts-extended = <&cpu0_intc 11>, <&cpu0_gei 1>, <&cpu0_gei 2> /* ... */;
}

I feel that this would be more appropriate, since the guest external
interrupts are defined in the privileged architecture specification and
are not specific to AIA. Though please do suggest more appropriate ways
to formulate it.
> <snip>
> +...
