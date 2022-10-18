Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC96603033
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJRPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJRPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:52:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4CBC14BA;
        Tue, 18 Oct 2022 08:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6484B81FF9;
        Tue, 18 Oct 2022 15:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2483C433D6;
        Tue, 18 Oct 2022 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666108264;
        bh=bLdmMle94QQwCBRxz3r6k1ilHoY6wGNxy1a0zdTcu18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4XHmj26B2z94vShlmPetNZJEwXdsYIVvD/5QnLCZSSU8yk65hTV+YPCeiPJS7jY/
         i8IAkhn8MrdJRhe9M3vIVk2Wo9RDALAMHOZsIoCI/WaNidG05zJIMBYhLrZPJfkvHF
         bJm6kP+tR7jdv9pBK1Efd6NEQJmYGEuBeBc3UmUQ/nYYnIsH4EpRtjFMdU3rwqydku
         Fo1YVHn/FGelFRHR9uAk0LzMqBluACgDRboDI3QaSUp54iJC+9WHZp3HoCNJhb+dWH
         pDSlvFQTlDMa1zUhPQxLAhMbJfhHn8cxlO3H9Z5zFUQ6WJ4sPlzBmuiDnnuXnOyPrq
         WRyDvLHxiGV3A==
Date:   Tue, 18 Oct 2022 16:50:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/2] dt-bindings: mtd: partitions: u-boot: allow
 dynamic subpartitions
Message-ID: <Y07LYoq6Dh+k0uJm@spud>
References: <20221018154202.4634-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221018154202.4634-1-zajec5@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 05:42:01PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot partition may contain subpartitions. For example Broadcom
> includes environment data block in the middle of its U-Boot partition.
> 
> This allows describing Broadcom's U-Boot env data and will allow
> referencing its NVMEM cell in the future.
> 
> Reg: 118f3fbe517f4 ("dt-bindings: mtd: partitions: support label/name only partition")

Pardon my ignorance here, but what is the significance of a "Reg" tag?
Thanks,
Conor.

> Ref: dd638202dfb65 ("dt-bindings: mtd: partitions: add additional example for qcom,smem-part")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V3: Add this patch as pre-requirement for u-boot,env.yaml & brcm,env
> ---
>  .../devicetree/bindings/mtd/partitions/u-boot.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml b/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
> index 8a88e7d16524..3c56efe48efd 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
> @@ -27,6 +27,10 @@ properties:
>            Broadcom stores environment variables inside a U-Boot partition. They
>            can be identified by a custom header with magic value.
>  
> +patternProperties:
> +  "^partition-.*$":
> +    $ref: partition.yaml#
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -40,6 +44,9 @@ examples:
>              compatible = "brcm,u-boot";
>              reg = <0x0 0x100000>;
>              label = "u-boot";
> +
> +            partition-u-boot-env {
> +            };
>          };
>  
>          partition@100000 {
> -- 
> 2.34.1
> 
