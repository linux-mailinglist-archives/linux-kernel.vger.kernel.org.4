Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECBA73AC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFVWds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjFVWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F2819AF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 086BA61923
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3D2C433C8;
        Thu, 22 Jun 2023 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687473220;
        bh=wP5iYCJHzA+hCBB51KqK3bEREmtRlXHKh26/82qwFDE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ssH+p4BaxnsIM0BKtv2UJNG2p5L0vhErzN1IOK6XILmij1WwGEh1ViosLCPKaFOzr
         dtW7Ca/Sdfb1PzLV0XPv4fb0bExLCFS64R2Wdi2VKHCGa6qyawvN+n88JW4oLRF7+i
         vP69ZO24fYXHexeWj2TNR8lGPL3703hktTrlMTJ9qdKPEGpEAkCN6vNCr3i6sQSBFu
         m+IZ5SHfp6qGeDpv89J0Sl54TS4Vuowue8HEKC7HrvuI5hSS5ezjXnvaLd/LX1xK5/
         x0lYBLgIhwU+l1VA/NAr4GwvvImVaq0ArrV/GBxnPexv+t5RbCH+/kaBPpv6BkHu1v
         0LkI2DbzYQKOA==
From:   Mark Brown <broonie@kernel.org>
To:     Yingkun Meng <mengyingkun@loongson.cn>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230622101235.3230941-1-arnd@kernel.org>
References: <20230622101235.3230941-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: loongson: fix address space confusion
Message-Id: <168747321729.318849.3547476102614344468.b4-ty@kernel.org>
Date:   Thu, 22 Jun 2023 23:33:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 12:12:22 +0200, Arnd Bergmann wrote:
> The i2s driver uses the mapped __iomem address of the FIFO as the DMA
> address for the device. This apparently works on loongarch because of
> the way it handles __iomem pointers as aliases of physical addresses,
> but this is not portable to other architectures and causes a compiler
> warning when dma addresses are not the same size as pointers:
> 
> sound/soc/loongson/loongson_i2s_pci.c: In function 'loongson_i2s_pci_probe':
> sound/soc/loongson/loongson_i2s_pci.c:110:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>   110 |         tx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_TX_DATA;
>       |                             ^
> sound/soc/loongson/loongson_i2s_pci.c:113:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>   113 |         rx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_RX_DATA;
>       |                             ^
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: fix address space confusion
      commit: 012fa2622e30675f61413485785e708ba02be78b

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

