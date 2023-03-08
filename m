Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58B06B0C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCHPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjCHPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:20:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E828D6EB9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B840AB81CBA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD330C433EF;
        Wed,  8 Mar 2023 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678288819;
        bh=w5Wq43aKMcTwX8nKsIou+Df8rMxn8L4Me+FGU3w6k8Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cm281oLMXSHk/1RWaJgO+zMO4bwXJ3JBBm+Oixmx6JxGzvbgkMK0vJfpIcie7kQv+
         y4NbZjXa9Kx9Fj1hgiF+RoKGtJ7aid7Wq8stsTHHnsSrXt794qQIEwAEpCZmH+sd/f
         Vd6H84Kk1gy5xnUSeGceZto5J0vvNPUHjHfWZQNpY6UKQKjRdG8m88Ooevee+VhAOC
         7pCSlrzK4ewWWKHf+TvMmLTQdwGdrRugcZxt/LJFoD7LIc6NSc3F/bYzNtQnNXBg0O
         FGg8cCxZVD0NK3jVBkggzy2cXyum2DIUDXuV4pb5pIoGPW8KPUKGorrdKohzn0fIgG
         xdQXBhHGwjc3w==
From:   Mark Brown <broonie@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
In-Reply-To: <20230307155111.1985522-1-linux@roeck-us.net>
References: <20230307155111.1985522-1-linux@roeck-us.net>
Subject: Re: [PATCH] ASoC: da7219: Initialize jack_det_mutex
Message-Id: <167828881761.45774.4994753049411138273.b4-ty@kernel.org>
Date:   Wed, 08 Mar 2023 15:20:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023 07:51:11 -0800, Guenter Roeck wrote:
> The following traceback is reported if mutex debugging is enabled.
> 
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> WARNING: CPU: 0 PID: 17 at kernel/locking/mutex.c:950 __mutex_lock_common+0x31c/0x11d4
> Modules linked in:
> CPU: 0 PID: 17 Comm: kworker/0:1 Not tainted 5.10.172-lockdep-21846-g849884cfca5a #1 fd2de466502012eb58bc8beb467f07d0b925611f
> Hardware name: MediaTek kakadu rev0/rev1 board (DT)
> Workqueue: events da7219_aad_jack_det_work
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
> pc : __mutex_lock_common+0x31c/0x11d4
> lr : __mutex_lock_common+0x31c/0x11d4
> sp : ffffff80c0317ae0
> x29: ffffff80c0317b50 x28: ffffff80c0317b20
> x27: 0000000000000000 x26: 0000000000000000
> x25: 0000000000000000 x24: 0000000100000000
> x23: ffffffd0121d296c x22: dfffffd000000000
> x21: 0000000000000000 x20: 0000000000000000
> x19: ffffff80c73d7190 x18: 1ffffff018050f52
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000000 x14: 0000000000000000
> x13: 0000000000000001 x12: 0000000000000001
> x11: 0000000000000000 x10: 0000000000000000
> x9 : 83f0d991da544b00 x8 : 83f0d991da544b00
> x7 : 0000000000000000 x6 : 0000000000000001
> x5 : ffffff80c03176a0 x4 : 0000000000000000
> x3 : ffffffd01067fd78 x2 : 0000000100000000
> x1 : ffffff80c030ba80 x0 : 0000000000000028
> Call trace:
> __mutex_lock_common+0x31c/0x11d4
> mutex_lock_nested+0x98/0xac
> da7219_aad_jack_det_work+0x54/0xf0
> process_one_work+0x6cc/0x19dc
> worker_thread+0x458/0xddc
> kthread+0x2fc/0x370
> ret_from_fork+0x10/0x30
> irq event stamp: 579
> hardirqs last enabled at (579): [<ffffffd012442b30>] exit_to_kernel_mode+0x108/0x138
> hardirqs last disabled at (577): [<ffffffd010001144>] __do_softirq+0x53c/0x125c
> softirqs last enabled at (578): [<ffffffd01009995c>] __irq_exit_rcu+0x264/0x4f4
> softirqs last disabled at (573): [<ffffffd01009995c>] __irq_exit_rcu+0x264/0x4f4
> ---[ end trace 26da674636181c40 ]---
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Initialize jack_det_mutex
      commit: af0f46e5b9a462aaa1d76e82781a5316f03828eb

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

