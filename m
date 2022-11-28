Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097BE63B1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiK1TGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiK1TGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:06:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E9286E8;
        Mon, 28 Nov 2022 11:06:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC5C61316;
        Mon, 28 Nov 2022 19:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2EFC433D6;
        Mon, 28 Nov 2022 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669662359;
        bh=bYrX7p6VXu59IzHLRpXR6E2l0n/Yi7FmtGPA1cHqfAs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O0MFcLEjqofyJR6Tl+sWupNctU5YJ3s9O8z+oa7x18f5HtRTS3w9oNQKYvF6coPlu
         YAD77vsF0A+hvQELCtZFpBQRK1nOSQyhu89kJYlvGEZ2Sf9BFjlUvyHUzZE9sxElNA
         VPj6uH8GEviPeq07k+z08/94rp5BQU9j9TKXwS+cXb5vxOYQqR4VCVrDIouxRCyQtw
         r/VxCnc3mZmDB3PCSQFD6phwAGP4bmpJXOSDtpD7vHVJzbjUtfpuM45yQNRseG3M88
         gVdCpILsU1Aq9QVL5LHsykiQXIn26TMZS6RX/kEDt08TFo4mTwRnKU6k9xp2TBneF2
         YYvYpgsl3fwIw==
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
In-Reply-To: <20220909175522.179175-1-sebastian.reichel@collabora.com>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCHv3 00/14] Introduce RK806 Support
Message-Id: <166966235607.739089.9217119235765482431.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 19:05:56 +0000
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

On Fri, 9 Sep 2022 19:55:08 +0200, Sebastian Reichel wrote:
> The Rockchip RK3588 Evaluation Boards use SPI connected RK806
> PMICs. Downstream this is handled by a new driver, but apart
> from being SPI connected this chip is quite similar to the
> ther Rockchip PMICs (also RK806 is promoted to also support
> I2C). Thus this series instead updates RK808.
> 
> Changelog since PATCHv2:
>  * https://lore.kernel.org/all/20220908003107.220143-1-sebastian.reichel@collabora.com/
>  * Change DT binding to not allow nldo-reg6
>  * Fix DT binding to check for [np]ldo-reg instead of [np]ldo_reg
>  * remove rk806_get_voltage_sel_regmap in favour of regulator_get_voltage_sel_regmap
>  * drop rk806_set_voltage in favour of regulator_set_voltage_sel_regmap
>  * use regulator_set_ramp_delay_regmap
>  * drop possibly incorrect printing of chip id register address in case of errors
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[11/14] regulator: rk808: Use dev_err_probe
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
