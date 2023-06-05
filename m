Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82C722725
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjFENPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjFENPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:15:22 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD383;
        Mon,  5 Jun 2023 06:15:20 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685970918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezVCXA59R6OoUuoJw4TkUJ8Lfny/r5hrMVf+Oit43HM=;
        b=pFe/JDymlb8lWaJnLc+kVSQv2RGWrE5mG4o7pyvP3LBJ5Ypix7HyK1wfxtPo1LU+Mq62s+
        xRdi5Pg+15iCku3Rx/BTziSPmQlJQOpOjlP0eh9SiWM3PnoIL/O1T61yprHFzySc6ilP2H
        jmfxuqRP8U/FdZApLzD8W9mgqOC9eWuaIfYDmrUHPqC7wcj0GXdIDZbRyIo0Dk09L5v1Kr
        UEiaAT+IPPC2FyGfv2iRQDK5zNGrRWJ4nKmvvaGJ/lYx0zecNYeQfhdE4LtUplA5aiziTp
        Kln0ykC1Zef0iG561jiN1eHtpeiAH7WFw5WP9gmx/9f87HciFBXjcAY0dSFcEw==
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 661EE60010;
        Mon,  5 Jun 2023 13:15:15 +0000 (UTC)
Date:   Mon, 5 Jun 2023 15:15:14 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v4 2/4] net: ethernet: altera-tse: Convert to
 mdio-regmap and use PCS Lynx
Message-ID: <20230605151514.20112956@pc-7.home>
In-Reply-To: <20230601141454.67858-3-maxime.chevallier@bootlin.com>
References: <20230601141454.67858-1-maxime.chevallier@bootlin.com>
        <20230601141454.67858-3-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu,  1 Jun 2023 16:14:52 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> The newly introduced regmap-based MDIO driver allows for an easy mapping
> of an mdiodevice onto the memory-mapped TSE PCS, which is actually a
> Lynx PCS.
> 
> Convert Altera TSE to use this PCS instead of the pcs-altera-tse, which
> is nothing more than a memory-mapped Lynx PCS.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
[ ... ]

> -	ret = request_and_map(pdev, "pcs", &pcs_res,
> -			      &priv->pcs_base);
> +	ret = request_and_map(pdev, "pcs", &pcs_res, &priv->pcs_base);

It turns out I'm missing the zeroing of pcs_regmap_cfg, which can trigger
errors at probe time. I know this series has been applied, and that I can
send a followup fix, but due to the missing regmap patch in the net-next
tree, this series will break altera_tse and dwmac_socfpga anyway,as
mentionned here (and in the cover):

https://lore.kernel.org/netdev/20230605142039.3f8d1530@pc-7.home/

Is reverting the way to go then ?

Best regards,

Maxime

