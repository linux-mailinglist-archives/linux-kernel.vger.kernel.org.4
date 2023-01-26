Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16B067CEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjAZOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZOx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:53:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D71BBE4;
        Thu, 26 Jan 2023 06:53:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 749FBC14;
        Thu, 26 Jan 2023 06:54:07 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48BB63F5A1;
        Thu, 26 Jan 2023 06:53:24 -0800 (PST)
Date:   Thu, 26 Jan 2023 14:53:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: optee: add interrupt controller
 properties
Message-ID: <20230126145321.xs3hjivlpifr5hg7@bogus>
References: <20230124105643.1737250-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124105643.1737250-1-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:56:41AM +0100, Etienne Carriere wrote:
> Adds an optional interrupt controller property to optee firmware node
> in the DT bindings. Optee driver may embeds an irqchip exposing
> interrupts notified by the TEE world. Optee registers up to 1 interrupt
> controller and identifies each line with a line number from 0 to
> UINT16_MAX.
> 
> In the example, the platform SCMI device uses optee interrupt irq 5
> as async signal to trigger processing of an async incoming SCMI message,
> in the scope of a CPU DVFS control. A platform can have several SCMI
> channels driven this way. Optee irqs also permits small embedded devices
> to share e.g. a gpio expander, a group of wakeup sources, etc... between
> OP-TEE world (for sensitive services) and Linux world (for non-sensitive
> services). The physical controller is driven from the TEE which exposes
> some controls to Linux kernel.
> 
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> 
> Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v1:
> - Added a description to #interrupt-cells property.
> - Changed of example. Linux wakeup event was subject to discussion and
>   i don't know much about input events in Linux. So move to SCMI.
>   In the example, an SCMI server in OP-TEE world raises optee irq 5
>   so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
>   SCMI message in the scmi device for liekly later processing in threaded
>   context. The example includes all parties: optee, scmi, sram, gic.
> - Obviously rephrased the commit message.
> - Added Cc: tags
> ---
>  .../arm/firmware/linaro,optee-tz.yaml         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index d4dc0749f9fd..9c00c27f8b2c 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -40,6 +40,14 @@ properties:
>        HVC #0, register assignments
>        register assignments are specified in drivers/tee/optee/optee_smc.h
>  
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +    description: |
> +      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
> +      irq is assigned a single line number identifier used as first argument.
> +
>  required:
>    - compatible
>    - method
> @@ -64,3 +72,62 @@ examples:
>              method = "hvc";
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    firmware  {
> +        optee: optee {
> +            compatible = "linaro,optee-tz";
> +            method = "smc";
> +            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +        };
> +
> +        scmi {
> +            compatible = "linaro,scmi-optee";
> +            linaro,optee-channel-id = <0>;
> +            interrupt-parent = <&gic>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            scmi_cpu_dvfs: protocol@13 {
> +                reg = <0x13>;
> +                linaro,optee-channel-id = <1>;
> +                shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
> +                interrupts-extended = <&optee 5>;

Just curious if this can discovered by some communication within OPTEE.
You know you are using optee-channel-id 0 for all SCMI and 1 for DVFS.
Is it not possible to get the information from OPTEE dynamically like
you do for shmem. It is offset within the notification bitmap IIUC, so
the question is can be get that from the firmware on the fly. It also
gives the firmware to reshuffle things around if needed and don't have to
worry about compatibility with DT ?

-- 
Regards,
Sudeep
