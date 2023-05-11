Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762A6FEB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjEKGBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEKGBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E4272A;
        Wed, 10 May 2023 23:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97485635B9;
        Thu, 11 May 2023 06:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5733BC433EF;
        Thu, 11 May 2023 06:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683784866;
        bh=DRAyWIVBVl/Vja8Y6YNCq8vTtf3RsA1/UCfLfuH/Fkw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y9PY77s7aH3WeiI0xSgZfJX5Ilh3vZj3S8whWKLJCvf+e8lYVAMIyjS4syhdgraIE
         u1l1uj7I8p9Hxm/8Q/xkRIXf8Ngic8Ub1478fwReF7MYvqJJwscPtbaKAsOcZVLPYh
         oN/2t5DVGC6qc5nLfR2W2eZSzWZku0WD2CrXTWgMpgOSleSvlOrOM+nkgQ4nXfSEdk
         41+Lu1TZq0VNVewY/2q19P4o/wdYQ+t/+XQzeGSAVg+xMVlCqgsDRX6P2cO6a1IPVk
         zCSqrpRIkaf6yd2s+wZ7Mr+w9Idxv97q+sYwAcvEMM5eR17DBI5CWUj58Omr2prFoF
         8VxLupA9MmRiw==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
In-Reply-To: <1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Select FIFO mode for chip select
Message-Id: <168378486157.333092.4222573391811617519.b4-ty@kernel.org>
Date:   Thu, 11 May 2023 15:01:01 +0900
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

On Tue, 09 May 2023 15:31:36 +0530, Vijaya Krishna Nivarthi wrote:
> Spi geni driver switches between FIFO and DMA modes based on xfer length.
> FIFO mode relies on M_CMD_DONE_EN interrupt for completion while DMA mode
> relies on XX_DMA_DONE.
> During dynamic switching, if FIFO mode is chosen, FIFO related interrupts
> are enabled and DMA related interrupts are disabled. And viceversa.
> Chip select shares M_CMD_DONE_EN interrupt with FIFO to check completion.
> Now, if a chip select operation is preceded by a DMA xfer, M_CMD_DONE_EN
> interrupt would have been disabled and hence it will never receive one
> resulting in timeout.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: Select FIFO mode for chip select
      commit: 4c329f5da7cfa366bacfda1328a025dd38951317

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

