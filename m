Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFDC5FA628
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJJU0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJJU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:26:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9C4B4AC;
        Mon, 10 Oct 2022 13:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD1CBB810B5;
        Mon, 10 Oct 2022 20:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB24C433D6;
        Mon, 10 Oct 2022 20:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665433473;
        bh=GxuUdnuLZ/1XFk+MQHp5V1EUIHVQ56n48XZ+ZzK9QA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKnzYXl8vvBcKaoIHxcGFkkfdfBEPZ7pBmsyzZ4w333kTwuPm3heWDV1ZdKPBoLt9
         H+rY6tIs0OCK8wxW1VKuxdZQnjnwwOVt5sAQC5mMvXgZpqd0qFE7AC7d3sciRbYAR1
         P7XR3kes7hfuSoPU9r36ZN4IsrIkGsdPuIhbER44=
Date:   Mon, 10 Oct 2022 22:25:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jun.li@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Message-ID: <Y0R/rJn+C0VPm3A/@kroah.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010101816.298334-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 06:18:14PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert usbmisc-imx to yaml format.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
>  .../devicetree/bindings/usb/usbmisc-imx.yaml  | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> deleted file mode 100644
> index b796836d2ce7..000000000000
> --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Freescale i.MX non-core registers
> -
> -Required properties:
> -- #index-cells: Cells used to describe usb controller index. Should be <1>
> -- compatible: Should be one of below:
> -	"fsl,imx6q-usbmisc" for imx6q
> -	"fsl,vf610-usbmisc" for Vybrid vf610
> -	"fsl,imx6sx-usbmisc" for imx6sx
> -	"fsl,imx7d-usbmisc" for imx7d
> -	"fsl,imx7ulp-usbmisc" for imx7ulp
> -- reg: Should contain registers location and length
> -
> -Examples:
> -usbmisc@2184800 {
> -	#index-cells = <1>;
> -	compatible = "fsl,imx6q-usbmisc";
> -	reg = <0x02184800 0x200>;
> -};
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> new file mode 100644
> index 000000000000..c0741ce9b523
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/usbmisc-imx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX non-core registers
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cool, is nxp going to pay me to maintain this?  If not, then don't be
assigning such a thing to someone else.  Why can you not maintain it?

Assigning a file to someone without even asking them is a bit odd,
please never do that.

thanks,

greg k-h
