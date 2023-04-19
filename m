Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB46E7C74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjDSOYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjDSOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8FB774
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 741E063BAD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADC8C4339C;
        Wed, 19 Apr 2023 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914203;
        bh=Y7NtdRvmYffAP0FrGkf+Pv8B5hj7E6uae/PQvl6MaS0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WZkty0bQqzMKfoyrRccbSKpbRiEzNS5m3vNdN9kjx4OK+ujf8Dr7zDBRIDEJX7l+A
         /oaqUG6MTOm2Cb3rB6COeQ69GRfdloleSwXfcmCkf5mLvVTqyXGlK0PoJLGmR9UayM
         R/TStqm3LXaUJoQ9NHiSPsVlhvt09qBj1cC/v6SEAirutEftAoikqibiLJPm/aO3Ph
         OCpz5Yt0apuLBnaqx2riz2GDI2PWh1rJvxYYR7QZuBBnecaJtS9HuDDdpCOGF9zyXk
         ZotnIDTRuRHkHr7lcJJPZl4fvZI49fsnsqA1KBKvAZdJOBaSdwYH6iCC0hBoydNMoY
         /zxpAsncbTrbQ==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Natalia Petrova <n.petrova@fintech.ru>
In-Reply-To: <20230417133242.53339-1-n.zhandarovich@fintech.ru>
References: <20230417133242.53339-1-n.zhandarovich@fintech.ru>
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: fix potential null-ptr-deref
Message-Id: <168191420102.83860.17076301173895914430.b4-ty@kernel.org>
Date:   Wed, 19 Apr 2023 15:23:21 +0100
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

On Mon, 17 Apr 2023 06:32:42 -0700, Nikita Zhandarovich wrote:
> dma_request_slave_channel() may return NULL which will lead to
> NULL pointer dereference error in 'tmp_chan->private'.
> 
> Correct this behaviour by, first, switching from deprecated function
> dma_request_slave_channel() to dma_request_chan(). Secondly, enable
> sanity check for the resuling value of dma_request_chan().
> Also, fix description that follows the enacted changes and that
> concerns the use of dma_request_slave_channel().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc_dma: fix potential null-ptr-deref
      commit: 86a24e99c97234f87d9f70b528a691150e145197

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

