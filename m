Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1499C63ADEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiK1QjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiK1QjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:39:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D524F12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8220B80DE3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0200C433D7;
        Mon, 28 Nov 2022 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669653546;
        bh=IvUx3MjLUTJK+tueA8CSBKHbylvoSs0bmHFekQHcz2g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p0Fp2G2PiK83DL3iiUMU16TObTHnjPtg1FBNyNPVCfRTHYzjP0BVR0lNRfzHYBT9J
         G0zDLaTJJf/Wn7tmnuUg2YM9mn8dXYDFK6QmRpmG447XvIxFHYVvXVpE/csXLd/bdg
         WQ3hk3UJiOI13tpiuaYKnAFWQ4fhzd7AH7OHo9Beuntesqb6dv9OUmmK27zDRK0tOq
         EPOLWSkbCu/Jt+gIwIxoRu2+STffzfLBjrHilCH5+zDdr/lvcqb0G15kq5DrDHCb/m
         w7qIHP33bJJjjcU9ChB7WnfJl5bBpJVwSHOfxUlVBNvo6W9Vu05C4WaWz3LPDcWRPe
         24DH/S1PdRaRQ==
From:   Mark Brown <broonie@kernel.org>
To:     V sujith kumar Reddy 
        <vsujithkumar.reddy@amd.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        ssabakar@amd.com, Basavaraj.Hiregoudar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        venkataprasad.potturu@amd.com,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Takashi Iwai <tiwai@suse.com>, Vijendar.Mukunda@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Sunil-kumar.Dommati@amd.com,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221123121911.3446224-2-vsujithkumar.reddy@amd.corp-partner.google.com>
References: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
 <20221123121911.3446224-2-vsujithkumar.reddy@amd.corp-partner.google.com>
Subject: Re: [PATCH v1 1/4] ASoC: SOF: amd: Fix for reading position updates from stream box.
Message-Id: <166965354163.629583.9195064953643860302.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 16:39:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 17:49:08 +0530, V sujith kumar Reddy wrote:
> From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
> 
> By default the position updates are read from dsp box when streambox
> size is not defined.if the streambox size is defined to some value
> then position updates can be read from the streambox.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: amd: Fix for reading position updates from stream box.
      commit: aae7e412b0ec0378e392b18c50b612dae09cdb74
[2/4] ASoC: SOF: amd: Fix for selecting clock source as external clock.
      commit: f9ced7dbbb551885c63632f1594997bdaf2177ee
[3/4] ASoC: SOF: amd: ADD HS and SP virtual DAI.
      commit: 9fd3b5b11db2fbbf0438324696de8233c0a78dad
[4/4] ASoC: SOF: Add DAI configuration support for AMD platforms.
      (no commit info)

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
