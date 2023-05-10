Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A26FD788
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjEJG4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjEJG4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:56:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6895730FC;
        Tue,  9 May 2023 23:56:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 324D6547;
        Wed, 10 May 2023 08:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683701781;
        bh=I1nga5E7NXEX+wSs7lO3+iw/5QQRIl796jYt1o/N/gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZ2MGxpgHLKGjisJ6+ijPWpDws2eK5PtcGTPPUSiqWJ+e4x81Ocy41rYbvGNNKhIk
         osboNYgFVp7Rh4o/G+K3soUUA7/oNQyKeL65aoUCmVHEs+R9NTAFDWBSoG6Qf+eTGo
         oDz3TxcNaRDmEfcQDpzNV7kJePOdUOnTgZdxecRU=
Date:   Wed, 10 May 2023 09:56:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/23] arm64: zynqmp: Set qspi tx-buswidth to 4
Message-ID: <20230510065623.GC11711@pendragon.ideasonboard.com>
References: <cover.1683034376.git.michal.simek@amd.com>
 <0cc9dce0330abf3df46252ab63a3930bded23e4b.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cc9dce0330abf3df46252ab63a3930bded23e4b.1683034376.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Tue, May 02, 2023 at 03:35:31PM +0200, Michal Simek wrote:
> From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> 
> All ZynqMP boards are setting up tx-buswidth to 1. Due to this the
> framework only issues 1-1-1 write commands to the GQSPI driver. But the
> GQSPI controller is capable of handling 1-4-4 write commands, so updated
> the tx-buswidth to 4.
> This would enable the spi-nor framework to issue 1-4-4 write commands
> instead of 1-1-1. This will increase the tx data transfer rate, as now the
> tx data will be transferred on four lines instead on single line.

The change seems OK, but the commit message shouldn't mention drivers.
DT is a hardware description, the commit message should focus on that.

> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index 34412304d09f..dcc17e3ea961 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -85,7 +85,7 @@ flash@0 { /* MT25QU512A */
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>;
>  		spi-max-frequency = <40000000>; /* 40MHz */
>  		partition@0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> index f1598527e5ec..4d301ea0bdcb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> @@ -44,7 +44,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>;
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> index 04efa1683eaa..485a7b21157a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> @@ -45,7 +45,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> index e971ba8c1418..676b8550a625 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> @@ -47,7 +47,7 @@ &qspi {
>  	flash@0 {
>  		compatible = "m25p80", "jedec,spi-nor";
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>;
>  		spi-max-frequency = <108000000>;
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index 5fa9604f05d1..35fe7857459a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -355,7 +355,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>;
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> index 6e0106bf1294..311cb2f81c7b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> @@ -173,7 +173,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>; /* also DUAL configuration possible */
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 78043d9de7cc..5b6403865541 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -957,7 +957,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index c1779c88ec34..a74a2061431a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -444,7 +444,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>;
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index b857c1950496..73972d83ed4d 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -456,7 +456,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>;
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index e4e09afbdc1a..5a54d066db86 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -964,7 +964,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 791b2ac9fbdb..3b37df98700c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -794,7 +794,7 @@ flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
>  		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>  	};

-- 
Regards,

Laurent Pinchart
