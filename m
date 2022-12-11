Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770B64960C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLKUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:00:02 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C2BCA9;
        Sun, 11 Dec 2022 12:00:00 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 402DE240007;
        Sun, 11 Dec 2022 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670788798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nviQnYPoCNryX26Yk5aQ1g/hoSw96V3xdfHJt6EIe1o=;
        b=NPljn+WjlL6wQk55wVt+JE7/b9utUL/easL6fbgNwYRUsfgbS76rL+clrhVsAiILUGzY4O
        +pa3mBoPHV2vruMxOpbrpaOfvN/ZEcHwnJNMlgAVaAw6VAJn9CzVXFq+PlsafKkBLQbGxw
        HGo2ch4S5koKgaLM3kWOPLxhCzOpQ83NtprCC4Y0K+u03mLAa2jBTgXXo69yv1sP4BhDPw
        9dnfgP69AfhZZyELiu7NZrlRCAnOK4XbbIwiDB6le2unmi78RVMu3Zy26l5aCD4QUgbSgW
        RHm/4rLXQ09DK0dtfM1n2zlIfp3zlaYTIK3pvHrEiVOA0SsVhz9qmAtohWpywA==
Date:   Sun, 11 Dec 2022 20:59:56 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCHv4 00/13] Introduce RK806 Support
Message-ID: <167078872190.11717.11951030261472241551.b4-ty@bootlin.com>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020204251.108565-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 22:42:38 +0200, Sebastian Reichel wrote:
> The Rockchip RK3588 Evaluation Boards use SPI connected RK806
> PMICs. Downstream this is handled by a new driver, but apart
> from being SPI connected this chip is quite similar to the
> ther Rockchip PMICs (also RK806 is promoted to also support
> I2C). Thus this series instead updates the RK808 driver(s).
> 
> Changelog since PATCHv3:
>  * https://lore.kernel.org/all/20220909175522.179175-1-sebastian.reichel@collabora.com/
>  * Dropped removing REGMAP_I2C dependency from RK817 ASoC driver (applied)
>  * Rename MFD_RK808 to MFD_RK8XX to be consistent. It makes sense to do this now,
>    since the patchset touches all the child drivers anyways.
>  * rebase to v6.1-rc1
>  * collected a couple of Acks
>  * update rk806 DT binding according to DT maintainer feedback
>  * add missing pinmux config to the rk806 DT binding
>  * update rk806_spi_bus_write and rk806_spi_bus_read
>  * replaced some constants with sizeof or defines
>  * used capitalized comments
>  * rename regmap_find_closest_bigger to regulator_find_closest_bigger, not sure
>    why I prefixed it with regmap_ in the first place
>  * use rk8xx_is_enabled_wmsk_regmap instead of regulator_is_enabled_regmap for
>    the switching regulators to correctly report the state
>  * reordered the first few patches grouping the MFD patches together
> 
> [...]

Applied, thanks!

[03/13] rtc: rk808: reduce 'struct rk808' usage
        commit: 2e830ccc21eb67a4c2490279d907e5e9199e5156

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
