Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0276B5EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCKRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCKRTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:19:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05E3D7C2A;
        Sat, 11 Mar 2023 09:19:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DABC8CE03BC;
        Sat, 11 Mar 2023 17:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C416C433D2;
        Sat, 11 Mar 2023 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678555170;
        bh=wSOMnDJH6RHTEc3Rd+XOWpH98pSvFyXuUz7OUkxGGA0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h0D4r8gRvfWv5naD4CqbDZBP7YbCDsLDOScr3tx0LmRYSwBqiMICO8gvgtVdeQo8a
         2/QFjoOB1+j6TxLe87FeY6C7bN/HxBqSVpGvthoGqtkLM1QjsF0Ku80F2Ss6O+eX/+
         cAbCtLYy6hrB19zxfMhKEiaMNFpAvEsA1gsyV4xC5507IqZOrvh0wmHToz0xLknyEq
         38J7gxNV/zgInF/e1ce3nM/1fWDdwBiUPgQUNsf+wOJxg12YP57PlMsjYviuW/nNQD
         zYpi6E3590awh+kUxwHiz8/ShxXbVSOZMoMlP5CUStUGqiuQxvoJ0sPGvhYPN378CX
         FLB5AaYWubM6A==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230310140605.569363-1-arnd@kernel.org>
References: <20230310140605.569363-1-arnd@kernel.org>
Subject: Re: [PATCH] spi: fsi: restore CONFIG_FSI dependency
Message-Id: <167855516801.950686.5158612540000291049.b4-ty@kernel.org>
Date:   Sat, 11 Mar 2023 17:19:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 15:05:37 +0100, Arnd Bergmann wrote:
> The assumption that the build dependency was not necessary turned
> out to be wrong, as building SPI_FSI without FSI results in a link
> failure:
> 
> aarch64-linux-ld: drivers/spi/spi-fsi.o: in function `fsi_spi_check_status':
> spi-fsi.c:(.text+0x54): undefined reference to `fsi_device_read'
> aarch64-linux-ld: drivers/spi/spi-fsi.o: in function `fsi_spi_read_reg':
> spi-fsi.c:(.text+0x120): undefined reference to `fsi_device_write'
> aarch64-linux-ld: spi-fsi.c:(.text+0x170): undefined reference to `fsi_device_read'
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: restore CONFIG_FSI dependency
      commit: bae4ae831a43a1e695bdb6c242bad2454519cb2a

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

