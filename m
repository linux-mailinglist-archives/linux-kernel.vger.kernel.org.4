Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E311565BD29
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjACJ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjACJ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:28:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10644E0B5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:28:19 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kw15so72105444ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mgqDuS8VoPnxTMSPcm7TpLYp2N0+QhDeUosiaeGlAQ=;
        b=jI/aqMlSZ4ihEbxh/jpd1/8EwC4bVazjEnJK/d1Usdmbw6TdFinU1ihj4IKVyC+DUN
         EbqWXvjfpgpckskLspI6IkDrIlPIwsp7MgFL9j3YjdO+O2Z65q0gNMoWKvYhh4fpmqz3
         0BY3TXXa+O/YqhneJznw2f0BermYrexrSA+6rTJVVOgYQ9MGrcBqkYZ/6ME21BFDZ67x
         123/I3ic7YpGFgq3X3Blf9kxDsLNHubj1SjoZTwu/ogFAigJhbHerNJLPaY/PeLEdUT2
         2btdpe448ZkrzRHXAWgIGBRjRHznrl91KsEYQgXJGrdeH+9PyLeW4P/otKl+KcHzZZqE
         Tyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mgqDuS8VoPnxTMSPcm7TpLYp2N0+QhDeUosiaeGlAQ=;
        b=02I+YHBHf03SCIOyFtPgMRHnBCLKa4CHzE4fcWVk7U1sNEnRMJX9ZZBxVHk6Ad1cjg
         0hznms1+ZDROMyersgrCVaCn0qaeautwCnElgcdKwDJPEQRCtJCI976qyztVZNLnVpAI
         2OeEXm4REiCulSWcLCr4ck+VrDlAyQjkOPAZ/KtEmk8YorIUJ25vEky9deeBiYXxvFOq
         2KKp2Q3lJRXgxKzXs3Li8PNeFA9y5SSIQBaFkkNDzdmH+/Zl7v+Uzu19U3w3ABv4kmk+
         zcKEdq0XnkdgRzR8OPVRkwB0X7vAWJ4sqDHTtiqXhXTIOFQsANM86e1Xih4NaIdeNDUv
         x//g==
X-Gm-Message-State: AFqh2koV1rMJse3lbvIu1TQM/MHnDOYOOE7y3R3X17Paq/fwaKc5q1EL
        M0cjdwzB7fqEOvmLgmf7ewmYKw==
X-Google-Smtp-Source: AMrXdXs3XUHe1hUgCDEUf7lvvDVgT0ChF67TCWmNPS+mrZc3trzhsWbC44DLAwLWKjfGj6X2q2/jnw==
X-Received: by 2002:a17:906:2813:b0:7c0:f9ef:23a2 with SMTP id r19-20020a170906281300b007c0f9ef23a2mr47667065ejc.30.1672738097556;
        Tue, 03 Jan 2023 01:28:17 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0083f91a32131sm13808062ejh.0.2023.01.03.01.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 01:28:17 -0800 (PST)
Date:   Tue, 3 Jan 2023 10:28:16 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, atishp@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        will@kernel.org, mark.rutland@arm.com, opensbi@lists.infradead.org,
        samuel@sholland.org
Subject: Re: [PATCH v3] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <20230103092816.w6hknvd4caeahdo4@orel>
References: <20230102165551.1564960-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102165551.1564960-1-conor@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:55:51PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The SBI PMU extension requires a firmware to be aware of the event to
> counter/mhpmevent mappings supported by the hardware. OpenSBI may use
> DeviceTree to describe the PMU mappings. This binding is currently
> described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by QEMU
> since v7.2.0.
> 
> Import the binding for use while validating dtb dumps from QEMU and
> upcoming hardware (eg JH7110 SoC) that will make use of the event
> mapping.
> 
> Link: https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc # Performance Monitoring Unit Extension
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v3:
> - align descriptions to SBI spec (and fix a misinterpretation of mine)
> - switch to a nested items description, since the descriptions are for
>   the elements of each entry, not the entries themselves
> 
> Changes in v2:
> - use the schema mechanism for dependancies between properties
> - +CC perf maintainers...
> - move the matrix element descriptions into regular item descriptions
>   rather than doing so freeform in the property description
> - drop some description text that no longer applies since changes were
>   made to the SBI spec
> - drop mention of the "generic platform" which is OpenSBI specific
> - drop the min/max items from the matrices, they don't appear to be
>   needed?
> 
> Note:
> OpenSBI is BSD-2-Clause licensed so I am unsure as to whether I can
> submit it with a dual license.
> ---
>  .../devicetree/bindings/perf/riscv,pmu.yaml   | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> new file mode 100644
> index 000000000000..87a47e365311
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/riscv,pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V SBI PMU events
> +
> +maintainers:
> +  - Atish Patra <atishp@rivosinc.com>
> +
> +description: |
> +  SBI PMU extension supports allow supervisor software to configure, start &

support allows

I'd replace '&' with 'and'

> +  stop any performance counter at anytime. Thus, a user can leverage full
> +  capability of performance analysis tools such as perf if the SBI PMU

s/full capability/all capabilities/

> +  extension is enabled. The OpenSBI implementation makes the following
                               ^ Shouldn't we drop references to OpenSBI? 

> +  assumptions about the hardware platform:
> +
> +    The platform must provide information about PMU event to counter mapping

mappings

> +    via device tree or platform specific hooks. Otherwise, the SBI PMU
> +    extension will not be enabled.
> +
> +    The platforms should provide information about the PMU event selector
> +    values that should be encoded in the expected value of MHPMEVENTx while
> +    configuring MHPMCOUNTERx for that specific event. This can be done via a
> +    device tree or platform specific hooks. The exact value to be written to
> +    the MHPMEVENTx is completely dependent on the platform.
> +
> +    For information on the SBI specification see the section "Performance
> +    Monitoring Unit Extension" of:
> +      https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> +
> +properties:
> +  compatible:
> +    const: riscv,pmu
> +
> +  riscv,event-to-mhpmevent:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      Represents an ONE-to-ONE mapping between a PMU event and the event
> +      selector value that platform expects to be written to the MHPMEVENTx CSR
                            ^ the
> +      for that event.
> +      The mapping is encoded in an matrix format where each element represents
> +      an event.
> +      This property shouldn't encode any raw hardware event.
> +    items:
> +      items:
> +        - description: event_idx, a 20-bit wide encoding of the event type and
> +            code. Refer to the SBI specification for a complete description of
> +            the event types and codes.
> +        - description: upper 32 bits of the event selector value for MHPMEVENTx
> +        - description: lower 32 bits of the event selector value for MHPMEVENTx
> +
> +  riscv,event-to-mhpmcounters:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      Represents a MANY-to-MANY mapping between a range of events and all the
> +      MHPMCOUNTERx in a bitmap format that can be used to monitor these range
> +      of events. The information is encoded in an matrix format where each
> +      element represents a certain range of events and corresponding counters.
> +      This property shouldn't encode any raw event.
> +    items:
> +      items:
> +        - description: first event_idx of the range of events
> +        - description: last event_idx of the range of events
> +        - description: bitmap of MHPMCOUNTERx for this event
> +
> +  riscv,raw-event-to-mhpmcounters:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      Represents an ONE-to-MANY or MANY-to-MANY mapping between the rawevent(s)
> +      and all the MHPMCOUNTERx in a bitmap format that can be used to monitor
> +      that raw event.
> +      The encoding of the raw events are platform specific. The information is
> +      encoded in a matrix format where each element represents the specific raw
> +      event(s).
> +      If a platform directly encodes each raw PMU event as a unique ID, the
> +      value of variant must be 0xffffffff_ffffffff.
> +    items:
> +      items:
> +        - description:
> +            upper 32 invariant bits for the range of events
> +        - description:
> +            lower 32 invariant bits for the range of events
> +        - description:
> +            upper 32 bits of the variant bit mask for the range of events
> +        - description:
> +            lower 32 bits of the variant bit mask for the range of events
> +        - description:
> +            bitmap of all MHPMCOUNTERx that can monitor the range of events
> +
> +dependencies:
> +  "riscv,event-to-mhpmevent": [ "riscv,event-to-mhpmcounters" ]
> +  "riscv,event-to-mhpmcounters": [ "riscv,event-to-mhpmevent" ]
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmu {
> +        compatible = "riscv,pmu";
> +        riscv,event-to-mhpmevent = <0x0000B 0x0000 0x0001>;
> +        riscv,event-to-mhpmcounters = <0x00001 0x00001 0x00000001>,
> +                                      <0x00002 0x00002 0x00000004>,
> +                                      <0x00003 0x0000A 0x00000ff8>,
> +                                      <0x10000 0x10033 0x000ff000>;
> +        riscv,raw-event-to-mhpmcounters =
> +            /* For event ID 0x0002 */
> +            <0x0000 0x0002 0xffffffff 0xffffffff 0x00000f8>,
> +            /* For event ID 0-4 */
> +            <0x0 0x0 0xffffffff 0xfffffff0 0x00000ff0>,
> +            /* For event ID 0xffffffff0000000f - 0xffffffff000000ff */
> +            <0xffffffff 0x0 0xffffffff 0xffffff0f 0x00000ff0>;
> +    };
> +
> +  - |
> +    /*
> +     * For HiFive Unmatched board the encodings can be found here
> +     * https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

I'd add a blank line here in this comment block.

> +     * This example also binds standard SBI PMU hardware id's to U74 PMU event

IDs

> +     * codes, U74 uses a bitfield for events encoding, so several U74 events
> +     * can be bound to single perf id.
                                ^ a   ID

> +     * See SBI PMU hardware id's in OpenSBI's include/sbi/sbi_ecall_interface.h

IDs

Linux has its own copy of enum sbi_pmu_hw_generic_events_t in
arch/riscv/include/asm/sbi.h which can be referenced.

> +     */
> +    pmu {
> +          compatible = "riscv,pmu";
> +          riscv,event-to-mhpmevent =
> +              /* SBI_PMU_HW_CACHE_REFERENCES -> Instruction or Data cache/ITIM busy */
> +              <0x00003 0x00000000 0x1801>,
> +              /* SBI_PMU_HW_CACHE_MISSES -> Instruction or Data cache miss or MMIO access */
> +              <0x00004 0x00000000 0x0302>,
> +              /* SBI_PMU_HW_BRANCH_INSTRUCTIONS -> Conditional branch retired */
> +              <0x00005 0x00000000 0x4000>,
> +              /* SBI_PMU_HW_BRANCH_MISSES -> Branch or jump misprediction */
> +              <0x00006 0x00000000 0x6001>,
> +              /* L1D_READ_MISS -> Data cache miss or MMIO access */
> +              <0x10001 0x00000000 0x0202>,
> +              /* L1D_WRITE_ACCESS -> Data cache write-back */
> +              <0x10002 0x00000000 0x0402>,
> +              /* L1I_READ_ACCESS -> Instruction cache miss */
> +              <0x10009 0x00000000 0x0102>,
> +              /* LL_READ_MISS -> UTLB miss */
> +              <0x10011 0x00000000 0x2002>,
> +              /* DTLB_READ_MISS -> Data TLB miss */
> +              <0x10019 0x00000000 0x1002>,
> +              /* ITLB_READ_MISS-> Instruction TLB miss */
> +              <0x10021 0x00000000 0x0802>;
> +          riscv,event-to-mhpmcounters = <0x00003 0x00006 0x18>,
> +                                        <0x10001 0x10002 0x18>,
> +                                        <0x10009 0x10009 0x18>,
> +                                        <0x10011 0x10011 0x18>,
> +                                        <0x10019 0x10019 0x18>,
> +                                        <0x10021 0x10021 0x18>;
> +          riscv,raw-event-to-mhpmcounters = <0x0 0x0 0xffffffff 0xfc0000ff 0x18>,
> +                                            <0x0 0x1 0xffffffff 0xfff800ff 0x18>,
> +                                            <0x0 0x2 0xffffffff 0xffffe0ff 0x18>;
> +    };
> -- 
> 2.39.0
>

Thanks,
drew
