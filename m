Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532367506D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjGLLtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjGLLsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595F26A5;
        Wed, 12 Jul 2023 04:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D49617A5;
        Wed, 12 Jul 2023 11:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6827AC433C9;
        Wed, 12 Jul 2023 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162475;
        bh=BL+8Fo9QG0zNtj0y7Lgb/m7HMTTimtNx9krlJ8PROKk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MBDgsatfZpWqdAMwV6qveeIfLQ6N7jrowK9LjuavtymGZJ2RZ2Oc1MpqiENhz3quE
         3C52w4yN+XHh2R9JtS9d5C82wdCYmJLOyIegf8gaLO9fnbUYfmxOmBAQgyocJctiAI
         6E59ipQJyxOm+qSbYi3HkSZBX2tCKWY1iP+GjHTkOSnvKhvbhkax3ZarfbH5wu0wKK
         qx68/+nBANjiNw+aQoV6C1vLW4EDygmSD4fpo+BTkFwtXsm5w2b39Kd49evlvRZIW7
         KcdjwPLLtdt+TqxuNclA8arYxR3eJ8wd/C5/2IO8CCIn4CiFbVXi916UJQXvZWbBYq
         HcHdiJ1RRWg+A==
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v2 00/15] spi: Header and core clean up and
 refactoring
Message-Id: <168916246513.47003.10097115249886306259.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 18:49:17 +0300, Andy Shevchenko wrote:
> Various cleanups and refactorings of the SPI header and core parts
> united in a single series. It also touches drivers under SPI subsystem
> folder on the pure renaming purposes of some constants.
> 
> No functional change intended.
> 
> Changelog v2:
> - added new patches 3,4,5,10,13,14
> - massaged comment and kernel doc in patch 9
> - split used to be patch 4 to patches 11,12
> - covered a few things in SPI core in patch 15
> - amended commit message for above (Mark)
> - reshuffled patches in the series for better logical grouping
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/15] spi: Remove unneeded OF node NULL checks
        commit: fbab5b2c09060e8034fee6ec2df69a62594fb7db
[02/15] spi: Drop duplicate IDR allocation code in spi_register_controller()
        commit: 440c47331bdb889e24128c75387c695ca81d9b9b
[03/15] spi: Replace if-else-if by bitops and multiplications
        commit: 2b308e7176e366a52a07a49868e3b1a295e56785
[06/15] spi: Use sysfs_emit() to instead of s*printf()
        commit: f2daa4667fda1aa951b91da0ae9675a5da9d7716
[07/15] spi: Sort headers alphabetically
        commit: edf6a864c996f9a9f5299a3b3e574a37e64000c5
[08/15] spi: Clean up headers
        (no commit info)
[11/15] spi: Get rid of old SPI_MASTER_NO_TX & SPI_MASTER_NO_RX
        commit: c397f09e5498994790503a64486213ef85e58db9
[12/15] spi: Get rid of old SPI_MASTER_MUST_TX & SPI_MASTER_MUST_RX
        commit: 90366cd60133a9f5b6a2f31360367c658585e125
[13/15] spi: Rename SPI_MASTER_GPIO_SS to SPI_CONTROLLER_GPIO_SS
        commit: 82238d2cbd99ebd09dda48fb7c1c8802097da6a2
[14/15] spi: Convert to SPI_CONTROLLER_HALF_DUPLEX
        commit: 7a2b552c8e0e5bb280558f6c120140f5f06323bc
[15/15] spi: Fix spelling typos and acronyms capitalization
        commit: 702ca0269ed56e2d8dae7874a4d8af268e2a382e

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

