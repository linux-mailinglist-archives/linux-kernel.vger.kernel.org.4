Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA3725F60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbjFGM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjFGM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D74E65;
        Wed,  7 Jun 2023 05:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BB3663674;
        Wed,  7 Jun 2023 12:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2275C433D2;
        Wed,  7 Jun 2023 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686140939;
        bh=QJXtZDyr4y8PqdZ+tYmaB6YEGrqj2OPQ+IO2QetYPnM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qntE2naidW5lgNM46jNKA359h4oM4obkc3y1ih7CWydCK0HNUJv7nUdqkPuK64Jca
         b3Y/ttQ/yqcznoBQETaKQmlaX8KRXm3NfgLSajcXbqtGvJMKH0BM8leYzrGRkZ+e3K
         00u+SQBxlg2wM45abAnSQiJDngCRMrlYT5l2zaTRRM66lW9XcFUBCUlvHqzLkT4sfG
         VsIkfBEWL8KuYKpR3WKDfolYyvnh9MfqDoKwR8ch3jvlL8K9DlbLtAfdjvyglgEgTU
         0aFr1qFOMyRqIUl5S1gStShurAh0VZiyRvSY1dtGgfAOkQDd6peHyB7BPQdiC3ZGqE
         I49OxCTP9xG9w==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
In-Reply-To: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
Subject: Re: [PATCH v2 0/2] spi-geni-qcom: Add new interfaces and utilise
 them to do map/unmap in framework for SE DMA
Message-Id: <168614093670.28037.10566283801764735785.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 13:28:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 17:48:12 +0530, Vijaya Krishna Nivarthi wrote:
> A "known issue" during implementation of SE DMA for spi geni driver was
> that it does DMA map/unmap internally instead of in spi framework.
> Current patches remove this hiccup and also clean up code a bit.
> 
> Testing revealed no regressions and results with 1000 iterations of
> reading from EC showed no loss of performance.
> Results
> =======
> Before - Iteration 999, min=5.10, max=5.17, avg=5.14, ints=25129
> After  - Iteration 999, min=5.10, max=5.20, avg=5.15, ints=25153
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] soc: qcom: geni-se: Add interfaces geni_se_tx_init_dma() and geni_se_rx_init_dma()
      commit: 6d6e57594957ee9131bc3802dfc8657ca6f78fee
[2/2] spi: spi-geni-qcom: Do not do DMA map/unmap inside driver, use framework instead
      commit: 3a76c7ca9e77269dd10cf21465a055274cfa40c6

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

