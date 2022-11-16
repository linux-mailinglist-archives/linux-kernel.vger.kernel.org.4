Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D580862C1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiKPPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiKPPBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:01:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6DB22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:01:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C26EB81DB9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8CFC433D7;
        Wed, 16 Nov 2022 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668610895;
        bh=dcP2x5CBch3DJrmGZJ+7f+29GSfFAgYzmRD/abQws/E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sDXNQYF9M6WwdwcIXcA4jA35AGQhYk2LJUH4cqiVg5csF4AmRBLuyJrSL+HzMMWsp
         1tASUSW+XLcPpsyYHKRzcL5RJMBZUliQ4MvDA5iFo101jOHKQm+2XgYdF8H+6kdamA
         29K8QUMxIZCmL4f2gQQ6ABbD6kZr8ZF1oatCIiNXU1P66E//Xz+xOD+xi1d5ycCwVQ
         MjqSlNG/kbclazj1u6T4LbA9W/goAUkngHvmlGTjEy4f/nOx2K+XjEWPjz484C4lN0
         qOx4O+2qduFwefuLL+U169T8n/dOgm65rGhVg1o0JVwRM7ybKDkJ44CrdmT7pU6Aqp
         NZdzj6PbmxORw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     lgirdwood@gmail.com
In-Reply-To: <20221116033706.3595812-1-yangyingliang@huawei.com>
References: <20221116033706.3595812-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] regulator: core: fix UAF in destroy_regulator()
Message-Id: <166861089393.540847.16213406405179822954.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 15:01:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 11:37:06 +0800, Yang Yingliang wrote:
> I got a UAF report as following:
> 
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x935/0x2060
> Read of size 8 at addr ffff88810e838220 by task python3/268
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x67/0x83
>  print_report+0x178/0x4b0
>  kasan_report+0x90/0x190
>  __lock_acquire+0x935/0x2060
>  lock_acquire+0x156/0x400
>  _raw_spin_lock+0x2a/0x40
>  lockref_get+0x11/0x30
>  simple_recursive_removal+0x41/0x440
>  debugfs_remove.part.12+0x32/0x50
>  debugfs_remove+0x29/0x30
>  _regulator_put.cold.54+0x3e/0x27f
>  regulator_put+0x1f/0x30
>  release_nodes+0x6a/0xa0
>  devres_release_all+0xf8/0x150
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: fix UAF in destroy_regulator()
      commit: 1f386d6894d0f1b7de8ef640c41622ddd698e7ab

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
