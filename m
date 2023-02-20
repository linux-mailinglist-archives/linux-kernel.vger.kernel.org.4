Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2293069CF44
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjBTOWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjBTOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:22:39 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F51EFCE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:22:37 -0800 (PST)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 555B13F1C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676902956;
        bh=15KdzNFX7MaKLfDAFP/yezApxH/xR6DxYD9Z1QEyvxM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aw+CJ6efsksFvrIUuatebjN+9htiQN2MZRX/+RhPfSWIPUlrYuBJFGUZcDgQ3Yz8r
         pjjDES4obX6kk5Z4uWue0qFQheuQxxfR078kToEhuu/v36y2elQ/VLcaAJCRmb+7Ux
         wmpVCiTNoQ2nfMbmZmBKFR/x6pbaJD4hDTnTKlMmEvRXo4MpuiPg8NXWNg7vg7SEkL
         DBlhUV4eTXCGjI9w5KyVqWa73acfy7Z/9NesuKSUaOYefXmtzJSUmwFZJWh4Pa5ejC
         qmZVeZTEF9d8pwACDvpO54dCElrREYoYmKrMVoMynqqoKe1bPGTeqQxEUi3PS4lGFK
         BzARUkrx7JF5A==
Received: by mail-qv1-f69.google.com with SMTP id u18-20020a0cec92000000b0056ea549d728so559393qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15KdzNFX7MaKLfDAFP/yezApxH/xR6DxYD9Z1QEyvxM=;
        b=k7ftENc+0CnGFkEyiYis2ffgM7fbwINwAh4zd5AVuj+DIGZp9Er6vhzH9xChYVBjyB
         2R9pETKFeqmvqk8x6rEpr5V0eCUZS+ZGVq3koreDW2f0yOIcRd0GYx8sn2cqsAOWgPq1
         fw/P3MiA1aFhZ0GSA2RAO9bWqX+PpitrnP9555/OAfhiwypkarjzQh9uIbNXPZi9GZL0
         yeIPUWMirr3fvMJBP6F65CdNF4kZQuqhTRxagtJtEZKPVvUH/ZSLNyk6XQpya0A4oDTl
         6cUKOXjXKarDV6iJ5POOXRCEZUpPj2fy1Li/NxW8rGQKE3g/YtZKXZF41JuaNiLr2LG6
         Fbbg==
X-Gm-Message-State: AO0yUKXgGS2704xySpjeVXIEXgeYU9j24Lv7wa0/GzhG1eUc/s7H2oA2
        hShFRaW1tsEOiBhvkHz0YgrfAZOvw5+WLaKMwvPb0MmenAOhwmrnbxxuE5sZowcNqcE8rfJn0Ii
        1cxP4EKOWxPV7IBBJyWFTFjXfCVw8HNbPY4igYBLcljTlID7zYaxLLsd4lg==
X-Received: by 2002:ac8:701b:0:b0:3b7:fda5:1cbc with SMTP id x27-20020ac8701b000000b003b7fda51cbcmr213066qtm.5.1676902954913;
        Mon, 20 Feb 2023 06:22:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+dV6jlM0TuskfDPI955wHdR3MIsyp4aZm7ZGrdR5YGZR5IqoJRIZac7YadjSfeXQ/9C9c1FhXN+okz8gNXcw4=
X-Received: by 2002:ac8:701b:0:b0:3b7:fda5:1cbc with SMTP id
 x27-20020ac8701b000000b003b7fda51cbcmr213061qtm.5.1676902954624; Mon, 20 Feb
 2023 06:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20230118061701.30047-1-yanhong.wang@starfivetech.com> <20230118061701.30047-7-yanhong.wang@starfivetech.com>
In-Reply-To: <20230118061701.30047-7-yanhong.wang@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 20 Feb 2023 15:22:18 +0100
Message-ID: <CAJM55Z9=wXxHXLHhLK1H2H2PnLv4Z+FiQPVd_+gtPss+P01MRg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] riscv: dts: starfive: jh7110: Add ethernet device node
To:     Yanhong Wang <yanhong.wang@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 at 07:19, Yanhong Wang
<yanhong.wang@starfivetech.com> wrote:
> Add JH7110 ethernet device node to support gmac driver for the JH7110
> RISC-V SoC.
>
> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 93 ++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index c22e8f1d2640..c6de6e3b1a25 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -433,5 +433,98 @@
>                         reg-shift = <2>;
>                         status = "disabled";
>                 };
> +
> +               stmmac_axi_setup: stmmac-axi-config {
> +                       snps,lpi_en;
> +                       snps,wr_osr_lmt = <4>;
> +                       snps,rd_osr_lmt = <4>;
> +                       snps,blen = <256 128 64 32 0 0 0>;
> +               };
> +
> +               gmac0: ethernet@16030000 {
> +                       compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
> +                       reg = <0x0 0x16030000 0x0 0x10000>;
> +                       clocks = <&aoncrg JH7110_AONCLK_GMAC0_AXI>,
> +                                <&aoncrg JH7110_AONCLK_GMAC0_AHB>,
> +                                <&syscrg JH7110_SYSCLK_GMAC0_PTP>,
> +                                <&aoncrg JH7110_AONCLK_GMAC0_TX>,

The gmac0_tx clock is a mux that takes either the gmac0_gtxclk or
rmii_rtx as parent. However it is then followed by an inverter that
optionally inverts the clock, gmac0_tx_inv. I'm guessing this
optionally inverted signal is what is actually used (otherwise why
would the inverter exist), so I think this clock is what should be
claimed here. Eg.
    <&aoncrg JH7110_AONCLK_GMAC0_TX_INV>,

Right now it works only because the inverted signal can't be gated
(turned off) even when it's not claimed by any driver.

> +                                <&syscrg JH7110_SYSCLK_GMAC0_GTXC>,
> +                                <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>;

Here the gmac0_gtxclk clock is the parent of the gmac0_gtxc, so
claiming the gmac0_gtxc should be enough. Since the gmac0_gtxc is just
a gate it should have the CLK_SET_RATE_PARENT flag set, so the driver
can just change the rate of the child and it should propagate to the
parent. In short I think claiming only the gmac0_gtxc clock should be
enough here.

> +                       clock-names = "stmmaceth", "pclk", "ptp_ref",
> +                                               "tx", "gtxc", "gtx";
> +                       resets = <&aoncrg JH7110_AONRST_GMAC0_AXI>,
> +                                <&aoncrg JH7110_AONRST_GMAC0_AHB>;
> +                       reset-names = "stmmaceth", "ahb";
> +                       interrupts = <7>, <6>, <5>;
> +                       interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
> +                       phy-mode = "rgmii-id";
> +                       snps,multicast-filter-bins = <64>;
> +                       snps,perfect-filter-entries = <8>;
> +                       rx-fifo-depth = <2048>;
> +                       tx-fifo-depth = <2048>;
> +                       snps,fixed-burst;
> +                       snps,no-pbl-x8;
> +                       snps,force_thresh_dma_mode;
> +                       snps,axi-config = <&stmmac_axi_setup>;
> +                       snps,tso;
> +                       snps,en-tx-lpi-clockgating;
> +                       snps,txpbl = <16>;
> +                       snps,rxpbl = <16>;
> +                       status = "disabled";
> +                       phy-handle = <&phy0>;
> +
> +                       mdio0: mdio {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               compatible = "snps,dwmac-mdio";
> +
> +                               phy0: ethernet-phy@0 {
> +                                       reg = <0>;
> +                               };
> +                       };
> +               };
> +
> +               gmac1: ethernet@16040000 {
> +                       compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
> +                       reg = <0x0 0x16040000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_GMAC1_AXI>,
> +                                <&syscrg JH7110_SYSCLK_GMAC1_AHB>,
> +                                <&syscrg JH7110_SYSCLK_GMAC1_PTP>,
> +                                <&syscrg JH7110_SYSCLK_GMAC1_TX>,
> +                                <&syscrg JH7110_SYSCLK_GMAC1_GTXC>,
> +                                <&syscrg JH7110_SYSCLK_GMAC1_GTXCLK>;
> +                       clock-names = "stmmaceth", "pclk", "ptp_ref",
> +                                       "tx", "gtxc", "gtx";
> +                       resets = <&syscrg JH7110_SYSRST_GMAC1_AXI>,
> +                                <&syscrg JH7110_SYSRST_GMAC1_AHB>;
> +                       reset-names = "stmmaceth", "ahb";
> +                       interrupts = <78>, <77>, <76>;
> +                       interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
> +                       phy-mode = "rgmii-id";
> +                       snps,multicast-filter-bins = <64>;
> +                       snps,perfect-filter-entries = <8>;
> +                       rx-fifo-depth = <2048>;
> +                       tx-fifo-depth = <2048>;
> +                       snps,fixed-burst;
> +                       snps,no-pbl-x8;
> +                       snps,force_thresh_dma_mode;
> +                       snps,axi-config = <&stmmac_axi_setup>;
> +                       snps,tso;
> +                       snps,en-tx-lpi-clockgating;
> +                       snps,txpbl = <16>;
> +                       snps,rxpbl = <16>;
> +                       status = "disabled";
> +                       phy-handle = <&phy1>;
> +
> +                       mdio1: mdio {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               compatible = "snps,dwmac-mdio";
> +
> +                               phy1: ethernet-phy@1 {
> +                                       reg = <1>;
> +                               };
> +                       };
> +               };
>         };
>  };
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
