Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BB6C20A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCTS71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCTS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:58:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF5122025;
        Mon, 20 Mar 2023 11:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C258EB80E64;
        Mon, 20 Mar 2023 18:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61177C4339B;
        Mon, 20 Mar 2023 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679338253;
        bh=7Gq+dkJBsJWnVaQuT6Pjmfs5E8jwp84nAv9NsQA+/7A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PVyPv4UTrKnLnkq7a2d6iXuEXMsEcoF4DbwYsDGMzopoXG7TdG6tdN/r6rCvqjzSa
         xilK5uFb/CUVPWLzQ+6BHy3Xrh5g0ehK4GxxicDNQAg9Iuw0VzNsXls+3NiKeWJ1BX
         LNlcPokzojSzvu2Xz8YTMeIsqMLPngvBnCmCrQSuYW42OVnY3Qk6s9CS03bKAQ1esE
         VEEWF+d1Qz6r0nbE3yOEM9oxI/Q8T5ocGB75Xh1MDXS90QkW6bNWtoYsaPT08DQC4n
         +kuT8mT2lZHV8JqHD/NCbFUm/Tne85cxS+hLVr81P2ZXM98nVckG6X21D1qDAtHXS2
         /5NpxPRVeRdaA==
From:   Mark Brown <broonie@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230306065733.2170662-1-u.kleine-koenig@pengutronix.de>
References: <20230306065733.2170662-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] spi: imx: Fix cleanup in remove and convert to
 .remove_new()
Message-Id: <167933825108.203761.2340402039311088951.b4-ty@kernel.org>
Date:   Mon, 20 Mar 2023 18:50:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2023 07:57:31 +0100, Uwe Kleine-König wrote:
> this small series converts the spi-imx driver to .remove_new(). The
> motivation for this tree-wide effort are drivers that don't properly
> cleanup and return an error code. This is broken as this results in
> resource leaks. The spi-imx driver is such a driver. The idea is that if
> the remove callback returns void it's obvious that an early error return
> is wrong.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: imx: Don't skip cleanup in remove's error path
      commit: 11951c9e3f364d7ae3b568a0e52c8335d43066b5
[2/2] spi: imx: Convert to platform remove callback returning void
      commit: 423e548127223d597bb65a149ebcb3c50ea08846

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

