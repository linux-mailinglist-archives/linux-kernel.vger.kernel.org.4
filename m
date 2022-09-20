Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB8A5BE746
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiITNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiITNja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:39:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED138B1A;
        Tue, 20 Sep 2022 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3pIjUlJA919B9lQ4aUcTZDjl/ToQpR3Iu1q2qExlc+0=; b=RZSS9O3GRyd5jXE3KqsVzp/6ja
        w4m8lGQbeA2elwVVGEM4FwtLGj41wsYTWJU01DB3/dGo7oz+mIiJ307vyc0rZZf6FUXW6nV/IK3ih
        pWNCaYVxkQanbkWV34A7U42jndu60DeFADkyspOOmRFIy0w+IJ1b7pPZ9aKgoBWH4Ouk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oadT4-00HH5w-0s; Tue, 20 Sep 2022 15:39:18 +0200
Date:   Tue, 20 Sep 2022 15:39:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] ASoC: kirkwood: enable Kirkwood driver for Armada
 38x platforms
Message-ID: <YynChnIJe3SZUUW5@lunn.ch>
References: <20220920132648.2008-1-pali@kernel.org>
 <20220920132648.2008-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920132648.2008-2-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (of_device_is_compatible(np, "marvell,armada-380-audio")) {
> +		err = armada_38x_i2s_init_quirk(pdev, priv, soc_dai);
> +		/* Set initial pll frequency */
> +		if (priv->pll_config)
> +			armada_38x_set_pll(priv->pll_config, 44100);
> +		if (err < 0)
> +			return err;

A nitpick: It would be better to do the test for err before calling
armada_38x_set_pll(), and then there is no need for the NULL check.

      Andrew
