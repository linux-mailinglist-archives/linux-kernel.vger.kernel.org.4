Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC997086EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjERRb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjERRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682FD10C3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 049FE65125
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9169EC433D2;
        Thu, 18 May 2023 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431066;
        bh=+5h/6N8I0UV/l06NAtCmeaQnePCeUKDhjroTzI85C4U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UyCONONYRD7xFmaZobBaYzr3h53pKq6TKE/mJ9CLm97V9nCbkH2GSJY5V/wVFuLDU
         NfoUw1EyeldIQPWq1FDRsvhBgUMAs8zaGHpHbNimdLNUVM8Dt+8Y1Lz6UN7ZQgToZw
         CEVEuvH+EsPsF4qmI8M8Zb3LyoDcFeyYf/Xk+WWgD1KR5jOGqoMcmq0auvfBeZQrka
         jxaK+JvOr5wxot37R5ER4ClVdZcoX5MJB0fuNgddNuGj8hc0bCYI6W0dq/G899ejcB
         SwJGJBM32phimhm5p3ABV0N56nn/nvrmz7U4L3+xGhc0JpFemTh6F4j1VPCxAUpPwG
         MTOYTKN4msMhA==
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
In-Reply-To: <20230511112532.16106-1-quic_visr@quicinc.com>
References: <20230511112532.16106-1-quic_visr@quicinc.com>
Subject: Re: [PATCH v2] ASoC:codecs: lpass: Fix for KASAN use_after_free
 out of bounds
Message-Id: <168443106443.480335.16812738995271810180.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 02:31:04 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 16:55:32 +0530, Ravulapati Vishnu Vardhan Rao wrote:
> When we run syzkaller we get below Out of Bounds error.
> 
> "KASAN: slab-out-of-bounds Read in regcache_flat_read"
> 
> Below is the backtrace of the issue:
> 
> BUG: KASAN: slab-out-of-bounds in regcache_flat_read+0x10c/0x110
> Read of size 4 at addr ffffff8088fbf714 by task syz-executor.4/14144
> CPU: 6 PID: 14144 Comm: syz-executor.4 Tainted: G        W
> Hardware name: Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+) (DT)
> Call trace:
> dump_backtrace+0x0/0x4ec
> show_stack+0x34/0x50
> dump_stack_lvl+0xdc/0x11c
> print_address_description+0x30/0x2d8
> kasan_report+0x178/0x1e4
> __asan_report_load4_noabort+0x44/0x50
> regcache_flat_read+0x10c/0x110
> regcache_read+0xf8/0x5a0
> _regmap_read+0x45c/0x86c
> _regmap_update_bits+0x128/0x290
> regmap_update_bits_base+0xc0/0x15c
> snd_soc_component_update_bits+0xa8/0x22c
> snd_soc_component_write_field+0x68/0xd4
> tx_macro_put_dec_enum+0x1d0/0x268
> snd_ctl_elem_write+0x288/0x474
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC:codecs: lpass: Fix for KASAN use_after_free out of bounds
      commit: 75e5fab7db0cecb6e16b22c34608f0b40a4c7cd1

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

