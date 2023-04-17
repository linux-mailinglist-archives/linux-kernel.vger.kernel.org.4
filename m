Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE296E50E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjDQT2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjDQT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854A729E;
        Mon, 17 Apr 2023 12:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F0E761FAD;
        Mon, 17 Apr 2023 19:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D1C4339C;
        Mon, 17 Apr 2023 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681759704;
        bh=oXlR8AAifxzte6z71VVc+KII9sSBzG7Ho+p5mKI5mrs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ciaKCa+ttowYhqS/tx+6lMgeWkRm44NKFgCF6ZQy9k4aOaCsN4OAWwkFp+Fx4ULrA
         jTWJSTL4Z8QL64fRu4opK7u07J674Z1G7IccciKH3l48rd7ePCdN2TXdtL+SJ8av68
         +SOTyhskpFBk0IRYxaVfONgB0b3YuD9psQp4PpPIIvMsMPzcS4G+ItSmLhMvsXw3k2
         98yU4DTJ6b6UdwYsfLgB6MdNtp9e+hxki5KyUqaHb/C7XttcubdAfXgIowaqL0c0Bq
         TClxZvqHI3NsI6bMBgZ1q8rCOq/Y/lrqam+kuiLIJowhF+eyXXehP8XQgMurRlDzRP
         H5Pnw4Ocpqfvw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Brad Larson <blarson@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
Subject: Re: (subset) [PATCH v13 00/15] Support AMD Pensando Elba SoC
Message-Id: <168175969761.1284440.5150551678916367911.b4-ty@kernel.org>
Date:   Mon, 17 Apr 2023 20:28:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 11:45:11 -0700, Brad Larson wrote:
> This series enables support for AMD Pensando Elba SoC based platforms.
> 
> The Elba SoC has the following features:
> - Sixteen ARM64 A72 cores
> - Dual DDR 4/5 memory controllers
> - 32 lanes of PCIe Gen3/4 to the Host
> - Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
>   also a single 1GE management port.
> - Storage/crypto offloads and 144 programmable P4 cores.
> - QSPI and EMMC for SoC storage
> - Two SPI interfaces for peripheral management
> - I2C bus for platform management
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
        (no commit info)
[04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
        commit: 6282a6ceef62f5732082f691de8f82fcd49d4fb4
[09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
        (no commit info)
[10/15] spi: dw: Add support for AMD Pensando Elba SoC
        commit: 2c8606040a808aa01d2d9e4f5b9332e87bb66377

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

