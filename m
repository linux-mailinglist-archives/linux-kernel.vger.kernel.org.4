Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C1625335
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 06:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKKFtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 00:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKKFtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:49:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F26F371;
        Thu, 10 Nov 2022 21:49:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77F1CB823DD;
        Fri, 11 Nov 2022 05:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE34C433D6;
        Fri, 11 Nov 2022 05:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668145745;
        bh=hU/Yy4eYDYCYpklieod8to4COUTLVXdAA92+1J4XZdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RX3ISyfDwYghXa2w6ZY0mI9y7mP1oMuySJIeaBAXMyk/zLEu//JlGKeLMpRZ4lUE6
         NKanGTyVmZS3GQUZ+3JDHEHth++ffOZeoFRENHcNYAkLwa3MFhjTRE24HT9j7B2RHO
         w3dY7hNEhEMFdTbmQdZvVh0aLfaN/GAokkk+1TqQK/uWj0Qksk2t1IScB7Vv2o5lPT
         0io3tse8ivqlQIZN6u0aIeiakgTH8GsxdDgCCNrarpZ2ELCD+teKau6USNbfHJnQDC
         d6auBUrJ4NjqhvJTlMUUtYRvYw5xNfOxuJOlcm4mAlBcqjjxe8gYUDPglc3oTJeDgP
         jmxiBCr9yD8+w==
Date:   Fri, 11 Nov 2022 13:48:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Peter Chen <peter.chen@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] arm64: dts: verdin-imx8mp: usb dual-role
 switching et. al.
Message-ID: <20221111054856.GE2649582@dragon>
References: <20221102131203.35648-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102131203.35648-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:11:57PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> This series is an assortment of USB dual-role specific commits as
> follows:
> 
> Improvement of pinctrl for vbus-supplies:
> As we are using two fixed regulators for Verdin USB_1_EN (SODIMM 155)
> and Verdin USB_2_EN (SODIMM 185), those should be muxed as GPIOs rather
> than OTG_PWR.
> 
> Removal of USB_2 over-current detection disabling:
> The disable-over-current property is only applicable for the
> ci-hdrc-usb2 and dwc2 drivers while the i.MX 8M Plus integrates dwc3
> IP. Therefore remove this property which does not really serve any
> purpose here.
> 
> Addition of USB_1 over-current detection:
> Add Verdin USB_1 over-current detection functionality via Verdin
> USB_1_OC# (SODIMM 157) being active-low and removing its previous
> gpio_hog3 mapping.
> 
> Disabling of USB port power controls:
> Disable port power control on Verdin USB_1/2 as we use regular
> fixed-regulators with Verdin USB_1/2_EN as enable GPIOs.
> 
> Addition of GPIO USB-B connector:
> Add GPIO USB-B connector (gpio-usb-b-connector) functionality using
> Verdin USB_1_ID.
> 
> Marking USB_2 as permanently attached:
> As both Dahlia and the Verdin Development Board have on-carrier
> permanently attached USB hubs mark Verdin USB_2 as such.
> 
> Note:
> Currently, I am still seeing a rare race condition of sorts when booting
> the system with Verdin USB_1 as a host port with a USB memory stick
> plugged in. This exact patch series applied on top of NXP's latest
> downstream 5.15.52_2.1.0 release (together with backporting a few more
> dwc3-specific patches) actually makes this same use case work very
> reliably. However, NXP also keeps further downstream-only patches which
> I plan to further investigate and hopefully upstream a proper fix for
> soon.

Thanks for the noting!

> 
> 
> Marcel Ziswiler (6):
>   arm64: dts: verdin-imx8mp: improve pinctrl for vbus-supplies
>   arm64: dts: verdin-imx8mp: remove usb_2 over-current detection
>     disabling
>   arm64: dts: verdin-imx8mp: add usb_1 over-current detection
>   arm64: dts: verdin-imx8mp: disable usb port power control
>   arm64: dts: verdin-imx8mp: add gpio usb-b connector
>   arm64: dts: verdin-imx8mp: dahlia: mark usb_2 permanently attached

Applied all, thanks!
