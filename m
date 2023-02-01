Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160FA686B59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBAQPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBAQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:15:31 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F00DAB;
        Wed,  1 Feb 2023 08:15:29 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1B229E000F;
        Wed,  1 Feb 2023 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675268128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGkI6VBUfU7G1GLfIXROj8CxpsFVux3g4YSmKzDHPfk=;
        b=YoNnRYoF/V00IyZstAOjYuP5TavqKiNnnDOCsMegk/qiSq5A+oUD10/t7EcToMZxUvpB4a
        FP6WRD6eBVE4kiC7mCi6sQ5EfIXh0o0KsiFJnJOq9l+zaD/XRh2qEhmogp87tiAQjBlaRy
        h9LrsuJgkApp/Wi7oe4c3F3BRAcl5BUZKq7A5pLYeNXyi8+r+OnoMj2tNvf4EtByd6bUBc
        j31a5bCoDvsEtrgupkHJeLGJ5AdSlWlmGL7VyvN4TFSOJ4OFnEwRYCnobVQGqxmvxICQr/
        l7uk30zI9lfHfdd+2GA8HsBO+I7QaKIhL4CAxmsnAK10QTdGGpQSxRBMOE0wgg==
Date:   Wed, 1 Feb 2023 17:15:26 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/7] Enable backup switch mode on RTCs via devicetree
Message-ID: <Y9qQHpySbrFcBB0P@mail.local>
References: <20230201143431.863784-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201143431.863784-1-frieder@fris.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

You can't do that, this breaks an important use case and it is the
reason why I didn't use device tree in the beginning. What is wrong with
setting BSM from userspace? You will anyway have to set the time and
date from userspace for it to be saved.

On 01/02/2023 15:34:22+0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Some RTC devices like the RV3028 have BSM disabled as factory default.
> This makes the RTC quite useless if it is expected to preserve the
> time on hardware that has a battery-buffered supply for the RTC.
> 
> Let boards that have a buffered supply for the RTC force the BSM to the
> desired value via devicetree by setting the 'backup-switch-mode' property.
> 
> That way the RTC on the boards work as one would expect them to do without
> any per-board intervention through userspace tools to enable BSM.
> 
> Frieder Schrempf (7):
>   dt-bindings: rtc: Move RV3028 to separate binding file
>   dt-bindings: rtc: Add backup-switch-mode property
>   dt-bindings: rtc: microcrystal,rv3032: Add backup-switch-mode property
>   rtc: Move BSM defines to separate header for DT usage
>   rtc: class: Support setting backup switch mode from devicetree
>   arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable from
>     RTC node
>   arm64: dts: imx8mm-kontron: Enable backup switch mode for RTC on OSM-S
>     module
> 
>  .../bindings/rtc/microcrystal,rv3028.yaml     | 60 +++++++++++++++++++
>  .../devicetree/bindings/rtc/rtc.yaml          |  7 +++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
>  .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |  3 +-
>  drivers/rtc/class.c                           | 14 +++++
>  include/dt-bindings/rtc/rtc.h                 | 11 ++++
>  include/uapi/linux/rtc.h                      |  6 +-
>  7 files changed, 95 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
>  create mode 100644 include/dt-bindings/rtc/rtc.h
> 
> -- 
> 2.39.1

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
