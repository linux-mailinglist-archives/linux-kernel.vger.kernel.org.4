Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B66ABFCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjCFMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCFMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:45:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0CC2BEC0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:45:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A297060EBC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75545C4339B;
        Mon,  6 Mar 2023 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678106744;
        bh=u39hN/wwIlITAu/b88DSvIgwjo46vuqUzKvxdfHdQ3Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IyaBW3m/TuBgQD4m9tIIV/WVS4eiepeLHuNJbj2jyrN3Slk6DPYlyXTaMK/GXbCWa
         qRVqVICiOKDOLsd0KZTGhyo6h9OuEq02QP4dxSvQotq+rSbyNMnoEVPFy2N5mJKTI3
         H0XZIARYMt8mnYwlkF0COryGMj8ImRpOp9/CaYtb6jhdLX9EzDpkIkzNnDSLvgrcTY
         13E5SLkXO/oMVay0IYjKV7A9WH4eaEuev7r+9eoH/b/BKNUlyUeY/xa/GqO/aojkAW
         fecvpFJ/9mcunJEMhAIqasitC7+6yN8HS+Uv16yHnTHWd6ZuajGxayGt/mrZQVEdRS
         VcB9Psu1xdV5w==
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230304080702.609-1-quic_visr@quicinc.com>
References: <20230304080702.609-1-quic_visr@quicinc.com>
Subject: Re: [PATCH] ASoC: codecs: tx-macro: Fix for KASAN:
 slab-out-of-bounds
Message-Id: <167810674220.45838.12997652294866709663.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 12:45:42 +0000
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

On Sat, 04 Mar 2023 13:37:02 +0530, Ravulapati Vishnu Vardhan Rao wrote:
> When we run syzkaller we get below Out of Bound.
>     "KASAN: slab-out-of-bounds Read in regcache_flat_read"
> 
>     Below is the backtrace of the issue:
> 
>     dump_backtrace+0x0/0x4c8
>     show_stack+0x34/0x44
>     dump_stack_lvl+0xd8/0x118
>     print_address_description+0x30/0x2d8
>     kasan_report+0x158/0x198
>     __asan_report_load4_noabort+0x44/0x50
>     regcache_flat_read+0x10c/0x110
>     regcache_read+0xf4/0x180
>     _regmap_read+0xc4/0x278
>     _regmap_update_bits+0x130/0x290
>     regmap_update_bits_base+0xc0/0x15c
>     snd_soc_component_update_bits+0xa8/0x22c
>     snd_soc_component_write_field+0x68/0xd4
>     tx_macro_digital_mute+0xec/0x140
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: tx-macro: Fix for KASAN: slab-out-of-bounds
      commit: e5e7e398f6bb7918dab0612eb6991f7bae95520d

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

