Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61FF70E5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbjEWTu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbjEWTuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268E5192;
        Tue, 23 May 2023 12:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1BA963351;
        Tue, 23 May 2023 19:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6ACC433EF;
        Tue, 23 May 2023 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684871414;
        bh=/uQB4FK0lydPawdhLkoFI5hgLqs3cAp8GENHDctEgK8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jBPbahj1WF4/+OVVUdhRNPsYZB+L2kIRtGlet+6p/RbavHHd0rSbENerN3E5RX3qR
         jxKkGHSB1jzxuthBFFIHH5UG1JMu09PoVCHQ+O1IGhZbIF/tqxK8j3Sv/EQph3iz0Y
         ffrKxcceSnPfNQ59XQAQW1tzvu0uZNKxy4SZVZsbmTyNAvSDnDrEohZYDXeUJ0bVsb
         np2v9g2lZ09dzs+itlQFCXaQu1LX+kt8la2JS1HeApc/D6OAc/JoTedr6PFKMNCDX/
         U4NrFAwRZUcdx8JVp49OCytwcByYdVYoBVSEbh5gHXHBhqHkZUWA6hrQy4jOnfgL5a
         KDZnuGtbd5aHA==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        Jyri Sarha <jyri.sarha@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20230519064404.1659637-1-harshit.m.mogalapalli@oracle.com>
References: <20230519064404.1659637-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH next] ASoC: SOF: Intel: hda-dai: Fix locking in
 hda_ipc4_pre_trigger()
Message-Id: <168487140940.278276.10853655095714956345.b4-ty@kernel.org>
Date:   Tue, 23 May 2023 20:50:09 +0100
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

On Thu, 18 May 2023 23:44:01 -0700, Harshit Mogalapalli wrote:
> hda_ipc4_pre_trigger() has two issues:
>  1. In the default case, we are returning without unlocking the mutex.
>  2. In case SNDRV_PCM_TRIGGER_STOP: when ret is less than zero it goes
>     to out, unlocks but returns zero instead of a negative value.
> 
> Fix this by changing the final return value to 'ret' instead of zero,
> and initialize 'ret' to zero in the start of the function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda-dai: Fix locking in hda_ipc4_pre_trigger()
      commit: ed67a3404a8806a57c0015ce97bd3e6d61e7aa22

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

