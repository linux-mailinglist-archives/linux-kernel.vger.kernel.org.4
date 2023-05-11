Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71CE6FF673
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjEKPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbjEKPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:49:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBEC4C3F;
        Thu, 11 May 2023 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=E7i+xfg7Zmreb4Vww4EYKdJmkpv928hvjj/hafEYQT0=; b=1M5qqDtAkcn+e6iqllMITj2Nmy
        U756c5EXwyGGyFDZlxHj9uDncFUTsXS7nQbZgXV8HxqdWcquRn7z9S0aRiIN/wNqbqfmobsA6UzcY
        ZwDulJZWQ/d6D9Y+7Y5p59yV531pEJb5aNNP1oQ8mvRs0uhFCTKosjuCtP55wP/XXr2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1px8XW-00CZd1-2A; Thu, 11 May 2023 17:49:10 +0200
Date:   Thu, 11 May 2023 17:49:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
        palmer@dabbelt.com, git@amd.com, michal.simek@amd.com,
        harini.katakam@amd.com, radhey.shyam.pandey@amd.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/2] net: macb: Add support for partial store
 and forward
Message-ID: <3a3c6241-2134-42d0-8dd3-0c96d8e7300b@lunn.ch>
References: <20230511071214.18611-1-pranavi.somisetty@amd.com>
 <20230511071214.18611-3-pranavi.somisetty@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511071214.18611-3-pranavi.somisetty@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (GEM_BFEXT(PBUF_CUTTHRU, gem_readl(bp, DCFG6))) {
> +		if (bp->caps & MACB_CAPS_PARTIAL_STORE_FORWARD) {
> +			retval = of_property_read_u16(bp->pdev->dev.of_node,
> +						      "rx-watermark",
> +						      &bp->rx_watermark);
> +
> +			/* Disable partial store and forward in case of error or
> +			 * invalid watermark value
> +			 */
> +			wtrmrk_rst_val = (1 << (GEM_BFEXT(RX_PBUF_ADDR, gem_readl(bp, DCFG2)))) - 1;
> +			if (retval || bp->rx_watermark > wtrmrk_rst_val || !bp->rx_watermark) {
> +				if (bp->rx_watermark > wtrmrk_rst_val) {
> +					dev_info(&bp->pdev->dev, "Invalid watermark value\n");
> +					bp->rx_watermark = 0;

Please return -EINVAL. We want the DT author to fix their error.

> +				}
> +				dev_info(&bp->pdev->dev, "Not enabling partial store and forward\n");

The DT property is optional? So when it is missing, retval will be
-EINVAL. Please don't spam the logs in this case.

	 Andrew
