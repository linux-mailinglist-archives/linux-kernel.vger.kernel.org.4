Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0A06F0D84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjD0U46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0U44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:56:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7CBE56;
        Thu, 27 Apr 2023 13:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=bOKdPgP2f7Sd/FoHLrr6mS68uu9YNkAN+DF4VXlrxTw=; b=W3
        Blf7KgaPebmxDke7+QYn/5qhkKdTUwp+X5FEX6TAif1REd56XCrCyPEUyK+V3haxDJyaK0pmOO7Hd
        K7m3J+0KKs2zQrEd9qgpRyj3lU44Q+NseAwT24v431JZMfDtmJsTGsONjVb/HItR/yKtI131hNdGb
        iSFXsR14KOV7eVs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ps8fQ-00BNU8-VL; Thu, 27 Apr 2023 22:56:40 +0200
Date:   Thu, 27 Apr 2023 22:56:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] imx8mn-var-som: dts: fix PHY detection bug by adding
 deassert delay
Message-ID: <31610e60-5c1e-4d19-9beb-83b49ef26155@lunn.ch>
References: <20230427195538.2718661-1-hugo@hugovil.com>
 <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
 <20230427160608.f051241d750404939296f60d@hugovil.com>
 <CAOMZO5BNbRV1fLpwDZWgj9+gihHJBBGeZCvkF1tgm5GhwSn8LQ@mail.gmail.com>
 <20230427162251.518a956ce7a9dcd88352725a@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230427162251.518a956ce7a9dcd88352725a@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 04:22:51PM -0400, Hugo Villeneuve wrote:
> On Thu, 27 Apr 2023 17:07:59 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
> 
> > On Thu, Apr 27, 2023 at 5:06 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > 
> > > Hi Fabio,
> > > it uses a ADIN1300 PHY.
> > >
> > > The datasheet indicate that the "Management interface active (t4)" state is reached at most 5ms after the reset signal is deasserted.
> > 
> > Please add this information to the commit log and please add a Fixes: tag.
> > 
> > Thanks
> 
> Hi,
> I am trying to properly add a "Fixes: " tag, but the description for this tag indicates that it is to report that "the patch fixes an issue in a previous commit".
> 
> In this case, I cannot identify a commit that introduced that bug, apart from the initial commit of the DTS file which didn't have the reset property present?

Is the PHY on the SOM or the carrier?

If the PHY is on the carrier, then the delay is a carrier property,
and should be in the carrier .dts file. So use the commit for when the
carrier DTS file was added.

If the PHY is on the SOM, then use the commit for when the SOM DTSI
was added.

	Andrew
