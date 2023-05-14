Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30E701ECD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjENRoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjENRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:44:13 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6821BF0;
        Sun, 14 May 2023 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1684086250; bh=/0Ryfvnd/iJeMY30BK3ahJlqI43ju5QrawuWSYL332U=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=sooP8EK2X962F2DOCrNVdZ0z1yICIfsJtQL6I6Jin6ejA5OaA1QEl32AvWJ5gZbcm
         P3C/VBgFXL6/4KGOmFnI+2DFpYS1HZVs6I2acOCbJyD9CDDf7veEt/eh7mYTyNmJAI
         NNL+NiPokwpeX86ZLcPajT4p0vjtwlMjvoFbN1Lk=
Date:   Sun, 14 May 2023 19:44:09 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] thermal/drivers/sun8i: Fix some error handling paths in
 sun8i_ths_probe()
Message-ID: <tk7dyyldwewc7k4eibocdcuz5pkfuppunmejkufipo3avli3ku@ea5r6mptncqa>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Vasily Khoruzhick <anarsoul@gmail.com>, 
        Yangtao Li <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
        Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>, 
        Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
        Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
        kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
        linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <26f9e3bb3fcd0c12ea24a44c75b7960da993b68b.1684077651.git.christophe.jaillet@wanadoo.fr>
 <yd37pz2nbs2i5m4a5avonj4w7ili4kx7d7w7fgbiss7z26jnfy@rwytm26i6v7h>
 <9ae3f111-e13b-cdd7-317d-316585390952@wanadoo.fr>
 <qatlg75vf4tbugut2xehwbv4722uklprr36lvsgtcdmgoiqwgi@mdsaurbgy6jz>
 <61d3dac0-550c-70bd-daf8-352e903de36d@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61d3dac0-550c-70bd-daf8-352e903de36d@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 07:32:54PM +0200, Christophe JAILLET wrote:
> 
> Le 14/05/2023 à 19:10, Ondřej Jirman a écrit :
> > On Sun, May 14, 2023 at 07:00:34PM +0200, Christophe JAILLET wrote:
> > > 
> > > Le 14/05/2023 à 17:35, Ondřej Jirman a écrit :
> > > > Hello Christophe,
> > > > 
> > > > [...]
> > > > 
> > > > This changes the recommeded order of reset release/clock enable steps, eg. A64
> > > > manual says:
> > > > 
> > > > 	3.3.6.4. Gating and reset
> > > > 
> > > > 	Make sure that the reset signal has been released before the release of
> > > > 	module clock gating;
> > > 
> > > Ok, so moving reset_control_deassert() (and my proposed
> 
>                  ^^^^^^^^^^^^^^^^^^^^^^
> 
> > > devm_add_action_or_reset()) just after devm_reset_control_get() should keep
> > > the expected order, right?
> > 
> > That would be after reset_control_deassert(). devm_reset_control_get() is just
> > resource management, like devm_clk_get().
> 
> Not sure to get your point. I think you misunderstood what I tried to say.

Yes, I just misread what you wrote. What you suggested is fine.

kind regards,
	o.

> 
> I propose to move reset_control_deassert() in a v2. And have
> devm_add_action_or_reset() just after it.
> 
> Something like:
> 
> 	if (tmdev->chip->has_bus_clk_reset) {
> 		tmdev->reset = devm_reset_control_get(dev, NULL);
> 		if (IS_ERR(tmdev->reset))
> 			return PTR_ERR(tmdev->reset);
> 
> 		ret = reset_control_deassert(tmdev->reset);
> 		if (ret)
> 			return ret;
> 
> 		ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
> 					       tmdev->reset);
> 		if (ret)
> 			return ret;
> 
> 		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
> 		if (IS_ERR(tmdev->bus_clk))
> 			return PTR_ERR(tmdev->bus_clk);
> 	}
> 
> 	if (tmdev->chip->has_mod_clk) {
> 		tmdev->mod_clk = devm_clk_get_enabled(&pdev->dev, "mod");
> 		if (IS_ERR(tmdev->mod_clk))
> 			return PTR_ERR(tmdev->mod_clk);
> 	}
> 
> 	ret = clk_set_rate(tmdev->mod_clk, 24000000);
> 	if (ret)
> 		return ret;
> 
> 
> This would keep the order of operation, still fix the leak in the probe and
> still save some LoC.
> 
> Would it make it?
> 
> CJ
> 
> > 
> > regards,
> > 	o.
> > 
> 
