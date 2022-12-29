Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8882658F70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiL2RNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiL2RNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:13:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270013FBB;
        Thu, 29 Dec 2022 09:13:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2ABF61337;
        Thu, 29 Dec 2022 17:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3809BC433EF;
        Thu, 29 Dec 2022 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672333984;
        bh=QDYaBGUiKiWlnfyJfkUdPRWV+eylE86a9UGNgjXpeOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zkkc6JBdtvNTzozF2B1x7GI7iJvu60LDG5RE0A0aTF0xPIelMQbETyqNwjC/kV3NS
         LMLmPVn5lMEz8WLWzAn5tMCw/GRTYiBSD03Eh+4DYh6XOSaXajHZ2LOlJBLP3Vq07w
         zJ1vvR3MFm6PyeEXnbrIp7Hass8NK8OHbhRA7K06BknCxlhcHeigqT2C0cbc3o7Gkg
         /Pg7qhtAUxgb5xHfbOpPqJjTVaATfxcx6ixbIYHY7S03msgwxaWzg0vZ0KnW48S+Xl
         JxQBT1LAzDiocPC5HP2gK2LKsBytAGUyU9dBwUeRyg0BvmiYgmZ/bZRv5NqkkhBBI8
         EsOXSeOTcLc4A==
Date:   Thu, 29 Dec 2022 11:13:01 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: sm6125: QUPs, SPI and Seine I2C
 buses
Message-ID: <20221229171301.7sjbyvqpn3qjwexu@builder.lan>
References: <20221216233408.1283581-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216233408.1283581-1-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 12:34:05AM +0100, Marijn Suijten wrote:
> Introduce Qualcomm Universal Peripheral support on SM6125 and define all
> known SPI and I2C Serial Engines.  On Sony Seine PDX201 all I2C buses
> with known-connected hardware are enabled for future hardware mapping,
> together with the respective GPI DMA 0 and QUP 0.
> 
> Changes since v1:
> - Un-downstream pinctrl mapping:
>   - Remove nested mux {} / config {};
>   - Remove useless comments;
>   - Remove unreferenced pinctrl states;
> - Use qup14 pinctrl function name instead of unknown qup_14;
> - Reword commit message;
> - Add iommus to QUP nodes now that this series depends on apps_smmu to
>   be available;
> - Reorder all properties to match other SoCs;
> - Reorder/intersperse QUP nodes with GPI DMA nodes to maintain sorting
>   by address;
> - Reorder SPI nodes to fit in with I2C nodes, restoring sorting by
>   address too;
> - Use QCOM_GPI_* constants;
> - Adhere to 3 instead of 5 dma cells for gpi_dma.
> 
> v1: https://lore.kernel.org/all/20221001185628.494884-1-martin.botka@somainline.org/T/#u
> 
> Depends on:
> - SM6125 APPS SMMU: https://lore.kernel.org/linux-arm-msm/20221216215819.1164973-1-marijn.suijten@somainline.org/T/#u
> - SM6125 GPI DMA: https://lore.kernel.org/linux-arm-msm/20221216231528.1268447-1-marijn.suijten@somainline.org/T/#u

Please, in the future, when you have dependencies between your dts
patches, send them together so I don't need to go on a treasure hunt in
my mailbox to figure out which order to apply things...

Regards,
Bjorn

> 
> Marijn Suijten (2):
>   arm64: dts: qcom: sm6125: Add QUPs with SPI and I2C Serial Engines
>   arm64: dts: qcom: sm6125-seine: Enable GPI DMA 0, QUP 0 and I2C SEs
> 
> Martin Botka (1):
>   arm64: dts: qcom: sm6125: Add pin configs for QUP SPI/I2C Serial
>     Engines
> 
>  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  |  29 +
>  arch/arm64/boot/dts/qcom/sm6125.dtsi          | 522 ++++++++++++++++++
>  2 files changed, 551 insertions(+)
> 
> --
> 2.39.0
> 
