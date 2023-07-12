Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C375069A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjGLLrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjGLLre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE35211F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6A1617A5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14356C433C7;
        Wed, 12 Jul 2023 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162434;
        bh=f5mVoe34HV5wp/TbZuYdG3O0UtLsVgTcl18qYuE7l1w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AWhwbFMEKwO+U3c0UHb390l/zu3wCZVhLi5vhf4r7y87X0VeOnfj7pU64j5fIU5wZ
         aGowduAOLkfml16RD4ZE0whKuPGAIUDKdz7odwTAQLjHOxbntnh0EF6rpBMqJaliFn
         Booc2XnSGyRNa2bIjkfY7+SDac0nP2uOKpqG2yPvuapUcfTe/NbNl12+I18xdM5B70
         bXsZWHKQKb1hpguzd9XTZp940FhUdOIm5PgtK7HLQ1hQa+sM4dlt6SsfvQdRRDkIi7
         M+WFzLe4MGw392dC6RycG1aG+4Nfg/8o6Bza42bO5pbMJn4CNGIlKbSpag6vGauLi/
         jsKp9ELVW8X3g==
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
Message-Id: <168916242980.46574.9079979863277488670.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

[2/2] ASoC: SOF: amd: refactor PSP smn_read
      commit: 2b48d170fb9965dda9d41edcb0bbfc9ee4c6584f

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

