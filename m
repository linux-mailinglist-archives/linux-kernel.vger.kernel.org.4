Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6752571636E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjE3OPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjE3OPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0441E42;
        Tue, 30 May 2023 07:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 647F5630EF;
        Tue, 30 May 2023 14:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A417C433EF;
        Tue, 30 May 2023 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685456108;
        bh=bm4SV3FLq8TygY6xro+tEHMUBROIfBWlNCPGHAIJ8Ls=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RvGgEHM0/t1LcP35KOD4FJiqO+AzlnQeT68CVpffEsR8M9JWbZVOtbzv3SU4bn25z
         mEzPXe//sk34i4LrgxzUkcd0AV3RdMNjSCgdgChJp3A8BuIjDn9iQQwhEwbffh41Pa
         ZdCD4L5THvEGZRkPteP3mDfjkfmDtDv5fC3gUBwFTflnb63WLWLlRqwUYMz5P75q/e
         TZEpRt0FpJrmeAdc2Fu0Zeh3pFyIJvZg77dnBMm64dXd3ibcamzAeEjhF4Zx+mazx/
         5T6vp0lqBlIj8ZOuzvOJPZynp+vq5A/fovOXagh1vvOt+R9b7QVdTX98MoU6odUoY0
         TwMlA6mlzbOoQ==
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230518-spi-qup-clk-defer-v1-1-f49fc9ca4e02@gerhold.net>
References: <20230518-spi-qup-clk-defer-v1-1-f49fc9ca4e02@gerhold.net>
Subject: Re: [PATCH] spi: qup: Request DMA before enabling clocks
Message-Id: <168545610674.311273.7922525088793753962.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 15:15:06 +0100
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

On Thu, 18 May 2023 15:04:25 +0200, Stephan Gerhold wrote:
> It is usually better to request all necessary resources (clocks,
> regulators, ...) before starting to make use of them. That way they do
> not change state in case one of the resources is not available yet and
> probe deferral (-EPROBE_DEFER) is necessary. This is particularly
> important for DMA channels and IOMMUs which are not enforced by
> fw_devlink yet (unless you use fw_devlink.strict=1).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: qup: Request DMA before enabling clocks
      commit: 0c331fd1dccfba657129380ee084b95c1cedfbef

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

