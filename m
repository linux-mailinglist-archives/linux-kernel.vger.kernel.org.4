Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58149701441
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 05:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjEMDqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 23:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMDqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 23:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F44A3C1E;
        Fri, 12 May 2023 20:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1539961E2F;
        Sat, 13 May 2023 03:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EF5C433EF;
        Sat, 13 May 2023 03:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683949597;
        bh=trgybS2M0zTEyWwOim8Ya8yxRceg8jK3XrVS9pVL9uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIB1Ixf8oT0/wIZr725B9RkA6X6JTMiiAV35Lv/Ha590Ud03HLifAKUdCz9Z/zMby
         EgFEIw11Gw+2sO5M9/tnwRVjvFwfnMWl+i/ZjXvDm9ZCHssmDPnHRtPVymENn2BgI8
         ehXtRNIhr8CBSd+kK1o65poCM14bWRRx9Q/tsFOP8aWKNmYLJ6IxMzVPn2yyW4qbS2
         mPhuE1SeEdinn4P4qf9/+vIVon39JiLKkV3C/vJTbjDMCxZyzaEKlAuAjePYLuA7lU
         dV9A+HI4mCbeMPdd45Mp5FXiq84429u5ZF8LLM3373W/tuoMxKWMUTGp3rIhaAFadO
         tSpcPBzmSitnQ==
Date:   Sat, 13 May 2023 11:46:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, pawell@cadence.com,
        imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM &
 QXPB0 at super speed
Message-ID: <20230513034624.GE727834@dragon>
References: <20230413155043.102307-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413155043.102307-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:50:43AM -0400, Frank Li wrote:
> Resolve USB 3.0 gadget failure for QM and QXPB0 in super speed mode with single
> IN and OUT endpoints, like mass storage devices, due to incorrect
> ACTUAL_MEM_SIZE in ep_cap2 (32k instead of actual 18k). Implement dt property
> cdns,on-chip-buff-size to override ep_cap2 and set it to 18k for imx8QM and
> imx8QXP chips. No adverse effects for 8QXP C0.
> 
> Fixes: dce49449e04ff ("usb: cdns3: allocate TX FIFO size according to composite EP number")
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

There are a couple of check patch warnings on commit log.

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
Resolve USB 3.0 gadget failure for QM and QXPB0 in super speed mode with single

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")'
#13: 
Fixes: dce49449e04ff ("usb: cdns3: allocate TX FIFO size according to composite EP number")

> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> index b32c2e199c160..030c273c8be40 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> @@ -171,6 +171,7 @@ usbotg3_cdns3: usb@5b120000 {
>  			interrupt-names = "host", "peripheral", "otg", "wakeup";
>  			phys = <&usb3_phy>;
>  			phy-names = "cdns3,usb3-phy";
> +			cdns,on-chip-buff-size = /bits/ 16 <18>;

The property is defined as uint32 in the bindings.  Not sure why we
need to enforce 16-bits here.

Shawn

>  			status = "disabled";
>  		};
>  	};
> -- 
> 2.34.1
> 
