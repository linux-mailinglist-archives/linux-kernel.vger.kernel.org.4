Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BEB5FFB26
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJOQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJOQBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:01:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66C444B2;
        Sat, 15 Oct 2022 09:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A318BCE0AB5;
        Sat, 15 Oct 2022 16:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F48C433C1;
        Sat, 15 Oct 2022 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665849671;
        bh=5DW+KfgeP2TSoBevcMQCqBiQ6w16gwzYO6dEt63VsXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CrprHuiVK/GF8bX9i7S1Mqi8ckPruPrhU+xVvLoDKcNvL9kRQVY88Z7s142oyo7zH
         25wSgw00z2SKr/1QVKTnC386ROpES7+yNG2CJEWNSIsLst7613jgHHQPMR76AbaO6L
         G0VgqsnUYLYvgtNf+YFj1KUZXCcwa5HxFO4e+Bpm4UQXusl5AWoJNyw4wOX4Lj5ZZb
         LU3+Ypv5fKBNuADSpBcDowG/Sd5iwj9Yu8QiQUYY3qa/4K6nTyyB2Nyycfma3G6Hsr
         4riLWL+QXsdOpiuawbQPRo0oeih90R9c53+u8Fhvmfg4bliTLJg2qbWjmuKkSMSt1f
         r3IY9qYJtWN1Q==
Date:   Sat, 15 Oct 2022 17:01:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] iio: stm32-adc: add support of adc for stm32mp13
Message-ID: <20221015170137.072b143a@jic23-huawei>
In-Reply-To: <aeb970f3-a089-dbe0-5fa8-63da657850d4@foss.st.com>
References: <20221012142205.13041-1-olivier.moysan@foss.st.com>
        <aeb970f3-a089-dbe0-5fa8-63da657850d4@foss.st.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 14:52:49 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 10/12/22 16:21, Olivier Moysan wrote:
> > On STM32MP13 SoCs, each ADC peripheral has a single ADC block.
> > These ADC peripherals, ADC1 and ADC2, are fully independent.
> > The STM32MP131 SoC provides only ADC2, while other STM32MP13x
> > SoCs provide both ADC1 and ADC2.
> > 
> > The STM32MP13 ADC features and characteristics are slightly
> > different from STM32MP15 ADC ones, requiring a specific support
> > in the driver.
> > 
> > This patchset enables the ADC peripheral on STM32MP135F-DK board.
> > 
> > On STM32MP135F-DK board the ADC is connected to VDDA voltage
> > provided by the PMIC LOD1 supply, which has to be enabled through
> > SCMI regulator framework.
> > This serie introduces a fixed regulator to allow ADC probing,
> > while SCMI regulators support is not available. This does
> > not ensure ADC regulator enabling however.  
> 
> 
> Hi Olivier,
> 
> I've one tiny remark on PATCH 5/8, "ARM: dts: stm32: add adc support to
> stm32mp13"
> 
> With that fixed, for the whole series, you can add my:
> 
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied 1 to the the fixes-togreg branch of iio.git and
2,3,4 to the togreg branch of iio.git (pushed out as testing only
until I can rebase on rc1).

No overlap in code affected, so this should work fine and means
I don't have to remember to pick up the non fixes later in the cycle.

Thanks,

Jonathan

> 
> Thanks,
> Fabrice
> 
> > 
> > Changes in v4:
> > - reformat patch 1 commit message
> > - reorder adc1 node
> > 
> > v3:
> > - Remove blank line in tag block
> > - Use HZ_PER_MHZ unit for max frequency definition
> > - Coding style updates
> > 
> > v2:
> > - Rework commit message length
> > - Add missing spaces
> > - Remove useless defines
> > 
> > Olivier Moysan (8):
> >   iio: adc: stm32-adc: fix channel sampling time init
> >   dt-bindings: iio: adc: stm32-adc: add stm32mp13 compatibles
> >   iio: adc: stm32-adc: add stm32mp13 support
> >   iio: adc: stm32: manage min sampling time on all internal channels
> >   ARM: dts: stm32: add adc support to stm32mp13
> >   ARM: dts: stm32: add adc pins muxing on stm32mp135f-dk
> >   ARM: dts: stm32: add dummy vdd_adc regulator on stm32mp135f-dk
> >   ARM: dts: stm32: add adc support on stm32mp135f-dk
> > 
> >  .../bindings/iio/adc/st,stm32-adc.yaml        |  68 ++++-
> >  arch/arm/boot/dts/stm32mp13-pinctrl.dtsi      |   7 +
> >  arch/arm/boot/dts/stm32mp131.dtsi             |  43 +++
> >  arch/arm/boot/dts/stm32mp133.dtsi             |  31 +++
> >  arch/arm/boot/dts/stm32mp135f-dk.dts          |  33 +++
> >  drivers/iio/adc/stm32-adc-core.c              |  30 ++-
> >  drivers/iio/adc/stm32-adc-core.h              |  30 +++
> >  drivers/iio/adc/stm32-adc.c                   | 247 +++++++++++++++---
> >  8 files changed, 443 insertions(+), 46 deletions(-)
> >   

