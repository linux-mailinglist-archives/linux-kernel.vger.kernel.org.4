Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB397205B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbjFBPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjFBPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6DB18D;
        Fri,  2 Jun 2023 08:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DA865149;
        Fri,  2 Jun 2023 15:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEB4C433D2;
        Fri,  2 Jun 2023 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685719013;
        bh=xSEpxg33Y2SgSD3RfJr1UzQa06gTFJ4eEBC5hlV5FIo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rQWM1s6QdtDSb/Cvzj5SlSryf7uA71A/77AvkoquEf6JZeHLBsP841yjuTadE2SOc
         XMUDCj8XmvvXc5so8lGPM9vy+i6U2CghVBq3WM9792RWw4rf8hfjFy6MmKRJlwLvhV
         /mcxlk2iNQ0KYob4ZPfiUqTbm63k7Wienb1PrwDebDkFPjrDnK71GbCOSMFqrz7hvp
         /06WK78/HKa909fnL8z2HfUMizFoaTUYJHe+tWwvN3QCAEnE6URsJVbaYnta20z5jg
         g1so0uRRWE42cXHpdNDm5nqBXM9SIjuMv20G4LtWliHtCnsFw0GDpbwjzNusWYPSma
         6L5wnM9JVw2Wg==
From:   Mark Brown <broonie@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Boerge Struempfel <boerge.struempfel@gmail.com>,
        "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230602115731.708883-1-linux@rasmusvillemoes.dk>
References: <20230602115731.708883-1-linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] spi: spi-imx: fix mixing of native and gpio
 chipselects for imx51/imx53/imx6 variants
Message-Id: <168571901091.65587.1980168076721765173.b4-ty@kernel.org>
Date:   Fri, 02 Jun 2023 16:16:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023 13:57:30 +0200, Rasmus Villemoes wrote:
> Commit 87c614175bbf (spi: spi-imx: fix MX51_ECSPI_* macros when cs >
> 3) ensured that the argument passed to the macros was masked with &3,
> so that we no longer write outside the intended fields in the various
> control registers. When all chip selects are gpios, this works just
> fine.
> 
> However, when a mix of native and gpio chip selects are in use, that
> masking is too naive. Say, for example, that SS0 is muxed as native
> chip select, and there is also a chip at 4 (obviously with a gpio
> cs). In that case, when accessing the latter chip, both the SS0 pin
> and the gpio pin will be asserted low.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: fix mixing of native and gpio chipselects for imx51/imx53/imx6 variants
      commit: a34e0353a681bbdd0402825e25410c3236109f31

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

