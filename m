Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7696FE71B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEJWPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEJWPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:15:34 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8672E5C;
        Wed, 10 May 2023 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gwaXBBg4XskKxM6U1vhH6WQb0H4bfCyfoRanAQAkWWU=; b=btLw9dYIp3jL127E1nzU23MyaU
        09V4k4g9F2Jqr7BbrH308Ol4HGgyDfjQgeMigsr/GIxutbydkVCJiCR3E3s32gIv4ATDkEAkcxQyY
        M1WUyM8nB9qbaTejuf3VDqWT3/nYYJhV8N/vifqEJymCOXRZMCgmR8GrcqJYcYjh6bJU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pws5h-00CUOm-Ek; Thu, 11 May 2023 00:15:21 +0200
Date:   Thu, 11 May 2023 00:15:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Yan Wang <rk.code@outlook.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v3] net: mdiobus: Add a function to deassert reset
Message-ID: <5b6eb4c3-1ef8-4ed5-bcf3-0bb11897ce24@lunn.ch>
References: <KL1PR01MB5448A33A549CDAD7D68945B9E6779@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1PR01MB5448A33A549CDAD7D68945B9E6779@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void fwnode_mdiobus_pre_enable_phy(struct fwnode_handle *fwnode)
> +{
> +	struct gpio_desc *reset;
> +
> +	reset = fwnode_gpiod_get_index(fwnode, "reset", 0, GPIOD_OUT_HIGH, NULL);
> +	if (IS_ERR(reset) && PTR_ERR(reset) != -EPROBE_DEFER)
> +		return;
> +
> +	usleep_range(100, 200);
> +	gpiod_set_value_cansleep(reset, 0);
> +	/*Release the reset pin,it needs to be registered with the PHY.*/
> +	gpiod_put(reset);

You are still putting it into reset, and then taking it out of
reset. This is what i said should not be done. Please only take it out
of reset if it is in reset.

Also, you ignored my comments about delay after reset.

Documentation/devicetree/bindings/net/ethernet-phy.yaml says:

  reset-gpios:
    maxItems: 1
    description:
      The GPIO phandle and specifier for the PHY reset signal.

  reset-assert-us:
    description:
      Delay after the reset was asserted in microseconds. If this
      property is missing the delay will be skipped.

  reset-deassert-us:
    description:
      Delay after the reset was deasserted in microseconds. If
      this property is missing the delay will be skipped.

You are deasserting the reset, so you should look for this property,
and if it is there, delay for that amount. Some PHYs take a while
before they will respond on the bus.

       Andrew
