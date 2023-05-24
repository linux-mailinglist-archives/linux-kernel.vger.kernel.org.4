Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA3C70F4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjEXLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjEXLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A31B4;
        Wed, 24 May 2023 04:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD49262C37;
        Wed, 24 May 2023 11:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8685CC4331D;
        Wed, 24 May 2023 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684926282;
        bh=gSfPnPjxQ+g5yc36jkezG18RMtNAGuoMZoOVm/qXtTk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=hJXyXP5mJz8gnTLp5D5Ov89xtBbXvOV38zbwsu3TQLvFbwHzZVTdHm7/WhqYKnr2C
         5//c4/C/ZcPI4HyNLZC3afU4VDVwsB8q31BfWCv3h6ELyZpX/8h/FTZNhfzZLaqrua
         PGh5fei8RPfjdCAeUO1m4gzdZ60mbJ4Qu3YD3JTthQBQ/TAvw9dihxG5ItWjajLD08
         Ckqheu+mhzZMQs7NZi6TA1yZO4iOqVC9MCOojHKZlXwjPaA90DJKo+9XLPstDHDlNh
         Jp5JSWdQ1d9iTJPJsJthVicAvEqNiruU6LaGI9shj4H0RVh6q6TZFmtItwrZ2Z/RAD
         V/QGnLfyU0pJg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <ZFAF6pJxMu1z6k4w@makrotopia.org>
References: <ZFAF6pJxMu1z6k4w@makrotopia.org>
Subject: Re: [PATCH] spi: mt65xx: make sure operations completed before
 unloading
Message-Id: <168492628027.37394.11329859234589803044.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:04:40 +0100
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

On Mon, 01 May 2023 19:33:14 +0100, Daniel Golle wrote:
> When unloading the spi-mt65xx kernel module during an ongoing spi-mem
> operation the kernel will Oops shortly after unloading the module.
> This is because wait_for_completion_timeout was still running and
> returning into the no longer loaded module:
> 
> Internal error: Oops: 0000000096000005 [#1] SMP
> Modules linked in: [many, but spi-mt65xx is no longer there]
> CPU: 0 PID: 2578 Comm: block Tainted: G        W  O       6.3.0-next-20230428+ #0
> Hardware name: Bananapi BPI-R3 (DT)
> pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __lock_acquire+0x18c/0x20e8
> lr : __lock_acquire+0x9b8/0x20e8
> sp : ffffffc009ec3400
> x29: ffffffc009ec3400 x28: 0000000000000001 x27: 0000000000000004
> x26: ffffff80082888c8 x25: 0000000000000000 x24: 0000000000000000
> x23: ffffffc009609da8 x22: ffffff8008288000 x21: ffffff8008288968
> x20: 00000000000003c2 x19: ffffff8008be7990 x18: 00000000000002af
> x17: 0000000000000000 x16: 0000000000000000 x15: ffffffc008d78970
> x14: 000000000000080d x13: 00000000000002af x12: 00000000ffffffea
> x11: 00000000ffffefff x10: ffffffc008dd0970 x9 : ffffffc008d78918
> x8 : 0000000000017fe8 x7 : 0000000000000001 x6 : 0000000000000000
> x5 : ffffff807fb53910 x4 : 0000000000000000 x3 : 0000000000000027
> x2 : 0000000000000027 x1 : 0000000000000000 x0 : 00000000000c03c2
> Call trace:
>  __lock_acquire+0x18c/0x20e8
>  lock_acquire+0x100/0x2a4
>  _raw_spin_lock_irq+0x58/0x74
>  __wait_for_common+0xe0/0x1b4
>  wait_for_completion_timeout+0x1c/0x24
>  0xffffffc000acc8a4 <--- used to be mtk_spi_transfer_wait
>  spi_mem_exec_op+0x390/0x3ec
>  spi_mem_no_dirmap_read+0x6c/0x88
>  spi_mem_dirmap_read+0xcc/0x12c
>  spinand_read_page+0xf8/0x1dc
>  spinand_mtd_read+0x1b4/0x2fc
>  mtd_read_oob_std+0x58/0x7c
>  mtd_read_oob+0x8c/0x148
>  mtd_read+0x50/0x6c
>  ...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mt65xx: make sure operations completed before unloading
      commit: 4be47a5d59cbc9396a6ffd327913eb4c8d67a32f

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

