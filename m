Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3D698697
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBOUvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjBOUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:51:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F5CF43908;
        Wed, 15 Feb 2023 12:48:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD8DD4B3;
        Wed, 15 Feb 2023 12:48:07 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 426623F881;
        Wed, 15 Feb 2023 12:47:23 -0800 (PST)
Date:   Wed, 15 Feb 2023 20:45:14 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Bastian Germann <bage@debian.org>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: hwlock: sun6i: Add missing names
Message-ID: <20230215204514.613a9a96@slackpad.lan>
In-Reply-To: <20230215203711.6293-4-bage@debian.org>
References: <20230215203711.6293-1-bage@debian.org>
        <20230215203711.6293-4-bage@debian.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 21:37:08 +0100
Bastian Germann <bage@debian.org> wrote:

> The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
> and reset-names set to "ahb" as required by the Linux driver.

Mmmh, but I thought that Krzysztof pretty clearly NAKed this?
So we have to either reach consensus on this or find another solution,
like teaching the driver to comply with the existing binding.
We could for instance get the first clock, should the devm_clk_get()
call fail.

Cheers,
Andre


> 
> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  .../hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> index 38478dad8b25..6cdfe22deb3c 100644
> --- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> +++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> @@ -23,9 +23,17 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  clock-names:
> +    items:
> +      - const: ahb
> +
>    resets:
>      maxItems: 1
>  
> +  reset-names:
> +    items:
> +      - const: ahb
> +
>    '#hwlock-cells':
>      const: 1
>  
> @@ -33,7 +41,9 @@ required:
>    - compatible
>    - reg
>    - clocks
> +  - clock-names
>    - resets
> +  - reset-names
>    - "#hwlock-cells"
>  
>  additionalProperties: false
> @@ -47,7 +57,9 @@ examples:
>          compatible = "allwinner,sun6i-a31-hwspinlock";
>          reg = <0x01c18000 0x1000>;
>          clocks = <&ccu CLK_BUS_SPINLOCK>;
> +        clock-names = "ahb";
>          resets = <&ccu RST_BUS_SPINLOCK>;
> +        reset-names = "ahb";
>          #hwlock-cells = <1>;
>      };
>  ...

