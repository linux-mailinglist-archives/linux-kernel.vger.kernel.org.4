Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055A569CFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjBTPBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjBTPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:01:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2491DBAE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:01:20 -0800 (PST)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 94BAE3F588
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676905275;
        bh=FT9bNaBG4upzki3OCtwoWOzdZmQXAWEHWUJEPV0NZh4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=kuDr5lPV/q+BNrXIQfPxh+NcMmhnJvARMvffSNQX3c9lgzf/EhZs3Rz92SeV7ZltX
         0mtdGZWTzxSY8VuOiQe1FlfTDu6lhfW6BqrTGe7JpDBPCYPgQFEqP+RT13w3cBSdrm
         1kJGw4s9+ef6QAUc1HmzQDJ01I3KpLWGJqd2pcXbInj2eGdXv9LDlCYsQOyzpFP2qK
         rM/Dxraea25YHZzEdJlXKbhBVV4z5SfAZesgSxxBV0iOMUmM3AcgFAEQLiaUeH7shB
         /aGPH6JWuS95wReChWEmk6VirHLo6tGvSzgZM+pEbBxVrTCtLxZS+jQ2qNoAMD0MAE
         vXXCo4QxshOaw==
Received: by mail-qk1-f199.google.com with SMTP id f11-20020a05620a280b00b006e08208eb31so172212qkp.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT9bNaBG4upzki3OCtwoWOzdZmQXAWEHWUJEPV0NZh4=;
        b=XAB0biWCJfrNZiDCMZ64LTMztBInvugJ763+PlZWyNXwXji/WqkT65AGN6YhwO1Tom
         cPxPAiou2GGyr2TZH5/s5XUqO+Iu9k6K0kPuiGBuleRNMKSttyTMedEx16XqCQCstzPz
         w7Ph994X4STAdokCxLlHJLmO2rP2g5+iyxyrKj4crnoeivCe727BSYcVM1VoA6tv6af4
         /J9HzA9ANO2hMf7rBpDHDJkdUq3oUEguryPiNG8TKnqLcOTiVV4CG7A4GSZYmt8/8cIx
         bTyPfK5FuBU0d2RCef+TGZA1OkvTy/osLUMwBhowE35fSkUnBN55N5bcCt8t7AX0k/r7
         V+6g==
X-Gm-Message-State: AO0yUKXBU4a8S5D9pmapyNl4Pua11msvKskOMtR2gBzidbEL/l3orcmb
        Ks684EKc5CPLKd5O71H7Pqn3bpJPiezARpawicpcR0eoC+W10QtyTOyvizo5xorw6XQeKtEX8eb
        mXhf0f+DoA6AYD3Dg5sTOfk186+uAW9xaEhGCHAtVc4eCgpx+FmT5dqsaGQ==
X-Received: by 2002:a0c:d990:0:b0:570:fc87:4f2c with SMTP id y16-20020a0cd990000000b00570fc874f2cmr314942qvj.83.1676905273199;
        Mon, 20 Feb 2023 07:01:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/ki7cw9SdzzVoTwUxjlP1pm1QijDiLAHbAwflTeRbXjJrLDJeGCNKMi/5l97KZWeWCaRZi6y7UTcBie4q0g1E=
X-Received: by 2002:a0c:d990:0:b0:570:fc87:4f2c with SMTP id
 y16-20020a0cd990000000b00570fc874f2cmr314932qvj.83.1676905272886; Mon, 20 Feb
 2023 07:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20230118061701.30047-1-yanhong.wang@starfivetech.com>
 <20230118061701.30047-7-yanhong.wang@starfivetech.com> <CAJM55Z9=wXxHXLHhLK1H2H2PnLv4Z+FiQPVd_+gtPss+P01MRg@mail.gmail.com>
In-Reply-To: <CAJM55Z9=wXxHXLHhLK1H2H2PnLv4Z+FiQPVd_+gtPss+P01MRg@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 20 Feb 2023 16:00:57 +0100
Message-ID: <CAJM55Z91Z277FB8O_P9VSEqjcPykvhrPOcvx6k05X5veNOo3Lw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 at 15:22, Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
> On Wed, 18 Jan 2023 at 07:19, Yanhong Wang
> <yanhong.wang@starfivetech.com> wrote:
> > Add JH7110 ethernet device node to support gmac driver for the JH7110
> > RISC-V SoC.
> >
> > Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi | 93 ++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > index c22e8f1d2640..c6de6e3b1a25 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > @@ -433,5 +433,98 @@
> >                         reg-shift = <2>;
> >                         status = "disabled";
> >                 };
> > +
> > +               stmmac_axi_setup: stmmac-axi-config {
> > +                       snps,lpi_en;
> > +                       snps,wr_osr_lmt = <4>;
> > +                       snps,rd_osr_lmt = <4>;
> > +                       snps,blen = <256 128 64 32 0 0 0>;
> > +               };
> > +
> > +               gmac0: ethernet@16030000 {
> > +                       compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
> > +                       reg = <0x0 0x16030000 0x0 0x10000>;
> > +                       clocks = <&aoncrg JH7110_AONCLK_GMAC0_AXI>,
> > +                                <&aoncrg JH7110_AONCLK_GMAC0_AHB>,
> > +                                <&syscrg JH7110_SYSCLK_GMAC0_PTP>,
> > +                                <&aoncrg JH7110_AONCLK_GMAC0_TX>,
>
> The gmac0_tx clock is a mux that takes either the gmac0_gtxclk or
> rmii_rtx as parent. However it is then followed by an inverter that
> optionally inverts the clock, gmac0_tx_inv. I'm guessing this
> optionally inverted signal is what is actually used (otherwise why
> would the inverter exist), so I think this clock is what should be
> claimed here. Eg.
>     <&aoncrg JH7110_AONCLK_GMAC0_TX_INV>,
>
> Right now it works only because the inverted signal can't be gated
> (turned off) even when it's not claimed by any driver.
>
> > +                                <&syscrg JH7110_SYSCLK_GMAC0_GTXC>,
> > +                                <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>;
>
> Here the gmac0_gtxclk clock is the parent of the gmac0_gtxc, so
> claiming the gmac0_gtxc should be enough. Since the gmac0_gtxc is just
> a gate it should have the CLK_SET_RATE_PARENT flag set, so the driver
> can just change the rate of the child and it should propagate to the
> parent. In short I think claiming only the gmac0_gtxc clock should be
> enough here.

Oh and just for completeness. This also goes for gmac1 below, and
don't forget to update the yaml binding doc accordingly.

> > +                       clock-names = "stmmaceth", "pclk", "ptp_ref",
> > +                                               "tx", "gtxc", "gtx";
> > +                       resets = <&aoncrg JH7110_AONRST_GMAC0_AXI>,
> > +                                <&aoncrg JH7110_AONRST_GMAC0_AHB>;
> > +                       reset-names = "stmmaceth", "ahb";
> > +                       interrupts = <7>, <6>, <5>;
> > +                       interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
> > +                       phy-mode = "rgmii-id";
> > +                       snps,multicast-filter-bins = <64>;
> > +                       snps,perfect-filter-entries = <8>;
> > +                       rx-fifo-depth = <2048>;
> > +                       tx-fifo-depth = <2048>;
> > +                       snps,fixed-burst;
> > +                       snps,no-pbl-x8;
> > +                       snps,force_thresh_dma_mode;
> > +                       snps,axi-config = <&stmmac_axi_setup>;
> > +                       snps,tso;
> > +                       snps,en-tx-lpi-clockgating;
> > +                       snps,txpbl = <16>;
> > +                       snps,rxpbl = <16>;
> > +                       status = "disabled";
> > +                       phy-handle = <&phy0>;
> > +
> > +                       mdio0: mdio {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                               compatible = "snps,dwmac-mdio";
> > +
> > +                               phy0: ethernet-phy@0 {
> > +                                       reg = <0>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               gmac1: ethernet@16040000 {
> > +                       compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
> > +                       reg = <0x0 0x16040000 0x0 0x10000>;
> > +                       clocks = <&syscrg JH7110_SYSCLK_GMAC1_AXI>,
> > +                                <&syscrg JH7110_SYSCLK_GMAC1_AHB>,
> > +                                <&syscrg JH7110_SYSCLK_GMAC1_PTP>,
> > +                                <&syscrg JH7110_SYSCLK_GMAC1_TX>,
> > +                                <&syscrg JH7110_SYSCLK_GMAC1_GTXC>,
> > +                                <&syscrg JH7110_SYSCLK_GMAC1_GTXCLK>;
> > +                       clock-names = "stmmaceth", "pclk", "ptp_ref",
> > +                                       "tx", "gtxc", "gtx";
> > +                       resets = <&syscrg JH7110_SYSRST_GMAC1_AXI>,
> > +                                <&syscrg JH7110_SYSRST_GMAC1_AHB>;
> > +                       reset-names = "stmmaceth", "ahb";
> > +                       interrupts = <78>, <77>, <76>;
> > +                       interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
> > +                       phy-mode = "rgmii-id";
> > +                       snps,multicast-filter-bins = <64>;
> > +                       snps,perfect-filter-entries = <8>;
> > +                       rx-fifo-depth = <2048>;
> > +                       tx-fifo-depth = <2048>;
> > +                       snps,fixed-burst;
> > +                       snps,no-pbl-x8;
> > +                       snps,force_thresh_dma_mode;
> > +                       snps,axi-config = <&stmmac_axi_setup>;
> > +                       snps,tso;
> > +                       snps,en-tx-lpi-clockgating;
> > +                       snps,txpbl = <16>;
> > +                       snps,rxpbl = <16>;
> > +                       status = "disabled";
> > +                       phy-handle = <&phy1>;
> > +
> > +                       mdio1: mdio {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                               compatible = "snps,dwmac-mdio";
> > +
> > +                               phy1: ethernet-phy@1 {
> > +                                       reg = <1>;
> > +                               };
> > +                       };
> > +               };
> >         };
> >  };
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
