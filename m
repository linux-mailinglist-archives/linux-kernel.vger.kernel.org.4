Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F348E65A89D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 03:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjAACTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 21:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAACTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 21:19:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7E64EC;
        Sat, 31 Dec 2022 18:19:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B57860A69;
        Sun,  1 Jan 2023 02:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83B8C433D2;
        Sun,  1 Jan 2023 02:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672539585;
        bh=h8J/bVhWAr9jEzm8BWXkFEB5bhxsazV+6RJ2Vu+Z4iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJig/QhwBlCInPYM/3+tKARDg6Olffq+JYuct3MlqhcXQpv9NEZRQsr0Fmr3u1ata
         J/Px9QGkUv7FzvZ4bOW6wvtSzhtTiN4V9bRJx0FseGdc6hr6be++T/YYG9Yax0CMdL
         Lpgh9LMxGqrNOwn26tOqb642xuVNrNPcB3yPxtHBJ2CVX2B4cT7vV+1ZngogMBYrAG
         KUyLMcNkp8hYsT9Jd2cUr7XgeNx8DtI6DdKjlBV7lWCw5JWtW+ese/m9LcDFggWrif
         lxCEGtPvUVSakSh549IrxhoHTPnQ7/Ml5VdN71ECGf72zp+Wdx/T8nYi7y4f0wiClY
         o7oUET3KT4W8A==
Date:   Sun, 1 Jan 2023 10:19:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Nikolaus Voss <nikolaus.voss@haag-streit.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, nv@vosn.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] imx6qdl.dtsi: use MAC-address from nvmem
Message-ID: <20230101021936.GG6112@T480>
References: <20221128084749.5F10D1D73@mail.steuer-voss.de>
 <20221231064923.GD6112@T480>
 <Y7BsmULn+VQNP3g+@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7BsmULn+VQNP3g+@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 06:08:41PM +0100, Andrew Lunn wrote:
> > > @@ -1053,6 +1053,8 @@ fec: ethernet@2188000 {
> > >  					 <&clks IMX6QDL_CLK_ENET_REF>;
> > >  				clock-names = "ipg", "ahb", "ptp", "enet_out";
> > >  				fsl,stop-mode = <&gpr 0x34 27>;
> > > +				nvmem-cells = <&fec_mac_addr>;
> > > +				nvmem-cell-names = "mac-address";
> > 
> > May I ask where is the support of FEC driver for this?
> 
> The fec uses of_get_mac_address() which calls
> of_get_mac_address_nvmem() as its last place to look for the MAC
> address.

Ah, of_get_mac_address() gets extended to call of_get_mac_address_nvmem()
nowadays.  Thanks, Andrew!

Shawn
