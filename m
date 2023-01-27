Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D48667E284
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjA0LBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjA0LB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:01:27 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEC234F2;
        Fri, 27 Jan 2023 03:01:16 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pLMTL-004hGz-0u; Fri, 27 Jan 2023 19:00:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Jan 2023 19:00:43 +0800
Date:   Fri, 27 Jan 2023 19:00:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/3] hwrng: starfive: Add driver for TRNG module
Message-ID: <Y9Ou20ocr+ReaFVZ@gondor.apana.org.au>
References: <20230117015445.32500-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117015445.32500-1-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:54:42AM +0800, Jia Jie Ho wrote:
> This patch series adds kernel support for StarFive JH7110 hardware
> random number generator. First 2 patches add binding docs and device
> driver for this module. Patch 3 adds devicetree entry for VisionFive 2
> SoC.
> 
> Patch 3 needs to be applied on top of:
> https://patchwork.kernel.org/project/linux-riscv/patch/20221220011247.35560-7-hal.feng@starfivetech.com/
> 
> Patch 3 also depends on additional clock and reset patches for stg
> domain that are yet to be submitted to mailing list.
> 
> Changes v4->v5:
> - Updated status in MAINTAINERS. (Conor)
> - Specified targeted device in Kconfig title and descriptions. (Conor)
> - Removed unnecessary goto label in patch 2. (Conor)
> - Enable runtime PM before registering hwrng in patch 2. (Conor)
> 
> Changes v3->v4:
> - Moved init_completion before IRQ registration to be prepared for
>   spurious interrupts. (Herbert)
> - Added locks to guard concurrent write to the same register. (Herbert)
> 
> Changes v2->v3:
> - Use constant usecs and convert to jiffies. (Herbert)
> - Removed sleep in irq handler. (Herbert)
> - Limited wait time to 40us if wait == 0 for trng read. (Herbert)
> 
> Changes v1->v2:
> - Updated of_match_ptr and added pm_sleep_ptr. (Krzysztof)
> - Dropped "status" in dts as module is always on. (Krzysztof)
> 
> Jia Jie Ho (3):
>   dt-bindings: rng: Add StarFive TRNG module
>   hwrng: starfive - Add TRNG driver for StarFive SoC
>   riscv: dts: starfive: Add TRNG node for VisionFive 2
> 
>  .../bindings/rng/starfive,jh7110-trng.yaml    |  55 +++
>  MAINTAINERS                                   |   6 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  10 +
>  drivers/char/hw_random/Kconfig                |  11 +
>  drivers/char/hw_random/Makefile               |   1 +
>  drivers/char/hw_random/jh7110-trng.c          | 393 ++++++++++++++++++
>  6 files changed, 476 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
>  create mode 100644 drivers/char/hw_random/jh7110-trng.c
> 
> -- 
> 2.25.1

Patches 1-2 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
