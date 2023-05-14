Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02524701EBF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjENRdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjENRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:33:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84D71BD7
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:33:02 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yFaYpbyRDlqGTyFaYpLaxw; Sun, 14 May 2023 19:33:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684085580;
        bh=mtkk84FKtzNu1ujBz4Fu/8kTW/TEwhhK9XrxgsIUZ9k=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=MCHAE2pFRIAIJXayl8wC9MR8rSEQF8rdrCMiSQ5axfxg5a5zpywcOIeL9x1K8KsQ1
         vsL3e/+mSBQATjSI+QRIrnOd+NR60xLfEONP/XNwwHMafqxPrtS7lXtGh3myxdJH+j
         pwk+srVORl9FbXxUQ5JFuONke5LGK926HSweYbOsXpRcP2OClinnTEEZhQGdXeeFhp
         +5WyBZjCvz5Udg5M1/sHwNYnLnkwQ34cINDdKrJel+i3/PSobkhSe4ZKGbo+xh8eGp
         0v0rFGElNt7P+CEZTjOhZDWHea8GOmSIOXnT8TTRis947JNIxlETfAxKoHIh0Xf1p5
         Tw0MZM3n2x5aw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 May 2023 19:33:00 +0200
X-ME-IP: 86.243.2.178
Message-ID: <61d3dac0-550c-70bd-daf8-352e903de36d@wanadoo.fr>
Date:   Sun, 14 May 2023 19:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] thermal/drivers/sun8i: Fix some error handling paths in
 sun8i_ths_probe()
Content-Language: fr, en-GB
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
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
References: <26f9e3bb3fcd0c12ea24a44c75b7960da993b68b.1684077651.git.christophe.jaillet@wanadoo.fr>
 <yd37pz2nbs2i5m4a5avonj4w7ili4kx7d7w7fgbiss7z26jnfy@rwytm26i6v7h>
 <9ae3f111-e13b-cdd7-317d-316585390952@wanadoo.fr>
 <qatlg75vf4tbugut2xehwbv4722uklprr36lvsgtcdmgoiqwgi@mdsaurbgy6jz>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <qatlg75vf4tbugut2xehwbv4722uklprr36lvsgtcdmgoiqwgi@mdsaurbgy6jz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/05/2023 à 19:10, Ondřej Jirman a écrit :
> On Sun, May 14, 2023 at 07:00:34PM +0200, Christophe JAILLET wrote:
>>
>> Le 14/05/2023 à 17:35, Ondřej Jirman a écrit :
>>> Hello Christophe,
>>>
>>> [...]
>>>
>>> This changes the recommeded order of reset release/clock enable steps, eg. A64
>>> manual says:
>>>
>>> 	3.3.6.4. Gating and reset
>>>
>>> 	Make sure that the reset signal has been released before the release of
>>> 	module clock gating;
>>
>> Ok, so moving reset_control_deassert() (and my proposed

                  ^^^^^^^^^^^^^^^^^^^^^^

>> devm_add_action_or_reset()) just after devm_reset_control_get() should keep
>> the expected order, right?
> 
> That would be after reset_control_deassert(). devm_reset_control_get() is just
> resource management, like devm_clk_get().

Not sure to get your point. I think you misunderstood what I tried to say.


I propose to move reset_control_deassert() in a v2. And have 
devm_add_action_or_reset() just after it.

Something like:

	if (tmdev->chip->has_bus_clk_reset) {
		tmdev->reset = devm_reset_control_get(dev, NULL);
		if (IS_ERR(tmdev->reset))
			return PTR_ERR(tmdev->reset);

		ret = reset_control_deassert(tmdev->reset);
		if (ret)
			return ret;

		ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
					       tmdev->reset);
		if (ret)
			return ret;

		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
		if (IS_ERR(tmdev->bus_clk))
			return PTR_ERR(tmdev->bus_clk);
	}

	if (tmdev->chip->has_mod_clk) {
		tmdev->mod_clk = devm_clk_get_enabled(&pdev->dev, "mod");
		if (IS_ERR(tmdev->mod_clk))
			return PTR_ERR(tmdev->mod_clk);
	}

	ret = clk_set_rate(tmdev->mod_clk, 24000000);
	if (ret)
		return ret;


This would keep the order of operation, still fix the leak in the probe 
and still save some LoC.

Would it make it?

CJ

> 
> regards,
> 	o.
> 

