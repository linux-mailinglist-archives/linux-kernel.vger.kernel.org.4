Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC67440D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjF3RHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjF3RHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB3B0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36178617AC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20506C433C8;
        Fri, 30 Jun 2023 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688144863;
        bh=U1TJ5FLNUaKTvdst4pVsT+ci60Uh+zUzDQUuUW43oHs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=de8bYXYiV5/q10RfBenKwLSVpc2wDUzUCQRKL5F0fh+iAZMdnRBCPOMvlpZ4t6nZw
         T3VOg5Owc1VSpYSW7fI/EIFCmUoJWGmKLybsgn4QxhLP9ORPHIAbXiuTKFEQA/h/O0
         mCNaYFPdI1vEzji1c634qyCtxckD/o9zIalBYfGeHO1wVLf3WQlVlaF1VKGdPLFyTn
         vhlJWDnTsDU++yzThy3B42JMKofvULXaH3mGJ0whwtazKZsyEHvErCiNxey8Gt+WQK
         JK19q0rafqYOdTBa939MgK9OZOS7Yt0nTpFCR4eTZH+wAue+t91xQycjb3G/5UQk/M
         saZ5kIbbeQ7Tg==
From:   Mark Brown <broonie@kernel.org>
To:     Mastan Katragadda <Mastan.Katragadda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, vijendar.mukunda@amd.com,
        Arungopal.kondaveeti@amd.com, vsujithkumar.reddy@amd.com,
        venkataprasad.potturu@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
References: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
Subject: Re: (subset) [PATCH 1/2] ASoC: SOF: amd: add revision check for
 sending sha dma completion command
Message-Id: <168814485881.50974.4096249135530047142.b4-ty@kernel.org>
Date:   Fri, 30 Jun 2023 18:07:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 12:35:42 +0530, Mastan Katragadda wrote:
> ACP driver should send SHA DMA completion command to PSP module for RN
> platform only.
> Add a revision check for RN platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: amd: add revision check for sending sha dma completion command
      commit: b1db244c716fe300e36428aeb0874913d2e0a91d

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

