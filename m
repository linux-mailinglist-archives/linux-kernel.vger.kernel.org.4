Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7D6EC3DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDXDQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjDXDQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:16:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A72212D;
        Sun, 23 Apr 2023 20:16:25 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 366064AD;
        Mon, 24 Apr 2023 05:16:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682306174;
        bh=NPDpujV+oOXwqE5M++R03f5yEhCC275fXEtdzF7RN4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSSNceogIo0YOP3CzBwaoB8kVtirtVOqkEu91cd83/k+zxhNQ0oaAOy55EnnjUq4P
         SzUkFlcrZxXAjiVZ5icmBCU6p41cQE/iOkpZxWAzvwefqcwpwnAprMjp2IA6d/k5yE
         Sbz4thPPklfTLat4wFpycHZ7zi+df4IFaNDnQu/0=
Date:   Mon, 24 Apr 2023 06:16:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Enable CSI and ISI Nodes
Message-ID: <20230424031635.GA4652@pendragon.ideasonboard.com>
References: <20230423212656.1381002-1-aford173@gmail.com>
 <20230424004706.GL21943@pendragon.ideasonboard.com>
 <CAHCN7xKM38RgFW9DAc9co_xcC7NjfymcVEwzu3LMwgYxytCpLA@mail.gmail.com>
 <CAHCN7xLNeN52vhNt0ampSsMfdGx7L+oc3YhUtrvYv-1imQj9eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xLNeN52vhNt0ampSsMfdGx7L+oc3YhUtrvYv-1imQj9eQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Sun, Apr 23, 2023 at 09:59:11PM -0500, Adam Ford wrote:
> On Sun, Apr 23, 2023 at 9:22 PM Adam Ford wrote:
> > On Sun, Apr 23, 2023 at 7:46 PM Laurent Pinchart wrote:
> > > On Sun, Apr 23, 2023 at 04:26:55PM -0500, Adam Ford wrote:
> > > > The CSI in the imx8mn is the same as what is used in the imx8mm,
> > > > but it's routed to the ISI on the Nano. Add both the ISI and CSI
> > > > nodes, and pointing them to each other. Since the CSI capture is
> > > > dependent on an attached camera, mark both ISI and CSI as
> > > > disabled by default.
> > >
> > > I'd then write the subject line as "Add CSI and ISI nodes".
> >
> > That makes sense, especially since I disabled them by default.
> > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > index 8be8f090e8b8..102550b41f22 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > @@ -1104,6 +1104,24 @@ dsim_from_lcdif: endpoint {
> > > >                               };
> > > >                       };
> > > >
> > > > +                     isi: isi@32e20000 {
> > > > +                             compatible = "fsl,imx8mn-isi";
> > > > +                             reg = <0x32e20000 0x100>;
> > >
> > > The i.MX8MN reference manual documents the ISI registers block size to
> > > be 64kB. Should we use the same here, even if all the registers we need
> > > are within the first 256 bytes ?
> >
> > I can do that.
> 
> There is a typo in the Nano Ref Manual.  Even though the table in
> "Table 2-6. AIPS4 Memory Map" reads 64K, the DISPLAY_BLK_CTRL starts
> at 32e2_8000.  The largest size we can do is 0x8000 (32k)

32k is fine. If you prefer keeping 0x100, that's fine with me too.

> > > > +                             interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                             clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> > > > +                                      <&clk IMX8MN_CLK_DISP_APB_ROOT>;
> > > > +                             clock-names = "axi", "apb";
> > > > +                             fsl,blk-ctrl = <&disp_blk_ctrl>;
> > > > +                             power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_ISI>;
> > > > +                             status = "disabled";
> > > > +
> > > > +                             port {
> > > > +                                     isi_in: endpoint {
> > > > +                                             remote-endpoint = <&mipi_csi_out>;
> > > > +                                     };
> > > > +                             };
> > >
> > > This will fail to validate against the ISI DT binding, as they require a
> > > "ports" node. When a single port is present using a "port" node directly
> > > is fine from an OF graph point of view, but to avoid too much complexity
> > > in the ISI binding the consensus was to always require a "ports" node
> > > for the ISI.
> >
> >
> > Argh!  I pulled from the wrong test repo.  I remember the discussion
> > from a few months back.  I'll fix it and the others when I submit V2.
> 
> It appears that using ports still throws warnings:
> 
> arch/arm64/boot/dts/freescale/imx8mn.dtsi:1118.11-1128.7: Warning
> (graph_child_address): /soc@0/bus@32c00000/isi@32e20000/ports: graph
> node has single child node 'port@0', #address-cells/#size-cells are
> not necessary

Aarghhhh :-)

> I'll leave it like this because we were told to do so.

Let's see if Rob or Krzysztof have a recommendation.

> > > > +                     };
> > > > +
> > > >                       disp_blk_ctrl: blk-ctrl@32e28000 {
> > > >                               compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
> > > >                               reg = <0x32e28000 0x100>;
> > > > @@ -1147,6 +1165,42 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
> > > >                               #power-domain-cells = <1>;
> > > >                       };
> > > >
> > > > +                     mipi_csi: mipi-csi@32e30000 {
> > > > +                             compatible = "fsl,imx8mm-mipi-csi2";
> > > > +                             reg = <0x32e30000 0x1000>;
> > > > +                             interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                             assigned-clocks = <&clk IMX8MN_CLK_CAMERA_PIXEL>,
> > > > +                                               <&clk IMX8MN_CLK_CSI1_PHY_REF>;
> > > > +                             assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_1000M>,
> > > > +                                                       <&clk IMX8MN_SYS_PLL2_1000M>;
> > > > +                             assigned-clock-rates = <333000000>;
> > > > +                             clock-frequency = <333000000>;
> > > > +                             clocks = <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> > > > +                                      <&clk IMX8MN_CLK_CAMERA_PIXEL>,
> > > > +                                      <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> > > > +                                      <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
> > > > +                             clock-names = "pclk", "wrap", "phy", "axi";
> > > > +                             power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_MIPI_CSI>;
> > > > +                             status = "disabled";
> > > > +
> > > > +                             ports {
> > > > +                                     #address-cells = <1>;
> > > > +                                     #size-cells = <0>;
> > > > +
> > > > +                                     port@0 {
> > > > +                                             reg = <0>;
> > > > +                                     };
> > > > +
> > > > +                                     port@1 {
> > > > +                                             reg = <1>;
> > > > +
> > > > +                                             mipi_csi_out: endpoint {
> > > > +                                                     remote-endpoint = <&isi_in>;
> > > > +                                             };
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +
> > > >                       usbotg1: usb@32e40000 {
> > > >                               compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
> > > >                               reg = <0x32e40000 0x200>;

-- 
Regards,

Laurent Pinchart
