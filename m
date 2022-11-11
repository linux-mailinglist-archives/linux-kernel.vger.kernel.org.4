Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069B626218
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbiKKTfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKTfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:35:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA11707F;
        Fri, 11 Nov 2022 11:35:45 -0800 (PST)
Received: from falcon9.localnet (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A13F6602A5B;
        Fri, 11 Nov 2022 19:35:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668195343;
        bh=LQzpqS6J1Op21IKDCU38ivvE8csL7oU4+93+9hQJ7JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBhMusJD3eXPpaiQORUMMm6FWJ4sGr65O/8ctweD+b8qcNdigavJM06VuNtKqJIhZ
         jb7cLd0kJgsuewxrzwKOV1UBwfAhVS48V0j0dH17voi3cGUZsgiX3yEMhtUQMUGKCz
         ORHLn2/AQrpW5RbjYTk9NEK13BDKbLyW3I8OUyImne45b0WA8vcux1oXp1K+3tIFA/
         5L2UmWY3YRz6ylBakGxCzfq2svE6bO/hx7uxBEVBKpIOC1tKsQa4T+ADjIOJO/4WqI
         KF4vqwnEhwGmJQYZdWcS++LYojVjSmXTw7wtrUzquw9uNsr9bleUI5TEgSNzLe2M0+
         UxUp8Prd+y4fw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabre: Add mmc aliases
Date:   Fri, 11 Nov 2022 14:35:36 -0500
Message-ID: <2868543.tdWV9SEqCh@falcon9>
In-Reply-To: <20221111025232.GI125525@dragon>
References: <20221028141811.101122-1-detlev.casanova@collabora.com> <20221111025232.GI125525@dragon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 10, 2022 9:52:32 P.M. EST Shawn Guo wrote:
> On Fri, Oct 28, 2022 at 10:18:11AM -0400, Detlev Casanova wrote:
> > If not specified, the mmc0 and mmc1 devices will be the devices
> > mmc@2190000 and mmc@2194000, which are in disabled state on the iMX.6
> > Sabrelite devices.
> > 
> > The actual SD card reader devices are the ones at mmc@2198000 and
> > mmc@219c000.
> > 
> > Set aliases to use the correct mmc devices order.
> 
> Is this something never worked or a regression?  For the latter, we may
> need a Fixes tag?

These were apparently never set in the kernel device-tree and added manually 
in u-boot when dts are synced.

Because most distributions use UUIDs in fstab, it is not a big problem in 
Linux, just that the SD card is called /dev/mmcblk2. I would say that this has 
always been an issue in Linux.

> Shawn
> 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi index
> > 22f8e2783cdf..12573e1f917c 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > @@ -14,6 +14,11 @@ chosen {
> > 
> >  		stdout-path = &uart2;
> >  	
> >  	};
> > 
> > +	aliases {
> > +		mmc0 = &usdhc3;
> > +		mmc1 = &usdhc4;
> > +	};
> > +
> > 
> >  	memory@10000000 {
> >  	
> >  		device_type = "memory";
> >  		reg = <0x10000000 0x40000000>;




