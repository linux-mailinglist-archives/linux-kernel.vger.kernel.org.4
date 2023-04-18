Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC606E6944
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjDRQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjDRQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C272BB77B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C3B76366A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF6EC4339B;
        Tue, 18 Apr 2023 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834884;
        bh=KYDGQ9LC4dPkxsMX1LMYuetVwQ+YdQq+9bWbGBBitMU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FAjdS1X12XnDLtdc2vxXiUiZEUSoRx5JQwgiqbIyXf5jNtZK+REYZ4mBKDmCmoQv7
         0KQmMicHUPbbSHyIqfCjadsugLbUtHK5hG6ze75e48XCs0hBYzs2vlQGEz/NeEI71e
         mZT5BYh4uh7RuG4gYtpS5A0risLPIElTJiDQsOi86KTj2r78ALN7wymPglJaVKblWW
         Axe0NQA1J4qRT6ZluipdMEvB9XEtGJrz16VypAWyMbgieK6a3kn+G0kgMMsh8ZWgl/
         yVAFnvVZfNg7/idwIYz55Oh9jLxw9/CRXRO+7yKAv+IAmnSPzBtEFjL4DTLRlbJAEx
         De1HdNSCQZeOA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        nathan@kernel.org, ndesaulniers@google.com, CTLIN0@nuvoton.com,
        luca.ceresoli@bootlin.com, peda@axentia.se, javierm@redhat.com,
        u.kleine-koenig@pengutronix.de, ckeepax@opensource.cirrus.com,
        Tom Rix <trix@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230418120955.3230705-1-trix@redhat.com>
References: <20230418120955.3230705-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: nau8825: fix bounds check for adc_delay
Message-Id: <168183488148.87933.1461165483240440828.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 17:21:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 08:09:55 -0400, Tom Rix wrote:
> clang build reports
> sound/soc/codecs/nau8825.c:2826:31: error: overlapping comparisons
>   always evaluate to false [-Werror,-Wtautological-overlap-compare]
>         if (nau8825->adc_delay < 125 && nau8825->adc_delay > 500)
>             ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is a bug, a logical-or should have been used.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8825: fix bounds check for adc_delay
      commit: 5f3d94eb7ae877430d9fe6a9aae7dcef6c3e5fea

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

