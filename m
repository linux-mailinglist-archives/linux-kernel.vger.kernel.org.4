Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95F8653185
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLUNRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiLUNRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:17:02 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174321898;
        Wed, 21 Dec 2022 05:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=nU5P7LyVQ3beqazjkGa/5BdKFxoYM9aSKA3nFZTk8DU=; b=51ZBAIiPhn8+my1KlwUrSE6x7b
        fOyvgm8qYYmddkQ0QD65fhhNZf97ZtMcsalpVwBVaJuH7rtnIDpu8qcDrMiqUNL2UP+8CLhjhKNpe
        cJOby3GN/Zk0CDS0zl4ETZAp9aSwSRmGywgKFUpQoGFOoi8t2ixa1HeHItZpNHVJoeH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1p7yxm-000BDz-5x; Wed, 21 Dec 2022 14:16:50 +0100
Date:   Wed, 21 Dec 2022 14:16:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        macpaul.lin@mediatek.com
Subject: Re: [RESEND PATCH v4] arm64: dts: mt8195: Add Ethernet controller
Message-ID: <Y6MHQnUcfBjibA8C@lunn.ch>
References: <20221221022523.8458-1-biao.huang@mediatek.com>
 <20221221022523.8458-2-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221022523.8458-2-biao.huang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +&eth {
> +	phy-mode ="rgmii-rxid";

That is pretty unusual. You don't see rxid, or txid very often, it is
normally rgmii, or rgmii-id.

> +	phy-handle = <&ethernet_phy0>;
> +	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
> +	snps,reset-delays-us = <0 10000 10000>;
> +	mediatek,tx-delay-ps = <2030>;

How important is the 30 here?

You appear to have the PHY doing the RX delay, and the MAC doing the
TX delay. Normally we have the PHY do both. Can you actually do

phy-mode = "rgmii-id", and mediatek,tx-delay-ps = <30> ? That would
then have the PHY doing the basic 2ns delay, and the MAC doing the
fine tuning needed for TX?

     Andrew
