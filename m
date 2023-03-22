Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B86C405E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCVC1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVC1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:27:51 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EADBF166F8;
        Tue, 21 Mar 2023 19:27:49 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 22 Mar 2023 11:27:48 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B55332059034;
        Wed, 22 Mar 2023 11:27:48 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 22 Mar 2023 11:27:48 +0900
Received: from [10.212.157.147] (unknown [10.212.157.147])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 12DF7B6343;
        Wed, 22 Mar 2023 11:27:48 +0900 (JST)
Message-ID: <57a8f73c-02ad-6f77-95f0-9c05e25e4146@socionext.com>
Date:   Wed, 22 Mar 2023 11:27:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: mmc: fujitsu: Add Socionext Synquacer
To:     Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230319173006.30455-1-robh@kernel.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20230319173006.30455-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2023/03/20 2:30, Rob Herring wrote:
> Add support for Socionext Synquacer SDHCI. This binding has been in use
> for
> some time.
> 
> The interrupts were not documented. The driver only uses the first
> interrupt, but the DT and example have 2 interrupts. The 2nd one is
> unknown. "dma-coherent" was also not documented, but is used on Synquacer.

Surely "interrupts" is needed. The 2nd interrupt seems to come from
the card, though, the driver isn't supported it.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - Rebase on conversion done by Kunihiko
> ---
>   .../bindings/mmc/fujitsu,sdhci-fujitsu.yaml       | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
> b/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
> index 73d747e917f3..430b62899397 100644
> --- a/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
> @@ -14,9 +14,13 @@ allOf:
>   
>   properties:
>     compatible:
> -    enum:
> -      - fujitsu,mb86s70-sdhci-3.0
> -      - socionext,f-sdh30-e51-mmc
> +    oneOf:
> +      - items:
> +          - const: socionext,synquacer-sdhci
> +          - const: fujitsu,mb86s70-sdhci-3.0
> +      - enum:
> +          - fujitsu,mb86s70-sdhci-3.0
> +          - socionext,f-sdh30-e51-mmc
>   
>     reg:
>       maxItems: 1
> @@ -29,6 +33,11 @@ properties:
>         - const: iface
>         - const: core
>   
> +  dma-coherent: true
> +
> +  interrupts:
> +    maxItems: 2
> +
>     resets:
>       maxItems: 1
>   


---
Best Regards
Kunihiko Hayashi
