Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A7163C2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbiK2Oms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiK2Omn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:42:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA36164E1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8965861729
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A62C433D6;
        Tue, 29 Nov 2022 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669732958;
        bh=C5ZoA8u7CjRfuYRa/p8LS+BgNNm4KfyQQxeH4LtrxiQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xf6SFudoEy7GIMULtvUWMiRkg5KY9wX+mngk6qerxcWP0globLzzXMje0gTEe0tGe
         C2s26B6VLRa2VUvzzeIZ6D5dk3zsVxBr3KmsrEkARFx0fHibTjWbtGsBJnY4OFDYCa
         61x3aNeTr6xkiR+N/01Z/U6yOdp4YJkdcS972Rn0jDqS3wigEGPiyDptnDJFXqQUCo
         lTcV9pRKjjgc3NmmmEOanZRc/RDCAiwU7HUeXrxiufLoU2Ihu0V9I4N/d25UTc/I1e
         k7aKv8P4h8CuQW/IiCvDtysCUenKjwqrnL0BO6ut8z26MseykaXXFJgkISlV0xrCfB
         iqr2TTRCWqb0A==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        V sujith kumar Reddy 
        <vsujithkumar.reddy@amd.corp-partner.google.com>
Cc:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Takashi Iwai <tiwai@suse.com>, ssabakar@amd.com,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        venkataprasad.potturu@amd.com,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>, Vijendar.Mukunda@amd.com,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>
In-Reply-To: <20221129100102.826781-1-vsujithkumar.reddy@amd.corp-partner.google.com>
References: <20221129100102.826781-1-vsujithkumar.reddy@amd.corp-partner.google.com>
Subject: Re: [PATCH v2 1/1] ASoC: SOF: Add DAI configuration support for AMD platforms.
Message-Id: <166973295442.182170.11091349433910086035.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 14:42:34 +0000
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

On Tue, 29 Nov 2022 15:30:59 +0530, V sujith kumar Reddy wrote:
> From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
> 
> Add support for configuring sp and hs DAI from topology.
> 
> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
> 
> Changes since v1
>     -- Apply on latest broonie-git for-next
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Add DAI configuration support for AMD platforms.
      commit: 75af41991955205fa0958feb587ce22b35aaa7b0

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
