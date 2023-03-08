Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD46B136F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCHU6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCHU6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:58:40 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4311562DA5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:58:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i10so18903560plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678309117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ps+hmTG6OMOCtb1tap23TE+XuifD4F3tbznuF8ocoWM=;
        b=LRjq6LVWzGzS/fuAjwwrVaGsTiyM9GmKtRpx5bWjMHMFUMqYD6lpHkspaiev88CSZE
         AgSnaod6Aw6kUiL1EdlI1yxqIMsYSNYJmyrTI1pBWRT6KxqgL9awNJ9mmsaxwkepWbND
         r1DCRBP5iTd9wcxNftp1ZxmdXg0diOUEJTid0n6gSjbkzm+vr0ajb8PUkE8gr07xv+G7
         8bYNFmggxAJYQCUKgnEb/A9zya0GmdNb8XW76B8E/GasOIOo03peHeqr1KwsncITgtLL
         qekI0q2Da2tgAGATjzqUpRUaugikMOAODhaK0imZXBN/QrGHt9BevL1F9xO5Co9eceVI
         Bwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps+hmTG6OMOCtb1tap23TE+XuifD4F3tbznuF8ocoWM=;
        b=WMzgTJYwsquCltytkXF+GhpibcigBraNvRU1XcQixyNzGtdLvvcXhW0TYZyigal3yC
         EYAZWt4WqsSgmQxe+BiqkzML2a/u8L7Aousys7T59fvziZarUIyFV5dUWko11ddcqGYn
         fVnR/rt7zMGZ2g7bWQ1hBXUFI2Cqf0rBgQtnrzR41pGopv+zUIbCflXL8vqoL0KK22J5
         gLv5fg7yvGRhu6PV1XLuYUB2HjB3gz62mM/8ru2pgL3enB6We14Olk188WWlF2+YC7RD
         oCnJopJR0A36UVXvGJ1pOjn0iSlu6pUGEGWCePapraukiubaU77y8/4zDxFWvfWK43Rv
         RrSg==
X-Gm-Message-State: AO0yUKW3wtDftsdN8xWFVCAL7qix8LZvGN/kXkrGImrr7J/i4dkvDDTJ
        vsF1aDNiu6R12EFdK2j9oL2SXw==
X-Google-Smtp-Source: AK7set80PDtUv2FPsiuITZmUYlCpPTcXQMiFwpDnGWdPQD24YTSvqOfy3kyMuat0p9BhPbfviWb2uQ==
X-Received: by 2002:a17:903:2344:b0:19b:64bb:d546 with SMTP id c4-20020a170903234400b0019b64bbd546mr4001171plh.18.1678309116674;
        Wed, 08 Mar 2023 12:58:36 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:af4f:13d6:af4f:f078])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b0019c91989a1csm10159444plg.300.2023.03.08.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:58:36 -0800 (PST)
Date:   Wed, 8 Mar 2023 13:58:33 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>, kernel@collabora.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: remoteproc: k3-m4f: Add bindings for
 K3 AM64x SoCs
Message-ID: <20230308205833.GA1768401@p14s>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
 <20230302171450.1598576-2-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302171450.1598576-2-martyn.welch@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martyn, 

Due to the size of this patch my comments will likely span a few days.  I will
clearly let you know when I am done reviewing your submission.


On Thu, Mar 02, 2023 at 05:14:48PM +0000, Martyn Welch wrote:
> From: Hari Nagalla <hnagalla@ti.com>
> 
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [Martyn Welch: Amended as per review comments and to pass DT tests]

This isn't needed.  Since you are taking over this patchset it is expected you
will make modifications.

> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes since v1:
>  - Spelling corrections
>  - Corrected to pass DT checks
> 
> Changes since v2:
>  - Missed spelling correction to commit message
> 
> Note: The only review comment that I don't see directly addressed is the
>       lack of description of `ti,sci`, `ti,sci-dev-id` and
>       `ti,sci-proc-ids`. A reference has been added to
>       `/schemas/arm/keystone/ti,k3-sci-common.yaml#` where they are
>       described. I believe this is the correct approach, please advise if
>       that is not the case.
> 
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> new file mode 100644
> index 000000000000..1b38df0be2e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI K3 M4F processor subsystems
> +
> +maintainers:
> +  - Hari Nagalla <hnagalla@ti.com>
> +

Hari did not finish upstreaming this set.  As such I doubt he intents to
maintain it and I suppose it is the same for you since you didn't add your name
either.  You can add my name there.

> +description: |
> +  Some K3 family SoCs have Arm Cortex M4F cores. AM64x is a SoC in K3
> +  family with a M4F core. Typically safety oriented applications may use
> +  the M4F core in isolation without an IPC. Where as some industrial and
> +  home automation applications, may use the M4F core as a remote processor
> +  with IPC communications.
> +
> +$ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: "^m4fss(@.*)?"
> +
> +  compatible:
> +    enum:
> +      - ti,am64-m4fss
> +
> +  power-domains:
> +    description: |
> +      Should contain a phandle to a PM domain provider node and an args
> +      specifier containing the M4FSS device id value.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    items:
> +      - description: Address and Size of the IRAM internal memory region
> +      - description: Address and Size of the DRAM internal memory region
> +
> +  reg-names:
> +    items:
> +      - const: iram
> +      - const: dram
> +
> +  resets:
> +    description: |
> +      Should contain the phandle to the reset controller node managing the
> +      local resets for this device, and a reset specifier.
> +    maxItems: 1
> +
> +  firmware-name:
> +    description: |
> +      Should contain the name of the default firmware image
> +      file located on the firmware search path
> +
> +  mboxes:
> +    description: |
> +      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
> +      communication with the remote processor. This property should match
> +      with the sub-mailbox node used in the firmware image.
> +    maxItems: 1
> +
> +  memory-region:
> +    description: |
> +      phandle to the reserved memory nodes to be associated with the
> +      remoteproc device. There should be at least two reserved memory nodes
> +      defined. The reserved memory nodes should be carveout nodes, and
> +      should be defined with a "no-map" property as per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> +    minItems: 2
> +    maxItems: 8
> +    items:
> +      - description: region used for dynamic DMA allocations like vrings and
> +                     vring buffers
> +      - description: region reserved for firmware image sections
> +    additionalItems: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ti,sci
> +  - ti,sci-dev-id
> +  - ti,sci-proc-ids
> +  - resets
> +  - firmware-name
> +  - mboxes

The 'mboxes' property is marked as required but the description section above
clearly state the M4F can operate without IPC.

> +  - memory-region
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9cb00000 0x00 0x100000>;
> +            no-map;
> +        };
> +
> +        mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9cc00000 0x00 0xe00000>;
> +            no-map;
> +        };
> +    };
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mailbox0_cluster0: mailbox-0 {
> +            #mbox-cells = <1>;
> +
> +            mbox_m4_0: mbox-m4-0 {
> +                ti,mbox-rx = <0 0 0>;
> +                ti,mbox-tx = <1 0 0>;
> +            };
> +        };
> +
> +        bus@f0000 {
> +            compatible = "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;
> +
> +            bus@4000000 {
> +                compatible = "simple-bus";
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;
> +
> +                mcu_m4fss: m4fss@5000000 {
> +                    compatible = "ti,am64-m4fss";
> +                    reg = <0x00 0x5000000 0x00 0x30000>,
> +                          <0x00 0x5040000 0x00 0x10000>;
> +                    reg-names = "iram", "dram";
> +                    ti,sci = <&dmsc>;
> +                    ti,sci-dev-id = <9>;
> +                    ti,sci-proc-ids = <0x18 0xff>;
> +                    resets = <&k3_reset 9 1>;
> +                    firmware-name = "am62-mcu-m4f0_0-fw";
> +                    mboxes = <&mailbox0_cluster0 &mbox_m4_0>;

This doesn't look right since mbox_m4_0 is defined within mailbox0_cluster0.

> +                    memory-region = <&mcu_m4fss_dma_memory_region>,
> +                                    <&mcu_m4fss_memory_region>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.39.1
> 
