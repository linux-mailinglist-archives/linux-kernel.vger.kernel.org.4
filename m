Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7683C706B78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEQOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjEQOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:44:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555A81708;
        Wed, 17 May 2023 07:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47E363A6A;
        Wed, 17 May 2023 14:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFFBC4339B;
        Wed, 17 May 2023 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684334638;
        bh=8xiYbOqEXUtDGMUV7q9ZaOPlQZ52ZChNwFZR+2AGYMs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JIhdHEH7BdQnG0Fi3V12uwO4Ei4+8ssxzTfDQi2B88PNSeXQh8pqhzzpjjxkI5OKM
         hcPXc2Oi89naBtWB3P0OK4v+OnUmFE8yXEdpiSinkLxcdhCKie4vAUglQmcTwULaJ+
         YhsYbuZLBJBcFm7n5gmZmMuJ92TUOIYFUBAJ3pWTREofsv6JIAHbvOBldiSd9G8RVK
         mJVYwPyzodpKyAzcpBkodt19XQ2Q3XGBk0nVt/QX0b1BtVqGEMfRMJMGPB0Q2pjxOZ
         yfiSeb3DUlOPJVIXJZKPboTIVo7fqVV+6vr8IVrWxSU/ynq0+XdHa8dSm6ce4OusWf
         LQFi2FHiK2qjw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Brad Larson <blarson@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
Subject: Re: (subset) [PATCH v14 0/8] Support AMD Pensando Elba SoC
Message-Id: <168433462851.451768.13871519819070116651.b4-ty@kernel.org>
Date:   Wed, 17 May 2023 23:43:48 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 11:15:58 -0700, Brad Larson wrote:
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

[2/8] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
      commit: f2156989bf3014c67707d73ccd202b2ada09080b
[7/8] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
      commit: f5c2f9f9584353bc816d76a65c97dd03dc61678c

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

