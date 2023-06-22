Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ACC73AD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjFVXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjFVXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831C1FE3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98FB1618CD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 23:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2451BC433C8;
        Thu, 22 Jun 2023 23:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687476063;
        bh=3Rhxm6Lb9G8rJv2eV/cdsUR1mUDxoTl8GkJ3wYgWTnk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YD4Tyc4Z1ok3HLz75iwjlkXLyJ+OFS4Gg1AI0NXlUyklTjaeic3MmcLCcj2hSdIx0
         BxxJ3J4KljqWcr6i3L08PAQ+jRBUVwhv/BAZaiTVIelpsv67zaBs/V9/jzmzSulbx8
         l0hyXOwooniPuGr4+T1Ju+IIVrFK8bKJWNLpxm/FnflPXTy9FO1Z0Q29/jcLMt8KDg
         DARq5yHG4kJNB05GElQDGyUU9KQZKnPe9Zgxq/15xgR0mtaCr/jZc/8RPknyykYPcv
         XJCYsML4bBBUksxQQV+v7qS5KcZfBhBUuJKDZnJVpYHjXpfUPNmvNLG7ki0FJasyfM
         yA/QE6dCAdYLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230622151146.1459250-1-martin.fuzzey@flowbird.group>
References: <20230622151146.1459250-1-martin.fuzzey@flowbird.group>
Subject: Re: [PATCH v2] regulator: da9063: fix null pointer deref with
 partial DT config
Message-Id: <168747606054.325012.10021476177510722363.b4-ty@kernel.org>
Date:   Fri, 23 Jun 2023 00:21:00 +0100
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

On Thu, 22 Jun 2023 17:11:02 +0200, Martin Fuzzey wrote:
> When some of the da9063 regulators do not have corresponding DT nodes
> a null pointer dereference occurs on boot:
> 
> [    1.559034] 8<--- cut here ---
> [    1.564014] Unable to handle kernel NULL pointer dereference at virtual address 00000098 when read
> [    1.578055] [00000098] *pgd=00000000
> [    1.593575] Internal error: Oops: 5 [#1] SMP ARM
> [    1.634870] PC is at da9063_regulator_probe+0x35c/0x788
> [    1.647934] LR is at da9063_regulator_probe+0x2e8/0x788
> [    2.073626]  da9063_regulator_probe from platform_probe+0x58/0xb8
> [    2.079759]  platform_probe from really_probe+0xd8/0x3c0
> [    2.085092]  really_probe from __driver_probe_device+0x94/0x1e8
> [    2.091026]  __driver_probe_device from driver_probe_device+0x2c/0xd0
> [    2.097479]  driver_probe_device from __device_attach_driver+0xa4/0x11c
> [    2.104107]  __device_attach_driver from bus_for_each_drv+0x84/0xdc
> [    2.110402]  bus_for_each_drv from __device_attach_async_helper+0xb0/0x110
> [    2.117295]  __device_attach_async_helper from async_run_entry_fn+0x3c/0x158
> [    2.124369]  async_run_entry_fn from process_one_work+0x1d4/0x3e4
> [    2.130485]  process_one_work from worker_thread+0x30/0x520
> [    2.136070]  worker_thread from kthread+0xdc/0xfc
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9063: fix null pointer deref with partial DT config
      commit: b9e6bee2bcb144d0eac0ac3d8826ae73c54a50df

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

