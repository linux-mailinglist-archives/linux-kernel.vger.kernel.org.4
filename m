Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC62C63B1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiK1TGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiK1TGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:06:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A028701;
        Mon, 28 Nov 2022 11:06:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3292061316;
        Mon, 28 Nov 2022 19:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C98C433D7;
        Mon, 28 Nov 2022 19:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669662362;
        bh=YuU2ft1vTL8owzTKzsHQya+OxilPcCD6BiamY379m0w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kaz2CAvUHoW4mkffkq2TfBYWjsh7NL18BeWfNPrBxjcQNx2pcC4EtUjAQGZrlKxNc
         duNYI+2P112Au0Bq7j3v8hps12+U58Tmy/RVzVRBaOMmX+XCWgdnzLNNtJ9vYRXRRS
         YzSgoExBRwAEdsUx8Y8Xb0coQeoioIQsSCELdKdtFS+s6i5OYpZyrl2A7Yyljqqqso
         lFBP8tU+pwaYi28YUMkEmUIroZb4pL4XTCkQb7JDCCEBf0sD9AQs235nqhn9eTW5B9
         s27heIop9/Su0Tsfh8ZrrGfQEDwTxM3cHOMVS6GFRO4cV31CQpQsCkotOGVCywu2ek
         qAz1+rPet6ZmA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org
In-Reply-To: <20221020204251.108565-1-sebastian.reichel@collabora.com>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCHv4 00/13] Introduce RK806 Support
Message-Id: <166966235945.739089.7387113152934884046.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 19:05:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[02/13] regulator: rk808: reduce 'struct rk808' usage
        commit: 647e57351f8ebc37d8e12cbc0f4bf7471754a0cc
[11/13] regulator: rk808: Use dev_err_probe
        commit: f39f8709c217d82aabbf51d8669731137ce09aea

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
