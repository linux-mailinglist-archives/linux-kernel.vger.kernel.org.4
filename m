Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274A6720826
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjFBRKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjFBRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A8F1A2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B405B61704
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACDAC433D2;
        Fri,  2 Jun 2023 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685725801;
        bh=FFfbYJAeWVlemuy55YRw4ykuDglzPT/JaLEPqPbT6qQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=coreVa5AwxkjU4f992ggWjolW7fV/ntma+BDJMVAnLt8XKsXaJ/Jre5aYaA0WaLRW
         TVIv5LKzC5y518KFJ7VFxI+x7SP5HLfSY72ToqC3eFc/C3do0nIHGd4QWedjB4ad1G
         wjtlzoZImKq9iaIWLMUt5gXBaIYWGX8d9w3rthF0ItGy+Nng8LCNpjNBPHop8B6VEM
         ACSTKSuj/7L1kNkbW3zdwet6isLENysj+NEZtLjvSUxcLhNjpZQOQgRAKPeqZm7h00
         5DFhGs/D1TGuvezU2/a+OWvJTRP2EtoqsySXgPV8RcozZQAlX7QZz68Z/y0wIlsPjD
         JCGdgWaERJ1Bg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230530103012.3448838-1-chancel.liu@nxp.com>
References: <20230530103012.3448838-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable BCI bit if SAI works on
 synchronous mode with BYP asserted
Message-Id: <168572579859.93025.4040527745876774020.b4-ty@kernel.org>
Date:   Fri, 02 Jun 2023 18:09:58 +0100
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

On Tue, 30 May 2023 18:30:12 +0800, Chancel Liu wrote:
> There's an issue on SAI synchronous mode that TX/RX side can't get BCLK
> from RX/TX it sync with if BYP bit is asserted. It's a workaround to
> fix it that enable SION of IOMUX pad control and assert BCI.
> 
> For example if TX sync with RX which means both TX and RX are using clk
> form RX and BYP=1. TX can get BCLK only if the following two conditions
> are valid:
> 1. SION of RX BCLK IOMUX pad is set to 1
> 2. BCI of TX is set to 1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode with BYP asserted
      commit: 32cf0046a652116d6a216d575f3049a9ff9dd80d

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

