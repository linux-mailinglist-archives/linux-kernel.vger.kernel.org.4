Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF340611751
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJ1QQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJ1QPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47C1B1C4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8CF962940
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AC9C4314D;
        Fri, 28 Oct 2022 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666973680;
        bh=hPulKsWfwmPS12vC8SipmsqMezI1Fy/nKCO0cEWbjbw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AwfmZaL49GbbKADMrHKMnSR4f8L6gDd7gYK+muQWnFx+nq5hB7Zetnlq90s9jvqtH
         h+Rt5C3MlVeEzz57EVBxSJqR9z5i9yVcl5uP7yXsZ+O/NeB8EmO1uv/5tDx8UEd5OP
         DnxHq9BSpn8H7VYxYVHc3Sc2oAz2yYWdQ+ONpyytV03wqPzez1ohg5cuD56Qk3+ria
         fIvghKVyII0Eo5+vNL+YvKysbUxfKr/knS+P1PoS/xxSSEGJV2idWG8u5jeDy5RctS
         XraqgYTvFh8X0uT1WepaBkMk2HxHymcrahRwNPCV+CANILBOUK1iGFjJX9Bk11hDgN
         SOeNIE23zAJ4A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com
In-Reply-To: <20221028031603.59416-1-chenzhongjin@huawei.com>
References: <20221028031603.59416-1-chenzhongjin@huawei.com>
Subject: Re: [PATCH] ASoC: core: Fix use-after-free in snd_soc_exit()
Message-Id: <166697367874.746166.7503879951900455151.b4-ty@kernel.org>
Date:   Fri, 28 Oct 2022 17:14:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 11:16:03 +0800, Chen Zhongjin wrote:
> KASAN reports a use-after-free:
> 
> BUG: KASAN: use-after-free in device_del+0xb5b/0xc60
> Read of size 8 at addr ffff888008655050 by task rmmod/387
> CPU: 2 PID: 387 Comm: rmmod
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Call Trace:
> <TASK>
> dump_stack_lvl+0x79/0x9a
> print_report+0x17f/0x47b
> kasan_report+0xbb/0xf0
> device_del+0xb5b/0xc60
> platform_device_del.part.0+0x24/0x200
> platform_device_unregister+0x2e/0x40
> snd_soc_exit+0xa/0x22 [snd_soc_core]
> __do_sys_delete_module.constprop.0+0x34f/0x5b0
> do_syscall_64+0x3a/0x90
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> ...
> </TASK>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: Fix use-after-free in snd_soc_exit()
      commit: 6ec27c53886c8963729885bcf2dd996eba2767a7

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
