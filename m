Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE46C6C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjCWPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjCWPx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE615881
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B89A16258C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5422BC4339B;
        Thu, 23 Mar 2023 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679586804;
        bh=FdHS15So9Ov5UwML5lh/46ZuooLqJDDwXlY+p4s6GWw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CNGSrs2QzotBEF+17I0Y5+b51GhUySm0eSUNvTgMHB4n9OihqfcOVEMFP6nf5qmGI
         ynMvvmfJAW2mFYi3wY7vWpCN6pAAXD8Xa2+8LTCzG0thi+Lg5vSHYl+TyW3t++2GpO
         m9bMWI98WntyjRC4t5aiuzNch7ZZW2+X/gnx0sGHYuOg3s+lFRMUQl/Fo8I2ASWL41
         Ii0p0CJaz1xq6aLJVwHi6tUYKlsr57s7WrVZccZqOOnwjNlRQeRrQAducIsXOWNgpK
         F01q12N6DgleqZ/gYdsZe8zFngRL4WJJE656WuNC+rGnlnUlMIzg1ijukzA1ndMIUJ
         nQ/yG/FnXKFNA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Amit Pundir <amit.pundir@linaro.org>
In-Reply-To: <20230323110125.23790-1-srinivas.kandagatla@linaro.org>
References: <20230323110125.23790-1-srinivas.kandagatla@linaro.org>
Subject: Re: [RESEND PATCH] ASoC: codecs: lpass: fix the order or clks turn
 off during suspend
Message-Id: <167958680207.69273.10837351413048222652.b4-ty@kernel.org>
Date:   Thu, 23 Mar 2023 15:53:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 11:01:25 +0000, Srinivas Kandagatla wrote:
> The order in which clocks are stopped matters as some of the clock
> like NPL are derived from MCLK.
> 
> Without this patch, Dragonboard RB5 DSP would crash with below error:
>  qcom_q6v5_pas 17300000.remoteproc: fatal error received:
>  ABT_dal.c:278:ABTimeout: AHB Bus hang is detected,
>  Number of bus hang detected := 2 , addr0 = 0x3370000 , addr1 = 0x0!!!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass: fix the order or clks turn off during suspend
      commit: a4a3203426f4b67535d6442ddc5dca8878a0678f

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

