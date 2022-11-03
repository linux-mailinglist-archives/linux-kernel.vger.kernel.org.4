Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4125C6180A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiKCPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiKCPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:09:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F45FBA;
        Thu,  3 Nov 2022 08:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31F8BB828DB;
        Thu,  3 Nov 2022 15:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25534C433D6;
        Thu,  3 Nov 2022 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667488102;
        bh=KhRW53DoqMIL02J6y2okdVdA8j0iIM0VREqjEufLwkM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BggIhs21AGl3tcUI1M35R8FkXZUaa16Ldc6OBqymKfDnolM+r30o6tE6zI+/qzHdU
         m4xkeaLBPUANkFqc3ZUGCc8SKB5iuCZ9SUF5Hbyp2SMPYTXoNwrGg/X3ls5A3SV8Og
         0XaWZJLVcnUu73kof2GiMUkOwj950T2ocNPnRxgYBQENcYWmiEn7nWjKmalul1JY9r
         mZhk8jGuEYR8/9N5QkSdYgyHtkxmtBRIc5BdLIVec1gpJvul7kpifhP+gdBEFcws98
         ZiI0osnH+g0aOzEOBVZ9AicdMxchQnL80eMSc18YVKDjX678KCCbT4WBOnP2h5F2K0
         OIGDqup0y4QHw==
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221103080043.3033414-1-sean@geanix.com>
References: <20221103080043.3033414-1-sean@geanix.com>
Subject: Re: [PATCH] spi: stm32: fix stm32_spi_prepare_mbr() that halves spi clk for every run
Message-Id: <166748810082.250043.8488161005893728423.b4-ty@kernel.org>
Date:   Thu, 03 Nov 2022 15:08:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 09:00:42 +0100, Sean Nyekjaer wrote:
> When this driver is used with a driver that uses preallocated spi_transfer
> structs. The speed_hz is halved by every run. This results in:
> 
> spi_stm32 44004000.spi: SPI transfer setup failed
> ads7846 spi0.0: SPI transfer failed: -22
> 
> Example when running with DIV_ROUND_UP():
> - First run; speed_hz = 1000000, spi->clk_rate 125000000
>   div 125 -> mbrdiv = 7, cur_speed = 976562
> - Second run; speed_hz = 976562
>   div 128,00007 (roundup to 129) -> mbrdiv = 8, cur_speed = 488281
> - Third run; speed_hz = 488281
>   div 256,000131072067109 (roundup to 257) and then -EINVAL is returned.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix stm32_spi_prepare_mbr() that halves spi clk for every run
      commit: 62aa1a344b0904549f6de7af958e8a1136fd5228

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
