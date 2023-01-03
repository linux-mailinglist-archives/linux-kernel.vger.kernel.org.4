Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20BA65C8E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbjACV2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbjACV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:28:10 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F80F26;
        Tue,  3 Jan 2023 13:28:09 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id y4so17273370iof.0;
        Tue, 03 Jan 2023 13:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDpFz/zfyG1h6KvORYA1TBbL7DQuojC0RTuz8khwWJc=;
        b=5+s8ecbmfn1sjMYyYLGWw+xclG7Vu4H848Nr2nt1OxYxluomuXJfm4ZQw1vZG1YNbI
         ylOD8DupVZrDqPwd0dDC7wO0SnQdHNUwF+zG/5Mw5LzHgG1HDnafIlU3IVvNYzgmYL/C
         FEgYT/uxPqFQnBBsRaCVppCnisPc9Moq8E/0BTTrd9FWrZDK4iBk5drvKhWfbOCqQYqk
         gDkX0BBESKZOdKiF3D6rklWVAiG/fHN6G+IqK4YIGCU8hBYyeN+N2ISroMGKWjTPMuB3
         r7ScnBTXQrUjvPKKyVBts5w/7+bUh4yDgJJYNNmkl17pKv9teI7N7cgKySG2lHUqohfK
         3Vmg==
X-Gm-Message-State: AFqh2kqckkub2FcIMUOI2WS6xuWJcUo238H7x5GLlnE4iF++D0y6QU2z
        psKsC3BhTQkKq+to/txKsw==
X-Google-Smtp-Source: AMrXdXup8ZTnz3csVLQIPOYIzueaY7SIhs8rXST2kjOQP5FXSjZn5I9Y0JbiWoqewHyUkPD3ea/QzQ==
X-Received: by 2002:a6b:5010:0:b0:6bc:d70f:8b2f with SMTP id e16-20020a6b5010000000b006bcd70f8b2fmr32240203iob.9.1672781289138;
        Tue, 03 Jan 2023 13:28:09 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w12-20020a5e970c000000b006e3170eeee4sm11743570ioj.6.2023.01.03.13.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:28:08 -0800 (PST)
Received: (nullmailer pid 4074404 invoked by uid 1000);
        Tue, 03 Jan 2023 21:28:07 -0000
Date:   Tue, 3 Jan 2023 15:28:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH 09/25] kvx: irqchip: Add support for irq controllers
Message-ID: <20230103212807.GA4069028-robh@kernel.org>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-10-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103164359.24347-10-ysionneau@kalray.eu>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 05:43:43PM +0100, Yann Sionneau wrote:
> Add support for kvx irq controllers found in Coolidge MPPA SoC
> 
> The core-intc:
> 
> Each kvx core includes a hardware interrupt controller (core ITC)
> with the following features:
> * 32 independent interrupt sources
> * 4-bit priotity level
> * Individual interrupt enable bit
> * Interrupt status bit displaying the pending interrupts
> * Priority management between the 32 interrupts
> 
> Among those 32 interrupt sources, the first are hard-wired to hardware
> sources. The remaining interrupt sources can be triggered via software
> by directly writing to the ILR SFR.
> 
> The hard-wired interrupt sources are the following:
> 0: Timer 0
> 1: Timer 1
> 2: Watchdog
> 3: Performance Monitors
> 4: APIC GIC line 0
> 5: APIC GIC line 1
> 6: APIC GIC line 2
> 7: APIC GIC line 3
> 12: SECC error from memory system
> 13: Arithmetic exception (carry and IEEE 754 flags)
> 16: Data Asynchronous Memory Error (DAME), raised for DECC/DSYS errors
> 17: CLI (Cache Line Invalidation) for L1D or L1I following DECC/DSYS/Parity
>     errors
> 
> The APIC GIC lines will be used to route interrupts coming from SoC peripherals
> from outside the Cluster to the kvx core. Those peripherals include USB host
> controller, eMMC/SD host controller, i2c, spi, PCIe, IOMMUs etc...
> 
> The APIC GIC:
> 
> Each Cluster of the Coolidge SoC includes an APIC
> (Advanced Programmable Interrupt Controller) GIC (Generic Interrupt Controller).
> The APIC GIC acts as an intermediary interrupt controller, muxing/routing
> incoming interrupts to output interrupts connected to the kvx core ITC lines.
> The first 128 incoming interrupt lines come from the mailbox controller (itself
> containing 128 mailboxes).
> The remaining 11 interrupt lines come from external interrupt sources (NoC
> router, the 5 IOMMUs, L2$ DMA job fifo, watchdog, SECC, DECC, D NoC).
> The APIC GIC has 72 output interrupts: 4 per kvx cores in the cluster
> (1 RM and 16 PE) connected to the "APIC GIC lines" described above and 1 for the
> L2$ controller which makes 69 interrupts lines (rounded up to 72).
> 
> The APIC Mailbox:
> 
> The APIC includes a mailbox controller, containing 128 mailboxes.
> This hardware block is basically a 1 Kb of smart memory space.
> Each mailbox is an 8 bytes word memory location which can generate and
> interrupt.
> Each mailbox has a trigger function and an input function.
> When a mailbox is written to, if the condition described by the
> trigger function is satisfied, the corresponding interrupt
> will fire.
> Since this hardware block generates IRQs based on writes
> at some memory locations, it is both an interrupt controller
> and an MSI controller.
> 
> The ITGEN:
> 
> The ITGEN (InTerrupt GENerator) is an interrupt controller block.
> It's purpose is to convert IRQ lines coming from SoC peripherals
> (USB host controller for instance) into writes on the AXI bus.
> Those writes are targeting the APIC Mailboxes.
> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Marc Zyngier <maz@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: linux-kernel@vger.kernel.org
> CC: devicetree@vger.kernel.org
> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> Co-developed-by: Luc Michel <lmichel@kalray.eu>
> Signed-off-by: Luc Michel <lmichel@kalray.eu>
> Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
> Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
> Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
>  .../kalray,kvx-core-intc.txt                  |  22 +

Bindings should be a separate patch and must be in schema format now.

You probably should do a patch per driver too.

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kvx-core-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/kalray,kvx-core-intc.txt
> new file mode 100644
> index 000000000000..503a661e1e84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kvx-core-intc.txt
> @@ -0,0 +1,22 @@
> +* KVX Core Interrupt controller
> +
> +Required properties:
> +
> +- compatible: must to be "kalray,kvx-core-intc".

compatible strings should be specific enough to identify bugs/features 
of a specific implementation unless there's another way to do that (e.g. 
version registers).

> +- interrupt-controller
> +- #interrupt-cells: has to be <1>: an interrupt index
> +- regs: Base address of interrupt controller registers.
> +
> +Optional properties:
> +
> +- kalray,intc-nr-irqs: Number of irqs handled by the controller.
> +  if not given, will default to 32.

What's the range?

> +
> +Example:
> +
> +	core_intc: core_intc@0 {

interrupt-controller {

> +		compatible = "kalray,kvx-core-intc";
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		interrupt-parent = <&core_intc>;
> +	};

[...]

> +IRQCHIP_DECLARE(kvx_apic_gic, "kalray,kvx-apic-gic", kvx_init_apic_gic);

> +IRQCHIP_DECLARE(kvx_apic_mailbox, "kalray,kvx-apic-mailbox",
> +		kvx_init_apic_mailbox);

> +static const struct of_device_id itgen_of_match[] = {
> +	{ .compatible = "kalray,kvx-itgen" },
> +	{ /* END */ }
> +};

All these compatible strings need binding schemas, too.


> diff --git a/include/linux/irqchip/irq-kvx-apic-gic.h b/include/linux/irqchip/irq-kvx-apic-gic.h
> new file mode 100644
> index 000000000000..8efbcd05f3ea
> --- /dev/null
> +++ b/include/linux/irqchip/irq-kvx-apic-gic.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018-2023 Kalray Inc.
> + * Author: Clement Leger
> + */
> +
> +#ifndef KVX_APIC_GIC_H
> +#define KVX_APIC_GIC_H
> +
> +/* GIC enable register definitions */
> +#define KVX_GIC_ENABLE_OFFSET     0x0
> +#define KVX_GIC_ENABLE_ELEM_SIZE  0x1
> +#define KVX_GIC_INPUT_IT_COUNT 0x9D
> +#define KVX_GIC_ELEM_SIZE 0x400
> +
> +/* GIC status lac register definitions */
> +#define KVX_GIC_STATUS_LAC_OFFSET     0x120
> +#define KVX_GIC_STATUS_LAC_ELEM_SIZE  0x8
> +#define KVX_GIC_STATUS_LAC_ARRAY_SIZE 0x3

Do these defines need to be public to *all* the kernel? Doesn't look 
like it.

Same question on the other headers.

Rob
