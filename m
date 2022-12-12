Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96056497C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 02:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiLLBxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 20:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiLLBxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:53:12 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0766D60F1;
        Sun, 11 Dec 2022 17:53:09 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Dec 2022 10:53:09 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 676B12059054;
        Mon, 12 Dec 2022 10:53:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 12 Dec 2022 10:53:09 +0900
Received: from [10.212.158.28] (unknown [10.212.158.28])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D19EFA855F;
        Mon, 12 Dec 2022 10:53:08 +0900 (JST)
Message-ID: <9724cb77-5175-acd6-c62e-0d3567222c01@socionext.com>
Date:   Mon, 12 Dec 2022 10:53:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: mmc: Convert Fujitsu SDHCI to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209171621.3351220-1-robh@kernel.org>
 <CAL_JsqL-FVy1SK1ZTVoPaxDG0-7_PtcZZHFWJt8+aaGWFFBwaA@mail.gmail.com>
 <CAMj1kXFJ+779S93dO3BzKKnEw=dBnbtzS+-yboFfj35ASnheJA@mail.gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAMj1kXFJ+779S93dO3BzKKnEw=dBnbtzS+-yboFfj35ASnheJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2022/12/10 3:44, Ard Biesheuvel wrote:
 > cc Jassi and Masahisa
 >
 > On Fri, 9 Dec 2022 at 19:42, Rob Herring <robh@kernel.org> wrote:
 >>
 >> On Fri, Dec 9, 2022 at 11:16 AM Rob Herring <robh@kernel.org> wrote:
 >>>
 >>> Convert the Fujitsu SDHCI binding to DT schema format.
 >>>
 >>> The interrupts were not documented. The driver only uses the first
 >>> interrupt, but the DT and example have 2 interrupts. The 2nd one is
 >>> unknown. "dma-coherent" was also not documented, but is used.
 >>>
 >>> The "socionext,synquacer-sdhci" compatible was not documented, but it is
 >>> compatible with "fujitsu,mb86s70-sdhci-3.0.yaml" and is in use (in
 >>> u-boot Synquacer dts).
 >>>
 >>> Signed-off-by: Rob Herring <robh@kernel.org>
 >>> ---
 >>>   .../mmc/fujitsu,mb86s70-sdhci-3.0.yaml        | 67 +++++++++++++++++++
 >>>   .../devicetree/bindings/mmc/sdhci-fujitsu.txt | 32 ---------
 >>>   2 files changed, 67 insertions(+), 32 deletions(-)
 >>>   create mode 100644 Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
 >>>   delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 >>>
 >>> diff --git a/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml 
b/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
 >>> new file mode 100644
 >>> index 000000000000..0218a6ce4b2f
 >>> --- /dev/null
 >>> +++ b/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
 >>> @@ -0,0 +1,67 @@
 >>> +# SPDX-License-Identifier: GPL-2.0-only
 >>> +%YAML 1.2
 >>> +---
 >>> +$id: http://devicetree.org/schemas/mmc/fujitsu,mb86s70-sdhci-3.0.yaml#
 >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
 >>> +
 >>> +title: Fujitsu SDHCI controller
 >>> +
 >>> +maintainers:
 >>> +  - Vincent Yang <Vincent.Yang@tw.fujitsu.com>
 >>
 >> Bounces. Any other volunteers?
 >>
 >>> +
 >>> +allOf:
 >>> +  - $ref: mmc-controller.yaml#
 >>> +
 >>> +properties:
 >>> +  compatible:
 >>> +    oneOf:
 >>> +      - items:
 >>> +          - const: socionext,synquacer-sdhci
 >>> +          - const: fujitsu,mb86s70-sdhci-3.0
 >>> +      - const: fujitsu,mb86s70-sdhci-3.0
 >>> +
 >>> +  reg:
 >>> +    maxItems: 1
 >>> +
 >>> +  clocks:
 >>> +    items:
 >>> +      - description: Core clock
 >>> +      - description: Interface clock
 >>> +
 >>> +  clock-names:
 >>> +    items:
 >>> +      - const: core
 >>> +      - const: iface
 >>> +
 >>> +  dma-coherent: true
 >>> +
 >>> +  interrupts:
 >>> +    maxItems: 2
 >>> +
 >>> +  fujitsu,cmd-dat-delay-select:
 >>> +    type: boolean
 >>> +    description: Indicating that the host requires the CMD_DAT_DELAY control
 >>> +      to be enabled.
 >>> +
 >>> +required:
 >>> +  - compatible
 >>> +  - reg
 >>> +  - clocks
 >>> +  - clock-names
 >>> +  - interrupts
 >>> +
 >>> +unevaluatedProperties: false
 >>> +
 >>> +examples:
 >>> +  - |
 >>> +    mmc@36600000 {
 >>> +        compatible = "fujitsu,mb86s70-sdhci-3.0";
 >>> +        reg = <0x36600000 0x1000>;
 >>> +        interrupts = <0 172 0x4>,
 >>> +               <0 173 0x4>;
 >>> +        bus-width = <4>;
 >>> +        vqmmc-supply = <&vccq_sdhci1>;
 >>> +        clocks = <&clock 2 2 0>, <&clock 2 3 0>;
 >>> +        clock-names = "core", "iface";
 >>> +    };
 >>> +...
 >>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt 
b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 >>> deleted file mode 100644
 >>> index 3ee9263adf73..000000000000
 >>> --- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 >>> +++ /dev/null
 >>> @@ -1,32 +0,0 @@
 >>> -* Fujitsu SDHCI controller
 >>> -
 >>> -This file documents differences between the core properties in mmc.txt
 >>> -and the properties used by the sdhci_f_sdh30 driver.
 >>> -
 >>> -Required properties:
 >>> -- compatible: "fujitsu,mb86s70-sdhci-3.0"
 >>> -- clocks: Must contain an entry for each entry in clock-names. It is a
 >>> -  list of phandles and clock-specifier pairs.
 >>> -  See ../clocks/clock-bindings.txt for details.
 >>> -- clock-names: Should contain the following two entries:
 >>> -       "iface" - clock used for sdhci interface
 >>> -       "core"  - core clock for sdhci controller
 >>> -
 >>> -Optional properties:
 >>> -- vqmmc-supply: phandle to the regulator device tree node, mentioned
 >>> -  as the VCCQ/VDD_IO supply in the eMMC/SD specs.
 >>> -- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
 >>> -  requires the CMD_DAT_DELAY control to be enabled.
 >>> -
 >>> -Example:
 >>> -
 >>> -       sdhci1: mmc@36600000 {
 >>> -               compatible = "fujitsu,mb86s70-sdhci-3.0";
 >>> -               reg = <0 0x36600000 0x1000>;
 >>> -               interrupts = <0 172 0x4>,
 >>> -                            <0 173 0x4>;
 >>> -               bus-width = <4>;
 >>> -               vqmmc-supply = <&vccq_sdhci1>;
 >>> -               clocks = <&clock 2 2 0>, <&clock 2 3 0>;
 >>> -               clock-names = "iface", "core";
 >>> -       };
 >>> --
 >>> 2.35.1
 >>>

I converted this dt-bindings as follows.

- [PATCH v2 1/6] dt-bindings: mmc: Convert sdhci-fujitsu to JSON schema
   https://marc.info/?l=linux-mmc&m=166815383930945

- [PATCH v2 3/6] dt-bindings: sdhci-fujitsu: Add compatible string for F_SDH30_E51
   https://marc.info/?l=linux-mmc&m=166815384730959

And this series has already merged by Ulf.
https://marc.info/?l=linux-mmc&m=166861511322498

Could you check it and update some diffs?

Thank you,

---
Best Regards
Kunihiko Hayashi

