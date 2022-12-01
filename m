Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8A63EC82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLAJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiLAJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:30:10 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72A3D4E6AA;
        Thu,  1 Dec 2022 01:30:04 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Dec 2022 18:30:03 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 93FD12059054;
        Thu,  1 Dec 2022 18:30:03 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 1 Dec 2022 18:30:03 +0900
Received: from [10.212.157.157] (unknown [10.212.157.157])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 03E3AA855E;
        Thu,  1 Dec 2022 18:30:02 +0900 (JST)
Message-ID: <33ca35f4-acee-6b2b-1a73-41ed5882819e@socionext.com>
Date:   Thu, 1 Dec 2022 18:30:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 8/8] dt-bindings: soc: socionext: Add UniPhier AHCI glue
 layer
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-9-hayashi.kunihiko@socionext.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20221129103509.9958-9-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/11/29 19:35, Kunihiko Hayashi wrote:
> Add DT binding schema for components belonging to the platform-specific
> AHCI glue layer implemented in UniPhier SoCs.
> 
> This AHCI glue layer works as a sideband logic for the host controller,
> including core reset, PHYs, and some signals to the controller.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

(snip)

> +examples:
> +  - |
> +    sata-controller@65700000 {
> +        compatible = "socionext,uniphier-pxs3-ahci-glue", "simple-mfd";
> +        reg = <0x65b00000 0x400>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x65700000 0x100>;

In PATCH 7/8, you suggested that the node name of "USB glue layer" should
changes to the generic node name "usb@...".

However, in case of this "AHCI glue layer", I can't change "sata-controller"
to the generic node name "sata@...", because ata/sata-common.yaml has pattern
"^sata(@.*)?$", and the changed node matches this pattern unintentionally.

This layer isn't a sata host controller, so it's hard to give a generic name
to this node. I'd like you opinion.

Thank you,

---
Best Regards
Kunihiko Hayashi
